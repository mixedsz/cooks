local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1
L0_1 = {}
L1_1 = nil
L2_1 = false
L3_1 = {}
L4_1 = nil
framework = nil
ESX = nil
QBCore = nil
L5_1 = 0
L6_1 = 5000
L7_1 = {}
L8_1 = GetResourceState
L9_1 = Config
L9_1 = L9_1.ResourceNames
L9_1 = L9_1.ESX
L8_1 = L8_1(L9_1)
if "started" == L8_1 then
  framework = "esx"
  L8_1 = exports
  L9_1 = Config
  L9_1 = L9_1.ResourceNames
  L9_1 = L9_1.ESX
  L8_1 = L8_1[L9_1]
  L9_1 = L8_1
  L8_1 = L8_1.getSharedObject
  L8_1 = L8_1(L9_1)
  ESX = L8_1
else
  L8_1 = GetResourceState
  L9_1 = Config
  L9_1 = L9_1.ResourceNames
  L9_1 = L9_1.QBCore
  L8_1 = L8_1(L9_1)
  if "started" == L8_1 then
    framework = "qb"
    L8_1 = exports
    L9_1 = Config
    L9_1 = L9_1.ResourceNames
    L9_1 = L9_1.QBCore
    L8_1 = L8_1[L9_1]
    L9_1 = L8_1
    L8_1 = L8_1.GetCoreObject
    L8_1 = L8_1(L9_1)
    QBCore = L8_1
  end
end
function L8_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  if not A1_2 then
    A1_2 = 5.0
  end
  if A0_2 then
    L2_2 = DoesEntityExist
    L3_2 = A0_2
    L2_2 = L2_2(L3_2)
    if L2_2 then
      goto lbl_13
    end
  end
  L2_2 = false
  do return L2_2 end
  ::lbl_13::
  L2_2 = PlayerPedId
  L2_2 = L2_2()
  L3_2 = GetEntityCoords
  L4_2 = L2_2
  L3_2 = L3_2(L4_2)
  L4_2 = GetEntityCoords
  L5_2 = A0_2
  L4_2 = L4_2(L5_2)
  L5_2 = L3_2 - L4_2
  L5_2 = #L5_2
  L5_2 = A1_2 >= L5_2
  return L5_2
end
function L9_1(A0_2)
  local L1_2, L2_2
  L1_2 = framework
  if "esx" == L1_2 then
    L1_2 = ESX
    if L1_2 then
      L1_2 = ESX
      L1_2 = L1_2.GetPlayerData
      L1_2 = L1_2()
      if L1_2 then
        L2_2 = L1_2.identifier
        if L2_2 then
          L2_2 = L1_2.identifier
          return L2_2
        end
      end
  end
  else
    L1_2 = framework
    if "qb" == L1_2 then
      L1_2 = QBCore
      if L1_2 then
        L1_2 = QBCore
        L1_2 = L1_2.Functions
        L1_2 = L1_2.GetPlayerData
        L1_2 = L1_2()
        if L1_2 then
          L2_2 = L1_2.PlayerData
          L2_2 = L2_2.citizenid
          if L2_2 then
            L2_2 = L1_2.PlayerData
            L2_2 = L2_2.citizenid
            return L2_2
          end
        end
      end
    end
  end
  return A0_2
end
function L10_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  if A0_2 then
    L1_2 = DoesEntityExist
    L2_2 = A0_2
    L1_2 = L1_2(L2_2)
    if L1_2 then
      goto lbl_10
    end
  end
  L1_2 = 0
  do return L1_2 end
  ::lbl_10::
  L1_2 = L9_1
  L2_2 = PlayerId
  L2_2, L3_2, L4_2, L5_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2)
  L2_2 = Entity
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L2_2 = L2_2.state
  L2_2 = L2_2.owner
  if not L2_2 then
    L2_2 = 0
  end
  L3_2 = type
  L4_2 = L2_2
  L3_2 = L3_2(L4_2)
  if "string" == L3_2 then
    L4_2 = L2_2
    L3_2 = L2_2.match
    L5_2 = "^char%d+$"
    L3_2 = L3_2(L4_2, L5_2)
    if L3_2 then
      L3_2 = framework
      if "esx" == L3_2 then
        L3_2 = ESX
        if L3_2 then
          L3_2 = ESX
          L3_2 = L3_2.GetPlayerData
          L3_2 = L3_2()
          if L3_2 then
            L4_2 = L3_2.identifier
            if L4_2 then
              L2_2 = L3_2.identifier
              L4_2 = Entity
              L5_2 = A0_2
              L4_2 = L4_2(L5_2)
              L4_2 = L4_2.state
              L4_2.owner = L2_2
            end
          end
      end
      else
        L3_2 = framework
        if "qb" == L3_2 then
          L3_2 = QBCore
          if L3_2 then
            L3_2 = QBCore
            L3_2 = L3_2.Functions
            L3_2 = L3_2.GetPlayerData
            L3_2 = L3_2()
            if L3_2 then
              L4_2 = L3_2.PlayerData
              L4_2 = L4_2.citizenid
              if L4_2 then
                L4_2 = L3_2.PlayerData
                L2_2 = L4_2.citizenid
                L4_2 = Entity
                L5_2 = A0_2
                L4_2 = L4_2(L5_2)
                L4_2 = L4_2.state
                L4_2.owner = L2_2
              end
            end
          end
        end
      end
    end
  end
  return L2_2
end
GetPropOwner = L10_1
function L10_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  if A0_2 then
    L2_2 = DoesEntityExist
    L3_2 = A0_2
    L2_2 = L2_2(L3_2)
    if L2_2 then
      goto lbl_9
    end
  end
  do return end
  ::lbl_9::
  L2_2 = A1_2
  L3_2 = type
  L4_2 = A1_2
  L3_2 = L3_2(L4_2)
  if "number" == L3_2 and A1_2 > 0 then
    L3_2 = L9_1
    L4_2 = A1_2
    L3_2 = L3_2(L4_2)
    L2_2 = L3_2
  else
    L3_2 = type
    L4_2 = A1_2
    L3_2 = L3_2(L4_2)
    if "string" == L3_2 then
      L4_2 = A1_2
      L3_2 = A1_2.match
      L5_2 = "^char%d+$"
      L3_2 = L3_2(L4_2, L5_2)
      if L3_2 then
        L3_2 = framework
        if "esx" == L3_2 then
          L3_2 = ESX
          if L3_2 then
            L3_2 = ESX
            L3_2 = L3_2.GetPlayerData
            L3_2 = L3_2()
            if L3_2 then
              L4_2 = L3_2.identifier
              if L4_2 then
                L2_2 = L3_2.identifier
              end
            end
        end
        else
          L3_2 = framework
          if "qb" == L3_2 then
            L3_2 = QBCore
            if L3_2 then
              L3_2 = QBCore
              L3_2 = L3_2.Functions
              L3_2 = L3_2.GetPlayerData
              L3_2 = L3_2()
              L4_2 = xPlayer
              if L4_2 then
                L4_2 = xPlayer
                L4_2 = L4_2.identifier
                if L4_2 then
                  L4_2 = xPlayer
                  L2_2 = L4_2.identifier
                end
              end
            end
          end
        end
      end
    end
  end
  L3_2 = Entity
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L3_2 = L3_2.state
  L3_2.owner = L2_2
end
SetPropOwner = L10_1
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2
  L0_2 = GetGameTimer
  L0_2 = L0_2()
  L1_2 = L5_1
  L1_2 = L0_2 - L1_2
  L2_2 = L6_1
  if L1_2 < L2_2 then
    return
  end
  L5_1 = L0_2
  L1_2 = PlayerPedId
  L1_2 = L1_2()
  L2_2 = GetEntityCoords
  L3_2 = L1_2
  L2_2 = L2_2(L3_2)
  L3_2 = GetGamePool
  L4_2 = "CObject"
  L3_2 = L3_2(L4_2)
  L4_2 = pairs
  L5_2 = L7_1
  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
  for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
    L10_2 = DoesEntityExist
    L11_2 = L8_2
    L10_2 = L10_2(L11_2)
    if not L10_2 then
      L10_2 = L7_1
      L10_2[L8_2] = nil
    end
  end
  L4_2 = pairs
  L5_2 = Config
  L5_2 = L5_2.CookingProps
  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
  for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
    L10_2 = joaat
    L11_2 = L9_2.model
    L10_2 = L10_2(L11_2)
    L11_2 = 1
    L12_2 = #L3_2
    L13_2 = 1
    for L14_2 = L11_2, L12_2, L13_2 do
      L15_2 = L3_2[L14_2]
      L16_2 = DoesEntityExist
      L17_2 = L15_2
      L16_2 = L16_2(L17_2)
      if L16_2 then
        L16_2 = GetEntityModel
        L17_2 = L15_2
        L16_2 = L16_2(L17_2)
        if L16_2 == L10_2 then
          L16_2 = GetEntityCoords
          L17_2 = L15_2
          L16_2 = L16_2(L17_2)
          L17_2 = L2_2 - L16_2
          L17_2 = #L17_2
          if L17_2 < 15.0 then
            L18_2 = L0_1
            L18_2 = L18_2[L15_2]
            if not L18_2 then
              L18_2 = L7_1
              L18_2 = L18_2[L15_2]
              if not L18_2 then
                L18_2 = SetupCookingPropInteraction
                L19_2 = L15_2
                L20_2 = L8_2
                L21_2 = L9_2
                L18_2(L19_2, L20_2, L21_2)
                L18_2 = L7_1
                L18_2[L15_2] = true
              end
            end
          else
            L18_2 = L7_1
            L18_2 = L18_2[L15_2]
            if L18_2 then
              L18_2 = exports
              L18_2 = L18_2.ox_target
              L19_2 = L18_2
              L18_2 = L18_2.removeLocalEntity
              L20_2 = L15_2
              L18_2(L19_2, L20_2)
              L18_2 = L7_1
              L18_2[L15_2] = nil
              L18_2 = L0_1
              L18_2[L15_2] = nil
            end
          end
        end
      end
    end
  end
end
RefreshCookingProps = L10_1
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2
  L0_2 = GetGameTimer
  L0_2 = L0_2()
  L1_2 = L5_1
  L1_2 = L0_2 - L1_2
  L2_2 = L6_1
  if L1_2 < L2_2 then
    return
  end
  L1_2 = PlayerPedId
  L1_2 = L1_2()
  L2_2 = GetEntityCoords
  L3_2 = L1_2
  L2_2 = L2_2(L3_2)
  L3_2 = GetGamePool
  L4_2 = "CObject"
  L3_2 = L3_2(L4_2)
  L4_2 = Config
  L4_2 = L4_2.Debug
  if L4_2 then
    L4_2 = print
    L5_2 = "DEBUG - RefreshDecorationProps: Found "
    L6_2 = #L3_2
    L7_2 = " objects in game pool"
    L5_2 = L5_2 .. L6_2 .. L7_2
    L4_2(L5_2)
  end
  L4_2 = pairs
  L5_2 = Config
  L5_2 = L5_2.DecorationProps
  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
  for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
    L10_2 = joaat
    L11_2 = L9_2.model
    L10_2 = L10_2(L11_2)
    L11_2 = Config
    L11_2 = L11_2.Debug
    if L11_2 then
      L11_2 = print
      L12_2 = "DEBUG - Checking for decoration prop type: "
      L13_2 = L8_2
      L14_2 = " with model hash: "
      L15_2 = tostring
      L16_2 = L10_2
      L15_2 = L15_2(L16_2)
      L12_2 = L12_2 .. L13_2 .. L14_2 .. L15_2
      L11_2(L12_2)
    end
    if 0 == L10_2 then
      L11_2 = print
      L12_2 = "WARNING: Invalid model name for decoration prop: "
      L13_2 = L8_2
      L12_2 = L12_2 .. L13_2
      L11_2(L12_2)
    else
      L11_2 = 1
      L12_2 = #L3_2
      L13_2 = 1
      for L14_2 = L11_2, L12_2, L13_2 do
        L15_2 = L3_2[L14_2]
        L16_2 = DoesEntityExist
        L17_2 = L15_2
        L16_2 = L16_2(L17_2)
        if L16_2 then
          L16_2 = GetEntityModel
          L17_2 = L15_2
          L16_2 = L16_2(L17_2)
          if L16_2 == L10_2 then
            L17_2 = GetEntityCoords
            L18_2 = L15_2
            L17_2 = L17_2(L18_2)
            L18_2 = L2_2 - L17_2
            L18_2 = #L18_2
            L19_2 = Config
            L19_2 = L19_2.Debug
            if L19_2 then
              L19_2 = print
              L20_2 = "DEBUG - Found decoration prop "
              L21_2 = L8_2
              L22_2 = " at distance "
              L23_2 = L18_2
              L20_2 = L20_2 .. L21_2 .. L22_2 .. L23_2
              L19_2(L20_2)
            end
            if L18_2 < 15.0 then
              L19_2 = L0_1
              L19_2 = L19_2[L15_2]
              if not L19_2 then
                L19_2 = L7_1
                L19_2 = L19_2[L15_2]
                if not L19_2 then
                  L19_2 = Config
                  L19_2 = L19_2.Debug
                  if L19_2 then
                    L19_2 = print
                    L20_2 = "DEBUG - Setting up interaction for decoration prop: "
                    L21_2 = L8_2
                    L20_2 = L20_2 .. L21_2
                    L19_2(L20_2)
                  end
                  L19_2 = SetupDecorationPropInteraction
                  L20_2 = L15_2
                  L21_2 = L8_2
                  L22_2 = L9_2
                  L19_2(L20_2, L21_2, L22_2)
                  L19_2 = L7_1
                  L19_2[L15_2] = true
                end
              end
            else
              L19_2 = L7_1
              L19_2 = L19_2[L15_2]
              if L19_2 then
                L19_2 = exports
                L19_2 = L19_2.ox_target
                L20_2 = L19_2
                L19_2 = L19_2.removeLocalEntity
                L21_2 = L15_2
                L19_2(L20_2, L21_2)
                L19_2 = L7_1
                L19_2[L15_2] = nil
                L19_2 = L0_1
                L19_2[L15_2] = nil
              end
            end
          end
        end
      end
    end
  end
  L4_2 = GetGameTimer
  L4_2 = L4_2()
  L5_1 = L4_2
end
RefreshDecorationProps = L10_1
function L10_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L3_2 = DoesEntityExist
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  if not L3_2 then
    return
  end
  L3_2 = L0_1
  L3_2[A0_2] = true
  L3_2 = L9_1
  L4_2 = PlayerId
  L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L4_2()
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L4_2 = exports
  L4_2 = L4_2.ox_target
  L5_2 = L4_2
  L4_2 = L4_2.addLocalEntity
  L6_2 = A0_2
  L7_2 = {}
  L8_2 = {}
  L9_2 = "cooking_"
  L10_2 = A1_2
  L9_2 = L9_2 .. L10_2
  L8_2.name = L9_2
  L8_2.icon = "fas fa-utensils"
  L9_2 = "Use "
  L10_2 = A2_2.label
  L9_2 = L9_2 .. L10_2
  L8_2.label = L9_2
  function L9_2(A0_3, A1_3, A2_3)
    local L3_3, L4_3, L5_3
    L3_3 = GetPropOwner
    L4_3 = A0_2
    L3_3 = L3_3(L4_3)
    L4_3 = L9_1
    L5_3 = PlayerId
    L5_3 = L5_3()
    L4_3 = L4_3(L5_3)
    L5_3 = L3_3 == L4_3 and A1_3 < 2.0
    return L5_3
  end
  L8_2.canInteract = L9_2
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3
    L0_3 = OpenCookingMenu
    L1_3 = A0_2
    L2_3 = A1_2
    L3_3 = A2_2
    L0_3(L1_3, L2_3, L3_3)
  end
  L8_2.onSelect = L9_2
  L9_2 = {}
  L10_2 = "pickup_"
  L11_2 = A1_2
  L10_2 = L10_2 .. L11_2
  L9_2.name = L10_2
  L9_2.icon = "fas fa-hand-holding"
  L10_2 = "Pick Up "
  L11_2 = A2_2.label
  L10_2 = L10_2 .. L11_2
  L9_2.label = L10_2
  function L10_2(A0_3, A1_3, A2_3)
    local L3_3, L4_3, L5_3
    L3_3 = GetPropOwner
    L4_3 = A0_2
    L3_3 = L3_3(L4_3)
    L4_3 = L9_1
    L5_3 = PlayerId
    L5_3 = L5_3()
    L4_3 = L4_3(L5_3)
    L5_3 = L3_3 == L4_3 and A1_3 < 2.0
    return L5_3
  end
  L9_2.canInteract = L10_2
  function L10_2()
    local L0_3, L1_3, L2_3, L3_3
    L0_3 = PickUpProp
    L1_3 = A0_2
    L2_3 = A1_2
    L3_3 = A2_2
    L0_3(L1_3, L2_3, L3_3)
  end
  L9_2.onSelect = L10_2
  L7_2[1] = L8_2
  L7_2[2] = L9_2
  L4_2(L5_2, L6_2, L7_2)
end
SetupCookingPropInteraction = L10_1
function L10_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L3_2 = DoesEntityExist
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  if not L3_2 then
    return
  end
  L3_2 = L0_1
  L3_2[A0_2] = true
  L3_2 = L9_1
  L4_2 = PlayerId
  L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L4_2()
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L4_2 = exports
  L4_2 = L4_2.ox_target
  L5_2 = L4_2
  L4_2 = L4_2.addLocalEntity
  L6_2 = A0_2
  L7_2 = {}
  L8_2 = {}
  L9_2 = "pickup_"
  L10_2 = A1_2
  L9_2 = L9_2 .. L10_2
  L8_2.name = L9_2
  L8_2.icon = "fas fa-hand-holding"
  L9_2 = "Pick Up "
  L10_2 = A2_2.label
  L9_2 = L9_2 .. L10_2
  L8_2.label = L9_2
  function L9_2(A0_3, A1_3, A2_3)
    local L3_3, L4_3, L5_3
    L3_3 = GetPropOwner
    L4_3 = A0_2
    L3_3 = L3_3(L4_3)
    L4_3 = L9_1
    L5_3 = PlayerId
    L5_3 = L5_3()
    L4_3 = L4_3(L5_3)
    L5_3 = L3_3 == L4_3 and A1_3 < 2.0
    return L5_3
  end
  L8_2.canInteract = L9_2
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3
    L0_3 = PickUpProp
    L1_3 = A0_2
    L2_3 = A1_2
    L3_3 = A2_2
    L0_3(L1_3, L2_3, L3_3)
  end
  L8_2.onSelect = L9_2
  L7_2[1] = L8_2
  L4_2(L5_2, L6_2, L7_2)
end
SetupDecorationPropInteraction = L10_1
function L10_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2
  L3_2 = RefreshCookingProps
  L3_2()
  L3_2 = L8_1
  L4_2 = A0_2
  L5_2 = 2.0
  L3_2 = L3_2(L4_2, L5_2)
  if not L3_2 then
    L3_2 = lib
    L3_2 = L3_2.notify
    L4_2 = {}
    L4_2.title = "Error"
    L4_2.description = "You are too far away from the cooking appliance"
    L4_2.type = "error"
    L3_2(L4_2)
    return
  end
  L3_2 = GetPropOwner
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = L9_1
  L5_2 = PlayerId
  L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2 = L5_2()
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
  if L3_2 ~= L4_2 then
    L5_2 = lib
    L5_2 = L5_2.notify
    L6_2 = {}
    L6_2.title = "Error"
    L6_2.description = "You cannot use this cooking appliance"
    L6_2.type = "error"
    L5_2(L6_2)
    return
  end
  L1_1 = A0_2
  L5_2 = {}
  L6_2 = nil
  L7_2 = {}
  L6_2 = L7_2
  L7_2 = pairs
  L8_2 = Config
  L8_2 = L8_2.Recipes
  L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
  for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
    L13_2 = L12_2.appliance
    if L13_2 == A1_2 then
      L6_2[L11_2] = L12_2
    end
  end
  L7_2 = pairs
  L8_2 = L6_2
  L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
  for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
    L13_2 = false
    L14_2 = L12_2.label
    L15_2 = GetRecipeDescription
    L16_2 = L12_2
    L15_2 = L15_2(L16_2)
    L16_2 = L12_2.resultItems
    L16_2 = L16_2[1]
    L16_2 = L16_2.item
    L17_2 = table
    L17_2 = L17_2.insert
    L18_2 = L5_2
    L19_2 = {}
    L19_2.title = L14_2
    L19_2.description = L15_2
    if L13_2 then
      L20_2 = "lock"
      if L20_2 then
        goto lbl_83
      end
    end
    L20_2 = "https://cfx-nui-ox_inventory/web/images/"
    L21_2 = L16_2
    L22_2 = ".png"
    L20_2 = L20_2 .. L21_2 .. L22_2
    ::lbl_83::
    L19_2.icon = L20_2
    L19_2.disabled = L13_2
    function L20_2()
      local L0_3, L1_3, L2_3, L3_3
      L0_3 = L13_2
      if not L0_3 then
        L0_3 = StartCooking
        L1_3 = A0_2
        L2_3 = L11_2
        L3_3 = L12_2
        L0_3(L1_3, L2_3, L3_3)
      else
        L0_3 = lib
        L0_3 = L0_3.notify
        L1_3 = {}
        L1_3.title = "Recipe Locked"
        L1_3.description = "You need more cooking experience to make this recipe"
        L1_3.type = "error"
        L0_3(L1_3)
      end
    end
    L19_2.onSelect = L20_2
    L17_2(L18_2, L19_2)
  end
  L7_2 = table
  L7_2 = L7_2.insert
  L8_2 = L5_2
  L9_2 = {}
  L9_2.title = "Close Menu"
  L9_2.icon = "xmark"
  function L10_2()
    local L0_3, L1_3
  end
  L9_2.onSelect = L10_2
  L7_2(L8_2, L9_2)
  L7_2 = lib
  L7_2 = L7_2.registerContext
  L8_2 = {}
  L8_2.id = "cooking_menu"
  L9_2 = "Cooking Menu - "
  L10_2 = A2_2.label
  L9_2 = L9_2 .. L10_2
  L8_2.title = L9_2
  L8_2.options = L5_2
  L7_2(L8_2)
  L7_2 = lib
  L7_2 = L7_2.showContext
  L8_2 = "cooking_menu"
  L7_2(L8_2)
end
OpenCookingMenu = L10_1
function L10_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  if A0_2 then
    L1_2 = A0_2.requiredItems
    if L1_2 then
      goto lbl_8
    end
  end
  L1_2 = "Invalid recipe"
  do return L1_2 end
  ::lbl_8::
  L1_2 = "Ingredients: "
  L2_2 = ipairs
  L3_2 = A0_2.requiredItems
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = L1_2
    L9_2 = L7_2.count
    L10_2 = "x "
    L11_2 = L7_2.item
    L8_2 = L8_2 .. L9_2 .. L10_2 .. L11_2
    L1_2 = L8_2
    L8_2 = A0_2.requiredItems
    L8_2 = #L8_2
    if L6_2 < L8_2 then
      L8_2 = L1_2
      L9_2 = ", "
      L8_2 = L8_2 .. L9_2
      L1_2 = L8_2
    end
  end
  L2_2 = 0
  L3_2 = A0_2.cookingFlow
  if L3_2 then
    L3_2 = ipairs
    L4_2 = A0_2.cookingFlow
    L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
    for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
      L9_2 = L8_2.time
      if not L9_2 then
        L9_2 = 0
      end
      L2_2 = L2_2 + L9_2
    end
    L3_2 = L1_2
    L4_2 = [[

Cooking Time: ]]
    L5_2 = L2_2
    L6_2 = " seconds"
    L3_2 = L3_2 .. L4_2 .. L5_2 .. L6_2
    L1_2 = L3_2
    L3_2 = L1_2
    L4_2 = [[

Steps: ]]
    L5_2 = A0_2.cookingFlow
    L5_2 = #L5_2
    L3_2 = L3_2 .. L4_2 .. L5_2
    L1_2 = L3_2
  else
    L3_2 = L1_2
    L4_2 = [[

Cooking Time: ]]
    L5_2 = A0_2.time
    if not L5_2 then
      L5_2 = 0
    end
    L6_2 = " seconds"
    L3_2 = L3_2 .. L4_2 .. L5_2 .. L6_2
    L1_2 = L3_2
  end
  return L1_2
end
GetRecipeDescription = L10_1
function L10_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2
  if A0_2 then
    L2_2 = DoesEntityExist
    L3_2 = A0_2
    L2_2 = L2_2(L3_2)
    if L2_2 then
      goto lbl_9
    end
  end
  do return end
  ::lbl_9::
  L2_2 = Config
  L2_2 = L2_2.CookingProps
  L2_2 = L2_2[A1_2]
  if L2_2 then
    L3_2 = L2_2.effects
    if L3_2 then
      goto lbl_18
    end
  end
  do return end
  ::lbl_18::
  L3_2 = Config
  L3_2 = L3_2.DebugEffects
  if L3_2 then
    L3_2 = print
    L4_2 = "-------------------"
    L3_2(L4_2)
    L3_2 = print
    L4_2 = "DEBUG EFFECTS: Starting effects for "
    L5_2 = A1_2
    L4_2 = L4_2 .. L5_2
    L3_2(L4_2)
    L3_2 = print
    L4_2 = "Entity ID: "
    L5_2 = A0_2
    L4_2 = L4_2 .. L5_2
    L3_2(L4_2)
    L3_2 = print
    L4_2 = "Available effects: "
    L5_2 = json
    L5_2 = L5_2.encode
    L6_2 = L2_2.effects
    L5_2 = L5_2(L6_2)
    L4_2 = L4_2 .. L5_2
    L3_2(L4_2)
    L3_2 = print
    L4_2 = "-------------------"
    L3_2(L4_2)
  end
  L3_2 = pairs
  L4_2 = L2_2.effects
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = L3_1
    L9_2 = L9_2[A0_2]
    if not L9_2 then
      L9_2 = L3_1
      L10_2 = {}
      L9_2[A0_2] = L10_2
    end
    L9_2 = "core"
    if "smoke" == L7_2 or "steam" == L7_2 or "bbq" == L7_2 or "fire" == L7_2 then
      L9_2 = "core"
    end
    L10_2 = Config
    L10_2 = L10_2.DebugEffects
    if L10_2 then
      L10_2 = print
      L11_2 = "Starting "
      L12_2 = L7_2
      L13_2 = " effect using dictionary: "
      L14_2 = L9_2
      L11_2 = L11_2 .. L12_2 .. L13_2 .. L14_2
      L10_2(L11_2)
      L10_2 = print
      L11_2 = "Effect name: "
      L12_2 = L8_2.name
      L11_2 = L11_2 .. L12_2
      L10_2(L11_2)
      L10_2 = print
      L11_2 = "Offset: "
      L12_2 = json
      L12_2 = L12_2.encode
      L13_2 = L8_2.offset
      L12_2 = L12_2(L13_2)
      L11_2 = L11_2 .. L12_2
      L10_2(L11_2)
      L10_2 = print
      L11_2 = "Scale: "
      L12_2 = tostring
      L13_2 = L8_2.scale
      L12_2 = L12_2(L13_2)
      L11_2 = L11_2 .. L12_2
      L10_2(L11_2)
    end
    L10_2 = RequestNamedPtfxAsset
    L11_2 = L9_2
    L10_2(L11_2)
    L10_2 = GetGameTimer
    L10_2 = L10_2()
    while true do
      L11_2 = HasNamedPtfxAssetLoaded
      L12_2 = L9_2
      L11_2 = L11_2(L12_2)
      if L11_2 then
        break
      end
      L11_2 = Wait
      L12_2 = 10
      L11_2(L12_2)
      L11_2 = GetGameTimer
      L11_2 = L11_2()
      L11_2 = L11_2 - L10_2
      L12_2 = 2000
      if L11_2 > L12_2 then
        L11_2 = Config
        L11_2 = L11_2.DebugEffects
        if L11_2 then
          L11_2 = print
          L12_2 = "WARNING: Timed out waiting for ptfx asset to load"
          L11_2(L12_2)
        end
        break
      end
    end
    L11_2 = Config
    L11_2 = L11_2.DebugEffects
    if L11_2 then
      L11_2 = print
      L12_2 = "Ptfx asset loaded: "
      L13_2 = tostring
      L14_2 = HasNamedPtfxAssetLoaded
      L15_2 = L9_2
      L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2 = L14_2(L15_2)
      L13_2 = L13_2(L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2)
      L12_2 = L12_2 .. L13_2
      L11_2(L12_2)
    end
    L11_2 = GetEntityCoords
    L12_2 = A0_2
    L11_2 = L11_2(L12_2)
    L12_2 = L8_2.offset
    if not L12_2 then
      L12_2 = vec3
      L13_2 = 0.0
      L14_2 = 0.0
      L15_2 = 0.0
      L12_2 = L12_2(L13_2, L14_2, L15_2)
    end
    L13_2 = UseParticleFxAssetNextCall
    L14_2 = L9_2
    L13_2(L14_2)
    L13_2 = Config
    L13_2 = L13_2.DebugEffects
    if L13_2 and "smoke" == L7_2 then
      L13_2 = {}
      L14_2 = L8_2.name
      L15_2 = "ent_amb_smoke_factory_white"
      L16_2 = "ent_amb_smoke_gaswork"
      L17_2 = "exp_grd_bzgas_smoke"
      L18_2 = "ent_amb_smoke_scrap"
      L19_2 = "ent_amb_smoke_foundry"
      L13_2[1] = L14_2
      L13_2[2] = L15_2
      L13_2[3] = L16_2
      L13_2[4] = L17_2
      L13_2[5] = L18_2
      L13_2[6] = L19_2
      L14_2 = ipairs
      L15_2 = L13_2
      L14_2, L15_2, L16_2, L17_2 = L14_2(L15_2)
      for L18_2, L19_2 in L14_2, L15_2, L16_2, L17_2 do
        L20_2 = UseParticleFxAssetNextCall
        L21_2 = L9_2
        L20_2(L21_2)
        L20_2 = StartParticleFxLoopedOnEntity
        L21_2 = L19_2
        L22_2 = A0_2
        L23_2 = L12_2.x
        L24_2 = L12_2.y
        L25_2 = L12_2.z
        L26_2 = 0.0
        L27_2 = 0.0
        L28_2 = 0.0
        L29_2 = L8_2.scale
        if not L29_2 then
          L29_2 = 1.0
        end
        L30_2 = false
        L31_2 = false
        L32_2 = false
        L20_2 = L20_2(L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2)
        if L20_2 and -1 ~= L20_2 then
          L21_2 = Config
          L21_2 = L21_2.DebugEffects
          if L21_2 then
            L21_2 = print
            L22_2 = "SUCCESS: Effect "
            L23_2 = L19_2
            L24_2 = " created with ID "
            L25_2 = L20_2
            L22_2 = L22_2 .. L23_2 .. L24_2 .. L25_2
            L21_2(L22_2)
          end
          if 1 == L18_2 then
            L21_2 = L3_1
            L21_2 = L21_2[A0_2]
            L21_2[L7_2] = L20_2
            break
          end
          L21_2 = StopParticleFxLooped
          L22_2 = L20_2
          L23_2 = false
          L21_2(L22_2, L23_2)
          L21_2 = UseParticleFxAssetNextCall
          L22_2 = L9_2
          L21_2(L22_2)
          L21_2 = StartParticleFxLoopedOnEntity
          L22_2 = L19_2
          L23_2 = A0_2
          L24_2 = L12_2.x
          L25_2 = L12_2.y
          L26_2 = L12_2.z
          L27_2 = 0.0
          L28_2 = 0.0
          L29_2 = 0.0
          L30_2 = L8_2.scale
          if not L30_2 then
            L30_2 = 1.0
          end
          L31_2 = false
          L32_2 = false
          L33_2 = false
          L21_2 = L21_2(L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2)
          L22_2 = L3_1
          L22_2 = L22_2[A0_2]
          L22_2[L7_2] = L21_2
          L22_2 = Config
          L22_2 = L22_2.DebugEffects
          if L22_2 then
            L22_2 = print
            L23_2 = "Using "
            L24_2 = L19_2
            L25_2 = " instead of "
            L26_2 = L8_2.name
            L23_2 = L23_2 .. L24_2 .. L25_2 .. L26_2
            L22_2(L23_2)
          end
          L22_2 = L2_2.effects
          L22_2 = L22_2[L7_2]
          L22_2.name = L19_2
          break
        else
          L21_2 = print
          L22_2 = "FAILED: Effect "
          L23_2 = L19_2
          L24_2 = " did not create"
          L22_2 = L22_2 .. L23_2 .. L24_2
          L21_2(L22_2)
          if L18_2 > 1 then
            L21_2 = StopParticleFxLooped
            L22_2 = L20_2
            L23_2 = false
            L21_2(L22_2, L23_2)
          end
          L21_2 = Wait
          L22_2 = 100
          L21_2(L22_2)
        end
      end
    else
      L13_2 = Config
      L13_2 = L13_2.DebugEffects
      if L13_2 and "fire" == L7_2 then
        L13_2 = {}
        L14_2 = L8_2.name
        L15_2 = "ent_amb_BBQ_fire"
        L16_2 = "ent_amb_fire_ring"
        L17_2 = "ent_amb_torch_fire"
        L18_2 = "fire_wrecked_plane_cockpit"
        L19_2 = "ent_ray_heli_aprtmnt_l_fire"
        L13_2[1] = L14_2
        L13_2[2] = L15_2
        L13_2[3] = L16_2
        L13_2[4] = L17_2
        L13_2[5] = L18_2
        L13_2[6] = L19_2
        L14_2 = ipairs
        L15_2 = L13_2
        L14_2, L15_2, L16_2, L17_2 = L14_2(L15_2)
        for L18_2, L19_2 in L14_2, L15_2, L16_2, L17_2 do
          L20_2 = UseParticleFxAssetNextCall
          L21_2 = L9_2
          L20_2(L21_2)
          L20_2 = StartParticleFxLoopedOnEntity
          L21_2 = L19_2
          L22_2 = A0_2
          L23_2 = L12_2.x
          L24_2 = L12_2.y
          L25_2 = L12_2.z
          L26_2 = 0.0
          L27_2 = 0.0
          L28_2 = 0.0
          L29_2 = L8_2.scale
          if not L29_2 then
            L29_2 = 1.0
          end
          L30_2 = false
          L31_2 = false
          L32_2 = false
          L20_2 = L20_2(L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2)
          if L20_2 and -1 ~= L20_2 then
            L21_2 = Config
            L21_2 = L21_2.DebugEffects
            if L21_2 then
              L21_2 = print
              L22_2 = "SUCCESS: Effect "
              L23_2 = L19_2
              L24_2 = " created with ID "
              L25_2 = L20_2
              L22_2 = L22_2 .. L23_2 .. L24_2 .. L25_2
              L21_2(L22_2)
            end
            if 1 == L18_2 then
              L21_2 = L3_1
              L21_2 = L21_2[A0_2]
              L21_2[L7_2] = L20_2
              break
            end
            L21_2 = StopParticleFxLooped
            L22_2 = L20_2
            L23_2 = false
            L21_2(L22_2, L23_2)
            L21_2 = UseParticleFxAssetNextCall
            L22_2 = L9_2
            L21_2(L22_2)
            L21_2 = StartParticleFxLoopedOnEntity
            L22_2 = L19_2
            L23_2 = A0_2
            L24_2 = L12_2.x
            L25_2 = L12_2.y
            L26_2 = L12_2.z
            L27_2 = 0.0
            L28_2 = 0.0
            L29_2 = 0.0
            L30_2 = L8_2.scale
            if not L30_2 then
              L30_2 = 1.0
            end
            L31_2 = false
            L32_2 = false
            L33_2 = false
            L21_2 = L21_2(L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2)
            L22_2 = L3_1
            L22_2 = L22_2[A0_2]
            L22_2[L7_2] = L21_2
            L22_2 = Config
            L22_2 = L22_2.DebugEffects
            if L22_2 then
              L22_2 = print
              L23_2 = "Using "
              L24_2 = L19_2
              L25_2 = " instead of "
              L26_2 = L8_2.name
              L23_2 = L23_2 .. L24_2 .. L25_2 .. L26_2
              L22_2(L23_2)
            end
            L22_2 = L2_2.effects
            L22_2 = L22_2[L7_2]
            L22_2.name = L19_2
            break
          else
            L21_2 = print
            L22_2 = "FAILED: Effect "
            L23_2 = L19_2
            L24_2 = " did not create"
            L22_2 = L22_2 .. L23_2 .. L24_2
            L21_2(L22_2)
            if L18_2 > 1 then
              L21_2 = StopParticleFxLooped
              L22_2 = L20_2
              L23_2 = false
              L21_2(L22_2, L23_2)
            end
            L21_2 = Wait
            L22_2 = 100
            L21_2(L22_2)
          end
        end
      else
        L13_2 = nil
        if "smoke" == L7_2 then
          L14_2 = StartParticleFxLoopedOnEntity
          L15_2 = L8_2.name
          L16_2 = A0_2
          L17_2 = L12_2.x
          L18_2 = L12_2.y
          L19_2 = L12_2.z
          L20_2 = 0.0
          L21_2 = 0.0
          L22_2 = 0.0
          L23_2 = L8_2.scale
          if not L23_2 then
            L23_2 = 1.0
          end
          L24_2 = false
          L25_2 = false
          L26_2 = false
          L14_2 = L14_2(L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
          L13_2 = L14_2
        elseif "steam" == L7_2 then
          L14_2 = StartParticleFxLoopedOnEntity
          L15_2 = L8_2.name
          L16_2 = A0_2
          L17_2 = L12_2.x
          L18_2 = L12_2.y
          L19_2 = L12_2.z
          L20_2 = 0.0
          L21_2 = 0.0
          L22_2 = 0.0
          L23_2 = L8_2.scale
          if not L23_2 then
            L23_2 = 1.0
          end
          L24_2 = false
          L25_2 = false
          L26_2 = false
          L14_2 = L14_2(L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
          L13_2 = L14_2
        elseif "fire" == L7_2 then
          L14_2 = StartParticleFxLoopedOnEntity
          L15_2 = L8_2.name
          L16_2 = A0_2
          L17_2 = L12_2.x
          L18_2 = L12_2.y
          L19_2 = L12_2.z
          L20_2 = 0.0
          L21_2 = 0.0
          L22_2 = 0.0
          L23_2 = L8_2.scale
          if not L23_2 then
            L23_2 = 1.0
          end
          L24_2 = false
          L25_2 = false
          L26_2 = false
          L14_2 = L14_2(L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
          L13_2 = L14_2
        end
        if L13_2 and -1 ~= L13_2 then
          L14_2 = L3_1
          L14_2 = L14_2[A0_2]
          L14_2[L7_2] = L13_2
          L14_2 = Config
          L14_2 = L14_2.DebugEffects
          if L14_2 then
            L14_2 = print
            L15_2 = "DEBUG - Started "
            L16_2 = L7_2
            L17_2 = " effect on "
            L18_2 = A1_2
            L19_2 = ", effectId: "
            L20_2 = tostring
            L21_2 = L13_2
            L20_2 = L20_2(L21_2)
            L15_2 = L15_2 .. L16_2 .. L17_2 .. L18_2 .. L19_2 .. L20_2
            L14_2(L15_2)
          end
        else
          L14_2 = Config
          L14_2 = L14_2.DebugEffects
          if L14_2 then
            L14_2 = print
            L15_2 = "WARNING - Failed to start "
            L16_2 = L7_2
            L17_2 = " effect on "
            L18_2 = A1_2
            L15_2 = L15_2 .. L16_2 .. L17_2 .. L18_2
            L14_2(L15_2)
          end
          if "smoke" == L7_2 then
            L14_2 = UseParticleFxAssetNextCall
            L15_2 = L9_2
            L14_2(L15_2)
            L14_2 = StartParticleFxLoopedOnEntity
            L15_2 = "ent_amb_smoke_factory_white"
            L16_2 = A0_2
            L17_2 = L12_2.x
            L18_2 = L12_2.y
            L19_2 = L12_2.z
            L20_2 = 0.0
            L21_2 = 0.0
            L22_2 = 0.0
            L23_2 = L8_2.scale
            if not L23_2 then
              L23_2 = 1.0
            end
            L24_2 = false
            L25_2 = false
            L26_2 = false
            L14_2 = L14_2(L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
            L13_2 = L14_2
            if L13_2 and -1 ~= L13_2 then
              L14_2 = L3_1
              L14_2 = L14_2[A0_2]
              L14_2[L7_2] = L13_2
              L14_2 = Config
              L14_2 = L14_2.DebugEffects
              if L14_2 then
                L14_2 = print
                L15_2 = "DEBUG - Started alternative smoke effect on "
                L16_2 = A1_2
                L17_2 = ", effectId: "
                L18_2 = tostring
                L19_2 = L13_2
                L18_2 = L18_2(L19_2)
                L15_2 = L15_2 .. L16_2 .. L17_2 .. L18_2
                L14_2(L15_2)
              end
            end
          elseif "fire" == L7_2 then
            L14_2 = UseParticleFxAssetNextCall
            L15_2 = L9_2
            L14_2(L15_2)
            L14_2 = StartParticleFxLoopedOnEntity
            L15_2 = "ent_amb_torch_fire"
            L16_2 = A0_2
            L17_2 = L12_2.x
            L18_2 = L12_2.y
            L19_2 = L12_2.z
            L20_2 = 0.0
            L21_2 = 0.0
            L22_2 = 0.0
            L23_2 = L8_2.scale
            if not L23_2 then
              L23_2 = 1.0
            end
            L24_2 = false
            L25_2 = false
            L26_2 = false
            L14_2 = L14_2(L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
            L13_2 = L14_2
            if L13_2 and -1 ~= L13_2 then
              L14_2 = L3_1
              L14_2 = L14_2[A0_2]
              L14_2[L7_2] = L13_2
              L14_2 = Config
              L14_2 = L14_2.DebugEffects
              if L14_2 then
                L14_2 = print
                L15_2 = "DEBUG - Started alternative fire effect on "
                L16_2 = A1_2
                L17_2 = ", effectId: "
                L18_2 = tostring
                L19_2 = L13_2
                L18_2 = L18_2(L19_2)
                L15_2 = L15_2 .. L16_2 .. L17_2 .. L18_2
                L14_2(L15_2)
              end
            end
          end
        end
      end
    end
  end
end
StartApplianceEffects = L10_1
function L10_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  if A0_2 then
    L1_2 = L3_1
    L1_2 = L1_2[A0_2]
    if L1_2 then
      goto lbl_8
    end
  end
  do return end
  ::lbl_8::
  L1_2 = pairs
  L2_2 = L3_1
  L2_2 = L2_2[A0_2]
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    if L6_2 then
      L7_2 = StopParticleFxLooped
      L8_2 = L6_2
      L9_2 = false
      L7_2(L8_2, L9_2)
      L7_2 = Config
      L7_2 = L7_2.Debug
      if L7_2 then
        L7_2 = print
        L8_2 = "DEBUG - Stopped "
        L9_2 = L5_2
        L10_2 = " effect"
        L8_2 = L8_2 .. L9_2 .. L10_2
        L7_2(L8_2)
      end
    end
  end
  L1_2 = L3_1
  L1_2[A0_2] = nil
end
StopApplianceEffects = L10_1
function L10_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2
  L1_2 = RemoveCookingHandProp
  L1_2()
  L1_2 = Config
  L1_2 = L1_2.CookingProps
  L1_2 = L1_2[A0_2]
  if L1_2 then
    L1_2 = Config
    L1_2 = L1_2.CookingProps
    L1_2 = L1_2[A0_2]
    L1_2 = L1_2.handProp
    if L1_2 then
      goto lbl_15
    end
  end
  do return end
  ::lbl_15::
  L1_2 = Config
  L1_2 = L1_2.CookingProps
  L1_2 = L1_2[A0_2]
  L1_2 = L1_2.handProp
  if L1_2 then
    L2_2 = L1_2.model
    if L2_2 then
      goto lbl_25
    end
  end
  do return end
  ::lbl_25::
  L2_2 = joaat
  L3_2 = L1_2.model
  L2_2 = L2_2(L3_2)
  L3_2 = RequestModel
  L4_2 = L2_2
  L3_2(L4_2)
  L3_2 = GetGameTimer
  L3_2 = L3_2()
  while true do
    L4_2 = HasModelLoaded
    L5_2 = L2_2
    L4_2 = L4_2(L5_2)
    if L4_2 then
      break
    end
    L4_2 = Wait
    L5_2 = 0
    L4_2(L5_2)
    L4_2 = GetGameTimer
    L4_2 = L4_2()
    L4_2 = L4_2 - L3_2
    L5_2 = 5000
    if L4_2 > L5_2 then
      return
    end
  end
  L4_2 = PlayerPedId
  L4_2 = L4_2()
  L5_2 = CreateObject
  L6_2 = L2_2
  L7_2 = 0.0
  L8_2 = 0.0
  L9_2 = 0.0
  L10_2 = true
  L11_2 = true
  L12_2 = true
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  if not L5_2 or 0 == L5_2 then
    L6_2 = SetModelAsNoLongerNeeded
    L7_2 = L2_2
    L6_2(L7_2)
    return
  end
  L6_2 = GetPedBoneIndex
  L7_2 = L4_2
  L8_2 = L1_2.bone
  if not L8_2 then
    L8_2 = 57005
  end
  L6_2 = L6_2(L7_2, L8_2)
  L7_2 = AttachEntityToEntity
  L8_2 = L5_2
  L9_2 = L4_2
  L10_2 = L6_2
  L11_2 = L1_2.offset
  L11_2 = L11_2.x
  if not L11_2 then
    L11_2 = 0.12
  end
  L12_2 = L1_2.offset
  L12_2 = L12_2.y
  if not L12_2 then
    L12_2 = 0.0
  end
  L13_2 = L1_2.offset
  L13_2 = L13_2.z
  if not L13_2 then
    L13_2 = 0.0
  end
  L14_2 = L1_2.rotation
  L14_2 = L14_2.x
  if not L14_2 then
    L14_2 = 0.0
  end
  L15_2 = L1_2.rotation
  L15_2 = L15_2.y
  if not L15_2 then
    L15_2 = -60.0
  end
  L16_2 = L1_2.rotation
  L16_2 = L16_2.z
  if not L16_2 then
    L16_2 = 0.0
  end
  L17_2 = false
  L18_2 = false
  L19_2 = false
  L20_2 = false
  L21_2 = 2
  L22_2 = true
  L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
  L4_1 = L5_2
  L7_2 = SetModelAsNoLongerNeeded
  L8_2 = L2_2
  L7_2(L8_2)
  L7_2 = Config
  L7_2 = L7_2.Debug
  if L7_2 then
    L7_2 = print
    L8_2 = "DEBUG - Attached hand prop "
    L9_2 = L1_2.model
    L10_2 = " for appliance "
    L11_2 = A0_2
    L8_2 = L8_2 .. L9_2 .. L10_2 .. L11_2
    L7_2(L8_2)
  end
end
AttachCookingHandProp = L10_1
function L10_1()
  local L0_2, L1_2
  L0_2 = L4_1
  if L0_2 then
    L0_2 = DoesEntityExist
    L1_2 = L4_1
    L0_2 = L0_2(L1_2)
    if L0_2 then
      L0_2 = DeleteEntity
      L1_2 = L4_1
      L0_2(L1_2)
      L0_2 = nil
      L4_1 = L0_2
      L0_2 = Config
      L0_2 = L0_2.Debug
      if L0_2 then
        L0_2 = print
        L1_2 = "DEBUG - Removed cooking hand prop"
        L0_2(L1_2)
      end
    end
  end
end
RemoveCookingHandProp = L10_1
function L10_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  L3_2 = L2_1
  if L3_2 then
    L3_2 = lib
    L3_2 = L3_2.notify
    L4_2 = {}
    L4_2.title = "Already Cooking"
    L4_2.description = "You are already cooking something"
    L4_2.type = "error"
    L3_2(L4_2)
    return
  end
  L3_2 = L8_1
  L4_2 = A0_2
  L5_2 = 2.0
  L3_2 = L3_2(L4_2, L5_2)
  if not L3_2 then
    L3_2 = lib
    L3_2 = L3_2.notify
    L4_2 = {}
    L4_2.title = "Error"
    L4_2.description = "You are too far away from the cooking appliance"
    L4_2.type = "error"
    L3_2(L4_2)
    return
  end
  if not A1_2 or not A2_2 then
    L3_2 = lib
    L3_2 = L3_2.notify
    L4_2 = {}
    L4_2.title = "Error"
    L4_2.description = "Invalid recipe selected"
    L4_2.type = "error"
    L3_2(L4_2)
    return
  end
  L3_2 = lib
  L3_2 = L3_2.callback
  L3_2 = L3_2.await
  L4_2 = "fsg_cooking:server:checkRequiredItems"
  L5_2 = false
  L6_2 = {}
  L6_2.recipe = A1_2
  L6_2.entity = A0_2
  L3_2 = L3_2(L4_2, L5_2, L6_2)
  if not L3_2 then
    L4_2 = lib
    L4_2 = L4_2.notify
    L5_2 = {}
    L5_2.title = "Missing Ingredients"
    L5_2.description = "You do not have all the required ingredients"
    L5_2.type = "error"
    L4_2(L5_2)
    return
  end
  L4_2 = true
  L2_1 = L4_2
  L1_1 = A0_2
  L4_2 = A2_2.appliance
  if L4_2 then
    L5_2 = StartApplianceEffects
    L6_2 = A0_2
    L7_2 = L4_2
    L5_2(L6_2, L7_2)
    L5_2 = AttachCookingHandProp
    L6_2 = L4_2
    L5_2(L6_2)
  end
  L5_2 = PlayerPedId
  L5_2 = L5_2()
  L6_2 = A2_2.animation
  if L6_2 then
    L6_2 = lib
    L6_2 = L6_2.requestAnimDict
    L7_2 = A2_2.animation
    L7_2 = L7_2.dict
    L6_2(L7_2)
    L6_2 = TaskPlayAnim
    L7_2 = L5_2
    L8_2 = A2_2.animation
    L8_2 = L8_2.dict
    L9_2 = A2_2.animation
    L9_2 = L9_2.clip
    L10_2 = 8.0
    L11_2 = -8.0
    L12_2 = -1
    L13_2 = 1
    L14_2 = 0
    L15_2 = false
    L16_2 = false
    L17_2 = false
    L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  end
  L6_2 = A2_2.cookingFlow
  if L6_2 then
    L6_2 = A2_2.cookingFlow
    L6_2 = #L6_2
    if L6_2 > 0 then
      L6_2 = ProcessCookingFlow
      L7_2 = L5_2
      L8_2 = A1_2
      L9_2 = A2_2
      L6_2(L7_2, L8_2, L9_2)
  end
  else
    L6_2 = lib
    L6_2 = L6_2.progressCircle
    L7_2 = {}
    L8_2 = A2_2.time
    L8_2 = L8_2 * 1000
    L7_2.duration = L8_2
    L8_2 = A2_2.progress
    L8_2 = L8_2.label
    L7_2.label = L8_2
    L7_2.useWhileDead = false
    L7_2.canCancel = true
    L8_2 = {}
    L8_2.car = true
    L8_2.move = true
    L8_2.combat = true
    L7_2.disable = L8_2
    L8_2 = {}
    L9_2 = A2_2.animation
    L9_2 = L9_2.dict
    L8_2.dict = L9_2
    L9_2 = A2_2.animation
    L9_2 = L9_2.clip
    L8_2.clip = L9_2
    L7_2.anim = L8_2
    L6_2 = L6_2(L7_2)
    if L6_2 then
      L6_2 = true
      L7_2 = A2_2.skillCheck
      if L7_2 then
        L7_2 = A2_2.skillCheck
        L7_2 = L7_2.enabled
        if L7_2 then
          L7_2 = Config
          L7_2 = L7_2.SkillCheck
          if L7_2 then
            L7_2 = lib
            L7_2 = L7_2.skillCheck
            L8_2 = A2_2.skillCheck
            L8_2 = L8_2.difficulty
            L9_2 = A2_2.skillCheck
            L9_2 = L9_2.inputs
            L7_2 = L7_2(L8_2, L9_2)
            L6_2 = L7_2
          end
        end
      end
      L7_2 = CompleteCooking
      L8_2 = A1_2
      L9_2 = L6_2
      L7_2(L8_2, L9_2)
    else
      L6_2 = lib
      L6_2 = L6_2.notify
      L7_2 = {}
      L7_2.title = "Cooking Cancelled"
      L7_2.description = "You stopped cooking"
      L7_2.type = "error"
      L6_2(L7_2)
      L6_2 = ClearPedTasks
      L7_2 = L5_2
      L6_2(L7_2)
      L6_2 = false
      L2_1 = L6_2
      L6_2 = RemoveCookingHandProp
      L6_2()
      if A0_2 then
        L6_2 = DoesEntityExist
        L7_2 = A0_2
        L6_2 = L6_2(L7_2)
        if L6_2 then
          L6_2 = StopApplianceEffects
          L7_2 = A0_2
          L6_2(L7_2)
        end
      end
    end
  end
end
StartCooking = L10_1
function L10_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L3_2 = true
  L4_2 = 1
  L5_2 = A2_2.cookingFlow
  L5_2 = #L5_2
  while L4_2 <= L5_2 and L3_2 do
    L6_2 = A2_2.cookingFlow
    L6_2 = L6_2[L4_2]
    if not L6_2 then
      L7_2 = lib
      L7_2 = L7_2.notify
      L8_2 = {}
      L8_2.title = "Error"
      L8_2.description = "Invalid cooking step"
      L8_2.type = "error"
      L7_2(L8_2)
      L3_2 = false
      break
    end
    L7_2 = string
    L7_2 = L7_2.format
    L8_2 = "%s (%d/%d)"
    L9_2 = L6_2.label
    L10_2 = L4_2
    L11_2 = L5_2
    L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2)
    L8_2 = lib
    L8_2 = L8_2.progressCircle
    L9_2 = {}
    L10_2 = L6_2.time
    L10_2 = L10_2 * 1000
    L9_2.duration = L10_2
    L9_2.label = L7_2
    L10_2 = L6_2.position
    if not L10_2 then
      L10_2 = "bottom"
    end
    L9_2.position = L10_2
    L9_2.useWhileDead = false
    L9_2.canCancel = true
    L10_2 = {}
    L10_2.car = true
    L10_2.move = true
    L10_2.combat = true
    L9_2.disable = L10_2
    L10_2 = {}
    L11_2 = A2_2.animation
    L11_2 = L11_2.dict
    L10_2.dict = L11_2
    L11_2 = A2_2.animation
    L11_2 = L11_2.clip
    L10_2.clip = L11_2
    L9_2.anim = L10_2
    L8_2 = L8_2(L9_2)
    if L8_2 then
      L8_2 = L6_2.skillCheck
      if L8_2 then
        L8_2 = L6_2.skillCheck
        L8_2 = L8_2.enabled
        if L8_2 then
          L8_2 = Config
          L8_2 = L8_2.SkillCheck
          if L8_2 then
            L8_2 = lib
            L8_2 = L8_2.skillCheck
            L9_2 = L6_2.skillCheck
            L9_2 = L9_2.difficulty
            L10_2 = L6_2.skillCheck
            L10_2 = L10_2.inputs
            L8_2 = L8_2(L9_2, L10_2)
            if not L8_2 then
              L3_2 = false
              L9_2 = lib
              L9_2 = L9_2.notify
              L10_2 = {}
              L10_2.title = "Cooking Failed"
              L10_2.description = "You failed the skill check!"
              L10_2.type = "error"
              L9_2(L10_2)
              break
            end
          end
        end
      end
      L4_2 = L4_2 + 1
    else
      L8_2 = lib
      L8_2 = L8_2.notify
      L9_2 = {}
      L9_2.title = "Cooking Cancelled"
      L9_2.description = "You stopped cooking"
      L9_2.type = "error"
      L8_2(L9_2)
      L8_2 = RemoveCookingHandProp
      L8_2()
      L3_2 = false
      break
    end
  end
  L6_2 = CompleteCooking
  L7_2 = A1_2
  L8_2 = L3_2
  L6_2(L7_2, L8_2)
end
ProcessCookingFlow = L10_1
function L10_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = PlayerPedId
  L2_2 = L2_2()
  L3_2 = ClearPedTasks
  L4_2 = L2_2
  L3_2(L4_2)
  L3_2 = RemoveCookingHandProp
  L3_2()
  L3_2 = L1_1
  if L3_2 then
    L3_2 = DoesEntityExist
    L4_2 = L1_1
    L3_2 = L3_2(L4_2)
    if L3_2 then
      L3_2 = StopApplianceEffects
      L4_2 = L1_1
      L3_2(L4_2)
    end
  end
  L3_2 = lib
  L3_2 = L3_2.callback
  L3_2 = L3_2.await
  L4_2 = "fsg_cooking:server:completeCooking"
  L5_2 = false
  L6_2 = {}
  L6_2.recipe = A0_2
  L6_2.success = A1_2
  L3_2(L4_2, L5_2, L6_2)
  L3_2 = false
  L2_1 = L3_2
end
CompleteCooking = L10_1
function L10_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  if A2_2 then
    L3_2 = A2_2.model
    if L3_2 then
      L3_2 = pairs
      L4_2 = Config
      L4_2 = L4_2.CookingProps
      L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
      for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
        L9_2 = L8_2.model
        L10_2 = A2_2.model
        if L9_2 == L10_2 then
          L9_2 = RefreshCookingProps
          L9_2()
          break
        end
      end
      L3_2 = pairs
      L4_2 = Config
      L4_2 = L4_2.DecorationProps
      L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
      for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
        L9_2 = L8_2.model
        L10_2 = A2_2.model
        if L9_2 == L10_2 then
          L9_2 = RefreshDecorationProps
          L9_2()
          break
        end
      end
    end
  end
  L3_2 = L8_1
  L4_2 = A0_2
  L5_2 = 2.0
  L3_2 = L3_2(L4_2, L5_2)
  if not L3_2 then
    L3_2 = lib
    L3_2 = L3_2.notify
    L4_2 = {}
    L4_2.title = "Error"
    L4_2.description = "You are too far away from the prop"
    L4_2.type = "error"
    L3_2(L4_2)
    return
  end
  L3_2 = GetPropOwner
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = GetPlayerServerId
  L5_2 = PlayerId
  L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L5_2()
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  L5_2 = L9_1
  L6_2 = PlayerId
  L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L6_2()
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  if 0 == L3_2 then
    L6_2 = DecorExistOn
    L7_2 = A0_2
    L8_2 = "PropOwner"
    L6_2 = L6_2(L7_2, L8_2)
    if L6_2 then
      L6_2 = DecorGetInt
      L7_2 = A0_2
      L8_2 = "PropOwner"
      L6_2 = L6_2(L7_2, L8_2)
      L7_2 = L9_1
      L8_2 = L6_2
      L7_2 = L7_2(L8_2)
      L3_2 = L7_2
      L7_2 = SetPropOwner
      L8_2 = A0_2
      L9_2 = L3_2
      L7_2(L8_2, L9_2)
    end
  end
  L6_2 = Config
  L6_2 = L6_2.Debug
  if L6_2 then
    L6_2 = print
    L7_2 = "DEBUG - PickUpProp:"
    L6_2(L7_2)
    L6_2 = print
    L7_2 = "- Entity: "
    L8_2 = tostring
    L9_2 = A0_2
    L8_2 = L8_2(L9_2)
    L7_2 = L7_2 .. L8_2
    L6_2(L7_2)
    L6_2 = print
    L7_2 = "- Prop Type: "
    L8_2 = tostring
    L9_2 = A1_2
    L8_2 = L8_2(L9_2)
    L7_2 = L7_2 .. L8_2
    L6_2(L7_2)
    L6_2 = print
    L7_2 = "- Prop Data exists: "
    L8_2 = tostring
    L9_2 = nil ~= A2_2
    L8_2 = L8_2(L9_2)
    L7_2 = L7_2 .. L8_2
    L6_2(L7_2)
    L6_2 = print
    L7_2 = "- Owner: "
    L8_2 = tostring
    L9_2 = L3_2
    L8_2 = L8_2(L9_2)
    L7_2 = L7_2 .. L8_2
    L6_2(L7_2)
    L6_2 = print
    L7_2 = "- Player Char ID: "
    L8_2 = tostring
    L9_2 = L5_2
    L8_2 = L8_2(L9_2)
    L7_2 = L7_2 .. L8_2
    L6_2(L7_2)
  end
  if not A1_2 or not A2_2 then
    L6_2 = GetEntityModel
    L7_2 = A0_2
    L6_2 = L6_2(L7_2)
    L7_2 = Config
    L7_2 = L7_2.Debug
    if L7_2 then
      L7_2 = print
      L8_2 = "DEBUG - Entity model hash: "
      L9_2 = tostring
      L10_2 = L6_2
      L9_2 = L9_2(L10_2)
      L8_2 = L8_2 .. L9_2
      L7_2(L8_2)
    end
    L7_2 = Config
    L7_2 = L7_2.GetPropByModel
    L8_2 = L6_2
    L7_2, L8_2, L9_2 = L7_2(L8_2)
    propCategory = L9_2
    A2_2 = L8_2
    A1_2 = L7_2
    if not A1_2 or not A2_2 then
      L7_2 = pairs
      L8_2 = Config
      L8_2 = L8_2.DecorationProps
      L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
      for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
        L13_2 = joaat
        L14_2 = L12_2.model
        L13_2 = L13_2(L14_2)
        if L13_2 == L6_2 then
          A1_2 = L11_2
          A2_2 = L12_2
          L14_2 = Config
          L14_2 = L14_2.Debug
          if L14_2 then
            L14_2 = print
            L15_2 = "DEBUG - Manually found matching decoration prop: "
            L16_2 = L11_2
            L15_2 = L15_2 .. L16_2
            L14_2(L15_2)
          end
          break
        end
      end
      if not A1_2 then
        L7_2 = pairs
        L8_2 = Config
        L8_2 = L8_2.CookingProps
        L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
        for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
          L13_2 = joaat
          L14_2 = L12_2.model
          L13_2 = L13_2(L14_2)
          if L13_2 == L6_2 then
            A1_2 = L11_2
            A2_2 = L12_2
            L14_2 = Config
            L14_2 = L14_2.Debug
            if L14_2 then
              L14_2 = print
              L15_2 = "DEBUG - Manually found matching cooking prop: "
              L16_2 = L11_2
              L15_2 = L15_2 .. L16_2
              L14_2(L15_2)
            end
            break
          end
        end
      end
    end
    if not A1_2 or not A2_2 then
      L7_2 = lib
      L7_2 = L7_2.notify
      L8_2 = {}
      L8_2.title = "Error"
      L8_2.description = "Could not identify prop type"
      L8_2.type = "error"
      L7_2(L8_2)
      return
    end
  end
  if L3_2 ~= L5_2 then
    L6_2 = lib
    L6_2 = L6_2.notify
    L7_2 = {}
    L7_2.title = "Error"
    L7_2.description = "You cannot pick up this prop"
    L7_2.type = "error"
    L6_2(L7_2)
    return
  end
  L6_2 = L2_1
  if L6_2 then
    L6_2 = lib
    L6_2 = L6_2.notify
    L7_2 = {}
    L7_2.title = "Error"
    L7_2.description = "Cannot pick up while cooking"
    L7_2.type = "error"
    L6_2(L7_2)
    return
  end
  L6_2 = PlayerPedId
  L6_2 = L6_2()
  L7_2 = A2_2.animation
  if L7_2 then
    L7_2 = lib
    L7_2 = L7_2.requestAnimDict
    L8_2 = A2_2.animation
    L8_2 = L8_2.dict
    L7_2(L8_2)
    L7_2 = TaskPlayAnim
    L8_2 = L6_2
    L9_2 = A2_2.animation
    L9_2 = L9_2.dict
    L10_2 = A2_2.animation
    L10_2 = L10_2.clip
    L11_2 = 8.0
    L12_2 = -8.0
    L13_2 = -1
    L14_2 = 0
    L15_2 = 0
    L16_2 = false
    L17_2 = false
    L18_2 = false
    L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  end
  L7_2 = lib
  L7_2 = L7_2.progressCircle
  L8_2 = {}
  L8_2.duration = 1000
  L9_2 = "Picking up "
  L10_2 = A2_2.label
  L9_2 = L9_2 .. L10_2
  L8_2.label = L9_2
  L8_2.useWhileDead = false
  L8_2.canCancel = false
  L9_2 = {}
  L9_2.car = true
  L8_2.disable = L9_2
  L7_2 = L7_2(L8_2)
  if L7_2 then
    L7_2 = DoesEntityExist
    L8_2 = A0_2
    L7_2 = L7_2(L8_2)
    if L7_2 then
      L7_2 = GetPropIdByEntity
      L8_2 = A0_2
      L7_2 = L7_2(L8_2)
      L8_2 = NetworkGetNetworkIdFromEntity
      L9_2 = A0_2
      L8_2 = L8_2(L9_2)
      L9_2 = Config
      L9_2 = L9_2.Debug
      if L9_2 then
        L9_2 = print
        L10_2 = "DEBUG - Entity: "
        L11_2 = tostring
        L12_2 = A0_2
        L11_2 = L11_2(L12_2)
        L10_2 = L10_2 .. L11_2
        L9_2(L10_2)
      end
      L9_2 = Config
      L9_2 = L9_2.Debug
      if L9_2 then
        L9_2 = print
        L10_2 = "DEBUG - PropId: "
        L11_2 = tostring
        L12_2 = L7_2
        L11_2 = L11_2(L12_2)
        L10_2 = L10_2 .. L11_2
        L9_2(L10_2)
      end
      L9_2 = Config
      L9_2 = L9_2.Debug
      if L9_2 then
        L9_2 = print
        L10_2 = "DEBUG - NetId: "
        L11_2 = tostring
        L12_2 = L8_2
        L11_2 = L11_2(L12_2)
        L10_2 = L10_2 .. L11_2
        L9_2(L10_2)
      end
      L9_2 = Config
      L9_2 = L9_2.Debug
      if L9_2 then
        L9_2 = print
        L10_2 = "DEBUG - About to call server callback"
        L9_2(L10_2)
      end
      L9_2 = lib
      L9_2 = L9_2.callback
      L9_2 = L9_2.await
      L10_2 = "fsg_cooking:server:pickupProp"
      L11_2 = false
      L12_2 = L8_2
      L13_2 = L7_2
      L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2)
      L10_2 = Config
      L10_2 = L10_2.Debug
      if L10_2 then
        L10_2 = print
        L11_2 = "DEBUG - Server callback result: "
        L12_2 = tostring
        L13_2 = L9_2
        L12_2 = L12_2(L13_2)
        L11_2 = L11_2 .. L12_2
        L10_2(L11_2)
      end
      if L9_2 then
        L10_2 = L0_1
        L10_2[A0_2] = nil
        L10_2 = Config
        L10_2 = L10_2.CookingProps
        L10_2 = L10_2[A1_2]
        L10_2 = nil ~= L10_2
        L11_2 = Config
        L11_2 = L11_2.DecorationProps
        L11_2 = L11_2[A1_2]
        L11_2 = nil ~= L11_2
        L12_2 = Config
        L12_2 = L12_2.Debug
        if L12_2 then
          L12_2 = print
          L13_2 = "DEBUG - Is cooking prop: "
          L14_2 = tostring
          L15_2 = L10_2
          L14_2 = L14_2(L15_2)
          L13_2 = L13_2 .. L14_2
          L12_2(L13_2)
        end
        L12_2 = Config
        L12_2 = L12_2.Debug
        if L12_2 then
          L12_2 = print
          L13_2 = "DEBUG - Is decoration prop: "
          L14_2 = tostring
          L15_2 = L11_2
          L14_2 = L14_2(L15_2)
          L13_2 = L13_2 .. L14_2
          L12_2(L13_2)
        end
        if L10_2 then
          L12_2 = exports
          L12_2 = L12_2.ox_target
          L13_2 = L12_2
          L12_2 = L12_2.removeLocalEntity
          L14_2 = A0_2
          L15_2 = {}
          L16_2 = "cooking_"
          L17_2 = A1_2
          L16_2 = L16_2 .. L17_2
          L17_2 = "pickup_"
          L18_2 = A1_2
          L17_2 = L17_2 .. L18_2
          L15_2[1] = L16_2
          L15_2[2] = L17_2
          L12_2(L13_2, L14_2, L15_2)
        elseif L11_2 then
          L12_2 = exports
          L12_2 = L12_2.ox_target
          L13_2 = L12_2
          L12_2 = L12_2.removeLocalEntity
          L14_2 = A0_2
          L15_2 = {}
          L16_2 = "pickup_"
          L17_2 = A1_2
          L16_2 = L16_2 .. L17_2
          L15_2[1] = L16_2
          L12_2(L13_2, L14_2, L15_2)
        end
      end
    else
      L7_2 = lib
      L7_2 = L7_2.notify
      L8_2 = {}
      L8_2.title = "Error"
      L8_2.description = "The item no longer exists"
      L8_2.type = "error"
      L7_2(L8_2)
    end
  else
    L7_2 = lib
    L7_2 = L7_2.notify
    L8_2 = {}
    L8_2.title = "Cancelled"
    L9_2 = "You cancelled picking up the "
    L10_2 = A2_2.label
    L9_2 = L9_2 .. L10_2
    L8_2.description = L9_2
    L8_2.type = "error"
    L7_2(L8_2)
  end
end
PickUpProp = L10_1
L10_1 = lib
L10_1 = L10_1.callback
L10_1 = L10_1.register
L11_1 = "fsg_cooking:client:checkRequiredItems"
function L12_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = HasRequiredItems
  L2_2 = cache
  L2_2 = L2_2.serverId
  L3_2 = Config
  L3_2 = L3_2.Recipes
  L4_2 = A0_2.recipe
  L3_2 = L3_2[L4_2]
  L3_2 = L3_2.requiredItems
  return L1_2(L2_2, L3_2)
end
L10_1(L11_1, L12_1)
L10_1 = RegisterNetEvent
L11_1 = "fsg_cooking:client:setPropOwner"
function L12_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = NetworkGetEntityFromNetworkId
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = DoesEntityExist
  L4_2 = L2_2
  L3_2 = L3_2(L4_2)
  if L3_2 then
    L3_2 = SetPropOwner
    L4_2 = L2_2
    L5_2 = A1_2
    L3_2(L4_2, L5_2)
  end
end
L10_1(L11_1, L12_1)
L10_1 = AddEventHandler
L11_1 = "onResourceStop"
function L12_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = GetCurrentResourceName
  L1_2 = L1_2()
  if A0_2 ~= L1_2 then
    return
  end
  L1_2 = lib
  L1_2 = L1_2.hideTextUI
  L1_2()
  L1_2 = pairs
  L2_2 = L3_1
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = DoesEntityExist
    L8_2 = L5_2
    L7_2 = L7_2(L8_2)
    if L7_2 then
      L7_2 = StopApplianceEffects
      L8_2 = L5_2
      L7_2(L8_2)
    end
  end
  L1_2 = L2_1
  if L1_2 then
    L1_2 = PlayerPedId
    L1_2 = L1_2()
    L2_2 = ClearPedTasks
    L3_2 = L1_2
    L2_2(L3_2)
  end
end
L10_1(L11_1, L12_1)
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2
  L0_2 = PlayerPedId
  L0_2 = L0_2()
  L1_2 = GetEntityCoords
  L2_2 = L0_2
  L1_2 = L1_2(L2_2)
  L2_2 = {}
  L3_2 = "ent_amb_smoke_foundry"
  L4_2 = "ent_amb_smoke_factory_white"
  L5_2 = "ent_amb_smoke_gaswork"
  L6_2 = "exp_grd_bzgas_smoke"
  L7_2 = "ent_amb_smoke_scrap"
  L2_2[1] = L3_2
  L2_2[2] = L4_2
  L2_2[3] = L5_2
  L2_2[4] = L6_2
  L2_2[5] = L7_2
  L3_2 = RequestNamedPtfxAsset
  L4_2 = "core"
  L3_2(L4_2)
  while true do
    L3_2 = HasNamedPtfxAssetLoaded
    L4_2 = "core"
    L3_2 = L3_2(L4_2)
    if L3_2 then
      break
    end
    L3_2 = Wait
    L4_2 = 10
    L3_2(L4_2)
  end
  L3_2 = ipairs
  L4_2 = L2_2
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = vector3
    L10_2 = 1.0 * L7_2
    L11_2 = 0.0
    L12_2 = 0.0
    L9_2 = L9_2(L10_2, L11_2, L12_2)
    L10_2 = L1_2 + L9_2
    L11_2 = UseParticleFxAssetNextCall
    L12_2 = "core"
    L11_2(L12_2)
    L11_2 = StartParticleFxLoopedAtCoord
    L12_2 = L8_2
    L13_2 = L10_2.x
    L14_2 = L10_2.y
    L15_2 = L10_2.z
    L15_2 = L15_2 + 1.0
    L16_2 = 0.0
    L17_2 = 0.0
    L18_2 = 0.0
    L19_2 = 1.0
    L20_2 = false
    L21_2 = false
    L22_2 = false
    L23_2 = false
    L11_2 = L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
    if L11_2 and -1 ~= L11_2 then
      L12_2 = print
      L13_2 = "SUCCESS: Created test effect "
      L14_2 = L8_2
      L15_2 = " with ID "
      L16_2 = L11_2
      L13_2 = L13_2 .. L14_2 .. L15_2 .. L16_2
      L12_2(L13_2)
      L12_2 = L3_1
      L13_2 = -1
      L12_2 = L12_2[L13_2]
      if not L12_2 then
        L12_2 = L3_1
        L13_2 = -1
        L14_2 = {}
        L12_2[L13_2] = L14_2
      end
      L12_2 = L3_1
      L13_2 = -1
      L12_2 = L12_2[L13_2]
      L12_2[L8_2] = L11_2
    else
      L12_2 = print
      L13_2 = "FAILED: Could not create test effect "
      L14_2 = L8_2
      L13_2 = L13_2 .. L14_2
      L12_2(L13_2)
    end
  end
  L3_2 = Citizen
  L3_2 = L3_2.SetTimeout
  L4_2 = 10000
  function L5_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3
    L0_3 = L3_1
    L1_3 = -1
    L0_3 = L0_3[L1_3]
    if L0_3 then
      L0_3 = pairs
      L1_3 = L3_1
      L2_3 = -1
      L1_3 = L1_3[L2_3]
      L0_3, L1_3, L2_3, L3_3 = L0_3(L1_3)
      for L4_3, L5_3 in L0_3, L1_3, L2_3, L3_3 do
        L6_3 = StopParticleFxLooped
        L7_3 = L5_3
        L8_3 = false
        L6_3(L7_3, L8_3)
        L6_3 = print
        L7_3 = "Cleaned up test effect: "
        L8_3 = L4_3
        L7_3 = L7_3 .. L8_3
        L6_3(L7_3)
      end
      L0_3 = L3_1
      L1_3 = -1
      L0_3[L1_3] = nil
    end
  end
  L3_2(L4_2, L5_2)
end
CreateTestSmoke = L10_1
L10_1 = Config
L10_1 = L10_1.Debug
if L10_1 then
  L10_1 = RegisterCommand
  L11_1 = "testsmoke"
  function L12_1()
    local L0_2, L1_2
    L0_2 = CreateTestSmoke
    L0_2()
  end
  L13_1 = false
  L10_1(L11_1, L12_1, L13_1)
end
L10_1 = exports
L11_1 = "CreateTestSmoke"
L12_1 = CreateTestSmoke
L10_1(L11_1, L12_1)
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2
  L0_2 = PlayerPedId
  L0_2 = L0_2()
  L1_2 = GetEntityCoords
  L2_2 = L0_2
  L1_2 = L1_2(L2_2)
  L2_2 = {}
  L3_2 = "ent_amb_BBQ_fire"
  L4_2 = "ent_amb_fire_ring"
  L5_2 = "ent_amb_torch_fire"
  L6_2 = "fire_wrecked_plane_cockpit"
  L7_2 = "ent_ray_heli_aprtmnt_l_fire"
  L2_2[1] = L3_2
  L2_2[2] = L4_2
  L2_2[3] = L5_2
  L2_2[4] = L6_2
  L2_2[5] = L7_2
  L3_2 = RequestNamedPtfxAsset
  L4_2 = "core"
  L3_2(L4_2)
  while true do
    L3_2 = HasNamedPtfxAssetLoaded
    L4_2 = "core"
    L3_2 = L3_2(L4_2)
    if L3_2 then
      break
    end
    L3_2 = Wait
    L4_2 = 10
    L3_2(L4_2)
  end
  L3_2 = ipairs
  L4_2 = L2_2
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = vector3
    L10_2 = 1.0 * L7_2
    L11_2 = 0.0
    L12_2 = 0.0
    L9_2 = L9_2(L10_2, L11_2, L12_2)
    L10_2 = L1_2 + L9_2
    L11_2 = UseParticleFxAssetNextCall
    L12_2 = "core"
    L11_2(L12_2)
    L11_2 = StartParticleFxLoopedAtCoord
    L12_2 = L8_2
    L13_2 = L10_2.x
    L14_2 = L10_2.y
    L15_2 = L10_2.z
    L15_2 = L15_2 + 0.5
    L16_2 = 0.0
    L17_2 = 0.0
    L18_2 = 0.0
    L19_2 = 0.8
    L20_2 = false
    L21_2 = false
    L22_2 = false
    L23_2 = false
    L11_2 = L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
    if L11_2 and -1 ~= L11_2 then
      L12_2 = print
      L13_2 = "SUCCESS: Created test fire effect "
      L14_2 = L8_2
      L15_2 = " with ID "
      L16_2 = L11_2
      L13_2 = L13_2 .. L14_2 .. L15_2 .. L16_2
      L12_2(L13_2)
      L12_2 = L3_1
      L13_2 = -2
      L12_2 = L12_2[L13_2]
      if not L12_2 then
        L12_2 = L3_1
        L13_2 = -2
        L14_2 = {}
        L12_2[L13_2] = L14_2
      end
      L12_2 = L3_1
      L13_2 = -2
      L12_2 = L12_2[L13_2]
      L12_2[L8_2] = L11_2
    else
      L12_2 = print
      L13_2 = "FAILED: Could not create test fire effect "
      L14_2 = L8_2
      L13_2 = L13_2 .. L14_2
      L12_2(L13_2)
    end
  end
  L3_2 = Citizen
  L3_2 = L3_2.SetTimeout
  L4_2 = 10000
  function L5_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3
    L0_3 = L3_1
    L1_3 = -2
    L0_3 = L0_3[L1_3]
    if L0_3 then
      L0_3 = pairs
      L1_3 = L3_1
      L2_3 = -2
      L1_3 = L1_3[L2_3]
      L0_3, L1_3, L2_3, L3_3 = L0_3(L1_3)
      for L4_3, L5_3 in L0_3, L1_3, L2_3, L3_3 do
        L6_3 = StopParticleFxLooped
        L7_3 = L5_3
        L8_3 = false
        L6_3(L7_3, L8_3)
        L6_3 = print
        L7_3 = "Cleaned up test fire effect: "
        L8_3 = L4_3
        L7_3 = L7_3 .. L8_3
        L6_3(L7_3)
      end
      L0_3 = L3_1
      L1_3 = -2
      L0_3[L1_3] = nil
    end
  end
  L3_2(L4_2, L5_2)
end
CreateTestFire = L10_1
L10_1 = Config
L10_1 = L10_1.Debug
if L10_1 then
  L10_1 = RegisterCommand
  L11_1 = "testfire"
  function L12_1()
    local L0_2, L1_2
    L0_2 = CreateTestFire
    L0_2()
  end
  L13_1 = false
  L10_1(L11_1, L12_1, L13_1)
end
L10_1 = exports
L11_1 = "CreateTestFire"
L12_1 = CreateTestFire
L10_1(L11_1, L12_1)
L10_1 = Config
L10_1 = L10_1.Debug
if L10_1 then
  L10_1 = RegisterCommand
  L11_1 = "testbbq"
  function L12_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2
    L0_2 = PlayerPedId
    L0_2 = L0_2()
    L1_2 = GetEntityCoords
    L2_2 = L0_2
    L1_2 = L1_2(L2_2)
    L2_2 = joaat
    L3_2 = "prop_bbq_1"
    L2_2 = L2_2(L3_2)
    L3_2 = RequestModel
    L4_2 = L2_2
    L3_2(L4_2)
    while true do
      L3_2 = HasModelLoaded
      L4_2 = L2_2
      L3_2 = L3_2(L4_2)
      if L3_2 then
        break
      end
      L3_2 = Wait
      L4_2 = 10
      L3_2(L4_2)
    end
    L3_2 = GetEntityHeading
    L4_2 = L0_2
    L3_2 = L3_2(L4_2)
    L4_2 = vector3
    L5_2 = 0.0
    L6_2 = 1.5
    L7_2 = 0.0
    L4_2 = L4_2(L5_2, L6_2, L7_2)
    L5_2 = L1_2 + L4_2
    L6_2 = CreateObject
    L7_2 = L2_2
    L8_2 = L5_2.x
    L9_2 = L5_2.y
    L10_2 = L5_2.z
    L11_2 = true
    L12_2 = false
    L13_2 = false
    L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
    if L6_2 then
      L7_2 = DoesEntityExist
      L8_2 = L6_2
      L7_2 = L7_2(L8_2)
      if L7_2 then
        L7_2 = SetEntityHeading
        L8_2 = L6_2
        L9_2 = L3_2
        L7_2(L8_2, L9_2)
        L7_2 = PlaceObjectOnGroundProperly
        L8_2 = L6_2
        L7_2(L8_2)
        L7_2 = L3_1
        L7_2 = L7_2[L6_2]
        if not L7_2 then
          L7_2 = L3_1
          L8_2 = {}
          L7_2[L6_2] = L8_2
        end
        L7_2 = RequestNamedPtfxAsset
        L8_2 = "core"
        L7_2(L8_2)
        while true do
          L7_2 = HasNamedPtfxAssetLoaded
          L8_2 = "core"
          L7_2 = L7_2(L8_2)
          if L7_2 then
            break
          end
          L7_2 = Wait
          L8_2 = 10
          L7_2(L8_2)
        end
        L7_2 = UseParticleFxAssetNextCall
        L8_2 = "core"
        L7_2(L8_2)
        L7_2 = StartParticleFxLoopedOnEntity
        L8_2 = "ent_amb_smoke_foundry"
        L9_2 = L6_2
        L10_2 = 0.0
        L11_2 = 0.0
        L12_2 = 0.7
        L13_2 = 0.0
        L14_2 = 0.0
        L15_2 = 0.0
        L16_2 = 1.5
        L17_2 = false
        L18_2 = false
        L19_2 = false
        L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
        if L7_2 and -1 ~= L7_2 then
          L8_2 = L3_1
          L8_2 = L8_2[L6_2]
          L8_2.smoke = L7_2
          L8_2 = print
          L9_2 = "Started smoke effect on test BBQ"
          L8_2(L9_2)
        end
        L8_2 = UseParticleFxAssetNextCall
        L9_2 = "core"
        L8_2(L9_2)
        L8_2 = StartParticleFxLoopedOnEntity
        L9_2 = "ent_amb_BBQ_fire"
        L10_2 = L6_2
        L11_2 = 0.0
        L12_2 = 0.0
        L13_2 = 0.5
        L14_2 = 0.0
        L15_2 = 0.0
        L16_2 = 0.0
        L17_2 = 0.6
        L18_2 = false
        L19_2 = false
        L20_2 = false
        L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
        if L8_2 and -1 ~= L8_2 then
          L9_2 = L3_1
          L9_2 = L9_2[L6_2]
          L9_2.fire = L8_2
          L9_2 = print
          L10_2 = "Started fire effect on test BBQ"
          L9_2(L10_2)
        end
        L9_2 = lib
        L9_2 = L9_2.notify
        L10_2 = {}
        L10_2.title = "Test BBQ"
        L10_2.description = "Created test BBQ with smoke and fire effects for 20 seconds"
        L10_2.type = "success"
        L9_2(L10_2)
        L9_2 = Citizen
        L9_2 = L9_2.SetTimeout
        L10_2 = 20000
        function L11_2()
          local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3
          L0_3 = L6_2
          if L0_3 then
            L0_3 = DoesEntityExist
            L1_3 = L6_2
            L0_3 = L0_3(L1_3)
            if L0_3 then
              L1_3 = L6_2
              L0_3 = L3_1
              L0_3 = L0_3[L1_3]
              if L0_3 then
                L0_3 = pairs
                L2_3 = L6_2
                L1_3 = L3_1
                L1_3 = L1_3[L2_3]
                L0_3, L1_3, L2_3, L3_3 = L0_3(L1_3)
                for L4_3, L5_3 in L0_3, L1_3, L2_3, L3_3 do
                  L6_3 = StopParticleFxLooped
                  L7_3 = L5_3
                  L8_3 = false
                  L6_3(L7_3, L8_3)
                  L6_3 = print
                  L7_3 = "Stopped "
                  L8_3 = L4_3
                  L9_3 = " effect on test BBQ"
                  L7_3 = L7_3 .. L8_3 .. L9_3
                  L6_3(L7_3)
                end
                L1_3 = L6_2
                L0_3 = L3_1
                L0_3[L1_3] = nil
              end
              L0_3 = DeleteEntity
              L1_3 = L6_2
              L0_3(L1_3)
              L0_3 = lib
              L0_3 = L0_3.notify
              L1_3 = {}
              L1_3.title = "Test BBQ"
              L1_3.description = "Removed test BBQ and effects"
              L1_3.type = "info"
              L0_3(L1_3)
            end
          end
        end
        L9_2(L10_2, L11_2)
    end
    else
      L7_2 = print
      L8_2 = "Failed to create test BBQ prop"
      L7_2(L8_2)
    end
  end
  L13_1 = false
  L10_1(L11_1, L12_1, L13_1)
end
L10_1 = exports
L11_1 = "TestBBQEffects"
function L12_1()
  local L0_2, L1_2
  L0_2 = ExecuteCommand
  L1_2 = "testbbq"
  L0_2(L1_2)
end
L10_1(L11_1, L12_1)
