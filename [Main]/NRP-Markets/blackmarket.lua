------------------------------------------------------
---------------------- Blackmarket -------------------
------------------------------------------------------
local gun2 = nil
local gun4 = nil
local gun9 = nil
local gun10 = nil
local gun11 = nil
local gun13 = nil
local gun14 = nil
local gun16 = nil
local gun18 = nil
local gun22 = nil
local gun23 = nil
local gun24 = nil
local gun25 = nil
local gun26 = nil
local gun27 = nil
local gun28 = nil
local gun22 = nil
local gun23 = nil
local gun24 = nil
local gun25 = nil
local gun26 = nil
local gun27 = nil
local gun28 = nil
local gun31 = nil
local ketamine1 = nil
local heroin1 = nil
local cocaine1 = nil
local moneywash2 = nil
local getbait = nil

local blackmarket2 = {[1] = {x = -154.658, y = -1643.478, z = 36.851}} --heading = 178.829},  Forum Dr //Moved
local blackmarket9 = {[1] = {x = 152.607, y = 6504.867, z = 31.669}}  --heading = 48.373},   Paleto Burgers/Water Non Blackmarket 
local blackmarket10 = {[1] = {x = 97.758, y = 283.796, z = 109.300}} --heading = 339.779},   Vinewood Drive Thru Non Blackmarket
local blackmarket11 = {[1] = {x = 144.499, y = -1461.527, z = 29.142}} --heading = 48.800},  Strawberry Drive Thru Non Blackmarket 1
local blackmarket13 = {[1] = {x = 145.572, y = -1460.359, z = 29.142}} --heading = 48.800},  Strawberry Drive Thru Non Blackmarket 2
local blackmarket14 = {[1] = {x = 3435.035, y = 5175.754, z = 7.397}} --heading = 48.800}, Coke Dealer
local blackmarket16 = {[1] = {x = 472.009, y = -1310.640, z = 29.219}} --heading = 115.193}, Mechanic Vouchers and repair kits
local blackmarket20 = {[1] = {x = 312.84, y = -593.03, z = 43.28}} --heading = }, Pillbox Pharmacy 
local blackmarket21 = {[1] = {x = -824.960, y = -2118.686, z = 96.258}} --heading = 223.770},  marky //Moved
local blackmarket22 = {[1] = {x = 2317.343, y = -2102.712, z = 5.543}} --heading = 223.770},  c4

local blackmarket_weapons2 = { ---Forum Drive Lamar //Moved
[1] = {label = 'Blunt', name = 'Item', price = 20, id = 123},
[2] = {label = 'Bulletproof Vest', name = 'Item', price = 1500, id = 42},
[3] = {label = 'Lockpick', name = 'Item', price = 100, id = 7},
[4] = {label = 'Machete', name = 'Item', price = 700, id = 210},
[5] = {label = 'Hatchet', name = 'Item', price = 1000, id = 203},  
[6] = {label = 'Blindfold', name = 'Item', price = 1000, id = 76},
[7] = {label = 'Radio Scanner', name = 'Item', price = 5000, id = 161},
}

local blackmarket_weapons9 = { --- Bobs Burgers
[1] = {label = 'Bottle Of Water', name = 'Item', price = 5, id = 13},
[2] = {label = 'Cheese Burger', name = 'Item', price = 7, id = 14},
[3] = {label = 'Hot Dog', name = 'Item', price = 10, id = 105},
}

local blackmarket_weapons10 = { --- Drive Thru
[1] = {label = 'Bottle Of Water', name = 'Item', price = 4, id = 13},
[2] = {label = 'Cheese Burger', name = 'Item', price = 8, id = 14},
[3] = {label = 'Hot Dog', name = 'Item', price = 10, id = 105},
}

local blackmarket_weapons11 = { --- Drive Thru
[1] = {label = 'Bottle Of Water', name = 'Item', price = 4, id = 13},
[2] = {label = 'Cheese Burger', name = 'Item', price = 8, id = 14},
[3] = {label = 'Hot Dog', name = 'Item', price = 10, id = 105},
}

local blackmarket_weapons13 = { --- Drive Thru
[1] = {label = 'Bottle Of Water', name = 'Item', price = 4, id = 13},
[2] = {label = 'Cheese Burger', name = 'Item', price = 8, id = 14},
[3] = {label = 'Hot Dog', name = 'Item', price = 10, id = 105},
}

local blackmarket_weapons14 = {
[1] = {label = 'Blank Plate', name = 'Item', price = 15000, id = 262},
[2] = {label = 'Radio Scanner', name = 'Item', price = 5000, id = 161},
}

local blackmarket_weapons16 = { --- Mechanics Laptop
[1] = {label = 'Repair Kit', name = 'Item', price = 3000, id = 6},
[2] = {label = 'Advanced Lockpick', name = 'Item', price = 2250, id = 21},
[3] = {label = 'Pipe Wrench', name = 'Item', price = 700, id = 192},  
[4] = {label = 'Blindfold', name = 'Item', price = 1000, id = 76},  
[7] = {label = 'Radio Scanner', name = 'Item', price = 5000, id = 161},
}

local blackmarket_weapons20 = { --- Pillbox Upper Meds
[1] = {label = 'First Aid Kit', name = 'Item', price = 75, id = 144},
[2] = {label = 'Emergency Medkit', name = 'Item', price = 500, id = 145},
[3] = {label = 'The Human Fixkit', name = 'Item', price = 200, id = 73},
[5] = {label = 'Bandage', name = 'Item', price = 10, id = 10},
[6] = {label = 'Strong Painkillers', name = 'Item', price = 20, id = 148}, 
[7] = {label = 'Morphine', name = 'Item', price = 30, id = 149}, 
[8] = {label = 'Bandage & Gauze', name = 'Item', price = 50, id = 150}, 
}

local blackmarket_weapons22 = { --- Ketamine //Moved
[1] = {label = 'C4 Explosive', name = 'Item', price = 2000, id = 276},   
[2] = {label = 'Hatchet', name = 'Item', price = 1000, id = 203},  
[3] = {label = 'Blindfold', name = 'Item', price = 1000, id = 76},
[4] = {label = 'Radio Scanner', name = 'Item', price = 5000, id = 161},
}

Citizen.CreateThread(function()
 WarMenu.CreateMenu('blackmarket2', 'Lamar')
 WarMenu.CreateMenu('blackmarket9', 'Street Dealer')
 WarMenu.CreateMenu('blackmarket11', 'Street Dealer')
 WarMenu.CreateMenu('blackmarket14', 'Street Dealer')
 WarMenu.CreateMenu('blackmarket18', 'Street Dealer')
 WarMenu.CreateMenu('blackmarket20', 'Street Dealer')
 WarMenu.CreateMenu('blackmarket22', 'Street Dealer')
 WarMenu.CreateMenu('blackmarket9', 'Fast Food')
 WarMenu.CreateMenu('blackmarket10', 'Fast Food')
 WarMenu.CreateMenu('blackmarket11', 'Fast Food')
 WarMenu.CreateMenu('blackmarket13', 'Fast Food')
 WarMenu.CreateMenu('blackmarket16', 'Dealer')
 WarMenu.CreateMenu('blackmarket20', 'Pharmacy')
 while true do
  Citizen.Wait(10)
  fastfood()
  mirrormarkets()
  end
 end)

 -- Peds
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(60000)
  spawnGunman()
  spawnGunman2() 
  end
end)

function mirrormarkets()
  for k,v in pairs(blackmarket2) do
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 1.2) then
      DrawText3Ds(v.x, v.y, v.z,'~g~[E]~w~ to talk business')
      if IsControlPressed(0, 38) and not WarMenu.IsMenuOpened('blackmarket2') then
          WarMenu.OpenMenu('blackmarket2')
      end
      end
  end
  if WarMenu.IsMenuOpened('blackmarket2') then
      for ind, v in pairs(blackmarket_weapons2) do
      if WarMenu.Button(v.label, "~r~$"..v.price) then
          if v.name ~= 'Item' then
          TriggerServerEvent('bmshops:purchase', v.name, v.price, 1, v.id)
          else
          TriggerServerEvent('bmshops:purchase', v.name, v.price, 1, v.id)
          end
      end
      end
      WarMenu.Display()
  end
  for k,v in pairs(blackmarket14) do
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 1.2) then
      DrawText3Ds(v.x, v.y, v.z,'~g~[E]~w~ to talk business')
      if IsControlPressed(0, 38) and not WarMenu.IsMenuOpened('blackmarket14') then
          WarMenu.OpenMenu('blackmarket14')
      end
      end
  end
  if WarMenu.IsMenuOpened('blackmarket14') then
      for ind, v in pairs(blackmarket_weapons14) do
      if WarMenu.Button(v.label, "~r~$"..v.price) then
          if v.name ~= 'Item' then
          TriggerServerEvent('bmshops:purchase', v.name, v.price, 1, v.id)
          else
          TriggerServerEvent('bmshops:purchase', v.name, v.price, 1, v.id)
          end
      end
      end
      WarMenu.Display()
  end
  for k,v in pairs(blackmarket22) do
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 1.2) then
      DrawText3Ds(v.x, v.y, v.z,'~g~[E]~w~ Talk Business')
      if IsControlPressed(0, 38) and not WarMenu.IsMenuOpened('blackmarket22') then
          WarMenu.OpenMenu('blackmarket22')
      end
      end
  end
  if WarMenu.IsMenuOpened('blackmarket22') then
      for ind, v in pairs(blackmarket_weapons22) do
      if WarMenu.Button(v.label, "~r~$"..v.price) then
          if v.name ~= 'Item' then
          TriggerServerEvent('bmshops:purchase', v.name, v.price, 1, v.id)
          else
          TriggerServerEvent('bmshops:purchase', v.name, v.price, 1, v.id)
          end
      end
      end
      WarMenu.Display()
  end
end

function fastfood()
  for k,v in pairs(blackmarket9) do
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 1.2) then
      DrawText3Ds(v.x, v.y, v.z,'~g~[E]~w~ to order food')
     if IsControlPressed(0, 38) and not WarMenu.IsMenuOpened('blackmarket9') then
      WarMenu.OpenMenu('blackmarket9')
     end
    end
   end
  if WarMenu.IsMenuOpened('blackmarket9') then
   for ind, v in pairs(blackmarket_weapons9) do
    if WarMenu.Button(v.label, "~g~$"..v.price) then
     if v.name ~= 'Item' then 
      TriggerServerEvent('foodmarket:purchase', v.name, v.label, v.price)
     else
      TriggerServerEvent('shops:purchase', v.name, v.price, 1, v.id)
     end
    end 
   end
   WarMenu.Display()
  end
  for k,v in pairs(blackmarket10) do
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 1.2) then
      DrawText3Ds(v.x, v.y, v.z,'~g~[E]~w~ to order food')
     if IsControlPressed(0, 38) and not WarMenu.IsMenuOpened('blackmarket10') then
      WarMenu.OpenMenu('blackmarket10')
     end
    end
   end
  if WarMenu.IsMenuOpened('blackmarket10') then
   for ind, v in pairs(blackmarket_weapons10) do
    if WarMenu.Button(v.label, "~g~$"..v.price) then
     if v.name ~= 'Item' then 
      TriggerServerEvent('foodmarket:purchase', v.name, v.label, v.price)
     else
      TriggerServerEvent('shops:purchase', v.name, v.price, 1, v.id)
     end
    end 
   end
   WarMenu.Display()
  end
  for k,v in pairs(blackmarket11) do
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 1.2) then
      DrawText3Ds(v.x, v.y, v.z,'~g~[E]~w~ to order food')
     if IsControlPressed(0, 38) and not WarMenu.IsMenuOpened('blackmarket11') then
      WarMenu.OpenMenu('blackmarket11')
     end
    end
   end
  if WarMenu.IsMenuOpened('blackmarket11') then
   for ind, v in pairs(blackmarket_weapons11) do
    if WarMenu.Button(v.label, "~g~$"..v.price) then
     if v.name ~= 'Item' then 
      TriggerServerEvent('foodmarket:purchase', v.name, v.label, v.price)
     else
      TriggerServerEvent('shops:purchase', v.name, v.price, 1, v.id)
     end
    end 
   end
   WarMenu.Display()
  end
  for k,v in pairs(blackmarket13) do
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 1.2) then
      DrawText3Ds(v.x, v.y, v.z,'~g~[E]~w~ to order food')
     if IsControlPressed(0, 38) and not WarMenu.IsMenuOpened('blackmarket13') then
      WarMenu.OpenMenu('blackmarket13')
     end
    end
  end
  if WarMenu.IsMenuOpened('blackmarket13') then
   for ind, v in pairs(blackmarket_weapons13) do
    if WarMenu.Button(v.label, "~g~$"..v.price) then
     if v.name ~= 'Item' then 
      TriggerServerEvent('foodmarket:purchase', v.name, v.label, v.price)
     else
      TriggerServerEvent('shops:purchase', v.name, v.price, 1, v.id)
     end
    end 
   end
   WarMenu.Display()
  end 
  for k,v in pairs(blackmarket16) do
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 1.2) then
      DrawText3Ds(v.x, v.y, v.z,'~g~[E]~w~ to use Talk Business')
     if IsControlPressed(0, 38) and not WarMenu.IsMenuOpened('blackmarket16') then
      WarMenu.OpenMenu('blackmarket16')
     end
    end
  end
  if WarMenu.IsMenuOpened('blackmarket16') then
   for ind, v in pairs(blackmarket_weapons16) do
    if WarMenu.Button(v.label, "~r~$"..v.price) then
     if v.name ~= 'Item' then 
      TriggerServerEvent('bmshops:purchase', v.name, v.price, 1, v.id)
     else
      TriggerServerEvent('bmshops:purchase', v.name, v.price, 1, v.id)
     end
    end 
   end
   WarMenu.Display()
  end
  for k,v in pairs(blackmarket20) do
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 1.2) then
     DrawText3Ds(v.x, v.y, v.z,'~g~[E]~w~ to use pharmacy')
     if IsControlPressed(0, 38) and not WarMenu.IsMenuOpened('blackmarket20') then
      WarMenu.OpenMenu('blackmarket20')
     end
    end
   end
  if WarMenu.IsMenuOpened('blackmarket20') then
   for ind, v in pairs(blackmarket_weapons20) do
    if WarMenu.Button(v.label, "~g~$"..v.price) then
     if v.name ~= 'Item' then 
      TriggerServerEvent('foodmarket:purchase', v.name, v.label, v.price)
     else
      TriggerServerEvent('shops:purchase', v.name, v.price, 1, v.id)
     end
    end 
   end
   WarMenu.Display()
  end
end  

function spawnGunman()
  if gun2 == nil then
  RequestModel(GetHashKey('ig_lamardavis'))
  while not HasModelLoaded(GetHashKey('ig_lamardavis')) do
      Wait(5)
  end
  gun2 = CreatePed(2, GetHashKey('ig_lamardavis'), -154.658, -1643.478, 36.851, 46.439, false, false)
  SetPedFleeAttributes(gun2, 0, 0)
  SetPedDiesWhenInjured(gun2, false)
  TaskStartScenarioInPlace(gun2, "WORLD_HUMAN_DRUG_DEALER_HARD", 0, true)
  SetPedKeepTask(gun2, true)
  end
  if gun9 == nil then
  RequestModel(GetHashKey('s_m_y_barman_01'))
  while not HasModelLoaded(GetHashKey('s_m_y_barman_01')) do
      Wait(5)
  end
  gun9 = CreatePed(2, GetHashKey('s_m_y_barman_01'), -1585.050, -3014.085, -76.005, 80.031, false, false)
  SetPedFleeAttributes(gun9, 0, 0)
  SetPedDiesWhenInjured(gun9, false)
  TaskStartScenarioInPlace(gun9, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
  SetPedKeepTask(gun9, true)
  end
  if gun10 == nil then
  RequestModel(GetHashKey('s_m_m_bouncer_01'))
  while not HasModelLoaded(GetHashKey('s_m_m_bouncer_01')) do
      Wait(5)
  end
  gun10 = CreatePed(2, GetHashKey('s_m_m_bouncer_01'), -1576.982, -3010.452, -79.006, 350.407, false, false)
  SetPedFleeAttributes(gun10, 0, 0)
  SetPedDiesWhenInjured(gun10, false)
  TaskStartScenarioInPlace(gun10, "WORLD_HUMAN_COP_IDLES", 0, true)
  SetPedKeepTask(gun10, true)
  end
  if gun11 == nil then
  RequestModel(GetHashKey('s_f_y_bartender_01'))
  while not HasModelLoaded(GetHashKey('s_f_y_bartender_01')) do
      Wait(5)
  end
  gun11 = CreatePed(2, GetHashKey('s_f_y_bartender_01'), -1577.122, -3016.616, -79.006, 0.482, false, false)
  SetPedFleeAttributes(gun11, 0, 0)
  SetPedDiesWhenInjured(gun11, false)
  TaskStartScenarioInPlace(gun11, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
  SetPedKeepTask(gun11, true)
  end
  if gun13 == nil then
  RequestModel(GetHashKey('ig_g'))
  while not HasModelLoaded(GetHashKey('ig_g')) do
      Wait(5)
  end
  gun13 = CreatePed(2, GetHashKey('ig_g'), -1609.360, -3018.375, -79.006, 192.375, false, false)
  SetPedFleeAttributes(gun13, 0, 0)
  SetPedDiesWhenInjured(gun13, false)
  TaskStartScenarioInPlace(gun13, "WORLD_HUMAN_LEANING", 0, true)
  SetPedKeepTask(gun13, true)
  end
  if gun14 == nil then
  RequestModel(GetHashKey('ig_cletus'))
  while not HasModelLoaded(GetHashKey('ig_cletus')) do
      Wait(5)
  end
  gun14 = CreatePed(2, GetHashKey('ig_cletus'), 3435.035, 5175.754, 7.397, 289.417, false, false)
  SetPedFleeAttributes(gun14, 0, 0)
  SetPedDiesWhenInjured(gun14, false)
  TaskStartScenarioInPlace(gun14, "WORLD_HUMAN_COP_IDLES", 0, true)
  SetPedKeepTask(gun14, true)
  end
  if gun16 == nil then
  RequestModel(GetHashKey('a_m_y_motox_01'))
  while not HasModelLoaded(GetHashKey('a_m_y_motox_01')) do
      Wait(5)
  end
  gun16 = CreatePed(2, GetHashKey('a_m_y_motox_01'), 1151.327, 2338.397, 53.660, 98.547, false, false)
  SetPedFleeAttributes(gun16, 0, 0)
  SetPedDiesWhenInjured(gun16, false)
  TaskStartScenarioInPlace(gun16, "WORLD_HUMAN_DRUG_DEALER", 0, true)
  SetPedKeepTask(gun16, true)
  end
  if gun18 == nil then
  RequestModel(GetHashKey('g_f_y_families_01'))
  while not HasModelLoaded(GetHashKey('g_f_y_families_01')) do
      Wait(5)
  end ---edit
  gun18 = CreatePed(2, GetHashKey('g_f_y_families_01'), -1601.769, -3006.226, -79.006, 335.363, false, false)
  SetPedFleeAttributes(gun18, 0, 0)
  SetPedDiesWhenInjured(gun18, false)
  TaskStartScenarioInPlace(gun18, "WORLD_HUMAN_PARTYING", 0, true)
  SetPedKeepTask(gun18, true)
  end
  if gun20 == nil then
  RequestModel(GetHashKey('u_m_m_jesus_01'))
  while not HasModelLoaded(GetHashKey('u_m_m_jesus_01')) do
      Wait(5)
  end
  --edit
  gun20 = CreatePed(2, GetHashKey('u_m_m_jesus_01'), -1589.170, -3019.206, -79.002, 0.583, false, false)
  SetPedFleeAttributes(gun20, 0, 0)
  SetPedDiesWhenInjured(gun20, false)
  TaskStartScenarioInPlace(gun20, "WORLD_HUMAN_BUM_STANDING", 0, true)
  SetPedKeepTask(gun20, true)
  end
  if gun22 == nil then
  RequestModel(GetHashKey('ig_hunter'))
  while not HasModelLoaded(GetHashKey('ig_hunter')) do
      Wait(5)
  end
  gun22 = CreatePed(2, GetHashKey('ig_hunter'), 2317.343, -2102.712, 5.543, 182.296, false, false)
  SetPedFleeAttributes(gun22, 0, 0)
  SetPedDiesWhenInjured(gun22, false)
  TaskStartScenarioInPlace(gun22, "WORLD_HUMAN_SMOKING", 0, true)
  SetPedKeepTask(gun22, true)
  end
  if gun23 == nil then
  RequestModel(GetHashKey('a_m_y_business_03'))
  while not HasModelLoaded(GetHashKey('a_m_y_business_03')) do
      Wait(5)
  end
  gun23 = CreatePed(2, GetHashKey('a_m_y_business_03'), -2040.926, -365.726, 44.107, 173.708, false, false)
  SetPedFleeAttributes(gun23, 0, 0)
  SetPedDiesWhenInjured(gun23, false)
  TaskStartScenarioInPlace(gun23, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
  SetPedKeepTask(gun23, true)
  end
  if gun24 == nil then
  RequestModel(GetHashKey('a_m_y_business_01'))
  while not HasModelLoaded(GetHashKey('a_m_y_business_01')) do
      Wait(5)
  end
  gun24 = CreatePed(2, GetHashKey('a_m_y_business_01'), -411.689, 151.568, 81.743, 309.526, false, false)
  SetPedFleeAttributes(gun24, 0, 0)
  SetPedDiesWhenInjured(gun24, false)
  TaskStartScenarioInPlace(gun24, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
  SetPedKeepTask(gun24, true)
  end
  if gun25 == nil then
  RequestModel(GetHashKey('s_m_y_robber_01'))
  while not HasModelLoaded(GetHashKey('s_m_y_robber_01')) do
      Wait(5)
  end
  gun25 = CreatePed(2, GetHashKey('s_m_y_robber_01'), 1993.038, 3051.344, 47.215, 237.860, false, false)
  SetPedFleeAttributes(gun25, 0, 0)
  SetPedDiesWhenInjured(gun25, false)
  TaskStartScenarioInPlace(gun25, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
  SetPedKeepTask(gun25, true)
  end
  if gun26 == nil then
  RequestModel(GetHashKey('ig_cletus'))
  while not HasModelLoaded(GetHashKey('ig_cletus')) do
      Wait(5)
  end
  gun26 = CreatePed(2, GetHashKey('ig_cletus'), -3266.279, 1041.823, 13.110-0.90, 126.588, false, false)
  SetPedFleeAttributes(gun26, 0, 0)
  SetPedDiesWhenInjured(gun26, false)
  TaskStartScenarioInPlace(gun26, "WORLD_HUMAN_COP_IDLES", 0, true)
  SetPedKeepTask(gun26, true)
  end
  if gun27 == nil then
  RequestModel(GetHashKey('s_m_y_armymech_01'))
  while not HasModelLoaded(GetHashKey('s_m_y_armymech_01')) do
      Wait(5)
  end
  gun27 = CreatePed(2, GetHashKey('s_m_y_armymech_01'), -2101.276, 2806.965, 36.887, 65.969, false, false)
  SetPedFleeAttributes(gun27, 0, 0)
  SetPedDiesWhenInjured(gun27, false)
  TaskStartScenarioInPlace(gun27, "WORLD_HUMAN_DRUG_DEALER_HARD", 0, true)
  SetPedKeepTask(gun27, true)
  end
  if gun28 == nil then
  RequestModel(GetHashKey('a_m_y_business_03'))
  while not HasModelLoaded(GetHashKey('a_m_y_business_03')) do
      Wait(5)
  end
  gun28 = CreatePed(2, GetHashKey('a_m_y_business_03'), -1192.603, -215.370, 37.945, 144.815, false, false)
  SetPedFleeAttributes(gun28, 0, 0)
  SetPedDiesWhenInjured(gun28, false)
  TaskStartScenarioInPlace(gun28, "WORLD_HUMAN_DRUG_DEALER_HARD", 0, true)
  SetPedKeepTask(gun28, true)
  else
    DeletePed(gun2)
    gun2 = nil
    DeletePed(gun9)
    gun9 = nil
    DeletePed(gun10)
    gun10 = nil
    DeletePed(gun11)
    gun11 = nil
    DeletePed(gun13)
    gun13 = nil
    DeletePed(gun14)
    gun14 = nil
    DeletePed(gun16)
    gun16 = nil
    DeletePed(gun18)
    gun18 = nil
    DeletePed(gun20)
    gun20 = nil
    DeletePed(gun22)
    gun22 = nil
    DeletePed(gun23)
    gun23 = nil
    DeletePed(gun24)
    gun24 = nil
    DeletePed(gun25)
    gun25 = nil
    DeletePed(gun26)
    gun26 = nil
    DeletePed(gun27)
    gun27 = nil
    DeletePed(gun28)
    gun28 = nil
    DeletePed(ketamine1)
    ketamine1 = nil
    DeletePed(heroin1)
    heroin1 = nil
    DeletePed(cocaine1)
    cocaine1 = nil
    DeletePed(moneywash2)
    moneywash2 = nil
    DeletePed(getbait)
    getbait = nil
  end
end

function spawnGunman2()
  if gun31 == nil then
    RequestModel(GetHashKey('a_m_y_business_03'))
    while not HasModelLoaded(GetHashKey('a_m_y_business_03')) do
     Wait(5)
    end 
    gun31 = CreatePed(2, GetHashKey('a_m_y_business_03'), -1673.699, -224.295, 55.100, 250.197, false, false)
    SetPedFleeAttributes(gun31, 0, 0)
    SetPedDiesWhenInjured(gun31, false)
    TaskStartScenarioInPlace(gun31, "WORLD_HUMAN_DRUG_DEALER_HARD", 0, true)
    SetPedKeepTask(gun31, true)
  end

  local rep = DecorGetInt(GetPlayerPed(-1), "Reputation")

  if ketamine1 == nil and rep >= 1000 then
    RequestModel(GetHashKey('u_m_o_tramp_01'))
    while not HasModelLoaded(GetHashKey('u_m_o_tramp_01')) do
     Wait(5)
    end 
    ketamine1 = CreatePed(2, GetHashKey('u_m_o_tramp_01'), 975.46, -2358.08, 31.82, 181.47, false, false)
    SetPedFleeAttributes(ketamine1, 0, 0)
    SetPedDiesWhenInjured(ketamine1, false)
    TaskStartScenarioInPlace(ketamine1, "WORLD_HUMAN_DRUG_DEALER_HARD", 0, true)
    SetPedKeepTask(ketamine1, true)
  end
  if heroin1 == nil and rep >= 1500 then
    RequestModel(GetHashKey('u_m_o_tramp_01'))
    while not HasModelLoaded(GetHashKey('u_m_o_tramp_01')) do
     Wait(5)
    end 
    heroin1 = CreatePed(2, GetHashKey('u_m_o_tramp_01'), 62.76, 6664.29, 31.79, 275.95, false, false)
    SetPedFleeAttributes(heroin1, 0, 0)
    SetPedDiesWhenInjured(heroin1, false)
    TaskStartScenarioInPlace(heroin1, "WORLD_HUMAN_DRUG_DEALER_HARD", 0, true)
    SetPedKeepTask(heroin1, true)
  end
  if cocaine1 == nil and rep >= 2000 then
    RequestModel(GetHashKey('u_m_o_tramp_01'))
    while not HasModelLoaded(GetHashKey('u_m_o_tramp_01')) do
     Wait(5)
    end 
    cocaine1 = CreatePed(2, GetHashKey('u_m_o_tramp_01'), -2054.24, -1034.94, 5.88, 250.59, false, false)
    SetPedFleeAttributes(cocaine1, 0, 0)
    SetPedDiesWhenInjured(cocaine1, false)
    TaskStartScenarioInPlace(cocaine1, "WORLD_HUMAN_DRUG_DEALER_HARD", 0, true)
    SetPedKeepTask(cocaine1, true)
  end

  if moneywash2 == nil then
    RequestModel(GetHashKey('a_m_y_hasjew_01'))
    while not HasModelLoaded(GetHashKey('a_m_y_hasjew_01')) do
     Wait(5)
    end 
    moneywash2 = CreatePed(2, GetHashKey('a_m_y_hasjew_01'), 905.441, -1688.000, 47.352, -280.197, false, false)
    SetPedFleeAttributes(moneywash2, 0, 0)
    SetPedDiesWhenInjured(moneywash2, false)
    TaskStartScenarioInPlace(moneywash2, "WORLD_HUMAN_DRUG_DEALER_HARD", 0, true)
    SetPedKeepTask(moneywash2, true)
  end

  if getbait == nil then
    RequestModel(GetHashKey('g_m_m_chicold_01'))
    while not HasModelLoaded(GetHashKey('g_m_m_chicold_01')) do
     Wait(5)
    end 
    getbait = CreatePed(2, GetHashKey('g_m_m_chicold_01'), 3611.800, 5026.807, 11.350, -100.197, false, false)
    SetPedFleeAttributes(getbait, 0, 0)
    SetPedDiesWhenInjured(getbait, false)
    TaskStartScenarioInPlace(getbait, "WORLD_HUMAN_DRUG_DEALER_HARD", 0, true)
    SetPedKeepTask(getbait, true)
  end
end

function DrawText3Ds(x,y,z, text)
  local onScreen,_x,_y=World3dToScreen2d(x,y,z)
  local px,py,pz=table.unpack(GetGameplayCamCoords())
  
  SetTextScale(0.35, 0.35)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextColour(255, 255, 255, 215)
  SetTextEntry("STRING")
  SetTextCentre(1)
  AddTextComponentString(text)
  DrawText(_x,_y)
end

