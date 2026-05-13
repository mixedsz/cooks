local L0_1, L1_1
L0_1 = lib
L0_1 = L0_1.class
L1_1 = "Nui"
L0_1 = L0_1(L1_1)
Nui = L0_1
L0_1 = Nui
function L1_1(A0_2)
  local L1_2
  L1_2 = {}
  A0_2.private = L1_2
end
L0_1.constructor = L1_1
L0_1 = Nui
function L1_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2
  L3_2 = SendNUIMessage
  L4_2 = {}
  L4_2.action = A1_2
  L4_2.data = A2_2
  L3_2(L4_2)
end
L0_1.msg = L1_1
L0_1 = Nui
function L1_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2
  L3_2 = RegisterNUICallback
  L4_2 = A1_2
  function L5_2(A0_3, A1_3)
    local L2_3, L3_3, L4_3
    L2_3 = A2_2
    L3_3 = A0_3
    L4_3 = A1_3
    L2_3(L3_3, L4_3)
  end
  L3_2(L4_2, L5_2)
end
L0_1.cb = L1_1
