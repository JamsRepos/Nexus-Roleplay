isInService = false
vehlivery = 0
local currentCops = 0
local currentEMS = 0
local IsDragged = false
local mission_list = {}
local currentVehicle = nil

--- In Dev
local prisped = nil
local inPDTrans = false

RegisterNetEvent('dutylog:dutyChange')
AddEventHandler('dutylog:dutyChange', function(job, status)
  TriggerServerEvent("dutylog:dutyChange", job, status)
end)

RegisterCommand("policestop", function(source, args, rawCommand)
 if DecorGetBool(GetPlayerPed(-1), "isOfficer") then
  
  local t, distance = GetClosestPlayer()
  if(distance ~= -1 and distance < 3) then
   TriggerServerEvent('police:prisontrans', GetPlayerServerId(t))
  else
    exports['NRP-notify']:DoHudText('inform',  "No Player Near")  
  end
 end
end)

--[[RegisterCommand("sharedbank", function(source, args, rawCommand)
 if DecorGetInt(GetPlayerPed(-1), "Job") == 107 then
   TriggerEvent('shared_banking:status', true)
 end
end)]]

RegisterCommand("unlockpbus", function(source, args, rawCommand)
  if exports['core']:GetItemQuantity(21) >= 1 then
    TriggerServerEvent('police:unlockpbus')
  end
end)

RegisterNetEvent('items:cuff')
AddEventHandler('items:cuff', function() 
  local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then 
      if GetEntityModel(GetPlayerPed(-1)) == 1126154828 then 
        exports['NRP-notify']:DoHudText('error',  "Your a Dog , How you plan on doing that?!")  
      else
        if not IsPedCuffed(GetPlayerPed(t)) then 
          RequestAnimDict('mp_arrest_paired')
          while not HasAnimDictLoaded('mp_arrest_paired') do
           Citizen.Wait(0)
          end
          --TaskPlayAnim(GetPlayerPed(-1), "mp_arrest_paired", "cop_p2_back_right", 8.0, -8, -1, 48, 0, 0, 0, 0)
          --TriggerServerEvent('police:drag', GetPlayerServerId(t))
        end
        TriggerServerEvent('police:handcuff', GetPlayerServerId(t))
        if AnimationComplete(GetPlayerPed(-1), "mp_arrest_paired", "cop_p2_back_right", 0.89, 300) then
          ClearPedTasksImmediately(GetPlayerPed(-1))
        end
      end
    else 
      exports['NRP-notify']:DoHudText('inform',  "No Player Near")  
  end
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

local inMugshot = false
-- Mugshots
Citizen.CreateThread(function()
  while true do
   Wait(5)
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 435.57, -990.25, 26.67, true) < 50) and not inMugshot then
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 435.57, -990.25, 26.67, true) < 1.0) then
        DrawText3Ds(435.57, -990.25, 26.67,'~g~[E]~w~ to take mugshots')
        if IsControlJustPressed(0, 38) then
          inMugshot = true
          Mugshot()
          Wait(1200)
          inMugshot = false
        end
      end
    end
  end
end)

function Mugshot()
  DoScreenFadeOut(500)
  TriggerEvent('police:uncuff')
  LoadModel("prop_police_id_board")
  local dict = "mp_character_creation@customise@male_a"
  RequestAnimDict(dict)
  while not HasAnimDictLoaded(dict) do
    Citizen.Wait(0)
  end
  Wait(500)
  SetEntityCoords(GetPlayerPed(-1), 435.57, -990.25, 26.67-0.95)
  SetEntityHeading(GetPlayerPed(-1), 280.000)
  ClearPedTasksImmediately(GetPlayerPed(-1))
  TaskPlayAnim(PlayerPedId(), "mp_character_creation@customise@male_a", "loop", 8.0, -8.0, -1, 0, 0, false, false, false)
  Wait(500)
  DoScreenFadeIn(500)
  local pos = GetEntityCoords(GetPlayerPed(-1), false)
  SignObject = CreateObject(GetHashKey("prop_police_id_board"), pos.x, pos.y, pos.z, true, true, true)
  AttachEntityToEntity(SignObject, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), 0.0, -0.00, 0.0, 5.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
  FreezeEntityPosition(GetPlayerPed(-1), true)
  Wait(10000)
  TaskPlayAnim(PlayerPedId(), "mp_character_creation@customise@male_a", "loop", 8.0, -8.0, -1, 0, 0, false, false, false)
  SetEntityHeading(GetPlayerPed(-1), 0.0)
  TaskPlayAnim(PlayerPedId(), "mp_character_creation@customise@male_a", "loop", 8.0, -8.0, -1, 0, 0, false, false, false)
  Wait(10000)
  TaskPlayAnim(PlayerPedId(), "mp_character_creation@customise@male_a", "loop", 8.0, -8.0, -1, 0, 0, false, false, false)
  SetEntityHeading(GetPlayerPed(-1), 180.0)
  TaskPlayAnim(PlayerPedId(), "mp_character_creation@customise@male_a", "loop", 8.0, -8.0, -1, 0, 0, false, false, false)
  Wait(10000)
  DoScreenFadeOut(500)
  DeleteObject(SignObject)
  ClearPedTasksImmediately(GetPlayerPed(-1))
  FreezeEntityPosition(GetPlayerPed(-1), false)
  Wait(2500)
  DoScreenFadeIn(500)
end

function LoadModel(model)
  RequestModel(model)

  while not HasModelLoaded(model) do
    Citizen.Wait(10)
  end
end

RegisterNetEvent('police:prisontrans')
AddEventHandler('police:prisontrans', function()
 API_PrisonBus("pbus", 495.894, -1003.348, 27.990, 359.934)
end)

local isheadingtoprison = false

function API_PrisonBus(model, x, y, z, heading)
 inPDTrans = true
 local vehicleHash = GetHashKey(model)
 RequestModel(vehicleHash)
 while not HasModelLoaded(vehicleHash) do
  Citizen.Wait(1)
 end
 
 RequestModel(GetHashKey('s_m_m_prisguard_01'))
  while not HasModelLoaded(GetHashKey('s_m_m_prisguard_01')) do
   Wait(1)
  end
 
 prisped = CreatePed(4, "s_m_m_prisguard_01", x, y, z, 0.0, true, true)

 currentVehicle = CreateVehicle(vehicleHash, x, y, z, heading, true, false)
 local id = NetworkGetNetworkIdFromEntity(currentVehicle)
 SetNetworkIdCanMigrate(id, true)
 SetNetworkIdExistsOnAllMachines(id, true)
 SetVehicleIsConsideredByPlayer(currentVehicle, true)

 TaskWarpPedIntoVehicle(prisped, currentVehicle, -1)
 Wait(1000)
 SetPedIntoVehicle(GetPlayerPed(-1), currentVehicle, 2)
 DecorSetBool(PlayerPedId(), 'Seatbelt', true)
 isheadingtoprison = true
 SetEntityAsMissionEntity(currentVehicle, true, true)
 SetVehicleEngineOn(currentVehicle, true)
 SetVehicleDoorsLocked(currentVehicle, 2)
 SetVehicleDoorsLockedForAllPlayers(currentVehicle, true)

 TaskVehicleDriveToCoordLongrange(prisped, currentVehicle, 1783.167, 2605.063, 45.565, 25.0, 411, 30.0)
end

local nearObject = false
local isNearObject = false
local objectLoc = {}
local clostestProp = nil
local label = "Hotdog"
local models = {
  [1] = 1129053052,
  [2] = -1581502570,
  [3] = 4022605402,
}

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
  Wait(5)
  if isNearObject then 
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), objectLoc.x, objectLoc.y, objectLoc.z-0.5, true) < 1.3) then
    DrawText3Ds(objectLoc.x, objectLoc.y, objectLoc.z,'~g~[E]~w~ Buy Hotdog ~g~$8') 
  	if IsControlJustPressed(0, 38) then
		  TaskStartScenarioInPlace(GetPlayerPed(-1), 'PROP_HUMAN_ATM', false, true) Wait(3000) ClearPedTasksImmediately(GetPlayerPed(-1))
      TriggerServerEvent('shops:purchase', label, 8, 1, 105)
      TriggerServerEvent('bank:intoSharedBank', 8, 10)
    end
   end ---- add shared banking to vending machines then somecan buy them
   end
 end
end)


RegisterNetEvent('police:unlockpbus')
AddEventHandler('police:unlockpbus', function()
 API_UnlockPBus()
end)

function API_UnlockPBus()
 SetVehicleDoorsLocked(GetHashKey("pbus"), 1)
 SetVehicleDoorsLockedForAllPlayers(GetHashKey("pbus"), false)
 exports['NRP-notify']:DoHudText('success', 'Door Unlocked')
end

Citizen.CreateThread(function()
  while true do
   Citizen.Wait(10)
  if isheadingtoprison == true and IsPedDeadOrDying(prisped, 1) then
    if GetVehicleDoorAngleRatio(GetVehiclePedIsIn(GetPlayerPed(-1), 1)) > 0.1 or GetVehicleDoorAngleRatio(GetVehiclePedIsIn(GetPlayerPed(-1)), 2) > 0.1 then
      DecorSetBool(PlayerPedId(), 'Seatbelt', false)
      inPDTrans = false
      TaskLeaveVehicle(GetPlayerPed(-1), currentVehicle, 256)
      ClearPedTasks(GetPlayerPed(-1))
      isheadingtoprison = false
      break
    end
  end
 end
end)

Citizen.CreateThread(function()
  while true do
   Citizen.Wait(10)
   if IsPedBeingStunned(GetPlayerPed(-1), true) then
    ShakeGameplayCam("ROAD_VIBRATION_SHAKE", 3.75)
    SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
    DoScreenFadeOut(1)
    Wait(1200)
    DoScreenFadeIn(1)
    SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
    Wait(1200)
   StopGameplayCamShaking(false)
  end
 end
end)

RegisterNetEvent('police:fastResponseMenu')
AddEventHandler('police:fastResponseMenu', function()
 WarMenu.OpenMenu('Policetrunk') 
end)
  
-- Blips And Locations
Citizen.CreateThread(function()
 while true do
  Wait(5)
  -- Duty Blip
  if DecorGetBool(GetPlayerPed(-1), "isOfficer") or DecorGetInt(GetPlayerPed(-1), "Jobs") == 17 and currentCops <=6 then
   for k,v in pairs(duty) do
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 50) then
     if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 2.0) then
      if isInService then
       DrawText3Ds(v.x, v.y, v.z,'~g~[E]~w~ To Go Off Duty')
       if IsControlJustPressed(0, 38) then
        TriggerEvent("police:offnotification")
        OffDuty()
        isInService = false
        PlaySound(-1, 'GO', 'HUD_MINI_GAME_SOUNDSET', 0, 0, 1)
       end
      else
       DrawText3Ds(v.x, v.y, v.z,'~g~[E]~w~ To Go On Duty')
       if IsControlJustPressed(0, 38) then
        OnDuty()
        isInService = true
        PlaySound(-1, 'GO', 'HUD_MINI_GAME_SOUNDSET', 0, 0, 1)
       end
      end
     end
    end
   end

   if isInService then
    for k,v in pairs(garage) do
     if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 50) then
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 4.0) then
       DrawText3Ds(v.x, v.y, v.z,'~g~[E]~w~ To Access Garage \n ~w~Press ~g~[R]~w~ To Apply All Extras')
       if IsControlJustPressed(0, 38) then
        if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
         local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1))
         SetEntityAsMissionEntity(vehicle, true, true)
         Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
        else
         currentgarage = {id=v.id, x=v.x, y=v.y, z=v.z}
         WarMenu.OpenMenu('police_garage')
       end
         elseif IsControlPressed(0, 45) then
          Applyextras()
          exports['NRP-notify']:DoHudText('inform', "Extras Applied")
          Wait(1000)
       end
      end
     end
    end

    for k,v in pairs(spgarage) do
     if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 50) then
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 4.0) then
       DrawText3Ds(v.x, v.y, v.z,'~g~[E]~w~ To Access Garage \n ~c~Press ~g~[R]~c~ To Apply All Extras')
       if IsControlJustPressed(0, 38) then
        if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
         local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1))
         SetEntityAsMissionEntity(vehicle, true, true)
         Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
        else
         currentgarage = {id=v.id, x=v.x, y=v.y, z=v.z}
         if  DecorGetInt(GetPlayerPed(-1), "Job") == 1 or DecorGetInt(GetPlayerPed(-1), "Job") == 37 then
          WarMenu.OpenMenu('police_unmarkedgarage')
         else 
          exports['NRP-notify']:DoHudText('success', 'You cannot take out a specialized vehicle.')
         end
       end
         elseif IsControlPressed(0, 45) then
          Applyextras()
          exports['NRP-notify']:DoHudText('inform', "Extras Applied")
          Wait(1000)
       end
      end
     end
    end

    for k,v in pairs(helicopters) do
     if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 50) then
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 4.0) then
       DrawText3Ds(v.x, v.y, v.z,'~g~[E]~w~ To Spawn Helicopter')
       if IsControlJustPressed(0, 38) then
        if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
         local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1))
         SetEntityAsMissionEntity(vehicle, true, true)
         Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
        else
         currentgarage = {x = v.x, y = v.y, z = v.z}
         if DecorGetInt(GetPlayerPed(-1), "Job") == 1 or DecorGetInt(GetPlayerPed(-1), "Job") == 37 then
          SpawnVehicle('polmav')
         else 
          exports['NRP-notify']:DoHudText('inform', "You are not authorized to fly a helicopter.")
         end
        end
       end
      end
     end
    end

    for k,v in pairs(armory) do
     if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 50) then
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 1.5) then
       DrawText3Ds(v.x, v.y, v.z+0.95,'~g~[E]~w~ to access the armoury')
       if IsControlJustPressed(0, 38) then
        TriggerServerEvent('armoury:getInventory')
        --WarMenu.OpenMenu('police_armoury')
       end
      end
     end
    end

    for k,v in pairs(evidence) do
     if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 50) then
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 1.5) then
       DrawText3Ds(v.x, v.y, v.z,'~g~[E]~w~ to access the evidence locker')
       if IsControlJustPressed(0, 38) then
        TriggerServerEvent('evidence:getInventory')
        --WarMenu.OpenMenu('police_armoury')
       end
      end
     end
    end
--[[
    for k,v in pairs(janitor) do
     if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 50) then
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 1.5) then
       DrawText3Ds(v.x, v.y, v.z,'~g~[E]~w~ to open the janitor\'s cabinet')
       if IsControlJustPressed(0, 38) then
        WarMenu.OpenMenu('police_jcabinet')
       end
      end
     end
    end

    for k,v in pairs(medicine) do
     if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 50) then
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 1.5) then
       DrawText3Ds(v.x, v.y, v.z,'~g~[E]~w~ to open the medicine cabinet')
       if IsControlJustPressed(0, 38) then
        WarMenu.OpenMenu('police_mcabinet')
       end
      end
     end
    end

   --[[ for k,v in pairs(chief) do
     if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 50) then
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 1.5) then
       DrawText3Ds(v.x, v.y, v.z,'~g~[E]~w~ to open the chief\'s drawer')
       if IsControlJustPressed(0, 38) then
        if DecorGetInt(GetPlayerPed(-1), "Job") == 107 then
          WarMenu.OpenMenu('police_cdrawer')
        else  
          exports['NRP-notify']:DoHudText('inform', "You dont have the chief's key")
        end
       end
      end
     end
    end
]]--
    --[[for k,v in pairs(breakroom) do
     if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 50) then
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 1.5) then
       DrawText3Ds(v.x, v.y, v.z,'~g~[E]~w~ to use the kitchen')
       if IsControlJustPressed(0, 38) then
        WarMenu.OpenMenu('police_breakroom')
       end
      end
     end
    end

    for k,v in pairs(breakroom1) do
     if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 50) then
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 1.5) then
       DrawText3Ds(v.x, v.y, v.z,'~g~[E]~w~ to open the fridge')
       if IsControlJustPressed(0, 38) then
        WarMenu.OpenMenu('police_breakroom1')
       end
      end
     end
    end
]]--
    if IsControlJustPressed(0, 167) or IsDisabledControlJustReleased(0, 167) then 
     WarMenu.OpenMenu('police_toolkit') 
    end
   end
  end
 end
end)

--=====Boats=====--

    --[[Citizen.CreateThread(function()
    while true do
      Citizen.Wait(1)
     if DecorGetBool(GetPlayerPed(-1), "isOfficer") then
     if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 458.597, -979.634, 30.690, true) < 10) then
      DrawMarker(27, 458.597, -979.634, 30.690-0.95, 0, 0, 0, 0, 0, 0, 0.5,0.5,0.5, 0, 82, 165, 240, 0, 0, 2, 0, 0, 0, 0)
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 458.597, -979.634, 30.690-0.95, true) < 1.0) then
       drawTxt('~g~[E]~w~ To Grab Pistol and Shotgun')
       if IsControlJustPressed(0, 38) then
         GiveWeaponToPed(GetPlayerPed(-1), 'WEAPON_COMBATPISTOL', 400)
         GiveWeaponToPed(GetPlayerPed(-1), 'WEAPON_PUMPSHOTGUN', 400)
         end
        end
       end
      end
     end
    end)]]

    Citizen.CreateThread(function()
    while true do
      Citizen.Wait(1)
     if DecorGetBool(GetPlayerPed(-1), "isOfficer") then
     if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 3823.225, 4442.610, 2.807, true) < 50) then
      DrawMarker(35, 3823.225, 4442.610, 2.807+0.95, 0, 0, 0, 0, 0, 0, 0.5,1.1,0.5, 0, 82, 165, 240, 0, 0, 2, 0, 0, 0, 0)
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 3823.225, 4442.610, 2.807, true) < 4.0) then
       drawTxt('~g~[E]~w~ To Spawn Boat')
       if IsControlJustPressed(0, 38) then
         API_CreateVehicle('predator', 3867.410, 4445.865, 2.807)
         end
        end
       end
      end
     end
    end)

        Citizen.CreateThread(function()
    while true do
      Citizen.Wait(1)
     if DecorGetBool(GetPlayerPed(-1), "isOfficer") then
     if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -806.866, -1497.097, 1.595, true) < 50) then
      DrawMarker(35, -806.866, -1497.097, 1.595+0.95, 0, 0, 0, 0, 0, 0, 0.8,0.8,0.5, 0, 82, 165, 240, 0, 0, 2, 0, 0, 0, 0)
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -806.866, -1497.097, 1.595, true) < 1.5) then
       drawTxt('~g~[E]~w~ To Spawn Boat')
       if IsControlJustPressed(0, 38) then
         API_CreateVehicle('predator', -801.935, -1504.908, 1.594)
         end
        end
       end
      end
     end
    end)


-------Spawn Firing Peds

        Citizen.CreateThread(function()
    while true do
      Citizen.Wait(1)
     if DecorGetBool(GetPlayerPed(-1), "isOfficer") then
     if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 896.034, -3170.867, -97.124, true) < 10) then
      DrawMarker(27, 886.034, -3170.867, -97.124+0.95, 0, 0, 0, 0, 0, 0, 0.8,0.8,0.5, 0, 82, 165, 240, 0, 0, 2, 0, 0, 0, 0)
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 896.034, -3170.867, -97.124, true) < 1.0) then
       drawTxt('~g~[E]~w~ To Spawn Peds To Shoot')
       if IsControlJustPressed(0, 38) then
           Wait(250)
           RequestModel(GetHashKey('s_m_m_marine_01'))
           CreatePed(2, GetHashKey('s_m_m_marine_01'), 902.722, -3133.767, -97.124, false, false)
           TaskStartScenarioInPlace('s_m_m_marine_01', "WORLD_HUMAN_CLIPBOARD", 0, true)
            SetPedCanRagdoll('s_m_m_marine_01', false)
           SetEntityInvincible('s_m_m_marine_01', true)
         end
        end
       end
      end
     end
    end)

      Citizen.CreateThread(function()
    while true do
      Citizen.Wait(1)
     if DecorGetBool(GetPlayerPed(-1), "isOfficer") then
     if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 894.431, -3171.111, -97.124, true) < 10) then
      DrawMarker(27, 884.431, -3171.111, -97.124+0.95, 0, 0, 0, 0, 0, 0, 0.8,0.8,0.5, 0, 82, 165, 240, 0, 0, 2, 0, 0, 0, 0)
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 894.431, -3171.111, -97.124, true) < 1.0) then
       drawTxt('~g~[E]~w~ To Spawn Peds To Shoot')
       if IsControlJustPressed(0, 38) then
           Wait(250)
           RequestModel(GetHashKey('s_m_m_marine_01'))
           CreatePed(2, GetHashKey('s_m_m_marine_01'), 904.553, -3133.843, -97.124, false, false)
           SetPedCanRagdoll('s_m_m_marine_01', false)
           SetEntityInvincible('s_m_m_marine_01', true)
         end
        end
       end
      end
     end
    end)

        Citizen.CreateThread(function()
    while true do
      Citizen.Wait(1)
     if DecorGetBool(GetPlayerPed(-1), "isOfficer") then
     if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 897.769, -3171.095, -97.124, true) < 10) then
      DrawMarker(27, 887.769, -3171.095, -97.124+0.95, 0, 0, 0, 0, 0, 0, 0.8,0.8,0.5, 0, 82, 165, 240, 0, 0, 2, 0, 0, 0, 0)
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 897.769, -3171.095, -97.124, true) < 1.0) then
       drawTxt('~g~[E]~w~ To Spawn Peds To Shoot')
       if IsControlJustPressed(0, 38) then
           Wait(250)
           RequestModel(GetHashKey('s_m_m_marine_01'))
           CreatePed(2, GetHashKey('s_m_m_marine_01'), 904.553, -3133.843, -97.124, false, false)
           SetPedCanRagdoll('s_m_m_marine_01', false)
           SetEntityInvincible('s_m_m_marine_01', true)
         end
        end
       end
      end
     end
    end)


--===========================================================================================================================--
function API_CreateVehicle(model, x, y, z)
 local vehicleHash = GetHashKey(model)
 RequestModel(vehicleHash)
 while not HasModelLoaded(vehicleHash) do
  Citizen.Wait(0)
 end

 currentVehicle = CreateVehicle(vehicleHash, x, y, z, GetEntityHeading(GetPlayerPed(-1)), true, false)
 local id = NetworkGetNetworkIdFromEntity(currentVehicle)
 SetNetworkIdCanMigrate(id, true)
 SetNetworkIdExistsOnAllMachines(id, true)

 TaskWarpPedIntoVehicle(GetPlayerPed(-1), currentVehicle, -1)
 SetEntityAsMissionEntity(currentVehicle, true, true)
 SetVehicleEngineOn(currentVehicle, true)
 DecorRegister("_Fuel_Level", 3);
 DecorRegister("_Max_Fuel_Level", 3);
 DecorSetInt(vehicle, "_Max_Fuel_Level", 150000)
 DecorSetInt(vehicle, "_Fuel_Level", 150000)

end

Citizen.CreateThread(function()
 local currentlivery = 1
 local selectedlivery = 1
 local currenttype = 1 
 local selectedtype = 1
 local currentveh = 1 
 local selectedveh = 1
 local armor_status = 1
 local armor = 1
 local vehicle = '' 
 WarMenu.CreateLongMenu('police_garage', "Garage")
 WarMenu.CreateLongMenu('police_unmarkedgarage', "Garage")
--WarMenu.CreateLongMenu('police_armoury', "Armoury")
 --WarMenu.CreateLongMenu('police_jcabinet', "Cabinet")
 --WarMenu.CreateLongMenu('police_mcabinet', "Cabinet")
 --WarMenu.CreateLongMenu('police_cdrawer', "Drawer")
 --WarMenu.CreateLongMenu('police_breakroom', "Kitchen")
-- WarMenu.CreateLongMenu('police_breakroom1', "Fridge")
 --WarMenu.CreateLongMenu('police_attatchments', "Police")
 while true do
  Wait(5)
  if WarMenu.IsMenuOpened('police_garage') then
    if selectedtype == 1 and WarMenu.ComboBox('Vehicle', {'Centenario', '2018 Charger', 'Explorer', 'Tahoe', 'Crownvick', 'Impala', 'Prison Bus', 'Motorbike','BCSO Explorer', 'BCSO Charger', 'BCSO Tahoe', 'BCSO Crown Vic', 'BCSO Taurus'}, currentveh, selectedveh, function(veh)
      currentveh = veh
      selectedveh = currentveh
      if currentveh == 1 then vehicle = 'lp770cop'
      elseif currentveh == 2 then vehicle = 'police2'
      elseif currentveh == 3 then vehicle = 'police5'
      elseif currentveh == 4 then vehicle = 'police6'
      elseif currentveh == 5 then vehicle = 'police7'
      elseif currentveh == 6 then vehicle = 'police8'
      elseif currentveh == 7 then vehicle = 'pbus'
      elseif currentveh == 8 then vehicle = 'polthrust'
      elseif currentveh == 9 then vehicle = '16exp'
      elseif currentveh == 10 then vehicle = '18charger'
      elseif currentveh == 11 then vehicle = '19hoe'
      elseif currentveh == 12 then vehicle = 'cvpi'
      elseif currentveh == 13 then vehicle = 'tau'
      end
     end) then
   elseif WarMenu.Button('Confirm') then
    if vehicle == 'riot' or vehicle == 'riot2' or vehicle == 'fbi' or vehicle == 'fbi2' or vehicle == 'suburban' or vehicle == 'policeb' then
     local pos = GetEntityCoords(GetPlayerPed(-1))
     API_CreateVehicle(vehicle, pos.x, pos.y, pos.z)
      --TriggerServerEvent('bank:outofSharedBank', 1500, 7)
    else
     SpawnVehicle(vehicle)
    if vehicle == 'zl1' then
      Wait(1000)
      local Veh = GetVehiclePedIsIn(GetPlayerPed(-1))
      SetVehicleCustomPrimaryColour(Veh, 0, 0, 0)
      SetVehicleCustomSecondaryColour(Veh, 0, 0, 0)
    end
      --TriggerServerEvent('bank:outofSharedBank', 1500, 7)
    end
  end
  elseif WarMenu.IsMenuOpened('police_unmarkedgarage') then
    if selectedtype == 1 and WarMenu.ComboBox('Vehicle', {'UC Charger', 'UC Explorer'}, currentveh, selectedveh, function(veh)
      currentveh = veh
      selectedveh = currentveh
      if currentveh == 1 then vehicle = '14char'
      elseif currentveh == 2 then vehicle = 'exp'
      end
     end) then
   elseif WarMenu.Button('Confirm') then
    if vehicle == 'riot' or vehicle == 'riot2' or vehicle == 'fbi' or vehicle == 'fbi2' or vehicle == 'suburban' or vehicle == 'policeb' then
     local pos = GetEntityCoords(GetPlayerPed(-1))
     API_CreateVehicle(vehicle, pos.x, pos.y, pos.z)
      --TriggerServerEvent('bank:outofSharedBank', 1500, 7)
    else
     SpawnVehicle(vehicle)
    if vehicle == '14char' or vehicle == 'exp' then
      Wait(1000)
      local Veh = GetVehiclePedIsIn(GetPlayerPed(-1))
      SetVehicleCustomPrimaryColour(Veh, 0, 0, 0)
      SetVehicleCustomSecondaryColour(Veh, 0, 0, 0)
    end
      --TriggerServerEvent('bank:outofSharedBank', 1500, 7)
    end
  end
  
  end
 end 
end)

Citizen.CreateThread(function()
 WarMenu.CreateLongMenu('police_missions', 'Missions')
 while true do 
  Wait(5)
  if DecorGetBool(GetPlayerPed(-1), "isOfficer") then
  if not IsPedInAnyVehicle(GetPlayerPed(-1)) then drawUI(0.514, 1.395, 1.0, 1.0, 0.45, MissionInformation, 89, 194, 255, 255, false) else drawUI(0.514, 1.275, 1.0, 1.0, 0.45, MissionInformation, 89, 194, 255, 255, false) end
   if WarMenu.IsMenuOpened('police_missions') then
    for i,v in pairs(mission_list) do
     if v.name ~= "Finish Mission" then
      if WarMenu.Button(v.name) then
       v.f(v.mission)
       exports['NRP-notify']:DoLongHudText('inform', 'Call Information: '..v.info)
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
end)

Citizen.CreateThread(function()
 WarMenu.CreateLongMenu('police_toolkit', 'Police')
 local currentItemIndex4 = 1
 local selectedItemIndex4 = 1
 local currentItemIndex = 1
 local Search = 1
 local Hand = 1
 local currentItemIndex3 = 1
 local currentItemIndex2 = 1
 local Vehicle = 1
 local Confiscate = 1
 local currentItemIndex5 = 1
 local Test = 1
 local currentItemIndex7 = 1
 local Cuffs = 1
 local currentItemIndexCuffs = 1
 local selectedItemIndexCuffs = 1
 while true do
  Wait(5)
  if WarMenu.IsMenuOpened('police_toolkit') then
   if WarMenu.Button('Missions') then
    WarMenu.OpenMenu('police_missions')
   elseif WarMenu.Button('Escort') then
      local t, distance = GetClosestPlayer()
      if(distance ~= -1 and distance < 3) then 
        TriggerServerEvent('police:drag', GetPlayerServerId(t)) 
      else 
        exports['NRP-notify']:DoHudText('inform',  "No Player Near")
      end
    elseif WarMenu.ComboBox('Handcuffs', {'Cuff','Un-Cuff'}, currentItemIndexCuffs, Cuffs, function(selectedItemIndexCuffs)
      currentItemIndexCuffs = selectedItemIndexCuffs Cuffs = selectedItemIndexCuffs
      end) then
      local t, distance = GetClosestPlayer()
      if Cuffs == 1 then
        if(distance ~= -1 and distance < 3) then
          RequestAnimDict('mp_arrest_paired')
          while not HasAnimDictLoaded('mp_arrest_paired') do
           Citizen.Wait(0)
          end
          TaskPlayAnim(GetPlayerPed(-1), "mp_arrest_paired", "cop_p2_back_right", 8.0, -8, -1, 48, 0, 0, 0, 0)
          TriggerServerEvent('police:handcuff:toggle', GetPlayerServerId(t), true)
        else
          exports['NRP-notify']:DoHudText('inform',  "No Player Near") 
        end
      end

      if Cuffs == 2 then
        if(distance ~= -1 and distance < 5) then
          TriggerServerEvent('police:handcuff:toggle', GetPlayerServerId(t), false)
        else
          exports['NRP-notify']:DoHudText('inform',  "No Player Near") 
        end
      end
      if AnimationComplete(GetPlayerPed(-1), "mp_arrest_paired", "cop_p2_back_right", 0.89, 300) then
        ClearPedTasksImmediately(GetPlayerPed(-1))
      end
   elseif WarMenu.Button('Props Menu') then
    if GetEntityModel(GetPlayerPed(-1)) == 1126154828 then exports['NRP-notify']:DoHudText('error',  "Your a Dog , How you plan on doing that?!")  else WarMenu.OpenMenu('police_props') end
   elseif WarMenu.Button('Plate Check') then
    if GetEntityModel(GetPlayerPed(-1)) == 1126154828 then exports['NRP-notify']:DoHudText('error',  "Your a Dog , How you plan on doing that?!")  else TriggerEvent("mdt:runMdcOnForwardEntity") end
   elseif WarMenu.ComboBox('Vehicle', {'Put In','Take Out'}, currentItemIndex2, Vehicle, function(currentIndex2)
    currentItemIndex2 = currentIndex2 Vehicle = currentIndex2
    end) then
    local t, distance = GetClosestPlayer()
    if Vehicle == 1 then if(distance ~= -1 and distance < 3) then if GetEntityModel(GetPlayerPed(-1)) == 1126154828 then exports['NRP-notify']:DoHudText('error',  "Your a Dog , How you plan on doing that?!")  else TriggerServerEvent('police:vehiclein', GetPlayerServerId(t)) end else exports['NRP-notify']:DoHudText('inform',  "No Player Near") end end
    if Vehicle == 2 then if(distance ~= -1 and distance < 5) then if GetEntityModel(GetPlayerPed(-1)) == 1126154828 then exports['NRP-notify']:DoHudText('error',  "Your a Dog , How you plan on doing that?!")  else TriggerServerEvent('police:vehicleout', GetPlayerServerId(t)) end else exports['NRP-notify']:DoHudText('inform',  "No Player Near") end end
   elseif WarMenu.ComboBox('Search', {'Pockets','Wallet'}, currentItemIndex, Search, function(currentIndex)
    currentItemIndex = currentIndex Search = currentIndex
    end) then
    local t, distance = GetClosestPlayer()
    if Search == 1 then if(distance ~= -1 and distance < 3) then if GetEntityModel(GetPlayerPed(-1)) == 1126154828 then ExecuteCommand('me Sniffs') TriggerServerEvent('police:k9targetCheckInventory', GetPlayerServerId(t)) else ProgressBar('Searching Pockets', 35) ExecuteCommand('me searching someones pockets') Citizen.Wait(3500) TriggerServerEvent('rob:getPlayerInventory', GetPlayerServerId(t)) WarMenu.CloseMenu('police_toolkit') end else exports['NRP-notify']:DoHudText('inform',  "No Player Near") end 
  end
    if Search == 2 then if(distance ~= -1 and distance < 5) then if GetEntityModel(GetPlayerPed(-1)) == 1126154828 then exports['NRP-notify']:DoHudText('error',  "Your a Dog , How you plan on doing that?!")  else ProgressBar('Searching Wallet', 25) ExecuteCommand('me searching someones wallet') Citizen.Wait(2500) TriggerServerEvent('rob:getPlayerCash', GetPlayerServerId(t)) WarMenu.CloseMenu('police_toolkit') end else exports['NRP-notify']:DoHudText('inform',  "No Player Near") end end
   elseif WarMenu.ComboBox('Test', {'GSR','BAC','TACHO'}, currentItemIndex7, Test, function(currentIndex7)
    currentItemIndex7 = currentIndex7 Test = currentIndex7
    end) then
    local t, distance = GetClosestPlayer()
    if Test == 1 then 
     if(distance ~= -1 and distance < 3) then 
      if GetEntityModel(GetPlayerPed(-1)) == 1126154828 then exports['NRP-notify']:DoHudText('error',  "Your a Dog , How you plan on doing that?!")  else
       isGSRactive = DecorGetBool(GetPlayerPed(t), "GSR_Active")
       ProgressBar('GSR Testing', 35)
       Citizen.Wait(5000)
       if isGSRactive then
        exports['NRP-notify']:DoHudText('error',  "Subject tested Positive,They have discharged a firearm recently!")  
       else
        exports['NRP-notify']:DoHudText('success',  "Subject tested Negative, They haven't discharged a firearm recently!") 
       end
     end
     else 
      exports['NRP-notify']:DoHudText('inform',  "No Player Near")  
     end 
    end
    if Test == 2 then 
     if(distance ~= -1 and distance < 3) then 
      if GetEntityModel(GetPlayerPed(-1)) == 1126154828 then exports['NRP-notify']:DoHudText('error',  "Your a Dog , How you plan on doing that?!")  else
        local isBACActive = DecorGetBool(GetPlayerPed(t), "BAC_Active")
        ProgressBar('Testing BAC', 35)
        Citizen.Wait(5000)
        if isBACActive then
          exports['NRP-notify']:DoHudText('success',  "Subject tested Positive, Their blood-alcohol concentration is outside the legal limits")
        else
          exports['NRP-notify']:DoHudText('error',  "Subject tested Negative, Their blood-alcohol concentration is inside the legal limits") 
        end 
      end
       else 
        exports['NRP-notify']:DoHudText('inform',  "No Player Near")  
       end
    end
    if Test == 3 then 
     if(distance ~= -1 and distance < 5) then 
      if GetEntityModel(GetPlayerPed(-1)) == 1126154828 then exports['NRP-notify']:DoHudText('error',  "Your a Dog , How you plan on doing that?!")  else
      local tachoTime = DecorGetInt(GetPlayerPed(t), "Tacho")
      ProgressBar('Checking Tacho', 35)
      Citizen.Wait(5000)
      if tachoTime >= 15 then 
       TriggerEvent('chatMessage', '^5Tacho Meter: ^1'..tachoTime.."^5 Minutes | Suspect Is Over The Legal Limit")
      else 
       TriggerEvent('chatMessage', '^5Tacho Meter: ^3'..tachoTime.."^5 Minutes | Suspect Is Within The Legal Limit")
      end
    end
     else 
      exports['NRP-notify']:DoHudText('inform',  "No Player Near")  
     end 
    end
   elseif WarMenu.Button('Panic') then
    local pos = GetEntityCoords(GetPlayerPed(-1))
    TriggerServerEvent('police:triggerpanic', pos.x, pos.y, pos.z)
    TriggerEvent('nrp:dispatch:notify', '10-33')
   elseif WarMenu.Button('10-20') then
    local pos = GetEntityCoords(GetPlayerPed(-1))
    TriggerServerEvent('police:1020', pos.x, pos.y, pos.z)
    TriggerEvent('nrp:dispatch:notify', '10-20')
   elseif WarMenu.Button('Revive') then
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 5) then
    if GetEntityModel(GetPlayerPed(-1)) == 1126154828 then exports['NRP-notify']:DoHudText('error',  "Your a Dog , How you plan on doing that?!")  else
     if currentEMS < 2 then
      ProgressBar('Reviving', 55)
      TaskStartScenarioInPlace(GetPlayerPed(-1), 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true) 
      Citizen.Wait(13000)
      ClearPedTasks(GetPlayerPed(-1))
      TriggerServerEvent('ems:revive', GetPlayerServerId(t))
      exports['NRP-notify']:DoHudText('inform',  "Revive Complete")
     else
      exports['NRP-notify']:DoHudText('error',  "Function Disabled due to current EMS Presence")
     end
   end
    else
      exports['NRP-notify']:DoHudText('inform',  "No Player Near")
    end
   elseif WarMenu.Button('Examine') then
    local t, distance = GetClosestPlayer()
  if(distance ~= -1 and distance < 5) then
    if GetEntityModel(GetPlayerPed(-1)) == 1126154828 then exports['NRP-notify']:DoHudText('error',  "Your a Dog , How you plan on doing that?!")  else
     ProgressBar('Examining', 35)
     TaskStartScenarioInPlace(GetPlayerPed(-1), 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
     Citizen.Wait(5000)
   ClearPedTasks(GetPlayerPed(-1))
   TriggerServerEvent('ems:damage', GetPlayerServerId(t))
    end
    else
      exports['NRP-notify']:DoHudText('inform',  "No Player Near")
  end
   elseif WarMenu.ComboBox('Mechanic', {"Tow", "Unlock"}, currentItemIndex4, selectedItemIndex4, function(currentIndex4, selectedIndex4)
     currentItemIndex4 = currentIndex4
     selectedItemIndex4 = selectedIndex4
    end) then
     if currentItemIndex4 == 1 then
      TriggerEvent("knb:tow")
      exports['NRP-notify']:DoHudText('success', 'Vehicle Sent To The Impound')
   elseif currentItemIndex4 == 2 then
    local coords    = GetEntityCoords(GetPlayerPed(-1))
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
     end
   end
  end
  WarMenu.Display()
 end
end)

local isInVehicle = false

RegisterCommand('escort', function(source, args, rawCommand) 
  if not isInVehicle then
   local t, distance = GetClosestPlayer()
   if(distance ~= -1 and distance < 3) then 
    TriggerServerEvent('police:drag', GetPlayerServerId(t)) 
   else exports['NRP-notify']:DoHudText('inform',  "No Player Near") 
   end
  end
end)

RegisterCommand("boat", function()
  local b = ("predator")
  if DecorGetBool(GetPlayerPed(-1), "isOfficer") then
      if IsEntityInWater(GetPlayerPed(-1)) then 
          local boat = GetHashKey(b)
  
          RequestModel(boat)
          while not HasModelLoaded(boat) do
              RequestModel(boat)
              Citizen.Wait(0)
          end

          local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 8.0, 0.5))
          local vehicle = CreateVehicle(boat, x, y, z, 0.0, true, false)
          DecorSetInt(vehicle, "_Max_Fuel_Level", 100000)
          DecorSetInt(vehicle, "_Fuel_Level", 100000)
          SetEntityAsMissionEntity(vehicle, true, true)
          exports['NRP-notify']:DoHudText('success', 'You have taken out a Police Predator')
      else
          exports['NRP-notify']:DoHudText('error', 'You are not in water')
      end
  else 
      exports['NRP-notify']:DoHudText('error', 'You are not permitted to take out a boat')
  end

end)

Citizen.CreateThread(function()
 WarMenu.CreateLongMenu('Police_tfoolkit', 'Police Offduty')
  local currentItemIndex2 = 1
  local Vehicle = 1
 while true do
  Wait(5)
  if WarMenu.IsMenuOpened('Police_tfoolkit') then
   if WarMenu.Button('Escort') then
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then TriggerServerEvent('police:drag', GetPlayerServerId(t)) else exports['NRP-notify']:DoHudText('inform',  "No Player Near") end
   elseif WarMenu.ComboBox('Vehicle', {'Put In','Take Out'}, currentItemIndex2, Vehicle, function(currentIndex2)
    currentItemIndex2 = currentIndex2 Vehicle = currentIndex2
    end) then
    local t, distance = GetClosestPlayer()
    if Vehicle == 1 then if(distance ~= -1 and distance < 3) then TriggerServerEvent('police:vehiclein', GetPlayerServerId(t)) else exports['NRP-notify']:DoHudText('inform',  "No Player Near") end end
    if Vehicle == 2 then if(distance ~= -1 and distance < 5) then TriggerServerEvent('police:vehicleout', GetPlayerServerId(t)) else exports['NRP-notify']:DoHudText('inform',  "No Player Near") end end
   elseif WarMenu.Button('Weapon Search') then
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then TriggerServerEvent('police:targetCheckGuns', GetPlayerServerId(t)) else exports['NRP-notify']:DoHudText('inform',  "No Player Near") end
   end
  end
  if IsControlJustPressed(0, 167) and isInService == false and DecorGetBool(GetPlayerPed(-1), "isOfficer") then 
   WarMenu.OpenMenu('Police_tfoolkit') 
  end
 end
end)

Citizen.CreateThread(function()
 WarMenu.CreateLongMenu('recovery_toolkit', 'Recovery')
  local currentItemIndex2 = 1
  local Vehicle = 1
 while true do
  Wait(5)
  if WarMenu.IsMenuOpened('recovery_toolkit') then
   if WarMenu.Button('Handcuff') then
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then 
    if not IsPedCuffed(GetPlayerPed(t)) then 
      RequestAnimDict('mp_arrest_paired')
      while not HasAnimDictLoaded('mp_arrest_paired') do
       Citizen.Wait(0)
      end
      TaskPlayAnim(GetPlayerPed(-1), "mp_arrest_paired", "cop_p2_back_right", 8.0, -8, -1, 48, 0, 0, 0, 0)
      TriggerServerEvent('police:drag', GetPlayerServerId(t))
    end
    TriggerServerEvent('police:handcuff', GetPlayerServerId(t))
    if AnimationComplete(GetPlayerPed(-1), "mp_arrest_paired", "cop_p2_back_right", 0.89, 300) then
      ClearPedTasksImmediately(GetPlayerPed(-1))
    end
    else 
       exports['NRP-notify']:DoHudText('inform',  "No Player Near") 
    end
   elseif WarMenu.Button('Escort') then
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then TriggerServerEvent('police:drag', GetPlayerServerId(t)) else exports['NRP-notify']:DoHudText('inform',  "No Player Near") end
   elseif WarMenu.ComboBox('Vehicle', {'Put In','Take Out'}, currentItemIndex2, Vehicle, function(currentIndex2)
    currentItemIndex2 = currentIndex2 Vehicle = currentIndex2
    end) then
    local t, distance = GetClosestPlayer()
    if Vehicle == 1 then if(distance ~= -1 and distance < 3) then TriggerServerEvent('police:vehiclein', GetPlayerServerId(t)) else exports['NRP-notify']:DoHudText('inform',  "No Player Near") end end
    if Vehicle == 2 then if(distance ~= -1 and distance < 5) then TriggerServerEvent('police:vehicleout', GetPlayerServerId(t)) else exports['NRP-notify']:DoHudText('inform',  "No Player Near") end end
   elseif WarMenu.Button('Weapon Search') then
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then TriggerServerEvent('police:targetCheckGuns', GetPlayerServerId(t)) else exports['NRP-notify']:DoHudText('inform',  "No Player Near") end
   elseif WarMenu.Button('Revive') then
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 5) then
     TaskStartScenarioInPlace(GetPlayerPed(-1), 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
     Citizen.Wait(10000)
     ClearPedTasks(GetPlayerPed(-1))
     TriggerServerEvent('ems:revive', GetPlayerServerId(t))
     exports['NRP-notify']:DoHudText('success',  "Revive Complete")
    else
     exports['NRP-notify']:DoHudText('inform',  "No Player Near")
    end
   end
  end
  if DecorGetInt(GetPlayerPed(-1), "Job") == 19 and IsControlJustPressed(0, 167) then 
   WarMenu.OpenMenu('recovery_toolkit') 
  end
 end
end)

Citizen.CreateThread(function()
 WarMenu.CreateLongMenu('securty_toolkit', 'Security')
  local currentItemIndex2 = 1
  local Vehicle = 1
 while true do
  Wait(5)
  if WarMenu.IsMenuOpened('securty_toolkit') then
   if WarMenu.ComboBox('Vehicle', {'Put In','Take Out'}, currentItemIndex2, Vehicle, function(currentIndex2)
    currentItemIndex2 = currentIndex2 Vehicle = currentIndex2
    end) then
    local t, distance = GetClosestPlayer()
    if Vehicle == 1 then if(distance ~= -1 and distance < 3) then TriggerServerEvent('police:vehiclein', GetPlayerServerId(t)) else exports['NRP-notify']:DoHudText('inform',  "No Player Near") end end
    if Vehicle == 2 then if(distance ~= -1 and distance < 5) then TriggerServerEvent('police:vehicleout', GetPlayerServerId(t)) else exports['NRP-notify']:DoHudText('inform',  "No Player Near") end end
   elseif WarMenu.Button('Revive') then
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 5) then
     TaskStartScenarioInPlace(GetPlayerPed(-1), 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
     Citizen.Wait(10000)
     ClearPedTasks(GetPlayerPed(-1))
     TriggerServerEvent('ems:revive', GetPlayerServerId(t))
     exports['NRP-notify']:DoHudText('success',  "Revive Complete")
    else
     exports['NRP-notify']:DoHudText('inform',  "No Player Near")
    end
   end
  end
  if DecorGetInt(GetPlayerPed(-1), "Job") == 8 and IsControlJustPressed(0, 167) then 
   WarMenu.OpenMenu('securty_toolkit') 
  end
  -- Fugitive Recovery
  if DecorGetInt(GetPlayerPed(-1), "Job") == 29 and IsControlJustPressed(0, 167) then
   WarMenu.OpenMenu('securty_toolkit') 
  end
 end
end)

RegisterNetEvent('police:vehiclein')
AddEventHandler('police:vehiclein', function()
  ClearPedTasks(GetPlayerPed(-1))
  ClearPedTasksImmediately(GetPlayerPed(-1))
  local pos = GetEntityCoords(GetPlayerPed(-1))
  local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 20.0, 0.0)

  local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
  local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)

  if vehicleHandle ~= nil then
    if(IsVehicleSeatFree(vehicleHandle, 1)) then
      SetPedIntoVehicle(GetPlayerPed(-1), vehicleHandle, 1)
    elseif(IsVehicleSeatFree(vehicleHandle, 2)) then
      SetPedIntoVehicle(GetPlayerPed(-1), vehicleHandle, 2)
    end
  end
  
  IsDragged = false
end)

RegisterNetEvent('police:vehicleout')
AddEventHandler('police:vehicleout', function(t)
  local ped = GetPlayerPed(t)
  ClearPedTasksImmediately(ped)
  plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
  local xnew = plyPos.x+2
  local ynew = plyPos.y+2

  SetEntityCoords(GetPlayerPed(-1), xnew, ynew, plyPos.z)
end)

local cuffed = false
local dict = "mp_arresting"
local anim = "idle"
local flags = 49
local ped = PlayerPedId()
local changed = false
local prevMaleVariation = 0
local prevFemaleVariation = 0
local femaleHash = GetHashKey("mp_f_freemode_01")
local maleHash = GetHashKey("mp_m_freemode_01")

RegisterNetEvent('police:handcuff')
AddEventHandler('police:handcuff', function()
 RequestAnimDict("mp_arresting")
 RequestAnimDict('mp_arrest_paired')
 while not HasAnimDictLoaded("mp_arresting") or not HasAnimDictLoaded('mp_arrest_paired') do
  Citizen.Wait(0)
 end
 if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
  if cuffed then
   ClearPedTasks(PlayerPedId())
   SetEnableHandcuffs(PlayerPedId(), false)
   UncuffPed(PlayerPedId())
   if GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then SetPedComponentVariation(PlayerPedId(), 7, prevFemaleVariation, 0, 0) elseif GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") then SetPedComponentVariation(PlayerPedId(), 7, prevMaleVariation, 0, 0) end
  else
    TaskPlayAnim(GetPlayerPed(-1), "mp_arrest_paired", "crook_p2_back_right", 8.0, -8, -1, 48, 0, 0, 0, 0)
    Wait(3100)
    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "handcuff", 0.5)
    Wait(600)
    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "handcuff", 0.5)
   Wait(4000)
   if GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then prevFemaleVariation = GetPedDrawableVariation(PlayerPedId(), 7) SetPedComponentVariation(PlayerPedId(), 7, 25, 0, 0) elseif GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") then prevMaleVariation = GetPedDrawableVariation(PlayerPedId(), 7) SetPedComponentVariation(PlayerPedId(), 7, 41, 0, 0) end
   SetEnableHandcuffs(PlayerPedId(), true)
   TaskPlayAnim(PlayerPedId(), "mp_arresting", "idle", 8.0, -8, -1, 49, 0, 0, 0, 0)
  end
  cuffed = not cuffed
  changed = true
 end
end)

RegisterNetEvent('police:handcuff:toggle')
AddEventHandler('police:handcuff:toggle', function(status)
 RequestAnimDict("mp_arresting")
 RequestAnimDict('mp_arrest_paired')
 while not HasAnimDictLoaded("mp_arresting") or not HasAnimDictLoaded('mp_arrest_paired') do
  Citizen.Wait(0)
 end
 if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
  if not status then
   ClearPedTasks(PlayerPedId())
   SetEnableHandcuffs(PlayerPedId(), false)
   UncuffPed(PlayerPedId())
   if GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then SetPedComponentVariation(PlayerPedId(), 7, prevFemaleVariation, 0, 0) elseif GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") then SetPedComponentVariation(PlayerPedId(), 7, prevMaleVariation, 0, 0) end
   cuffed = false
  else
    TaskPlayAnim(GetPlayerPed(-1), "mp_arrest_paired", "crook_p2_back_right", 8.0, -8, -1, 48, 0, 0, 0, 0)
    Wait(3100)
    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "handcuff", 0.5)
    Wait(600)
    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "handcuff", 0.5)
   Wait(4000)
   if GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then prevFemaleVariation = GetPedDrawableVariation(PlayerPedId(), 7) SetPedComponentVariation(PlayerPedId(), 7, 25, 0, 0) elseif GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") then prevMaleVariation = GetPedDrawableVariation(PlayerPedId(), 7) SetPedComponentVariation(PlayerPedId(), 7, 41, 0, 0) end
   SetEnableHandcuffs(PlayerPedId(), true)
   TaskPlayAnim(PlayerPedId(), "mp_arresting", "idle", 8.0, -8, -1, 49, 0, 0, 0, 0)
   cuffed = true
  end
  changed = true
 end
end)

RegisterNetEvent('police:hardcuff')
AddEventHandler('police:hardcuff', function()
  if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
    ped = PlayerPedId()
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
      Citizen.Wait(0)
    end
    
    if hardcuffed then
      ClearPedTasks(ped)
      SetEnableHandcuffs(ped, false)
      FreezeEntityPosition(ped, false)
      UncuffPed(ped)
      if GetEntityModel(ped) == femaleHash then -- mp female
        SetPedComponentVariation(ped, 7, prevFemaleVariation, 0, 0)
      elseif GetEntityModel(ped) == maleHash then -- mp male
        SetPedComponentVariation(ped, 7, prevMaleVariation, 0, 0)
      end
    else
      if GetEntityModel(ped) == femaleHash then -- mp female
        prevFemaleVariation = GetPedDrawableVariation(ped, 7)
        SetPedComponentVariation(ped, 7, 25, 0, 0)
      
      elseif GetEntityModel(ped) == maleHash then -- mp male
        prevMaleVariation = GetPedDrawableVariation(ped, 7)
        SetPedComponentVariation(ped, 7, 41, 0, 0)
      end
      SetEnableHandcuffs(ped, true)
      FreezeEntityPosition(ped, true)
      TaskPlayAnim(ped, dict, anim, 8.0, -8, -1, flags, 0, 0, 0, 0)
    end
    
    hardcuffed = not hardcuffed
    
    changed = true
  end
end)

RegisterNetEvent('police:uncuff')
AddEventHandler('police:uncuff', function()
  if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
    ped = PlayerPedId()

    ClearPedTasks(ped)
    SetEnableHandcuffs(ped, false)
    UncuffPed(ped)
    FreezeEntityPosition(ped, false)

    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
      Citizen.Wait(0)
    end

    if cuffed then
      ClearPedTasks(ped)
      SetEnableHandcuffs(ped, false)
      UncuffPed(ped)
      if GetEntityModel(ped) == femaleHash then -- mp female
        SetPedComponentVariation(ped, 7, prevFemaleVariation, 0, 0)
      elseif GetEntityModel(ped) == maleHash then -- mp male
        SetPedComponentVariation(ped, 7, prevMaleVariation, 0, 0)
      end
    end
    cuffed = false
  end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        if not changed then
            ped = PlayerPedId()
            local IsCuffed = IsPedCuffed(ped) 
            
            if IsCuffed and not IsEntityPlayingAnim(PlayerPedId(), dict, anim, 3) then
                Citizen.Wait(500)
                TaskPlayAnim(ped, dict, anim, 8.0, -8, -1, flags, 0, 0, 0, 0)
            end
        
        else
            changed = false
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        ped = PlayerPedId()
        if cuffed then
          DisableControlAction(0, 23, true) -- INPUT_ENTER
          DisableControlAction(0, 182, true)
          DisableControlAction(0, 73, true)
          DisableControlAction(0, 37, true)
          DisablePlayerFiring(ped, true) --- testing xzurv 
          DisableControlAction(0, 69, true) -- INPUT_VEH_ATTACK
          DisableControlAction(0, 92, true) -- INPUT_VEH_PASSENGER_ATTACK
          DisableControlAction(0, 114, true) -- INPUT_VEH_FLY_ATTACK
          DisableControlAction(0, 140, true) -- INPUT_MELEE_ATTACK_LIGHT
          DisableControlAction(0, 141, true) -- INPUT_MELEE_ATTACK_HEAVY
          DisableControlAction(0, 142, true) -- INPUT_MELEE_ATTACK_ALTERNATE
          DisableControlAction(0, 257, true) -- INPUT_ATTACK2
          DisableControlAction(0, 263, true) -- INPUT_MELEE_ATTACK1
          DisableControlAction(0, 264, true) -- INPUT_MELEE_ATTACK2
          DisableControlAction(0, 24, true) -- INPUT_ATTACK
          DisableControlAction(0, 25, true) -- INPUT_AIM
          DisableControlAction(0, 23, true) -- INPUT_ENTER
          DisableControlAction(0, 75, true) -- INPUT_VEH_EXIT
          DisableControlAction(0, 288, true)
          DisableControlAction(0, 289, true)
          SetPedDropsWeapon(ped)
          if IsPedRunning(ped) then
           Wait(1000)
           if math.random(1,1000) > 750 then
            SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
            TaskPlayAnim(ped, dict, anim, 8.0, -8, -1, flags, 0, 0, 0, 0)
           end
          end
        end
        if hardcuffed then
            SetPedDropsWeapon(ped)
            DisableControlAction(0, 182, true)
            DisableControlAction(0, 23, true)
            DisableControlAction(0, 22, true)
            DisableControlAction(0, 30, true)
            DisableControlAction(0, 31, true)
            DisableControlAction(0, 37, true)
            DisablePlayerFiring(ped, true)
            DisableControlAction(0, 69, true) -- INPUT_VEH_ATTACK
            DisableControlAction(0, 92, true) -- INPUT_VEH_PASSENGER_ATTACK
            DisableControlAction(0, 114, true) -- INPUT_VEH_FLY_ATTACK
            DisableControlAction(0, 140, true) -- INPUT_MELEE_ATTACK_LIGHT
            DisableControlAction(0, 141, true) -- INPUT_MELEE_ATTACK_HEAVY
            DisableControlAction(0, 142, true) -- INPUT_MELEE_ATTACK_ALTERNATE
            DisableControlAction(0, 257, true) -- INPUT_ATTACK2
            DisableControlAction(0, 263, true) -- INPUT_MELEE_ATTACK1
            DisableControlAction(0, 264, true) -- INPUT_MELEE_ATTACK2
            DisableControlAction(0, 24, true) -- INPUT_ATTACK
            DisableControlAction(0, 25, true) -- INPUT_AIM
            DisableControlAction(0, 23, true) -- INPUT_ENTER
            DisableControlAction(0, 75, true) -- INPUT_VEH_EXIT
        end
    end
end)

local playerStillDragged = false
Citizen.CreateThread(function()
 while true do
  Wait(5)
  if IsDragged then
   local ped = GetPlayerPed(GetPlayerFromServerId(CopPed))
   local myped = GetPlayerPed(-1)
   AttachEntityToEntity(myped, ped, 4103, 11816, 0.48, 0.00, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
   playerStillDragged = true
  else
   if(playerStillDragged) then
    DetachEntity(GetPlayerPed(-1), true, false)
    playerStillDragged = false
   end
  end
 end
end)

RegisterNetEvent('police:drag')
AddEventHandler('police:drag', function(cop)
  if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
    IsDragged = not IsDragged
    CopPed = tonumber(cop)
  end
end)

RegisterNetEvent('police:panic')
AddEventHandler('police:panic', function(x,y,z)
 if DecorGetBool(GetPlayerPed(-1), "isOfficer") or DecorGetBool(GetPlayerPed(-1), "isParamedic") then
  local transG = 250
  local location = AddBlipForCoord(x,y,z)
  SetBlipSprite(location,  161)
  SetBlipScale(location , 1.5)
  SetBlipColour(location,  75)
  SetBlipAlpha(location,  transG)
  SetBlipAsShortRange(location,  1)
  PulseBlip(location)
  PlaySoundFrontend(-1, "HACKING_FAILURE", 0, 1);
  Wait(1000)
  PlaySoundFrontend(-1, "HACKING_FAILURE", 0, 1);
  Wait(1000)
  PlaySoundFrontend(-1, "HACKING_FAILURE", 0, 1);
  Wait(1000)
  PlaySoundFrontend(-1, "HACKING_FAILURE", 0, 1);
  Wait(1000)
  PlaySoundFrontend(-1, "HACKING_FAILURE", 0, 1);
  Wait(1000)
  PlaySoundFrontend(-1, "HACKING_FAILURE", 0, 1);
  Wait(1000)
  PlaySoundFrontend(-1, "HACKING_FAILURE", 0, 1);
  Wait(1000)
  PlaySoundFrontend(-1, "HACKING_FAILURE", 0, 1);
  Wait(1000)
  PlaySoundFrontend(-1, "HACKING_FAILURE", 0, 1);
  while transG ~= 0 do
    Wait(240 * 4)
    transG = transG - 1
    SetBlipAlpha(location,  transG)
    if transG == 0 then
      SetBlipSprite(location,  2)
      return
    end
  end
 end
end)

RegisterNetEvent('ss:panic')
AddEventHandler('ss:panic', function(x,y,z)
 if DecorGetBool(GetPlayerPed(-1), "isOfficer") or DecorGetBool(GetPlayerPed(-1), "isParamedic") or DecorGetInt(GetPlayerPed(-1), "Job") == 23 then
  exports['NRP-notify']:DoLongHudText('error', "A Government member has triggered thier panic button.")
  local transG = 250
  local location = AddBlipForCoord(x,y,z)
  SetBlipSprite(location,  161)
  SetBlipScale(location , 1.5)
  SetBlipColour(location,  75)
  SetBlipAlpha(location,  transG)
  SetBlipAsShortRange(location,  1)
  PulseBlip(location)
  PlaySoundFrontend(-1, "HACKING_FAILURE", 0, 1);
  Wait(1000)
  PlaySoundFrontend(-1, "HACKING_FAILURE", 0, 1);
  Wait(1000)
  PlaySoundFrontend(-1, "HACKING_FAILURE", 0, 1);
  Wait(1000)
  PlaySoundFrontend(-1, "HACKING_FAILURE", 0, 1);
  Wait(1000)
  PlaySoundFrontend(-1, "HACKING_FAILURE", 0, 1);
  Wait(1000)
  PlaySoundFrontend(-1, "HACKING_FAILURE", 0, 1);
  Wait(1000)
  PlaySoundFrontend(-1, "HACKING_FAILURE", 0, 1);
  Wait(1000)
  PlaySoundFrontend(-1, "HACKING_FAILURE", 0, 1);
  Wait(1000)
  PlaySoundFrontend(-1, "HACKING_FAILURE", 0, 1);
  while transG ~= 0 do
    Wait(240 * 4)
    transG = transG - 1
    SetBlipAlpha(location,  transG)
    if transG == 0 then
      SetBlipSprite(location,  2)
      return
    end
  end
 end
end)

RegisterNetEvent('police:11020')
AddEventHandler('police:11020', function(x,y,z)
 if DecorGetBool(GetPlayerPed(-1), "isOfficer") then
  local transG = 250
  local location = AddBlipForCoord(x,y,z)
  SetBlipSprite(location,  1)
  SetBlipScale(location , 1.2)
  SetBlipColour(location,  3)
  SetBlipAlpha(location,  transG)
  SetBlipAsShortRange(location,  1)
  PulseBlip(location)
  while transG ~= 0 do
    Wait(240 * 4)
    transG = transG - 1
    SetBlipAlpha(location,  transG)
    if transG == 0 then
      SetBlipSprite(location,  2)
   end
 end
end
end)

RegisterNetEvent('police:offnotification')
AddEventHandler('police:offnotification', function(x,y,z)
 if DecorGetBool(GetPlayerPed(-1), "isOfficer") then
  exports['NRP-notify']:DoHudText('inform', "An Officer Just Signed 10-42, 10-7")
  PlaySound(-1, 'GO', 'HUD_MINI_GAME_SOUNDSET', 0, 0, 1)
end
end)

RegisterNetEvent('police:ondutynotification')
AddEventHandler('police:ondutynotification', function(x,y,z, source)
 if DecorGetBool(GetPlayerPed(-1), "isOfficer") then
  exports['NRP-notify']:DoHudText('inform', "An Officer Just Signed 10-41, 10-8")
  PlaySound(-1, 'GO', 'HUD_MINI_GAME_SOUNDSET', 0, 0, 1)
end
end)

RegisterNetEvent('police:byebyeweapons')
AddEventHandler('police:byebyeweapons', function(target)
  local playerped = GetPlayerPed(-1)
  RemoveAllPedWeapons(playerped, true)
end)


----------------------------------------------------------------------------------------------------------
---------------------------- New Mission System ----------------------------------------------------------
----------------------------------------------------------------------------------------------------------
currentMissionBlip = nil 
availableMissions = {}
currentMissions = nil
MissionInformation = '~g~NO CALLS WAITING'
CopCallStatus = 0
activeCops = 0
availableCops = 0

RegisterNetEvent("police:notifyallCops")
AddEventHandler("police:notifyallCops",function(message)
 if isInService then
  PlaySoundFrontend(-1, "HACKING_SUCCESS", 0, 1);
  exports['NRP-notify']:DoLongHudText('error', 'Emergency Info: '..message)
  Wait(750)
  PlaySoundFrontend(-1, "HACKING_SUCCESS", 0, 1);
 end
end)

RegisterNetEvent("police:notifyClient")
AddEventHandler("police:notifyClient",function(message)
  exports['NRP-notify']:DoLongHudText('error', 'Emergency: '..message)
end)

function acceptMissionEmergency(data) 
    TriggerServerEvent('police:acceptMission', data.id)
end

function finishCurrentMissionEmergency()
    if currentMissions ~= nil then
        TriggerServerEvent('police:finishMission', currentMissions.id)
    end
    currentMissions = nil
    if currentMissionBlip ~= nil then
        RemoveBlip(currentMissionBlip)
    end
    WarMenu.OpenMenu('police_missions')
end

function updateMissionMenu() 
    local cmissions = {}
    for _,m in pairs(availableMissions) do 
        local data = {
            name = m.name,
            info = m.type,
            mission = m,
            f = acceptMissionEmergency
        }
        if #m.acceptBy ~= 0 then
            data.name = data.name .. ' (' .. #m.acceptBy ..' Unit) ('..currentMissions.id..')'
        end
        table.insert(cmissions, data)
    end

    if currentMissions ~= nil then
        table.insert(cmissions, {name = 'Finish Mission', f = finishCurrentMissionEmergency})
    end
    mission_list = cmissions
    if curMenu ~= nil then
        if curMenu == "missions_menu" then
            WarMenu.OpenMenu('police_missions')
        end
    end
end

RegisterNetEvent('police:acceptMission')
AddEventHandler('police:acceptMission',function(mission)
    currentMissions = mission
    SetNewWaypoint(mission.pos[1], mission.pos[2])
    currentMissionBlip = AddBlipForCoord(mission.pos[1], mission.pos[2], mission.pos[3])
    SetBlipSprite(currentMissionBlip, 58)
    SetBlipColour(currentMissionBlip, 5)
    SetBlipAsShortRange(currentMissionBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Mission In Progress')
    EndTextCommandSetBlipName(currentMissionBlip)
    SetBlipAsMissionCreatorBlip(currentMissionBlip, true)
end)

RegisterNetEvent('police:cancelMission')
AddEventHandler('police:cancelMission', function ()
    currentMissions = nil
    if currentMissionBlip ~= nil then
        RemoveBlip(currentMissionBlip)
    end
    if curMenu ~= nil then
        if curMenu == "missions_menu" then
            MissionMenu()
        end
    end
end)

RegisterNetEvent('police:changeMission')
AddEventHandler('police:changeMission', function (missions)
    if not isInService then
        return
    end 
    
    availableMissions = missions
    local MissionsOnHold = 0
    for _,m in pairs(availableMissions) do
        if #m.acceptBy == 0 then
            MissionsOnHold = MissionsOnHold + 1
        end
    end
    if MissionsOnHold == 0 then 
        MissionInformation = '~g~NO CALLS WAITING'
    else
        MissionInformation = '~w~'..MissionsOnHold..' ~r~CALL/S WAITING'
    end  
    updateMissionMenu()
end)

RegisterNetEvent('police:callStatus')
AddEventHandler('police:callStatus',function(status)
    CopCallStatus = status
end)

RegisterNetEvent('police:updateactiveCops')
AddEventHandler('police:updateactiveCops',function(activeCount, availableCount)
    activeCops = activeCount
    availableCops = availableCount
end)

function acceptMissionEmergency(data) 
    TriggerServerEvent('police:acceptMission', data.id)
end


RegisterNetEvent('police:cancelCall')
AddEventHandler('police:cancelCall',function(data)
    TriggerServerEvent('police:cancelCall')
end)

TriggerServerEvent('police:getactiveCops') 

function callpolice(reason)
    local pos = GetEntityCoords(GetPlayerPed(-1))
    TriggerServerEvent('police:Call', pos.x, pos.y, pos.z, reason)
end

RegisterNetEvent('police:callpoliceCustom')
AddEventHandler('police:callpoliceCustom',function()
    local reason = openTextInput()
    if reason ~= nil and reason ~= '' then
        callpolice(reason)
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

----------------------------------------------------------------------------------------------------------
------------------------------------------ Police Commands -----------------------------------------------
----------------------------------------------------------------------------------------------------------
local backupvehicle = false 

RegisterNetEvent('police:dutystatus')
AddEventHandler('police:dutystatus', function(stat)
  if stat == 1 then -- On Duty
   OnDuty()
   isInService = true   
  elseif stat == 0 then -- Off Duty
   OffDuty()
   isInService = false
  end
end)

RegisterNetEvent('police:spawnbackup')
AddEventHandler('police:spawnbackup', function()
 local pos = GetEntityCoords(GetPlayerPed(-1), false)
 if not backupvehicle then 
  vehiclehash = GetHashKey('police2')
  RequestModel(vehiclehash)
  Citizen.CreateThread(function() 
   while not HasModelLoaded(vehiclehash) do  
    Citizen.Wait(0)  
   end
   local spawned = CreateVehicle(vehiclehash, pos.x,pos.y,pos.z, 90, true, false)
   TaskWarpPedIntoVehicle(GetPlayerPed(-1), spawned, -1)
   SetVehicleEngineOn(spawned, true, true)
   SetVehicleIsConsideredByPlayer(spawned, true)
   exports["onyxLocksystem"]:givePlayerKeys(GetVehicleNumberPlateText(spawned))
  end)
  backupvehicle = false 
 end
end)

RegisterNetEvent('police:spawnboat')
AddEventHandler('police:spawnboat', function()
 local pos = GetEntityCoords(GetPlayerPed(-1), false)
 if not backupvehicle then 
  vehiclehash = GetHashKey('dinghy3')
  RequestModel(vehiclehash)
  Citizen.CreateThread(function() 
   while not HasModelLoaded(vehiclehash) do  
    Citizen.Wait(0)  
   end
   local spawned = CreateVehicle(vehiclehash, pos.x,pos.y,pos.z, 90, true, false)
   TaskWarpPedIntoVehicle(GetPlayerPed(-1), spawned, -1)
   SetVehicleEngineOn(spawned, true, true)
   SetVehicleIsConsideredByPlayer(spawned, true)
   DecorSetInt(spawned, "_Fuel_Level", 75000)
   exports["onyxLocksystem"]:givePlayerKeys(GetVehicleNumberPlateText(spawned))
  end)
  backupvehicle = false 
 end
end)

RegisterNetEvent('ems:spawnboat')
AddEventHandler('ems:spawnboat', function()
 local pos = GetEntityCoords(GetPlayerPed(-1), false)
 if not backupvehicle then 
  vehiclehash = GetHashKey('dinghy')
  RequestModel(vehiclehash)
  Citizen.CreateThread(function() 
   while not HasModelLoaded(vehiclehash) do  
    Citizen.Wait(0)  
   end
   local spawned = CreateVehicle(vehiclehash, pos.x,pos.y,pos.z, 90, true, false)
   TaskWarpPedIntoVehicle(GetPlayerPed(-1), spawned, -1)
   SetVehicleEngineOn(spawned, true, true)
   SetVehicleIsConsideredByPlayer(spawned, true)
   DecorSetInt(spawned, "_Fuel_Level", 75000)
   exports["onyxLocksystem"]:givePlayerKeys(GetVehicleNumberPlateText(spawned))
  end)
  backupvehicle = false 
 end
end)

RegisterNetEvent('ems:spawnbackup')
AddEventHandler('ems:spawnbackup', function()
 local pos = GetEntityCoords(GetPlayerPed(-1), false)
 if not backupvehicle then 
  vehiclehash = GetHashKey('ambulance')
  RequestModel(vehiclehash)
  Citizen.CreateThread(function() 
   while not HasModelLoaded(vehiclehash) do  
    Citizen.Wait(0)  
   end
   local spawned = CreateVehicle(vehiclehash, pos.x,pos.y,pos.z, 90, true, false)
   TaskWarpPedIntoVehicle(GetPlayerPed(-1), spawned, -1)
   SetVehicleMod(spawned,16, 20)
   SetVehicleEngineOn(spawned, true, true)
   SetVehicleIsConsideredByPlayer(spawned, true)
   SetVehicleLivery(spawned, vehlivery)
   DecorRegister("_Fuel_Level", 3);
  DecorRegister("_Max_Fuel_Level", 3);
  DecorSetInt(spawned, "_Max_Fuel_Level", 150000)
  DecorSetInt(spawned, "_Fuel_Level", 150000)
  exports["onyxLocksystem"]:givePlayerKeys(GetVehicleNumberPlateText(spawned))
   SetVehicleColours(spawned, 131, 131)
  end)
  backupvehicle = false 
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
  Citizen.Wait(0)
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

RegisterNetEvent('hud:updatepresence')
AddEventHandler('hud:updatepresence', function(copss, emss)
 currentCops = copss
 currentEMS = emss
end)


--===============Vehicle Extra==================--
local DoesExtraExist = false

function Applyextras()
  local vehicle = GetVehiclePedIsUsing(GetPlayerPed(-1))
   SetVehicleExtra(vehicle, 1)
   SetVehicleExtra(vehicle, 2)
   SetVehicleExtra(vehicle, 3)
   SetVehicleExtra(vehicle, 4)
   SetVehicleExtra(vehicle, 5)
   SetVehicleExtra(vehicle, 6)
   SetVehicleExtra(vehicle, 7)
   SetVehicleExtra(vehicle, 8)
   SetVehicleExtra(vehicle, 9)
   SetVehicleExtra(vehicle, 10)
   SetVehicleExtra(vehicle, 11)
   SetVehicleExtra(vehicle, 12)
   SetVehicleExtra(vehicle, 13)
   SetVehicleExtra(vehicle, 14)
end

function VehicleInFront()
 local pos = GetEntityCoords(GetPlayerPed(-1))
 local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 4.0, 0.0)
 local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
 local a, b, c, d, result = GetRaycastResult(rayHandle) 
 return result 
end

--------MegaPhone------
Citizen.CreateThread(function()
   WarMenu.CreateMenu('Megaphone', "Car Megaphone")
   while true do 
    Wait(5)
  if DecorGetBool(GetPlayerPed(-1), "isOfficer") and isInService and IsPedInAnyPoliceVehicle(GetPlayerPed(-1)) and IsControlJustPressed(311, 182) then 
    WarMenu.OpenMenu('Megaphone')
    end
    end 
end) 

  Citizen.CreateThread(function()
 while true do
  Wait(5)
  if WarMenu.IsMenuOpened('Megaphone') then
   if WarMenu.Button('Stop The Vehicle #1 (Angry)') then
    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 30.0, "stop_vehicle", 0.3)
    elseif WarMenu.Button('Stop The Vehicle #2 (Angry)') then
      TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 30.0, "stop_vehicle-2", 0.3)
    elseif WarMenu.Button('Get Out Of Here NOW') then
       TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 30.0, "get_out_of_here_now", 0.3)
    elseif WarMenu.Button('Move Along People') then
       TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 30.0, "move_along_people", 0.3)
    elseif WarMenu.Button('This is The LSPD') then
        TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 30.0, "this_is_the_lspd", 0.3)
    end
    end
end
   WarMenu.Display()
end)

------------Spikes
---------------------------------------------------------------------------
-- Important Variables --
---------------------------------------------------------------------------
local PoliceModels = {}
local SpawnedSpikes = {}
local spikemodel = "P_ld_stinger_s"
local nearSpikes = false
local spikesSpawned = false

---------------------------------------------------------------------------
-- Checking Distance To Spikestrips --
---------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        if IsPedInAnyVehicle(LocalPed(), false) then
            local vehicle = GetVehiclePedIsIn(LocalPed(), false)
            if GetPedInVehicleSeat(vehicle, -1) == LocalPed() then
                local vehiclePos = GetEntityCoords(vehicle, false)
                local spikes = GetClosestObjectOfType(vehiclePos.x, vehiclePos.y, vehiclePos.z, 80.0, GetHashKey(spikemodel), 1, 1, 1)
                local spikePos = GetEntityCoords(spikes, false)
                local distance = Vdist(vehiclePos.x, vehiclePos.y, vehiclePos.z, spikePos.x, spikePos.y, spikePos.z)

                if spikes ~= 0 then
                    nearSpikes = true
                else
                    nearSpikes = false
                end
            else
                nearSpikes = false
            end
        else
            nearSpikes = false
        end

        Citizen.Wait(0)
    end
end)

---------------------------------------------------------------------------
-- Tire Popping --
---------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        if nearSpikes then
            local tires = {
                {bone = "wheel_lf", index = 0},
                {bone = "wheel_rf", index = 1},
                {bone = "wheel_lm", index = 2},
                {bone = "wheel_rm", index = 3},
                {bone = "wheel_lr", index = 4},
                {bone = "wheel_rr", index = 5}
            }

            for a = 1, #tires do
                local vehicle = GetVehiclePedIsIn(LocalPed(), false)
                local tirePos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, tires[a].bone))
                local spike = GetClosestObjectOfType(tirePos.x, tirePos.y, tirePos.z, 15.0, GetHashKey(spikemodel), 1, 1, 1)
                local spikePos = GetEntityCoords(spike, false)
                local distance = Vdist(tirePos.x, tirePos.y, tirePos.z, spikePos.x, spikePos.y, spikePos.z)

                if distance < 1.8 then
                    if not IsVehicleTyreBurst(vehicle, tires[a].index, true) or IsVehicleTyreBurst(vehicle, tires[a].index, false) then
                        SetVehicleTyreBurst(vehicle, tires[a].index, false, 1000.0)
                    end
                end
            end
        end

        Citizen.Wait(0)
    end
end)

---------------------------------------------------------------------------
-- Keypresses Spikes Event --
---------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        if spikesSpawned then
            DisplayNotification("To remove the spikstrips press ~INPUT_CHARACTER_WHEEL~ + ~INPUT_PHONE~")
            if IsControlPressed(1, 19) and IsControlJustPressed(1, 27) then
                RemoveSpikes()
                spikesSpawned = false
            end
        end
        Citizen.Wait(0)
    end
end)

---------------------------------------------------------------------------
-- Spawn Spikes Event --
---------------------------------------------------------------------------
RegisterNetEvent("Spikes:SpawnSpikes")
AddEventHandler("Spikes:SpawnSpikes", function(config)
    if config.isRestricted then
        if CheckPedRestriction(LocalPed(), config.pedList) then
            CreateSpikes(config.amount)
        end
    else
        CreateSpikes(config.amount)
    end
end)

---------------------------------------------------------------------------
-- Delete Spikes Event --
---------------------------------------------------------------------------
RegisterNetEvent("Spikes:DeleteSpikes")
AddEventHandler("Spikes:DeleteSpikes", function(netid)
    Citizen.CreateThread(function()
        local spike = NetworkGetEntityFromNetworkId(netid)
        DeleteEntity(spike)
    end)
end)

---------------------------------------------------------------------------
-- Extra Functions --
---------------------------------------------------------------------------
function CreateSpikes(amount)
    local spawnCoords = GetOffsetFromEntityInWorldCoords(LocalPed(), 0.0, 2.0, 0.0)
    for a = 1, amount do
        local spike = CreateObject(GetHashKey(spikemodel), spawnCoords.x, spawnCoords.y, spawnCoords.z, 1, 1, 1)
        local netid = NetworkGetNetworkIdFromEntity(spike)
        SetNetworkIdExistsOnAllMachines(netid, true)
        SetNetworkIdCanMigrate(netid, false)
        SetEntityHeading(spike, GetEntityHeading(LocalPed()))
        PlaceObjectOnGroundProperly(spike)
        spawnCoords = GetOffsetFromEntityInWorldCoords(spike, 0.0, 4.0, 0.0)
        table.insert(SpawnedSpikes, netid)
    end
    spikesSpawned = true
end

Citizen.CreateThread(function()
    while true do
        local dev = false

        if dev then
            local plyOffset = GetOffsetFromEntityInWorldCoords(LocalPed(), 0.0, 2.0, 0.0)
            DrawMarker(0, plyOffset.x, plyOffset.y, plyOffset.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 2.0, 255, 0, 0, 255, 0, 0, 0, 0, 0, 0, 0)
            local spike = GetClosestObjectOfType(plyOffset.x, plyOffset.y, plyOffset.z, 80.0, GetHashKey(spikemodel), 1, 1, 1)
            Citizen.Trace("NETID: " .. ObjToNet(spike))
        end
        Citizen.Wait(0)
    end
end)

function RemoveSpikes()
    for a = 1, #SpawnedSpikes do
        TriggerServerEvent("Spikes:TriggerDeleteSpikes", SpawnedSpikes[a])
    end
    SpawnedSpikes = {}
end

function LocalPed()
    return GetPlayerPed(PlayerId())  
end

function CheckPedRestriction(ped, pedList)
    for a = 1, #pedList do
        if GetHashKey(pedList[a]) == GetEntityModel(ped) then
            return true
        end
    end
    return false
end

function DisplayNotification(string)
  SetTextComponentFormat("STRING")
  AddTextComponentString(string)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

-------------
local propslist = {}

Citizen.CreateThread(function()
 WarMenu.CreateLongMenu('police_props', 'Props')
 while true do 
  Wait(5)
  if DecorGetBool(GetPlayerPed(-1), "isOfficer") then
   if WarMenu.IsMenuOpened('police_props') then
    if WarMenu.Button('Cone') then
     ProgressBar('Placing Barrier', 15)
     Citizen.Wait(1500)
     SpawnProps('prop_mp_cone_02')
    elseif WarMenu.Button('Police Barrier') then
     ProgressBar('Placing Barrier', 15)
     Citizen.Wait(1500)
     SpawnProps('prop_barrier_work05')
    elseif WarMenu.Button('Work Barrier') then
     ProgressBar('Placing Barrier', 15)
     Citizen.Wait(1500)
     SpawnProps('prop_barrier_work04a')
    elseif WarMenu.Button('Work Barrier (Arrow)') then
     ProgressBar('Placing Barrier', 15)
     Citizen.Wait(1500)
     SpawnProps('prop_mp_arrow_barrier_01')
    elseif WarMenu.Button('Channelizer Drum') then
     ProgressBar('Placing Barrier', 15)
     Citizen.Wait(1500)
     SpawnProps('prop_barrier_wat_03a')
    elseif WarMenu.Button('Remove Last Prop') then
     ProgressBar('Removing Barrier', 15)
     Citizen.Wait(1500)
     RemoveLastProps()
    elseif WarMenu.Button('Remove All Props') then
     ProgressBar('Removing All Barriers', 15)
     Citizen.Wait(1500)
     RemoveAllProps()
    end
   end
  end
 end
end)

function SpawnProps(model)
 if not IsPedInAnyVehicle(PlayerPedId(), false) then
  if(#propslist < 4) then
   local prophash = GetHashKey(tostring(model))
   RequestModel(prophash)
   while not HasModelLoaded(prophash) do
    Citizen.Wait(0)
   end

   local offset = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.75, 0.0)
   local _, worldZ = GetGroundZFor_3dCoord(offset.x, offset.y, offset.z)
   local propsobj = CreateObjectNoOffset(prophash, offset.x, offset.y, worldZ, true, true, true)
   local heading = GetEntityHeading(PlayerPedId())

   SetEntityHeading(propsobj, heading)
   SetEntityAsMissionEntity(propsobj)
   FreezeEntityPosition(propsobj, true)
   SetModelAsNoLongerNeeded(prophash)

   propslist[#propslist+1] = ObjToNet(propsobj)
  end
 end
end

function RemoveLastProps()
 DeleteObject(NetToObj(propslist[#propslist]))
 propslist[#propslist] = nil
end

function RemoveAllProps()
 for i, props in pairs(propslist) do
  DeleteObject(NetToObj(props))
  propslist[i] = nil
 end
end

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
  for _, props in pairs(propslist) do
   local ox, oy, oz = table.unpack(GetEntityCoords(NetToObj(props), true))
   local cVeh = GetClosestVehicle(ox, oy, oz, 15.0, 0, 70)
   if(IsEntityAVehicle(cVeh)) then
    if IsEntityAtEntity(cVeh, NetToObj(props), 20.0, 20.0, 2.0, 0, 1, 0) then
     SetVehicleForwardSpeed(cVeh, 0)
    end
   end
  end 
 end
end)