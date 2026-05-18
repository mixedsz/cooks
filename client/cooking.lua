-- ============================================================
-- flake_cooking – client/cooking.lua
-- ============================================================

-- Module-level state
local setupEntities    = {}   -- entity => true  (ox_target already added)
local currentAppliance = nil  -- entity handle of the appliance currently in use
local isCooking        = false
local activeEffects    = {}   -- entity => { effectType => ptfxId }
local handPropEntity   = nil  -- currently attached hand-prop object
local lastRefreshTime  = 0
local refreshInterval  = 5000
local pendingEntities  = {}   -- entity => true  (interaction setup pending / in progress)

-- ============================================================
-- Framework detection
-- ============================================================

framework = nil
ESX       = nil
QBCore    = nil

if GetResourceState(Config.ResourceNames.ESX) == "started" then
    framework = "esx"
    ESX = exports[Config.ResourceNames.ESX]:getSharedObject()
elseif GetResourceState(Config.ResourceNames.QBCore) == "started" then
    framework = "qb"
    QBCore = exports[Config.ResourceNames.QBCore]:GetCoreObject()
end

-- ============================================================
-- Helper: isEntityNearby(entity, radius)
-- Returns true when the local player is within `radius` units
-- of `entity` (default 5.0).
-- ============================================================

local function isEntityNearby(entity, radius)
    if not radius then radius = 5.0 end
    if not entity then return false end
    if not DoesEntityExist(entity) then return false end

    local playerPos = GetEntityCoords(PlayerPedId())
    local entityPos = GetEntityCoords(entity)
    return radius >= #(playerPos - entityPos)
end

-- ============================================================
-- Helper: getPlayerCharId(playerId)
-- Returns the framework character identifier for a player.
-- Falls back to returning `playerId` unchanged when no
-- framework data is available.
-- ============================================================

local function getPlayerCharId(playerId)
    if framework == "esx" then
        if ESX then
            local playerData = ESX.GetPlayerData()
            if playerData and playerData.identifier then
                return playerData.identifier
            end
        end
    elseif framework == "qb" then
        if QBCore then
            local playerData = QBCore.Functions.GetPlayerData()
            if playerData and playerData.PlayerData and playerData.PlayerData.citizenid then
                return playerData.PlayerData.citizenid
            end
        end
    end
    return playerId
end

-- ============================================================
-- GetPropOwner(entity)
-- Reads the owner state-bag from `entity`.  When the stored
-- value looks like a legacy "charN" identifier it upgrades it
-- to the current framework identifier on the fly.
-- ============================================================

function GetPropOwner(entity)
    if not entity or not DoesEntityExist(entity) then
        return 0
    end

    local owner = Entity(entity).state.owner
    if not owner then owner = 0 end

    -- Legacy "charN" identifier – re-stamp with current player id
    if type(owner) == "string" and owner:match("^char%d+$") then
        local currentId
        if framework == "esx" and ESX then
            local pd = ESX.GetPlayerData()
            if pd and pd.identifier then
                currentId = pd.identifier
                Entity(entity).state.owner = currentId
            end
        elseif framework == "qb" and QBCore then
            local pd = QBCore.Functions.GetPlayerData()
            if pd and pd.PlayerData and pd.PlayerData.citizenid then
                currentId = pd.PlayerData.citizenid
                Entity(entity).state.owner = currentId
            end
        end
        if currentId then owner = currentId end
    end

    return owner
end

-- ============================================================
-- SetPropOwner(entity, ownerIdentifier)
-- Writes an owner value into the entity state-bag.  Accepts
-- a server-id number (converted via getPlayerCharId), a string
-- charN identifier (validated against the current player), or
-- any plain string.
-- ============================================================

function SetPropOwner(entity, ownerIdentifier)
    if not entity or not DoesEntityExist(entity) then return end

    local value = ownerIdentifier

    if type(ownerIdentifier) == "number" and ownerIdentifier > 0 then
        -- Convert numeric server-id to character id
        value = getPlayerCharId(ownerIdentifier)
    elseif type(ownerIdentifier) == "string" then
        if ownerIdentifier:match("^char%d+$") then
            -- Legacy charN format – replace with current player's id
            if framework == "esx" and ESX then
                local pd = ESX.GetPlayerData()
                if pd and pd.identifier then
                    value = pd.identifier
                end
            elseif framework == "qb" and QBCore then
                -- Note: original code referenced `xPlayer` here (likely a bug),
                -- so we mirror the behaviour faithfully.
                if xPlayer and xPlayer.identifier then
                    value = xPlayer.identifier
                end
            end
        end
        -- plain string: use as-is
    end

    Entity(entity).state.owner = value
end

-- ============================================================
-- RefreshCookingProps()
-- Scans the CObject pool for props whose model matches any
-- entry in Config.CookingProps that are within 15 m of the
-- player.  Newly discovered props get ox_target interactions
-- set up; props that drift beyond 15 m have their interactions
-- removed.
-- Throttled by `refreshInterval` ms.
-- ============================================================

function RefreshCookingProps()
    local now = GetGameTimer()
    if (now - lastRefreshTime) < refreshInterval then return end
    lastRefreshTime = now

    local playerPos  = GetEntityCoords(PlayerPedId())
    local allObjects = GetGamePool("CObject")

    -- Prune stale entries from pendingEntities
    for entity in pairs(pendingEntities) do
        if not DoesEntityExist(entity) then
            pendingEntities[entity] = nil
        end
    end

    for propType, propData in pairs(Config.CookingProps) do
        local modelHash = joaat(propData.model)

        for _, entity in ipairs(allObjects) do
            if DoesEntityExist(entity) and GetEntityModel(entity) == modelHash then
                local dist = #(playerPos - GetEntityCoords(entity))

                if dist < 15.0 then
                    if not setupEntities[entity] and not pendingEntities[entity] then
                        SetupCookingPropInteraction(entity, propType, propData)
                        pendingEntities[entity] = true
                    end
                else
                    if pendingEntities[entity] then
                        exports.ox_target:removeLocalEntity(entity)
                        pendingEntities[entity] = nil
                        setupEntities[entity]   = nil
                    end
                end
            end
        end
    end
end

-- ============================================================
-- RefreshDecorationProps()
-- Same logic as RefreshCookingProps but for Config.DecorationProps.
-- Also updates `lastRefreshTime`.
-- ============================================================

function RefreshDecorationProps()
    local now = GetGameTimer()
    if (now - lastRefreshTime) < refreshInterval then return end

    local playerPos  = GetEntityCoords(PlayerPedId())
    local allObjects = GetGamePool("CObject")

    if Config.Debug then
        print("DEBUG - RefreshDecorationProps: Found " .. #allObjects .. " objects in game pool")
    end

    for propType, propData in pairs(Config.DecorationProps) do
        local modelHash = joaat(propData.model)

        if Config.Debug then
            print("DEBUG - Checking for decoration prop type: " .. propType ..
                  " with model hash: " .. tostring(modelHash))
        end

        if modelHash == 0 then
            print("WARNING: Invalid model name for decoration prop: " .. propType)
        else
            for _, entity in ipairs(allObjects) do
                if DoesEntityExist(entity) and GetEntityModel(entity) == modelHash then
                    local dist = #(playerPos - GetEntityCoords(entity))

                    if Config.Debug then
                        print("DEBUG - Found decoration prop " .. propType .. " at distance " .. dist)
                    end

                    if dist < 15.0 then
                        if not setupEntities[entity] and not pendingEntities[entity] then
                            if Config.Debug then
                                print("DEBUG - Setting up interaction for decoration prop: " .. propType)
                            end
                            SetupDecorationPropInteraction(entity, propType, propData)
                            pendingEntities[entity] = true
                        end
                    else
                        if pendingEntities[entity] then
                            exports.ox_target:removeLocalEntity(entity)
                            pendingEntities[entity] = nil
                            setupEntities[entity]   = nil
                        end
                    end
                end
            end
        end
    end

    lastRefreshTime = GetGameTimer()
end

-- ============================================================
-- SetupCookingPropInteraction(entity, propType, propData)
-- Adds two ox_target options to a cooking-appliance entity:
--   • "Use <label>"    – only the owner may interact (distance < 2 m)
--   • "Pick Up <label>" – only the owner may interact (distance < 2 m)
-- ============================================================

function SetupCookingPropInteraction(entity, propType, propData)
    if not DoesEntityExist(entity) then return end

    setupEntities[entity] = true
    getPlayerCharId(PlayerId())  -- ensure framework id is cached

    exports.ox_target:addLocalEntity(entity, {
        {
            name    = "cooking_" .. propType,
            icon    = "fas fa-utensils",
            label   = "Use " .. propData.label,
            canInteract = function(ent, distance, _coords)
                local owner    = GetPropOwner(entity)
                local playerId = getPlayerCharId(PlayerId())
                return owner == playerId and distance < 2.0
            end,
            onSelect = function()
                OpenCookingMenu(entity, propType, propData)
            end,
        },
        {
            name    = "pickup_" .. propType,
            icon    = "fas fa-hand-holding",
            label   = "Pick Up " .. propData.label,
            canInteract = function(ent, distance, _coords)
                local owner    = GetPropOwner(entity)
                local playerId = getPlayerCharId(PlayerId())
                return owner == playerId and distance < 2.0
            end,
            onSelect = function()
                PickUpProp(entity, propType, propData)
            end,
        },
    })
end

-- ============================================================
-- SetupDecorationPropInteraction(entity, propType, propData)
-- Adds a single ox_target option to a decoration prop:
--   • "Pick Up <label>" – only the owner may interact (distance < 2 m)
-- ============================================================

function SetupDecorationPropInteraction(entity, propType, propData)
    if not DoesEntityExist(entity) then return end

    setupEntities[entity] = true
    getPlayerCharId(PlayerId())  -- ensure framework id is cached

    exports.ox_target:addLocalEntity(entity, {
        {
            name    = "pickup_" .. propType,
            icon    = "fas fa-hand-holding",
            label   = "Pick Up " .. propData.label,
            canInteract = function(ent, distance, _coords)
                local owner    = GetPropOwner(entity)
                local playerId = getPlayerCharId(PlayerId())
                return owner == playerId and distance < 2.0
            end,
            onSelect = function()
                PickUpProp(entity, propType, propData)
            end,
        },
    })
end

-- ============================================================
-- OpenCookingMenu(entity, applianceKey, applianceData)
-- Validates proximity and ownership, then builds and shows an
-- ox_lib context menu listing every recipe for this appliance.
-- ============================================================

function OpenCookingMenu(entity, applianceKey, applianceData)
    RefreshCookingProps()

    if not isEntityNearby(entity, 2.0) then
        lib.notify({ title = "Error", description = "You are too far away from the cooking appliance", type = "error" })
        return
    end

    local owner    = GetPropOwner(entity)
    local playerId = getPlayerCharId(PlayerId())

    if owner ~= playerId then
        lib.notify({ title = "Error", description = "You cannot use this cooking appliance", type = "error" })
        return
    end

    currentAppliance = entity

    -- Collect recipes that belong to this appliance
    local applianceRecipes = {}
    for recipeName, recipe in pairs(Config.Recipes) do
        if recipe.appliance == applianceKey then
            applianceRecipes[recipeName] = recipe
        end
    end

    -- Build menu options
    local options = {}
    for recipeName, recipe in pairs(applianceRecipes) do
        local locked      = false   -- reserved for future skill/level gating
        local description = GetRecipeDescription(recipe)
        local firstItem   = recipe.resultItems[1].item

        local icon
        if locked then
            icon = "lock"
        else
            icon = "https://cfx-nui-ox_inventory/web/images/" .. firstItem .. ".png"
        end

        table.insert(options, {
            title       = recipe.label,
            description = description,
            icon        = icon,
            disabled    = locked,
            onSelect    = function()
                if not locked then
                    StartCooking(entity, recipeName, recipe)
                else
                    lib.notify({
                        title       = "Recipe Locked",
                        description = "You need more cooking experience to make this recipe",
                        type        = "error",
                    })
                end
            end,
        })
    end

    table.insert(options, {
        title    = "Close Menu",
        icon     = "xmark",
        onSelect = function() end,
    })

    lib.registerContext({
        id      = "cooking_menu",
        title   = "Cooking Menu - " .. applianceData.label,
        options = options,
    })
    lib.showContext("cooking_menu")
end

-- ============================================================
-- GetRecipeDescription(recipe)
-- Returns a multi-line string summarising ingredients,
-- cooking time, and (when present) the number of flow steps.
-- ============================================================

function GetRecipeDescription(recipe)
    if not recipe or not recipe.requiredItems then
        return "Invalid recipe"
    end

    -- Ingredients list
    local desc = "Ingredients: "
    for i, item in ipairs(recipe.requiredItems) do
        desc = desc .. item.count .. "x " .. item.item
        if i < #recipe.requiredItems then
            desc = desc .. ", "
        end
    end

    -- Cooking time / steps
    if recipe.cookingFlow then
        local totalTime = 0
        for _, step in ipairs(recipe.cookingFlow) do
            totalTime = totalTime + (step.time or 0)
        end
        desc = desc .. "\n\nCooking Time: " .. totalTime .. " seconds"
        desc = desc .. "\n\nSteps: " .. #recipe.cookingFlow
    else
        desc = desc .. "\n\nCooking Time: " .. (recipe.time or 0) .. " seconds"
    end

    return desc
end

-- ============================================================
-- StartApplianceEffects(entity, applianceKey)
-- Starts looped particle effects (smoke / steam / fire / bbq)
-- defined in Config.CookingProps[applianceKey].effects on the
-- given entity.  Stores the ptfx handle per effect type in
-- activeEffects[entity].
--
-- When Config.DebugEffects is true the function tries a list of
-- known fallback effect names before accepting a result.
-- ============================================================

function StartApplianceEffects(entity, applianceKey)
    if not entity or not DoesEntityExist(entity) then return end

    local propCfg = Config.CookingProps[applianceKey]
    if not propCfg or not propCfg.effects then return end

    if Config.DebugEffects then
        print("-------------------")
        print("DEBUG EFFECTS: Starting effects for " .. applianceKey)
        print("Entity ID: " .. entity)
        print("Available effects: " .. json.encode(propCfg.effects))
        print("-------------------")
    end

    for effectType, effectData in pairs(propCfg.effects) do
        -- Ensure the activeEffects sub-table exists for this entity
        if not activeEffects[entity] then
            activeEffects[entity] = {}
        end

        -- All cooking effects use the "core" ptfx asset
        local assetDict = "core"

        if Config.DebugEffects then
            print("Starting " .. effectType .. " effect using dictionary: " .. assetDict)
            print("Effect name: " .. effectData.name)
            print("Offset: " .. json.encode(effectData.offset))
            print("Scale: " .. tostring(effectData.scale))
        end

        -- Load the ptfx asset (2-second timeout)
        RequestNamedPtfxAsset(assetDict)
        local loadStart = GetGameTimer()
        while not HasNamedPtfxAssetLoaded(assetDict) do
            Wait(10)
            if GetGameTimer() - loadStart > 2000 then
                if Config.DebugEffects then
                    print("WARNING: Timed out waiting for ptfx asset to load")
                end
                break
            end
        end

        if Config.DebugEffects then
            print("Ptfx asset loaded: " .. tostring(HasNamedPtfxAssetLoaded(assetDict)))
        end

        local offset = effectData.offset or vec3(0.0, 0.0, 0.0)
        local scale  = effectData.scale  or 1.0

        -- -------------------------------------------------------
        -- Debug mode: try fallback effect name lists for smoke/fire
        -- -------------------------------------------------------
        if Config.DebugEffects and effectType == "smoke" then
            local smokeCandidates = {
                effectData.name,
                "ent_amb_smoke_factory_white",
                "ent_amb_smoke_gaswork",
                "exp_grd_bzgas_smoke",
                "ent_amb_smoke_scrap",
                "ent_amb_smoke_foundry",
            }
            for idx, candidateName in ipairs(smokeCandidates) do
                UseParticleFxAssetNextCall(assetDict)
                local fxId = StartParticleFxLoopedOnEntity(
                    candidateName, entity,
                    offset.x, offset.y, offset.z,
                    0.0, 0.0, 0.0,
                    scale, false, false, false
                )
                if fxId and fxId ~= -1 then
                    if Config.DebugEffects then
                        print("SUCCESS: Effect " .. candidateName .. " created with ID " .. fxId)
                    end
                    if idx == 1 then
                        -- First candidate succeeded immediately
                        activeEffects[entity][effectType] = fxId
                        break
                    else
                        -- A fallback succeeded; stop the test run and use it properly
                        StopParticleFxLooped(fxId, false)
                        UseParticleFxAssetNextCall(assetDict)
                        local fxId2 = StartParticleFxLoopedOnEntity(
                            candidateName, entity,
                            offset.x, offset.y, offset.z,
                            0.0, 0.0, 0.0,
                            scale, false, false, false
                        )
                        activeEffects[entity][effectType] = fxId2
                        if Config.DebugEffects then
                            print("Using " .. candidateName .. " instead of " .. effectData.name)
                        end
                        propCfg.effects[effectType].name = candidateName
                        break
                    end
                else
                    print("FAILED: Effect " .. candidateName .. " did not create")
                    if idx > 1 then
                        StopParticleFxLooped(fxId, false)
                    end
                    Wait(100)
                end
            end

        elseif Config.DebugEffects and effectType == "fire" then
            local fireCandidates = {
                effectData.name,
                "ent_amb_BBQ_fire",
                "ent_amb_fire_ring",
                "ent_amb_torch_fire",
                "fire_wrecked_plane_cockpit",
                "ent_ray_heli_aprtmnt_l_fire",
            }
            for idx, candidateName in ipairs(fireCandidates) do
                UseParticleFxAssetNextCall(assetDict)
                local fxId = StartParticleFxLoopedOnEntity(
                    candidateName, entity,
                    offset.x, offset.y, offset.z,
                    0.0, 0.0, 0.0,
                    scale, false, false, false
                )
                if fxId and fxId ~= -1 then
                    if Config.DebugEffects then
                        print("SUCCESS: Effect " .. candidateName .. " created with ID " .. fxId)
                    end
                    if idx == 1 then
                        activeEffects[entity][effectType] = fxId
                        break
                    else
                        StopParticleFxLooped(fxId, false)
                        UseParticleFxAssetNextCall(assetDict)
                        local fxId2 = StartParticleFxLoopedOnEntity(
                            candidateName, entity,
                            offset.x, offset.y, offset.z,
                            0.0, 0.0, 0.0,
                            scale, false, false, false
                        )
                        activeEffects[entity][effectType] = fxId2
                        if Config.DebugEffects then
                            print("Using " .. candidateName .. " instead of " .. effectData.name)
                        end
                        propCfg.effects[effectType].name = candidateName
                        break
                    end
                else
                    print("FAILED: Effect " .. candidateName .. " did not create")
                    if idx > 1 then
                        StopParticleFxLooped(fxId, false)
                    end
                    Wait(100)
                end
            end

        else
            -- -------------------------------------------------------
            -- Normal (non-debug) path: start the named effect directly
            -- with a simple fallback for smoke / fire failures.
            -- -------------------------------------------------------
            local fxId = nil

            if effectType == "smoke" or effectType == "steam" or effectType == "fire" then
                UseParticleFxAssetNextCall(assetDict)
                fxId = StartParticleFxLoopedOnEntity(
                    effectData.name, entity,
                    offset.x, offset.y, offset.z,
                    0.0, 0.0, 0.0,
                    scale, false, false, false
                )
            end

            if fxId and fxId ~= -1 then
                activeEffects[entity][effectType] = fxId
                if Config.DebugEffects then
                    print("DEBUG - Started " .. effectType .. " effect on " .. applianceKey ..
                          ", effectId: " .. tostring(fxId))
                end
            else
                if Config.DebugEffects then
                    print("WARNING - Failed to start " .. effectType .. " effect on " .. applianceKey)
                end

                -- Fallback effect names
                local fallbackName
                if effectType == "smoke" then
                    fallbackName = "ent_amb_smoke_factory_white"
                elseif effectType == "fire" then
                    fallbackName = "ent_amb_torch_fire"
                end

                if fallbackName then
                    UseParticleFxAssetNextCall(assetDict)
                    fxId = StartParticleFxLoopedOnEntity(
                        fallbackName, entity,
                        offset.x, offset.y, offset.z,
                        0.0, 0.0, 0.0,
                        scale, false, false, false
                    )
                    if fxId and fxId ~= -1 then
                        activeEffects[entity][effectType] = fxId
                        if Config.DebugEffects then
                            print("DEBUG - Started alternative " .. effectType ..
                                  " effect on " .. applianceKey ..
                                  ", effectId: " .. tostring(fxId))
                        end
                    end
                end
            end
        end
    end
end

-- ============================================================
-- StopApplianceEffects(entity)
-- Stops all looped particle effects that were started for
-- `entity` and removes its entry from activeEffects.
-- ============================================================

function StopApplianceEffects(entity)
    if not entity or not activeEffects[entity] then return end

    for effectType, fxId in pairs(activeEffects[entity]) do
        if fxId then
            StopParticleFxLooped(fxId, false)
            if Config.Debug then
                print("DEBUG - Stopped " .. effectType .. " effect")
            end
        end
    end

    activeEffects[entity] = nil
end

-- ============================================================
-- AttachCookingHandProp(applianceKey)
-- Creates and attaches the hand prop defined in
-- Config.CookingProps[applianceKey].handProp to the player's
-- right hand (bone 57005 by default).
-- Stores the object handle in `handPropEntity`.
-- ============================================================

function AttachCookingHandProp(applianceKey)
    RemoveCookingHandProp()

    local propCfg = Config.CookingProps[applianceKey]
    if not propCfg or not propCfg.handProp then return end

    local handPropCfg = propCfg.handProp
    if not handPropCfg or not handPropCfg.model then return end

    local modelHash = joaat(handPropCfg.model)
    RequestModel(modelHash)

    local loadStart = GetGameTimer()
    while not HasModelLoaded(modelHash) do
        Wait(0)
        if GetGameTimer() - loadStart > 5000 then return end
    end

    local ped = PlayerPedId()
    local obj = CreateObject(modelHash, 0.0, 0.0, 0.0, true, true, true)

    if not obj or obj == 0 then
        SetModelAsNoLongerNeeded(modelHash)
        return
    end

    local boneId = GetPedBoneIndex(ped, handPropCfg.bone or 57005)

    local offX = (handPropCfg.offset and handPropCfg.offset.x) or 0.12
    local offY = (handPropCfg.offset and handPropCfg.offset.y) or 0.0
    local offZ = (handPropCfg.offset and handPropCfg.offset.z) or 0.0

    local rotX = (handPropCfg.rotation and handPropCfg.rotation.x) or 0.0
    local rotY = (handPropCfg.rotation and handPropCfg.rotation.y) or -60.0
    local rotZ = (handPropCfg.rotation and handPropCfg.rotation.z) or 0.0

    AttachEntityToEntity(obj, ped, boneId,
        offX, offY, offZ,
        rotX, rotY, rotZ,
        false, false, false, false, 2, true)

    handPropEntity = obj
    SetModelAsNoLongerNeeded(modelHash)

    if Config.Debug then
        print("DEBUG - Attached hand prop " .. handPropCfg.model .. " for appliance " .. applianceKey)
    end
end

-- ============================================================
-- RemoveCookingHandProp()
-- Deletes the currently attached hand prop (if any) and clears
-- the `handPropEntity` reference.
-- ============================================================

function RemoveCookingHandProp()
    if handPropEntity then
        if DoesEntityExist(handPropEntity) then
            DeleteEntity(handPropEntity)
            if Config.Debug then
                print("DEBUG - Removed cooking hand prop")
            end
        end
        handPropEntity = nil
    end
end

-- ============================================================
-- StartCooking(entity, recipeName, recipe)
-- Entry point for the cooking interaction.
--   1. Checks isCooking flag and proximity.
--   2. Calls server callback to validate ingredients.
--   3. Plays the recipe animation.
--   4. Delegates to ProcessCookingFlow (multi-step) or a single
--      progressCircle (simple recipes).
-- ============================================================

function StartCooking(entity, recipeName, recipe)
    if isCooking then
        lib.notify({ title = "Already Cooking", description = "You are already cooking something", type = "error" })
        return
    end

    if not isEntityNearby(entity, 2.0) then
        lib.notify({ title = "Error", description = "You are too far away from the cooking appliance", type = "error" })
        return
    end

    if not recipeName or not recipe then
        lib.notify({ title = "Error", description = "Invalid recipe selected", type = "error" })
        return
    end

    -- Server-side ingredient check
    local hasItems = lib.callback.await("flake_cooking:server:checkRequiredItems", false, {
        recipe = recipeName,
        entity = entity,
    })

    if not hasItems then
        lib.notify({ title = "Missing Ingredients", description = "You do not have all the required ingredients", type = "error" })
        return
    end

    isCooking        = true
    currentAppliance = entity

    -- Start visual effects and hand prop
    if recipe.appliance then
        StartApplianceEffects(entity, recipe.appliance)
        AttachCookingHandProp(recipe.appliance)
    end

    local ped = PlayerPedId()

    -- Play animation
    if recipe.animation then
        lib.requestAnimDict(recipe.animation.dict)
        TaskPlayAnim(ped, recipe.animation.dict, recipe.animation.clip,
            8.0, -8.0, -1, 1, 0, false, false, false)
    end

    -- Multi-step or simple cooking
    if recipe.cookingFlow and #recipe.cookingFlow > 0 then
        ProcessCookingFlow(ped, recipeName, recipe)
    else
        local completed = lib.progressCircle({
            duration     = recipe.time * 1000,
            label        = recipe.progress.label,
            useWhileDead = false,
            canCancel    = true,
            disable      = { car = true, move = true, combat = true },
            anim         = { dict = recipe.animation.dict, clip = recipe.animation.clip },
        })

        if completed then
            local success = true
            if recipe.skillCheck and recipe.skillCheck.enabled and Config.SkillCheck then
                success = lib.skillCheck(recipe.skillCheck.difficulty, recipe.skillCheck.inputs)
            end
            CompleteCooking(recipeName, success)
        else
            lib.notify({ title = "Cooking Cancelled", description = "You stopped cooking", type = "error" })
            ClearPedTasks(ped)
            isCooking = false
            RemoveCookingHandProp()
            if entity and DoesEntityExist(entity) then
                StopApplianceEffects(entity)
            end
        end
    end
end

-- ============================================================
-- ProcessCookingFlow(ped, recipeName, recipe)
-- Iterates over recipe.cookingFlow steps, showing a labelled
-- progress bar for each.  If a step has a skill-check it runs
-- lib.skillCheck; failure sets success = false and breaks.
-- Finally calls CompleteCooking.
-- ============================================================

function ProcessCookingFlow(ped, recipeName, recipe)
    local success   = true
    local stepIndex = 1
    local stepCount = #recipe.cookingFlow

    while stepIndex <= stepCount and success do
        local step = recipe.cookingFlow[stepIndex]

        if not step then
            lib.notify({ title = "Error", description = "Invalid cooking step", type = "error" })
            success = false
            break
        end

        local stepLabel = string.format("%s (%d/%d)", step.label, stepIndex, stepCount)

        local completed = lib.progressCircle({
            duration     = step.time * 1000,
            label        = stepLabel,
            position     = step.position or "bottom",
            useWhileDead = false,
            canCancel    = true,
            disable      = { car = true, move = true, combat = true },
            anim         = { dict = recipe.animation.dict, clip = recipe.animation.clip },
        })

        if completed then
            -- Optional per-step skill check
            if step.skillCheck and step.skillCheck.enabled and Config.SkillCheck then
                local passed = lib.skillCheck(step.skillCheck.difficulty, step.skillCheck.inputs)
                if not passed then
                    success = false
                    lib.notify({ title = "Cooking Failed", description = "You failed the skill check!", type = "error" })
                    break
                end
            end
            stepIndex = stepIndex + 1
        else
            lib.notify({ title = "Cooking Cancelled", description = "You stopped cooking", type = "error" })
            RemoveCookingHandProp()
            success = false
            break
        end
    end

    CompleteCooking(recipeName, success)
end

-- ============================================================
-- CompleteCooking(recipeName, success)
-- Cleans up the cooking state, stops effects / animation, then
-- calls the server callback flake_cooking:server:completeCooking.
-- ============================================================

function CompleteCooking(recipeName, success)
    local ped = PlayerPedId()
    ClearPedTasks(ped)
    RemoveCookingHandProp()

    if currentAppliance and DoesEntityExist(currentAppliance) then
        StopApplianceEffects(currentAppliance)
    end

    lib.callback.await("flake_cooking:server:completeCooking", false, {
        recipe  = recipeName,
        success = success,
    })

    isCooking = false
end

-- ============================================================
-- PickUpProp(entity, propType, propData)
-- Validates proximity and ownership, plays a 1-second progress
-- bar, then calls the server callback flake_cooking:server:pickupProp.
-- On success removes the ox_target interactions from the entity.
-- ============================================================

function PickUpProp(entity, propType, propData)
    -- If propType or propData are nil, try to recover them from Config
    if propData and propData.model then
        -- Check if this model is a cooking or decoration prop; trigger a refresh if found
        for _, cookPropData in pairs(Config.CookingProps) do
            if cookPropData.model == propData.model then
                RefreshCookingProps()
                break
            end
        end
        for _, decoPropData in pairs(Config.DecorationProps) do
            if decoPropData.model == propData.model then
                RefreshDecorationProps()
                break
            end
        end
    end

    if not isEntityNearby(entity, 2.0) then
        lib.notify({ title = "Error", description = "You are too far away from the prop", type = "error" })
        return
    end

    local owner    = GetPropOwner(entity)
    local serverId = GetPlayerServerId(PlayerId())
    local charId   = getPlayerCharId(PlayerId())

    -- If owner is 0 check the legacy DecorInt "PropOwner" decorator
    if owner == 0 then
        if DecorExistOn(entity, "PropOwner") then
            local decorOwnerServerId = DecorGetInt(entity, "PropOwner")
            owner = getPlayerCharId(decorOwnerServerId)
            SetPropOwner(entity, owner)
        end
    end

    -- Debug output
    if Config.Debug then
        print("DEBUG - PickUpProp:")
        print("- Entity: "             .. tostring(entity))
        print("- Prop Type: "          .. tostring(propType))
        print("- Prop Data exists: "   .. tostring(propData ~= nil))
        print("- Owner: "              .. tostring(owner))
        print("- Player Char ID: "     .. tostring(charId))
    end

    -- If propType or propData are still missing, try to resolve from model hash
    if not propType or not propData then
        local modelHash = GetEntityModel(entity)

        if Config.Debug then
            print("DEBUG - Entity model hash: " .. tostring(modelHash))
        end

        -- Try Config.GetPropByModel helper first
        if Config.GetPropByModel then
            propType, propData, propCategory = Config.GetPropByModel(modelHash)
        end

        -- Manual fallback: scan DecorationProps then CookingProps
        if not propType or not propData then
            for k, v in pairs(Config.DecorationProps) do
                if joaat(v.model) == modelHash then
                    propType = k
                    propData = v
                    if Config.Debug then
                        print("DEBUG - Manually found matching decoration prop: " .. k)
                    end
                    break
                end
            end
        end

        if not propType or not propData then
            for k, v in pairs(Config.CookingProps) do
                if joaat(v.model) == modelHash then
                    propType = k
                    propData = v
                    if Config.Debug then
                        print("DEBUG - Manually found matching cooking prop: " .. k)
                    end
                    break
                end
            end
        end

        if not propType or not propData then
            lib.notify({ title = "Error", description = "Could not identify prop type", type = "error" })
            return
        end
    end

    -- Ownership check
    if owner ~= charId then
        lib.notify({ title = "Error", description = "You cannot pick up this prop", type = "error" })
        return
    end

    -- Cannot pick up while actively cooking
    if isCooking then
        lib.notify({ title = "Error", description = "Cannot pick up while cooking", type = "error" })
        return
    end

    local ped = PlayerPedId()

    -- Play optional pick-up animation
    if propData.animation then
        lib.requestAnimDict(propData.animation.dict)
        TaskPlayAnim(ped, propData.animation.dict, propData.animation.clip,
            8.0, -8.0, -1, 0, 0, false, false, false)
    end

    -- Short progress bar (non-cancellable)
    local confirmed = lib.progressCircle({
        duration     = 1000,
        label        = "Picking up " .. propData.label,
        useWhileDead = false,
        canCancel    = false,
        disable      = { car = true },
    })

    if confirmed then
        if DoesEntityExist(entity) then
            local propDbId = GetPropIdByEntity(entity)
            local netId    = NetworkGetNetworkIdFromEntity(entity)

            if Config.Debug then
                print("DEBUG - Entity: "              .. tostring(entity))
                print("DEBUG - PropId: "              .. tostring(propDbId))
                print("DEBUG - NetId: "               .. tostring(netId))
                print("DEBUG - About to call server callback")
            end

            local result = lib.callback.await("flake_cooking:server:pickupProp", false, netId, propDbId)

            if Config.Debug then
                print("DEBUG - Server callback result: " .. tostring(result))
            end

            if result then
                setupEntities[entity] = nil

                local isCookingPropType    = Config.CookingProps[propType]    ~= nil
                local isDecorationPropType = Config.DecorationProps[propType] ~= nil

                if Config.Debug then
                    print("DEBUG - Is cooking prop: "    .. tostring(isCookingPropType))
                    print("DEBUG - Is decoration prop: " .. tostring(isDecorationPropType))
                end

                if isCookingPropType then
                    exports.ox_target:removeLocalEntity(entity, {
                        "cooking_" .. propType,
                        "pickup_"  .. propType,
                    })
                elseif isDecorationPropType then
                    exports.ox_target:removeLocalEntity(entity, {
                        "pickup_" .. propType,
                    })
                end
            end
        else
            lib.notify({ title = "Error", description = "The item no longer exists", type = "error" })
        end
    else
        lib.notify({
            title       = "Cancelled",
            description = "You cancelled picking up the " .. propData.label,
            type        = "error",
        })
    end
end

-- ============================================================
-- HasRequiredItems(serverId, requiredItems)
-- Client-side check: returns true if the local player's
-- ox_inventory contains at least the required count of every
-- item in `requiredItems`.
-- ============================================================

function HasRequiredItems(serverId, requiredItems)
    if not requiredItems then return false end
    for _, required in ipairs(requiredItems) do
        local count = exports.ox_inventory:GetItemCount(required.item)
        if not count or count < required.count then
            return false
        end
    end
    return true
end

-- ============================================================
-- Callback: flake_cooking:client:checkRequiredItems
-- Called by the server to verify the client has all ingredients.
-- ============================================================

lib.callback.register("flake_cooking:client:checkRequiredItems", function(data)
    local recipe = Config.Recipes[data.recipe]
    return HasRequiredItems(cache.serverId, recipe.requiredItems)
end)

-- ============================================================
-- NetEvent: flake_cooking:client:setPropOwner
-- Sets the state-bag owner of a networked entity.
-- ============================================================

RegisterNetEvent("flake_cooking:client:setPropOwner", function(netId, ownerIdentifier)
    local entity = NetworkGetEntityFromNetworkId(netId)
    if DoesEntityExist(entity) then
        SetPropOwner(entity, ownerIdentifier)
    end
end)

-- ============================================================
-- Resource stop cleanup
-- ============================================================

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end

    lib.hideTextUI()

    for entity in pairs(activeEffects) do
        if DoesEntityExist(entity) then
            StopApplianceEffects(entity)
        end
    end

    if isCooking then
        ClearPedTasks(PlayerPedId())
    end
end)

-- ============================================================
-- Debug: CreateTestSmoke
-- Spawns looped smoke effects at the player's location using
-- all known smoke effect names, then cleans them up after 10 s.
-- ============================================================

local function CreateTestSmoke()
    local ped      = PlayerPedId()
    local origin   = GetEntityCoords(ped)

    local smokeNames = {
        "ent_amb_smoke_foundry",
        "ent_amb_smoke_factory_white",
        "ent_amb_smoke_gaswork",
        "exp_grd_bzgas_smoke",
        "ent_amb_smoke_scrap",
    }

    RequestNamedPtfxAsset("core")
    while not HasNamedPtfxAssetLoaded("core") do Wait(10) end

    for i, name in ipairs(smokeNames) do
        local offset  = vector3(1.0 * i, 0.0, 0.0)
        local spawnAt = origin + offset

        UseParticleFxAssetNextCall("core")
        local fxId = StartParticleFxLoopedAtCoord(
            name,
            spawnAt.x, spawnAt.y, spawnAt.z + 1.0,
            0.0, 0.0, 0.0,
            1.0, false, false, false, false
        )

        if fxId and fxId ~= -1 then
            print("SUCCESS: Created test effect " .. name .. " with ID " .. fxId)
            if not activeEffects[-1] then activeEffects[-1] = {} end
            activeEffects[-1][name] = fxId
        else
            print("FAILED: Could not create test effect " .. name)
        end
    end

    -- Auto-cleanup after 10 seconds
    Citizen.SetTimeout(10000, function()
        if activeEffects[-1] then
            for name, fxId in pairs(activeEffects[-1]) do
                StopParticleFxLooped(fxId, false)
                print("Cleaned up test effect: " .. name)
            end
            activeEffects[-1] = nil
        end
    end)
end

CreateTestSmoke = CreateTestSmoke  -- expose as global

if Config.Debug then
    RegisterCommand("testsmoke", function()
        CreateTestSmoke()
    end, false)
end

exports("CreateTestSmoke", CreateTestSmoke)

-- ============================================================
-- Debug: CreateTestFire
-- Same as CreateTestSmoke but for fire effect names.
-- ============================================================

local function CreateTestFire()
    local ped      = PlayerPedId()
    local origin   = GetEntityCoords(ped)

    local fireNames = {
        "ent_amb_BBQ_fire",
        "ent_amb_fire_ring",
        "ent_amb_torch_fire",
        "fire_wrecked_plane_cockpit",
        "ent_ray_heli_aprtmnt_l_fire",
    }

    RequestNamedPtfxAsset("core")
    while not HasNamedPtfxAssetLoaded("core") do Wait(10) end

    for i, name in ipairs(fireNames) do
        local offset  = vector3(1.0 * i, 0.0, 0.0)
        local spawnAt = origin + offset

        UseParticleFxAssetNextCall("core")
        local fxId = StartParticleFxLoopedAtCoord(
            name,
            spawnAt.x, spawnAt.y, spawnAt.z + 0.5,
            0.0, 0.0, 0.0,
            0.8, false, false, false, false
        )

        if fxId and fxId ~= -1 then
            print("SUCCESS: Created test fire effect " .. name .. " with ID " .. fxId)
            if not activeEffects[-2] then activeEffects[-2] = {} end
            activeEffects[-2][name] = fxId
        else
            print("FAILED: Could not create test fire effect " .. name)
        end
    end

    -- Auto-cleanup after 10 seconds
    Citizen.SetTimeout(10000, function()
        if activeEffects[-2] then
            for name, fxId in pairs(activeEffects[-2]) do
                StopParticleFxLooped(fxId, false)
                print("Cleaned up test fire effect: " .. name)
            end
            activeEffects[-2] = nil
        end
    end)
end

CreateTestFire = CreateTestFire  -- expose as global

if Config.Debug then
    RegisterCommand("testfire", function()
        CreateTestFire()
    end, false)
end

exports("CreateTestFire", CreateTestFire)

-- ============================================================
-- Debug: testbbq command
-- Spawns a prop_bbq_1 in front of the player, starts smoke and
-- fire effects on it, notifies the player, then removes it all
-- after 20 seconds.
-- ============================================================

if Config.Debug then
    RegisterCommand("testbbq", function()
        local ped    = PlayerPedId()
        local origin = GetEntityCoords(ped)

        local modelHash = joaat("prop_bbq_1")
        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do Wait(10) end

        local heading  = GetEntityHeading(ped)
        local spawnPos = origin + vector3(0.0, 1.5, 0.0)
        local bbq      = CreateObject(modelHash, spawnPos.x, spawnPos.y, spawnPos.z,
                                      true, false, false)

        if bbq then
            if DoesEntityExist(bbq) then
                SetEntityHeading(bbq, heading)
                PlaceObjectOnGroundProperly(bbq)

                if not activeEffects[bbq] then activeEffects[bbq] = {} end

                RequestNamedPtfxAsset("core")
                while not HasNamedPtfxAssetLoaded("core") do Wait(10) end

                -- Smoke effect
                UseParticleFxAssetNextCall("core")
                local smokeId = StartParticleFxLoopedOnEntity(
                    "ent_amb_smoke_foundry", bbq,
                    0.0, 0.0, 0.7,
                    0.0, 0.0, 0.0,
                    1.5, false, false, false
                )
                if smokeId and smokeId ~= -1 then
                    activeEffects[bbq].smoke = smokeId
                    print("Started smoke effect on test BBQ")
                end

                -- Fire effect
                UseParticleFxAssetNextCall("core")
                local fireId = StartParticleFxLoopedOnEntity(
                    "ent_amb_BBQ_fire", bbq,
                    0.0, 0.0, 0.5,
                    0.0, 0.0, 0.0,
                    0.6, false, false, false
                )
                if fireId and fireId ~= -1 then
                    activeEffects[bbq].fire = fireId
                    print("Started fire effect on test BBQ")
                end

                lib.notify({
                    title       = "Test BBQ",
                    description = "Created test BBQ with smoke and fire effects for 20 seconds",
                    type        = "success",
                })

                -- Auto-cleanup after 20 seconds
                Citizen.SetTimeout(20000, function()
                    if bbq and DoesEntityExist(bbq) then
                        if activeEffects[bbq] then
                            for effectType, fxId in pairs(activeEffects[bbq]) do
                                StopParticleFxLooped(fxId, false)
                                print("Stopped " .. effectType .. " effect on test BBQ")
                            end
                            activeEffects[bbq] = nil
                        end
                        DeleteEntity(bbq)
                        lib.notify({
                            title       = "Test BBQ",
                            description = "Removed test BBQ and effects",
                            type        = "info",
                        })
                    end
                end)
            end
        else
            print("Failed to create test BBQ prop")
        end
    end, false)
end

exports("TestBBQEffects", function()
    ExecuteCommand("testbbq")
end)
