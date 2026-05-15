-- Food consumption — server side
-- Registers every cooked/crafted item as a useable item via ESX.
-- When used: ox_inventory already removed the item; we just fire the
-- client-side event that plays the animation and applies esx_status.

local ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- ─────────────────────────────────────────────────────────────────────────────
-- Item data
-- hunger / thirst are in esx_status units (0 – 1,000,000)
-- foodType: 'food' | 'drink' | 'bowl'
-- ─────────────────────────────────────────────────────────────────────────────
local foodItems = {
    -- ── Store drinks ──────────────────────────────────────────
    fsg_water             = { hunger = 0,      thirst = 600000, foodType = 'drink' },
    fsg_applejuice        = { hunger = 30000,  thirst = 400000, foodType = 'drink' },

    -- ── Crafted drinks ────────────────────────────────────────
    fsg_apple_juice       = { hunger = 30000,  thirst = 450000, foodType = 'drink' },
    fsg_orange_juice      = { hunger = 30000,  thirst = 450000, foodType = 'drink' },
    fsg_grape_juice       = { hunger = 30000,  thirst = 400000, foodType = 'drink' },
    fsg_carrot_juice      = { hunger = 50000,  thirst = 350000, foodType = 'drink' },
    fsg_celery_juice      = { hunger = 50000,  thirst = 350000, foodType = 'drink' },
    fsg_beet_juice        = { hunger = 50000,  thirst = 350000, foodType = 'drink' },
    fsg_pineapple_juice   = { hunger = 30000,  thirst = 400000, foodType = 'drink' },
    fsg_watermelon_juice  = { hunger = 50000,  thirst = 500000, foodType = 'drink' },
    fsg_tomato_juice      = { hunger = 50000,  thirst = 350000, foodType = 'drink' },
    fsg_smoothie          = { hunger = 100000, thirst = 400000, foodType = 'drink' },
    fsg_hot_chocolate     = { hunger = 100000, thirst = 300000, foodType = 'drink' },

    -- ── Heavy meals ───────────────────────────────────────────
    fsg_bbq_ribs          = { hunger = 500000, thirst = 100000, foodType = 'food' },
    fsg_pulled_pork       = { hunger = 500000, thirst = 100000, foodType = 'food' },
    fsg_fancy_steak       = { hunger = 500000, thirst = 100000, foodType = 'food' },
    fsg_cooked_steak      = { hunger = 450000, thirst = 100000, foodType = 'food' },
    fsg_pan_seared_steak  = { hunger = 450000, thirst = 100000, foodType = 'food' },
    fsg_meatlovers_pizza  = { hunger = 500000, thirst = 100000, foodType = 'food' },
    fsg_curry             = { hunger = 450000, thirst = 100000, foodType = 'bowl' },
    fsg_risotto           = { hunger = 400000, thirst = 100000, foodType = 'bowl' },
    fsg_pasta_dish        = { hunger = 400000, thirst = 100000, foodType = 'bowl' },
    fsg_fish_and_chips    = { hunger = 400000, thirst = 100000, foodType = 'food' },

    -- ── Bowls / soups ─────────────────────────────────────────
    fsg_ramen             = { hunger = 400000, thirst = 200000, foodType = 'bowl' },
    fsg_soup              = { hunger = 250000, thirst = 150000, foodType = 'bowl' },
    fsg_homemade_soup     = { hunger = 300000, thirst = 200000, foodType = 'bowl' },
    fsg_bffriedrice       = { hunger = 350000, thirst = 80000,  foodType = 'bowl' },
    fsg_ckfriedrice       = { hunger = 350000, thirst = 80000,  foodType = 'bowl' },
    fsg_fried_rice        = { hunger = 300000, thirst = 80000,  foodType = 'bowl' },
    fsg_cooked_oatmeal    = { hunger = 250000, thirst = 50000,  foodType = 'bowl' },
    fsg_microwave_mac_cheese = { hunger = 300000, thirst = 80000, foodType = 'bowl' },

    -- ── Medium meals ──────────────────────────────────────────
    fsg_bbq_burger        = { hunger = 380000, thirst = 100000, foodType = 'food' },
    fsg_bbq_chicken       = { hunger = 350000, thirst = 80000,  foodType = 'food' },
    fsg_bbq_sausages      = { hunger = 250000, thirst = 50000,  foodType = 'food' },
    fsg_chicken_nuggets   = { hunger = 250000, thirst = 50000,  foodType = 'food' },
    fsg_fried_chicken_wings = { hunger = 300000, thirst = 80000, foodType = 'food' },
    fsg_grilled_fish      = { hunger = 300000, thirst = 80000,  foodType = 'food' },
    fsg_salmon            = { hunger = 350000, thirst = 80000,  foodType = 'food' },
    fsg_omelette          = { hunger = 250000, thirst = 50000,  foodType = 'food' },
    fsg_scrambled_eggs    = { hunger = 200000, thirst = 50000,  foodType = 'food' },
    fsg_pancakes          = { hunger = 250000, thirst = 80000,  foodType = 'food' },
    fsg_waffle            = { hunger = 200000, thirst = 50000,  foodType = 'food' },
    fsg_quesadilla        = { hunger = 300000, thirst = 50000,  foodType = 'food' },
    fsg_quiche            = { hunger = 300000, thirst = 80000,  foodType = 'food' },
    fsg_spring_rolls      = { hunger = 250000, thirst = 50000,  foodType = 'food' },
    fsg_stir_fry          = { hunger = 300000, thirst = 80000,  foodType = 'bowl' },
    fsg_bstirfry          = { hunger = 350000, thirst = 80000,  foodType = 'bowl' },
    fsg_pepperoni_pizza   = { hunger = 400000, thirst = 100000, foodType = 'food' },
    fsg_pineapple_pizza   = { hunger = 400000, thirst = 100000, foodType = 'food' },
    fsg_chicken_pesto_pizza = { hunger = 400000, thirst = 100000, foodType = 'food' },
    fsg_chickensand       = { hunger = 300000, thirst = 50000,  foodType = 'food' },
    fsg_hamtoastie        = { hunger = 250000, thirst = 50000,  foodType = 'food' },
    fsg_grilled_shrimp    = { hunger = 250000, thirst = 50000,  foodType = 'food' },
    fsg_fried_shrimp      = { hunger = 250000, thirst = 50000,  foodType = 'food' },
    fsg_fried_calamari    = { hunger = 250000, thirst = 50000,  foodType = 'food' },
    fsg_pepshrimp         = { hunger = 250000, thirst = 80000,  foodType = 'food' },
    fsg_tv_dinner         = { hunger = 250000, thirst = 80000,  foodType = 'food' },

    -- ── Light snacks ──────────────────────────────────────────
    fsg_toast             = { hunger = 150000, thirst = 20000,  foodType = 'food' },
    fsg_baked_potato      = { hunger = 200000, thirst = 50000,  foodType = 'food' },
    fsg_popcorn           = { hunger = 100000, thirst = 20000,  foodType = 'food' },
    fsg_onion_rings       = { hunger = 150000, thirst = 20000,  foodType = 'food' },
    fsg_mozzarella_sticks = { hunger = 200000, thirst = 20000,  foodType = 'food' },
    fsg_fried_okra        = { hunger = 150000, thirst = 20000,  foodType = 'food' },
    fsg_fried_cheese_curds = { hunger = 200000, thirst = 20000, foodType = 'food' },
    fsg_grilled_vegetables = { hunger = 150000, thirst = 50000, foodType = 'food' },
    fsg_grilled_corn      = { hunger = 200000, thirst = 50000,  foodType = 'food' },
    fsg_crepes            = { hunger = 200000, thirst = 50000,  foodType = 'food' },

    -- ── Desserts ──────────────────────────────────────────────
    fsg_microwave_chocolate_mug_cake = { hunger = 150000, thirst = 20000, foodType = 'food' },
    fsg_bpudding          = { hunger = 150000, thirst = 20000,  foodType = 'food' },
    fsg_nanacream         = { hunger = 150000, thirst = 50000,  foodType = 'food' },
    fsg_applesauce        = { hunger = 100000, thirst = 80000,  foodType = 'bowl' },

    -- ── Raw fruits (edible) ───────────────────────────────────
    fsg_apple             = { hunger = 100000, thirst = 80000,  foodType = 'food' },
    fsg_banana            = { hunger = 100000, thirst = 50000,  foodType = 'food' },
    fsg_grapes            = { hunger = 80000,  thirst = 100000, foodType = 'food' },
    fsg_orange            = { hunger = 80000,  thirst = 100000, foodType = 'food' },
    fsg_strawberry        = { hunger = 80000,  thirst = 80000,  foodType = 'food' },

    -- ── Misc store goods ──────────────────────────────────────
    fsg_berrycream        = { hunger = 100000, thirst = 80000,  foodType = 'food' },
    fsg_choccream         = { hunger = 100000, thirst = 50000,  foodType = 'food' },
    fsg_vaniwafers        = { hunger = 80000,  thirst = 20000,  foodType = 'food' },
    fsg_milk              = { hunger = 100000, thirst = 300000, foodType = 'drink' },

    -- ── Burnt food (barely helps) ─────────────────────────────
    fsg_burnt_food        = { hunger = 30000,  thirst = 0,      foodType = 'food' },
}

-- Register once ESX and ox_inventory are both ready
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
            TriggerClientEvent('fsg_cooking:consumeFood', source, d)
        end)
        count = count + 1
    end

    print('^3[fsg_cooking]^7: Registered ' .. count .. ' food/drink items')
end)
