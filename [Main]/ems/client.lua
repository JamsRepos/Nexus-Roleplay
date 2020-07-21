isInService = false
IsDead = false
mission_list = {}

-- Menus
Citizen.CreateThread(function()
 WarMenu.CreateLongMenu('ems_toolkit', 'Paramedic')
 WarMenu.CreateSubMenu('ems_garage', 'ems_toolkit', 'ems_garage')
 WarMenu.CreateSubMenu('ems_missions', 'ems_toolkit', 'ems_missions')
 local currentvehicle = 1
 local selectedvehicle = 1
 local currentmechanic = 1 
 local selectedmechanic = 1 
 local currentOption = 1
 local selectedOption = 1
 while true do 
  Wait(2)
  if DecorGetBool(GetPlayerPed(-1), "isParamedic") then
   if isInService then if not IsPedInAnyVehicle(GetPlayerPed(-1)) then drawUI(0.514, 1.375, 1.0, 1.0, 0.45, MissionInformation, 89, 194, 255, 255, false) else drawUI(0.514, 1.275, 1.0, 1.0, 0.45, MissionInformation, 89, 194, 255, 255, false) end end
   -- Main Menu
   if WarMenu.IsMenuOpened('ems_toolkit') then
    if WarMenu.ComboBox('Revive', {"Player", "NPC"}, currentOption, selectedOption, function(option)
      currentOption = option selectedOption = option
     end) then
     if selectedOption == 1 then
      local t, distance = GetClosestPlayer()
      if(distance ~= -1 and distance < 3) then 
       ProgressBar('Reviving', 55)
       TaskStartScenarioInPlace(GetPlayerPed(-1), 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
       Citizen.Wait(13000)
       ClearPedTasks(GetPlayerPed(-1))
       TriggerServerEvent('ems:revive', GetPlayerServerId(t))
      else
       exports['NRP-notify']:DoHudText('error', 'No Player Near')
      end
     elseif selectedOption == 2 then
      local player = GetPlayerPed(-1)
      local coords = GetEntityCoords(player)
      local closestPed = GetClosestPed()
      if IsPedDeadOrDying(closestPed) then
       local maxHealth = GetPedMaxHealth(closestPed)
       SetEntityHealth(closestPed, maxHealth)
       ClonePed(closestPed, GetEntityHeading(GetPlayerPed(-1)), 1)
       DeletePed(closestPed)
       local newPed = GetClosestPed()
       SetEntityCoords(newPed, coords.x, coords.y, coords.z+1)
       TaskReactAndFleePed(newPed, GetPlayerPed(-1))
      end
    elseif WarMenu.Button('Examine') then 
     local t, distance = GetClosestPlayer()
     if(distance ~= -1 and distance < 3) then 
      ProgressBar('Examining', 35)
      TaskStartScenarioInPlace(GetPlayerPed(-1), 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
      Citizen.Wait(5000)
      ClearPedTasks(GetPlayerPed(-1))
      TriggerServerEvent('ems:damage', GetPlayerServerId(t))
     else
      exports['NRP-notify']:DoHudText('error', 'No Player Near')
     end
    end 
    elseif WarMenu.Button('Escort') then
     local t, distance = GetClosestPlayer() 
     if(distance ~= -1 and distance < 3) then 
      TriggerServerEvent('police:drag', GetPlayerServerId(t)) 
     else 
      exports['NRP-notify']:DoHudText('error', 'No Player Near')
     end
    elseif WarMenu.Button('Panic') then
     local pos = GetEntityCoords(GetPlayerPed(-1))
     TriggerServerEvent('ems:panic', pos.x, pos.y, pos.z)
    elseif WarMenu.ComboBox('Vehicle', {"Put In", "Take Out"}, currentvehicle, selectedvehicle, function(vehicle)
     currentvehicle = vehicle selectedvehicle = vehicle
    end) then
     local t, distance = GetClosestPlayer()
     if(distance ~= -1 and distance < 3) then  
      if selectedvehicle == 2 then  
       TriggerServerEvent('police:vehicleout', GetPlayerServerId(t)) 
      elseif selectedvehicle == 1 then
       TriggerServerEvent('police:vehiclein', GetPlayerServerId(t)) 
      end
     else 
      exports['NRP-notify']:DoHudText('error', 'No Player Near')
     end
         elseif WarMenu.Button('Examine') then
    local t, distance = GetClosestPlayer()
  if(distance ~= -1 and distance < 3) then 
     ProgressBar('Examining', 35)
     TaskStartScenarioInPlace(GetPlayerPed(-1), 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
     Citizen.Wait(5000)
   ClearPedTasks(GetPlayerPed(-1))
   TriggerServerEvent('ems:damage', GetPlayerServerId(t))
    else
   exports['NRP-notify']:DoHudText('error', 'No Player Near')
  end
    --[[elseif WarMenu.ComboBox('Mechanic', {"Repair", "Impound", "Unlock", "Clean"}, currentmechanic, selectedmechanic, function(mechanic)
     currentmechanic = mechanic 
     selectedmechanic = mechanic
    end) then
    if selectedmechanic == 1 then
     local coords = GetEntityCoords(GetPlayerPed(-1))
     if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
      local vehicle = nil
      if IsPedInAnyVehicle(GetPlayerPed(-1), false) then vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false) else vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71) end
      if DoesEntityExist(vehicle) then
       ProgressBar('Repairing', 55)
       TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_BUM_BIN", 0, true)
       Citizen.Wait(8000)
       ClearPedTasks(GetPlayerPed(-1))
       TriggerEvent('vehice:repair', false, vehicle)
      end
     end
    elseif selectedmechanic == 2 then
     if IsPedInAnyVehicle(GetPlayerPed(-1)) then
      local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
      SetEntityAsMissionEntity(veh,  false,  true)
      DeleteVehicle(veh)
      exports['NRP-notify']:DoHudText('inform', 'Vehicle Sent To The Impound')
     else
      local coords = GetEntityCoords(GetPlayerPed(-1))
      local veh = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
      SetEntityAsMissionEntity(veh,  false,  true)
      DeleteVehicle(veh)
      exports['NRP-notify']:DoHudText('inform', 'Vehicle Sent To The Impound')
     end
    elseif selectedmechanic == 3 then
     local coords    = GetEntityCoords(GetPlayerPed(-1))
     if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
      local vehicle = nil
      if IsPedInAnyVehicle(playerPed, false) then vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false) else vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71) end
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
    elseif selectedmechanic == 4 then
     local coords    = GetEntityCoords(GetPlayerPed(-1))
     if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
      local vehicle = nil
      if IsPedInAnyVehicle(GetPlayerPed(-1), false) then vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false) else vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71) end
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
    end]]--
    elseif WarMenu.MenuButton('Missions', 'ems_missions') then
    end
    WarMenu.Display()
   -- Garage Menu
   elseif WarMenu.IsMenuOpened('ems_garage') then
    for _,v in pairs(vehicles) do
     if WarMenu.Button(v.name, v.rank) then
      SpawnVehicle(v.vehicle)
      WarMenu.CloseMenu()
     end 
    end
    WarMenu.Display()
   -- Mission Menu
   elseif WarMenu.IsMenuOpened('ems_missions') then
    for i,v in pairs(mission_list) do
     if v.name ~= "Finish the mission" then
      if WarMenu.Button(v.name) then
       v.f(v.mission)
       exports['NRP-notify']:DoHudText('inform', 'Call Information: '..v.info)
      end
     else
      if WarMenu.Button(v.name) then
       v.f()
      end
     end 
    end
    WarMenu.Display()
   end
  end
 end
end)

function GetClosestPed()
  local closestPed = 0

  for ped in EnumeratePeds() do
      local distanceCheck = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(ped), true)
      if distanceCheck <= 5.0 then
          closestPed = ped
          break
      end
  end

  return closestPed
end

-- Blips And Locations
Citizen.CreateThread(function()
 while true do
  Wait(2)
  -- Duty Blip
  if DecorGetBool(GetPlayerPed(-1), "isParamedic") then
   for k,v in pairs(duty) do
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 50) then
     DrawMarker(27, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, 1.2,1.2,0.5, 255, 255, 0, 100, 0, 0, 2, 0, 0, 0, 0)
     if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 2.2) then
      if isInService then
       drawTxt('~m~Press ~g~E~m~ To Go Off Duty')
       if IsControlJustPressed(0, 38) then
        OffDuty()
        isInService = false
       end
      else
       drawTxt('~m~Press ~g~E~m~ To Go On Duty')
       if IsControlJustPressed(0, 38) then
        OnDuty()
        isInService = true
       end
      end
     end
    end
   end

   if isInService then
    for k,v in pairs(garage) do
     if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 50) then
      DrawMarker(27, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, 1.5,1.5,0.5, 255, 255, 0, 100, 0, 0, 2, 0, 0, 0, 0)
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 4.0) then
       drawTxt('~g~[E]~w~ Garage')
       if IsControlJustPressed(0, 38) then
        if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
         local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1))
         SetEntityAsMissionEntity(vehicle, true, true)
         Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
        else
         currentgarage = {x=v.x, y=v.y, z=v.z}
         WarMenu.OpenMenu('ems_garage')
        end
       end
      end
     end

     for k,v in pairs(medicalcabinet) do
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 50) then
        if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 1.5) then
        DrawText3Ds(v.x, v.y, v.z+0.95,'~g~[E]~w~ to access the medical cabinet')
        if IsControlJustPressed(0, 38) then
          TriggerServerEvent('medical:getInventory')
        end
        end
      end
     end

    end

    if isInService and IsControlJustPressed(0, 167) or isInService and IsDisabledControlJustReleased(0, 167) then 
     WarMenu.OpenMenu('ems_toolkit') 
    end
   end
  end
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

RegisterNetEvent('ems:revive')
AddEventHandler('ems:revive', function()
 IsDead = false
 local ped = GetPlayerPed(-1)
 SetPlayerInvincible(ped, false)
 NetworkResurrectLocalPlayer(GetEntityCoords(GetPlayerPed(-1)), true, true, false)
 SetEntityHealth(ped, 200)
 ResetPedMovementClipset(GetPlayerPed(-1), true)
 Citizen.CreateThread(function()
  RequestAnimSet("move_m@injured")
  while not HasAnimSetLoaded("move_m@injured") do Citizen.Wait(0) end
  SetPedMovementClipset(GetPlayerPed(-1), "move_m@injured", true)
  TriggerEvent('NRP-hospital:client:RemoveBleed')
  TriggerEvent('NRP-hospital:client:ResetLimbs')
  TriggerServerEvent('core:playerRevived')
 end)
end)

RegisterNetEvent('ems:heal')
AddEventHandler('ems:heal', function()
 exports['NRP-notify']:DoHudText('inform', 'You Have Been Healed')
 SetEntityHealth(GetPlayerPed(-1), 200)
 StopAllScreenEffects()
 TriggerEvent('NRP-hospital:client:RemoveBleed')
 TriggerEvent('NRP-hospital:client:ResetLimbs')
 ClearPedBloodDamage(GetPlayerPed(-1))
 --ResetPedMovementClipset(GetPlayerPed(-1), true)
 IsDead = false
 SendNUIMessage({dead = false})
end)

function Respawn()
  Citizen.CreateThread(function()
    local shortestDistance = 100000
    local closestHospital = {}
    for _,v in pairs(hospitals) do
      local currentDistance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true)
      if currentDistance < shortestDistance then
        shortestDistance = currentDistance
        closestHospital["x"] = v.x
        closestHospital["y"] = v.y
        closestHospital["z"] = v.z
      end
    end

    NetworkResurrectLocalPlayer(closestHospital["x"], closestHospital["y"], closestHospital["z"], true, true, false)
    SetEntityHealth(GetPlayerPed(-1), 200)
    ClearPedBloodDamage(GetPlayerPed(-1))
    ResetPedMovementClipset(GetPlayerPed(-1), true)
    SetPlayerInvincible(GetPlayerPed(-1), false)
    IsDead = false
    Citizen.Wait(1000)
    SendNUIMessage({dead = false})
    TriggerEvent('ems:revive')
    local rctruck, gunkit = false
    if exports['core']:GetItemQuantity(134) >= 1 then rctruck = true end
    if exports['core']:GetItemQuantity(135) >= 1 then gunkit = true end
    if ems > 0 or cops > 0 then
      TriggerServerEvent('medical:wipeInventory', rctruck, gunkit)
    end
  end)
end

RegisterNetEvent('medical:giveWhitelisted')
AddEventHandler('medical:giveWhitelisted', function(rctruck, gunkit)
  print("giving back whitelisted items")
  if rctruck then TriggerEvent("inventory:addQty", 134, 1) end
  if gunkit then TriggerEvent("inventory:addQty", 135, 1) end
end)

-- String string
function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

Citizen.CreateThread(function()
  while true do
   Citizen.Wait(0)
   local health = GetEntityHealth(GetPlayerPed(-1))
   if not IsDead then
    if health <= 50 then
     DoScreenFadeOut(0)
     Wait(5000)
     DoScreenFadeIn(5000)
     IsDead = true
    end
   end
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(100)
    if IsDead then
      if not IsPedRagdoll(GetPlayerPed(-1)) then
        SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
      else
        ResetPedRagdollTimer(GetPlayerPed(-1))
      end
      SetEntityHealth(GetPlayerPed(-1), 70)
    end
  end
end)

local timer = 5 * 60 * 1000

Citizen.CreateThread(function()
  while true do
    Wait(0)
    if IsDead then
      while timer > 0 and IsDead do
        raw_seconds = timer/1000
        raw_minutes = raw_seconds/60
        minutes = stringsplit(raw_minutes, ".")[1]
        seconds = stringsplit(raw_seconds-(minutes*60), ".")[1]
        drawTxt("~g~Use your phone to call for an Ambulance or wait " .. minutes .. " minute(s) and " .. seconds .. " second(s) to take an airlift.")
        timer = timer - 15
        Citizen.Wait(0)
      end

      while timer <= 0 and IsDead do
        drawTxt("~m~Press ~g~R ~m~ to take an airlift.")
        Citizen.Wait(0)
        if IsControlPressed(0, 80) then
          SetEntityHealth(GetPlayerPed(-1), 200)
          IsDead = false
          Respawn()
        end
      end
    end
  end
end)

RegisterNetEvent('ems:count')
AddEventHandler('ems:count', function(cops, ems)
 if not IsDead then
  if ems == 0 and cops == 0 then
   timer = 5 * 60 * 1000
  else
   timer = 10 * 60 * 1000
  end
 end
end)

----------------------------------------------------------------------------------------------------------
---------------------------- New Mission System ----------------------------------------------------------
----------------------------------------------------------------------------------------------------------

currentMissionBlip = nil 
availableMissions = {}
currentMissions = nil
MissionInformation = '~g~NO CALLS WAITING'
MedicCallStatus = 0
activeMedics = 0
availableMedics = 0


RegisterNetEvent("paramedic:notifyallMedics")
AddEventHandler("paramedic:notifyallMedics",function(message)
    if isInService then
        exports['NRP-notify']:DoHudText('inform', 'Emergency Info:'..message)
    end
end)

RegisterNetEvent("paramedic:notifyClient")
AddEventHandler("paramedic:notifyClient",function(message)
  PlaySoundFrontend(-1, "HACKING_SUCCESS", 0, 1);
    exports['NRP-notify']:DoHudText('inform', 'Emergency: '..message)
    Wait(750)
    PlaySoundFrontend(-1, "HACKING_SUCCESS", 0, 1);
end)

function acceptMissionEmergency(data) 
    TriggerServerEvent('paramedic:acceptMission', data.id)
end

function finishCurrentMissionEmergency()
    if currentMissions ~= nil then
        TriggerServerEvent('paramedic:finishMission', currentMissions.id)
    end
    currentMissions = nil
    if currentMissionBlip ~= nil then
        RemoveBlip(currentMissionBlip)
    end
    WarMenu.OpenMenu('ems_missions')
end

function updateMissionMenu() 
    local cmissions = {}
    for k,v in pairs(availableMissions) do
        Citizen.Trace('==>' .. k)
    end
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
        table.insert(cmissions, {name = 'Finish the mission', f = finishCurrentMissionEmergency})
    end
    mission_list = cmissions
    if curMenu ~= nil then
        if curMenu == "missions_menu" then
            WarMenu.OpenMenu('ems_missions')
        end
    end
end

function callAmbulance(reason)
    local pos = GetEntityCoords(GetPlayerPed(-1))
    TriggerServerEvent('paramedic:Call', pos.x, pos.y, pos.z, reason)
end

function drawTxt(text)
  SetTextFont(0)
  SetTextProportional(0)
  SetTextScale(0.32, 0.32)
  SetTextColour(0, 255, 255, 255)
  SetTextDropShadow(0, 0, 0, 0, 255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextCentre(1)
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(0.5, 0.95)
end

RegisterNetEvent('paramedic:acceptMission')
AddEventHandler('paramedic:acceptMission',function(mission)
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

RegisterNetEvent('paramedic:cancelMission')
AddEventHandler('paramedic:cancelMission', function ()
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

RegisterNetEvent('paramedic:changeMission')
AddEventHandler('paramedic:changeMission', function (missions)
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

RegisterNetEvent('paramedic:callAmbulanceCustom')
AddEventHandler('paramedic:callAmbulanceCustom',function()
    local reason = openTextInput()
    if reason ~= nil and reason ~= '' then
        callAmbulance(reason)
    end
end)

RegisterNetEvent('paramedic:callStatus')
AddEventHandler('paramedic:callStatus',function(status)
    MedicCallStatus = status
end)

RegisterNetEvent('paramedic:updateactiveMedics')
AddEventHandler('paramedic:updateactiveMedics',function(activeCount, availableCount)
    activeMedics = activeCount
    availableMedics = availableCount
end)

RegisterNetEvent('paramedic:cancelCall')
AddEventHandler('paramedic:cancelCall',function(data)
    TriggerServerEvent('paramedic:cancelCall')
end)

TriggerServerEvent('paramedic:getactiveMedics') 

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

function dht(message)
    Citizen.CreateThread(function()
        Wait(10)
        SetNotificationTextEntry("STRING")
        AddTextComponentString(message)
        DrawNotification(false, false)
    end)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if DecorGetBool(GetPlayerPed(-1), "isParamedic") then
            if(isInService) then
                if currentMissions ~= nil then
                    if currentMissionBlip ~= nil then
                        RemoveBlip(currentMissionBlip)
                    end
                    local patient = GetPlayerPed(GetPlayerFromServerId(currentMissions.id))
                    local pos = {x=currentMissions.pos[1],y=currentMissions.pos[2],z=currentMissions.pos[3]}

                    if patient ~= nil and patient ~= 0 and patient ~= GetPlayerPed(-1) then
                        pos = GetEntityCoords(patient)
                    end

                    local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), pos.x, pos.y, pos.z, false)

                    if distance < 500.0 then
                     DrawMarker(1, pos.x, pos.y, pos.z-5, 0, 0, 0, 0, 0, 0, 2.5, 2.5, 255.0, 0, 155, 255, 64, 0, 0, 0, 0)
                    end
                    if distance < 4.0 then
                      drawTxt('~m~Press ~g~E ~m~To Revive Player')
                      if IsControlJustPressed(1, 38) then
                          TaskStartScenarioInPlace(GetPlayerPed(-1), 'CODE_HUMAN_MEDIC_KNEEL', 0, true)
                          Citizen.Wait(15000)
                          ClearPedTasksImmediately(GetPlayerPed(-1))
                          TriggerServerEvent("ems:revive", currentMissions.id)
                          finishCurrentMissionEmergency()
                      else
                       if distance < 2.0 then finishCurrentMissionEmergency() end
                        end
                    end
                else
                    if currentMissionBlip ~= nil then
                        RemoveBlip(currentMissionBlip)
                    end
                end
            end
        end
    end
end)

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

RegisterNetEvent('ems:panic')
AddEventHandler('ems:panic', function(x,y,z)
 if DecorGetBool(GetPlayerPed(-1), "isOfficer") then
  exports['NRP-notify']:DoHudText('inform', "EMT In Distress. All Availble Units Respond Code 3.")
  local transG = 250
  local location = AddBlipForCoord(x,y,z)
  SetBlipSprite(location,  161)
  SetBlipScale(location , 1.4)
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

--===========================================================================================================================--

local inBed = false
local currentBed = {}

local beds = {
  [1] = {x = 360.469, y = -587.190, z = 44.016, heading = 334.987, offset = 0.95},
  [2] = {x = 356.850, y = -585.744, z = 44.106, heading = 334.0, offset = 0.90},
  [3] = {x = 353.121, y = -584.824, z = 44.105, heading = 334.0, offset = 0.90},
  [4] = {x = 349.747, y = -583.738, z = 44.016, heading = 334.0, offset = 0.95},
  [5] = {x = 346.836, y = -590.404, z = 44.106, heading = 167.0, offset = 0.90},
  [6] = {x = 350.891, y = -591.619, z = 44.106, heading = 167.0, offset = 0.90},
  [7] = {x = 354.216, y = -592.588, z = 44.106, heading = 167.0, offset = 0.90},
  [8] = {x = 357.472, y = -594.232, z = 44.106, heading = 167.0, offset = 0.90},
  [9] = {x = 344.767, y = -580.979, z = 44.016, heading = 250.0, offset = 0.95},
  [10] = {x = 333.770, y = -578.164, z = 44.009, heading = 250.0, offset = 0.95},
  [11] = {x = 326.960, y = -576.308, z = 44.022, heading = 334.0, offset = 0.95},
  [12] = {x = 323.678, y = -575.295, z = 44.022, heading = 334.0, offset = 0.95},

}

RegisterCommand("bed", function(source, args, rawCommand)
  for k,v in pairs(beds) do
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 1.8) and not inBed then
    DoScreenFadeOut(500)
    Wait(600)
    TriggerEvent('police:uncuff')
    FreezeEntityPosition(GetPlayerPed(-1), true)
    SetEntityCoords(GetPlayerPed(-1), v.x, v.y, v.z-v.offset)
    SetEntityHeading(GetPlayerPed(-1), v.heading)
    Wait(100)
    TaskStartScenarioInPlace(GetPlayerPed(-1), 'WORLD_HUMAN_SUNBATHE_BACK', looped2, true)  
    Wait(5000)
    DoScreenFadeIn(500)
    inBed = true
    currentBed = v
   end
  end
 end)

 
 Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    if inBed then
     if IsControlJustPressed(0, 38) then
      DoScreenFadeOut(500)
      Wait(600)
      ClearPedTasksImmediately(GetPlayerPed(-1))
      SetEntityCoords(GetPlayerPed(-1), currentBed.x+1, currentBed.y, currentBed.z-1)
      FreezeEntityPosition(GetPlayerPed(-1), false)
      SetEntityHealth(GetPlayerPed(-1), 200)
      ResetPedMovementClipset(GetPlayerPed(-1), 0)
      ClearPedBloodDamage(GetPlayerPed(-1))
      Wait(1600)
      DoScreenFadeIn(500)
      inBed = false
      currentBed = {}
     end
    end
  end
end)

--===========================================================================================================================--

local drugs = {
  [1] = {name = 'Antibiotics', id = '43', amount = '1'},
  [2] = {name = 'Addiction Relief', id = '58', amount = '24'},
  [3] = {name = 'General Anastetic', id = '57', amount = '1'},
  [4] = {name = 'Morphine Injection', id = '102', amount = '1'},
  [5] = {name = 'Condom', id = '60', amount = '1'},
  [6] = {name = 'Anti Inflammatory Drug', id = '61', amount = '1'},
  [7] = {name = 'Bandage', price = '0', amount =  '1', id = '10'},
  [8] = {name = 'Medkit', price = '0', amount = '1', id = '9'},
  [9] = {name = 'Cough Medicine', price = '0', amount = '1', id = '44'},
}

local drug_locations = {
  {x = 342.442, y = -586.236, z = 43.315},
}

RegisterNetEvent('illness:generalAnasteticGiver')
AddEventHandler('illness:generalAnasteticGiver', function()
 local t, distance = GetClosestPlayer()
 if(distance ~= -1 and distance < 3 and DecorGetBool(GetPlayerPed(-1), "isParamedic")) then 
  TriggerServerEvent('ems:administerDrug', GetPlayerServerId(t), 'anastetic') 
  ExecuteCommand('me sticks needle into vein and slowly injects the contents')
 else exports['NRP-notify']:DoHudText('inform',  "No Player Near") end
end)

RegisterNetEvent('ems:giveMorphine')
AddEventHandler('ems:giveMorphine', function()
 local t, distance = GetClosestPlayer()
 if(distance ~= -1 and distance < 5 and DecorGetBool(GetPlayerPed(-1), "isParamedic")) then 
  TriggerServerEvent('ems:administerDDrug', GetPlayerServerId(t), 'morphine') 
  ExecuteCommand('me sticks needle into vein and slowly injects 10mg of Morphine')
 else exports['NRP-notify']:DoHudText('inform',  "No Player Near") end
end)

local inAnastetic = false 

RegisterNetEvent('ems:drug:anastetic')
AddEventHandler('ems:drug:anastetic', function()
 if not inAnastetic then
  TriggerEvent('chatMessage', "^5You feel the needle peirce your skin and instantly start to feel drowsy")
  DoScreenFadeOut(5000)
  Wait(5000)
  ExecuteCommand('me falls unconscious')
  inAnastetic = true
 else
  TriggerEvent('chatMessage', "^5You begin to wake up from the operation feeling tired and aching but will survive.")
  DoScreenFadeIn(5000)
  inAnastetic = false
 end
end)

RegisterNetEvent('ems:drug:morphine')
AddEventHandler('ems:drug:morphine', function()
 TriggerEvent('chatMessage', "^5You feel the needle peirce your skin and you can no longer feel your pain.")
 DoScreenFadeOut(3000)
 Wait(3000)
 SetTimecycleModifier("spectator5")
 SetPedMotionBlur(GetPlayerPed(-1), true)
 DoScreenFadeIn(3000)
 Wait(300000)
 TriggerEvent('chatMessage', "^5The effects of the morphine begin to fade away.")
 DoScreenFadeOut(3000)
 Wait(3000)
 ClearTimecycleModifier()
 DoScreenFadeIn(3000)
end)

Citizen.CreateThread(function()
  WarMenu.CreateLongMenu('medicine', 'Medicine')
 while true do
  Wait(0)
  for k,v in pairs(drug_locations) do
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 15) and DecorGetInt(GetPlayerPed(-1), "Faction") == 5 then
     DrawMarker(20, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, 0.8,0.8,0.5, 255, 255, 0, 100, 0, 0, 2, 0, 0, 0, 0)
     if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 1.0) then
      API_DrawTxt('~m~Press ~g~E~m~ To Access Medicine Cupboard')
      if IsControlJustPressed(0, 38) then
        WarMenu.OpenMenu('medicine')
      end
     end
    end
   end
   if WarMenu.IsMenuOpened('medicine') then
    for _,v in pairs(drugs) do
     if WarMenu.Button(v.name) then
       TriggerServerEvent('ems:purchase', v.name, 0, v.amount, v.id)
     end 
    end
    WarMenu.Display()
   end
 end
end)


--===========================================================================================================================--

    Citizen.CreateThread(function()
    while true do
      Citizen.Wait(1)
     if DecorGetBool(GetPlayerPed(-1), "isParamedic") then
     if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 3823.225, 4442.610, 2.807, true) < 50) then
      DrawMarker(35, 3823.225, 4442.610, 2.807+0.95, 0, 0, 0, 0, 0, 0, 0.5,1.1,0.5, 255, 255, 0, 100, 0, 0, 2, 0, 0, 0, 0)
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 3823.225, 4442.610, 2.807, true) < 1.5) then
       drawTxt('~m~Press ~g~E~m~ To Spawn Boat')
       if IsControlJustPressed(0, 38) then
         API_CreateVehicle('emsboat', 3867.410, 4445.865, 2.807)
         end
        end
       end
      end
     end
    end)

Citizen.CreateThread(function()
    while true do
      Citizen.Wait(1)
     if DecorGetBool(GetPlayerPed(-1), "isParamedic") then
     if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -806.866, -1497.097, 1.595, true) < 50) then
      DrawMarker(35, -806.866, -1497.097, 1.595+0.95, 0, 0, 0, 0, 0, 0, 0.5,1.1,0.5, 255, 255, 0, 100, 0, 0, 2, 0, 0, 0, 0)
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -806.866, -1497.097, 1.595, true) < 1.5) then
       drawTxt('~m~Press ~g~E~m~ To Spawn Boat')
       if IsControlJustPressed(0, 38) then
         API_CreateVehicle('emsboat', -801.935, -1504.908, 1.594)
         end
        end
       end
      end
     end
    end)

--===========================================================================================================================--

RegisterNetEvent('ems:AmbulanceBack')
AddEventHandler('ems:AmbulanceBack', function()
  WarMenu.OpenMenu('medicine')
end)

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
 DecorSetInt(vehicle, "_Max_Fuel_Level", 100000)
 DecorSetInt(vehicle, "_Fuel_Level", 100000)
end