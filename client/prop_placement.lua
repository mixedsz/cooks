-- ============================================================
-- flake_cooking | client/prop_placement.lua
-- Prop placement, sync, creation and management
-- ============================================================

-- --- Module-level state -------------------------------------
local isPlacing             = false   -- currently in placement flow
local propData              = nil     -- Config prop entry for the item being placed
local placingEntity         = nil     -- temp gizmo entity
local lastPlacementTime     = 0       -- GetGameTimer() when last prop was confirmed placed
local placementCooldown     = 2000    -- ms between placements
local lastInventoryUsageTime = 0      -- GetGameTimer() when inventory was last used
local inventoryCooldown     = 500     -- ms between inventory usages
local placementLock         = false   -- prevents concurrent placement
local isInjured             = false   -- set by CEventNetworkEntityDamage
local savedHealth           = nil     -- player health snapshot on init

-- Cached native references
local GetEntityCoords       = GetEntityCoords
local PlayerPedId           = PlayerPedId
local DoesEntityExist       = DoesEntityExist
local DeleteEntity          = DeleteEntity
local HasModelLoaded        = HasModelLoaded
local RequestModel          = RequestModel
local joaat                 = joaat

-- propId -> { entity, netId, model, owner, coords, viewOnly }
local placedPropsById = {}

-- --- GetPropIdByEntity --------------------------------------
-- Searches placedPropsById for the given entity handle and
-- returns its propId key, or nil if not found.
function GetPropIdByEntity(entity)
    if not entity or not DoesEntityExist(entity) then
        return nil
    end
    for propId, propEntry in pairs(placedPropsById) do
        if propEntry.entity == entity then
            return propId
        end
    end
    return nil
end

-- --- gameEventTriggered - injury detection ------------------
AddEventHandler("gameEventTriggered", function(eventName, eventArgs)
    if eventName ~= "CEventNetworkEntityDamage" then return end

    local damagedEntity = eventArgs[1]
    local ped = PlayerPedId()

    if damagedEntity == ped then
        isInjured = true
        if isPlacing then
            CancelPlacementDueToInjury()
        end
        SetTimeout(1000, function()
            isInjured = false
        end)
    end
end)

-- --- RotationToDirection ------------------------------------
-- Converts an Euler rotation (degrees) to a normalised
-- direction vector (x forward, y right, z up convention).
function RotationToDirection(rot)
    local radians = {
        x = (math.pi / 180) * rot.x,
        y = (math.pi / 180) * rot.y,
        z = (math.pi / 180) * rot.z,
    }
    local direction = {}
    direction.x = -math.sin(radians.z) * math.abs(math.cos(radians.x))
    direction.y =  math.cos(radians.z) * math.abs(math.cos(radians.x))
    direction.z =  math.sin(radians.x)
    return direction
end

-- --- RayCastGamePlayCamera ----------------------------------
-- Fires a shape-test ray from the gameplay camera origin in
-- the camera's forward direction for `distance` units.
-- Returns: hitResult, hitCoords, hitEntity
function RayCastGamePlayCamera(distance)
    local camRot    = GetGameplayCamRot()
    local camCoords = GetGameplayCamCoord()
    local direction = RotationToDirection(camRot)

    local farCoords = {
        x = camCoords.x + direction.x * distance,
        y = camCoords.y + direction.y * distance,
        z = camCoords.z + direction.z * distance,
    }

    local rayHandle = StartShapeTestRay(
        camCoords.x, camCoords.y, camCoords.z,
        farCoords.x, farCoords.y, farCoords.z,
        -1,
        PlayerPedId(),
        0
    )

    local hitResult, hitCoords, _, hitEntity = GetShapeTestResult(rayHandle)
    return hitResult, hitCoords, hitEntity
end

-- --- DrawPropAxes -------------------------------------------
-- Draws RGB debug axis lines on the given entity each frame.
-- Red = forward (Y axis), Green = right (X axis), Blue = up (Z axis).
function DrawPropAxes(entity)
    local forward, right, up, pos = GetEntityMatrix(entity)

    local endForward = pos + forward * 1.0
    local endRight   = pos + right   * 1.0
    local endUp      = pos + up      * 1.0

    -- Red - forward
    DrawLine(pos.x, pos.y, pos.z + 0.1, endForward.x, endForward.y, endForward.z, 255, 0, 0, 255)
    -- Green - right
    DrawLine(pos.x, pos.y, pos.z + 0.1, endRight.x,   endRight.y,   endRight.z,   0, 255, 0, 255)
    -- Blue - up
    DrawLine(pos.x, pos.y, pos.z + 0.1, endUp.x,      endUp.y,      endUp.z,      0, 0, 255, 255)
end

-- --- loadModel ----------------------------------------------
-- Loads a model by hash.  Uses lib.requestModel when available,
-- otherwise falls back to a manual RequestModel loop (5 s timeout).
-- Returns true on success, false on failure.
function loadModel(hash)
    if Config.Debug then
        print("^3[flake_cooking]^7: Loading model: " .. tostring(hash))
    end

    if lib and lib.requestModel then
        return lib.requestModel(hash, 1000)
    end

    -- Fallback path (no ox_lib)
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        local deadline = GetGameTimer() + 5000
        while true do
            if HasModelLoaded(hash) then break end
            if GetGameTimer() >= deadline then break end
            Wait(10)
        end
        if not HasModelLoaded(hash) then
            print("^1[flake_cooking]^7: Failed to load model: " .. tostring(hash))
            return false
        end
    end
    return true
end

-- --- unloadModel --------------------------------------------
function unloadModel(hash)
    SetModelAsNoLongerNeeded(hash)
end

-- --- IsPlayerInjured ----------------------------------------
-- Returns true when the player has been recently hit (isInjured)
-- or is currently swimming.
function IsPlayerInjured()
    local ped = PlayerPedId()
    return isInjured or IsPedSwimming(ped)
end

-- --- IsPlayerInInvalidState ---------------------------------
-- Returns true when the player is in a state that prevents
-- prop placement (currently: swimming only).
function IsPlayerInInvalidState()
    local ped = PlayerPedId()
    return IsPedSwimming(ped)
end

-- --- CancelPlacementDueToInjury -----------------------------
-- Cleans up an in-progress placement because the player was hurt.
function CancelPlacementDueToInjury()
    if DoesEntityExist(placingEntity) then
        DeleteEntity(placingEntity)
    end
    placingEntity = nil
    isPlacing     = false
    propData      = nil
    placementLock = false

    lib.hideTextUI()
    lib.notify({
        title       = "Cancelled",
        description = "Prop placement cancelled due to injury",
        type        = "error",
    })
end

-- --- StartPropPlacement -------------------------------------
-- Full gizmo-based prop placement flow.
-- 1. Guard checks (lock, swim, cooldown).
-- 2. Look up prop config and load model.
-- 3. Create a local-only gizmo object near the player.
-- 4. Call exports.object_gizmo:useGizmo to let the player
--    position/rotate the prop.
-- 5. Run a lib.progressCircle inside a coroutine while a
--    parallel health-monitor thread watches for injuries.
-- 6. On confirmation, delete gizmo object then call the server
--    callback flake_cooking:server:placeProp.
function StartPropPlacement(itemName)
    -- Guard: already placing
    if placementLock then
        lib.notify({
            title       = "Please Wait",
            description = "A prop placement is already in progress",
            type        = "error",
        })
        return
    end

    -- Guard: invalid player state (swimming, etc.)
    if IsPlayerInInvalidState() then
        lib.notify({
            title       = "Cannot Place Prop",
            description = "You cannot place props while swimming",
            type        = "error",
        })
        return
    end

    -- Guard: placement cooldown
    local now = GetGameTimer()
    local timeSinceLast = now - lastPlacementTime
    if timeSinceLast < placementCooldown then
        local secondsLeft = math.ceil((placementCooldown - timeSinceLast) / 1000)
        lib.notify({
            title       = "Please Wait",
            description = "You need to wait " .. secondsLeft .. " seconds before placing another prop",
            type        = "error",
        })
        return
    end

    if Config.Debug then
        print("^3[flake_cooking]^7: Setting placementLock to true")
    end
    placementLock = true

    -- Look up prop config from item name
    local foundPropData, propConfig = Config.GetPropByItem(itemName)
    if not foundPropData then
        if Config.Debug then
            print("^3[flake_cooking]^7: Clearing placementLock due to invalid prop type")
        end
        placementLock = false
        return
    end
    propData  = propConfig
    isPlacing = true

    -- Load model
    local modelHash = joaat(propData.model)
    local modelLoaded = loadModel(modelHash)
    if not modelLoaded then
        lib.notify({
            title       = "Error",
            description = "Failed to load prop model",
            type        = "error",
        })
        isPlacing     = false
        propData      = nil
        placementLock = false
        return
    end

    -- Get initial raycast placement position
    local hitResult, hitCoords, hitEntity = RayCastGamePlayCamera(1000.0)
    if not hitResult then
        local attempts = 0
        while not hitResult and attempts < 10 do
            hitResult, hitCoords, hitEntity = RayCastGamePlayCamera(1000.0)
            Wait(100)
            attempts = attempts + 1
        end
        if not hitResult then
            lib.notify({
                title       = "Error",
                description = "Could not find a valid placement location",
                type        = "error",
            })
            isPlacing     = false
            propData      = nil
            placementLock = false
            return
        end
    end

    -- Spawn local gizmo object slightly in front of the player
    local pedCoords   = GetEntityCoords(cache.ped)
    local forwardVec  = GetEntityForwardVector(cache.ped)
    local spawnCoords = pedCoords + forwardVec * 3

    local gizmoEntity = CreateObject(
        modelHash,
        spawnCoords.x, spawnCoords.y, spawnCoords.z,
        false, false, false
    )
    if not gizmoEntity or gizmoEntity == 0 then
        lib.notify({
            title       = "Error",
            description = "Failed to create object",
            type        = "error",
        })
        placementLock = false
        return
    end

    if Config.Debug then
        print("^5[GIZMO OBJECT CREATED]^7 Entity:", gizmoEntity, "Model:", propData.model)
    end

    NetworkSetEntityInvisibleToNetwork(gizmoEntity, true)
    SetEntityCollision(gizmoEntity, true, true)
    FreezeEntityPosition(gizmoEntity, true)

    if Config.Debug then
        print("^5[GIZMO OBJECT FROZEN]^7 Entity:", gizmoEntity)
        print("^5[DEBUG]^7 About to start gizmo interaction")
    end

    -- Call the gizmo export (wrapped in pcall for safety)
    local gizmoOk, gizmoData
    gizmoOk, gizmoData = pcall(function()
        return exports.object_gizmo:useGizmo(gizmoEntity)
    end)

    if Config.Debug then
        print("^5[DEBUG]^7 Gizmo pcall success:", gizmoOk)
        print("^5[DEBUG]^7 Gizmo returned data:", gizmoData and "YES" or "NO")
        if gizmoData and gizmoOk then
            print("^5[DEBUG]^7 Data contents:", json.encode(gizmoData))
        end
    end

    -- Gizmo call itself errored
    if not gizmoOk then
        if Config.Debug then
            print("^1[DEBUG]^7 Gizmo error:", gizmoData)
        end
        lib.notify({
            title       = "Error",
            description = "Gizmo interaction failed",
            type        = "error",
        })
        DeleteEntity(gizmoEntity)
        isPlacing     = false
        propData      = nil
        placementLock = false
        return
    end

    -- Gizmo returned data (player confirmed placement)
    if gizmoData then
        -- Overwrite position/rotation in gizmoData with actual entity state
        local finalCoords   = GetEntityCoords(gizmoEntity)
        local finalRotation = GetEntityRotation(gizmoEntity)

        if Config.Debug then
            print("^3[flake_cooking]^7: Gizmo data received:", json.encode(gizmoData))
            print("^3[flake_cooking]^7: Actual object coords:", finalCoords)
            print("^3[flake_cooking]^7: Actual object rotation:", finalRotation)
        end

        gizmoData.position = finalCoords
        gizmoData.rotation = finalRotation

        -- Play placement animation if configured
        if propData.animation then
            lib.requestAnimDict(propData.animation.dict)
            TaskPlayAnim(
                PlayerPedId(),
                propData.animation.dict,
                propData.animation.clip,
                8.0, -8.0, -1, 0, 0,
                false, false, false
            )
        end

        if Config.Debug then
            print("^5[DEBUG]^7 Creating placement progress bar coroutine")
        end

        -- Create coroutine that runs the progress circle
        local progressCoroutine = coroutine.create(function()
            if Config.Debug then
                print("^5[DEBUG]^7 Starting progress circle")
            end

            local pcallOk, pcallResult = pcall(function()
                return lib.progressCircle({
                    duration   = 2000,
                    label      = "Placing " .. propData.label,
                    useWhileDead = false,
                    canCancel  = false,
                    disable    = { car = true, move = true, combat = true },
                    anim       = {
                        dict = propData.animation.dict,
                        clip = propData.animation.clip,
                    },
                })
            end)

            if Config.Debug then
                print("^5[DEBUG]^7 Progress circle pcall success:", pcallOk)
                print("^5[DEBUG]^7 Progress circle returned:", pcallResult)
                print("^5[DEBUG]^7 Progress result type:", type(pcallResult))
            end

            if not pcallOk then
                if Config.Debug then
                    print("^1[DEBUG]^7 Progress circle error:", pcallResult)
                    print("^3[DEBUG]^7 Attempting to continue despite error (WaveShield interference)")
                end
                -- Treat error as success so placement continues
                return true
            end

            return (pcallResult ~= false and pcallResult ~= nil)
        end)

        -- Health monitor state flags
        local progressRunning  = true
        local cancelledByHealth = false

        -- Health monitor thread - cancels progress if player gets injured
        CreateThread(function()
            if Config.Debug then
                print("^5[DEBUG]^7 Health monitor thread started")
            end
            while progressRunning do
                if IsPlayerInjured() then
                    if Config.Debug then
                        print("^1[DEBUG]^7 Player injured detected! Cancelling progress")
                    end
                    cancelledByHealth = true
                    lib.cancelProgress()
                    Wait(500)
                    lib.notify({
                        title       = "Cancelled",
                        description = "Placement cancelled due to injury",
                        type        = "error",
                    })
                    break
                end
                Wait(100)
            end
            if Config.Debug then
                print("^5[DEBUG]^7 Health monitor thread ended. Cancelled:", cancelledByHealth)
            end
        end)

        if Config.Debug then
            print("^5[DEBUG]^7 Resuming placement coroutine")
        end

        local coStatus, coResult = coroutine.resume(progressCoroutine)
        progressRunning = false  -- signal health monitor thread to stop

        if Config.Debug then
            print("^5[DEBUG]^7 Coroutine status:", coStatus)
            print("^5[DEBUG]^7 Coroutine result:", coResult)
            print("^5[DEBUG]^7 Result type:", type(coResult))
            print("^5[DEBUG]^7 Health cancelled:", cancelledByHealth)
            print("^5[DEBUG]^7 Final check (status and result):", coStatus and coResult or coResult)
        end

        if not coStatus then
            if Config.Debug then
                print("^1[DEBUG]^7 Coroutine error:", coResult)
            end
            coResult = false
        end

        if coStatus and coResult then
            -- --- Placement confirmed -----------------------------
            if Config.Debug then
                print("^3[flake_cooking]^7: Gizmo placement confirmed, deleting gizmo object")
            end

            -- Delete gizmo object
            if DoesEntityExist(gizmoEntity) then
                local coordsBeforeDelete = GetEntityCoords(gizmoEntity)
                if Config.Debug then
                    print("^1[DELETING GIZMO]^7 Entity:", gizmoEntity, "At:", coordsBeforeDelete)
                end
                SetEntityAsMissionEntity(gizmoEntity, false, true)
                DeleteObject(gizmoEntity)
                DeleteEntity(gizmoEntity)
                Wait(500)
                if DoesEntityExist(gizmoEntity) then
                    if Config.Debug then
                        print("^1[WARNING]^7 Gizmo object still exists after delete!")
                    end
                else
                    if Config.Debug then
                        print("^2[SUCCESS]^7 Gizmo object deleted")
                    end
                end
            end

            if Config.Debug then
                print("^3[flake_cooking]^7: Calling server to place prop")
            end

            -- Final injury check before calling server
            if not IsPlayerInjured() then
                local serverOk, serverResult = pcall(function()
                    return lib.callback.await(
                        "flake_cooking:server:placeProp",
                        false,
                        propData.model,
                        gizmoData.position,
                        gizmoData.rotation
                    )
                end)

                if Config.Debug then
                    print("^5[DEBUG]^7 Server callback pcall success:", serverOk)
                    print("^3[flake_cooking]^7: Server responded with: " .. tostring(serverResult))
                    print("^3[flake_cooking]^7: Clearing placementLock after server response")
                end

                if not serverOk then
                    if Config.Debug then
                        print("^1[DEBUG]^7 Server callback error:", serverResult)
                    end
                    lib.notify({
                        title       = "Error",
                        description = "Failed to place prop on server",
                        type        = "error",
                    })
                elseif serverResult then
                    lastPlacementTime     = GetGameTimer()
                    lastInventoryUsageTime = GetGameTimer()
                end
            else
                lib.notify({
                    title       = "Cancelled",
                    description = "Placement cancelled due to injury",
                    type        = "error",
                })
            end

        else
            -- --- Placement failed / cancelled --------------------
            if Config.Debug then
                print("^1[DEBUG]^7 Placement failed!")
                print("^1[DEBUG]^7 - Status was:", coStatus)
                print("^1[DEBUG]^7 - Result was:", coResult)
                print("^1[DEBUG]^7 - Health cancelled:", cancelledByHealth)
            end

            if not cancelledByHealth then
                lib.notify({
                    title       = "Cancelled",
                    description = "You cancelled placing the " .. propData.label,
                    type        = "error",
                })
            end

            if DoesEntityExist(gizmoEntity) then
                DeleteEntity(gizmoEntity)
            end
        end

    else
        -- --- Gizmo returned no data (player cancelled via gizmo) -
        if Config.Debug then
            print("^3[flake_cooking]^7: Gizmo placement cancelled (no data returned from gizmo)")
        end
        DeleteEntity(gizmoEntity)
    end

    -- Always reset state
    isPlacing     = false
    propData      = nil
    placementLock = false
end

-- --- ClearPlacementLock -------------------------------------
-- Resets placementLock and tells the server to clear its
-- active-placement record for this player.
function ClearPlacementLock()
    if Config.Debug then
        print("^3[flake_cooking]^7: Force clearing placement lock")
    end
    placementLock = false
    lib.callback.await("flake_cooking:server:clearActivePlacement", false)
end

-- --- Stale lock watchdog thread -----------------------------
-- Clears placementLock on resource start, snapshots initial
-- health, then every 60 s auto-clears a stale lock (one that
-- is set but isPlacing is false, meaning something went wrong).
CreateThread(function()
    ClearPlacementLock()
    savedHealth = GetEntityHealth(PlayerPedId())

    while true do
        Wait(60000)
        if placementLock and not isPlacing then
            if Config.Debug then
                print("^3[flake_cooking]^7: Detected stale placement lock, clearing it")
            end
            ClearPlacementLock()
        end
        Wait(1000)
    end
end)

-- Shared logic for starting prop placement (used by both net event and lib.callback paths)
local function handleStartPropPlacement(itemName)
    ClearPlacementLock()

    local now = GetGameTimer()
    local timeSinceInventory = now - lastInventoryUsageTime
    if timeSinceInventory < inventoryCooldown then
        lib.notify({
            title       = "Please Wait",
            description = "You need to wait before taking another prop from your inventory",
            type        = "error",
        })
        return false
    end

    lastInventoryUsageTime = GetGameTimer()
    StartPropPlacement(itemName)
    return true
end

-- Net event path: fired directly by the server useable-item handler (primary)
RegisterNetEvent('flake_cooking:startPropPlacement')
AddEventHandler('flake_cooking:startPropPlacement', function(itemName)
    handleStartPropPlacement(itemName)
end)

-- lib.callback path: kept as fallback for any server->client callback calls
lib.callback.register("flake_cooking:client:startPropPlacement", function(itemName)
    return handleStartPropPlacement(itemName)
end)

-- --- lib.callback: syncProp ---------------------------------
-- Updates an existing networked entity's position/rotation, or
-- creates a new networked object and optionally assigns it the
-- given network id.
-- Args: netId, model, coords, rotation, propId
lib.callback.register("flake_cooking:client:syncProp", function(netId, model, coords, rotation, propId)
    local modelHash = joaat(model)
    loadModel(modelHash)

    -- Try to find an existing entity for this netId
    local existingEntity = NetworkGetEntityFromNetworkId(netId)
    if existingEntity then
        if DoesEntityExist(existingEntity) then
            SetEntityCoords(existingEntity, coords.x, coords.y, coords.z, false, false, false, true)
            SetEntityRotation(existingEntity, rotation.x, rotation.y, rotation.z, 2, true)
            FreezeEntityPosition(existingEntity, true)
            return true
        end
    end

    -- Create a new networked object
    local newEntity = CreateObject(modelHash, coords.x, coords.y, coords.z, true, true, false)
    if DoesEntityExist(newEntity) then
        SetEntityRotation(newEntity, rotation.x, rotation.y, rotation.z, 2, true)
        FreezeEntityPosition(newEntity, true)
        NetworkRegisterEntityAsNetworked(newEntity)

        if netId and netId > 0 then
            local dynOk = NetworkSetNetworkIdDynamic(netId, true)
            if dynOk then
                NetworkSetNetworkIdExistsOnAllMachines(netId, true)
            end
        end
        return true
    end

    return false
end)

-- --- createPropLocally (internal function) ------------------
-- Creates a non-networked local object, applies decorators and
-- interaction zones, then stores it in placedPropsById.
-- Args: model, coords, rotation, owner, propId
local function createPropLocally(model, coords, rotation, owner, propId)
    -- Parameter validation
    if not model then
        print("Error: Missing 'model' parameter in createPropLocally")
        return false
    end
    if not coords then
        print("Error: Missing 'coords' parameter in createPropLocally")
        return false
    end
    if not rotation then
        print("Error: Missing 'rotation' parameter in createPropLocally")
        return false
    end

    -- Fallback owner
    if not owner then
        owner = GetPlayerServerId(PlayerId())
        print("^3[flake_cooking]^7: Using fallback owner value:", owner)
    end

    -- Fallback propId
    if not propId then
        propId = "local_" .. model .. "_" .. math.random(1000, 9999) .. "_" .. GetGameTimer()
        print("^3[flake_cooking]^7: Using fallback propId:", propId)
    end

    -- Validate coords format
    if type(coords) ~= "vector3" then
        if not (coords.x and coords.y and coords.z) then
            print("Error: Invalid coords format in createPropLocally")
            print("X: " .. tostring(coords.x) .. ", Y: " .. tostring(coords.y) .. ", Z: " .. tostring(coords.z))
            return false
        end
    end

    -- Validate model name
    local modelHash = joaat(model)
    if modelHash == 0 then
        print("Error: Invalid model name: " .. model)
        return false
    end

    -- Load model
    if not loadModel(modelHash) then
        print("^1[flake_cooking]^7: Failed to load model for prop creation")
        return false
    end

    -- Duplicate proximity check (skip if same propId)
    for existingId, existingEntry in pairs(placedPropsById) do
        if existingId ~= propId and existingEntry.entity and DoesEntityExist(existingEntry.entity) then
            local dist = #(vector3(coords.x, coords.y, coords.z) - GetEntityCoords(existingEntry.entity))
            if dist < 0.5 then
                print("Already have a prop at this location (distance: " .. dist .. "), skipping duplicate")
                return false
            end
        end
    end

    -- Create local object
    local entity = CreateObject(modelHash, coords.x, coords.y, coords.z, false, false, false)
    if DoesEntityExist(entity) then
        if Config.Debug then
            print("^2[LOCAL PROP CREATED]^7 Model:", model, "PropID:", propId, "Entity:", entity)
            print("DEBUG - createPropLocally:")
            print("  Requested coords:", coords.x, coords.y, coords.z)
        end

        SetEntityRotation(entity, rotation.x, rotation.y, rotation.z, 2, true)
        SetEntityCoordsNoOffset(entity, coords.x, coords.y, coords.z, false, false, false)

        if Config.Debug then
            local actualCoords = GetEntityCoords(entity)
            print("  Coords after force set:", actualCoords.x, actualCoords.y, actualCoords.z)
            print("  Height difference:", actualCoords.z - coords.z)
        end

        FreezeEntityPosition(entity, true)
        SetEntityCollision(entity, true, true)
        SetEntityAsMissionEntity(entity, true, true)

        -- Resolve owner to a numeric server id for the decorator
        local ownerServerId = 0
        if type(owner) == "string" then
            -- e.g. "char5" format used by some frameworks
            if owner:sub(1, 4) == "char" then
                ownerServerId = tonumber(owner:sub(5)) or 0
            end
        elseif type(owner) == "number" then
            ownerServerId = owner
        end

        -- Apply decorators
        DecorSetInt(entity,  "PropOwner",    ownerServerId)
        DecorSetBool(entity, "IsPlacedProp", true)
        DecorSetInt(entity,  "PropId",       propId)

        -- Store in tracking table
        local actualCoords = GetEntityCoords(entity)
        placedPropsById[propId] = {
            entity = entity,
            netId  = 0,
            model  = model,
            owner  = owner,
            coords = actualCoords,
        }

        if Config.Debug then
            print("Client created prop locally: " .. model ..
                  " at " .. tostring(coords.x) .. ", " .. tostring(coords.y) .. ", " .. tostring(coords.z) ..
                  " with ID: " .. propId .. " owned by " .. owner)
        end

        SetPropOwner(entity, owner)

        -- Determine prop type and set up interaction
        local propKey, propConfig, propCategory = nil, nil, nil

        for key, cfg in pairs(Config.CookingProps) do
            if cfg.model == model then
                propKey      = key
                propConfig   = cfg
                propCategory = "cooking"
                if Config.Debug then print("Created prop is a cooking prop: " .. key) end
                break
            end
        end

        if not propKey then
            for key, cfg in pairs(Config.DecorationProps) do
                if cfg.model == model then
                    propKey      = key
                    propConfig   = cfg
                    propCategory = "decoration"
                    if Config.Debug then print("Created prop is a decoration prop: " .. key) end
                    break
                end
            end
        end

        if propCategory == "cooking" and propKey and propConfig then
            if Config.Debug then print("Setting up cooking prop interaction for " .. propKey) end
            SetupCookingPropInteraction(entity, propKey, propConfig)
        elseif propCategory == "decoration" and propKey and propConfig then
            if Config.Debug then print("Setting up decoration prop interaction for " .. propKey) end
            SetupDecorationPropInteraction(entity, propKey, propConfig)
        else
            if Config.Debug then print("Warning: Could not determine prop type for interaction setup") end
        end

        unloadModel(modelHash)
        return true
    else
        print("Failed to create entity on client side")
        unloadModel(modelHash)
        return false
    end
end

-- lib.callback path (kept for backwards compat)
lib.callback.register("flake_cooking:client:createPropLocally", function(model, coords, rotation, owner, propId)
    return createPropLocally(model, coords, rotation, owner, propId)
end)

-- Net event path (primary -- used by server TriggerClientEvent)
RegisterNetEvent("flake_cooking:client:createPropLocally")
AddEventHandler("flake_cooking:client:createPropLocally", function(model, coords, rotation, owner, propId)
    createPropLocally(model, coords, rotation, owner, propId)
end)

-- --- createViewOnlyProp (internal function) ------------------
-- Creates a non-interactable (viewOnly = true) copy of a prop
-- for players who are not the owner.  Used for both the
-- lib.callback and the RegisterNetEvent paths below.
local function createViewOnlyProp(model, coords, rotation, owner, propId)
    if Config.Debug then
        print("^3[flake_cooking]^7: Received createViewOnlyProp event with parameters:")
        print("- model:",  tostring(model))
        print("- coords:", tostring(coords))
        if coords then
            print("  - x:", tostring(coords.x))
            print("  - y:", tostring(coords.y))
            print("  - z:", tostring(coords.z))
        end
        print("- rotation:", tostring(rotation))
        print("- owner:",    tostring(owner))
        print("- propId:",   tostring(propId))
    end

    -- Parameter validation
    if not model then
        if Config.Debug then print("Error: Missing 'model' parameter in createViewOnlyProp") end
        return false
    end
    if not coords then
        if Config.Debug then print("Error: Missing 'coords' parameter in createViewOnlyProp") end
        return false
    end
    if not rotation then
        if Config.Debug then print("Error: Missing 'rotation' parameter in createViewOnlyProp") end
        return false
    end

    -- Fallback owner
    if not owner then
        owner = 0
        if Config.Debug then
            print("^3[flake_cooking]^7: Using fallback owner value for view-only prop:", owner)
        end
    end

    -- Fallback propId
    if not propId then
        propId = "view_" .. model .. "_" .. math.random(1000, 9999) .. "_" .. GetGameTimer()
        if Config.Debug then
            print("^3[flake_cooking]^7: Using fallback propId for view-only prop:", propId)
        end
    end

    -- Coerce coords to vector3 if needed
    if type(coords) ~= "vector3" then
        if not (coords.x and coords.y and coords.z) then
            if Config.Debug then
                print("Error: Invalid coords format in createViewOnlyProp")
                print("X: " .. tostring(coords.x) .. ", Y: " .. tostring(coords.y) .. ", Z: " .. tostring(coords.z))
            end
            coords = vector3(coords.x or 0, coords.y or 0, coords.z or 0)
        end
    end

    -- Duplicate propId check
    if Config.Debug then
        print("^3[DEBUG]^7 Checking propId:", propId)
        print("^3[DEBUG]^7 Current placedPropsById keys:")
        for k, v in pairs(placedPropsById) do
            print("  - Key:", k, "Entity:", v.entity)
        end
    end

    if placedPropsById[propId] then
        if Config.Debug then
            print("^1[DUPLICATE DETECTED]^7 Already have prop with ID " .. propId .. ", ignoring duplicate")
        end
        return false
    else
        if Config.Debug then
            print("^2[NEW PROP]^7 PropId not found in table, creating view-only prop")
        end
    end

    -- Duplicate proximity check
    for existingId, existingEntry in pairs(placedPropsById) do
        if existingId ~= propId and existingEntry.entity and DoesEntityExist(existingEntry.entity) then
            local dist = #(vector3(coords.x, coords.y, coords.z) - GetEntityCoords(existingEntry.entity))
            if dist < 0.5 then
                if Config.Debug then
                    print("Already have a prop at this location (distance: " .. dist .. "), skipping duplicate")
                end
                return false
            end
        end
    end

    -- Load model and create object
    local modelHash = joaat(model)
    if not loadModel(modelHash) then
        print("^1[flake_cooking]^7: Failed to load model for view-only prop creation")
        return false
    end

    local entity = CreateObject(modelHash, coords.x, coords.y, coords.z, false, false, false)
    if DoesEntityExist(entity) then
        if Config.Debug then
            print("^3[VIEW-ONLY PROP CREATED]^7 Model:", model, "PropID:", propId,
                  "Entity:", entity, "Owner:", owner)
        end

        SetEntityRotation(entity, rotation.x, rotation.y, rotation.z, 2, true)
        SetEntityCoordsNoOffset(entity, coords.x, coords.y, coords.z, false, false, false)
        FreezeEntityPosition(entity, true)
        SetEntityCollision(entity, true, true)
        SetEntityAsMissionEntity(entity, true, true)

        -- View-only decorators
        DecorSetInt(entity,  "ViewPropOwner", owner)
        DecorSetBool(entity, "IsViewProp",    true)
        DecorSetInt(entity,  "PropId",        propId)

        SetPropOwner(entity, owner)

        -- Store in tracking table
        local actualCoords = GetEntityCoords(entity)
        placedPropsById[propId] = {
            entity   = entity,
            model    = model,
            owner    = owner,
            viewOnly = true,
            coords   = actualCoords,
        }

        if Config.Debug then
            print("Client created view-only prop: " .. model ..
                  " with ID: " .. propId ..
                  " owned by: " .. tostring(owner))
        end

        -- Determine prop type and set up interaction (view-only props still show the menu)
        local propKey, propConfig, propCategory = nil, nil, nil

        for key, cfg in pairs(Config.CookingProps) do
            if cfg.model == model then
                propKey      = key
                propConfig   = cfg
                propCategory = "cooking"
                if Config.Debug then print("View-only prop is a cooking prop: " .. key) end
                break
            end
        end

        if not propKey then
            for key, cfg in pairs(Config.DecorationProps) do
                if cfg.model == model then
                    propKey      = key
                    propConfig   = cfg
                    propCategory = "decoration"
                    if Config.Debug then print("View-only prop is a decoration prop: " .. key) end
                    break
                end
            end
        end

        if propCategory == "cooking" and propKey and propConfig then
            if Config.Debug then
                print("Setting up cooking prop interaction for view-only prop: " .. propKey)
            end
            SetupCookingPropInteraction(entity, propKey, propConfig)
        elseif propCategory == "decoration" and propKey and propConfig then
            if Config.Debug then
                print("Setting up decoration prop interaction for view-only prop: " .. propKey)
            end
            SetupDecorationPropInteraction(entity, propKey, propConfig)
        else
            print("Warning: Could not determine prop type for view-only interaction setup")
        end

        unloadModel(modelHash)
        return true
    else
        print("Failed to create view-only entity")
        unloadModel(modelHash)
        return false
    end
end

-- --- lib.callback: createViewOnlyProp -----------------------
lib.callback.register("flake_cooking:client:createViewOnlyProp", function(model, coords, rotation, owner, propId)
    return createViewOnlyProp(model, coords, rotation, owner, propId)
end)

-- --- RegisterNetEvent: createViewOnlyProp -------------------
RegisterNetEvent("flake_cooking:client:createViewOnlyProp")
AddEventHandler("flake_cooking:client:createViewOnlyProp", function(model, coords, rotation, owner, propId)
    createViewOnlyProp(model, coords, rotation, owner, propId)
end)

-- --- Helper: delete a prop entity robustly ------------------
-- Tries DeleteEntity; if it stubbornly persists, teleports it
-- underground and hides it before trying once more.
local function deletePropEntity(propEntry, propId)
    local entity = propEntry.entity
    SetEntityAsMissionEntity(entity, true, true)
    DeleteEntity(entity)

    if DoesEntityExist(entity) then
        SetEntityCoords(entity, 0, 0, -1000.0)
        SetEntityVisible(entity, false)
        DeleteEntity(entity)
    end

    placedPropsById[propId] = nil
end

-- --- lib.callback: deletePropById ---------------------------
lib.callback.register("flake_cooking:client:deletePropById", function(propId)
    if not propId then return false end

    if Config.Debug then
        print("Received request to delete prop with ID: " .. propId)
    end

    local propEntry = placedPropsById[propId]
    if propEntry and propEntry.entity then
        if DoesEntityExist(propEntry.entity) then
            if Config.Debug then print("Found prop to delete, removing entity") end
            deletePropEntity(propEntry, propId)
            return true
        end
    else
        print("Could not find prop with ID: " .. propId)
        return false
    end
end)

-- --- RegisterNetEvent: deletePropById -----------------------
RegisterNetEvent("flake_cooking:client:deletePropById")
AddEventHandler("flake_cooking:client:deletePropById", function(propId)
    if not propId then return end

    if Config.Debug then
        print("Received event to delete prop with ID: " .. propId)
    end

    local propEntry = placedPropsById[propId]
    if propEntry and propEntry.entity then
        if DoesEntityExist(propEntry.entity) then
            if Config.Debug then print("Found prop to delete via event, removing entity") end

            SetEntityAsMissionEntity(propEntry.entity, true, true)
            DeleteEntity(propEntry.entity)

            if DoesEntityExist(propEntry.entity) then
                SetEntityCoords(propEntry.entity, 0, 0, -1000.0)
                SetEntityVisible(propEntry.entity, false)
                DeleteEntity(propEntry.entity)
            end

            placedPropsById[propId] = nil
        end
    else
        print("Could not find prop with ID: " .. propId)
    end
end)

-- --- lib.callback: deleteEntityByNetId ----------------------
-- Deletes an entity by its network id.  Falls back to scanning
-- the CObject game pool when the direct network lookup fails.
lib.callback.register("flake_cooking:client:deleteEntityByNetId", function(netId)
    if not netId or netId <= 0 then return false end

    if Config.Debug then
        print("Received request to delete entity with netId: " .. netId)
    end

    -- Direct network lookup
    if NetworkDoesNetworkIdExist(netId) then
        local entity = NetworkGetEntityFromNetworkId(netId)
        if DoesEntityExist(entity) then
            if Config.Debug then print("Found entity to delete by netId") end

            SetEntityAsMissionEntity(entity, true, true)
            DeleteEntity(entity)

            if DoesEntityExist(entity) then
                SetEntityCoords(entity, 0, 0, -1000.0)
                SetEntityVisible(entity, false)
                SetEntityCollision(entity, false, false)
                DeleteEntity(entity)
            end

            return true
        end
    end

    -- Fallback: search CObject pool for a placed prop with matching netId
    local pool = GetGamePool("CObject")
    for _, obj in ipairs(pool) do
        if DoesEntityExist(obj) then
            if DecorGetBool(obj, "IsPlacedProp") then
                local objNetId = NetworkGetNetworkIdFromEntity(obj)
                if objNetId == netId then
                    if Config.Debug then print("Found matching entity through game pool") end
                    SetEntityAsMissionEntity(obj, true, true)
                    DeleteEntity(obj)
                    return true
                end
            end
        end
    end

    return false
end)

-- --- RegisterNetEvent: deleteEntityByNetId ------------------
RegisterNetEvent("flake_cooking:client:deleteEntityByNetId")
AddEventHandler("flake_cooking:client:deleteEntityByNetId", function(netId)
    if not netId or netId <= 0 then return end

    if Config.Debug then
        print("Received event to delete entity with netId: " .. netId)
    end

    -- Direct network lookup
    if NetworkDoesNetworkIdExist(netId) then
        local entity = NetworkGetEntityFromNetworkId(netId)
        if DoesEntityExist(entity) then
            if Config.Debug then print("Found entity to delete by netId via event") end

            SetEntityAsMissionEntity(entity, true, true)
            DeleteEntity(entity)

            if DoesEntityExist(entity) then
                SetEntityCoords(entity, 0, 0, -1000.0)
                SetEntityVisible(entity, false)
                SetEntityCollision(entity, false, false)
                DeleteEntity(entity)
            end

            return
        end
    end

    -- Fallback: search CObject pool
    local pool = GetGamePool("CObject")
    for _, obj in ipairs(pool) do
        if DoesEntityExist(obj) then
            if DecorGetBool(obj, "IsPlacedProp") then
                local objNetId = NetworkGetNetworkIdFromEntity(obj)
                if objNetId == netId then
                    if Config.Debug then print("Found matching entity through game pool via event") end
                    SetEntityAsMissionEntity(obj, true, true)
                    DeleteEntity(obj)
                    return
                end
            end
        end
    end
end)

-- --- onResourceStop cleanup ---------------------------------
AddEventHandler("onResourceStop", function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end

    lib.hideTextUI()

    -- Clean up gizmo entity if still alive
    if placingEntity and DoesEntityExist(placingEntity) then
        DeleteEntity(placingEntity)
        placingEntity = nil
    end

    -- Delete all tracked props
    for propId, propEntry in pairs(placedPropsById) do
        if propEntry.entity and DoesEntityExist(propEntry.entity) then
            SetEntityAsMissionEntity(propEntry.entity, true, true)
            DeleteEntity(propEntry.entity)
        end
    end

    placedPropsById = {}
end)

-- --- Startup thread - register decorators & setup targets ---
CreateThread(function()
    -- Register "PropOwner" decorator (type 3 = INT)
    if not DecorIsRegisteredAsType("PropOwner", 3) then
        DecorRegister("PropOwner", 3)
    end
    -- Register "IsPlacedProp" decorator (type 2 = BOOL)
    if not DecorIsRegisteredAsType("IsPlacedProp", 2) then
        DecorRegister("IsPlacedProp", 2)
    end

    Wait(1000)
    SetupTargetInteractions()
end)

-- --- SetupTargetInteractions --------------------------------
-- Iterates the CObject game pool and attaches ox_target
-- interaction zones to any already-spawned placed props.
function SetupTargetInteractions()
    if Config.Debug then
        print("Setting up target interactions for props")
    end

    if not Config.CookingProps then
        print("Warning: Config.CookingProps is not defined")
        return
    end

    local pool = GetGamePool("CObject")

    -- Cooking props
    if Config.Debug then print("Setting up cooking prop interactions") end
    for i = 1, #pool do
        local obj = pool[i]
        if DoesEntityExist(obj) and DecorGetBool(obj, "IsPlacedProp") then
            local objModelHash = GetEntityModel(obj)
            for propKey, propCfg in pairs(Config.CookingProps) do
                if joaat(propCfg.model) == objModelHash then
                    print("Found cooking prop: " .. propKey)
                    SetupCookingPropInteraction(obj, propKey, propCfg)
                    break
                end
            end
        end
    end

    -- Decoration props
    if Config.Debug then print("Setting up decoration prop interactions") end
    for i = 1, #pool do
        local obj = pool[i]
        if DoesEntityExist(obj) and DecorGetBool(obj, "IsPlacedProp") then
            local objModelHash = GetEntityModel(obj)
            for propKey, propCfg in pairs(Config.DecorationProps) do
                if joaat(propCfg.model) == objModelHash then
                    if Config.Debug then print("Found decoration prop: " .. propKey) end
                    SetupDecorationPropInteraction(obj, propKey, propCfg)
                    break
                end
            end
        end
    end

    if Config.Debug then print("Target interactions setup complete") end
end

-- --- RegisterNetEvent: registerTargetForModel ---------------
-- Registers ox_target interactions for all existing world
-- instances of the specified model.
RegisterNetEvent("flake_cooking:client:registerTargetForModel")
AddEventHandler("flake_cooking:client:registerTargetForModel", function(model)
    if not model then return end

    local propKey, propConfig, propCategory = nil, nil, nil

    for key, cfg in pairs(Config.CookingProps) do
        if cfg.model == model then
            propKey      = key
            propConfig   = cfg
            propCategory = "cooking"
            break
        end
    end

    if not propKey then
        for key, cfg in pairs(Config.DecorationProps) do
            if cfg.model == model then
                propKey      = key
                propConfig   = cfg
                propCategory = "decoration"
                break
            end
        end
    end

    if not propConfig then
        print("No prop data found for model: " .. model)
        return
    end

    local modelHash = joaat(model)

    if Config.Debug then
        print("Registering ox_target for specific model: " .. model .. " (" .. propCategory .. ")")
    end

    -- Apply to all matching world objects
    local pool = GetGamePool("CObject")
    for i = 1, #pool do
        local obj = pool[i]
        if DoesEntityExist(obj) then
            if GetEntityModel(obj) == modelHash then
                if DecorGetBool(obj, "IsPlacedProp") then
                    if propCategory == "cooking" then
                        SetupCookingPropInteraction(obj, propKey, propConfig)
                    elseif propCategory == "decoration" then
                        SetupDecorationPropInteraction(obj, propKey, propConfig)
                    end
                end
            end
        end
    end
end)

-- --- TryPickupNearbyProp ------------------------------------
-- Determines the prop type from the entity's model hash and
-- calls PickUpProp with the relevant config data.
function TryPickupNearbyProp(entity)
    if not entity or not DoesEntityExist(entity) then
        print("No valid entity provided to TryPickupNearbyProp")
        return false
    end

    local entityModelHash = GetEntityModel(entity)
    local propKey, propConfig, propCategory = nil, nil, nil

    if Config.Debug then
        print("DEBUG - Entity model hash to pick up: " .. tostring(entityModelHash))
    end

    -- Check cooking props
    for key, cfg in pairs(Config.CookingProps) do
        local hash = joaat(cfg.model)
        if Config.Debug then
            print("DEBUG - Checking cooking prop " .. key .. " with model hash: " .. tostring(hash))
        end
        if hash == entityModelHash then
            propKey      = key
            propConfig   = cfg
            propCategory = "cooking"
            if Config.Debug then print("DEBUG - Found matching cooking prop: " .. key) end
            break
        end
    end

    -- Check decoration props if not found
    if not propKey then
        for key, cfg in pairs(Config.DecorationProps) do
            local hash = joaat(cfg.model)
            if Config.Debug then
                print("DEBUG - Checking decoration prop " .. key .. " with model hash: " .. tostring(hash))
            end
            if hash == entityModelHash then
                propKey      = key
                propConfig   = cfg
                propCategory = "decoration"
                if Config.Debug then print("DEBUG - Found matching decoration prop: " .. key) end
                break
            end
        end
    end

    if not propKey or not propConfig then
        print("Could not determine prop type from model hash: " .. tostring(entityModelHash))
        return false
    end

    -- Gather ownership info for debug
    local decorOwner   = DecorGetInt(entity, "PropOwner")
    local entityOwner  = GetPropOwner(entity)
    local localPlayer  = GetPlayerServerId(PlayerId())

    if Config.Debug then
        print("DEBUG - Prop ownership:")
        print("- Decor owner: "      .. tostring(decorOwner))
        print("- Entity state owner: " .. tostring(entityOwner))
        print("- Current player: "   .. tostring(localPlayer))
        print("- Picking up prop type: " .. tostring(propKey) .. " with model: " .. tostring(propConfig.model))
        print("- Prop category: "    .. tostring(propCategory))
    end

    PickUpProp(entity, propKey, propConfig)
    return true
end

-- --- UseProp ------------------------------------------------
-- Finds the cooking prop config from the entity's model and
-- calls OpenCookingMenu.
function UseProp(entity)
    if not entity or not DoesEntityExist(entity) then
        print("No valid entity provided to UseProp")
        return false
    end

    local entityModelHash = GetEntityModel(entity)
    local propKey, propConfig = nil, nil

    for key, cfg in pairs(Config.CookingProps) do
        if joaat(cfg.model) == entityModelHash then
            propKey    = key
            propConfig = cfg
            break
        end
    end

    if not propKey or not propConfig then
        print("Could not determine prop type from model")
        return false
    end

    print("Using prop: " .. propKey .. " (" .. propConfig.label .. ")")
    OpenCookingMenu(entity, propKey, propConfig)
    return true
end

-- --- Debug commands (Config.Debug only) ---------------------
if Config.Debug then
    -- /cleanupprops [radius]
    -- Deletes tracked props and loose world props within `radius` metres.
    RegisterCommand("cleanupprops", function(source, args, rawCommand)
        local radius = tonumber(args[1]) or 5.0
        local playerCoords = GetEntityCoords(PlayerPedId())
        local worldRemoved   = 0
        local trackedRemoved = 0

        -- Remove tracked props within radius
        for propId, propEntry in pairs(placedPropsById) do
            if propEntry.entity then
                if DoesEntityExist(propEntry.entity) then
                    local dist = #(playerCoords - GetEntityCoords(propEntry.entity))
                    if dist < radius then
                        SetEntityAsMissionEntity(propEntry.entity, true, true)
                        DeleteEntity(propEntry.entity)
                        placedPropsById[propId] = nil
                        trackedRemoved = trackedRemoved + 1
                    end
                else
                    placedPropsById[propId] = nil
                end
            end
        end

        -- Remove untracked world props (cooking props only) within radius
        local pool = GetGamePool("CObject")
        for _, obj in ipairs(pool) do
            if DoesEntityExist(obj) then
                local dist = #(playerCoords - GetEntityCoords(obj))
                if dist < radius then
                    local objModelHash = GetEntityModel(obj)
                    local isCookingProp = false
                    for _, cfg in pairs(Config.CookingProps) do
                        if joaat(cfg.model) == objModelHash then
                            isCookingProp = true
                            break
                        end
                    end
                    if isCookingProp then
                        SetEntityAsMissionEntity(obj, true, true)
                        DeleteEntity(obj)
                        worldRemoved = worldRemoved + 1
                    end
                end
            end
        end

        lib.notify({
            title       = "Prop Cleanup",
            description = "Removed " .. worldRemoved .. " props from world and " .. trackedRemoved .. " from tracking",
            type        = "success",
        })
    end, false)

    -- /clearplacement
    -- Manually clears a stuck placement lock.
    RegisterCommand("clearplacement", function()
        ClearPlacementLock()
        lib.notify({
            title       = "Placement Lock",
            description = "Placement lock has been cleared",
            type        = "success",
        })
    end, false)
end
