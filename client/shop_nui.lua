-- Shop NUI handlers
-- Handles purchase flow from the custom shop UI (NUI-based shop)

-- Check balance helpers (client-side cash uses ox_inventory, bank goes via server)
local function canAfford(amount, method)
    if method == 'cash' then
        local count = exports.ox_inventory:Search('count', 'money')
        return count and count >= amount
    elseif method == 'bank' then
        return lib.callback.await('flake_cooking:checkBankBalance', false, amount)
    end
    return false
end

local function deductPayment(amount, method)
    if method == 'cash' then
        return exports.ox_inventory:RemoveItem('money', amount)
    elseif method == 'bank' then
        return lib.callback.await('flake_cooking:removeBankMoney', false, amount)
    end
    return false
end

-- NUI callback: player confirms purchase of multiple items
Nui:cb('purchaseItems', function(data, cb)
    local total         = data.total
    local items         = data.items
    local paymentMethod = data.paymentMethod

    -- Check balance on client side first for fast feedback
    if paymentMethod == 'cash' then
        local hasFunds = lib.callback.await('flake_cooking:checkCashBalance', false, total)
        if not hasFunds then
            cb({ success = false, message = 'Insufficient funds' })
            return
        end
    end

    if paymentMethod == 'bank' then
        local hasFunds = lib.callback.await('flake_cooking:checkBankBalance', false, total)
        if not hasFunds then
            cb({ success = false, message = 'Insufficient funds' })
            return
        end
    end

    -- Let server validate, deduct money, and give items
    local success, message = lib.callback.await('flake_cooking:purchaseItems', false, items, paymentMethod)
    cb({ success = success, message = message })
end)

-- NUI callback: player closes the shop
Nui:cb('closeShop', function(data, cb)
    SetNuiFocus(false, false)
    cb({})
end)

-- Debug command to open a test shop (only in debug mode)
RegisterCommand('testshop', function()
    local shopData = {
        label = 'Test Shop',
        categories = {
            Food = {
                { item = 'burger', label = 'Burger', price = 10 },
                { item = 'pizza',  label = 'Pizza',  price = 15 },
            },
            Drinks = {
                { item = 'water', label = 'Water', price = 5 },
                { item = 'cola',  label = 'Cola',  price = 8 },
            },
        },
    }
    DisplayShopMenu(shopData)
end, false)
