-- Shop client-side logic
-- Spawns store NPCs, registers ox_target interactions, displays shop menus

local shopPeds = {}  -- [storeIndex] = pedEntity

-- ─────────────────────────────────────────────────────────────
-- Cleanup on resource stop
-- ─────────────────────────────────────────────────────────────

local function cleanupPeds()
    for _, ped in pairs(shopPeds) do
        if DoesEntityExist(ped) then
            DeleteEntity(ped)
        end
    end
    shopPeds = {}
end

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    cleanupPeds()
end)

-- ─────────────────────────────────────────────────────────────
-- Purchase dialog (ox_lib input, used by the OX-context shop)
-- ─────────────────────────────────────────────────────────────

local function showPurchaseDialog(itemName, itemLabel, price)
    local result = lib.inputDialog('Purchase ' .. itemLabel, {
        {
            type        = 'number',
            label       = 'Amount of Items',
            description = 'How many ' .. itemLabel .. ' would you like to get?',
            required    = true,
            min         = 1,
            max         = 100,
            icon        = 'fa-solid fa-box',
        },
        {
            type     = 'select',
            label    = 'Payment Method',
            options  = {
                { value = 'cash', label = 'Cash' },
                { value = 'card', label = 'Card' },
            },
            required = true,
            icon     = 'fa-solid fa-wallet',
        },
    })

    if not result then return end

    local count         = result[1]
    local paymentMethod = result[2]

    if paymentMethod == 'cash' then
        local total = price * count
        local hasFunds = lib.callback.await('flake_cooking:checkCashBalance', false, total)
        if not hasFunds then
            lib.notify({ title = 'Error', description = 'Insufficient funds', type = 'error' })
            return
        end
    end

    if paymentMethod == 'card' then
        local total = price * count
        local hasFunds = lib.callback.await('flake_cooking:checkBankBalance', false, total)
        if not hasFunds then
            lib.notify({ title = 'Error', description = 'Insufficient funds', type = 'error' })
            return
        end
    end

    if count and paymentMethod then
        lib.callback.await('flake_cooking:purchaseItem', false, itemName, count, price, paymentMethod)
    end
end

-- ─────────────────────────────────────────────────────────────
-- Display shop menu
-- ─────────────────────────────────────────────────────────────

function DisplayShopMenu(shopData)
    if Config.ShopMenu == 'ox' then
        -- ── OX Context Menu ─────────────────────────────────
        local oxItems     = exports.ox_inventory:Items()
        local mainOptions = {}

        for categoryName, categoryItems in pairs(shopData.categories) do
            local categoryOptions = {}

            for _, storeItem in ipairs(categoryItems) do
                local oxData = oxItems[storeItem.item] or {}
                local weightText = oxData.weight and ('Weight: ' .. oxData.weight .. ' | ') or ''
                local imageUrl   = oxData.image or ('https://cfx-nui-ox_inventory/web/images/' .. storeItem.item .. '.png')

                table.insert(categoryOptions, {
                    title       = storeItem.label,
                    description = weightText .. 'Price: $' .. storeItem.price,
                    image       = imageUrl,
                    icon        = imageUrl,
                    onSelect    = function()
                        showPurchaseDialog(storeItem.item, storeItem.label, storeItem.price)
                    end,
                })
            end

            lib.registerContext({
                id      = 'category_' .. categoryName,
                title   = categoryName,
                menu    = 'main_menu',
                options = categoryOptions,
            })

            table.insert(mainOptions, {
                title       = categoryName,
                description = 'Browse ' .. categoryName .. ' items',
                arrow       = true,
                onSelect    = function()
                    lib.showContext('category_' .. categoryName)
                end,
            })
        end

        lib.registerContext({
            id      = 'main_menu',
            title   = shopData.label or 'Shop',
            options = mainOptions,
        })
        lib.showContext('main_menu')

    elseif Config.ShopMenu == 'ui' then
        -- ── Custom NUI Shop ──────────────────────────────────
        local oxItems      = exports.ox_inventory:Items()
        local flatItems    = {}
        local categoryList = {}

        for categoryName, categoryItems in pairs(shopData.categories) do
            table.insert(categoryList, categoryName)

            for _, storeItem in ipairs(categoryItems) do
                local oxData = oxItems[storeItem.item] or {}
                table.insert(flatItems, {
                    item     = storeItem.item,
                    label    = storeItem.label,
                    price    = storeItem.price,
                    category = categoryName,
                    weight   = oxData.weight,
                })
            end
        end

        SetNuiFocus(true, true)
        Nui:msg('setShopData', {
            items      = flatItems,
            label      = shopData.label or 'Shop',
            categories = categoryList,
        })

    else
        print('[flake_cooking] Invalid shop menu type: ' .. tostring(Config.ShopMenu))
    end
end

-- Fetch shop data from server and display menu for a given store index
local function openShop(storeIndex)
    local shopData = lib.callback.await('flake_cooking:getShopData', false, storeIndex)
    if shopData then
        DisplayShopMenu(shopData)
    end
end

-- ─────────────────────────────────────────────────────────────
-- Spawn store NPCs and register ox_target interactions
-- ─────────────────────────────────────────────────────────────

local function setupStores()
    for i, store in ipairs(Config.Stores) do
        if not store.enabled then goto continue end

        -- Blip
        if store.blip and store.blip.enabled then
            local blip = AddBlipForCoord(vec3(store.ped.coords.x, store.ped.coords.y, store.ped.coords.z))
            SetBlipSprite(blip, store.blip.sprite)
            SetBlipAsShortRange(blip, true)
            SetBlipScale(blip, store.blip.scale)
            SetBlipColour(blip, store.blip.color)
            SetBlipDisplay(blip, store.blip.display)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString(store.label)
            EndTextCommandSetBlipName(blip)
        end

        -- NPC ped
        if not shopPeds[i] then
            lib.requestModel(store.ped.model)

            local ped = CreatePed(
                0,
                store.ped.model,
                store.ped.coords.x,
                store.ped.coords.y,
                store.ped.coords.z,
                store.ped.coords.w,
                false,
                true
            )

            if store.ped.scenario then
                TaskStartScenarioInPlace(ped, store.ped.scenario, 0, true)
            end

            FreezeEntityPosition(ped, true)
            SetEntityInvincible(ped, true)
            SetBlockingOfNonTemporaryEvents(ped, true)

            shopPeds[i] = ped

            -- ox_target interaction on ped
            local storeIndex = i
            exports.ox_target:addLocalEntity(ped, {
                {
                    label    = 'Open ' .. (store.label or 'Shop'),
                    icon     = 'fas fa-store',
                    distance = 2.0,
                    onSelect = function()
                        openShop(storeIndex)
                    end,
                },
            })
        end

        ::continue::
    end
end

CreateThread(setupStores)
