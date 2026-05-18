-- Food consumption — server side
-- Registers every food/drink item via ESX.RegisterUsableItem.
-- Fires flake_cooking:consumeFood to the client with item effects.

local ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- ─────────────────────────────────────────────────────────────────────────────
-- Item data
-- Rules:
--   foodType 'food' | 'bowl'  → hunger ONLY  (thirst = 0)
--   foodType 'drink'          → thirst ONLY  (hunger = 0)
-- Values use esx_status units (0 – 1,000,000).
--   250,000 = 25 %  (heavy)
--   200,000 = 20 %  (medium)
--   150,000 = 15 %  (light)
-- ─────────────────────────────────────────────────────────────────────────────
local foodItems = {
    -- ── Drinks ───────────────────────────────────────────────
    flake_water             = { hunger = 0, thirst = 250000, foodType = 'drink' },
    flake_applejuice        = { hunger = 0, thirst = 200000, foodType = 'drink' },
    flake_apple_juice       = { hunger = 0, thirst = 200000, foodType = 'drink' },
    flake_orange_juice      = { hunger = 0, thirst = 200000, foodType = 'drink' },
    flake_grape_juice       = { hunger = 0, thirst = 200000, foodType = 'drink' },
    flake_carrot_juice      = { hunger = 0, thirst = 150000, foodType = 'drink' },
    flake_celery_juice      = { hunger = 0, thirst = 150000, foodType = 'drink' },
    flake_beet_juice        = { hunger = 0, thirst = 150000, foodType = 'drink' },
    flake_pineapple_juice   = { hunger = 0, thirst = 200000, foodType = 'drink' },
    flake_watermelon_juice  = { hunger = 0, thirst = 250000, foodType = 'drink' },
    flake_tomato_juice      = { hunger = 0, thirst = 150000, foodType = 'drink' },
    flake_smoothie          = { hunger = 0, thirst = 250000, foodType = 'drink' },
    flake_hot_chocolate     = { hunger = 0, thirst = 200000, foodType = 'drink' },
    flake_milk              = { hunger = 0, thirst = 200000, foodType = 'drink' },

    -- ── Heavy meals (25 %) ────────────────────────────────────
    flake_bbq_ribs              = { hunger = 250000, thirst = 0, foodType = 'food' },
    flake_pulled_pork           = { hunger = 250000, thirst = 0, foodType = 'food' },
    flake_fancy_steak           = { hunger = 250000, thirst = 0, foodType = 'food' },
    flake_cooked_steak          = { hunger = 250000, thirst = 0, foodType = 'food' },
    flake_pan_seared_steak      = { hunger = 250000, thirst = 0, foodType = 'food' },
    flake_meatlovers_pizza      = { hunger = 250000, thirst = 0, foodType = 'food' },
    flake_fish_and_chips        = { hunger = 250000, thirst = 0, foodType = 'food' },
    flake_ramen                 = { hunger = 250000, thirst = 0, foodType = 'bowl' },
    flake_curry                 = { hunger = 250000, thirst = 0, foodType = 'bowl' },
    flake_risotto               = { hunger = 250000, thirst = 0, foodType = 'bowl' },
    flake_pasta_dish            = { hunger = 250000, thirst = 0, foodType = 'bowl' },
    flake_bffriedrice           = { hunger = 250000, thirst = 0, foodType = 'bowl' },
    flake_ckfriedrice           = { hunger = 250000, thirst = 0, foodType = 'bowl' },

    -- ── Medium meals (20 %) ───────────────────────────────────
    flake_bbq_burger            = { hunger = 200000, thirst = 0, foodType = 'food' },
    flake_bbq_chicken           = { hunger = 200000, thirst = 0, foodType = 'food' },
    flake_fried_chicken_wings   = { hunger = 200000, thirst = 0, foodType = 'food' },
    flake_grilled_fish          = { hunger = 200000, thirst = 0, foodType = 'food' },
    flake_salmon                = { hunger = 200000, thirst = 0, foodType = 'food' },
    flake_omelette              = { hunger = 200000, thirst = 0, foodType = 'food' },
    flake_scrambled_eggs        = { hunger = 200000, thirst = 0, foodType = 'food' },
    flake_pancakes              = { hunger = 200000, thirst = 0, foodType = 'food' },
    flake_waffle                = { hunger = 200000, thirst = 0, foodType = 'food' },
    flake_quesadilla            = { hunger = 200000, thirst = 0, foodType = 'food' },
    flake_quiche                = { hunger = 200000, thirst = 0, foodType = 'food' },
    flake_spring_rolls          = { hunger = 200000, thirst = 0, foodType = 'food' },
    flake_stir_fry              = { hunger = 200000, thirst = 0, foodType = 'bowl' },
    flake_bstirfry              = { hunger = 200000, thirst = 0, foodType = 'bowl' },
    flake_fried_rice            = { hunger = 200000, thirst = 0, foodType = 'bowl' },
    flake_soup                  = { hunger = 200000, thirst = 0, foodType = 'bowl' },
    flake_homemade_soup         = { hunger = 200000, thirst = 0, foodType = 'bowl' },
    flake_pepperoni_pizza       = { hunger = 200000, thirst = 0, foodType = 'food' },
    flake_pineapple_pizza       = { hunger = 200000, thirst = 0, foodType = 'food' },
    flake_chicken_pesto_pizza   = { hunger = 200000, thirst = 0, foodType = 'food' },
    flake_chickensand           = { hunger = 200000, thirst = 0, foodType = 'food' },
    flake_hamtoastie            = { hunger = 200000, thirst = 0, foodType = 'food' },
    flake_grilled_shrimp        = { hunger = 200000, thirst = 0, foodType = 'food' },
    flake_fried_shrimp          = { hunger = 200000, thirst = 0, foodType = 'food' },
    flake_fried_calamari        = { hunger = 200000, thirst = 0, foodType = 'food' },
    flake_pepshrimp             = { hunger = 200000, thirst = 0, foodType = 'food' },
    flake_microwave_mac_cheese  = { hunger = 200000, thirst = 0, foodType = 'bowl' },
    flake_tv_dinner             = { hunger = 200000, thirst = 0, foodType = 'food' },
    flake_bbq_sausages          = { hunger = 200000, thirst = 0, foodType = 'food' },
    flake_cooked_oatmeal        = { hunger = 200000, thirst = 0, foodType = 'bowl' },

    -- ── Light snacks (15 %) ───────────────────────────────────
    flake_chicken_nuggets       = { hunger = 150000, thirst = 0, foodType = 'food' },
    flake_toast                 = { hunger = 150000, thirst = 0, foodType = 'food' },
    flake_baked_potato          = { hunger = 150000, thirst = 0, foodType = 'food' },
    flake_popcorn               = { hunger = 150000, thirst = 0, foodType = 'food' },
    flake_onion_rings           = { hunger = 150000, thirst = 0, foodType = 'food' },
    flake_mozzarella_sticks     = { hunger = 150000, thirst = 0, foodType = 'food' },
    flake_fried_okra            = { hunger = 150000, thirst = 0, foodType = 'food' },
    flake_fried_cheese_curds    = { hunger = 150000, thirst = 0, foodType = 'food' },
    flake_grilled_vegetables    = { hunger = 150000, thirst = 0, foodType = 'food' },
    flake_grilled_corn          = { hunger = 150000, thirst = 0, foodType = 'food' },
    flake_crepes                = { hunger = 150000, thirst = 0, foodType = 'food' },
    flake_microwave_chocolate_mug_cake = { hunger = 150000, thirst = 0, foodType = 'food' },
    flake_bpudding              = { hunger = 150000, thirst = 0, foodType = 'food' },
    flake_nanacream             = { hunger = 150000, thirst = 0, foodType = 'food' },
    flake_applesauce            = { hunger = 150000, thirst = 0, foodType = 'bowl' },
    flake_berrycream            = { hunger = 150000, thirst = 0, foodType = 'food' },
    flake_choccream             = { hunger = 150000, thirst = 0, foodType = 'food' },
    flake_vaniwafers            = { hunger = 150000, thirst = 0, foodType = 'food' },

    -- ── Raw fruits (light, 15 %) ──────────────────────────────
    flake_apple                 = { hunger = 150000, thirst = 0, foodType = 'food' },
    flake_banana                = { hunger = 150000, thirst = 0, foodType = 'food' },
    flake_grapes                = { hunger = 150000, thirst = 0, foodType = 'food' },
    flake_orange                = { hunger = 150000, thirst = 0, foodType = 'food' },
    flake_strawberry            = { hunger = 150000, thirst = 0, foodType = 'food' },

    -- ── Burnt food (barely helps) ─────────────────────────────
    flake_burnt_food            = { hunger = 50000,  thirst = 0, foodType = 'food' },
}

CreateThread(function()
    Wait(2000)

    if not ESX then
        print('^1[flake_cooking]^7: food.lua — ESX not found, food consumption disabled')
        return
    end

    local count = 0
    for itemName, data in pairs(foodItems) do
        local n = itemName
        local d = data
        ESX.RegisterUsableItem(n, function(source)
            TriggerClientEvent('flake_cooking:consumeFood', source, n, d)
        end)
        count = count + 1
    end

    print('^3[flake_cooking]^7: Registered ' .. count .. ' food/drink items')
end)
