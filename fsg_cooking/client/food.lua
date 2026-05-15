-- Food consumption — client side
-- Progress circle + eating animation + hand prop + esx_status restore.

local isEating = false

-- ─────────────────────────────────────────────────────────────────────────────
-- GTA V prop models
-- ─────────────────────────────────────────────────────────────────────────────
local props = {
    food  = 'prop_cs_burger_01',
    drink = 'prop_amb_drink_can',
    bowl  = 'prop_food_bs_noodles',
}

-- ─────────────────────────────────────────────────────────────────────────────
-- Animation / bone config per food type
-- ─────────────────────────────────────────────────────────────────────────────
local eatConfig = {
    food = {
        dict     = 'mp_player_inteat@burger',
        clip     = 'mp_player_int_eat_burger',
        flag     = 51,
        duration = 6700,
        bone     = 57005,                      -- right hand
        pos      = vec3(0.12, 0.028, 0.001),
        rot      = vec3(10.0, 160.0, 170.0),
    },
    drink = {
        dict     = 'mp_player_intdrink',
        clip     = 'idle',
        flag     = 51,
        duration = 4000,
        bone     = 57005,
        pos      = vec3(0.0, 0.0, 0.003),
        rot      = vec3(0.0, 0.0, 0.0),
    },
    bowl = {
        dict     = 'mp_player_inteat@burger',
        clip     = 'mp_player_int_eat_burger',
        flag     = 51,
        duration = 6700,
        bone     = 18905,                      -- left hand
        pos      = vec3(0.1, 0.06, 0.02),
        rot      = vec3(70.0, 0.0, 0.0),
    },
}

-- ─────────────────────────────────────────────────────────────────────────────
-- Main handler
-- ─────────────────────────────────────────────────────────────────────────────

RegisterNetEvent('fsg_cooking:consumeFood')
AddEventHandler('fsg_cooking:consumeFood', function(itemName, data)
    if isEating then
        lib.notify({ title = 'Already Eating', description = "You're already eating something", type = 'error', duration = 2000 })
        return
    end
    isEating = true

    -- Get the item's display label from ox_inventory
    local oxItems  = exports.ox_inventory:Items()
    local label    = (oxItems[itemName] and oxItems[itemName].label) or itemName

    local foodType = data.foodType or 'food'
    local cfg      = eatConfig[foodType] or eatConfig.food
    local propName = props[foodType]     or props.food

    -- Progress circle (handles animation + prop internally via ox_lib)
    local action = foodType == 'drink' and 'Drinking' or 'Eating'

    local completed = lib.progressCircle({
        duration    = cfg.duration,
        label       = action .. ': ' .. label,
        position    = 'bottom',
        useWhileDead = false,
        canCancel   = false,
        disable     = { move = false, sprint = true, combat = true },
        anim        = { dict = cfg.dict, clip = cfg.clip, flag = cfg.flag },
        prop        = {
            model = propName,
            bone  = cfg.bone,
            pos   = cfg.pos,
            rot   = cfg.rot,
        },
    })

    if completed then
        -- Apply esx_status
        if data.hunger and data.hunger > 0 then
            TriggerEvent('esx_status:add', 'hunger', data.hunger)
        end
        if data.thirst and data.thirst > 0 then
            TriggerEvent('esx_status:add', 'thirst', data.thirst)
        end

        -- Result notification
        local statLine
        if foodType == 'drink' then
            statLine = '+ Thirst'
        else
            statLine = '+ Hunger'
        end

        lib.notify({
            title       = label,
            description = statLine,
            type        = 'success',
            duration    = 3000,
        })
    end

    isEating = false
end)
