-- flake_cooking - Server Main
-- Handles: cooking callbacks, shop purchases, prop placement/pickup, DB persistence

local framework = nil
local ESX = nil
local QBCore = nil

-- In-memory prop tracking: [propId] = { model, coords, rotation, owner (serverId), identifier }
local placedProps = {}

-- ============================================================
-- Framework Initialization
-- ============================================================

CreateThread(function()
    if GetResourceState(Config.ResourceNames.ESX) == 'started' then
        framework = 'esx'
        ESX = exports[Config.ResourceNames.ESX]:getSharedObject()
    elseif GetResourceState(Config.ResourceNames.QBCore) == 'started' then
        framework = 'qb'
        QBCore = exports[Config.ResourceNames.QBCore]:GetCoreObject()
    end
end)

-- ============================================================
-- Framework Helpers
-- ============================================================

local function getPlayerIdentifier(source)
    if framework == 'esx' then
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer then return xPlayer.identifier end
    elseif framework == 'qb' then
        local Player = QBCore.Functions.GetPlayer(source)
        if Player then return Player.PlayerData.citizenid end
    end
    return tostring(source)
end

local function getBankBalance(source)
    if framework == 'esx' then
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer then
            local account = xPlayer.getAccount('bank')
            return account and account.money or 0
        end
    elseif framework == 'qb' then
        local Player = QBCore.Functions.GetPlayer(source)
        if Player then
            return Player.PlayerData.money['bank'] or 0
        end
    end
    return 0
end

local function removeBankMoney(source, amount)
    if framework == 'esx' then
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer then
            xPlayer.removeAccountMoney('bank', amount)
            return true
        end
    elseif framework == 'qb' then
        local Player = QBCore.Functions.GetPlayer(source)
        if Player then
            Player.Functions.RemoveMoney('bank', amount, 'flake_cooking_purchase')
            return true
        end
    end
    return false
end

-- ============================================================
-- Prop Helpers
-- ============================================================

local function getPropDataFromModel(model)
    for k, v in pairs(Config.CookingProps) do
        if v.model == model then
            return v.item, 'cooking'
        end
    end
    for k, v in pairs(Config.DecorationProps) do
        if v.model == model then
            return v.item, 'decoration'
        end
    end
    return nil, nil
end

local function generatePropId()
    return 'prop_' .. tostring(os.time()) .. '_' .. tostring(math.random(100000, 999999))
end

-- Look up item price from any store config
local function findItemPrice(itemName)
    for _, store in ipairs(Config.Stores) do
        if store.categories then
            for _, category in pairs(store.categories) do
                for _, item in ipairs(category) do
                    if item.item == itemName then
                        return item.price
                    end
                end
            end
        end
    end
    return nil
end

-- ============================================================
-- Database Setup & Prop Loading
-- ============================================================

local function setupDatabase()
    MySQL.Async.execute([[
        CREATE TABLE IF NOT EXISTS `flake_cooking_props` (
            `id` INT AUTO_INCREMENT PRIMARY KEY,
            `prop_id` VARCHAR(100) NOT NULL UNIQUE,
            `model` VARCHAR(100) NOT NULL,
            `x` FLOAT NOT NULL,
            `y` FLOAT NOT NULL,
            `z` FLOAT NOT NULL,
            `rot_x` FLOAT NOT NULL DEFAULT 0,
            `rot_y` FLOAT NOT NULL DEFAULT 0,
            `rot_z` FLOAT NOT NULL DEFAULT 0,
            `owner` VARCHAR(100),
            `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
    ]], {})
end

local function loadPropsFromDB(cb)
    MySQL.Async.fetchAll('SELECT * FROM flake_cooking_props', {}, function(results)
        if not results then
            if cb then cb() end
            return
        end
        for _, row in ipairs(results) do
            placedProps[row.prop_id] = {
                model    = row.model,
                coords   = { x = row.x, y = row.y, z = row.z },
                rotation = { x = row.rot_x, y = row.rot_y, z = row.rot_z },
                owner    = 0, -- server ID unknown after restart; use identifier for ownership
                identifier = row.owner,
            }
        end
        if Config.Debug then
            print('^3[flake_cooking]^7: Loaded ' .. #results .. ' persistent props from DB')
        end
        if cb then cb() end
    end)
end

-- Send all stored props to a specific player
local function syncPropsToPlayer(src)
    for propId, prop in pairs(placedProps) do
        TriggerClientEvent('flake_cooking:client:createViewOnlyProp', src,
            prop.model, prop.coords, prop.rotation, prop.owner or 0, propId)
    end
end

-- ============================================================
-- Resource Start
-- ============================================================

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
    if Config.Database.AutoExecuteSQL then
        setupDatabase()
    end
    -- Wait for MySQL to initialise then load props
    SetTimeout(3000, function()
        loadPropsFromDB()
    end)
end)

-- ============================================================
-- Player Join / Prop Sync
-- ============================================================

-- Client fires this after spawning so the server can send existing props
RegisterNetEvent('flake_cooking:server:requestProps', function()
    local src = source
    -- Small delay to ensure client is fully ready
    SetTimeout(1000, function()
        syncPropsToPlayer(src)
    end)
end)

-- Fallback: also sync via playerJoining with a longer delay
AddEventHandler('playerJoining', function()
    local src = source
    SetTimeout(15000, function()
        if GetPlayerName(src) then
            syncPropsToPlayer(src)
        end
    end)
end)

-- ============================================================
-- Helper: safely add an item via ox_inventory
-- ============================================================

local function safeAddItem(source, itemName, qty)
    if not itemName then
        print('^1[flake_cooking]^7: safeAddItem called with nil item name -- check recipe/shop config')
        return false
    end
    local oxItems = exports.ox_inventory:Items()
    if not oxItems or not oxItems[itemName] then
        print('^1[flake_cooking]^7: Item "' .. itemName .. '" is not registered in ox_inventory -- add it to ox_inventory/data/items.lua')
        return false
    end
    local ok, err = pcall(function()
        exports.ox_inventory:AddItem(source, itemName, qty)
    end)
    if not ok then
        print('^1[flake_cooking]^7: AddItem error for "' .. itemName .. '": ' .. tostring(err))
        return false
    end
    return true
end

-- ============================================================
-- Cooking Callbacks
-- ============================================================

-- Check if player has all required items (server-side validation)
lib.callback.register('flake_cooking:server:checkRequiredItems', function(source, data)
    if not data or not data.recipe then return false end
    local recipe = Config.Recipes[data.recipe]
    if not recipe or not recipe.requiredItems then return false end

    for _, required in ipairs(recipe.requiredItems) do
        local count = exports.ox_inventory:Search(source, 'count', required.item)
        if not count or count < required.count then
            return false
        end
    end
    return true
end)

-- Complete cooking: remove ingredients, give results
lib.callback.register('flake_cooking:server:completeCooking', function(source, data)
    if not data or not data.recipe then return false end
    local recipe = Config.Recipes[data.recipe]
    if not recipe or not recipe.requiredItems then return false end

    -- Double-check inventory server-side
    for _, required in ipairs(recipe.requiredItems) do
        local count = exports.ox_inventory:Search(source, 'count', required.item)
        if not count or count < required.count then
            lib.notify(source, {
                title = 'Missing Ingredients',
                description = 'You no longer have all required ingredients',
                type = 'error'
            })
            return false
        end
    end

    -- Remove ingredients
    for _, required in ipairs(recipe.requiredItems) do
        exports.ox_inventory:RemoveItem(source, required.item, required.count)
    end

    -- Give results based on success
    if data.success then
        for _, result in ipairs(recipe.resultItems) do
            safeAddItem(source, result.item, result.count)
        end
        lib.notify(source, {
            title = 'Cooking Complete',
            description = 'You cooked ' .. recipe.label .. '!',
            type = 'success'
        })
    elseif recipe.failedResultItems and #recipe.failedResultItems > 0 then
        for _, result in ipairs(recipe.failedResultItems) do
            safeAddItem(source, result.item, result.count)
        end
        lib.notify(source, {
            title = 'Cooking Failed',
            description = 'You burned the food!',
            type = 'error'
        })
    end

    return true
end)

-- ============================================================
-- Shop Callbacks
-- ============================================================

-- Return shop configuration for a given store index
lib.callback.register('flake_cooking:getShopData', function(source, storeIndex)
    local store = Config.Stores[storeIndex]
    if not store or not store.enabled then return nil end
    return store
end)

-- Check if player has enough cash (money item in ox_inventory)
lib.callback.register('flake_cooking:checkCashBalance', function(source, amount)
    if not amount or amount <= 0 then return true end
    local count = exports.ox_inventory:Search(source, 'count', 'money')
    return count ~= nil and count >= amount
end)

-- Check if player has enough bank balance via framework
lib.callback.register('flake_cooking:checkBankBalance', function(source, amount)
    if not amount or amount <= 0 then return true end
    return getBankBalance(source) >= amount
end)

-- Remove money from player bank
lib.callback.register('flake_cooking:removeBankMoney', function(source, amount)
    if not amount or amount <= 0 then return false end
    return removeBankMoney(source, amount)
end)

-- Purchase a single item (ox-context shop)
lib.callback.register('flake_cooking:purchaseItem', function(source, itemName, count, pricePerItem, paymentMethod)
    if not itemName or not count or count < 1 then return false, 'Invalid request' end

    -- Validate item exists in ox_inventory before charging the player
    local oxItems = exports.ox_inventory:Items()
    if not oxItems or not oxItems[itemName] then
        lib.notify(source, { title = 'Purchase Failed', description = 'Item not available', type = 'error' })
        print('^1[flake_cooking]^7: Purchase blocked -- "' .. tostring(itemName) .. '" not registered in ox_inventory')
        return false, 'Item not registered'
    end

    -- Server-side price lookup to prevent tampering
    local serverPrice = findItemPrice(itemName)
    local unitPrice = serverPrice or (pricePerItem or 0)
    local total = unitPrice * count

    if total > 0 then
        if paymentMethod == 'cash' then
            local cashCount = exports.ox_inventory:Search(source, 'count', 'money')
            if not cashCount or cashCount < total then
                lib.notify(source, { title = 'Purchase Failed', description = 'Insufficient cash', type = 'error' })
                return false, 'Insufficient cash'
            end
            exports.ox_inventory:RemoveItem(source, 'money', total)
        elseif paymentMethod == 'card' then
            if getBankBalance(source) < total then
                lib.notify(source, { title = 'Purchase Failed', description = 'Insufficient bank funds', type = 'error' })
                return false, 'Insufficient bank funds'
            end
            removeBankMoney(source, total)
        else
            return false, 'Invalid payment method'
        end
    end

    local added = safeAddItem(source, itemName, count)
    if not added then
        -- Refund the payment since we couldn't give the item
        if total > 0 then
            if paymentMethod == 'cash' then
                exports.ox_inventory:AddItem(source, 'money', total)
            elseif paymentMethod == 'card' then
                if framework == 'esx' then
                    local xPlayer = ESX.GetPlayerFromId(source)
                    if xPlayer then xPlayer.addAccountMoney('bank', total) end
                elseif framework == 'qb' then
                    local Player = QBCore.Functions.GetPlayer(source)
                    if Player then Player.Functions.AddMoney('bank', total, 'flake_cooking_refund') end
                end
            end
        end
        lib.notify(source, { title = 'Purchase Failed', description = 'Item unavailable -- payment refunded', type = 'error' })
        return false, 'Item unavailable'
    end

    lib.notify(source, {
        title = 'Purchase Complete',
        description = 'You purchased ' .. count .. 'x ' .. itemName,
        type = 'success'
    })
    return true, 'Success'
end)

-- Purchase multiple items (NUI shop)
lib.callback.register('flake_cooking:purchaseItems', function(source, items, paymentMethod)
    if not items or #items == 0 then return false, 'No items to purchase' end

    -- Calculate total using server-side prices
    -- NUI may send item name as 'item', 'name', 'id', or 'itemName' -- accept all variants
    local total = 0
    for _, item in ipairs(items) do
        local iName = item.item or item.name or item.id or item.itemName
        local serverPrice = findItemPrice(iName)
        local unitPrice = serverPrice or (item.price or 0)
        local qty = item.count or item.quantity or item.amount or 1
        total = total + (unitPrice * qty)
    end

    -- Process payment
    if total > 0 then
        if paymentMethod == 'cash' then
            local cashCount = exports.ox_inventory:Search(source, 'count', 'money')
            if not cashCount or cashCount < total then
                lib.notify(source, { title = 'Purchase Failed', description = 'Insufficient cash', type = 'error' })
                return false, 'Insufficient cash'
            end
            exports.ox_inventory:RemoveItem(source, 'money', total)
        elseif paymentMethod == 'bank' then
            if getBankBalance(source) < total then
                lib.notify(source, { title = 'Purchase Failed', description = 'Insufficient bank funds', type = 'error' })
                return false, 'Insufficient bank funds'
            end
            removeBankMoney(source, total)
        else
            return false, 'Invalid payment method'
        end
    end

    -- Give all items; skip any not registered in ox_inventory
    local failedItems = {}
    for _, item in ipairs(items) do
        local iName = item.item or item.name or item.id or item.itemName
        local qty   = item.count or item.quantity or item.amount or 1
        if not iName then
            print('^1[flake_cooking]^7: purchaseItems -- cart entry has no item name field, skipping')
        elseif not safeAddItem(source, iName, qty) then
            table.insert(failedItems, iName)
        end
    end

    if #failedItems == #items then
        -- Every item failed -- refund the whole payment
        if total > 0 then
            if paymentMethod == 'cash' then
                exports.ox_inventory:AddItem(source, 'money', total)
            elseif paymentMethod == 'bank' then
                if framework == 'esx' then
                    local xPlayer = ESX.GetPlayerFromId(source)
                    if xPlayer then xPlayer.addAccountMoney('bank', total) end
                elseif framework == 'qb' then
                    local Player = QBCore.Functions.GetPlayer(source)
                    if Player then Player.Functions.AddMoney('bank', total, 'flake_cooking_refund') end
                end
            end
        end
        lib.notify(source, { title = 'Purchase Failed', description = 'Items unavailable -- payment refunded', type = 'error' })
        return false, 'Items not registered in ox_inventory'
    end

    if #failedItems > 0 then
        lib.notify(source, {
            title = 'Partial Purchase',
            description = #failedItems .. ' item(s) were unavailable and have been skipped',
            type = 'warning'
        })
    else
        lib.notify(source, {
            title = 'Purchase Complete',
            description = 'Your order has been placed!',
            type = 'success'
        })
    end
    return true, 'Success'
end)

-- ============================================================
-- Prop Placement & Pickup Callbacks
-- ============================================================

-- Active placement locks per player (prevents spam)
local activePlacements = {}

-- Place a prop in the world
lib.callback.register('flake_cooking:server:placeProp', function(source, model, coords, rotation)
    if not model or not coords or not rotation then return false end

    -- Find the inventory item for this prop model
    local propItem, _ = getPropDataFromModel(model)
    if not propItem then
        lib.notify(source, { title = 'Error', description = 'Unknown prop type', type = 'error' })
        return false
    end

    -- Verify player has the item
    local count = exports.ox_inventory:Search(source, 'count', propItem)
    if not count or count < 1 then
        lib.notify(source, { title = 'Error', description = 'You do not have the required item', type = 'error' })
        return false
    end

    -- Remove item from inventory
    local removed = exports.ox_inventory:RemoveItem(source, propItem, 1)
    if not removed then
        lib.notify(source, { title = 'Error', description = 'Failed to remove item from inventory', type = 'error' })
        return false
    end

    -- Generate unique ID and get identifier
    local propId = generatePropId()
    local identifier = getPlayerIdentifier(source)

    -- Normalise coords/rotation tables
    local c = { x = coords.x or 0.0, y = coords.y or 0.0, z = coords.z or 0.0 }
    local r = { x = rotation.x or 0.0, y = rotation.y or 0.0, z = rotation.z or 0.0 }

    -- Track in memory
    placedProps[propId] = {
        model      = model,
        coords     = c,
        rotation   = r,
        owner      = source,
        identifier = identifier,
    }

    -- Persist to database
    if Config.PersistentProps.Enabled then
        MySQL.Async.execute(
            'INSERT INTO flake_cooking_props (prop_id, model, x, y, z, rot_x, rot_y, rot_z, owner) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)',
            { propId, model, c.x, c.y, c.z, r.x, r.y, r.z, identifier }
        )
    end

    -- Tell the placing player to create their ownable local copy
    TriggerClientEvent('flake_cooking:client:createPropLocally', source,
        model, c, r, source, propId)

    -- Tell all other players to create a view-only copy
    for _, pid in ipairs(GetPlayers()) do
        local playerId = tonumber(pid)
        if playerId ~= source then
            TriggerClientEvent('flake_cooking:client:createViewOnlyProp', playerId,
                model, c, r, source, propId)
        end
    end

    if Config.Debug then
        print('^3[flake_cooking]^7: Prop ' .. propId .. ' placed by ' .. identifier)
    end

    return true
end)

-- Pick up / remove a prop from the world
lib.callback.register('flake_cooking:server:pickupProp', function(source, netId, propId)
    if not propId then return false end

    local prop = placedProps[propId]

    -- Fall back to DB if not in memory (e.g. after server restart)
    if not prop and Config.PersistentProps.Enabled then
        local results = MySQL.Sync.fetchAll('SELECT * FROM flake_cooking_props WHERE prop_id = ?', { propId })
        if results and results[1] then
            local row = results[1]
            prop = {
                model      = row.model,
                coords     = { x = row.x, y = row.y, z = row.z },
                rotation   = { x = row.rot_x, y = row.rot_y, z = row.rot_z },
                owner      = 0,
                identifier = row.owner,
            }
        end
    end

    if not prop then
        lib.notify(source, { title = 'Error', description = 'Prop not found', type = 'error' })
        return false
    end

    -- Ownership check
    local identifier = getPlayerIdentifier(source)
    local isOwner = (prop.owner == source) or (prop.identifier == identifier)

    if not isOwner then
        lib.notify(source, { title = 'Error', description = 'You do not own this prop', type = 'error' })
        return false
    end

    -- Give item back
    local propItem, _ = getPropDataFromModel(prop.model)
    if not propItem then return false end

    safeAddItem(source, propItem, 1)

    -- Remove from memory
    placedProps[propId] = nil

    -- Remove from database
    if Config.PersistentProps.Enabled then
        MySQL.Async.execute('DELETE FROM flake_cooking_props WHERE prop_id = ?', { propId })
    end

    -- Tell ALL clients to delete their local copy of this prop
    TriggerClientEvent('flake_cooking:client:deletePropById', -1, propId)

    if Config.Debug then
        print('^3[flake_cooking]^7: Prop ' .. propId .. ' picked up by ' .. identifier)
    end

    return true
end)

-- Clear server-side placement lock for a player
lib.callback.register('flake_cooking:server:clearActivePlacement', function(source)
    activePlacements[source] = nil
    return true
end)

-- ============================================================
-- Useable Items Registration
-- ============================================================

-- Wraps the different useable-item registration APIs so we work with
-- ox_inventory (any version), ESX legacy, and QBCore.
local function registerUseableItem(itemName, cb)
    -- Try ox_inventory first
    local ok = pcall(function()
        exports.ox_inventory:RegisterUsableItem(itemName, cb)
    end)
    if ok then return end

    -- Fall back to framework-level registration
    if framework == 'esx' and ESX then
        ESX.RegisterUsableItem(itemName, function(source)
            cb(source)
        end)
    elseif framework == 'qb' and QBCore then
        QBCore.Functions.CreateUseableItem(itemName, function(source)
            cb(source)
        end)
    else
        print('^1[flake_cooking]^7: Failed to register useable item "' .. itemName ..
              '" -- ox_inventory:RegisterUsableItem not found and no framework fallback available')
    end
end

CreateThread(function()
    Wait(5000) -- Give ox_inventory time to fully start

    local registered = 0

    for _, v in pairs(Config.CookingProps) do
        if v.item then
            local itemName = v.item
            registerUseableItem(itemName, function(source)
                TriggerClientEvent('flake_cooking:startPropPlacement', source, itemName)
            end)
            registered = registered + 1
        end
    end

    for _, v in pairs(Config.DecorationProps) do
        if v.item then
            local itemName = v.item
            registerUseableItem(itemName, function(source)
                TriggerClientEvent('flake_cooking:startPropPlacement', source, itemName)
            end)
            registered = registered + 1
        end
    end

    print('^3[flake_cooking]^7: Registered ' .. registered .. ' useable items')
end)

-- ============================================================
-- Periodic Prop Save (optional safety net)
-- ============================================================

if Config.PersistentProps.Enabled then
    CreateThread(function()
        while true do
            Wait(Config.PersistentProps.SaveInterval * 1000)
            -- Props are saved/deleted on placement/pickup; this is a no-op safety tick
            if Config.Debug then
                local count = 0
                for _ in pairs(placedProps) do count = count + 1 end
                print('^3[flake_cooking]^7: ' .. count .. ' props currently tracked in memory')
            end
        end
    end)
end
