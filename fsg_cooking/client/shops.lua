local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1
L0_1 = {}
function L1_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L0_2 = pairs
  L1_2 = L0_1
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = DoesEntityExist
    L7_2 = L5_2
    L6_2 = L6_2(L7_2)
    if L6_2 then
      L6_2 = DeleteEntity
      L7_2 = L5_2
      L6_2(L7_2)
    end
  end
  L0_2 = {}
  L0_1 = L0_2
end
function L2_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L3_2 = lib
  L3_2 = L3_2.inputDialog
  L4_2 = "Purchase "
  L5_2 = A1_2
  L4_2 = L4_2 .. L5_2
  L5_2 = {}
  L6_2 = {}
  L6_2.type = "number"
  L6_2.label = "Amount of Items"
  L7_2 = "How many "
  L8_2 = A1_2
  L9_2 = " would you like to get?"
  L7_2 = L7_2 .. L8_2 .. L9_2
  L6_2.description = L7_2
  L6_2.required = true
  L6_2.min = 1
  L6_2.max = 100
  L6_2.icon = "fa-solid fa-box"
  L7_2 = {}
  L7_2.type = "select"
  L7_2.label = "Payment Method"
  L8_2 = {}
  L9_2 = {}
  L9_2.value = "cash"
  L9_2.label = "Cash"
  L10_2 = {}
  L10_2.value = "card"
  L10_2.label = "Card"
  L8_2[1] = L9_2
  L8_2[2] = L10_2
  L7_2.options = L8_2
  L7_2.required = true
  L7_2.icon = "fa-solid fa-wallet"
  L5_2[1] = L6_2
  L5_2[2] = L7_2
  L3_2 = L3_2(L4_2, L5_2)
  if not L3_2 then
    return
  end
  L4_2 = L3_2[1]
  L5_2 = L3_2[2]
  if "cash" == L5_2 then
    L6_2 = lib
    L6_2 = L6_2.callback
    L6_2 = L6_2.await
    L7_2 = "fsg_cooking:checkCashBalance"
    L8_2 = false
    L9_2 = total
    L6_2 = L6_2(L7_2, L8_2, L9_2)
    if not L6_2 then
      L7_2 = cb
      L8_2 = {}
      L8_2.success = false
      L8_2.message = "Insufficient funds"
      L7_2(L8_2)
      return
    end
  end
  if "card" == L5_2 then
    L6_2 = lib
    L6_2 = L6_2.callback
    L6_2 = L6_2.await
    L7_2 = "fsg_cooking:checkBankBalance"
    L8_2 = false
    L9_2 = total
    L6_2 = L6_2(L7_2, L8_2, L9_2)
    if not L6_2 then
      L7_2 = cb
      L8_2 = {}
      L8_2.success = false
      L8_2.message = "Insufficient funds"
      L7_2(L8_2)
      return
    end
  end
  if L4_2 and L5_2 then
    L6_2 = lib
    L6_2 = L6_2.callback
    L6_2 = L6_2.await
    L7_2 = "fsg_cooking:purchaseItem"
    L8_2 = false
    L9_2 = A0_2
    L10_2 = L4_2
    L11_2 = A2_2
    L12_2 = L5_2
    L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  end
end
function L3_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2
  L1_2 = Config
  L1_2 = L1_2.ShopMenu
  if "ox" == L1_2 then
    L1_2 = {}
    L2_2 = exports
    L2_2 = L2_2.ox_inventory
    L3_2 = L2_2
    L2_2 = L2_2.Items
    L2_2 = L2_2(L3_2)
    L3_2 = pairs
    L4_2 = A0_2.categories
    L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
    for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
      L9_2 = table
      L9_2 = L9_2.insert
      L10_2 = L1_2
      L11_2 = {}
      L11_2.title = L7_2
      L12_2 = "Browse "
      L13_2 = L7_2
      L14_2 = " items"
      L12_2 = L12_2 .. L13_2 .. L14_2
      L11_2.description = L12_2
      L11_2.arrow = true
      function L12_2()
        local L0_3, L1_3, L2_3
        L0_3 = lib
        L0_3 = L0_3.showContext
        L1_3 = "category_"
        L2_3 = L7_2
        L1_3 = L1_3 .. L2_3
        L0_3(L1_3)
      end
      L11_2.onSelect = L12_2
      L9_2(L10_2, L11_2)
      L9_2 = {}
      L10_2 = ipairs
      L11_2 = L8_2
      L10_2, L11_2, L12_2, L13_2 = L10_2(L11_2)
      for L14_2, L15_2 in L10_2, L11_2, L12_2, L13_2 do
        L16_2 = L15_2.item
        L16_2 = L2_2[L16_2]
        if not L16_2 then
          L16_2 = {}
        end
        L17_2 = L16_2.weight
        if L17_2 then
          L17_2 = "Weight: "
          L18_2 = L16_2.weight
          L19_2 = " | "
          L17_2 = L17_2 .. L18_2 .. L19_2
          if L17_2 then
            goto lbl_52
          end
        end
        L17_2 = ""
        ::lbl_52::
        L18_2 = table
        L18_2 = L18_2.insert
        L19_2 = L9_2
        L20_2 = {}
        L21_2 = L15_2.label
        L20_2.title = L21_2
        L21_2 = L17_2
        L22_2 = "Price: $"
        L23_2 = L15_2.price
        L21_2 = L21_2 .. L22_2 .. L23_2
        L20_2.description = L21_2
        function L21_2()
          local L0_3, L1_3, L2_3, L3_3
          L0_3 = L2_1
          L1_3 = L15_2.item
          L2_3 = L15_2.label
          L3_3 = L15_2.price
          L0_3(L1_3, L2_3, L3_3)
        end
        L20_2.onSelect = L21_2
        L21_2 = L16_2.image
        if not L21_2 then
          L21_2 = "https://cfx-nui-ox_inventory/web/images/"
          L22_2 = L15_2.item
          L23_2 = ".png"
          L21_2 = L21_2 .. L22_2 .. L23_2
        end
        L20_2.image = L21_2
        L21_2 = L16_2.image
        if not L21_2 then
          L21_2 = "https://cfx-nui-ox_inventory/web/images/"
          L22_2 = L15_2.item
          L23_2 = ".png"
          L21_2 = L21_2 .. L22_2 .. L23_2
        end
        L20_2.icon = L21_2
        L18_2(L19_2, L20_2)
      end
      L10_2 = lib
      L10_2 = L10_2.registerContext
      L11_2 = {}
      L12_2 = "category_"
      L13_2 = L7_2
      L12_2 = L12_2 .. L13_2
      L11_2.id = L12_2
      L11_2.title = L7_2
      L11_2.menu = "main_menu"
      L11_2.options = L9_2
      L10_2(L11_2)
    end
    L3_2 = lib
    L3_2 = L3_2.registerContext
    L4_2 = {}
    L4_2.id = "main_menu"
    L5_2 = A0_2.label
    if not L5_2 then
      L5_2 = "Shop"
    end
    L4_2.title = L5_2
    L4_2.options = L1_2
    L3_2(L4_2)
    L3_2 = lib
    L3_2 = L3_2.showContext
    L4_2 = "main_menu"
    L3_2(L4_2)
  else
    L1_2 = Config
    L1_2 = L1_2.ShopMenu
    if "ui" == L1_2 then
      L1_2 = {}
      L2_2 = exports
      L2_2 = L2_2.ox_inventory
      L3_2 = L2_2
      L2_2 = L2_2.Items
      L2_2 = L2_2(L3_2)
      L3_2 = pairs
      L4_2 = A0_2.categories
      L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
      for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
        L9_2 = ipairs
        L10_2 = L8_2
        L9_2, L10_2, L11_2, L12_2 = L9_2(L10_2)
        for L13_2, L14_2 in L9_2, L10_2, L11_2, L12_2 do
          L15_2 = L14_2.item
          L15_2 = L2_2[L15_2]
          if not L15_2 then
            L15_2 = {}
          end
          L16_2 = table
          L16_2 = L16_2.insert
          L17_2 = L1_2
          L18_2 = {}
          L19_2 = L14_2.item
          L18_2.item = L19_2
          L19_2 = L14_2.label
          L18_2.label = L19_2
          L19_2 = L14_2.price
          L18_2.price = L19_2
          L18_2.category = L7_2
          L19_2 = L15_2.weight
          L18_2.weight = L19_2
          L16_2(L17_2, L18_2)
        end
      end
      L3_2 = SetNuiFocus
      L4_2 = true
      L5_2 = true
      L3_2(L4_2, L5_2)
      L3_2 = {}
      L4_2 = pairs
      L5_2 = A0_2.categories
      L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
      for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
        L10_2 = table
        L10_2 = L10_2.insert
        L11_2 = L3_2
        L12_2 = L8_2
        L10_2(L11_2, L12_2)
      end
      L4_2 = SetNuiFocus
      L5_2 = true
      L6_2 = true
      L4_2(L5_2, L6_2)
      L4_2 = Nui
      L5_2 = L4_2
      L4_2 = L4_2.msg
      L6_2 = "setShopData"
      L7_2 = {}
      L7_2.items = L1_2
      L8_2 = A0_2.label
      if not L8_2 then
        L8_2 = "Shop"
      end
      L7_2.label = L8_2
      L7_2.categories = L3_2
      L4_2(L5_2, L6_2, L7_2)
    else
      L1_2 = print
      L2_2 = "Invalid shop menu type"
      L1_2(L2_2)
    end
  end
end
DisplayShopMenu = L3_1
function L3_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = lib
  L1_2 = L1_2.callback
  L1_2 = L1_2.await
  L2_2 = "fsg_cooking:getShopData"
  L3_2 = false
  L4_2 = A0_2
  L1_2 = L1_2(L2_2, L3_2, L4_2)
  if L1_2 then
    L2_2 = DisplayShopMenu
    L3_2 = L1_2
    L2_2(L3_2)
  end
end
function L4_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L0_2 = ipairs
  L1_2 = Config
  L1_2 = L1_2.Stores
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = L5_2.enabled
    if L6_2 then
      L6_2 = L5_2.blip
      if L6_2 then
        L6_2 = L5_2.blip
        L6_2 = L6_2.enabled
        if L6_2 then
          L6_2 = AddBlipForCoord
          L7_2 = vec3
          L8_2 = L5_2.ped
          L8_2 = L8_2.coords
          L8_2 = L8_2.x
          L9_2 = L5_2.ped
          L9_2 = L9_2.coords
          L9_2 = L9_2.y
          L10_2 = L5_2.ped
          L10_2 = L10_2.coords
          L10_2 = L10_2.z
          L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2 = L7_2(L8_2, L9_2, L10_2)
          L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
          L7_2 = SetBlipSprite
          L8_2 = L6_2
          L9_2 = L5_2.blip
          L9_2 = L9_2.sprite
          L7_2(L8_2, L9_2)
          L7_2 = SetBlipAsShortRange
          L8_2 = L6_2
          L9_2 = true
          L7_2(L8_2, L9_2)
          L7_2 = SetBlipScale
          L8_2 = L6_2
          L9_2 = L5_2.blip
          L9_2 = L9_2.scale
          L7_2(L8_2, L9_2)
          L7_2 = SetBlipColour
          L8_2 = L6_2
          L9_2 = L5_2.blip
          L9_2 = L9_2.color
          L7_2(L8_2, L9_2)
          L7_2 = SetBlipDisplay
          L8_2 = L6_2
          L9_2 = L5_2.blip
          L9_2 = L9_2.display
          L7_2(L8_2, L9_2)
          L7_2 = BeginTextCommandSetBlipName
          L8_2 = "STRING"
          L7_2(L8_2)
          L7_2 = AddTextComponentString
          L8_2 = L5_2.label
          L7_2(L8_2)
          L7_2 = EndTextCommandSetBlipName
          L8_2 = L6_2
          L7_2(L8_2)
        end
      end
      L6_2 = L0_1
      L6_2 = L6_2[L4_2]
      if not L6_2 then
        L6_2 = lib
        L6_2 = L6_2.requestModel
        L7_2 = L5_2.ped
        L7_2 = L7_2.model
        L6_2(L7_2)
        L6_2 = CreatePed
        L7_2 = 0
        L8_2 = L5_2.ped
        L8_2 = L8_2.model
        L9_2 = L5_2.ped
        L9_2 = L9_2.coords
        L9_2 = L9_2.x
        L10_2 = L5_2.ped
        L10_2 = L10_2.coords
        L10_2 = L10_2.y
        L11_2 = L5_2.ped
        L11_2 = L11_2.coords
        L11_2 = L11_2.z
        L12_2 = L5_2.ped
        L12_2 = L12_2.coords
        L12_2 = L12_2.w
        L13_2 = false
        L14_2 = true
        L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
        L7_2 = L5_2.ped
        L7_2 = L7_2.scenario
        if L7_2 then
          L7_2 = TaskStartScenarioInPlace
          L8_2 = L6_2
          L9_2 = L5_2.ped
          L9_2 = L9_2.scenario
          L10_2 = 0
          L11_2 = true
          L7_2(L8_2, L9_2, L10_2, L11_2)
        end
        L7_2 = FreezeEntityPosition
        L8_2 = L6_2
        L9_2 = true
        L7_2(L8_2, L9_2)
        L7_2 = SetEntityInvincible
        L8_2 = L6_2
        L9_2 = true
        L7_2(L8_2, L9_2)
        L7_2 = SetBlockingOfNonTemporaryEvents
        L8_2 = L6_2
        L9_2 = true
        L7_2(L8_2, L9_2)
        L7_2 = L0_1
        L7_2[L4_2] = L6_2
        L7_2 = exports
        L7_2 = L7_2.ox_target
        L8_2 = L7_2
        L7_2 = L7_2.addLocalEntity
        L9_2 = L6_2
        L10_2 = {}
        L11_2 = {}
        L12_2 = "Open "
        L13_2 = L5_2.label
        if not L13_2 then
          L13_2 = "Shop"
        end
        L12_2 = L12_2 .. L13_2
        L11_2.label = L12_2
        L11_2.icon = "fas fa-store"
        L11_2.distance = 2.0
        function L12_2()
          local L0_3, L1_3
          L0_3 = L3_1
          L1_3 = L4_2
          L0_3(L1_3)
        end
        L11_2.onSelect = L12_2
        L10_2[1] = L11_2
        L7_2(L8_2, L9_2, L10_2)
      end
    end
  end
end
L5_1 = CreateThread
function L6_1()
  local L0_2, L1_2
  L0_2 = L4_1
  L0_2()
end
L5_1(L6_1)
L5_1 = AddEventHandler
L6_1 = "onResourceStop"
function L7_1(A0_2)
  local L1_2
  L1_2 = GetCurrentResourceName
  L1_2 = L1_2()
  if L1_2 ~= A0_2 then
    return
  end
  L1_2 = L1_1
  L1_2()
end
L5_1(L6_1, L7_1)
