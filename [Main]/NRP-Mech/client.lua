-- New system
local brokenParts = {
    [1] = {name="Gear Box"},
    [2] = {name="Clutch"},
    [3] = {name="Exhaust"},
    [4] = {name="Vehicle Airbag"},
}

local vehicleLocation = {
    {x = 145.632, y = 6630.923, z = 31.665},
    {x = 1377.606, y = 3600.424, z = 34.851},
    {x = 494.977, y = -1331.707, z = 29.337},
    {x = -1535.340, y = -575.951, z = 33.656},
    {x = 530.635, y = -179.906, z = 54.328},
}

local onCollection = 0
local currentStock = {}
local currentStore = nil
local nearPoint = false
local onCollectionHigher = 0


RegisterNetEvent('mechanic:getstock')
AddEventHandler('mechanic:getstock', function(results)
 currentStock = results
end)

--[[Citizen.CreateThread(function()
 WarMenu.CreateLongMenu('stocklisting', "Parts")
 WarMenu.CreateLongMenu('buy_stocklisting', "Purchase Stock")
 while true do
  local coords = GetEntityCoords(GetPlayerPed(-1))
  Wait(0)
  if not IsPedInAnyVehicle(GetPlayerPed(-1), false) and onCollection == 0 then
   if(GetDistanceBetweenCoords(coords, 99.999, 6620.228, 32.435, true) < 1.2) and DecorGetInt(GetPlayerPed(-1), "Job") == 3 then
    API_DrawTxt('~g~[E]~w~ Stock Deliveries')
    if IsControlJustPressed(0, 38) then
     WarMenu.OpenMenu('buy_stocklisting')
    end
   end
  end
  
  --[[if DecorGetInt(GetPlayerPed(-1), "Job") == 3 then
    if(GetDistanceBetweenCoords(coords, 98.025, 6619.415, 32.435, true) < 15.0) then
     DrawMarker(25, 98.025, 6619.415, 32.435-0.95, 0, 0, 0, 0, 0, 0, 0.65,0.65,0.5, 255, 255, 255, 200, 0, true, 2, 0, 0, 0, 0)
     if(GetDistanceBetweenCoords(coords, 98.025, 6619.415, 32.435, true) < 1.2) then
      API_DrawTxt('~g~[E]~w~ Part Storage')
      if IsControlJustPressed(0, 38) then
       WarMenu.OpenMenu('stocklisting', "Parts")
       TriggerServerEvent('fastfood:getstock', 3)
       --TriggerServerEvent('fastfood:getstock', v.id)
      end
     end
    end
   end
  
   if not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
   if(GetDistanceBetweenCoords(coords, 111.894, 6627.381, 31.787, true) < 15.0) and DecorGetInt(GetPlayerPed(-1), "Job") == 3 then
    DrawMarker(25, 111.894, 6627.381, 31.787-0.99, 0, 0, 0, 0, 0, 0, 0.55,0.55,0.5, 255, 15, 15, 200, 0, true, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(coords, 111.894, 6627.381, 31.787, true) < 1.2) then
     API_DrawTxt('~g~[E]~w~ Repair Vehicle')
     if IsControlJustPressed(0, 38) then
      local coords = GetEntityCoords(GetPlayerPed(-1))
      if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
       local vehicle = nil
       if IsPedInAnyVehicle(playerPed, false) then
        vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
       else
       vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
       end

       if DoesEntityExist(vehicle) then
        ProgressBar('Inspecting Final Repairs', 55)
        TaskStartScenarioInPlace(GetPlayerPed(-1), "CODE_HUMAN_MEDIC_TIME_OF_DEATH", 0, true)
        Citizen.Wait(5000)
        ClearPedTasks(GetPlayerPed(-1))
        TriggerEvent('vehice:repair', false, vehicle)
       end
      end
     end
    end
   end
  end

  if onCollection == 1 then
   if(GetDistanceBetweenCoords(coords, 346.336, 3406.535, 36.516, true) < 15.0) and DecorGetInt(GetPlayerPed(-1), "Job") == 3 then
   nearPoint = true
    DrawMarker(25, 346.336, 3406.535, 36.516-0.99, 0, 0, 0, 0, 0, 0, 0.95,0.95,0.5, 255, 15, 15, 200, 0, true, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(coords, 346.336, 3406.535, 36.516, true) < 1.2) then
     API_DrawTxt('~g~[E]~w~ Collect Car Parts')
     if IsControlJustPressed(0, 38) then
      RemoveJobBlip()
      onCollection = 2
      exports['NRP-notify']:DoHudText('inform', "Return Car Parts to Garage")
      SetJobBlip(113.557, 6607.130, 31.899)
     end
    end
   else
    nearPoint = false
   end
  end

  if onCollectionHigher == 1 then
   if(GetDistanceBetweenCoords(coords, 154.926, -1672.450, 29.684, true) < 15.0) and DecorGetInt(GetPlayerPed(-1), "Job") == 3 then
    nearPoint = true
    DrawMarker(25, 154.926, -1672.450, 29.684-0.99, 0, 0, 0, 0, 0, 0, 0.95,0.95,0.5, 255, 15, 15, 200, 0, true, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(coords, 154.926, -1672.450, 29.684, true) < 1.2) then
     API_DrawTxt('~g~[E]~w~ Collect Car Parts')
     if IsControlJustPressed(0, 38) then
      RemoveJobBlip()
      onCollectionHigher = 2
      exports['NRP-notify']:DoHudText('inform', "Return Car Parts to Garage")
      SetJobBlip(113.557, 6607.130, 31.899)
     end
    end
   else
    nearPoint = false
   end
  end

  if IsPedInAnyVehicle(GetPlayerPed(-1), false) and onCollectionHigher == 2 or onCollection == 2 then
   if(GetDistanceBetweenCoords(coords, 113.557, 6607.130, 31.899, true) < 15.0) and DecorGetInt(GetPlayerPed(-1), "Job") == 3 then
    nearPoint = true
    DrawMarker(25, 113.557, 6607.130, 31.899-0.99, 0, 0, 0, 0, 0, 0, 0.95,0.95,0.5, 255, 15, 15, 200, 0, true, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(coords, 113.557, 6607.130, 31.899, true) < 1.2) then
     API_DrawTxt('~g~[E]~w~ Drop-Off Car Parts')
     if IsControlJustPressed(0, 38) then
      RemoveJobBlip()
      exports['NRP-notify']:DoHudText('inform', "The car parts have been dropped off into the garage!")

      local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1))
      SetEntityAsMissionEntity(vehicle, true, true)
      Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))

      if onCollection == 2 then
       TriggerServerEvent('fastfood:addstock', 3, 96, math.random(5,11))
       TriggerServerEvent('fastfood:addstock', 3, 97, math.random(5,11))
       TriggerServerEvent('fastfood:addstock', 3, 98, math.random(5,11))
       TriggerServerEvent('fastfood:addstock', 3, 54, math.random(5,11))
       TriggerServerEvent('fastfood:addstock', 3, 53, math.random(5,11))
       TriggerServerEvent('fastfood:addstock', 3, 52, math.random(2,8))
       TriggerServerEvent('fastfood:addstock', 3, 99, math.random(5,11))
       TriggerServerEvent('fastfood:addstock', 3, 100, math.random(5,11))
       TriggerServerEvent('fastfood:addstock', 3, 101, math.random(5,11))
       onCollection = 0
       onCollectionHigher = 0
      elseif onCollectionHigher == 2 then
       TriggerServerEvent('fastfood:addstock', 3, 96, math.random(8,18))
       TriggerServerEvent('fastfood:addstock', 3, 97, math.random(8,18))
       TriggerServerEvent('fastfood:addstock', 3, 98, math.random(8,18))
       TriggerServerEvent('fastfood:addstock', 3, 54, math.random(8,18))
       TriggerServerEvent('fastfood:addstock', 3, 53, math.random(8,18))
       TriggerServerEvent('fastfood:addstock', 3, 52, math.random(8,12))
       TriggerServerEvent('fastfood:addstock', 3, 99, math.random(8,18))
       TriggerServerEvent('fastfood:addstock', 3, 100, math.random(8,18))
       TriggerServerEvent('fastfood:addstock', 3, 101, math.random(8,18))
       onCollection = 0
       onCollectionHigher = 0
      end
      onCollection = 0
      onCollectionHigher = 0
      TriggerServerEvent('fastfood:getstock', 3)
     end
    end
   else
    nearPoint = false
   end
  end

  if WarMenu.IsMenuOpened('buy_stocklisting') then
   if WarMenu.Button('Stock Delivery #1', '~g~$1,000') then
    SpawnJobTruck("utillitruck3", 113.557, 6607.130, 31.899)
    onCollection = 1
    SetJobBlip(346.336, 3406.535, 36.516)
    WarMenu.CloseMenu()
    TriggerServerEvent('mechanic:charge', 1000)
   elseif WarMenu.Button('Stock Delivery #2', '~g~$2,000') then
    SpawnJobTruck("utillitruck3", 113.557, 6607.130, 31.899)
    onCollectionHigher = 1
    SetJobBlip(154.926, -1672.450, 29.684)
    WarMenu.CloseMenu()
    TriggerServerEvent('mechanic:charge', 2000)
   end
  WarMenu.Display()

  --[[if WarMenu.IsMenuOpened('stocklisting') then
    for ind,v in pairs(currentStock) do
     if v.amount > 0 then
      if WarMenu.Button(v.stockname.." ["..v.amount.."]", "~g~$"..v.price) then
       local item = v.itemid
       TriggerServerEvent('fastfood:removestock', 3, item, 1, 0)-
       TriggerServerEvent('shops:purchase', v.stockname, 0, 1, item)
       TriggerServerEvent('fastfood:getstock', 3)
      end
     elseif v.amount <= 0 then
      if WarMenu.Button(v.stockname, "~r~No Stock") then
      exports['NRP-notify']:DoHudText('inform', "You need to collect more "..v.stockname})
      end
     end
    end
    WarMenu.Display()
   end
  
   if onCollection == 1 or onCollectionHigher == 1 and not nearPoint then
   API_DrawTxt('~m~Drive to collect the ~g~Vehicle Part Delivery')
  elseif onCollection == 1 or onCollectionHigher == 1 and not nearPoint then
   API_DrawTxt('~m~Return the ~g~Vehicle Part Delivery')
  end
  end
 end
end)
]]--
local currentlyTowedVehicle = nil
local mission_list = {}
local currentGarageMenu = {}

-- Draw Markers TriggerEvent('vehice:repair', false)
Citizen.CreateThread(function()
 while true do
  Wait(0)
  local coords = GetEntityCoords(GetPlayerPed(-1))
  if DecorGetInt(GetPlayerPed(-1), "Job") == 15 and IsControlPressed(0, 167) then
   WarMenu.OpenMenu('dealer')
  end
  -- Mechanics Only 
  if DecorGetInt(GetPlayerPed(-1), "Job") == 3 then
    if IsControlPressed(0, 167) then
    WarMenu.OpenMenu('mechanic')
    end
  end
  WarMenu.Display()
 end
end)

Citizen.CreateThread(function()
 WarMenu.CreateLongMenu('mechanic','Mechanic')
 local currentOption = 1
 local selectedOption = 1
 while true do 
  Wait(0)  
  if WarMenu.IsMenuOpened('mechanic') then
   if WarMenu.Button('Missions') then 
    WarMenu.OpenMenu('mechanic_missions')
   elseif WarMenu.Button('Unlock Vehicle') then
    local coords = GetEntityCoords(GetPlayerPed(-1))
    if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
     local vehicle = nil
     if IsPedInAnyVehicle(playerPed, false) then
      vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
     else
      vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
     end
     if DoesEntityExist(vehicle) then
      TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_WELDING", 0, true)
      Citizen.CreateThread(function()
       Citizen.Wait(10000)
       SetVehicleDoorsLocked(vehicle, 1)
       SetVehicleDoorsLockedForAllPlayers(vehicle, false)
       ClearPedTasksImmediately(GetPlayerPed(-1))
       exports['NRP-notify']:DoHudText('success', 'Vehicle Unlocked')
      end)
     end
    end 
   elseif WarMenu.Button('Clean Vehicle') then
    local ped = GetPlayerPed(-1)
    local coords = GetEntityCoords(ped)
    if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
     local vehicle = nil
     if IsPedInAnyVehicle(ped, false) then
      vehicle = GetVehiclePedIsIn(ped, false)
     else
      vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
     end     
     if DoesEntityExist(vehicle) then
      TaskStartScenarioInPlace(ped, "WORLD_HUMAN_MAID_CLEAN", 0, true)
      Citizen.CreateThread(function()
       Citizen.Wait(8000)
       SetVehicleDirtLevel(vehicle, 0.0)
       ClearPedTasksImmediately(ped)
       exports['NRP-notify']:DoHudText('success', 'Vehicle Cleaned')
      end)
     end
    end     
   elseif WarMenu.Button('Impound Vehicle') then
    if IsPedInAnyVehicle(GetPlayerPed(-1)) then
      ExecuteCommand("tow")
    end
   elseif WarMenu.Button('Toggle Vehicle On Flatbed') then
    TriggerEvent("mechanic:tow")
   elseif WarMenu.Button('Plate Check') then
    TriggerEvent("mdt:runMdcOnForwardEntity") 
   end   
   end
end
   WarMenu.Display()
end)    


Citizen.CreateThread(function()
 WarMenu.CreateLongMenu('dealer','Car Dealer')
 while true do 
  Wait(0)  
  if WarMenu.IsMenuOpened('dealer') then
   if WarMenu.Button('Clean Vehicle') then
    local coords = GetEntityCoords(GetPlayerPed(-1))
    if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
     local vehicle = nil
     if IsPedInAnyVehicle(playerPed, false) then
      vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
     else
      vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
     end
     
     if DoesEntityExist(vehicle) then
      TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_MAID_CLEAN", 0, true)
      Citizen.CreateThread(function()
       Citizen.Wait(8000)
       SetVehicleDirtLevel(vehicle, 0)
       ClearPedTasksImmediately(GetPlayerPed(-1))
       exports['NRP-notify']:DoHudText('success', 'Vehicle Cleaned')
      end)
     end
    end     
   elseif WarMenu.Button('Plate Check') then
    TriggerEvent("mdt:runMdcOnForwardEntity")
   end
   WarMenu.Display()
  end 
 end
end)

Citizen.CreateThread(function()
 WarMenu.CreateLongMenu('mechanic_missions', 'Missions')
 while true do 
  Wait(0)
  if DecorGetInt(GetPlayerPed(-1), "Job") == 3 then
   if not IsPedInAnyVehicle(GetPlayerPed(-1)) then drawUI(0.514, 1.375, 1.0, 1.0, 0.45, MissionInformation, 89, 194, 255, 255, false) else drawUI(0.514, 1.275, 1.0, 1.0, 0.45, MissionInformation, 89, 194, 255, 255, false) end
   if WarMenu.IsMenuOpened('mechanic_missions') then
    for i,v in pairs(mission_list) do
     if v.name ~= "Finish the mission" then
      if WarMenu.Button(v.name) then
       v.f(v.mission)
       exports['NRP-notify']:DoHudText('success', 'Call Information: '..v.info)
      end
     else
      if WarMenu.Button(v.name) then
       v.f()
      end
     end 
    end
       end
  end
 end
    WarMenu.Display()
end)

RegisterNetEvent('mechanic:onFixkit')
AddEventHandler('mechanic:onFixkit', function()
  local playerPed = GetPlayerPed(-1)
  local coords    = GetEntityCoords(playerPed)
  if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
    local vehicle = nil
    if IsPedInAnyVehicle(playerPed, false) then
      vehicle = GetVehiclePedIsIn(playerPed, false)
    else
      vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
    end
    if DoesEntityExist(vehicle) then
      TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
      Citizen.CreateThread(function()
        Citizen.Wait(20000)
        SetVehicleFixed(vehicle)
        SetVehicleDeformationFixed(vehicle)
        SetVehicleUndriveable(vehicle, false)
        ClearPedTasksImmediately(playerPed)
        exports['NRP-notify']:DoHudText('success', 'Vehicle Repaired')
      end)
    end
  end
end)

function drawTxt(text)
	SetTextFont(4)
	SetTextProportional(0)
	SetTextScale(0.7, 0.8)
	SetTextCentre(1)
	SetTextColour(255, 255, 255, 255)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(0.5 , 0.93)	
end
local allowedTowModels = { 
    ['flatbed'] = {x = 0.0, y = -0.85, z = 1.25}, -- default GTA V flatbed
    ['flatbed2'] = {x = 0.0, y = 0.0, z = 0.68}, -- addon flatbed2
    ['flatbed3'] = {x = 0.0, y = -1.2, z = 1.30}, -- addon flatbed3
}
local allowTowingBoats = true -- Set to true if you want to be able to tow boats.
local allowTowingPlanes = true -- Set to true if you want to be able to tow planes.
local allowTowingHelicopters = true -- Set to true if you want to be able to tow helicopters.
local allowTowingTrains = false -- Set to true if you want to be able to tow trains.
local allowTowingTrailers = true -- Disables trailers. NOTE: THIS ALSO DISABLES THE AIRTUG, TOWTRUCK, SADLER, AND ANY OTHER VEHICLE THAT IS IN THE UTILITY CLASS.
local currentlyTowedVehicle = nil
function isTargetVehicleATrailer(modelHash)
    if GetVehicleClassFromName(modelHash) == 11 then
        return true
    else
        return false
    end
end
local xoff = 0.0
local yoff = 0.0
local zoff = 0.0
function isVehicleATowTruck(vehicle)
    local isValid = false
    for model,posOffset in pairs(allowedTowModels) do
        if IsVehicleModel(vehicle, model) then
            xoff = posOffset.x
            yoff = posOffset.y
            zoff = posOffset.z
            isValid = true
            break
        end
    end
    return isValid
end

RegisterNetEvent('mechanic:tow')
AddEventHandler('mechanic:tow', function()
  local playerped = PlayerPedId()
  local vehicle = GetVehiclePedIsIn(playerped, true)
  local isVehicleTow = isVehicleATowTruck(vehicle)
  if isVehicleTow then
    local coordA = GetEntityCoords(playerped, 1)
    local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 5.0, 0.0)
    local targetVehicle = getVehicleInDirection(coordA, coordB)
    if currentlyTowedVehicle == nil then
      if targetVehicle ~= 0 then
        if not IsPedInAnyVehicle(playerped, true) then
          if vehicle ~= targetVehicle then
            AttachEntityToEntity(targetVehicle, vehicle, 20, -0.5, -5.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
            currentlyTowedVehicle = targetVehicle
            exports['NRP-notify']:DoHudText('success', 'Vehicle Succsefully Attatched')
          else
            exports['NRP-notify']:DoHudText('error', 'No Vehicle Attatched')
          end
        end
      else
        exports['NRP-notify']:DoHudText('error', 'No Vehicle Attatched')
    end
   else
      AttachEntityToEntity(currentlyTowedVehicle, vehicle, 20, -0.5, -12.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
      DetachEntity(currentlyTowedVehicle, true, true)
      currentlyTowedVehicle = nil
      exports['NRP-notify']:DoHudText('error', 'Vehicle Succsefully Detatched')
    end
  end
end)

function getVehicleInDirection(coordFrom, coordTo)
	local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, PlayerPedId(), 0)
	local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
	return vehicle
end

function drawUI(x,y ,width,height,scale, text, r,g,b,a, center)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextCentre(center)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function SpawnJobVehicle(model, x,y,z)
 local vehiclehash = GetHashKey(model)
 RequestModel(vehiclehash)
 while not HasModelLoaded(vehiclehash) do
  Wait(0)
 end
 vehicle = CreateVehicle(vehiclehash, x,y,z, 115, true, false)
 local id = NetworkGetNetworkIdFromEntity(vehicle)
 SetNetworkIdCanMigrate(id, true)
 SetNetworkIdExistsOnAllMachines(id, true)
 SetVehicleDirtLevel(vehicle, 0)
 TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
 SetVehicleHasBeenOwnedByPlayer(vehicle, true)
 SetEntityAsMissionEntity(vehicle, true, true)
 SetVehicleEngineOn(vehicle, true)
 DecorRegister("_Fuel_Level", 3);
 DecorRegister("_Max_Fuel_Level", 3);
 DecorSetInt(vehicle, "_Max_Fuel_Level", 100000)
 DecorSetInt(vehicle, "_Fuel_Level", 50000)
 exports["onyxLocksystem"]:givePlayerKeys(GetVehicleNumberPlateText(vehicle))
end

----------------------------------------------------------------------------------------------------------
---------------------------- New Mission System ----------------------------------------------------------
----------------------------------------------------------------------------------------------------------
local currentMissionBlip = nil 
local availableMissions = {}
local currentMissions = nil
local MissionInformation = '~g~NO CALLS WAITING'
local mechanicCallStatus = 0
local activemechanics = 0
local availablemechanics = 0


local nearObject = false 
local isNearObject = false
local objectLoc = {}
local clostestProp = nil
local label = "eCola"
local models = {[1] = 992069095,}

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(1500)
  nearObject = false
  isNearObject = false
  local myCoords = GetEntityCoords(GetPlayerPed(-1))
  for i = 1, #models do
   clostestProp = GetClosestObjectOfType(myCoords.x, myCoords.y, myCoords.z, 2.5, models[i], false, false)
   if clostestProp ~= nil and clostestProp ~= 0 then
    local coords = GetEntityCoords(clostestProp)
    isNearObject = true
    objectLoc = {['x'] = coords.x, ['y'] = coords.y, ['z'] = coords.z + 1.2}
    break
   end
  end
 end
end)

Citizen.CreateThread(function()
 while true do
  Wait(0)
  if isNearObject then 
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), objectLoc.x, objectLoc.y, objectLoc.z-0.5, true) < 1.3) then
    DrawText3Ds(objectLoc.x, objectLoc.y, objectLoc.z,'~g~[E]~w~ Buy eCola ~g~$5') 
	if IsControlJustPressed(0, 38) then
		TaskStartScenarioInPlace(GetPlayerPed(-1), 'PROP_HUMAN_ATM', false, true) Wait(3000) ClearPedTasksImmediately(GetPlayerPed(-1))
        TriggerServerEvent('shops:purchase', label, 5, 1, 258)
    end
   end ---- add shared banking to vending machines then somecan buy them
   end
 end
end)

RegisterNetEvent("mechanic:notifyallmechanics")
AddEventHandler("mechanic:notifyallmechanics",function(message)
  if DecorGetInt(GetPlayerPed(-1), "Job") == 3 then
    PlaySoundFrontend(-1, "HACKING_SUCCESS", 0, 1);
    TriggerEvent("pNotify:SendNotification", {text= message, timeout = 15000})
    Wait(750)
    PlaySoundFrontend(-1, "HACKING_SUCCESS", 0, 1);
  end
end)

RegisterNetEvent("mechanic:notifyClient")
AddEventHandler("mechanic:notifyClient",function(message)
  TriggerEvent("pNotify:SendNotification", {text= message})
end)

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

function acceptMissionmechanic(data) 
    TriggerServerEvent('mechanic:acceptMission', data.id)
end

function finishCurrentMissionmechanic()
    if currentMissions ~= nil then
        TriggerServerEvent('mechanic:finishMission', currentMissions.id)
    end
    currentMissions = nil
    if currentMissionBlip ~= nil then
        RemoveBlip(currentMissionBlip)
    end
  WarMenu.OpenMenu('mechanic_missions')
end

function updateMissionMenu() 
    local cmissions = {}
    for k,v in pairs(availableMissions) do
        Citizen.Trace('==>' .. k )
    end
    for _,m in pairs(availableMissions) do 
        local data = {
            name = '' .. m.name,
            mission = m,
            info = m.type,
            f = acceptMissionmechanic
        }
        if #m.acceptBy ~= 0 then
            data.name = data.name .. ' (' .. #m.acceptBy ..' Unit)'
        end
        table.insert(cmissions, data)
    end

    if currentMissions ~= nil then
        table.insert(cmissions, {name = 'Finish the mission', f = finishCurrentMissionmechanic})
    end
    mission_list = cmissions
    if curMenu ~= nil then
        if curMenu == "missions_menu" then
            WarMenu.OpenMenu('mechanic_missions')
        end
    end
end

function callmechanic(type)
    local callerPos = GetEntityCoords(GetPlayerPed(-1))
    TriggerServerEvent('mechanic:Call', callerPos.x, callerPos.y, callerPos.z, type)
end

RegisterNetEvent('mechanic:acceptMission')
AddEventHandler('mechanic:acceptMission',function(mission)
    currentMissions = mission
    SetNewWaypoint(mission.pos[1], mission.pos[2])
    currentMissionBlip = AddBlipForCoord(mission.pos[1], mission.pos[2], mission.pos[3])
    SetBlipSprite(currentMissionBlip, 58)
    SetBlipColour(currentMissionBlip, 5)
    SetBlipAsShortRange(currentMissionBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Mission in progress')
    EndTextCommandSetBlipName(currentMissionBlip)
    SetBlipAsMissionCreatorBlip(currentMissionBlip, true)
end)

RegisterNetEvent('mechanic:cancelMission')
AddEventHandler('mechanic:cancelMission', function ()
    currentMissions = nil
    if currentMissionBlip ~= nil then
        RemoveBlip(currentMissionBlip)
    end
    if curMenu ~= nil then
        if curMenu == "missions_menu" then
          WarMenu.OpenMenu('mechanic_missions')
        end
    end
end)

RegisterNetEvent('mechanic:changeMission')
AddEventHandler('mechanic:changeMission', function (missions)
    availableMissions = missions
    local MissionsOnHold = 0
    for _,m in pairs(availableMissions) do
        if #m.acceptBy == 0 then
            MissionsOnHold = MissionsOnHold + 1
        end
    end
    if MissionsOnHold == 0 then 
        MissionInformation = '~g~No Call Waiting'
    else
        MissionInformation = '~g~'..MissionsOnHold..' ~w~Call waiting'
    end  
    updateMissionMenu()
end)

RegisterNetEvent('mechanic:callmechanic')
AddEventHandler('mechanic:callmechanic',function(data)
    callmechanic(data.type)
end)

RegisterNetEvent('mechanic:callmechanicCustom')
AddEventHandler('mechanic:callmechanicCustom',function()
    local reason = openTextInput()
    if reason ~= nil and reason ~= '' then
        callmechanic(reason)
    end
end)

function openTextInput()
    DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 200)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        return GetOnscreenKeyboardResult()
    end
    return nil
end

RegisterNetEvent('mechanic:callStatus')
AddEventHandler('mechanic:callStatus',function(status)
    mechanicCallStatus = status
end)

RegisterNetEvent('mechanic:updateactivemechanics')
AddEventHandler('mechanic:updateactivemechanics',function(activeCount, availableCount)
    activemechanics = activeCount
    availablemechanics = availableCount
end)

RegisterNetEvent('mechanic:cancelCall')
AddEventHandler('mechanic:cancelCall',function(data)
    TriggerServerEvent('mechanic:cancelCall')
end)


TriggerServerEvent('mechanic:getactivemechanics') -- Initilized on startup


RegisterNetEvent('mechanic:callmechanicCustom')
AddEventHandler('mechanic:callmechanicCustom',function()
    local reason = openTextInput()
    if reason ~= nil and reason ~= '' then
        callmechanic(reason)
    end
end)
function openTextInput()
    DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 200)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        return GetOnscreenKeyboardResult()
    end
    return nil
end
 
Citizen.CreateThread(function()
    while true do
        Wait(0)
        if DecorGetInt(GetPlayerPed(-1), "Job") == 3 then
            if currentMissions == nil then
                if currentMissionBlip ~= nil then
                    RemoveBlip(currentMissionBlip)
                end
            end
        end
    end
end)

--========================================================================================--
--================================== Progress Bar ========================================--
--========================================================================================--
-- Default Progress Duration = 20, During Trigging Progress Bar, Wait 3750 Then Trigger The Event
local progress_time = 0.20
local progress_bar = false
local progress_bar_duration = 20
local progress_bar_text = ''


function ProgressBar(text, time)
 progress_bar_text = text
 progress_bar_duration = time
 progress_time = 0.20
 progress_bar = true
end

RegisterNetEvent('hud:progressbar')
AddEventHandler('hud:progressbar', function(text, time)
 ProgressBar(text, time)
end)

RegisterNetEvent('vehice:repair')
AddEventHandler('vehice:repair', function(mechanic, veh)
	SetVehicleUndriveable(veh,false)
	SetVehicleFixed(veh)
	SetVehicleEngineOn(veh, true, false )
    exports['NRP-notify']:DoHudText('success', 'Vehicle Repaired')
end)

function SpawnJobTruck(model, x,y,z)
    if DoesEntityExist(vehicle) then DeleteVehicle(vehicle) end
    local vehiclehash = GetHashKey(model)
    RequestModel(vehiclehash)
    while not HasModelLoaded(vehiclehash) do
     Wait(0)
    end
    vehicle = CreateVehicle(vehiclehash, x,y,z, 122.814, true, false)
    SetVehicleDirtLevel(vehicle, 0)
    TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
    SetVehicleHasBeenOwnedByPlayer(vehicle, true)
    SetEntityAsMissionEntity(vehicle, true, true)
    SetVehicleMod(vehicle,16, 20)
    SetVehicleEngineOn(vehicle, true)
    SetVehicleLivery(vehicle, vehlivery)
    DecorSetInt(vehicle, "_Fuel_Level", 75000)
    exports["onyxLocksystem"]:givePlayerKeys(GetVehicleNumberPlateText(vehicle))
end

function SetJobBlip(x,y,z)
    if DoesBlipExist(missionblip) then RemoveBlip(missionblip) end
    missionblip = AddBlipForCoord(x,y,z)
    SetBlipSprite(missionblip, 164)
    SetBlipColour(missionblip, 53)
    SetBlipRoute(missionblip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Destination")
    EndTextCommandSetBlipName(missionblip)
end
   
function RemoveJobBlip()
    if DoesBlipExist(missionblip) then RemoveBlip(missionblip) end
end

Citizen.CreateThread(function()
  while true do
   Citizen.Wait(progress_bar_duration)
   if(progress_time > 0)then
    progress_time = progress_time - 0.002
   end
  end
end)
 
Citizen.CreateThread(function()
  while true do
   Wait(0)
   if progress_bar then 
    DrawRect(0.50, 0.90, 0.20, 0.05, 0, 0, 0, 100)
    drawUI(0.910, 1.375, 1.0, 1.0, 0.55, progress_bar_text,135, 135, 135, 255, false)
    if progress_time > 0 then
     DrawRect(0.50, 0.90, 0.20-progress_time, 0.05, 255, 255, 0, 225)
    elseif progress_time < 1 and progress_bar then 
     progress_bar = false
    end
   end
  end
end)
 

Citizen.CreateThread(function()
 while true do
  Wait(0)
  local coords = GetEntityCoords(GetPlayerPed(-1))
 if DecorGetInt(GetPlayerPed(-1), "Job") == 3 or DecorGetInt(GetPlayerPed(-1), "Job") == 39 and IsPedInAnyVehicle(GetPlayerPed(-1), false) then
  if(GetDistanceBetweenCoords(coords, 402.909, -1632.407, 29.292, true) < 10.0) then
   DrawMarker(27, 402.909, -1632.407, 29.292-0.98, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 255, 255, 0, 100, 0, 0, 2, 0, 0, 0, 0)
   if(GetDistanceBetweenCoords(coords, 402.909, -1632.407, 29.292, true) < 1.5) then
    API_DrawTxt('~m~Press ~g~E ~m~To Impound [MUST BE IN CAR]')
    if IsControlJustPressed(0, 38) and IsPedInAnyVehicle(GetPlayerPed(-1), false) then
          local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
     SetEntityAsMissionEntity(veh,  false,  true)
     DeleteVehicle(veh)
     Wait(3000)
     exports['NRP-notify']:DoHudText('success', 'Car Impounded!!')
    end
   end
  end
 end
 end
end)

 --------------- mechanic
 Citizen.CreateThread(function()
  while true do
    Wait(0) --- TJ MECH NEW
    if DecorGetInt(GetPlayerPed(-1), "Faction") == 20 then
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 726.35,-1066.5,28.31, true) < 10.0) then
        DrawMarker(27, 726.35,-1066.5,28.31-0.95, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 255, 255, 0, 180, 0, 0, 2, 0, 0, 0, 0)
        if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 726.35,-1066.5,28.31, true) < 1.5) then
          DrawText3Ds(726.35,-1066.5,28.31,'~g~[E]~w~ Sign On/Off Duty')
          if IsControlJustPressed(0, 38) and DecorGetInt(GetPlayerPed(-1), "Job") ~= 3 then
            TriggerServerEvent('xz-mech:onduty')
          elseif IsControlJustPressed(0, 38) and DecorGetInt(GetPlayerPed(-1), "Job") == 3 then
            TriggerServerEvent('xz-mech:offduty')
          end
        end
      end
    end --- mav new
    if DecorGetInt(GetPlayerPed(-1), "Faction") == 20 then
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -344.345, -123.595, 39.010, true) < 10.0) then
        DrawMarker(27, -344.345, -123.595, 39.010-0.95, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 255, 255, 0, 180, 0, 0, 2, 0, 0, 0, 0)
        if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -344.345, -123.595, 39.010, true) < 1.5) then
          DrawText3Ds(-344.345, -123.595, 39.010,'~g~[E]~w~ Sign On/Off Duty')
          if IsControlJustPressed(0, 38) and DecorGetInt(GetPlayerPed(-1), "Job") ~= 3 then
            TriggerServerEvent('xz-mech:onduty')
          elseif IsControlJustPressed(0, 38) and DecorGetInt(GetPlayerPed(-1), "Job") == 3 then
            TriggerServerEvent('xz-mech:offduty')
          end
        end
      end
    end
    if DecorGetInt(GetPlayerPed(-1), "Faction") == 20 then
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -207.84,-1340.6,34.9, true) < 10.0) then
        DrawMarker(27, -207.84,-1340.6,34.9-0.95, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 255, 255, 0, 180, 0, 0, 2, 0, 0, 0, 0)
        if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -207.84,-1340.6,34.9, true) < 1.5) then
          DrawText3Ds(-207.84,-1340.6,34.9,'~g~[E]~w~ Sign On/Off Duty')
          if IsControlJustPressed(0, 38) and DecorGetInt(GetPlayerPed(-1), "Job") ~= 3 then
            TriggerServerEvent('xz-mech:onduty')
          elseif IsControlJustPressed(0, 38) and DecorGetInt(GetPlayerPed(-1), "Job") == 3 then
            TriggerServerEvent('xz-mech:offduty')
          end
        end
      end
    end
    if DecorGetInt(GetPlayerPed(-1), "Faction") == 20 then
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 261.42,-1809.47,26.9, true) < 10.0) then
        DrawMarker(27, 261.42,-1809.47,26.9-0.95, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 255, 255, 0, 180, 0, 0, 2, 0, 0, 0, 0)
        if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 261.42,-1809.47,26.9, true) < 1.5) then
          DrawText3Ds(261.42,-1809.47,26.9,'~g~[E]~w~ Sign On/Off Duty')
          if IsControlJustPressed(0, 38) and DecorGetInt(GetPlayerPed(-1), "Job") ~= 3 then
            TriggerServerEvent('xz-mech:onduty')
          elseif IsControlJustPressed(0, 38) and DecorGetInt(GetPlayerPed(-1), "Job") == 3 then
            TriggerServerEvent('xz-mech:offduty')
          end
        end
      end
    end
  end
end)

RegisterCommand('repair', function(source, args, rawCommand)
    if DecorGetInt(GetPlayerPed(-1), "Job") == 3 then	
      local ped = GetPlayerPed(-1)
      local coords = GetEntityCoords(ped)
      if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
        local vehicle = nil
        if IsPedInAnyVehicle(ped, false) then
          vehicle = GetVehiclePedIsIn(ped, false)
        else
          vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
        end
        if DoesEntityExist(vehicle) then
          if GetVehicleEngineHealth(vehicle) > 950.0 then
               TriggerEvent("NRP-Mech:Service")
               exports['NRP-notify']:DoHudText('inform', 'Servicing Vehicle and Repairing Body Damage')
          elseif GetVehicleEngineHealth(vehicle) > 900.0 then
               TriggerEvent("NRP-Mech:SparkPlug")
               exports['NRP-notify']:DoHudText('inform', 'Fitting New Spark Plugs')
          elseif	GetVehicleEngineHealth(vehicle) > 800.0 then
               TriggerEvent("NRP-Mech:AirFilter")
               exports['NRP-notify']:DoHudText('inform', 'Fitting New Air Filter')
          elseif	GetVehicleEngineHealth(vehicle) > 700.0 then
               TriggerEvent("NRP-Mech:SparkPlug")
               exports['NRP-notify']:DoHudText('inform', 'Fitting New Radiator')
          elseif	GetVehicleEngineHealth(vehicle) > 600.0 then
               TriggerEvent("NRP-Mech:Exhuast")
               exports['NRP-notify']:DoHudText('inform', 'Fitting New Exhuast')
          elseif	GetVehicleEngineHealth(vehicle) > 500.0 then
               TriggerEvent("NRP-Mech:CConverter")
               exports['NRP-notify']:DoHudText('inform', 'Fitting New Catayltic Converter')
          elseif	GetVehicleEngineHealth(vehicle) > 400.0 then
               TriggerEvent("NRP-Mech:Clutch")
               exports['NRP-notify']:DoHudText('inform', 'Fitting New Clutch')
          elseif	GetVehicleEngineHealth(vehicle) > 300.0 then
               TriggerEvent('NRP-Mech:Gearbox')
               exports['NRP-notify']:DoHudText('inform', 'Fitting New Gearbox')
          elseif	GetVehicleEngineHealth(vehicle) < 300.0 then
               TriggerEvent('NRP-Mech:Engine')
               exports['NRP-notify']:DoHudText('inform', 'Fitting New Engine ')
          end
        end		
      end
    else
      exports['NRP-notify']:DoHudText('error', 'You Need To Be a Mechanic To Use This Command')
    end	
end)
  
RegisterNetEvent('NRP-Mech:Clutch')
AddEventHandler('NRP-Mech:Clutch', function()
      local ped = GetPlayerPed(-1)
      local coords = GetEntityCoords(ped)
      if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
        local vehicle = nil
        if IsPedInAnyVehicle(ped, false) then
          vehicle = GetVehiclePedIsIn(ped, false)
        else
          vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
        end
        if DoesEntityExist(vehicle) then
          TaskStartScenarioInPlace(ped, "PROP_HUMAN_BUM_BIN", 0, true)
          Citizen.CreateThread(function()
            Citizen.Wait(20000)
            SetVehicleEngineHealth(vehicle, 501.0)
            SetVehicleUndriveable(vehicle, false) 
            ClearPedTasksImmediately(ped)
            exports['NRP-notify']:DoHudText('success', 'New Clutch Fitted') 
          end)
        end
      end
end)
      
RegisterNetEvent('NRP-Mech:Exhuast')
AddEventHandler('NRP-Mech:Exhuast', function()
     local ped = GetPlayerPed(-1)
    local coords = GetEntityCoords(ped)
    if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
      local vehicle = nil
      if IsPedInAnyVehicle(ped, false) then
        vehicle = GetVehiclePedIsIn(ped, false)
      else
        vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
      end
      if DoesEntityExist(vehicle) then
          TaskStartScenarioInPlace(ped, "PROP_HUMAN_BUM_BIN", 0, true)
           exports['mythic_progbar']:Progress({
             name = "exh_aust",
             duration = 20000,
             label = "Fitting New Exhaust",
             useWhileDead = false,
             canCancel = true,
             controlDisables = {
                 disableMovement = true,
                 disableCarMovement = true,
                 disableMouse = false,
                 disableCombat = true,
             },
         }, function(status)
               if not status then
                 SetVehicleEngineHealth(vehicle, 701.0)
                 SetVehicleUndriveable(vehicle, false)
                 ClearPedTasksImmediately(ped)
                 --exports['NRP-notify']:DoHudText('success', 'Fitting New Gearbox') 
                end
           end)
        end
      end
end)
  
RegisterNetEvent('NRP-Mech:Radiator')
AddEventHandler('NRP-Mech:Radiator', function()
      local ped = GetPlayerPed(-1)
      local coords = GetEntityCoords(ped)
      if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
        local vehicle = nil
        if IsPedInAnyVehicle(ped, false) then
          vehicle = GetVehiclePedIsIn(ped, false)
        else
          vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
        end
        if DoesEntityExist(vehicle) then
          TaskStartScenarioInPlace(ped, "PROP_HUMAN_BUM_BIN", 0, true)
           exports['mythic_progbar']:Progress({
             name = "rad_iator",
             duration = 20000,
             label = "Fitting New Radiator",
             useWhileDead = false,
             canCancel = true,
             controlDisables = {
                 disableMovement = true,
                 disableCarMovement = true,
                 disableMouse = false,
                 disableCombat = true,
             },
         }, function(status)
               if not status then
                 SetVehicleEngineHealth(vehicle, 801.0)
                 SetVehicleUndriveable(vehicle, false)
                 ClearPedTasksImmediately(ped)
                 --exports['NRP-notify']:DoHudText('success', 'Fitting New Gearbox') 
                end
           end)
        end
      end
end)
  
RegisterNetEvent('NRP-Mech:Engine')
AddEventHandler('NRP-Mech:Engine', function()
     local ped = GetPlayerPed(-1)
    local coords = GetEntityCoords(ped)
    if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
      local vehicle = nil
      if IsPedInAnyVehicle(ped, false) then
        vehicle = GetVehiclePedIsIn(ped, false)
      else
        vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
      end
      if DoesEntityExist(vehicle) then
          TaskStartScenarioInPlace(ped, "PROP_HUMAN_BUM_BIN", 0, true)
           exports['mythic_progbar']:Progress({
             name = "eng_ine",
             duration = 60000,
             label = "Fitting New Engine",
             useWhileDead = false,
             canCancel = true,
             controlDisables = {
                 disableMovement = true,
                 disableCarMovement = true,
                 disableMouse = false,
                 disableCombat = true,
             },
         }, function(status)
               if not status then
                 SetVehicleEngineHealth(vehicle, 1000.0)
                 SetVehicleUndriveable(vehicle, false)
                 ClearPedTasksImmediately(ped)
                 --exports['NRP-notify']:DoHudText('success', 'Fitting New Gearbox') 
                end
           end)
        end
      end
end)
  
RegisterNetEvent('NRP-Mech:Gearbox')
AddEventHandler('NRP-Mech:Gearbox', function()
     local ped = GetPlayerPed(-1)
    local coords = GetEntityCoords(ped)
    if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
      local vehicle = nil
      if IsPedInAnyVehicle(ped, false) then
        vehicle = GetVehiclePedIsIn(ped, false)
      else
        vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
      end
      if DoesEntityExist(vehicle) then
          TaskStartScenarioInPlace(ped, "PROP_HUMAN_BUM_BIN", 0, true)
           exports['mythic_progbar']:Progress({
             name = "gear_box",
             duration = 20000,
             label = "Fitting New Gearbox",
             useWhileDead = false,
             canCancel = true,
             controlDisables = {
                 disableMovement = true,
                 disableCarMovement = true,
                 disableMouse = false,
                 disableCombat = true,
             },
         }, function(status)
               if not status then
                 SetVehicleEngineHealth(vehicle, 401.0)
                 SetVehicleUndriveable(vehicle, false)
                 ClearPedTasksImmediately(ped)
                 --exports['NRP-notify']:DoHudText('success', 'Fitting New Gearbox') 
                end
           end)
        end
      end
end)
  
RegisterNetEvent('NRP-Mech:Service')
AddEventHandler('NRP-Mech:Service', function()
      local ped = GetPlayerPed(-1)
      local coords = GetEntityCoords(ped)
      if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
        local vehicle = nil
        if IsPedInAnyVehicle(ped, false) then
          vehicle = GetVehiclePedIsIn(ped, false)
        else
          vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
        end
        if DoesEntityExist(vehicle) then
             TaskStartScenarioInPlace(ped, "PROP_HUMAN_BUM_BIN", 0, true)
              exports['mythic_progbar']:Progress({
                name = "engine_bodywork",
                duration = 25000,
                label = "Servicing Engine and Repairing Bodywork",
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
            }, function(status)
                  if not status then
                    --SetVehicleEngineHealth(vehicle, 1000.0)
                    --SetVehicleBodyHealth(vehicle, 1000.0)
                    SetVehicleFixed(vehicle) 
                    SetVehicleUndriveable(vehicle, false)
                    ClearPedTasksImmediately(ped)
                    --exports['NRP-notify']:DoHudText('success', 'Vehicle Has Been Serviced and Body Has Been Repaired') 
                   end
              end)
           end
      end
end)
  
RegisterNetEvent('NRP-Mech:SparkPlug')
AddEventHandler('NRP-Mech:SparkPlug', function()
      local ped = GetPlayerPed(-1)
      local coords = GetEntityCoords(ped)
      if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
        local vehicle = nil
        if IsPedInAnyVehicle(ped, false) then
          vehicle = GetVehiclePedIsIn(ped, false)
        else
          vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
        end
        if DoesEntityExist(vehicle) then
          TaskStartScenarioInPlace(ped, "PROP_HUMAN_BUM_BIN", 0, true)
           exports['mythic_progbar']:Progress({
             name = "spark_plug",
             duration = 20000,
             label = "Fitting New Spark Plugs",
             useWhileDead = false,
             canCancel = true,
             controlDisables = {
                 disableMovement = true,
                 disableCarMovement = true,
                 disableMouse = false,
                 disableCombat = true,
             },
         }, function(status)
               if not status then
                 SetVehicleEngineHealth(vehicle, 951.0)
                 SetVehicleUndriveable(vehicle, false)
                 ClearPedTasksImmediately(ped)
                 --exports['NRP-notify']:DoHudText('success', 'Fitting New Spark Plugs') 
                end
           end)
        end
      end
end)
 
RegisterNetEvent('NRP-Mech:AirFilter')
AddEventHandler('NRP-Mech:AirFilter', function()
      local ped = GetPlayerPed(-1)
      local coords = GetEntityCoords(ped)
      if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
        local vehicle = nil
        if IsPedInAnyVehicle(ped, false) then
          vehicle = GetVehiclePedIsIn(ped, false)
        else
          vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
        end
        if DoesEntityExist(vehicle) then
          TaskStartScenarioInPlace(ped, "PROP_HUMAN_BUM_BIN", 0, true)
           exports['mythic_progbar']:Progress({
             name = "air_filter",
             duration = 20000,
             label = "Fitting New Air Filter",
             useWhileDead = false,
             canCancel = true,
             controlDisables = {
                 disableMovement = true,
                 disableCarMovement = true,
                 disableMouse = false,
                 disableCombat = true,
             },
         }, function(status)
               if not status then
                 SetVehicleEngineHealth(vehicle, 901.0)
                 SetVehicleUndriveable(vehicle, false)
                 ClearPedTasksImmediately(ped)
                 --exports['NRP-notify']:DoHudText('success', 'Fitting New Air Filter') 
                end
           end)
        end
      end
end)
  
RegisterNetEvent('NRP-Mech:CConverter')
AddEventHandler('NRP-Mech:CConverter', function()
      local ped = GetPlayerPed(-1)
      local coords = GetEntityCoords(ped)
      if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
        local vehicle = nil
        if IsPedInAnyVehicle(ped, false) then
          vehicle = GetVehiclePedIsIn(ped, false)
        else
          vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
        end
        if DoesEntityExist(vehicle) then
          TaskStartScenarioInPlace(ped, "PROP_HUMAN_BUM_BIN", 0, true)
           exports['mythic_progbar']:Progress({
             name = "cat_c",
             duration = 20000,
             label = "Fitting New Catyltic Converter",
             useWhileDead = false,
             canCancel = true,
             controlDisables = {
                 disableMovement = true,
                 disableCarMovement = true,
                 disableMouse = false,
                 disableCombat = true,
             },
         }, function(status)
               if not status then
                 SetVehicleEngineHealth(vehicle, 601.0)
                 SetVehicleUndriveable(vehicle, false)
                 ClearPedTasksImmediately(ped)
                 exports['NRP-notify']:DoHudText('success', 'Fitting New Catayltic Converter') 
                end
           end)
        end
      end
end)