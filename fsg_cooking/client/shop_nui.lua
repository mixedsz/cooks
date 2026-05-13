local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  if "cash" == A1_2 then
    L2_2 = exports
    L2_2 = L2_2.ox_inventory
    L3_2 = L2_2
    L2_2 = L2_2.Search
    L4_2 = "count"
    L5_2 = "money"
    L2_2 = L2_2(L3_2, L4_2, L5_2)
    L3_2 = A0_2 <= L2_2
    return L3_2
  elseif "bank" == A1_2 then
    L2_2 = lib
    L2_2 = L2_2.callback
    L2_2 = L2_2.await
    L3_2 = "fsg_cooking:checkBankBalance"
    L4_2 = false
    L5_2 = A0_2
    return L2_2(L3_2, L4_2, L5_2)
  end
  L2_2 = false
  return L2_2
end
function L1_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  if "cash" == A1_2 then
    L2_2 = exports
    L2_2 = L2_2.ox_inventory
    L3_2 = L2_2
    L2_2 = L2_2.RemoveItem
    L4_2 = "money"
    L5_2 = A0_2
    return L2_2(L3_2, L4_2, L5_2)
  elseif "bank" == A1_2 then
    L2_2 = lib
    L2_2 = L2_2.callback
    L2_2 = L2_2.await
    L3_2 = "fsg_cooking:removeBankMoney"
    L4_2 = false
    L5_2 = A0_2
    return L2_2(L3_2, L4_2, L5_2)
  end
  L2_2 = false
  return L2_2
end
L2_1 = Nui
L3_1 = L2_1
L2_1 = L2_1.cb
L4_1 = "purchaseItems"
function L5_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L2_2 = A0_2.total
  L3_2 = A0_2.items
  L4_2 = A0_2.paymentMethod
  if "cash" == L4_2 then
    L5_2 = lib
    L5_2 = L5_2.callback
    L5_2 = L5_2.await
    L6_2 = "fsg_cooking:checkCashBalance"
    L7_2 = false
    L8_2 = L2_2
    L5_2 = L5_2(L6_2, L7_2, L8_2)
    if not L5_2 then
      L6_2 = A1_2
      L7_2 = {}
      L7_2.success = false
      L7_2.message = "Insufficient funds"
      L6_2(L7_2)
      return
    end
  end
  if "bank" == L4_2 then
    L5_2 = lib
    L5_2 = L5_2.callback
    L5_2 = L5_2.await
    L6_2 = "fsg_cooking:checkBankBalance"
    L7_2 = false
    L8_2 = L2_2
    L5_2 = L5_2(L6_2, L7_2, L8_2)
    if not L5_2 then
      L6_2 = A1_2
      L7_2 = {}
      L7_2.success = false
      L7_2.message = "Insufficient funds"
      L6_2(L7_2)
      return
    end
  end
  L5_2 = lib
  L5_2 = L5_2.callback
  L5_2 = L5_2.await
  L6_2 = "fsg_cooking:purchaseItems"
  L7_2 = false
  L8_2 = L3_2
  L9_2 = L4_2
  L5_2, L6_2 = L5_2(L6_2, L7_2, L8_2, L9_2)
  L7_2 = A1_2
  L8_2 = {}
  L8_2.success = L5_2
  L8_2.message = L6_2
  L7_2(L8_2)
end
L2_1(L3_1, L4_1, L5_1)
L2_1 = Nui
L3_1 = L2_1
L2_1 = L2_1.cb
L4_1 = "closeShop"
function L5_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = SetNuiFocus
  L3_2 = false
  L4_2 = false
  L2_2(L3_2, L4_2)
  L2_2 = A1_2
  L3_2 = {}
  L2_2(L3_2)
end
L2_1(L3_1, L4_1, L5_1)
L2_1 = RegisterCommand
L3_1 = "testshop"
function L4_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2
  L0_2 = {}
  L1_2 = {}
  L2_2 = {}
  L3_2 = {}
  L3_2.item = "burger"
  L3_2.label = "Burger"
  L3_2.price = 10
  L4_2 = {}
  L4_2.item = "pizza"
  L4_2.label = "Pizza"
  L4_2.price = 15
  L2_2[1] = L3_2
  L2_2[2] = L4_2
  L1_2.Food = L2_2
  L2_2 = {}
  L3_2 = {}
  L3_2.item = "water"
  L3_2.label = "Water"
  L3_2.price = 5
  L4_2 = {}
  L4_2.item = "cola"
  L4_2.label = "Cola"
  L4_2.price = 8
  L2_2[1] = L3_2
  L2_2[2] = L4_2
  L1_2.Drinks = L2_2
  L0_2.categories = L1_2
  L0_2.label = "Test Shop"
  L1_2 = DisplayShopMenu
  L2_2 = L0_2
  L1_2(L2_2)
end
L5_1 = false
L2_1(L3_1, L4_1, L5_1)
