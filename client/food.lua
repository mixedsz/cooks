-- Food consumption — client side
-- Progress circle + eating animation + hand prop + esx_status restore.

local isEating = false

-- ─────────────────────────────────────────────────────────────────────────────
-- Props — all confirmed present in the base Steam GTA V install.
-- Right hand (bone 57005) is used for every type so the prop follows
-- whichever animation is playing.
-- ─────────────────────────────────────────────────────────────────────────────
local eatConfig = {
    food = {
        prop     = 'prop_cs_burger_01',
        dict     = 'mp_player_inteat@burger',
        clip     = 'mp_player_int_eat_burger',
        flag     = 51,
        duration = 6700,
        bone     = 57005,           -- SKEL_R_Hand
        pos      = vec3(0.13,  0.028, 0.001),
        rot      = vec3(10.0, 160.0, 170.0),
    },
    drink = {
        prop     = 'prop_amb_drink_can',
        dict     = 'mp_player_intdrink',
        clip     = 'idle',
        flag     = 51,
        duration = 4000,
        bone     = 57005,
        pos      = vec3(0.0,  0.01,  0.05),
        rot      = vec3(-100.0, 0.0,  0.0),
    },
    bowl = {
        -- Bowl food uses the same burger prop/animation but held in right hand
        -- so the animation is consistent and the prop follows the hand.
        prop     = 'prop_cs_burger_01',
        dict     = 'mp_player_inteat@burger',
        clip     = 'mp_player_int_eat_burger',
        flag     = 51,
        duration = 6700,
        bone     = 57005,
        pos      = vec3(0.13,  0.028, 0.001),
        rot      = vec3(10.0, 160.0, 170.0),
    },
}

-- ─────────────────────────────────────────────────────────────────────────────
-- Handler
-- ─────────────────────────────────────────────────────────────────────────────

RegisterNetEvent('flake_cooking:consumeFood')
AddEventHandler('flake_cooking:consumeFood', function(itemName, data)
    if isEating then
        lib.notify({ title = 'Already Eating', description = "You're already eating something.", type = 'error', duration = 2000 })
        return
    end
    isEating = true

    -- Resolve display label from ox_inventory (shows "BBQ Ribs" not "flake_bbq_ribs")
    local oxItems = exports.ox_inventory:Items()
    local label   = (oxItems[itemName] and oxItems[itemName].label) or itemName

    local foodType = data.foodType or 'food'
    local cfg      = eatConfig[foodType] or eatConfig.food
    local action   = foodType == 'drink' and 'Drinking' or 'Eating'

    local completed = lib.progressCircle({
        duration     = cfg.duration,
        label        = action .. ': ' .. label,
        position     = 'bottom',
        useWhileDead = false,
        canCancel    = false,
        disable      = { move = false, sprint = true, combat = true },
        anim         = { dict = cfg.dict, clip = cfg.clip, flag = cfg.flag },
        prop         = {
            model = cfg.prop,
            bone  = cfg.bone,
            pos   = cfg.pos,
            rot   = cfg.rot,
        },
    })

    if completed then
        if data.hunger and data.hunger > 0 then
            TriggerEvent('esx_status:add', 'hunger', data.hunger)
        end
        if data.thirst and data.thirst > 0 then
            TriggerEvent('esx_status:add', 'thirst', data.thirst)
        end

        lib.notify({
            title       = 'Eats',
            description = 'You ate 1 ' .. label,
            type        = 'success',
            duration    = 3000,
        })
    end

    isEating = false
end)
