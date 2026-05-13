local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1
L0_1 = false
L1_1 = nil
L2_1 = nil
L3_1 = 0
L4_1 = 2000
L5_1 = 0
L6_1 = 500
L7_1 = false
L8_1 = false
L9_1 = nil
L10_1 = GetEntityCoords
L11_1 = PlayerPedId
L12_1 = DoesEntityExist
L13_1 = DeleteEntity
L14_1 = HasModelLoaded
L15_1 = RequestModel
L16_1 = joaat
L17_1 = {}
function L18_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  if A0_2 then
    L1_2 = L12_1
    L2_2 = A0_2
    L1_2 = L1_2(L2_2)
    if L1_2 then
      goto lbl_10
    end
  end
  L1_2 = nil
  do return L1_2 end
  ::lbl_10::
  L1_2 = pairs
  L2_2 = L17_1
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = L6_2.entity
    if L7_2 == A0_2 then
      return L5_2
    end
  end
  L1_2 = nil
  return L1_2
end
GetPropIdByEntity = L18_1
L18_1 = AddEventHandler
L19_1 = "gameEventTriggered"
function L20_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  if "CEventNetworkEntityDamage" ~= A0_2 then
    return
  end
  L2_2 = A1_2[1]
  L3_2 = L11_1
  L3_2 = L3_2()
  if L2_2 == L3_2 then
    L4_2 = true
    L8_1 = L4_2
    L4_2 = L0_1
    if L4_2 then
      L4_2 = CancelPlacementDueToInjury
      L4_2()
    end
    L4_2 = SetTimeout
    L5_2 = 1000
    function L6_2()
      local L0_3, L1_3
      L0_3 = false
      L8_1 = L0_3
    end
    L4_2(L5_2, L6_2)
  end
end
L18_1(L19_1, L20_1)
function L18_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = {}
  L2_2 = math
  L2_2 = L2_2.pi
  L2_2 = L2_2 / 180
  L3_2 = A0_2.x
  L2_2 = L2_2 * L3_2
  L1_2.x = L2_2
  L2_2 = math
  L2_2 = L2_2.pi
  L2_2 = L2_2 / 180
  L3_2 = A0_2.y
  L2_2 = L2_2 * L3_2
  L1_2.y = L2_2
  L2_2 = math
  L2_2 = L2_2.pi
  L2_2 = L2_2 / 180
  L3_2 = A0_2.z
  L2_2 = L2_2 * L3_2
  L1_2.z = L2_2
  L2_2 = {}
  L3_2 = math
  L3_2 = L3_2.sin
  L4_2 = L1_2.z
  L3_2 = L3_2(L4_2)
  L3_2 = -L3_2
  L4_2 = math
  L4_2 = L4_2.abs
  L5_2 = math
  L5_2 = L5_2.cos
  L6_2 = L1_2.x
  L5_2, L6_2 = L5_2(L6_2)
  L4_2 = L4_2(L5_2, L6_2)
  L3_2 = L3_2 * L4_2
  L2_2.x = L3_2
  L3_2 = math
  L3_2 = L3_2.cos
  L4_2 = L1_2.z
  L3_2 = L3_2(L4_2)
  L4_2 = math
  L4_2 = L4_2.abs
  L5_2 = math
  L5_2 = L5_2.cos
  L6_2 = L1_2.x
  L5_2, L6_2 = L5_2(L6_2)
  L4_2 = L4_2(L5_2, L6_2)
  L3_2 = L3_2 * L4_2
  L2_2.y = L3_2
  L3_2 = math
  L3_2 = L3_2.sin
  L4_2 = L1_2.x
  L3_2 = L3_2(L4_2)
  L2_2.z = L3_2
  return L2_2
end
RotationToDirection = L18_1
function L18_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L1_2 = GetGameplayCamRot
  L1_2 = L1_2()
  L2_2 = GetGameplayCamCoord
  L2_2 = L2_2()
  L3_2 = RotationToDirection
  L4_2 = L1_2
  L3_2 = L3_2(L4_2)
  L4_2 = {}
  L5_2 = L2_2.x
  L6_2 = L3_2.x
  L6_2 = L6_2 * A0_2
  L5_2 = L5_2 + L6_2
  L4_2.x = L5_2
  L5_2 = L2_2.y
  L6_2 = L3_2.y
  L6_2 = L6_2 * A0_2
  L5_2 = L5_2 + L6_2
  L4_2.y = L5_2
  L5_2 = L2_2.z
  L6_2 = L3_2.z
  L6_2 = L6_2 * A0_2
  L5_2 = L5_2 + L6_2
  L4_2.z = L5_2
  L5_2 = GetShapeTestResult
  L6_2 = StartShapeTestRay
  L7_2 = L2_2.x
  L8_2 = L2_2.y
  L9_2 = L2_2.z
  L10_2 = L4_2.x
  L11_2 = L4_2.y
  L12_2 = L4_2.z
  L13_2 = -1
  L14_2 = L11_1
  L14_2 = L14_2()
  L15_2 = 0
  L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  L5_2, L6_2, L7_2, L8_2, L9_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  L10_2 = L6_2
  L11_2 = L7_2
  L12_2 = L9_2
  return L10_2, L11_2, L12_2
end
RayCastGamePlayCamera = L18_1
function L18_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  L1_2 = GetEntityMatrix
  L2_2 = A0_2
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  L5_2 = L2_2 * 1.0
  L5_2 = L4_2 + L5_2
  L6_2 = L1_2 * 1.0
  L6_2 = L4_2 + L6_2
  L7_2 = L3_2 * 1.0
  L7_2 = L4_2 + L7_2
  L8_2 = DrawLine
  L9_2 = L4_2.x
  L10_2 = L4_2.y
  L11_2 = L4_2.z
  L11_2 = L11_2 + 0.1
  L12_2 = L5_2.x
  L13_2 = L5_2.y
  L14_2 = L5_2.z
  L15_2 = 255
  L16_2 = 0
  L17_2 = 0
  L18_2 = 255
  L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  L8_2 = DrawLine
  L9_2 = L4_2.x
  L10_2 = L4_2.y
  L11_2 = L4_2.z
  L11_2 = L11_2 + 0.1
  L12_2 = L6_2.x
  L13_2 = L6_2.y
  L14_2 = L6_2.z
  L15_2 = 0
  L16_2 = 255
  L17_2 = 0
  L18_2 = 255
  L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  L8_2 = DrawLine
  L9_2 = L4_2.x
  L10_2 = L4_2.y
  L11_2 = L4_2.z
  L11_2 = L11_2 + 0.1
  L12_2 = L7_2.x
  L13_2 = L7_2.y
  L14_2 = L7_2.z
  L15_2 = 0
  L16_2 = 0
  L17_2 = 255
  L18_2 = 255
  L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
end
DrawPropAxes = L18_1
function L18_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = Config
  L1_2 = L1_2.Debug
  if L1_2 then
    L1_2 = print
    L2_2 = "^3[fsg_cooking]^7: Loading model: "
    L3_2 = tostring
    L4_2 = A0_2
    L3_2 = L3_2(L4_2)
    L2_2 = L2_2 .. L3_2
    L1_2(L2_2)
  end
  L1_2 = lib
  if L1_2 then
    L1_2 = lib
    L1_2 = L1_2.requestModel
    if L1_2 then
      L1_2 = lib
      L1_2 = L1_2.requestModel
      L2_2 = A0_2
      L3_2 = 1000
      return L1_2(L2_2, L3_2)
  end
  else
    L1_2 = L14_1
    L2_2 = A0_2
    L1_2 = L1_2(L2_2)
    if not L1_2 then
      L1_2 = L15_1
      L2_2 = A0_2
      L1_2(L2_2)
      L1_2 = GetGameTimer
      L1_2 = L1_2()
      L1_2 = L1_2 + 5000
      while true do
        L2_2 = L14_1
        L3_2 = A0_2
        L2_2 = L2_2(L3_2)
        if L2_2 then
          break
        end
        L2_2 = GetGameTimer
        L2_2 = L2_2()
        if not (L1_2 > L2_2) then
          break
        end
        L2_2 = Wait
        L3_2 = 10
        L2_2(L3_2)
      end
      L2_2 = L14_1
      L3_2 = A0_2
      L2_2 = L2_2(L3_2)
      if not L2_2 then
        L2_2 = print
        L3_2 = "^1[fsg_cooking]^7: Failed to load model: "
        L4_2 = tostring
        L5_2 = A0_2
        L4_2 = L4_2(L5_2)
        L3_2 = L3_2 .. L4_2
        L2_2(L3_2)
        L2_2 = false
        return L2_2
      end
    end
    L1_2 = true
    return L1_2
  end
end
loadModel = L18_1
function L18_1(A0_2)
  local L1_2, L2_2
  L1_2 = SetModelAsNoLongerNeeded
  L2_2 = A0_2
  L1_2(L2_2)
end
unloadModel = L18_1
function L18_1()
  local L0_2, L1_2, L2_2
  L0_2 = L11_1
  L0_2 = L0_2()
  L1_2 = IsPedSwimming
  L2_2 = L0_2
  L1_2 = L1_2(L2_2)
  L2_2 = L8_1
  if not L2_2 then
    L2_2 = L1_2
  end
  return L2_2
end
IsPlayerInjured = L18_1
function L18_1()
  local L0_2, L1_2, L2_2
  L0_2 = L11_1
  L0_2 = L0_2()
  L1_2 = IsPedSwimming
  L2_2 = L0_2
  L1_2 = L1_2(L2_2)
  return L1_2
end
IsPlayerInInvalidState = L18_1
function L18_1()
  local L0_2, L1_2
  L0_2 = L12_1
  L1_2 = L2_1
  L0_2 = L0_2(L1_2)
  if L0_2 then
    L0_2 = L13_1
    L1_2 = L2_1
    L0_2(L1_2)
  end
  L0_2 = nil
  L2_1 = L0_2
  L0_2 = false
  L0_1 = L0_2
  L0_2 = nil
  L1_1 = L0_2
  L0_2 = false
  L7_1 = L0_2
  L0_2 = lib
  L0_2 = L0_2.hideTextUI
  L0_2()
  L0_2 = lib
  L0_2 = L0_2.notify
  L1_2 = {}
  L1_2.title = "Cancelled"
  L1_2.description = "Prop placement cancelled due to injury"
  L1_2.type = "error"
  L0_2(L1_2)
end
CancelPlacementDueToInjury = L18_1
function L18_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2
  L1_2 = L7_1
  if L1_2 then
    L1_2 = lib
    L1_2 = L1_2.notify
    L2_2 = {}
    L2_2.title = "Please Wait"
    L2_2.description = "A prop placement is already in progress"
    L2_2.type = "error"
    L1_2(L2_2)
    return
  end
  L1_2 = IsPlayerInInvalidState
  L1_2 = L1_2()
  if L1_2 then
    L1_2 = lib
    L1_2 = L1_2.notify
    L2_2 = {}
    L2_2.title = "Cannot Place Prop"
    L2_2.description = "You cannot place props while swimming"
    L2_2.type = "error"
    L1_2(L2_2)
    return
  end
  L1_2 = GetGameTimer
  L1_2 = L1_2()
  L2_2 = L3_1
  L2_2 = L1_2 - L2_2
  L3_2 = L4_1
  if L2_2 < L3_2 then
    L2_2 = math
    L2_2 = L2_2.ceil
    L3_2 = L4_1
    L4_2 = L3_1
    L4_2 = L1_2 - L4_2
    L3_2 = L3_2 - L4_2
    L3_2 = L3_2 / 1000
    L2_2 = L2_2(L3_2)
    L3_2 = lib
    L3_2 = L3_2.notify
    L4_2 = {}
    L4_2.title = "Please Wait"
    L5_2 = "You need to wait "
    L6_2 = L2_2
    L7_2 = " seconds before placing another prop"
    L5_2 = L5_2 .. L6_2 .. L7_2
    L4_2.description = L5_2
    L4_2.type = "error"
    L3_2(L4_2)
    return
  end
  L2_2 = Config
  L2_2 = L2_2.Debug
  if L2_2 then
    L2_2 = print
    L3_2 = "^3[fsg_cooking]^7: Setting placementLock to true"
    L2_2(L3_2)
  end
  L2_2 = true
  L7_1 = L2_2
  L2_2 = Config
  L2_2 = L2_2.GetPropByItem
  L3_2 = A0_2
  L2_2, L3_2 = L2_2(L3_2)
  if not L2_2 then
    L4_2 = Config
    L4_2 = L4_2.Debug
    if L4_2 then
      L4_2 = print
      L5_2 = "^3[fsg_cooking]^7: Clearing placementLock due to invalid prop type"
      L4_2(L5_2)
    end
    L4_2 = false
    L7_1 = L4_2
    return
  end
  L1_1 = L3_2
  L4_2 = true
  L0_1 = L4_2
  L4_2 = L16_1
  L5_2 = L1_1.model
  L4_2 = L4_2(L5_2)
  L5_2 = loadModel
  L6_2 = L4_2
  L5_2 = L5_2(L6_2)
  if not L5_2 then
    L5_2 = lib
    L5_2 = L5_2.notify
    L6_2 = {}
    L6_2.title = "Error"
    L6_2.description = "Failed to load prop model"
    L6_2.type = "error"
    L5_2(L6_2)
    L5_2 = false
    L0_1 = L5_2
    L5_2 = nil
    L1_1 = L5_2
    L5_2 = false
    L7_1 = L5_2
    return
  end
  L5_2 = RayCastGamePlayCamera
  L6_2 = 1000.0
  L5_2, L6_2, L7_2 = L5_2(L6_2)
  if not L5_2 then
    L8_2 = 0
    while not L5_2 and L8_2 < 10 do
      L9_2 = RayCastGamePlayCamera
      L10_2 = 1000.0
      L9_2, L10_2, L11_2 = L9_2(L10_2)
      L7_2 = L11_2
      L6_2 = L10_2
      L5_2 = L9_2
      L9_2 = Wait
      L10_2 = 100
      L9_2(L10_2)
      L8_2 = L8_2 + 1
    end
    if not L5_2 then
      L9_2 = lib
      L9_2 = L9_2.notify
      L10_2 = {}
      L10_2.title = "Error"
      L10_2.description = "Could not find a valid placement location"
      L10_2.type = "error"
      L9_2(L10_2)
      L9_2 = false
      L0_1 = L9_2
      L9_2 = nil
      L1_1 = L9_2
      L9_2 = false
      L7_1 = L9_2
      return
    end
  end
  L8_2 = L10_1
  L9_2 = cache
  L9_2 = L9_2.ped
  L8_2 = L8_2(L9_2)
  L9_2 = GetEntityForwardVector
  L10_2 = cache
  L10_2 = L10_2.ped
  L9_2 = L9_2(L10_2)
  L9_2 = L9_2 * 3
  L8_2 = L8_2 + L9_2
  L9_2 = CreateObject
  L10_2 = L4_2
  L11_2 = L8_2.x
  L12_2 = L8_2.y
  L13_2 = L8_2.z
  L14_2 = false
  L15_2 = false
  L16_2 = false
  L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
  if not L9_2 or 0 == L9_2 then
    L10_2 = lib
    L10_2 = L10_2.notify
    L11_2 = {}
    L11_2.title = "Error"
    L11_2.description = "Failed to create object"
    L11_2.type = "error"
    L10_2(L11_2)
    L10_2 = false
    L7_1 = L10_2
    return
  end
  L10_2 = Config
  L10_2 = L10_2.Debug
  if L10_2 then
    L10_2 = print
    L11_2 = "^5[GIZMO OBJECT CREATED]^7 Entity:"
    L12_2 = L9_2
    L13_2 = "Model:"
    L14_2 = L1_1.model
    L10_2(L11_2, L12_2, L13_2, L14_2)
  end
  L10_2 = NetworkSetEntityInvisibleToNetwork
  L11_2 = L9_2
  L12_2 = true
  L10_2(L11_2, L12_2)
  L10_2 = SetEntityCollision
  L11_2 = L9_2
  L12_2 = true
  L13_2 = true
  L10_2(L11_2, L12_2, L13_2)
  L10_2 = FreezeEntityPosition
  L11_2 = L9_2
  L12_2 = true
  L10_2(L11_2, L12_2)
  L10_2 = Config
  L10_2 = L10_2.Debug
  if L10_2 then
    L10_2 = print
    L11_2 = "^5[GIZMO OBJECT FROZEN]^7 Entity:"
    L12_2 = L9_2
    L10_2(L11_2, L12_2)
  end
  L10_2 = Config
  L10_2 = L10_2.Debug
  if L10_2 then
    L10_2 = print
    L11_2 = "^5[DEBUG]^7 About to start gizmo interaction"
    L10_2(L11_2)
  end
  L10_2 = pcall
  function L11_2()
    local L0_3, L1_3, L2_3
    L0_3 = exports
    L0_3 = L0_3.object_gizmo
    L1_3 = L0_3
    L0_3 = L0_3.useGizmo
    L2_3 = L9_2
    return L0_3(L1_3, L2_3)
  end
  L10_2, L11_2 = L10_2(L11_2)
  L12_2 = Config
  L12_2 = L12_2.Debug
  if L12_2 then
    L12_2 = print
    L13_2 = "^5[DEBUG]^7 Gizmo pcall success:"
    L14_2 = L10_2
    L12_2(L13_2, L14_2)
    L12_2 = print
    L13_2 = "^5[DEBUG]^7 Gizmo returned data:"
    if L11_2 then
      L14_2 = "YES"
      if L14_2 then
        goto lbl_241
      end
    end
    L14_2 = "NO"
    ::lbl_241::
    L12_2(L13_2, L14_2)
    if L11_2 and L10_2 then
      L12_2 = print
      L13_2 = "^5[DEBUG]^7 Data contents:"
      L14_2 = json
      L14_2 = L14_2.encode
      L15_2 = L11_2
      L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2 = L14_2(L15_2)
      L12_2(L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
    end
  end
  if not L10_2 then
    L12_2 = Config
    L12_2 = L12_2.Debug
    if L12_2 then
      L12_2 = print
      L13_2 = "^1[DEBUG]^7 Gizmo error:"
      L14_2 = L11_2
      L12_2(L13_2, L14_2)
    end
    L12_2 = lib
    L12_2 = L12_2.notify
    L13_2 = {}
    L13_2.title = "Error"
    L13_2.description = "Gizmo interaction failed"
    L13_2.type = "error"
    L12_2(L13_2)
    L12_2 = L13_1
    L13_2 = L9_2
    L12_2(L13_2)
    L12_2 = false
    L0_1 = L12_2
    L12_2 = nil
    L1_1 = L12_2
    L12_2 = false
    L7_1 = L12_2
    return
  end
  if L11_2 then
    L12_2 = L10_1
    L13_2 = L9_2
    L12_2 = L12_2(L13_2)
    L13_2 = GetEntityRotation
    L14_2 = L9_2
    L13_2 = L13_2(L14_2)
    L14_2 = Config
    L14_2 = L14_2.Debug
    if L14_2 then
      L14_2 = print
      L15_2 = "^3[fsg_cooking]^7: Gizmo data received:"
      L16_2 = json
      L16_2 = L16_2.encode
      L17_2 = L11_2
      L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2 = L16_2(L17_2)
      L14_2(L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
      L14_2 = print
      L15_2 = "^3[fsg_cooking]^7: Actual object coords:"
      L16_2 = L12_2
      L14_2(L15_2, L16_2)
      L14_2 = print
      L15_2 = "^3[fsg_cooking]^7: Actual object rotation:"
      L16_2 = L13_2
      L14_2(L15_2, L16_2)
    end
    L11_2.position = L12_2
    L11_2.rotation = L13_2
    L14_2 = L1_1.animation
    if L14_2 then
      L14_2 = lib
      L14_2 = L14_2.requestAnimDict
      L15_2 = L1_1.animation
      L15_2 = L15_2.dict
      L14_2(L15_2)
      L14_2 = TaskPlayAnim
      L15_2 = L11_1
      L15_2 = L15_2()
      L16_2 = L1_1.animation
      L16_2 = L16_2.dict
      L17_2 = L1_1.animation
      L17_2 = L17_2.clip
      L18_2 = 8.0
      L19_2 = -8.0
      L20_2 = -1
      L21_2 = 0
      L22_2 = 0
      L23_2 = false
      L24_2 = false
      L25_2 = false
      L14_2(L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
    end
    L14_2 = Config
    L14_2 = L14_2.Debug
    if L14_2 then
      L14_2 = print
      L15_2 = "^5[DEBUG]^7 Creating placement progress bar coroutine"
      L14_2(L15_2)
    end
    L14_2 = coroutine
    L14_2 = L14_2.create
    function L15_2()
      local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3
      L0_3 = Config
      L0_3 = L0_3.Debug
      if L0_3 then
        L0_3 = print
        L1_3 = "^5[DEBUG]^7 Starting progress circle"
        L0_3(L1_3)
      end
      L0_3 = pcall
      function L1_3()
        local L0_4, L1_4, L2_4, L3_4
        L0_4 = lib
        L0_4 = L0_4.progressCircle
        L1_4 = {}
        L1_4.duration = 2000
        L2_4 = "Placing "
        L3_4 = L1_1.label
        L2_4 = L2_4 .. L3_4
        L1_4.label = L2_4
        L1_4.useWhileDead = false
        L1_4.canCancel = false
        L2_4 = {}
        L2_4.car = true
        L2_4.move = true
        L2_4.combat = true
        L1_4.disable = L2_4
        L2_4 = {}
        L3_4 = L1_1.animation
        L3_4 = L3_4.dict
        L2_4.dict = L3_4
        L3_4 = L1_1.animation
        L3_4 = L3_4.clip
        L2_4.clip = L3_4
        L1_4.anim = L2_4
        return L0_4(L1_4)
      end
      L0_3, L1_3 = L0_3(L1_3)
      L2_3 = Config
      L2_3 = L2_3.Debug
      if L2_3 then
        L2_3 = print
        L3_3 = "^5[DEBUG]^7 Progress circle pcall success:"
        L4_3 = L0_3
        L2_3(L3_3, L4_3)
        L2_3 = print
        L3_3 = "^5[DEBUG]^7 Progress circle returned:"
        L4_3 = L1_3
        L2_3(L3_3, L4_3)
        L2_3 = print
        L3_3 = "^5[DEBUG]^7 Progress result type:"
        L4_3 = type
        L5_3 = L1_3
        L4_3, L5_3 = L4_3(L5_3)
        L2_3(L3_3, L4_3, L5_3)
      end
      if not L0_3 then
        L2_3 = Config
        L2_3 = L2_3.Debug
        if L2_3 then
          L2_3 = print
          L3_3 = "^1[DEBUG]^7 Progress circle error:"
          L4_3 = L1_3
          L2_3(L3_3, L4_3)
          L2_3 = print
          L3_3 = "^3[DEBUG]^7 Attempting to continue despite error (WaveShield interference)"
          L2_3(L3_3)
        end
        L2_3 = true
        return L2_3
      end
      L2_3 = false ~= L1_3 and nil ~= L1_3
      return L2_3
    end
    L14_2 = L14_2(L15_2)
    L15_2 = true
    L16_2 = false
    L17_2 = CreateThread
    function L18_2()
      local L0_3, L1_3, L2_3
      L0_3 = Config
      L0_3 = L0_3.Debug
      if L0_3 then
        L0_3 = print
        L1_3 = "^5[DEBUG]^7 Health monitor thread started"
        L0_3(L1_3)
      end
      while true do
        L0_3 = L15_2
        if not L0_3 then
          break
        end
        L0_3 = IsPlayerInjured
        L0_3 = L0_3()
        if L0_3 then
          L0_3 = Config
          L0_3 = L0_3.Debug
          if L0_3 then
            L0_3 = print
            L1_3 = "^1[DEBUG]^7 Player injured detected! Cancelling progress"
            L0_3(L1_3)
          end
          L0_3 = true
          L16_2 = L0_3
          L0_3 = lib
          L0_3 = L0_3.cancelProgress
          L0_3()
          L0_3 = Wait
          L1_3 = 500
          L0_3(L1_3)
          L0_3 = lib
          L0_3 = L0_3.notify
          L1_3 = {}
          L1_3.title = "Cancelled"
          L1_3.description = "Placement cancelled due to injury"
          L1_3.type = "error"
          L0_3(L1_3)
          break
        end
        L0_3 = Wait
        L1_3 = 100
        L0_3(L1_3)
      end
      L0_3 = Config
      L0_3 = L0_3.Debug
      if L0_3 then
        L0_3 = print
        L1_3 = "^5[DEBUG]^7 Health monitor thread ended. Cancelled:"
        L2_3 = L16_2
        L0_3(L1_3, L2_3)
      end
    end
    L17_2(L18_2)
    L17_2 = Config
    L17_2 = L17_2.Debug
    if L17_2 then
      L17_2 = print
      L18_2 = "^5[DEBUG]^7 Resuming placement coroutine"
      L17_2(L18_2)
    end
    L17_2 = coroutine
    L17_2 = L17_2.resume
    L18_2 = L14_2
    L17_2, L18_2 = L17_2(L18_2)
    L15_2 = false
    L19_2 = Config
    L19_2 = L19_2.Debug
    if L19_2 then
      L19_2 = print
      L20_2 = "^5[DEBUG]^7 Coroutine status:"
      L21_2 = L17_2
      L19_2(L20_2, L21_2)
      L19_2 = print
      L20_2 = "^5[DEBUG]^7 Coroutine result:"
      L21_2 = L18_2
      L19_2(L20_2, L21_2)
      L19_2 = print
      L20_2 = "^5[DEBUG]^7 Result type:"
      L21_2 = type
      L22_2 = L18_2
      L21_2, L22_2, L23_2, L24_2, L25_2 = L21_2(L22_2)
      L19_2(L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
      L19_2 = print
      L20_2 = "^5[DEBUG]^7 Health cancelled:"
      L21_2 = L16_2
      L19_2(L20_2, L21_2)
      L19_2 = print
      L20_2 = "^5[DEBUG]^7 Final check (status and result):"
      L21_2 = L17_2 or L21_2
      if L17_2 then
        L21_2 = L18_2
      end
      L19_2(L20_2, L21_2)
    end
    if not L17_2 then
      L19_2 = Config
      L19_2 = L19_2.Debug
      if L19_2 then
        L19_2 = print
        L20_2 = "^1[DEBUG]^7 Coroutine error:"
        L21_2 = L18_2
        L19_2(L20_2, L21_2)
      end
      L18_2 = false
    end
    if L17_2 and L18_2 then
      L19_2 = Config
      L19_2 = L19_2.Debug
      if L19_2 then
        L19_2 = print
        L20_2 = "^3[fsg_cooking]^7: Gizmo placement confirmed, deleting gizmo object"
        L19_2(L20_2)
      end
      L19_2 = L12_1
      L20_2 = L9_2
      L19_2 = L19_2(L20_2)
      if L19_2 then
        L19_2 = L10_1
        L20_2 = L9_2
        L19_2 = L19_2(L20_2)
        L20_2 = Config
        L20_2 = L20_2.Debug
        if L20_2 then
          L20_2 = print
          L21_2 = "^1[DELETING GIZMO]^7 Entity:"
          L22_2 = L9_2
          L23_2 = "At:"
          L24_2 = L19_2
          L20_2(L21_2, L22_2, L23_2, L24_2)
        end
        L20_2 = SetEntityAsMissionEntity
        L21_2 = L9_2
        L22_2 = false
        L23_2 = true
        L20_2(L21_2, L22_2, L23_2)
        L20_2 = DeleteObject
        L21_2 = L9_2
        L20_2(L21_2)
        L20_2 = L13_1
        L21_2 = L9_2
        L20_2(L21_2)
        L20_2 = Wait
        L21_2 = 500
        L20_2(L21_2)
        L20_2 = L12_1
        L21_2 = L9_2
        L20_2 = L20_2(L21_2)
        if L20_2 then
          L20_2 = Config
          L20_2 = L20_2.Debug
          if L20_2 then
            L20_2 = print
            L21_2 = "^1[WARNING]^7 Gizmo object still exists after delete!"
            L20_2(L21_2)
          end
        else
          L20_2 = Config
          L20_2 = L20_2.Debug
          if L20_2 then
            L20_2 = print
            L21_2 = "^2[SUCCESS]^7 Gizmo object deleted"
            L20_2(L21_2)
          end
        end
      end
      L19_2 = Config
      L19_2 = L19_2.Debug
      if L19_2 then
        L19_2 = print
        L20_2 = "^3[fsg_cooking]^7: Calling server to place prop"
        L19_2(L20_2)
      end
      L19_2 = IsPlayerInjured
      L19_2 = L19_2()
      if not L19_2 then
        L19_2 = pcall
        function L20_2()
          local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3
          L0_3 = lib
          L0_3 = L0_3.callback
          L0_3 = L0_3.await
          L1_3 = "fsg_cooking:server:placeProp"
          L2_3 = false
          L3_3 = L1_1.model
          L4_3 = L11_2.position
          L5_3 = L11_2.rotation
          return L0_3(L1_3, L2_3, L3_3, L4_3, L5_3)
        end
        L19_2, L20_2 = L19_2(L20_2)
        L21_2 = Config
        L21_2 = L21_2.Debug
        if L21_2 then
          L21_2 = print
          L22_2 = "^5[DEBUG]^7 Server callback pcall success:"
          L23_2 = L19_2
          L21_2(L22_2, L23_2)
          L21_2 = print
          L22_2 = "^3[fsg_cooking]^7: Server responded with: "
          L23_2 = tostring
          L24_2 = L20_2
          L23_2 = L23_2(L24_2)
          L22_2 = L22_2 .. L23_2
          L21_2(L22_2)
          L21_2 = print
          L22_2 = "^3[fsg_cooking]^7: Clearing placementLock after server response"
          L21_2(L22_2)
        end
        if not L19_2 then
          L21_2 = Config
          L21_2 = L21_2.Debug
          if L21_2 then
            L21_2 = print
            L22_2 = "^1[DEBUG]^7 Server callback error:"
            L23_2 = L20_2
            L21_2(L22_2, L23_2)
          end
          L21_2 = lib
          L21_2 = L21_2.notify
          L22_2 = {}
          L22_2.title = "Error"
          L22_2.description = "Failed to place prop on server"
          L22_2.type = "error"
          L21_2(L22_2)
        elseif L20_2 then
          L21_2 = GetGameTimer
          L21_2 = L21_2()
          L3_1 = L21_2
          L21_2 = GetGameTimer
          L21_2 = L21_2()
          L5_1 = L21_2
        end
      else
        L19_2 = lib
        L19_2 = L19_2.notify
        L20_2 = {}
        L20_2.title = "Cancelled"
        L20_2.description = "Placement cancelled due to injury"
        L20_2.type = "error"
        L19_2(L20_2)
      end
    else
      L19_2 = Config
      L19_2 = L19_2.Debug
      if L19_2 then
        L19_2 = print
        L20_2 = "^1[DEBUG]^7 Placement failed!"
        L19_2(L20_2)
        L19_2 = print
        L20_2 = "^1[DEBUG]^7 - Status was:"
        L21_2 = L17_2
        L19_2(L20_2, L21_2)
        L19_2 = print
        L20_2 = "^1[DEBUG]^7 - Result was:"
        L21_2 = L18_2
        L19_2(L20_2, L21_2)
        L19_2 = print
        L20_2 = "^1[DEBUG]^7 - Health cancelled:"
        L21_2 = L16_2
        L19_2(L20_2, L21_2)
      end
      if not L16_2 then
        L19_2 = lib
        L19_2 = L19_2.notify
        L20_2 = {}
        L20_2.title = "Cancelled"
        L21_2 = "You cancelled placing the "
        L22_2 = L1_1.label
        L21_2 = L21_2 .. L22_2
        L20_2.description = L21_2
        L20_2.type = "error"
        L19_2(L20_2)
      end
      L19_2 = L12_1
      L20_2 = L9_2
      L19_2 = L19_2(L20_2)
      if L19_2 then
        L19_2 = L13_1
        L20_2 = L9_2
        L19_2(L20_2)
      end
    end
  else
    L12_2 = Config
    L12_2 = L12_2.Debug
    if L12_2 then
      L12_2 = print
      L13_2 = "^3[fsg_cooking]^7: Gizmo placement cancelled (no data returned from gizmo)"
      L12_2(L13_2)
    end
    L12_2 = L13_1
    L13_2 = L9_2
    L12_2(L13_2)
  end
  L12_2 = false
  L0_1 = L12_2
  L12_2 = nil
  L1_1 = L12_2
  L12_2 = false
  L7_1 = L12_2
end
StartPropPlacement = L18_1
L18_1 = lib
L18_1 = L18_1.callback
L18_1 = L18_1.register
L19_1 = "fsg_cooking:client:startPropPlacement"
function L20_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = ClearPlacementLock
  L1_2()
  L1_2 = GetGameTimer
  L1_2 = L1_2()
  L2_2 = L5_1
  L2_2 = L1_2 - L2_2
  L3_2 = L6_1
  if L2_2 < L3_2 then
    L2_2 = lib
    L2_2 = L2_2.notify
    L3_2 = {}
    L3_2.title = "Please Wait"
    L3_2.description = "You need to wait before taking another prop from your inventory"
    L3_2.type = "error"
    L2_2(L3_2)
    L2_2 = false
    return L2_2
  end
  L2_2 = GetGameTimer
  L2_2 = L2_2()
  L5_1 = L2_2
  L2_2 = StartPropPlacement
  L3_2 = A0_2
  L2_2(L3_2)
  L2_2 = true
  return L2_2
end
L18_1(L19_1, L20_1)
L18_1 = lib
L18_1 = L18_1.callback
L18_1 = L18_1.register
L19_1 = "fsg_cooking:client:syncProp"
function L20_1(A0_2, A1_2, A2_2, A3_2, A4_2)
  local L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L5_2 = L16_1
  L6_2 = A1_2
  L5_2 = L5_2(L6_2)
  L6_2 = loadModel
  L7_2 = L5_2
  L6_2(L7_2)
  L6_2 = NetworkGetEntityFromNetworkId
  L7_2 = A0_2
  L6_2 = L6_2(L7_2)
  if L6_2 then
    L7_2 = L12_1
    L8_2 = L6_2
    L7_2 = L7_2(L8_2)
    if L7_2 then
      L7_2 = SetEntityCoords
      L8_2 = L6_2
      L9_2 = A2_2.x
      L10_2 = A2_2.y
      L11_2 = A2_2.z
      L12_2 = false
      L13_2 = false
      L14_2 = false
      L15_2 = true
      L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
      L7_2 = SetEntityRotation
      L8_2 = L6_2
      L9_2 = A3_2.x
      L10_2 = A3_2.y
      L11_2 = A3_2.z
      L12_2 = 2
      L13_2 = true
      L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
      L7_2 = FreezeEntityPosition
      L8_2 = L6_2
      L9_2 = true
      L7_2(L8_2, L9_2)
      L7_2 = true
      return L7_2
    end
  end
  L7_2 = CreateObject
  L8_2 = L5_2
  L9_2 = A2_2.x
  L10_2 = A2_2.y
  L11_2 = A2_2.z
  L12_2 = true
  L13_2 = true
  L14_2 = false
  L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  L8_2 = L12_1
  L9_2 = L7_2
  L8_2 = L8_2(L9_2)
  if L8_2 then
    L8_2 = SetEntityRotation
    L9_2 = L7_2
    L10_2 = A3_2.x
    L11_2 = A3_2.y
    L12_2 = A3_2.z
    L13_2 = 2
    L14_2 = true
    L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
    L8_2 = FreezeEntityPosition
    L9_2 = L7_2
    L10_2 = true
    L8_2(L9_2, L10_2)
    L8_2 = NetworkRegisterEntityAsNetworked
    L9_2 = L7_2
    L8_2(L9_2)
    if A0_2 and A0_2 > 0 then
      L8_2 = NetworkSetNetworkIdDynamic
      L9_2 = A0_2
      L10_2 = true
      L8_2 = L8_2(L9_2, L10_2)
      if L8_2 then
        L9_2 = NetworkSetNetworkIdExistsOnAllMachines
        L10_2 = A0_2
        L11_2 = true
        L9_2(L10_2, L11_2)
      end
    end
    L8_2 = true
    return L8_2
  end
  L8_2 = false
  return L8_2
end
L18_1(L19_1, L20_1)
L18_1 = lib
L18_1 = L18_1.callback
L18_1 = L18_1.register
L19_1 = "fsg_cooking:client:createPropLocally"
function L20_1(A0_2, A1_2, A2_2, A3_2, A4_2)
  local L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2
  if not A0_2 then
    L5_2 = print
    L6_2 = "Error: Missing 'model' parameter in createPropLocally"
    L5_2(L6_2)
    L5_2 = false
    return L5_2
  end
  if not A1_2 then
    L5_2 = print
    L6_2 = "Error: Missing 'coords' parameter in createPropLocally"
    L5_2(L6_2)
    L5_2 = false
    return L5_2
  end
  if not A2_2 then
    L5_2 = print
    L6_2 = "Error: Missing 'rotation' parameter in createPropLocally"
    L5_2(L6_2)
    L5_2 = false
    return L5_2
  end
  if not A3_2 then
    L5_2 = GetPlayerServerId
    L6_2 = PlayerId
    L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2 = L6_2()
    L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
    A3_2 = L5_2
    L5_2 = print
    L6_2 = "^3[fsg_cooking]^7: Using fallback owner value:"
    L7_2 = A3_2
    L5_2(L6_2, L7_2)
  end
  if not A4_2 then
    L5_2 = "local_"
    L6_2 = A0_2
    L7_2 = "_"
    L8_2 = math
    L8_2 = L8_2.random
    L9_2 = 1000
    L10_2 = 9999
    L8_2 = L8_2(L9_2, L10_2)
    L9_2 = "_"
    L10_2 = GetGameTimer
    L10_2 = L10_2()
    L5_2 = L5_2 .. L6_2 .. L7_2 .. L8_2 .. L9_2 .. L10_2
    A4_2 = L5_2
    L5_2 = print
    L6_2 = "^3[fsg_cooking]^7: Using fallback propId:"
    L7_2 = A4_2
    L5_2(L6_2, L7_2)
  end
  L5_2 = type
  L6_2 = A1_2
  L5_2 = L5_2(L6_2)
  if "vector3" ~= L5_2 then
    L5_2 = A1_2.x
    if L5_2 then
      L5_2 = A1_2.y
      if L5_2 then
        L5_2 = A1_2.z
        if L5_2 then
          goto lbl_86
        end
      end
    end
    L5_2 = print
    L6_2 = "Error: Invalid coords format in createPropLocally"
    L5_2(L6_2)
    L5_2 = print
    L6_2 = "X: "
    L7_2 = tostring
    L8_2 = A1_2.x
    L7_2 = L7_2(L8_2)
    L8_2 = ", Y: "
    L9_2 = tostring
    L10_2 = A1_2.y
    L9_2 = L9_2(L10_2)
    L10_2 = ", Z: "
    L11_2 = tostring
    L12_2 = A1_2.z
    L11_2 = L11_2(L12_2)
    L6_2 = L6_2 .. L7_2 .. L8_2 .. L9_2 .. L10_2 .. L11_2
    L5_2(L6_2)
    L5_2 = false
    return L5_2
  end
  ::lbl_86::
  L5_2 = L16_1
  L6_2 = A0_2
  L5_2 = L5_2(L6_2)
  if 0 == L5_2 then
    L6_2 = print
    L7_2 = "Error: Invalid model name: "
    L8_2 = A0_2
    L7_2 = L7_2 .. L8_2
    L6_2(L7_2)
    L6_2 = false
    return L6_2
  end
  L6_2 = loadModel
  L7_2 = L5_2
  L6_2 = L6_2(L7_2)
  if not L6_2 then
    L6_2 = print
    L7_2 = "^1[fsg_cooking]^7: Failed to load model for prop creation"
    L6_2(L7_2)
    L6_2 = false
    return L6_2
  end
  L6_2 = pairs
  L7_2 = L17_1
  L6_2, L7_2, L8_2, L9_2 = L6_2(L7_2)
  for L10_2, L11_2 in L6_2, L7_2, L8_2, L9_2 do
    if L10_2 ~= A4_2 then
      L12_2 = L11_2.entity
      if L12_2 then
        L12_2 = L12_1
        L13_2 = L11_2.entity
        L12_2 = L12_2(L13_2)
        if L12_2 then
          L12_2 = L10_1
          L13_2 = L11_2.entity
          L12_2 = L12_2(L13_2)
          L13_2 = vector3
          L14_2 = A1_2.x
          L15_2 = A1_2.y
          L16_2 = A1_2.z
          L13_2 = L13_2(L14_2, L15_2, L16_2)
          L13_2 = L13_2 - L12_2
          L13_2 = #L13_2
          L14_2 = 0.5
          if L13_2 < L14_2 then
            L14_2 = print
            L15_2 = "Already have a prop at this location (distance: "
            L16_2 = L13_2
            L17_2 = "), skipping duplicate"
            L15_2 = L15_2 .. L16_2 .. L17_2
            L14_2(L15_2)
            L14_2 = false
            return L14_2
          end
        end
      end
    end
  end
  L6_2 = CreateObject
  L7_2 = L5_2
  L8_2 = A1_2.x
  L9_2 = A1_2.y
  L10_2 = A1_2.z
  L11_2 = false
  L12_2 = false
  L13_2 = false
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L7_2 = L12_1
  L8_2 = L6_2
  L7_2 = L7_2(L8_2)
  if L7_2 then
    L7_2 = Config
    L7_2 = L7_2.Debug
    if L7_2 then
      L7_2 = print
      L8_2 = "^2[LOCAL PROP CREATED]^7 Model:"
      L9_2 = A0_2
      L10_2 = "PropID:"
      L11_2 = A4_2
      L12_2 = "Entity:"
      L13_2 = L6_2
      L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
    end
    L7_2 = Config
    L7_2 = L7_2.Debug
    if L7_2 then
      L7_2 = print
      L8_2 = "DEBUG - createPropLocally:"
      L7_2(L8_2)
      L7_2 = print
      L8_2 = "  Requested coords:"
      L9_2 = A1_2.x
      L10_2 = A1_2.y
      L11_2 = A1_2.z
      L7_2(L8_2, L9_2, L10_2, L11_2)
    end
    L7_2 = SetEntityRotation
    L8_2 = L6_2
    L9_2 = A2_2.x
    L10_2 = A2_2.y
    L11_2 = A2_2.z
    L12_2 = 2
    L13_2 = true
    L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
    L7_2 = SetEntityCoordsNoOffset
    L8_2 = L6_2
    L9_2 = A1_2.x
    L10_2 = A1_2.y
    L11_2 = A1_2.z
    L12_2 = false
    L13_2 = false
    L14_2 = false
    L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
    L7_2 = Config
    L7_2 = L7_2.Debug
    if L7_2 then
      L7_2 = L10_1
      L8_2 = L6_2
      L7_2 = L7_2(L8_2)
      L8_2 = print
      L9_2 = "  Coords after force set:"
      L10_2 = L7_2.x
      L11_2 = L7_2.y
      L12_2 = L7_2.z
      L8_2(L9_2, L10_2, L11_2, L12_2)
      L8_2 = print
      L9_2 = "  Height difference:"
      L10_2 = L7_2.z
      L11_2 = A1_2.z
      L10_2 = L10_2 - L11_2
      L8_2(L9_2, L10_2)
    end
    L7_2 = FreezeEntityPosition
    L8_2 = L6_2
    L9_2 = true
    L7_2(L8_2, L9_2)
    L7_2 = SetEntityCollision
    L8_2 = L6_2
    L9_2 = true
    L10_2 = true
    L7_2(L8_2, L9_2, L10_2)
    L7_2 = 0
    L8_2 = SetEntityAsMissionEntity
    L9_2 = L6_2
    L10_2 = true
    L11_2 = true
    L8_2(L9_2, L10_2, L11_2)
    L8_2 = 0
    L9_2 = type
    L10_2 = A3_2
    L9_2 = L9_2(L10_2)
    if "string" == L9_2 then
      L10_2 = A3_2
      L9_2 = A3_2.sub
      L11_2 = 1
      L12_2 = 4
      L9_2 = L9_2(L10_2, L11_2, L12_2)
      if "char" == L9_2 then
        L9_2 = tonumber
        L11_2 = A3_2
        L10_2 = A3_2.sub
        L12_2 = 5
        L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2 = L10_2(L11_2, L12_2)
        L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
        L8_2 = L9_2 or L8_2
        if not L9_2 then
          L8_2 = 0
        end
    end
    else
      L9_2 = type
      L10_2 = A3_2
      L9_2 = L9_2(L10_2)
      if "number" == L9_2 then
        L8_2 = A3_2
      end
    end
    L9_2 = DecorSetInt
    L10_2 = L6_2
    L11_2 = "PropOwner"
    L12_2 = L8_2
    L9_2(L10_2, L11_2, L12_2)
    L9_2 = DecorSetBool
    L10_2 = L6_2
    L11_2 = "IsPlacedProp"
    L12_2 = true
    L9_2(L10_2, L11_2, L12_2)
    L9_2 = DecorSetInt
    L10_2 = L6_2
    L11_2 = "PropId"
    L12_2 = A4_2
    L9_2(L10_2, L11_2, L12_2)
    L9_2 = L10_1
    L10_2 = L6_2
    L9_2 = L9_2(L10_2)
    L10_2 = L17_1
    L11_2 = {}
    L11_2.entity = L6_2
    L11_2.netId = L7_2
    L11_2.model = A0_2
    L11_2.owner = A3_2
    L11_2.coords = L9_2
    L10_2[A4_2] = L11_2
    L10_2 = Config
    L10_2 = L10_2.Debug
    if L10_2 then
      L10_2 = print
      L11_2 = "Client created prop locally: "
      L12_2 = A0_2
      L13_2 = " at "
      L14_2 = tostring
      L15_2 = A1_2.x
      L14_2 = L14_2(L15_2)
      L15_2 = ", "
      L16_2 = tostring
      L17_2 = A1_2.y
      L16_2 = L16_2(L17_2)
      L17_2 = ", "
      L18_2 = tostring
      L19_2 = A1_2.z
      L18_2 = L18_2(L19_2)
      L19_2 = " with ID: "
      L20_2 = A4_2
      L21_2 = " owned by "
      L22_2 = A3_2
      L11_2 = L11_2 .. L12_2 .. L13_2 .. L14_2 .. L15_2 .. L16_2 .. L17_2 .. L18_2 .. L19_2 .. L20_2 .. L21_2 .. L22_2
      L10_2(L11_2)
    end
    L10_2 = SetPropOwner
    L11_2 = L6_2
    L12_2 = A3_2
    L10_2(L11_2, L12_2)
    L10_2 = nil
    L11_2 = nil
    L12_2 = nil
    L13_2 = pairs
    L14_2 = Config
    L14_2 = L14_2.CookingProps
    L13_2, L14_2, L15_2, L16_2 = L13_2(L14_2)
    for L17_2, L18_2 in L13_2, L14_2, L15_2, L16_2 do
      L19_2 = L18_2.model
      if L19_2 == A0_2 then
        L10_2 = L17_2
        L11_2 = L18_2
        L12_2 = "cooking"
        L19_2 = Config
        L19_2 = L19_2.Debug
        if L19_2 then
          L19_2 = print
          L20_2 = "Created prop is a cooking prop: "
          L21_2 = L17_2
          L20_2 = L20_2 .. L21_2
          L19_2(L20_2)
        end
        break
      end
    end
    if not L10_2 then
      L13_2 = pairs
      L14_2 = Config
      L14_2 = L14_2.DecorationProps
      L13_2, L14_2, L15_2, L16_2 = L13_2(L14_2)
      for L17_2, L18_2 in L13_2, L14_2, L15_2, L16_2 do
        L19_2 = L18_2.model
        if L19_2 == A0_2 then
          L10_2 = L17_2
          L11_2 = L18_2
          L12_2 = "decoration"
          L19_2 = Config
          L19_2 = L19_2.Debug
          if L19_2 then
            L19_2 = print
            L20_2 = "Created prop is a decoration prop: "
            L21_2 = L17_2
            L20_2 = L20_2 .. L21_2
            L19_2(L20_2)
          end
          break
        end
      end
    end
    if "cooking" == L12_2 and L10_2 and L11_2 then
      L13_2 = Config
      L13_2 = L13_2.Debug
      if L13_2 then
        L13_2 = print
        L14_2 = "Setting up cooking prop interaction for "
        L15_2 = L10_2
        L14_2 = L14_2 .. L15_2
        L13_2(L14_2)
      end
      L13_2 = SetupCookingPropInteraction
      L14_2 = L6_2
      L15_2 = L10_2
      L16_2 = L11_2
      L13_2(L14_2, L15_2, L16_2)
    elseif "decoration" == L12_2 and L10_2 and L11_2 then
      L13_2 = Config
      L13_2 = L13_2.Debug
      if L13_2 then
        L13_2 = print
        L14_2 = "Setting up decoration prop interaction for "
        L15_2 = L10_2
        L14_2 = L14_2 .. L15_2
        L13_2(L14_2)
      end
      L13_2 = SetupDecorationPropInteraction
      L14_2 = L6_2
      L15_2 = L10_2
      L16_2 = L11_2
      L13_2(L14_2, L15_2, L16_2)
    else
      L13_2 = Config
      L13_2 = L13_2.Debug
      if L13_2 then
        L13_2 = print
        L14_2 = "Warning: Could not determine prop type for interaction setup"
        L13_2(L14_2)
      end
    end
    L13_2 = unloadModel
    L14_2 = L5_2
    L13_2(L14_2)
    L13_2 = true
    return L13_2
  else
    L7_2 = print
    L8_2 = "Failed to create entity on client side"
    L7_2(L8_2)
    L7_2 = unloadModel
    L8_2 = L5_2
    L7_2(L8_2)
    L7_2 = false
    return L7_2
  end
end
L18_1(L19_1, L20_1)
function L18_1(A0_2, A1_2, A2_2, A3_2, A4_2)
  local L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
  L5_2 = Config
  L5_2 = L5_2.Debug
  if L5_2 then
    L5_2 = print
    L6_2 = "^3[fsg_cooking]^7: Received createViewOnlyProp event with parameters:"
    L5_2(L6_2)
    L5_2 = print
    L6_2 = "- model:"
    L7_2 = tostring
    L8_2 = A0_2
    L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L7_2(L8_2)
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
    L5_2 = print
    L6_2 = "- coords:"
    L7_2 = tostring
    L8_2 = A1_2
    L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L7_2(L8_2)
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
    if A1_2 then
      L5_2 = print
      L6_2 = "  - x:"
      L7_2 = tostring
      L8_2 = A1_2.x
      L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L7_2(L8_2)
      L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
      L5_2 = print
      L6_2 = "  - y:"
      L7_2 = tostring
      L8_2 = A1_2.y
      L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L7_2(L8_2)
      L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
      L5_2 = print
      L6_2 = "  - z:"
      L7_2 = tostring
      L8_2 = A1_2.z
      L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L7_2(L8_2)
      L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
    end
    L5_2 = print
    L6_2 = "- rotation:"
    L7_2 = tostring
    L8_2 = A2_2
    L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L7_2(L8_2)
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
    L5_2 = print
    L6_2 = "- owner:"
    L7_2 = tostring
    L8_2 = A3_2
    L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L7_2(L8_2)
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
    L5_2 = print
    L6_2 = "- propId:"
    L7_2 = tostring
    L8_2 = A4_2
    L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L7_2(L8_2)
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
  end
  if not A0_2 then
    L5_2 = Config
    L5_2 = L5_2.Debug
    if L5_2 then
      L5_2 = print
      L6_2 = "Error: Missing 'model' parameter in createViewOnlyProp"
      L5_2(L6_2)
    end
    L5_2 = false
    return L5_2
  end
  if not A1_2 then
    L5_2 = Config
    L5_2 = L5_2.Debug
    if L5_2 then
      L5_2 = print
      L6_2 = "Error: Missing 'coords' parameter in createViewOnlyProp"
      L5_2(L6_2)
    end
    L5_2 = false
    return L5_2
  end
  if not A2_2 then
    L5_2 = Config
    L5_2 = L5_2.Debug
    if L5_2 then
      L5_2 = print
      L6_2 = "Error: Missing 'rotation' parameter in createViewOnlyProp"
      L5_2(L6_2)
    end
    L5_2 = false
    return L5_2
  end
  if not A3_2 then
    A3_2 = 0
    L5_2 = Config
    L5_2 = L5_2.Debug
    if L5_2 then
      L5_2 = print
      L6_2 = "^3[fsg_cooking]^7: Using fallback owner value for view-only prop:"
      L7_2 = A3_2
      L5_2(L6_2, L7_2)
    end
  end
  if not A4_2 then
    L5_2 = "view_"
    L6_2 = A0_2
    L7_2 = "_"
    L8_2 = math
    L8_2 = L8_2.random
    L9_2 = 1000
    L10_2 = 9999
    L8_2 = L8_2(L9_2, L10_2)
    L9_2 = "_"
    L10_2 = GetGameTimer
    L10_2 = L10_2()
    L5_2 = L5_2 .. L6_2 .. L7_2 .. L8_2 .. L9_2 .. L10_2
    A4_2 = L5_2
    L5_2 = Config
    L5_2 = L5_2.Debug
    if L5_2 then
      L5_2 = print
      L6_2 = "^3[fsg_cooking]^7: Using fallback propId for view-only prop:"
      L7_2 = A4_2
      L5_2(L6_2, L7_2)
    end
  end
  L5_2 = type
  L6_2 = A1_2
  L5_2 = L5_2(L6_2)
  if "vector3" ~= L5_2 then
    L5_2 = A1_2.x
    if L5_2 then
      L5_2 = A1_2.y
      if L5_2 then
        L5_2 = A1_2.z
        if L5_2 then
          goto lbl_176
        end
      end
    end
    L5_2 = Config
    L5_2 = L5_2.Debug
    if L5_2 then
      L5_2 = print
      L6_2 = "Error: Invalid coords format in createViewOnlyProp"
      L5_2(L6_2)
      L5_2 = print
      L6_2 = "X: "
      L7_2 = tostring
      L8_2 = A1_2.x
      L7_2 = L7_2(L8_2)
      L8_2 = ", Y: "
      L9_2 = tostring
      L10_2 = A1_2.y
      L9_2 = L9_2(L10_2)
      L10_2 = ", Z: "
      L11_2 = tostring
      L12_2 = A1_2.z
      L11_2 = L11_2(L12_2)
      L6_2 = L6_2 .. L7_2 .. L8_2 .. L9_2 .. L10_2 .. L11_2
      L5_2(L6_2)
    end
    L5_2 = vector3
    L6_2 = A1_2.x
    if not L6_2 then
      L6_2 = 0
    end
    L7_2 = A1_2.y
    if not L7_2 then
      L7_2 = 0
    end
    L8_2 = A1_2.z
    if not L8_2 then
      L8_2 = 0
    end
    L5_2 = L5_2(L6_2, L7_2, L8_2)
    A1_2 = L5_2
  end
  ::lbl_176::
  L5_2 = Config
  L5_2 = L5_2.Debug
  if L5_2 then
    L5_2 = print
    L6_2 = "^3[DEBUG]^7 Checking propId:"
    L7_2 = A4_2
    L5_2(L6_2, L7_2)
    L5_2 = print
    L6_2 = "^3[DEBUG]^7 Current placedPropsById keys:"
    L5_2(L6_2)
    L5_2 = pairs
    L6_2 = L17_1
    L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
    for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
      L11_2 = print
      L12_2 = "  - Key:"
      L13_2 = L9_2
      L14_2 = "Entity:"
      L15_2 = L10_2.entity
      L11_2(L12_2, L13_2, L14_2, L15_2)
    end
  end
  L5_2 = L17_1
  L5_2 = L5_2[A4_2]
  if L5_2 then
    L5_2 = Config
    L5_2 = L5_2.Debug
    if L5_2 then
      L5_2 = print
      L6_2 = "^1[DUPLICATE DETECTED]^7 Already have prop with ID "
      L7_2 = A4_2
      L8_2 = ", ignoring duplicate"
      L6_2 = L6_2 .. L7_2 .. L8_2
      L5_2(L6_2)
    end
    L5_2 = false
    return L5_2
  else
    L5_2 = Config
    L5_2 = L5_2.Debug
    if L5_2 then
      L5_2 = print
      L6_2 = "^2[NEW PROP]^7 PropId not found in table, creating view-only prop"
      L5_2(L6_2)
    end
  end
  L5_2 = pairs
  L6_2 = L17_1
  L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
  for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
    if L9_2 ~= A4_2 then
      L11_2 = L10_2.entity
      if L11_2 then
        L11_2 = L12_1
        L12_2 = L10_2.entity
        L11_2 = L11_2(L12_2)
        if L11_2 then
          L11_2 = L10_1
          L12_2 = L10_2.entity
          L11_2 = L11_2(L12_2)
          L12_2 = vector3
          L13_2 = A1_2.x
          L14_2 = A1_2.y
          L15_2 = A1_2.z
          L12_2 = L12_2(L13_2, L14_2, L15_2)
          L12_2 = L12_2 - L11_2
          L12_2 = #L12_2
          L13_2 = 0.5
          if L12_2 < L13_2 then
            L13_2 = Config
            L13_2 = L13_2.Debug
            if L13_2 then
              L13_2 = print
              L14_2 = "Already have a prop at this location (distance: "
              L15_2 = L12_2
              L16_2 = "), skipping duplicate"
              L14_2 = L14_2 .. L15_2 .. L16_2
              L13_2(L14_2)
            end
            L13_2 = false
            return L13_2
          end
        end
      end
    end
  end
  L5_2 = L16_1
  L6_2 = A0_2
  L5_2 = L5_2(L6_2)
  L6_2 = loadModel
  L7_2 = L5_2
  L6_2 = L6_2(L7_2)
  if not L6_2 then
    L6_2 = print
    L7_2 = "^1[fsg_cooking]^7: Failed to load model for view-only prop creation"
    L6_2(L7_2)
    L6_2 = false
    return L6_2
  end
  L6_2 = CreateObject
  L7_2 = L5_2
  L8_2 = A1_2.x
  L9_2 = A1_2.y
  L10_2 = A1_2.z
  L11_2 = false
  L12_2 = false
  L13_2 = false
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L7_2 = L12_1
  L8_2 = L6_2
  L7_2 = L7_2(L8_2)
  if L7_2 then
    L7_2 = Config
    L7_2 = L7_2.Debug
    if L7_2 then
      L7_2 = print
      L8_2 = "^3[VIEW-ONLY PROP CREATED]^7 Model:"
      L9_2 = A0_2
      L10_2 = "PropID:"
      L11_2 = A4_2
      L12_2 = "Entity:"
      L13_2 = L6_2
      L14_2 = "Owner:"
      L15_2 = A3_2
      L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
    end
    L7_2 = SetEntityRotation
    L8_2 = L6_2
    L9_2 = A2_2.x
    L10_2 = A2_2.y
    L11_2 = A2_2.z
    L12_2 = 2
    L13_2 = true
    L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
    L7_2 = SetEntityCoordsNoOffset
    L8_2 = L6_2
    L9_2 = A1_2.x
    L10_2 = A1_2.y
    L11_2 = A1_2.z
    L12_2 = false
    L13_2 = false
    L14_2 = false
    L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
    L7_2 = FreezeEntityPosition
    L8_2 = L6_2
    L9_2 = true
    L7_2(L8_2, L9_2)
    L7_2 = SetEntityCollision
    L8_2 = L6_2
    L9_2 = true
    L10_2 = true
    L7_2(L8_2, L9_2, L10_2)
    L7_2 = SetEntityAsMissionEntity
    L8_2 = L6_2
    L9_2 = true
    L10_2 = true
    L7_2(L8_2, L9_2, L10_2)
    L7_2 = DecorSetInt
    L8_2 = L6_2
    L9_2 = "ViewPropOwner"
    L10_2 = A3_2
    L7_2(L8_2, L9_2, L10_2)
    L7_2 = DecorSetBool
    L8_2 = L6_2
    L9_2 = "IsViewProp"
    L10_2 = true
    L7_2(L8_2, L9_2, L10_2)
    L7_2 = DecorSetInt
    L8_2 = L6_2
    L9_2 = "PropId"
    L10_2 = A4_2
    L7_2(L8_2, L9_2, L10_2)
    L7_2 = SetPropOwner
    L8_2 = L6_2
    L9_2 = A3_2
    L7_2(L8_2, L9_2)
    L7_2 = L10_1
    L8_2 = L6_2
    L7_2 = L7_2(L8_2)
    L8_2 = L17_1
    L9_2 = {}
    L9_2.entity = L6_2
    L9_2.model = A0_2
    L9_2.owner = A3_2
    L9_2.viewOnly = true
    L9_2.coords = L7_2
    L8_2[A4_2] = L9_2
    L8_2 = Config
    L8_2 = L8_2.Debug
    if L8_2 then
      L8_2 = print
      L9_2 = "Client created view-only prop: "
      L10_2 = A0_2
      L11_2 = " with ID: "
      L12_2 = A4_2
      L13_2 = " owned by: "
      L14_2 = tostring
      L15_2 = A3_2
      L14_2 = L14_2(L15_2)
      L9_2 = L9_2 .. L10_2 .. L11_2 .. L12_2 .. L13_2 .. L14_2
      L8_2(L9_2)
    end
    L8_2 = nil
    L9_2 = nil
    L10_2 = nil
    L11_2 = pairs
    L12_2 = Config
    L12_2 = L12_2.CookingProps
    L11_2, L12_2, L13_2, L14_2 = L11_2(L12_2)
    for L15_2, L16_2 in L11_2, L12_2, L13_2, L14_2 do
      L17_2 = L16_2.model
      if L17_2 == A0_2 then
        L8_2 = L15_2
        L9_2 = L16_2
        L10_2 = "cooking"
        L17_2 = Config
        L17_2 = L17_2.Debug
        if L17_2 then
          L17_2 = print
          L18_2 = "View-only prop is a cooking prop: "
          L19_2 = L15_2
          L18_2 = L18_2 .. L19_2
          L17_2(L18_2)
        end
        break
      end
    end
    if not L8_2 then
      L11_2 = pairs
      L12_2 = Config
      L12_2 = L12_2.DecorationProps
      L11_2, L12_2, L13_2, L14_2 = L11_2(L12_2)
      for L15_2, L16_2 in L11_2, L12_2, L13_2, L14_2 do
        L17_2 = L16_2.model
        if L17_2 == A0_2 then
          L8_2 = L15_2
          L9_2 = L16_2
          L10_2 = "decoration"
          L17_2 = Config
          L17_2 = L17_2.Debug
          if L17_2 then
            L17_2 = print
            L18_2 = "View-only prop is a decoration prop: "
            L19_2 = L15_2
            L18_2 = L18_2 .. L19_2
            L17_2(L18_2)
          end
          break
        end
      end
    end
    if "cooking" == L10_2 and L8_2 and L9_2 then
      L11_2 = Config
      L11_2 = L11_2.Debug
      if L11_2 then
        L11_2 = print
        L12_2 = "Setting up cooking prop interaction for view-only prop: "
        L13_2 = L8_2
        L12_2 = L12_2 .. L13_2
        L11_2(L12_2)
      end
      L11_2 = SetupCookingPropInteraction
      L12_2 = L6_2
      L13_2 = L8_2
      L14_2 = L9_2
      L11_2(L12_2, L13_2, L14_2)
    elseif "decoration" == L10_2 and L8_2 and L9_2 then
      L11_2 = Config
      L11_2 = L11_2.Debug
      if L11_2 then
        L11_2 = print
        L12_2 = "Setting up decoration prop interaction for view-only prop: "
        L13_2 = L8_2
        L12_2 = L12_2 .. L13_2
        L11_2(L12_2)
      end
      L11_2 = SetupDecorationPropInteraction
      L12_2 = L6_2
      L13_2 = L8_2
      L14_2 = L9_2
      L11_2(L12_2, L13_2, L14_2)
    else
      L11_2 = print
      L12_2 = "Warning: Could not determine prop type for view-only interaction setup"
      L11_2(L12_2)
    end
    L11_2 = unloadModel
    L12_2 = L5_2
    L11_2(L12_2)
    L11_2 = true
    return L11_2
  else
    L7_2 = print
    L8_2 = "Failed to create view-only entity"
    L7_2(L8_2)
    L7_2 = unloadModel
    L8_2 = L5_2
    L7_2(L8_2)
    L7_2 = false
    return L7_2
  end
end
L19_1 = lib
L19_1 = L19_1.callback
L19_1 = L19_1.register
L20_1 = "fsg_cooking:client:createViewOnlyProp"
L21_1 = L18_1
L19_1(L20_1, L21_1)
L19_1 = RegisterNetEvent
L20_1 = "fsg_cooking:client:createViewOnlyProp"
function L21_1(A0_2, A1_2, A2_2, A3_2, A4_2)
  local L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L5_2 = L18_1
  L6_2 = A0_2
  L7_2 = A1_2
  L8_2 = A2_2
  L9_2 = A3_2
  L10_2 = A4_2
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
end
L19_1(L20_1, L21_1)
L19_1 = lib
L19_1 = L19_1.callback
L19_1 = L19_1.register
L20_1 = "fsg_cooking:client:deletePropById"
function L21_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  if not A0_2 then
    L1_2 = false
    return L1_2
  end
  L1_2 = Config
  L1_2 = L1_2.Debug
  if L1_2 then
    L1_2 = print
    L2_2 = "Received request to delete prop with ID: "
    L3_2 = A0_2
    L2_2 = L2_2 .. L3_2
    L1_2(L2_2)
  end
  L1_2 = L17_1
  L1_2 = L1_2[A0_2]
  if L1_2 then
    L2_2 = L1_2.entity
    if L2_2 then
      L2_2 = L12_1
      L3_2 = L1_2.entity
      L2_2 = L2_2(L3_2)
      if L2_2 then
        L2_2 = Config
        L2_2 = L2_2.Debug
        if L2_2 then
          L2_2 = print
          L3_2 = "Found prop to delete, removing entity"
          L2_2(L3_2)
        end
        L2_2 = SetEntityAsMissionEntity
        L3_2 = L1_2.entity
        L4_2 = true
        L5_2 = true
        L2_2(L3_2, L4_2, L5_2)
        L2_2 = L13_1
        L3_2 = L1_2.entity
        L2_2(L3_2)
        L2_2 = L12_1
        L3_2 = L1_2.entity
        L2_2 = L2_2(L3_2)
        if L2_2 then
          L2_2 = SetEntityCoords
          L3_2 = L1_2.entity
          L4_2 = 0
          L5_2 = 0
          L6_2 = -1000.0
          L2_2(L3_2, L4_2, L5_2, L6_2)
          L2_2 = SetEntityVisible
          L3_2 = L1_2.entity
          L4_2 = false
          L2_2(L3_2, L4_2)
          L2_2 = L13_1
          L3_2 = L1_2.entity
          L2_2(L3_2)
        end
        L2_2 = L17_1
        L2_2[A0_2] = nil
        L2_2 = true
        return L2_2
    end
  end
  else
    L2_2 = print
    L3_2 = "Could not find prop with ID: "
    L4_2 = A0_2
    L3_2 = L3_2 .. L4_2
    L2_2(L3_2)
    L2_2 = false
    return L2_2
  end
end
L19_1(L20_1, L21_1)
L19_1 = RegisterNetEvent
L20_1 = "fsg_cooking:client:deletePropById"
L19_1(L20_1)
L19_1 = AddEventHandler
L20_1 = "fsg_cooking:client:deletePropById"
function L21_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  if not A0_2 then
    return
  end
  L1_2 = Config
  L1_2 = L1_2.Debug
  if L1_2 then
    L1_2 = print
    L2_2 = "Received event to delete prop with ID: "
    L3_2 = A0_2
    L2_2 = L2_2 .. L3_2
    L1_2(L2_2)
  end
  L1_2 = L17_1
  L1_2 = L1_2[A0_2]
  if L1_2 then
    L2_2 = L1_2.entity
    if L2_2 then
      L2_2 = L12_1
      L3_2 = L1_2.entity
      L2_2 = L2_2(L3_2)
      if L2_2 then
        L2_2 = Config
        L2_2 = L2_2.Debug
        if L2_2 then
          L2_2 = print
          L3_2 = "Found prop to delete via event, removing entity"
          L2_2(L3_2)
        end
        L2_2 = SetEntityAsMissionEntity
        L3_2 = L1_2.entity
        L4_2 = true
        L5_2 = true
        L2_2(L3_2, L4_2, L5_2)
        L2_2 = L13_1
        L3_2 = L1_2.entity
        L2_2(L3_2)
        L2_2 = L12_1
        L3_2 = L1_2.entity
        L2_2 = L2_2(L3_2)
        if L2_2 then
          L2_2 = SetEntityCoords
          L3_2 = L1_2.entity
          L4_2 = 0
          L5_2 = 0
          L6_2 = -1000.0
          L2_2(L3_2, L4_2, L5_2, L6_2)
          L2_2 = SetEntityVisible
          L3_2 = L1_2.entity
          L4_2 = false
          L2_2(L3_2, L4_2)
          L2_2 = L13_1
          L3_2 = L1_2.entity
          L2_2(L3_2)
        end
        L2_2 = L17_1
        L2_2[A0_2] = nil
    end
  end
  else
    L2_2 = print
    L3_2 = "Could not find prop with ID: "
    L4_2 = A0_2
    L3_2 = L3_2 .. L4_2
    L2_2(L3_2)
  end
end
L19_1(L20_1, L21_1)
L19_1 = lib
L19_1 = L19_1.callback
L19_1 = L19_1.register
L20_1 = "fsg_cooking:client:deleteEntityByNetId"
function L21_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  if not A0_2 or A0_2 <= 0 then
    L1_2 = false
    return L1_2
  end
  L1_2 = Config
  L1_2 = L1_2.Debug
  if L1_2 then
    L1_2 = print
    L2_2 = "Received request to delete entity with netId: "
    L3_2 = A0_2
    L2_2 = L2_2 .. L3_2
    L1_2(L2_2)
  end
  L1_2 = NetworkDoesNetworkIdExist
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if L1_2 then
    L1_2 = NetworkGetEntityFromNetworkId
    L2_2 = A0_2
    L1_2 = L1_2(L2_2)
    L2_2 = L12_1
    L3_2 = L1_2
    L2_2 = L2_2(L3_2)
    if L2_2 then
      L2_2 = Config
      L2_2 = L2_2.Debug
      if L2_2 then
        L2_2 = print
        L3_2 = "Found entity to delete by netId"
        L2_2(L3_2)
      end
      L2_2 = SetEntityAsMissionEntity
      L3_2 = L1_2
      L4_2 = true
      L5_2 = true
      L2_2(L3_2, L4_2, L5_2)
      L2_2 = L13_1
      L3_2 = L1_2
      L2_2(L3_2)
      L2_2 = L12_1
      L3_2 = L1_2
      L2_2 = L2_2(L3_2)
      if L2_2 then
        L2_2 = SetEntityCoords
        L3_2 = L1_2
        L4_2 = 0
        L5_2 = 0
        L6_2 = -1000.0
        L2_2(L3_2, L4_2, L5_2, L6_2)
        L2_2 = SetEntityVisible
        L3_2 = L1_2
        L4_2 = false
        L2_2(L3_2, L4_2)
        L2_2 = SetEntityCollision
        L3_2 = L1_2
        L4_2 = false
        L5_2 = false
        L2_2(L3_2, L4_2, L5_2)
        L2_2 = L13_1
        L3_2 = L1_2
        L2_2(L3_2)
      end
      L2_2 = true
      return L2_2
    end
  end
  L1_2 = GetGamePool
  L2_2 = "CObject"
  L1_2 = L1_2(L2_2)
  L2_2 = ipairs
  L3_2 = L1_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = L12_1
    L9_2 = L7_2
    L8_2 = L8_2(L9_2)
    if L8_2 then
      L8_2 = DecorGetBool
      L9_2 = L7_2
      L10_2 = "IsPlacedProp"
      L8_2 = L8_2(L9_2, L10_2)
      if L8_2 then
        L8_2 = NetworkGetNetworkIdFromEntity
        L9_2 = L7_2
        L8_2 = L8_2(L9_2)
        if L8_2 == A0_2 then
          L9_2 = Config
          L9_2 = L9_2.Debug
          if L9_2 then
            L9_2 = print
            L10_2 = "Found matching entity through game pool"
            L9_2(L10_2)
          end
          L9_2 = SetEntityAsMissionEntity
          L10_2 = L7_2
          L11_2 = true
          L12_2 = true
          L9_2(L10_2, L11_2, L12_2)
          L9_2 = L13_1
          L10_2 = L7_2
          L9_2(L10_2)
          L9_2 = true
          return L9_2
        end
      end
    end
  end
  L2_2 = false
  return L2_2
end
L19_1(L20_1, L21_1)
L19_1 = RegisterNetEvent
L20_1 = "fsg_cooking:client:deleteEntityByNetId"
L19_1(L20_1)
L19_1 = AddEventHandler
L20_1 = "fsg_cooking:client:deleteEntityByNetId"
function L21_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  if not A0_2 or A0_2 <= 0 then
    return
  end
  L1_2 = Config
  L1_2 = L1_2.Debug
  if L1_2 then
    L1_2 = print
    L2_2 = "Received event to delete entity with netId: "
    L3_2 = A0_2
    L2_2 = L2_2 .. L3_2
    L1_2(L2_2)
  end
  L1_2 = NetworkDoesNetworkIdExist
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if L1_2 then
    L1_2 = NetworkGetEntityFromNetworkId
    L2_2 = A0_2
    L1_2 = L1_2(L2_2)
    L2_2 = L12_1
    L3_2 = L1_2
    L2_2 = L2_2(L3_2)
    if L2_2 then
      L2_2 = Config
      L2_2 = L2_2.Debug
      if L2_2 then
        L2_2 = print
        L3_2 = "Found entity to delete by netId via event"
        L2_2(L3_2)
      end
      L2_2 = SetEntityAsMissionEntity
      L3_2 = L1_2
      L4_2 = true
      L5_2 = true
      L2_2(L3_2, L4_2, L5_2)
      L2_2 = L13_1
      L3_2 = L1_2
      L2_2(L3_2)
      L2_2 = L12_1
      L3_2 = L1_2
      L2_2 = L2_2(L3_2)
      if L2_2 then
        L2_2 = SetEntityCoords
        L3_2 = L1_2
        L4_2 = 0
        L5_2 = 0
        L6_2 = -1000.0
        L2_2(L3_2, L4_2, L5_2, L6_2)
        L2_2 = SetEntityVisible
        L3_2 = L1_2
        L4_2 = false
        L2_2(L3_2, L4_2)
        L2_2 = SetEntityCollision
        L3_2 = L1_2
        L4_2 = false
        L5_2 = false
        L2_2(L3_2, L4_2, L5_2)
        L2_2 = L13_1
        L3_2 = L1_2
        L2_2(L3_2)
      end
      return
    end
  end
  L1_2 = GetGamePool
  L2_2 = "CObject"
  L1_2 = L1_2(L2_2)
  L2_2 = ipairs
  L3_2 = L1_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = L12_1
    L9_2 = L7_2
    L8_2 = L8_2(L9_2)
    if L8_2 then
      L8_2 = DecorGetBool
      L9_2 = L7_2
      L10_2 = "IsPlacedProp"
      L8_2 = L8_2(L9_2, L10_2)
      if L8_2 then
        L8_2 = NetworkGetNetworkIdFromEntity
        L9_2 = L7_2
        L8_2 = L8_2(L9_2)
        if L8_2 == A0_2 then
          L9_2 = Config
          L9_2 = L9_2.Debug
          if L9_2 then
            L9_2 = print
            L10_2 = "Found matching entity through game pool via event"
            L9_2(L10_2)
          end
          L9_2 = SetEntityAsMissionEntity
          L10_2 = L7_2
          L11_2 = true
          L12_2 = true
          L9_2(L10_2, L11_2, L12_2)
          L9_2 = L13_1
          L10_2 = L7_2
          L9_2(L10_2)
          return
        end
      end
    end
  end
end
L19_1(L20_1, L21_1)
L19_1 = AddEventHandler
L20_1 = "onResourceStop"
function L21_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = GetCurrentResourceName
  L1_2 = L1_2()
  if A0_2 ~= L1_2 then
    return
  end
  L1_2 = lib
  L1_2 = L1_2.hideTextUI
  L1_2()
  L1_2 = L2_1
  if L1_2 then
    L1_2 = L12_1
    L2_2 = L2_1
    L1_2 = L1_2(L2_2)
    if L1_2 then
      L1_2 = L13_1
      L2_2 = L2_1
      L1_2(L2_2)
      L1_2 = nil
      L2_1 = L1_2
    end
  end
  L1_2 = pairs
  L2_2 = L17_1
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = L6_2.entity
    if L7_2 then
      L7_2 = L12_1
      L8_2 = L6_2.entity
      L7_2 = L7_2(L8_2)
      if L7_2 then
        L7_2 = SetEntityAsMissionEntity
        L8_2 = L6_2.entity
        L9_2 = true
        L10_2 = true
        L7_2(L8_2, L9_2, L10_2)
        L7_2 = L13_1
        L8_2 = L6_2.entity
        L7_2(L8_2)
      end
    end
  end
  L1_2 = {}
  L17_1 = L1_2
end
L19_1(L20_1, L21_1)
L19_1 = CreateThread
function L20_1()
  local L0_2, L1_2, L2_2
  L0_2 = DecorIsRegisteredAsType
  L1_2 = "PropOwner"
  L2_2 = 3
  L0_2 = L0_2(L1_2, L2_2)
  if not L0_2 then
    L0_2 = DecorRegister
    L1_2 = "PropOwner"
    L2_2 = 3
    L0_2(L1_2, L2_2)
  end
  L0_2 = DecorIsRegisteredAsType
  L1_2 = "IsPlacedProp"
  L2_2 = 2
  L0_2 = L0_2(L1_2, L2_2)
  if not L0_2 then
    L0_2 = DecorRegister
    L1_2 = "IsPlacedProp"
    L2_2 = 2
    L0_2(L1_2, L2_2)
  end
  L0_2 = Wait
  L1_2 = 1000
  L0_2(L1_2)
  L0_2 = SetupTargetInteractions
  L0_2()
end
L19_1(L20_1)
function L19_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L0_2 = Config
  L0_2 = L0_2.Debug
  if L0_2 then
    L0_2 = print
    L1_2 = "Setting up target interactions for props"
    L0_2(L1_2)
  end
  L0_2 = Config
  L0_2 = L0_2.CookingProps
  if not L0_2 then
    L0_2 = print
    L1_2 = "Warning: Config.CookingProps is not defined"
    L0_2(L1_2)
    return
  end
  L0_2 = GetGamePool
  L1_2 = "CObject"
  L0_2 = L0_2(L1_2)
  L1_2 = Config
  L1_2 = L1_2.Debug
  if L1_2 then
    L1_2 = print
    L2_2 = "Setting up cooking prop interactions"
    L1_2(L2_2)
  end
  L1_2 = 1
  L2_2 = #L0_2
  L3_2 = 1
  for L4_2 = L1_2, L2_2, L3_2 do
    L5_2 = L0_2[L4_2]
    L6_2 = L12_1
    L7_2 = L5_2
    L6_2 = L6_2(L7_2)
    if L6_2 then
      L6_2 = DecorGetBool
      L7_2 = L5_2
      L8_2 = "IsPlacedProp"
      L6_2 = L6_2(L7_2, L8_2)
      if L6_2 then
        L6_2 = GetEntityModel
        L7_2 = L5_2
        L6_2 = L6_2(L7_2)
        L7_2 = pairs
        L8_2 = Config
        L8_2 = L8_2.CookingProps
        L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
        for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
          L13_2 = L16_1
          L14_2 = L12_2.model
          L13_2 = L13_2(L14_2)
          if L13_2 == L6_2 then
            L13_2 = print
            L14_2 = "Found cooking prop: "
            L15_2 = L11_2
            L14_2 = L14_2 .. L15_2
            L13_2(L14_2)
            L13_2 = SetupCookingPropInteraction
            L14_2 = L5_2
            L15_2 = L11_2
            L16_2 = L12_2
            L13_2(L14_2, L15_2, L16_2)
            break
          end
        end
      end
    end
  end
  L1_2 = Config
  L1_2 = L1_2.Debug
  if L1_2 then
    L1_2 = print
    L2_2 = "Setting up decoration prop interactions"
    L1_2(L2_2)
  end
  L1_2 = 1
  L2_2 = #L0_2
  L3_2 = 1
  for L4_2 = L1_2, L2_2, L3_2 do
    L5_2 = L0_2[L4_2]
    L6_2 = L12_1
    L7_2 = L5_2
    L6_2 = L6_2(L7_2)
    if L6_2 then
      L6_2 = DecorGetBool
      L7_2 = L5_2
      L8_2 = "IsPlacedProp"
      L6_2 = L6_2(L7_2, L8_2)
      if L6_2 then
        L6_2 = GetEntityModel
        L7_2 = L5_2
        L6_2 = L6_2(L7_2)
        L7_2 = pairs
        L8_2 = Config
        L8_2 = L8_2.DecorationProps
        L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
        for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
          L13_2 = L16_1
          L14_2 = L12_2.model
          L13_2 = L13_2(L14_2)
          if L13_2 == L6_2 then
            L13_2 = Config
            L13_2 = L13_2.Debug
            if L13_2 then
              L13_2 = print
              L14_2 = "Found decoration prop: "
              L15_2 = L11_2
              L14_2 = L14_2 .. L15_2
              L13_2(L14_2)
            end
            L13_2 = SetupDecorationPropInteraction
            L14_2 = L5_2
            L15_2 = L11_2
            L16_2 = L12_2
            L13_2(L14_2, L15_2, L16_2)
            break
          end
        end
      end
    end
  end
  L1_2 = Config
  L1_2 = L1_2.Debug
  if L1_2 then
    L1_2 = print
    L2_2 = "Target interactions setup complete"
    L1_2(L2_2)
  end
end
SetupTargetInteractions = L19_1
L19_1 = RegisterNetEvent
L20_1 = "fsg_cooking:client:registerTargetForModel"
function L21_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  if not A0_2 then
    return
  end
  L1_2 = nil
  L2_2 = nil
  L3_2 = nil
  L4_2 = pairs
  L5_2 = Config
  L5_2 = L5_2.CookingProps
  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
  for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
    L10_2 = L9_2.model
    if L10_2 == A0_2 then
      L1_2 = L8_2
      L2_2 = L9_2
      L3_2 = "cooking"
      break
    end
  end
  if not L1_2 then
    L4_2 = pairs
    L5_2 = Config
    L5_2 = L5_2.DecorationProps
    L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
    for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
      L10_2 = L9_2.model
      if L10_2 == A0_2 then
        L1_2 = L8_2
        L2_2 = L9_2
        L3_2 = "decoration"
        break
      end
    end
  end
  if not L2_2 then
    L4_2 = print
    L5_2 = "No prop data found for model: "
    L6_2 = A0_2
    L5_2 = L5_2 .. L6_2
    L4_2(L5_2)
    return
  end
  L4_2 = L16_1
  L5_2 = A0_2
  L4_2 = L4_2(L5_2)
  L5_2 = Config
  L5_2 = L5_2.Debug
  if L5_2 then
    L5_2 = print
    L6_2 = "Registering ox_target for specific model: "
    L7_2 = A0_2
    L8_2 = " ("
    L9_2 = L3_2
    L10_2 = ")"
    L6_2 = L6_2 .. L7_2 .. L8_2 .. L9_2 .. L10_2
    L5_2(L6_2)
  end
  L5_2 = GetGamePool
  L6_2 = "CObject"
  L5_2 = L5_2(L6_2)
  L6_2 = 1
  L7_2 = #L5_2
  L8_2 = 1
  for L9_2 = L6_2, L7_2, L8_2 do
    L10_2 = L5_2[L9_2]
    L11_2 = L12_1
    L12_2 = L10_2
    L11_2 = L11_2(L12_2)
    if L11_2 then
      L11_2 = GetEntityModel
      L12_2 = L10_2
      L11_2 = L11_2(L12_2)
      if L11_2 == L4_2 then
        L11_2 = DecorGetBool
        L12_2 = L10_2
        L13_2 = "IsPlacedProp"
        L11_2 = L11_2(L12_2, L13_2)
        if L11_2 then
          if "cooking" == L3_2 then
            L11_2 = SetupCookingPropInteraction
            L12_2 = L10_2
            L13_2 = L1_2
            L14_2 = L2_2
            L11_2(L12_2, L13_2, L14_2)
          elseif "decoration" == L3_2 then
            L11_2 = SetupDecorationPropInteraction
            L12_2 = L10_2
            L13_2 = L1_2
            L14_2 = L2_2
            L11_2(L12_2, L13_2, L14_2)
          end
        end
      end
    end
  end
end
L19_1(L20_1, L21_1)
function L19_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  if A0_2 then
    L1_2 = L12_1
    L2_2 = A0_2
    L1_2 = L1_2(L2_2)
    if L1_2 then
      goto lbl_13
    end
  end
  L1_2 = print
  L2_2 = "No valid entity provided to TryPickupNearbyProp"
  L1_2(L2_2)
  L1_2 = false
  do return L1_2 end
  ::lbl_13::
  L1_2 = GetEntityModel
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = nil
  L3_2 = nil
  L4_2 = nil
  L5_2 = Config
  L5_2 = L5_2.Debug
  if L5_2 then
    L5_2 = print
    L6_2 = "DEBUG - Entity model hash to pick up: "
    L7_2 = tostring
    L8_2 = L1_2
    L7_2 = L7_2(L8_2)
    L6_2 = L6_2 .. L7_2
    L5_2(L6_2)
  end
  L5_2 = pairs
  L6_2 = Config
  L6_2 = L6_2.CookingProps
  L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
  for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
    L11_2 = L16_1
    L12_2 = L10_2.model
    L11_2 = L11_2(L12_2)
    L12_2 = Config
    L12_2 = L12_2.Debug
    if L12_2 then
      L12_2 = print
      L13_2 = "DEBUG - Checking cooking prop "
      L14_2 = L9_2
      L15_2 = " with model hash: "
      L16_2 = tostring
      L17_2 = L11_2
      L16_2 = L16_2(L17_2)
      L13_2 = L13_2 .. L14_2 .. L15_2 .. L16_2
      L12_2(L13_2)
    end
    if L11_2 == L1_2 then
      L2_2 = L9_2
      L3_2 = L10_2
      L4_2 = "cooking"
      L12_2 = Config
      L12_2 = L12_2.Debug
      if L12_2 then
        L12_2 = print
        L13_2 = "DEBUG - Found matching cooking prop: "
        L14_2 = L9_2
        L13_2 = L13_2 .. L14_2
        L12_2(L13_2)
      end
      break
    end
  end
  if not L2_2 then
    L5_2 = pairs
    L6_2 = Config
    L6_2 = L6_2.DecorationProps
    L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
    for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
      L11_2 = L16_1
      L12_2 = L10_2.model
      L11_2 = L11_2(L12_2)
      L12_2 = Config
      L12_2 = L12_2.Debug
      if L12_2 then
        L12_2 = print
        L13_2 = "DEBUG - Checking decoration prop "
        L14_2 = L9_2
        L15_2 = " with model hash: "
        L16_2 = tostring
        L17_2 = L11_2
        L16_2 = L16_2(L17_2)
        L13_2 = L13_2 .. L14_2 .. L15_2 .. L16_2
        L12_2(L13_2)
      end
      if L11_2 == L1_2 then
        L2_2 = L9_2
        L3_2 = L10_2
        L4_2 = "decoration"
        L12_2 = Config
        L12_2 = L12_2.Debug
        if L12_2 then
          L12_2 = print
          L13_2 = "DEBUG - Found matching decoration prop: "
          L14_2 = L9_2
          L13_2 = L13_2 .. L14_2
          L12_2(L13_2)
        end
        break
      end
    end
  end
  if not L2_2 or not L3_2 then
    L5_2 = print
    L6_2 = "Could not determine prop type from model hash: "
    L7_2 = tostring
    L8_2 = L1_2
    L7_2 = L7_2(L8_2)
    L6_2 = L6_2 .. L7_2
    L5_2(L6_2)
    L5_2 = false
    return L5_2
  end
  L5_2 = DecorGetInt
  L6_2 = A0_2
  L7_2 = "PropOwner"
  L5_2 = L5_2(L6_2, L7_2)
  L6_2 = GetPropOwner
  L7_2 = A0_2
  L6_2 = L6_2(L7_2)
  L7_2 = GetPlayerServerId
  L8_2 = PlayerId
  L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L8_2()
  L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  L8_2 = Config
  L8_2 = L8_2.Debug
  if L8_2 then
    L8_2 = print
    L9_2 = "DEBUG - Prop ownership:"
    L8_2(L9_2)
    L8_2 = print
    L9_2 = "- Decor owner: "
    L10_2 = tostring
    L11_2 = L5_2
    L10_2 = L10_2(L11_2)
    L9_2 = L9_2 .. L10_2
    L8_2(L9_2)
    L8_2 = print
    L9_2 = "- Entity state owner: "
    L10_2 = tostring
    L11_2 = L6_2
    L10_2 = L10_2(L11_2)
    L9_2 = L9_2 .. L10_2
    L8_2(L9_2)
    L8_2 = print
    L9_2 = "- Current player: "
    L10_2 = tostring
    L11_2 = L7_2
    L10_2 = L10_2(L11_2)
    L9_2 = L9_2 .. L10_2
    L8_2(L9_2)
    L8_2 = print
    L9_2 = "- Picking up prop type: "
    L10_2 = tostring
    L11_2 = L2_2
    L10_2 = L10_2(L11_2)
    L11_2 = " with model: "
    L12_2 = tostring
    L13_2 = L3_2.model
    L12_2 = L12_2(L13_2)
    L9_2 = L9_2 .. L10_2 .. L11_2 .. L12_2
    L8_2(L9_2)
    L8_2 = print
    L9_2 = "- Prop category: "
    L10_2 = tostring
    L11_2 = L4_2
    L10_2 = L10_2(L11_2)
    L9_2 = L9_2 .. L10_2
    L8_2(L9_2)
  end
  L8_2 = PickUpProp
  L9_2 = A0_2
  L10_2 = L2_2
  L11_2 = L3_2
  L8_2(L9_2, L10_2, L11_2)
  L8_2 = true
  return L8_2
end
TryPickupNearbyProp = L19_1
L19_1 = Config
L19_1 = L19_1.Debug
if L19_1 then
  L19_1 = RegisterCommand
  L20_1 = "cleanupprops"
  function L21_1(A0_2, A1_2, A2_2)
    local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2
    L3_2 = tonumber
    L4_2 = A1_2[1]
    L3_2 = L3_2(L4_2)
    if not L3_2 then
      L3_2 = 5.0
    end
    L4_2 = L10_1
    L5_2 = L11_1
    L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2 = L5_2()
    L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
    L5_2 = 0
    L6_2 = 0
    L7_2 = pairs
    L8_2 = L17_1
    L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
    for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
      L13_2 = L12_2.entity
      if L13_2 then
        L13_2 = L12_1
        L14_2 = L12_2.entity
        L13_2 = L13_2(L14_2)
        if L13_2 then
          L13_2 = L10_1
          L14_2 = L12_2.entity
          L13_2 = L13_2(L14_2)
          L14_2 = L4_2 - L13_2
          L14_2 = #L14_2
          if L3_2 > L14_2 then
            L15_2 = SetEntityAsMissionEntity
            L16_2 = L12_2.entity
            L17_2 = true
            L18_2 = true
            L15_2(L16_2, L17_2, L18_2)
            L15_2 = L13_1
            L16_2 = L12_2.entity
            L15_2(L16_2)
            L15_2 = L17_1
            L15_2[L11_2] = nil
            L6_2 = L6_2 + 1
          end
      end
      else
        L13_2 = L17_1
        L13_2[L11_2] = nil
      end
    end
    L7_2 = GetGamePool
    L8_2 = "CObject"
    L7_2 = L7_2(L8_2)
    L8_2 = ipairs
    L9_2 = L7_2
    L8_2, L9_2, L10_2, L11_2 = L8_2(L9_2)
    for L12_2, L13_2 in L8_2, L9_2, L10_2, L11_2 do
      L14_2 = L12_1
      L15_2 = L13_2
      L14_2 = L14_2(L15_2)
      if L14_2 then
        L14_2 = L10_1
        L15_2 = L13_2
        L14_2 = L14_2(L15_2)
        L15_2 = L4_2 - L14_2
        L15_2 = #L15_2
        if L3_2 > L15_2 then
          L16_2 = GetEntityModel
          L17_2 = L13_2
          L16_2 = L16_2(L17_2)
          L17_2 = false
          L18_2 = pairs
          L19_2 = Config
          L19_2 = L19_2.CookingProps
          L18_2, L19_2, L20_2, L21_2 = L18_2(L19_2)
          for L22_2, L23_2 in L18_2, L19_2, L20_2, L21_2 do
            L24_2 = L16_1
            L25_2 = L23_2.model
            L24_2 = L24_2(L25_2)
            if L24_2 == L16_2 then
              L17_2 = true
              break
            end
          end
          if L17_2 then
            L18_2 = SetEntityAsMissionEntity
            L19_2 = L13_2
            L20_2 = true
            L21_2 = true
            L18_2(L19_2, L20_2, L21_2)
            L18_2 = L13_1
            L19_2 = L13_2
            L18_2(L19_2)
            L5_2 = L5_2 + 1
          end
        end
      end
    end
    L8_2 = lib
    L8_2 = L8_2.notify
    L9_2 = {}
    L9_2.title = "Prop Cleanup"
    L10_2 = "Removed "
    L11_2 = L5_2
    L12_2 = " props from world and "
    L13_2 = L6_2
    L14_2 = " from tracking"
    L10_2 = L10_2 .. L11_2 .. L12_2 .. L13_2 .. L14_2
    L9_2.description = L10_2
    L9_2.type = "success"
    L8_2(L9_2)
  end
  L22_1 = false
  L19_1(L20_1, L21_1, L22_1)
end
function L19_1()
  local L0_2, L1_2, L2_2
  L0_2 = Config
  L0_2 = L0_2.Debug
  if L0_2 then
    L0_2 = print
    L1_2 = "^3[fsg_cooking]^7: Force clearing placement lock"
    L0_2(L1_2)
  end
  L0_2 = false
  L7_1 = L0_2
  L0_2 = lib
  L0_2 = L0_2.callback
  L0_2 = L0_2.await
  L1_2 = "fsg_cooking:server:clearActivePlacement"
  L2_2 = false
  L0_2(L1_2, L2_2)
end
ClearPlacementLock = L19_1
L19_1 = Config
L19_1 = L19_1.Debug
if L19_1 then
  L19_1 = RegisterCommand
  L20_1 = "clearplacement"
  function L21_1()
    local L0_2, L1_2
    L0_2 = ClearPlacementLock
    L0_2()
    L0_2 = lib
    L0_2 = L0_2.notify
    L1_2 = {}
    L1_2.title = "Placement Lock"
    L1_2.description = "Placement lock has been cleared"
    L1_2.type = "success"
    L0_2(L1_2)
  end
  L22_1 = false
  L19_1(L20_1, L21_1, L22_1)
end
L19_1 = CreateThread
function L20_1()
  local L0_2, L1_2
  L0_2 = ClearPlacementLock
  L0_2()
  L0_2 = GetEntityHealth
  L1_2 = L11_1
  L1_2 = L1_2()
  L0_2 = L0_2(L1_2)
  L9_1 = L0_2
  while true do
    L0_2 = Wait
    L1_2 = 60000
    L0_2(L1_2)
    L0_2 = L7_1
    if L0_2 then
      L0_2 = L0_1
      if not L0_2 then
        L0_2 = Config
        L0_2 = L0_2.Debug
        if L0_2 then
          L0_2 = print
          L1_2 = "^3[fsg_cooking]^7: Detected stale placement lock, clearing it"
          L0_2(L1_2)
        end
        L0_2 = ClearPlacementLock
        L0_2()
      end
    end
    L0_2 = Wait
    L1_2 = 1000
    L0_2(L1_2)
  end
end
L19_1(L20_1)
function L19_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  if A0_2 then
    L1_2 = L12_1
    L2_2 = A0_2
    L1_2 = L1_2(L2_2)
    if L1_2 then
      goto lbl_13
    end
  end
  L1_2 = print
  L2_2 = "No valid entity provided to UseProp"
  L1_2(L2_2)
  L1_2 = false
  do return L1_2 end
  ::lbl_13::
  L1_2 = GetEntityModel
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = nil
  L3_2 = nil
  L4_2 = pairs
  L5_2 = Config
  L5_2 = L5_2.CookingProps
  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
  for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
    L10_2 = L16_1
    L11_2 = L9_2.model
    L10_2 = L10_2(L11_2)
    if L10_2 == L1_2 then
      L2_2 = L8_2
      L3_2 = L9_2
      break
    end
  end
  if not L2_2 or not L3_2 then
    L4_2 = print
    L5_2 = "Could not determine prop type from model"
    L4_2(L5_2)
    L4_2 = false
    return L4_2
  end
  L4_2 = print
  L5_2 = "Using prop: "
  L6_2 = L2_2
  L7_2 = " ("
  L8_2 = L3_2.label
  L9_2 = ")"
  L5_2 = L5_2 .. L6_2 .. L7_2 .. L8_2 .. L9_2
  L4_2(L5_2)
  L4_2 = OpenCookingMenu
  L5_2 = A0_2
  L6_2 = L2_2
  L7_2 = L3_2
  L4_2(L5_2, L6_2, L7_2)
  L4_2 = true
  return L4_2
end
UseProp = L19_1
