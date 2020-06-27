
-- /gps
RegisterCommand('gps', function(source, args, rawCommand)
 if args[1] == nil then 
  local pos = GetEntityCoords(GetPlayerPed(-1))
  TriggerEvent('chatMessage', '^5Latitude: ^3'..string.format("%.3f", pos.x).." ^0| ^5Longitude: ^3"..string.format("%.3f", pos.y))
 elseif args[1] == 'waypoint' or args[1] == 'Waypoint' then 
  if IsWaypointActive() then 
   local waypointBlip = GetFirstBlipInfoId(8) -- 8 = Waypoint ID
   local x,y,z = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09, waypointBlip, Citizen.ResultAsVector())) 
   TriggerEvent('chatMessage', '^5Latitude: ^3'..string.format("%.3f", x).." ^0| ^5Longitude: ^3"..string.format("%.3f", y))
  else
   TriggerEvent('chatMessage', '^1No Waypoint')
  end
 else
  SetNewWaypoint(tonumber(args[1]), tonumber(args[2]))
  local waypointBlip = GetFirstBlipInfoId(8) -- 8 = Waypoint ID
  local x,y,z = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09, waypointBlip, Citizen.ResultAsVector())) 
  local var1, var2 = GetStreetNameAtCoord(x, y, z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
  TriggerEvent('chatMessage', '^5Street Name: ^3'..GetStreetNameFromHashKey(var1))
 end
end)

-- Vehicle Locking
AddEventHandler('garage:togglelocks', function()
 local coords = GetEntityCoords(GetPlayerPed(-1))
 local vehicle = nil
 if IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
  vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false) 
 else 
  vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 16.0, 0, 71) 
 end
 Citizen.CreateThread(function()
  if exports['core']:HasKey(GetVehicleNumberPlateText(vehicle)) then
   if GetVehicleDoorLockStatus(vehicle) == 1 then 
    SetVehicleDoorsLocked(vehicle, 2)
    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "lock", 0.1)
    if not IsPedInAnyVehicle(GetPlayerPed(-1), false) then playLockAnimation() end
    SetVehicleLights(vehicle, 2)
    Wait (100)
    SetVehicleLights(vehicle, 0)
    Wait (100)
    SetVehicleLights(vehicle, 2)
    Wait (100)	
    SetVehicleLights(vehicle, 0)  
    exports['NRP-notify']:DoHudText('error', 'Vehicle Locked')
   elseif GetVehicleDoorLockStatus(vehicle) == 2 then -- if locked
    SetVehicleDoorsLocked(vehicle, 1)
    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "lock", 0.1)
    if not IsPedInAnyVehicle(GetPlayerPed(-1), false) then playLockAnimation() end
    SetVehicleLights(vehicle, 2)
    Wait (100)
    SetVehicleLights(vehicle, 0)
    Wait (100)
    SetVehicleLights(vehicle, 2)
    Wait (100)	
    SetVehicleLights(vehicle, 0)
    exports['NRP-notify']:DoHudText('success', 'Vehicle Unlocked')
   end   
  elseif DecorGetBool(GetPlayerPed(-1), "isOfficer") or DecorGetBool(GetPlayerPed(-1), "isParamedic") or DecorGetInt(GetPlayerPed(-1), "Faction") == 11 then 
   if GetVehicleDoorLockStatus(vehicle) == 1 then 
    SetVehicleDoorsLocked(vehicle, 2)
    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "lock", 0.1)
    if not IsPedInAnyVehicle(GetPlayerPed(-1), false) then playLockAnimation() end
    SetVehicleLights(vehicle, 2)
    Wait (100)
    SetVehicleLights(vehicle, 0)
    Wait (100)
    SetVehicleLights(vehicle, 2)
    Wait (100)	
    SetVehicleLights(vehicle, 0)   
    exports['NRP-notify']:DoHudText('error', 'Vehicle Locked')
   elseif GetVehicleDoorLockStatus(vehicle) == 2 then -- if locked
    SetVehicleDoorsLocked(vehicle, 1)
    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "lock", 0.1)
    if not IsPedInAnyVehicle(GetPlayerPed(-1), false) then playLockAnimation() end
    SetVehicleLights(vehicle, 2)
    Wait (100)
    SetVehicleLights(vehicle, 0)
    Wait (100)
    SetVehicleLights(vehicle, 2)
    Wait (100)	
    SetVehicleLights(vehicle, 0)
    print(GetVehicleDoorLockStatus(vehicle))
    exports['NRP-notify']:DoHudText('success', 'Vehicle Unlocked')
   end
  elseif DecorGetInt(GetPlayerPed(-1), "Job") == 15 and GetVehicleNumberPlateText(vehicle) == "CARDEALE" then --[[ CAR LOCK FOR CARDEALER]]
    if GetVehicleDoorLockStatus(vehicle) == 1 then 
     SetVehicleDoorsLocked(vehicle, 2)
     TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "lock", 0.1)
     if not IsPedInAnyVehicle(GetPlayerPed(-1), false) then playLockAnimation() end
     FreezeEntityPosition(vehicle,true)
     SetVehicleLights(vehicle, 2)
     Wait (100)
     SetVehicleLights(vehicle, 0)
     Wait (100)
     SetVehicleLights(vehicle, 2)
     Wait (100)	
     SetVehicleLights(vehicle, 0)   
     exports['NRP-notify']:DoHudText('error', 'Vehicle Locked')
    elseif GetVehicleDoorLockStatus(vehicle) == 2 then -- if locked
     SetVehicleDoorsLocked(vehicle, 1)
     TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "lock", 0.1)
     if not IsPedInAnyVehicle(GetPlayerPed(-1), false) then playLockAnimation() end
     FreezeEntityPosition(vehicle,false)
     SetVehicleLights(vehicle, 2)
     Wait (100)
     SetVehicleLights(vehicle, 0)
     Wait (100)
     SetVehicleLights(vehicle, 2)
     Wait (100)	
     SetVehicleLights(vehicle, 0)
     print(GetVehicleDoorLockStatus(vehicle))
     exports['NRP-notify']:DoHudText('success', 'Vehicle Unlocked')
    end      
  end
 end)
end)

function playLockAnimation()
 RequestAnimDict('anim@mp_player_intmenu@key_fob@')
 while not HasAnimDictLoaded('anim@mp_player_intmenu@key_fob@') do
  Citizen.Wait(10)
 end
 TaskPlayAnim(PlayerPedId(), "anim@mp_player_intmenu@key_fob@", "fob_click_fp", 8.0, 8.0, -1, 50, 0, false, false, false)
 Wait(1000)
 ClearPedTasks(GetPlayerPed(-1))
end

-- Locked Vehicles
Citizen.CreateThread(function()
 while true do
  local ped = GetPlayerPed(-1)
  Citizen.Wait(5)
  if IsPedInAnyVehicle(ped, false) then 
   if GetVehicleDoorLockStatus(GetVehiclePedIsIn(ped, false)) == 2 then
    DisableControlAction(0, 75)
   end
  end
 end
end)

-- Peds
Citizen.CreateThread(function()
 spawnHospitalWorkers()
end)

-- Hospital Peds
local doctorWho = nil
local nurseWho = nil

function spawnHospitalWorkers()
 if doctorWho == nil then
  RequestModel(GetHashKey('s_m_m_doctor_01'))
  while not HasModelLoaded(GetHashKey('s_m_m_doctor_01')) do
   Wait(1)
  end

  doctorWho = CreatePed(2, GetHashKey('s_m_m_doctor_01'), 308.236, -596.602, 43.292, 13.582, false, false)
  SetPedFleeAttributes(doctorWho, 0, 0)
  SetPedDiesWhenInjured(doctorWho, false)
  TaskStartScenarioInPlace(doctorWho, "WORLD_HUMAN_CLIPBOARD", 0, true)
  SetPedKeepTask(doctorWho, true)
 end
 if nurseWho == nil then 
  RequestModel(GetHashKey('s_f_y_scrubs_01'))
  while not HasModelLoaded(GetHashKey('s_f_y_scrubs_01')) do
   Wait(1)
  end

  nurseWho = CreatePed(2, GetHashKey('s_f_y_scrubs_01'), 326.211, -582.833, 43.317, 340.769, false, false)
  SetPedFleeAttributes(nurseWho, 0, 0)
  SetPedDiesWhenInjured(nurseWho, false)
  SetPedKeepTask(nurseWho, true)
 end
end

local disabledPeds = {
  "s_m_y_cop_01",
  "s_f_y_sheriff_01",
  "s_m_y_sheriff_01",
  "s_m_y_hwaycop_01",
  "s_m_y_swat_01",
  "s_m_m_snowcop_01",
  "s_m_m_paramedic_01",
  "g_f_y_lost_01",
  "g_m_y_lost_01",
  "g_m_y_lost_02",
  "g_m_y_lost_03"
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000) 
        for ped in EnumeratePeds() do
            if DoesEntityExist(ped) then
        for i,model in pairs(disabledPeds) do
          if (GetEntityModel(ped) == GetHashKey(model)) then
            veh = GetVehiclePedIsIn(ped, false)
            SetEntityAsNoLongerNeeded(ped)
            SetEntityCoords(ped,10000,10000,10000,1,0,0,1)
            if veh ~= nil then
              SetEntityAsNoLongerNeeded(veh)
              SetEntityCoords(veh,10000,10000,10000,1,0,0,1)
            end
          end
        end
      end
    end
    end
end)

--[[Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    local aimped, targetped = GetEntityPlayerIsFreeAimingAt(PlayerId(-1))
    local PersonC = GetEntityCoords(GetPlayerPed(-1), true)
    local tpcoords = GetEntityCoords(targetped, true)
    local distanceayyycunt = GetDistanceBetweenCoords(PersonC.x, PersonC.y, PersonC.z, tpcoords.x, tpcoords.y, tpcoords.z, true)
    if aimped then
    if DoesEntityExist(targetped) and not IsPedInAnyVehicle(targetped, false) and IsEntityAPed(targetped) and not IsPedDeadOrDying(targetped, false) and IsControlPressed(0, 38) and IsPedFleeing(targetped, false) and IsPlayerFreeAiming(GetPlayerPed(-1)) and distanceayyycunt <= 10.0 then
          exports.pNotify:SendNotification({text = "Robbing Pedestrian")
          PlayEntityAnim(targetped, 'hand_up_scientist', 'missfbi5ig_21', true, loop, , p6, delta, bitset)
          TaskStartScenarioInPlace(targetped, 'CODE_HUMAN_POLICE_CROWD_CONTROL', 0, 0)
          SetPedMovementClipset(targetped, true)
          FreezeEntityPosition(targetped, true)
          Wait(7000)
          FreezeEntityPosition(targetped, false)
          ClearPedTasksImmediately(targetped)
          SetPedAsNoLongerNeeded(targetped)
          exports.pNotify:SendNotification({text = "Pedestrian Robbery Succesful")
      end
    end
  end
end)]]

    

function loadAnimDict( dict )
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
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
  DrawText(0.5, 0.93) 
end