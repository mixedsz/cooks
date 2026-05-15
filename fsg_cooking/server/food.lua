-- Food consumption — server side
-- Registers every food/drink item via ESX.RegisterUsableItem.
-- Fires fsg_cooking:consumeFood to the client with item effects.

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
    fsg_water             = { hunger = 0, thirst = 250000, foodType = 'drink' },
    fsg_applejuice        = { hunger = 0, thirst = 200000, foodType = 'drink' },
    fsg_apple_juice       = { hunger = 0, thirst = 200000, foodType = 'drink' },
    fsg_orange_juice      = { hunger = 0, thirst = 200000, foodType = 'drink' },
    fsg_grape_juice       = { hunger = 0, thirst = 200000, foodType = 'drink' },
    fsg_carrot_juice      = { hunger = 0, thirst = 150000, foodType = 'drink' },
    fsg_celery_juice      = { hunger = 0, thirst = 150000, foodType = 'drink' },
    fsg_beet_juice        = { hunger = 0, thirst = 150000, foodType = 'drink' },
    fsg_pineapple_juice   = { hunger = 0, thirst = 200000, foodType = 'drink' },
    fsg_watermelon_juice  = { hunger = 0, thirst = 250000, foodType = 'drink' },
    fsg_tomato_juice      = { hunger = 0, thirst = 150000, foodType = 'drink' },
    fsg_smoothie          = { hunger = 0, thirst = 250000, foodType = 'drink' },
    fsg_hot_chocolate     = { hunger = 0, thirst = 200000, foodType = 'drink' },
    fsg_milk              = { hunger = 0, thirst = 200000, foodType = 'drink' },

    -- ── Heavy meals (25 %) ────────────────────────────────────
    fsg_bbq_ribs              = { hunger = 250000, thirst = 0, foodType = 'food' },
    fsg_pulled_pork           = { hunger = 250000, thirst = 0, foodType = 'food' },
    fsg_fancy_steak           = { hunger = 250000, thirst = 0, foodType = 'food' },
    fsg_cooked_steak          = { hunger = 250000, thirst = 0, foodType = 'food' },
    fsg_pan_seared_steak      = { hunger = 250000, thirst = 0, foodType = 'food' },
    fsg_meatlovers_pizza      = { hunger = 250000, thirst = 0, foodType = 'food' },
    fsg_fish_and_chips        = { hunger = 250000, thirst = 0, foodType = 'food' },
    fsg_ramen                 = { hunger = 250000, thirst = 0, foodType = 'bowl' },
    fsg_curry                 = { hunger = 250000, thirst = 0, foodType = 'bowl' },
    fsg_risotto               = { hunger = 250000, thirst = 0, foodType = 'bowl' },
    fsg_pasta_dish            = { hunger = 250000, thirst = 0, foodType = 'bowl' },
    fsg_bffriedrice           = { hunger = 250000, thirst = 0, foodType = 'bowl' },
    fsg_ckfriedrice           = { hunger = 250000, thirst = 0, foodType = 'bowl' },

    -- ── Medium meals (20 %) ───────────────────────────────────
    fsg_bbq_burger            = { hunger = 200000, thirst = 0, foodType = 'food' },
    fsg_bbq_chicken           = { hunger = 200000, thirst = 0, foodType = 'food' },
    fsg_fried_chicken_wings   = { hunger = 200000, thirst = 0, foodType = 'food' },
    fsg_grilled_fish          = { hunger = 200000, thirst = 0, foodType = 'food' },
    fsg_salmon                = { hunger = 200000, thirst = 0, foodType = 'food' },
    fsg_omelette              = { hunger = 200000, thirst = 0, foodType = 'food' },
    fsg_scrambled_eggs        = { hunger = 200000, thirst = 0, foodType = 'food' },
    fsg_pancakes              = { hunger = 200000, thirst = 0, foodType = 'food' },
    fsg_waffle                = { hunger = 200000, thirst = 0, foodType = 'food' },
    fsg_quesadilla            = { hunger = 200000, thirst = 0, foodType = 'food' },
    fsg_quiche                = { hunger = 200000, thirst = 0, foodType = 'food' },
    fsg_spring_rolls          = { hunger = 200000, thirst = 0, foodType = 'food' },
    fsg_stir_fry              = { hunger = 200000, thirst = 0, foodType = 'bowl' },
    fsg_bstirfry              = { hunger = 200000, thirst = 0, foodType = 'bowl' },
    fsg_fried_rice            = { hunger = 200000, thirst = 0, foodType = 'bowl' },
    fsg_soup                  = { hunger = 200000, thirst = 0, foodType = 'bowl' },
    fsg_homemade_soup         = { hunger = 200000, thirst = 0, foodType = 'bowl' },
    fsg_pepperoni_pizza       = { hunger = 200000, thirst = 0, foodType = 'food' },
    fsg_pineapple_pizza       = { hunger = 200000, thirst = 0, foodType = 'food' },
    fsg_chicken_pesto_pizza   = { hunger = 200000, thirst = 0, foodType = 'food' },
    fsg_chickensand           = { hunger = 200000, thirst = 0, foodType = 'food' },
    fsg_hamtoastie            = { hunger = 200000, thirst = 0, foodType = 'food' },
    fsg_grilled_shrimp        = { hunger = 200000, thirst = 0, foodType = 'food' },
    fsg_fried_shrimp          = { hunger = 200000, thirst = 0, foodType = 'food' },
    fsg_fried_calamari        = { hunger = 200000, thirst = 0, foodType = 'food' },
    fsg_pepshrimp             = { hunger = 200000, thirst = 0, foodType = 'food' },
    fsg_microwave_mac_cheese  = { hunger = 200000, thirst = 0, foodType = 'bowl' },
    fsg_tv_dinner             = { hunger = 200000, thirst = 0, foodType = 'food' },
    fsg_bbq_sausages          = { hunger = 200000, thirst = 0, foodType = 'food' },
    fsg_cooked_oatmeal        = { hunger = 200000, thirst = 0, foodType = 'bowl' },

    -- ── Light snacks (15 %) ───────────────────────────────────
    fsg_chicken_nuggets       = { hunger = 150000, thirst = 0, foodType = 'food' },
    fsg_toast                 = { hunger = 150000, thirst = 0, foodType = 'food' },
    fsg_baked_potato          = { hunger = 150000, thirst = 0, foodType = 'food' },
    fsg_popcorn               = { hunger = 150000, thirst = 0, foodType = 'food' },
    fsg_onion_rings           = { hunger = 150000, thirst = 0, foodType = 'food' },
    fsg_mozzarella_sticks     = { hunger = 150000, thirst = 0, foodType = 'food' },
    fsg_fried_okra            = { hunger = 150000, thirst = 0, foodType = 'food' },
    fsg_fried_cheese_curds    = { hunger = 150000, thirst = 0, foodType = 'food' },
    fsg_grilled_vegetables    = { hunger = 150000, thirst = 0, foodType = 'food' },
    fsg_grilled_corn          = { hunger = 150000, thirst = 0, foodType = 'food' },
    fsg_crepes                = { hunger = 150000, thirst = 0, foodType = 'food' },
    fsg_microwave_chocolate_mug_cake = { hunger = 150000, thirst = 0, foodType = 'food' },
    fsg_bpudding              = { hunger = 150000, thirst = 0, foodType = 'food' },
    fsg_nanacream             = { hunger = 150000, thirst = 0, foodType = 'food' },
    fsg_applesauce            = { hunger = 150000, thirst = 0, foodType = 'bowl' },
    fsg_berrycream            = { hunger = 150000, thirst = 0, foodType = 'food' },
    fsg_choccream             = { hunger = 150000, thirst = 0, foodType = 'food' },
    fsg_vaniwafers            = { hunger = 150000, thirst = 0, foodType = 'food' },

    -- ── Raw fruits (light, 15 %) ──────────────────────────────
    fsg_apple                 = { hunger = 150000, thirst = 0, foodType = 'food' },
    fsg_banana                = { hunger = 150000, thirst = 0, foodType = 'food' },
    fsg_grapes                = { hunger = 150000, thirst = 0, foodType = 'food' },
    fsg_orange                = { hunger = 150000, thirst = 0, foodType = 'food' },
    fsg_strawberry            = { hunger = 150000, thirst = 0, foodType = 'food' },

    -- ── Burnt food (barely helps) ─────────────────────────────
    fsg_burnt_food            = { hunger = 50000,  thirst = 0, foodType = 'food' },
}

CreateThread(function()
    Wait(2000)

    if not ESX then
        print('^1[fsg_cooking]^7: food.lua — ESX not found, food consumption disabled')
        return
    end

    local count = 0
    for itemName, data in pairs(foodItems) do
        local n = itemName
        local d = data
        ESX.RegisterUsableItem(n, function(source)
            TriggerClientEvent('fsg_cooking:consumeFood', source, n, d)
        end)
        count = count + 1
    end

    print('^3[fsg_cooking]^7: Registered ' .. count .. ' food/drink items')
end)
