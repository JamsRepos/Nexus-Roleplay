currentgarage = {}
local wantsAnim = false

-- Locations
duty = {
  {x = 459.126, y = -992.424, z = 30.69},
  {x = 1852.322, y = 3691.616, z = 34.267},
  {x = -450.341, y = 6011.161, z = 31.716},
}

garage = {
  {x = -466.257, y = 6021.872, z = 31.341}
}

bcsogarage = {
  {x = 1869.977, y = 3695.366, z = 33.557},
  {x = 454.76, y = -1019.81, z = 28.3}
}

spgarage = {
  {x = 454.06, y = -1014.00, z = 28.44}
}

armory = {
 {x = -448.132, y = 6008.409, z = 30.719},
 {x = 1848.832, y = 3689.946, z = 33.270},
 {x = 452.311, y = -980.097, z = 29.691}
} 

evidence = {
 {x = 478.077, y = -989.495, z = 24.914}
} 

janitor = {
 {x = 468.04, y = -990.89, z = 35.93}
} 

medicine = {
 {x = 435.84, y = -973.52, z = 26.67}
} 

breakroom = {
 {x = 467.57, y = -989.77, z = 30.69}
} 

breakroom1 = {
 {x = 464.75, y = -989.85, z = 30.69}
} 

chief = {
 {x = 463.27, y = -1009.32, z = 35.93}
} 

helicopters = {
  {x = -482.057, y = 5996.559, z = 33.216}, 
  {x = 449.499, y = -981.03, z = 45.141}

}

RegisterCommand("wantanim", function(source, args, rawCommand)
  if DecorGetBool(GetPlayerPed(-1), "isOfficer") then
   if wantsAnim then
    wantsAnim = false
    TriggerEvent('chatMessage', '^0Anim Disabled.')
   elseif not wantsAnim then
    wantsAnim = true
    TriggerEvent('chatMessage', '^0Anim Enabled.')
   end
  end
 end)

 RegisterCommand("uctaxi", function(source, args, rawCommand)
  local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
  if DecorGetBool(GetPlayerPed(-1), "isOfficer") then
   SetVehicleColours(vehicle, 88, 77)
  end
 end)

-- Spawn Vehicle Function
function SpawnVehicle(vehicle2)
 local vehiclehash = GetHashKey(vehicle2)
 RequestModel(vehiclehash)
 while not HasModelLoaded(vehiclehash) do
  Citizen.Wait(0)
 end
 vehicle = CreateVehicle(vehiclehash, currentgarage.x, currentgarage.y, currentgarage.z, GetEntityHeading(PlayerPedId()), true, false)
 local id = NetworkGetNetworkIdFromEntity(vehicle)
 SetNetworkIdCanMigrate(id, true)
 SetNetworkIdExistsOnAllMachines(id, true)
 SetVehicleDirtLevel(vehicle, 0)
 TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
 SetVehicleHasBeenOwnedByPlayer(vehicle, true)
 SetEntityAsMissionEntity(vehicle, true, true)
 SetVehicleMod(vehicle,16, 20)
 SetVehicleEngineOn(vehicle, true)
 SetVehicleLivery(vehicle, vehlivery)
 SetVehicleColours(vehicle, 100, 100)
 DecorRegister("_Fuel_Level", 3);
  DecorRegister("_Max_Fuel_Level", 3);
  DecorSetInt(vehicle, "_Max_Fuel_Level", 150000)
  DecorSetInt(vehicle, "_Fuel_Level", 150000)
  exports["onyxLocksystem"]:givePlayerKeys(GetVehicleNumberPlateText(vehicle))
end

function OnDuty() 
  TriggerServerEvent('police:duty', true)
  TriggerServerEvent("blips:activate", 'police')
  SetPedRelationshipGroupHash(GetPlayerPed(-1), "COP")
  SetAudioFlag("LoadMPData", false)
  SetAudioFlag("DisableFlightMusic", true)
  SetAudioFlag("OnlyAllowScriptTriggerPoliceScanner", false)
  SetAudioFlag("PoliceScannerDisabled", false)
  SetAudioFlag("WantedMusicDisabled", false)
  SetAudioFlag("AllowScoreAndRadio", true)
  exports["rp-radio"]:GivePlayerAccessToFrequencies(1, 2, 3)
  
  TriggerEvent("NRP-notify:client:SendAlert", { type = "success", text = "Please enter your callsign.", length = 5000})
  DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 32)
  while (UpdateOnscreenKeyboard() == 0) do
    DisableAllControlActions(0);
    Wait(0);
  end
  if (GetOnscreenKeyboardResult()) then
   local result = tonumber(GetOnscreenKeyboardResult())
   TriggerServerEvent('dispatch:duty', true, result)
   TriggerEvent("police:ondutynotification")
  end
end

function OffDuty()
  RemoveAllPedWeapons(GetPlayerPed(-1), true)  
  TriggerServerEvent("blips:deactivate")
  TriggerServerEvent('police:duty', false)
  TriggerServerEvent('dispatch:duty', false)
  exports["rp-radio"]:RemovePlayerAccessToFrequencies(1, 2, 3)
end

-- Nearest Players
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

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end

--==============================================================================================================================--
--Breathalyzer

DecorRegister("BAC_Active", 2)
DecorSetBool(GetPlayerPed(-1), "BAC_Active", false)
DecorRegister("_BAC_Level", 1)
DecorSetFloat(GetPlayerPed(-1), "_BAC_Level", 0.0)

function addBAC(amount)
    local BAC_Driving_Limit = 0.11
    local currentBAC = DecorGetFloat(GetPlayerPed(-1), "_BAC_Level")
    local newBAC = currentBAC + amount
    DecorSetFloat(GetPlayerPed(-1), "_BAC_Level", newBAC)
    if newBAC >= BAC_Driving_Limit then
        local isBACactive = DecorGetBool(GetPlayerPed(-1), "BAC_Active")
        if not isBACactive then
            DecorSetBool(GetPlayerPed(-1), "BAC_Active", true)  
        end
    end
end

AddEventHandler("police:bac", function(amount)
 addBAC(amount)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000) -- Every Minute remove some BAC
        local currentBAC = DecorGetFloat(GetPlayerPed(-1), "_BAC_Level")
        if currentBAC > 0 then
            local newBAC = currentBAC - 0.0005 --BAC to remove

            if newBAC < 0 then
                newBAC = 0
            end
            DecorSetFloat(GetPlayerPed(-1), "_BAC_Level", newBAC) 
            if newBAC == 0 then
                DecorSetBool(GetPlayerPed(-1), "BAC_Active", false) 
            end
        end

    end
end)
--==============================================================================================================================--
--Gunshot residue test 

local GSR_LastShot = 0
local GSR_ExpireTime = 15 -- Minutes
DecorRegister("GSR_Active", 2)
DecorSetBool(GetPlayerPed(-1), "GSR_Active", false) 
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        if IsPedShooting(GetPlayerPed(-1)) and GetSelectedPedWeapon(GetPlayerPed(-1)) ~= GetHashKey("WEAPON_BALL") then
            TriggerEvent("police:wfired")
        end
        local isGSRactive = DecorGetBool(GetPlayerPed(-1), "GSR_Active")
        if isGSRactive then
            if GSR_LastShot + (GSR_ExpireTime * 1000 * 60) <= GetGameTimer() then
                DecorSetBool(GetPlayerPed(-1), "GSR_Active", false)     
            end
        end
    end
end)

AddEventHandler("police:wfired", function()
    GSR_LastShot = GetGameTimer()
    local isGSRactive = DecorGetBool(GetPlayerPed(-1), "GSR_Active")
    if not isGSRactive then
        DecorSetBool(GetPlayerPed(-1), "GSR_Active", true)
    end
end)

--[[--=================================================================================================
--===================================== Radar =====================================================
--=================================================================================================
local radar = true 
local lastDetVehf = {}
local lastDetVehr = {}

Citizen.CreateThread(function()
  while true do
    Wait(5)

    if (DecorGetBool(GetPlayerPed(-1), 'isOfficer') and IsPedInAnyPoliceVehicle(GetPlayerPed(-1))) then
      local veh = GetVehiclePedIsIn(GetPlayerPed(-1))
      local vehpos = GetEntityCoords(veh)
      
      -- front radar
      local offsetf = GetOffsetFromEntityInWorldCoords(veh, 0.0, 360.0, 0.0)
      local detvehf = getVehicleInDirection(vehpos, offsetf, veh)

      if ((detvehf ~= 0) and (IsEntityAVehicle(detvehf)) and (detvehf ~= lastDetVeh) and (not IsVehicleSeatFree(detvehf, -1))) then
        local mph = math.ceil(GetEntitySpeed(detvehf, false) * 2.236936)
        local vtype = GetDisplayNameFromVehicleModel(GetEntityModel(detvehf))
        local plate = GetVehicleNumberPlateText(detvehf)
        local driver = GetPedInVehicleSeat(detvehf, -1)
        local driverbelt = '~g~On'

        lastDetVehf.mph = mph
        lastDetVehf.vtype = vtype
        lastDetVehf.plate = plate
        lastDetVehf.driverbelt = '~g~On'

        if DecorGetBool(driver, 'Seatbelt') then 
         lastDetVehf.driverbelt = '~g~On'
         driverbelt = '~g~On'
        else
         lastDetVehf.driverbelt = '~o~Off'
         driverbelt = '~o~Off'
        end

        drawRadarFront(mph, vtype, plate, driverbelt)
      elseif (lastDetVehf.mph) then
       if IsControlJustPressed(0, 79) then TriggerServerEvent('radar:check', 'Front', lastDetVehf.vtype, lastDetVehf.plate, lastDetVehf.mph) end
       if lastDetVehf.mph > 75 then 
        drawRadarFront(lastDetVehf.mph, tostring('~r~'..lastDetVehf.vtype..'~c~'), lastDetVehf.plate, lastDetVehf.driverbelt)
       else
        drawRadarFront(lastDetVehf.mph, lastDetVehf.vtype, lastDetVehf.plate, lastDetVehf.driverbelt)
       end
      end

      -- rear radar
      local offsetr = GetOffsetFromEntityInWorldCoords(veh, 0.0, -360.0, 0.0)
      local detvehr = getVehicleInDirection(vehpos, offsetr, veh)

      if ((detvehr ~= 0) and (IsEntityAVehicle(detvehr)) and (detvehr ~= lastDetVeh) and (not IsVehicleSeatFree(detvehr, -1))) then
        local mph = math.ceil(GetEntitySpeed(detvehr, false) * 2.236936)
        local vtype = GetDisplayNameFromVehicleModel(GetEntityModel(detvehr))
        local plate = GetVehicleNumberPlateText(detvehr)
        local driver = GetPedInVehicleSeat(detvehr, -1)

        lastDetVehr.mph = mph
        lastDetVehr.vtype = vtype
        lastDetVehr.plate = plate
        lastDetVehr.driverbelt = '~g~On'

        if DecorGetBool(driver, 'Seatbelt') then 
         lastDetVehr.driverbelt = '~g~On'
        else
         lastDetVehr.driverbelt = '~o~Off'
        end

        drawRadarRear(mph, vtype, plate, driverbelt)
      elseif (lastDetVehr.mph) then
       if IsControlJustPressed(0, 79) then TriggerServerEvent('radar:check', 'Rear', lastDetVehr.vtype, lastDetVehr.plate, lastDetVehr.mph) end
       if lastDetVehr.mph > 75 then 
        drawRadarRear(lastDetVehr.mph, tostring('~r~'..lastDetVehr.vtype..'~c~'), lastDetVehr.plate, lastDetVehr.driverbelt)
       else
        drawRadarRear(lastDetVehr.mph, lastDetVehr.vtype, lastDetVehr.plate, lastDetVehr.driverbelt)
       end
      end
    end
  end
end)

function getVehicleInDirection(coordFrom, coordTo, ignore)
  local rayHandle = StartShapeTestRay(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, ignore, 0)
  local _, _, _, _, vehicle = GetShapeTestResult(rayHandle)
  return vehicle
end

function drawRadarFront(mph, vtype, plate, dbelt)
  SetTextFont(4)
  SetTextProportional(0)
  SetTextScale(0.42, 0.42)
  SetTextColour(255, 255, 255, 255)
  SetTextDropShadow(0, 0, 0, 0, 255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextCentre(0)
  BeginTextCommandDisplayText("STRING")
  AddTextComponentSubstringPlayerName(string.format("Front Radar: ~c~%s | %s | %s MPH | Seatbelt: %s", vtype, plate, mph, dbelt))
  EndTextCommandDisplayText(0.5, 0.91)
end

function drawRadarRear(mph, vtype, plate, dbelt)
  SetTextFont(4)
  SetTextProportional(0)
  SetTextScale(0.42, 0.42)
  SetTextColour(255, 255, 255, 255)
  SetTextDropShadow(0, 0, 0, 0, 255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextCentre(0)
  BeginTextCommandDisplayText("STRING")
  AddTextComponentSubstringPlayerName(string.format("Rear Radar: ~c~%s | %s | %s MPH | Seatbelt: %s ~c~", vtype, plate, mph, dbelt))
  EndTextCommandDisplayText(0.5, 0.945)
end]]--

local holstered = true

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local ped = PlayerPedId()
		if DoesEntityExist( ped ) and not IsEntityDead( ped ) and not IsPedSwimming(ped) and DecorGetBool(GetPlayerPed(-1), 'isOfficer') and wantsAnim then
			if not IsPauseMenuActive() then 
				loadAnimDict( "reaction@intimidation@cop@unarmed" )
				if IsControlJustReleased( 0, 137 ) then
					ClearPedTasks(ped)
					SetEnableHandcuffs(ped, false)
				else
					if IsControlJustPressed( 0, 137 ) and not IsPlayerFreeAiming(PlayerId()) then -- INPUT_CHARACTER_WHEEL (LEFT ALT)
						TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "intro", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
					elseif IsControlJustPressed( 0, 137 ) and IsPlayerFreeAiming(PlayerId()) then -- INPUT_CHARACTER_WHEEL (LEFT ALT)
						TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "radio_chatter", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
					end 
					if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "reaction@intimidation@cop@unarmed", "intro", 3) then
				
					elseif IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "reaction@intimidation@cop@unarmed", "radio_chatter", 3) then
						DisableActions(ped)
					end
				end
			end 
		end 
	end
end)

function DisableActions(ped)
	DisableControlAction(1, 140, true)
	DisableControlAction(1, 141, true)
	DisableControlAction(1, 142, true)
	DisableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
	DisablePlayerFiring(ped, true) -- Disable weapon firing
end

function loadAnimDict( dict )
	while ( not HasAnimDictLoaded( dict ) ) do
		RequestAnimDict( dict )
		Citizen.Wait( 0 )
	end
end
