-- Food consumption — client side
-- Handles eating animation, hand prop, and esx_status restoration.

local isEating = false

-- ─────────────────────────────────────────────────────────────────────────────
-- GTA V prop models used when eating/drinking
-- ─────────────────────────────────────────────────────────────────────────────
local props = {
    food  = 'prop_cs_burger_01',     -- held in right hand, solid food
    drink = 'prop_amb_drink_can',    -- held in right hand, cans / bottles
    bowl  = 'prop_food_bs_noodles',  -- bowl held in left hand, soups / ramen
}

-- ─────────────────────────────────────────────────────────────────────────────
-- Animations
-- ─────────────────────────────────────────────────────────────────────────────
local anims = {
    food = {
        dict     = 'mp_player_inteat@burger',
        clip     = 'mp_player_int_eat_burger',
        duration = 6700,
        flag     = 51,
        -- right hand bone, matches burger animation nicely
        bone     = 57005,
        offset   = vector3(0.12,  0.028, 0.001),
        rotation = vector3(10.0, 160.0, 170.0),
    },
    drink = {
        dict     = 'mp_player_intdrink',
        clip     = 'idle',
        duration = 4000,
        flag     = 51,
        bone     = 57005,
        offset   = vector3(0.0,   0.0,   0.003),
        rotation = vector3(0.0,   0.0,   0.0),
    },
    bowl = {
        dict     = 'mp_player_inteat@burger',
        clip     = 'mp_player_int_eat_burger',
        duration = 6700,
        flag     = 51,
        -- left hand for bowls
        bone     = 18905,
        offset   = vector3(0.1,   0.06,  0.02),
        rotation = vector3(70.0,  0.0,   0.0),
    },
}

-- ─────────────────────────────────────────────────────────────────────────────
-- Helpers
-- ─────────────────────────────────────────────────────────────────────────────

local function loadAnimDict(dict)
    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)
        local timeout = 0
        while not HasAnimDictLoaded(dict) and timeout < 100 do
            Wait(50)
            timeout = timeout + 1
        end
    end
    return HasAnimDictLoaded(dict)
end

local function loadModel(hash)
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        local timeout = 0
        while not HasModelLoaded(hash) and timeout < 100 do
            Wait(50)
            timeout = timeout + 1
        end
    end
    return HasModelLoaded(hash)
end

-- ─────────────────────────────────────────────────────────────────────────────
-- Main consumption handler
-- ─────────────────────────────────────────────────────────────────────────────

RegisterNetEvent('fsg_cooking:consumeFood')
AddEventHandler('fsg_cooking:consumeFood', function(data)
    if isEating then return end
    isEating = true

    local ped      = PlayerPedId()
    local foodType = data.foodType or 'food'
    local anim     = anims[foodType] or anims.food
    local propName = props[foodType] or props.food
    local propHash = GetHashKey(propName)

    -- Load anim dict
    if not loadAnimDict(anim.dict) then
        isEating = false
        return
    end

    -- Load prop model
    local hasProp = loadModel(propHash)
    local prop    = nil

    -- Create and attach prop
    if hasProp then
        prop = CreateObject(propHash, 0.0, 0.0, 0.0, true, true, false)
        AttachEntityToEntity(
            prop, ped,
            GetPedBoneIndex(ped, anim.bone),
            anim.offset.x, anim.offset.y, anim.offset.z,
            anim.rotation.x, anim.rotation.y, anim.rotation.z,
            true, true, false, true, 1, true
        )
    end

    -- Play animation
    TaskPlayAnim(ped, anim.dict, anim.clip, 8.0, -8.0, anim.duration, anim.flag, 0, false, false, false)

    -- Wait for eat/drink animation to play out
    Wait(anim.duration)

    -- Apply esx_status effects
    if data.hunger and data.hunger > 0 then
        TriggerEvent('esx_status:add', 'hunger', data.hunger)
    end
    if data.thirst and data.thirst > 0 then
        TriggerEvent('esx_status:add', 'thirst', data.thirst)
    end

    -- Cleanup
    if prop and DoesEntityExist(prop) then
        DeleteObject(prop)
    end
    ClearPedTasks(ped)
    RemoveAnimDict(anim.dict)
    SetModelAsNoLongerNeeded(propHash)

    isEating = false
end)
