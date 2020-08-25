local veh_inventory = {}
local veh_weapons = {}
local vehicle_plate = nil
local maxCapacity = {
  [0] = {["item"] = 20, ["weapons"] = 1}, --Compact
  [1] = {["item"] = 30, ["weapons"] = 2}, --Sedan
  [2] = {["item"] = 50, ["weapons"] = 3}, --SUV
  [3] = {["item"] = 30, ["weapons"] = 2}, --Coupes
  [4] = {["item"] = 25, ["weapons"] = 1}, --Muscle
  [5] = {["item"] = 20, ["weapons"] = 1}, --Sports Classics
  [6] = {["item"] = 20, ["weapons"] = 1}, --Sports
  [7] = {["item"] = 15, ["weapons"] = 1}, --Super
  [8] = {["item"] = 5, ["weapons"] = 1}, --Motorcycles
  [9] = {["item"] = 40, ["weapons"] = 1}, --Off-road
  [10] = {["item"] = 100, ["weapons"] = 8}, --Industrial
  [11] = {["item"] = 25, ["weapons"] = 1}, --Utility
  [12] = {["item"] = 75, ["weapons"] = 4}, --Vans
  [14] = {["item"] = 0, ["weapons"] = 1}, --Boats
  [15] = {["item"] = 0, ["weapons"] = 1}, --Helicopters
  [16] = {["item"] = 0, ["weapons"] = 1}, --Planes
  [17] = {["item"] = 40, ["weapons"] = 1}, --Service
  [18] = {["item"] = 40, ["weapons"] = 2}, --Emergency
  [20] = {["item"] = 100, ["weapons"] = 5}, --Commercial
}

local fastResponse = {
  [1] = {id = "FBI"},
  [2] = {id = "SSPRES"},
  [3] = {id = "ONEBEAST"},
  [4] = {id = "POLICE2"},
  [5] = {id = "FBI2"},
  [6] = {id = "SUBURBAN '0"},
  [7] = {id = "POLICE"},
  [8] = {id = "POLICE3"},
  [9] = {id = "POLICE4"},
  [10] = {id = "RIOT"},
  [11] = {id = "RIOT2"},
  [12] = {id = "2015polstang"},
  [13] = {id = "POLICE"},
}

RegisterNetEvent('vehicle_inventory:updateitems')
AddEventHandler('vehicle_inventory:updateitems', function(inv, weapons)
 veh_inventory = {}
 veh_weapons = {}
 veh_inventory = inv
 veh_weapons = weapons
end)

function VehicleInFront()
 local pos = GetEntityCoords(GetPlayerPed(-1))
 local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 4.0, 0.0)
 local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
 local a, b, c, d, result = GetRaycastResult(rayHandle) 
 return result 
end

Citizen.CreateThread(function()
 while true do
   Wait(5)
  if vehicle_plate then
    local vehFront = VehicleInFront()
    if vehFront == 0 then
      exports['inventory']:closeInventory()
      vehicle_plate = nil
    end
  end
  if IsControlJustPressed(0, 182) and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
   if IsControlJustPressed(1, 21) or IsControlJustPressed(1, 71) or IsControlJustPressed(1, 139) or IsControlJustPressed(1, 142) or IsControlJustPressed(1, 78) or IsControlJustPressed(1, 87) or IsControlJustPressed(1, 92) or IsControlJustPressed(1, 129) then
   else
    PDtrunk = false
    local vehFront = VehicleInFront()
    local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
    local vehicle = GetClosestVehicle(x, y, z, 4.0, 0, 71)
    if vehFront > 0 and vehicle ~= nil then
     if GetVehicleDoorLockStatus(vehicle) == 1 then
       local t, distance = GetClosestPlayer()
       if(distance ~= -1 and distance < 3) then
        exports['NRP-notify']:DoHudText('error', 'Player near the trunk, tell them to move back.')
       else
         for k,v in pairs(fastResponse) do
           SetVehicleDoorOpen(vehFront, 5, false, false)
           vehicle_plate = GetVehicleNumberPlateText(vehFront)
           TriggerServerEvent("vehicle_inventory:getInventory", GetVehicleNumberPlateText(vehFront))
           TriggerEvent("vehicle_inventory:settype", GetVehicleClass(vehFront))
         end 
       end
     else
       exports['NRP-notify']:DoHudText('error', 'Vehicle Locked')
     end
    else
     vehicle_plate = nil
     exports['NRP-notify']:DoHudText('error', 'No Vehicle Near')
    end 
   end
   end
  end
 end)
 

--[[Citizen.CreateThread(function()
 local currentstore = 1
 local selectedstore = 1
 local currenttake = 1 
 local selectedtake = 1
 WarMenu.CreateMenu('vehicle_inventory', 'Trunk')
 WarMenu.CreateSubMenu('storage_depsoit', 'Trunk')
 WarMenu.CreateSubMenu('storage_depsoit', 'vehicle_inventory', 'storage_depsoit')
 WarMenu.CreateSubMenu('trunk_listitems', 'vehicle_inventory', 'trunk_listitems')
 while true do
  Citizen.Wait(5)
  if WarMenu.IsMenuOpened('vehicle_inventory') and not PDtrunk then
   if WarMenu.ComboBox('Store', {'Items', 'Weapons'}, currentstore, selectedstore, function(store)
     currentstore = store
     selectedstore = currentstore
    end) then
    if selectedstore == 1 then WarMenu.OpenMenu('storage_depsoit') elseif selectedstore then WarMenu.OpenMenu('trunk_storeweapons') end 
   elseif WarMenu.ComboBox('Take', {'Items', 'Weapons'}, currenttake, selectedtake, function(take)
     currenttake = take
     selectedtake = currenttake
    end) then
    if selectedtake == 1 then WarMenu.OpenMenu('trunk_listitems') elseif selectedtake == 2 then WarMenu.OpenMenu('trunk_listweapons') end 
   elseif WarMenu.Button('Close Trunk') then
    SetVehicleDoorShut(VehicleInFront(), 5, false)
    DecorSetBool(VehicleInFront(), "Trunk", false)
   end
   WarMenu.Display()
  elseif WarMenu.IsMenuOpened('storage_depsoit') then
   local inventory = getInventory()
   for i = 1,#inventory do
    if (inventory[i].q > 0) then
     if WarMenu.Button(tostring(inventory[i].name), tonumber(inventory[i].q)) then
      local t, distance = GetClosestPlayer()
      if(distance ~= -1 and distance < 4) then
       exports['NRP-notify']:DoHudText('inform', 'Player to Close, Tell Them To Move Back')
      else
       VehicleItemStore(inventory[i].id, inventory[i].name, inventory[i].q) 
      end
     end
    end
   end
   WarMenu.Display()
  elseif WarMenu.IsMenuOpened('trunk_listitems') then
   for i = 1,#veh_inventory do
    if (veh_inventory[i].q > 0) then
     if WarMenu.Button(veh_inventory[i].name, veh_inventory[i].q) then
      local t, distance = GetClosestPlayer()
      if(distance ~= -1 and distance < 5) then
       exports['NRP-notify']:DoHudText('inform', 'Player to Close, Tell Them To Move Back')
      else
       VehicleItemTake(veh_inventory[i].item, veh_inventory[i].q, veh_inventory[i].meta)
      end
     end
    end
   end
   WarMenu.Display()
  elseif WarMenu.IsMenuOpened('trunk_storeweapons') then
   local inventory = getWeapons()
   for i = 1,#inventory do
    if WarMenu.Button(tostring(inventory[i].label)) then
     if 1 + getVehicleWeapons() <= maxCapacity[GetVehicleClass(VehicleInFront())].weapons then
      TriggerServerEvent('vehicle_inventory:addweapon', vehicle_plate, inventory[i].name, inventory[i].label, inventory[i].id, inventory[i].blackmarket)
      TaskStartScenarioInPlace(GetPlayerPed(-1), 'PROP_HUMAN_BUM_BIN', false, true) 
      Wait(6000) 
      ClearPedTasksImmediately(GetPlayerPed(-1))
      TriggerServerEvent('core:giveweapons')
      TriggerEvent('weapons:updateback')
     else
      exports['NRP-notify']:DoHudText('error', 'Vehicle Can Only Hold'..maxCapacity[GetVehicleClass(VehicleInFront())].weapons..' Weapons')
     end
    end
   end
   WarMenu.Display()
  elseif WarMenu.IsMenuOpened('trunk_listweapons') then
   for i = 1,#veh_weapons do
    if WarMenu.Button(tostring(veh_weapons[i].label)) then
     TriggerServerEvent('vehicle_inventory:removeweapon', vehicle_plate, veh_weapons[i].name, veh_weapons[i].id, veh_weapons[i].label, veh_weapons[i].weapon_id, veh_weapons[i].blackmarket)
     TaskStartScenarioInPlace(GetPlayerPed(-1), 'PROP_HUMAN_BUM_BIN', false, true) 
     Wait(6000) 
     ClearPedTasksImmediately(GetPlayerPed(-1))
     TriggerServerEvent('core:giveweapons')
     TriggerEvent('weapons:updateback')
    end
   end
   WarMenu.Display()
  end
 end
end)]]--

function VehicleItemStore(item, name, quantity)
 local amount = "xxsdrtghyuujhdjsjenenfjfjtjtjtj"
 if(amount == "xxsdrtghyuujhdjsjenenfjfjtjtjtj") then
  showLoadingPrompt("Enter Quantity", 3)
  DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8S", "", "", "", "", "", 20)
  while (UpdateOnscreenKeyboard() == 0) do
   DisableAllControlActions(0);
   Wait(0);
  end
  if (GetOnscreenKeyboardResult()) then
   local option = tonumber(GetOnscreenKeyboardResult())
   if(option ~= nil and option ~= 0) then
    amount = ""..option
   end
  end
 end
 stopLoadingPrompt()
 if (amount ~= "xxsdrtghyuujhdjsjenenfjfjtjtjtj" and tonumber(amount) > 0) then
  if amount + getVehicleQuantity() <= maxCapacity[GetVehicleClass(VehicleInFront())].item then
   TriggerServerEvent('vehicle_inventory:additems', vehicle_plate, item, name, amount)
   TaskStartScenarioInPlace(GetPlayerPed(-1), 'PROP_HUMAN_BUM_BIN', false, true) 
   Wait(6000) 
   ClearPedTasksImmediately(GetPlayerPed(-1))  
 else
   exports['NRP-notify']:DoHudText('error', 'Vehicle Can Only Hold'..maxCapacity[GetVehicleClass(VehicleInFront())].item..' items')
  end
 end
end

function VehicleItemTake(item, qty, meta)
 local amount = "xxsdrtghyuujhdjsjenenfjfjtjtjtj"
 if(amount == "xxsdrtghyuujhdjsjenenfjfjtjtjtj") then
  showLoadingPrompt("Enter Quantity", 3)
  DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8S", "", "", "", "", "", 20)
  while (UpdateOnscreenKeyboard() == 0) do
   DisableAllControlActions(0);
   Wait(0);
  end
  if (GetOnscreenKeyboardResult()) then
   local option = tonumber(GetOnscreenKeyboardResult())
   if(option ~= nil and option ~= 0) then
    amount = ""..option
   end
  end
 end
 stopLoadingPrompt()
 if (amount ~= "xxsdrtghyuujhdjsjenenfjfjtjtjtj" and tonumber(amount) > 0) then
  if math.floor(getQuantity() + amount) <= 120 then
   if tonumber(amount) <= tonumber(qty) then 
    TriggerServerEvent('vehicle_inventory:removeitems', vehicle_plate, item, amount, meta)
    TaskStartScenarioInPlace(GetPlayerPed(-1), 'PROP_HUMAN_BUM_BIN', false, true) 
    Wait(6000) 
    ClearPedTasksImmediately(GetPlayerPed(-1))
   end 
  else
   exports['NRP-notify']:DoHudText('inform', 'Inventory Full')
  end
 end
end


function getVehicleQuantity()
 local quantity = 0
 for i=1,#veh_inventory do
  quantity = quantity + veh_inventory[i].q
 end
 return quantity
end

function getVehicleWeapons()
 local quantity = 0
 for i=1,#veh_weapons do
  quantity = quantity + 1
 end
 return quantity
end

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)
    
    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = Vdist(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"])
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    
    return closestPlayer, closestDistance
end

function GetPlayers()
    local players = {}

    for _, player in ipairs(GetActivePlayers()) do
      table.insert(players, player)
    end

    return players
end