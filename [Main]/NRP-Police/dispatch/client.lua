local currentJob = nil
local disableNotifs = false

RegisterNetEvent('nrp:clNotify')
AddEventHandler('nrp:clNotify', function(pData)
    if pData ~= nil then
        if pData.recipientList then
            if DecorGetBool(GetPlayerPed(-1), "isOfficer") then
              currentJob = "police"
            elseif DecorGetBool(GetPlayerPed(-1), "isParamedic") then
              currentJob = "ems"
            else
              currentJob = "none"
            end
            if isInService and (currentJob == pData.recipientList[1].name or currentJob == pData.recipientList[2].name) then
                SendNUIMessage({type = "alerts", info = pData, job = currentJob})
                PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
            end
        end
    end
end)

RegisterNetEvent('nrp:dispatch:notify')
AddEventHandler('nrp:dispatch:notify', function(alertType, additionalInformation)
    street = GetTheStreet()
    local job = false
    
    if DecorGetBool(GetPlayerPed(-1), "isOfficer") then
        job = false
    elseif DecorGetBool(GetPlayerPed(-1), "isParamedic") then
        job = true
    end

    if alertType == "10-20" or alertType == "10-33" then
      job = false
    end

    if not job then
        print("poo2")
        if additionalInformation ~= nil then
          data = {dispatchCode = alertType, street = playerStreetsLocation, extra = additionalInformation}
        else
          data = {dispatchCode = alertType, street = playerStreetsLocation}
        end
        local suspectLocation = getSuspectLocation()
        TriggerServerEvent('nrp:svNotify', data, suspectLocation.pos)
    end
end)

RegisterNetEvent('dispatch:toggle')
AddEventHandler('dispatch:toggle', function(status)
  SendNUIMessage({
    type = "dispatch",
    display = status
  })
end)

RegisterNetEvent('dispatch:update')
AddEventHandler('dispatch:update', function(string, duty)
  if DecorGetBool(GetPlayerPed(-1), "isOfficer") or DecorGetBool(GetPlayerPed(-1), "isParamedic") then
    local onDuty = {}
    for k,v in pairs(string) do
      if v ~= nil then
        table.insert(onDuty, v)
      end
    end
    local officers = onDuty
    SendNUIMessage({
      type = "dispatch",
      display = false
    })
    for k,v in pairs(duty) do
      if v == GetPlayerServerId(PlayerId()) then
        SendNUIMessage({
          type = "dispatch",
          display = true,
          onduty = officers
        })
      end
    end
  end
end)

RegisterNetEvent('dispatch:notify')
AddEventHandler('dispatch:notify', function(alert)
 if DecorGetBool(GetPlayerPed(-1), "isOfficer") then
  if isInService then
    exports['NRP-notify']:DoCustomHudText('error','Dispatch: '.. alert, 10000)
  end
 end
end)

--== CDS Reports
RegisterNetEvent("dispatch:noInsurance")
AddEventHandler("dispatch:noInsurance", function()
 local suspectSex = getSuspectSex()
 local suspectLocation = getSuspectLocation()
 local vehicle = GetVehiclePedIsTryingToEnter(GetPlayerPed(-1))
 local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
 local vehiclePlate = GetVehicleNumberPlateText(vehicle)
 local vehicleColour = getVehicleColours(vehicle)
 TriggerServerEvent('dispatch:noInsurance', suspectLocation, suspectSex, vehicleName, vehiclePlate, vehicleColour)
end)

RegisterNetEvent('dispatch:noInsurancePos')
AddEventHandler('dispatch:noInsurancePos', function(pos)
 if isInService then
  local transT = 250
  local thiefBlip = AddBlipForCoord(pos.x, pos.y, pos.z)
  SetBlipSprite(thiefBlip, 10)
  SetBlipColour(thiefBlip, 1)
  SetBlipAlpha(thiefBlip, transT)
  SetBlipAsShortRange(thiefBlip, 1)
  while transT ~= 0 do
   Wait(250)
   transT = transT - 1
   SetBlipAlpha(thiefBlip,  transT)
   if transT == 0 then
    SetBlipSprite(thiefBlip,  2)
    return
   end
  end
 end
end)

RegisterNetEvent("dispatch:robbery")
AddEventHandler("dispatch:robbery", function()
 local suspectSex = getSuspectSex()
  TriggerEvent('nrp:dispatch:notify', '10-31B', json.encode({{civrobSex=suspectSex}}))
 if DecorGetBool(GetPlayerPed(-1), "isOfficer") and isInService then
 TriggerServerEvent('InteractSound_SV:PlayOnSource', 'CDScomp', 0.05)
end
end)



RegisterNetEvent('dispatch:robberyPos')
AddEventHandler('dispatch:robberyPos', function(pos)
	if isInService then
		local transG = 250
		local gunshotBlip = AddBlipForCoord(pos.x, pos.y, pos.z)
		SetBlipSprite(gunshotBlip,  1)
		SetBlipColour(gunshotBlip,  44)
		SetBlipAlpha(gunshotBlip,  transG)
		SetBlipAsShortRange(gunshotBlip,  1)
		while transG ~= 0 do
			Wait(250)
			transG = transG - 1
			SetBlipAlpha(gunshotBlip,  transG)
			if transG == 0 then
				SetBlipSprite(gunshotBlip,  2)
				return
			end
		end
  end
  if (exports['core']:GetItemQuantity(161) > 0) and (exports['core']:GetItemQuantity(261) > 0) then 
    TriggerEvent('chatMessage', "RADIO CHATTER ", {255, 0, 0}, "An emergency signal has been picked up on your radio scanner!")
    local transG = 250
    local gunshotBlip = AddBlipForCoord(pos.x, pos.y, pos.z)
    SetBlipSprite(gunshotBlip,  459)
    SetBlipColour(gunshotBlip,  4)
    SetBlipAlpha(gunshotBlip,  transG)
    SetBlipAsShortRange(gunshotBlip,  1)
    while transG ~= 0 do
    Wait(550)
    transG = transG-1
    SetBlipAlpha(gunshotBlip, transG)
    if transG == 0 then
      SetBlipSprite(gunshotBlip,  2)
      return
    end
    end		   
  elseif (exports['core']:GetItemQuantity(161) > 0) and (IsPedInAnyVehicle(GetPlayerPed(-1), false)) then 
    TriggerEvent('chatMessage', "RADIO CHATTER ", {255, 0, 0}, "An emergency signal has been picked up on your radio scanner!")
    local transG = 250
    local gunshotBlip = AddBlipForCoord(pos.x, pos.y, pos.z)
    SetBlipSprite(gunshotBlip,  459)
    SetBlipColour(gunshotBlip,  4)
    SetBlipAlpha(gunshotBlip,  transG)
    SetBlipAsShortRange(gunshotBlip,  1)
    while transG ~= 0 do
     Wait(550)
     transG = transG-1
     SetBlipAlpha(gunshotBlip, transG)
     if transG == 0 then
      SetBlipSprite(gunshotBlip,  2)
      return
     end
    end		   
  end
end)

--== Hospital
RegisterNetEvent("dispatch:hospital")
AddEventHandler("dispatch:hospital", function()
 local suspectSex = getSuspectSex()
 local suspectLocation = getSuspectLocation()
 TriggerServerEvent('dispatch:hospital', suspectLocation, suspectSex)
 if DecorGetBool(GetPlayerPed(-1), "isOfficer") and isInService then
 TriggerServerEvent('InteractSound_SV:PlayOnSource', 'CDScomp', 0.05)
end
end)

RegisterNetEvent('dispatch:hospitalPos')
AddEventHandler('dispatch:hospitalPos', function(pos)
	if isInService then
		local transG = 250
		local gunshotBlip = AddBlipForCoord(pos.x, pos.y, pos.z)
		SetBlipSprite(gunshotBlip,  1)
		SetBlipColour(gunshotBlip,  44)
		SetBlipAlpha(gunshotBlip,  transG)
		SetBlipAsShortRange(gunshotBlip,  1)
		while transG ~= 0 do
			Wait(250)
			transG = transG - 1
			SetBlipAlpha(gunshotBlip,  transG)
			if transG == 0 then
				SetBlipSprite(gunshotBlip,  2)
				return
			end
		end
	end
end)


--== CDS Reports
RegisterNetEvent("dispatch:cds")
AddEventHandler("dispatch:cds", function()
 local suspectSex = getSuspectSex()
  TriggerEvent('nrp:dispatch:notify', '10-60', json.encode({{drugsaleSex=suspectSex}}))
 if DecorGetBool(GetPlayerPed(-1), "isOfficer") and isInService then
 TriggerServerEvent('InteractSound_SV:PlayOnSource', 'CDScomp', 0.05)
end
end)

RegisterNetEvent('dispatch:cdsPos')
AddEventHandler('dispatch:cdsPos', function(pos)
	if isInService then
		local transG = 250
		local gunshotBlip = AddBlipForCoord(pos.x, pos.y, pos.z)
		SetBlipSprite(gunshotBlip,  1)
		SetBlipColour(gunshotBlip,  46)
		SetBlipAlpha(gunshotBlip,  transG)
		SetBlipAsShortRange(gunshotBlip,  1)
		while transG ~= 0 do
			Wait(250)
			transG = transG - 1
			SetBlipAlpha(gunshotBlip,  transG)
			if transG == 0 then
				SetBlipSprite(gunshotBlip,  2)
				return
			end
		end
  end
  if (exports['core']:GetItemQuantity(161) > 0) and (exports['core']:GetItemQuantity(261) > 0) then 
    TriggerEvent('chatMessage', "RADIO CHATTER ", {255, 0, 0}, "An emergency signal has been picked up on your radio scanner!")
    local transG = 250
    local gunshotBlip = AddBlipForCoord(pos.x, pos.y, pos.z)
    SetBlipSprite(gunshotBlip,  459)
    SetBlipColour(gunshotBlip,  4)
    SetBlipAlpha(gunshotBlip,  transG)
    SetBlipAsShortRange(gunshotBlip,  1)
    while transG ~= 0 do
    Wait(550)
    transG = transG-1
    SetBlipAlpha(gunshotBlip, transG)
    if transG == 0 then
      SetBlipSprite(gunshotBlip,  2)
      return
    end
    end		   
  elseif (exports['core']:GetItemQuantity(161) > 0) and (IsPedInAnyVehicle(GetPlayerPed(-1), false)) then 
    TriggerEvent('chatMessage', "RADIO CHATTER ", {255, 0, 0}, "An emergency signal has been picked up on your radio scanner!")
    local transG = 250
    local gunshotBlip = AddBlipForCoord(pos.x, pos.y, pos.z)
    SetBlipSprite(gunshotBlip,  459)
    SetBlipColour(gunshotBlip,  4)
    SetBlipAlpha(gunshotBlip,  transG)
    SetBlipAsShortRange(gunshotBlip,  1)
    while transG ~= 0 do
     Wait(550)
     transG = transG-1
     SetBlipAlpha(gunshotBlip, transG)
     if transG == 0 then
      SetBlipSprite(gunshotBlip,  2)
      return
     end
    end		   
  end
end)

--== CDS Reports
RegisterNetEvent("dispatch:poaching")
AddEventHandler("dispatch:poaching", function()
 local suspectSex = getSuspectSex()
  TriggerEvent('nrp:dispatch:notify', '10-45', json.encode({{poachingSex=suspectSex}}))
end)

RegisterNetEvent('dispatch:poachingPos')
AddEventHandler('dispatch:poachingPos', function(pos)
	if isInService then
		local transG = 250
		local poachingBlip = AddBlipForCoord(pos.x, pos.y, pos.z)
		SetBlipSprite(poachingBlip,  1)
		SetBlipColour(poachingBlip,  25)
		SetBlipAlpha(poachingBlip,  transG)
		SetBlipAsShortRange(poachingBlip,  1)
		while transG ~= 0 do
			Wait(250)
			transG = transG - 1
			SetBlipAlpha(poachingBlip,  transG)
			if transG == 0 then
				SetBlipSprite(poachingBlip,  2)
				return
			end
		end
  end
  if (exports['core']:GetItemQuantity(161) > 0) and (exports['core']:GetItemQuantity(261) > 0) then 
    TriggerEvent('chatMessage', "RADIO CHATTER ", {255, 0, 0}, "An emergency signal has been picked up on your radio scanner!")
    local transG = 250
    local gunshotBlip = AddBlipForCoord(pos.x, pos.y, pos.z)
    SetBlipSprite(gunshotBlip,  459)
    SetBlipColour(gunshotBlip,  4)
    SetBlipAlpha(gunshotBlip,  transG)
    SetBlipAsShortRange(gunshotBlip,  1)
    while transG ~= 0 do
    Wait(550)
    transG = transG-1
    SetBlipAlpha(gunshotBlip, transG)
    if transG == 0 then
      SetBlipSprite(gunshotBlip,  2)
      return
    end
    end		   
  elseif (exports['core']:GetItemQuantity(161) > 0) and (IsPedInAnyVehicle(GetPlayerPed(-1), false)) then 
    TriggerEvent('chatMessage', "RADIO CHATTER ", {255, 0, 0}, "An emergency signal has been picked up on your radio scanner!")
    local transG = 250
    local gunshotBlip = AddBlipForCoord(pos.x, pos.y, pos.z)
    SetBlipSprite(gunshotBlip,  459)
    SetBlipColour(gunshotBlip,  4)
    SetBlipAlpha(gunshotBlip,  transG)
    SetBlipAsShortRange(gunshotBlip,  1)
    while transG ~= 0 do
     Wait(550)
     transG = transG-1
     SetBlipAlpha(gunshotBlip, transG)
     if transG == 0 then
      SetBlipSprite(gunshotBlip,  2)
      return
     end
    end		   
  end
end)

--== Melee Reports
RegisterNetEvent('dispatch:vehiclePos')
AddEventHandler('dispatch:vehiclePos', function(pos)
  if DecorGetBool(GetPlayerPed(-1), "isOfficer") and isInService then
  TriggerServerEvent('InteractSound_SV:PlayOnSource', 'VTheft', 0.05)
  local transT = 250
  local thiefBlip = AddBlipForCoord(pos.x, pos.y, pos.z)
  SetBlipSprite(thiefBlip, 10)
  SetBlipColour(thiefBlip, 1)
  SetBlipAlpha(thiefBlip, transT)
  SetBlipAsShortRange(thiefBlip, 1)
  while transT ~= 0 do
   Wait(250)
   transT = transT - 1
   SetBlipAlpha(thiefBlip,  transT)
   if transT == 0 then
    SetBlipSprite(thiefBlip,  2)
    return
   end
  end
 end
 if (exports['core']:GetItemQuantity(161) > 0) and (exports['core']:GetItemQuantity(261) > 0) then 
  TriggerServerEvent('InteractSound_SV:PlayOnSource', 'VTheft', 0.05)
  TriggerEvent('chatMessage', "RADIO CHATTER ", {255, 0, 0}, "An emergency signal has been picked up on your radio scanner!")
  local transG = 250
  local gunshotBlip = AddBlipForCoord(pos.x, pos.y, pos.z)
  SetBlipSprite(gunshotBlip,  459)
  SetBlipColour(gunshotBlip,  4)
  SetBlipAlpha(gunshotBlip,  transG)
  SetBlipAsShortRange(gunshotBlip,  1)
  while transG ~= 0 do
  Wait(550)
  transG = transG-1
  SetBlipAlpha(gunshotBlip, transG)
  if transG == 0 then
    SetBlipSprite(gunshotBlip,  2)
    return
  end
  end		   
elseif (exports['core']:GetItemQuantity(161) > 0) and (IsPedInAnyVehicle(GetPlayerPed(-1), false)) then 
  TriggerServerEvent('InteractSound_SV:PlayOnSource', 'VTheft', 0.05)
  TriggerEvent('chatMessage', "RADIO CHATTER ", {255, 0, 0}, "An emergency signal has been picked up on your radio scanner!")
  local transG = 250
  local gunshotBlip = AddBlipForCoord(pos.x, pos.y, pos.z)
  SetBlipSprite(gunshotBlip,  459)
  SetBlipColour(gunshotBlip,  4)
  SetBlipAlpha(gunshotBlip,  transG)
  SetBlipAsShortRange(gunshotBlip,  1)
  while transG ~= 0 do
   Wait(550)
   transG = transG-1
   SetBlipAlpha(gunshotBlip, transG)
   if transG == 0 then
    SetBlipSprite(gunshotBlip,  2)
    return
   end
  end		   
end
end)
--[[
Citizen.CreateThread(function()
 while true do
  Wait(1000)
  if IsPedTryingToEnterALockedVehicle(GetPlayerPed(-1)) or IsPedJacking(GetPlayerPed(-1)) then
   local vehicle = GetVehiclePedIsTryingToEnter(GetPlayerPed(-1))
   local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
   local vehiclePlate = GetVehicleNumberPlateText(vehicle)
   local vehicleColour = getVehicleColours(vehicle)
   local suspectSex = getSuspectSex()
   local suspectLocation = getSuspectLocation()
    if not exports['core']:HasKey(vehiclePlate) then
    Wait(200)
    TriggerServerEvent('dispatch:vehicle', suspectLocation, suspectSex, vehicleName, vehiclePlate, vehicleColour)
    if DecorGetBool(GetPlayerPed(-1), "isOfficer") and isInService then
        TriggerServerEvent('InteractSound_SV:PlayOnSource', 'VTheft', 0.05)
    end
   end
  end
 end
end)
--]]

--== Gun Shots Reports
RegisterNetEvent('dispatch:shotPos')
AddEventHandler('dispatch:shotPos', function(pos)
  if (DecorGetBool(GetPlayerPed(-1), "isOfficer") and isInService) then
  TriggerServerEvent('InteractSound_SV:PlayOnSource', 'Firearmdis', 0.05)
  local transG = 250
  local gunshotBlip = AddBlipForCoord(pos.x, pos.y, pos.z)
  SetBlipSprite(gunshotBlip,  1)
  SetBlipColour(gunshotBlip,  1)
  SetBlipAlpha(gunshotBlip,  transG)
  SetBlipAsShortRange(gunshotBlip,  1)
  while transG ~= 0 do
   Wait(350)
   transG = transG-1
   SetBlipAlpha(gunshotBlip, transG)
   if transG == 0 then
    SetBlipSprite(gunshotBlip,  2)
    return
   end
  end		   
 end
  if (exports['core']:GetItemQuantity(161) > 0) and (exports['core']:GetItemQuantity(261) > 0) then 
    TriggerServerEvent('InteractSound_SV:PlayOnSource', 'Firearmdis', 0.05)
    TriggerEvent('chatMessage', "RADIO CHATTER ", {255, 0, 0}, "An emergency signal has been picked up on your radio scanner!")
    local transG = 250
    local gunshotBlip = AddBlipForCoord(pos.x, pos.y, pos.z)
    SetBlipSprite(gunshotBlip,  459)
    SetBlipColour(gunshotBlip,  4)
    SetBlipAlpha(gunshotBlip,  transG)
    SetBlipAsShortRange(gunshotBlip,  1)
    while transG ~= 0 do
    Wait(550)
    transG = transG-1
    SetBlipAlpha(gunshotBlip, transG)
    if transG == 0 then
      SetBlipSprite(gunshotBlip,  2)
      return
    end
    end		   
  elseif (exports['core']:GetItemQuantity(161) > 0) and (IsPedInAnyVehicle(GetPlayerPed(-1), false)) then 
    TriggerServerEvent('InteractSound_SV:PlayOnSource', 'Firearmdis', 0.05)
    TriggerEvent('chatMessage', "RADIO CHATTER ", {255, 0, 0}, "An emergency signal has been picked up on your radio scanner!")
    local transG = 250
    local gunshotBlip = AddBlipForCoord(pos.x, pos.y, pos.z)
    SetBlipSprite(gunshotBlip,  459)
    SetBlipColour(gunshotBlip,  4)
    SetBlipAlpha(gunshotBlip,  transG)
    SetBlipAsShortRange(gunshotBlip,  1)
    while transG ~= 0 do
     Wait(550)
     transG = transG-1
     SetBlipAlpha(gunshotBlip, transG)
     if transG == 0 then
      SetBlipSprite(gunshotBlip,  2)
      return
     end
    end		   
  end
end)

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(60)
  if IsPedShooting(GetPlayerPed(-1)) then
    if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 13.360, -1097.651, 29.834, true) > 5 then
      if GetSelectedPedWeapon(GetPlayerPed(-1)) ~= 317205821 and GetSelectedPedWeapon(GetPlayerPed(-1)) ~= 883325847 and GetSelectedPedWeapon(GetPlayerPed(-1)) ~= 101631238 and GetSelectedPedWeapon(GetPlayerPed(-1)) ~= 911657153 and GetSelectedPedWeapon(GetPlayerPed(-1)) ~= 1198879012 and GetSelectedPedWeapon(GetPlayerPed(-1)) ~= GetHashKey("WEAPON_BALL") then
        if not IsSuppressed() and NearestNPC() then
        local suspectSex = getSuspectSex()
        local suspectLocation = getSuspectLocation()
        TriggerEvent('nrp:dispatch:notify', '10-13', json.encode({{gunshotSex=suspectSex}}))
        Wait(2500)
       end
      end
    end
 end
end
end)

function IsSuppressed()
 local currentWeaponHash = GetSelectedPedWeapon(GetPlayerPed(-1))
 local havesilence = false
 if currentWeaponHash == GetHashKey("WEAPON_PISTOL") then
  havesilence = HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL"), GetHashKey("component_at_pi_supp_02"))
 elseif currentWeaponHash == GetHashKey("WEAPON_PISTOL50") then
  havesilence = HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL50"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
 elseif currentWeaponHash == GetHashKey("WEAPON_COMBATPISTOL") then
  havesilence = HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP"))
 elseif currentWeaponHash == GetHashKey("WEAPON_APPISTOL") then
  havesilence = HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey("WEAPON_APPISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP"))
elseif currentWeaponHash == GetHashKey("weapon_machinepistol") then
    havesilence = HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey("weapon_machinepistol"), GetHashKey("COMPONENT_AT_PI_SUPP"))
 elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYPISTOL") then
  havesilence = HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYPISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP"))
 elseif currentWeaponHash == GetHashKey("WEAPON_VINTAGEPISTOL") then
   havesilence = HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey("WEAPON_VINTAGEPISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP"))
 elseif currentWeaponHash == GetHashKey("WEAPON_SMG") then
   havesilence = HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey("WEAPON_SMG"), GetHashKey("COMPONENT_AT_PI_SUPP"))
 elseif currentWeaponHash == GetHashKey("WEAPON_MICROSMG") then
  havesilence = HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey("WEAPON_MICROSMG"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
 elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSMG") then
  havesilence = HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTSMG"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
 elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE") then
  havesilence = HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
 elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE") then
  havesilence = HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP"))
 elseif currentWeaponHash == GetHashKey("WEAPON_ADVANCEDRIFLE") then
  havesilence = HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey("WEAPON_ADVANCEDRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP"))
 elseif currentWeaponHash == GetHashKey("WEAPON_SPECIALCARBINE") then
  havesilence = HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
 elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPRIFLE") then
  havesilence = HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey("WEAPON_BULLPUPRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP"))
 elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSHOTGUN") then
  havesilence = HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTSHOTGUN"), GetHashKey("COMPONENT_AT_AR_SUPP"))
 elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYSHOTGUN") then
  havesilence = HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYSHOTGUN"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
 elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPSHOTGUN") then
  havesilence = HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey("WEAPON_BULLPUPSHOTGUN"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
 elseif currentWeaponHash == GetHashKey("WEAPON_PUMPSHOTGUN") then
  havesilence = HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN"), GetHashKey("COMPONENT_AT_SR_SUPP"))
 elseif currentWeaponHash == GetHashKey("WEAPON_MARKSMANRIFLE") then
  havesilence = HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey("WEAPON_MARKSMANRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP"))
 elseif currentWeaponHash == GetHashKey("WEAPON_SNIPERRIFLE") then
  havesilence = HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey("WEAPON_SNIPERRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
 elseif currentWeaponHash == GetHashKey("WEAPON_STUNGUN") then
  havesilence = true
 end
 return havesilence
end


function NearestNPC()
 local playerCoords = GetEntityCoords(GetPlayerPed(-1))
 local handle, ped = FindFirstPed()
 local success
 local rped = nil
 local distanceFrom
 repeat
  local pos = GetEntityCoords(ped)
  local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
  if canPedBeUsed(ped) and distance < 300.0 and (distanceFrom == nil or distance < distanceFrom) then
   distanceFrom = distance
   rped = ped
  end
  success, ped = FindNextPed(handle)
  Wait(10)
  until not success
  EndFindPed(handle)
  
  if DoesEntityExist(rped) then
   return true
  end
end

function canPedBeUsed(ped)
    if ped == nil then
        return false
    end
    if ped == GetPlayerPed(-1) then
        return false
    end
    if not DoesEntityExist(ped) then
        return false
    end
    return true
end

local vehicleColors = {['0'] = "Metallic Black", ['1'] = "Metallic Graphite Black", ['2'] = "Metallic Black Steal", ['3'] = "Metallic Dark Silver", ['4'] = "Metallic Silver", ['5'] = "Metallic Blue Silver", ['6'] = "Metallic Steel Gray", ['7'] = "Metallic Shadow Silver", ['8'] = "Metallic Stone Silver", ['9'] = "Metallic Midnight Silver", ['10'] = "Metallic Gun Metal", ['11'] = "Metallic Anthracite Grey", ['12'] = "Matte Black", ['13'] = "Matte Gray", ['14'] = "Matte Light Grey", ['15'] = "Util Black", ['16'] = "Util Black Poly", ['17'] = "Util Dark silver", ['18'] = "Util Silver", ['19'] = "Util Gun Metal", ['20'] = "Util Shadow Silver", ['21'] = "Worn Black", ['22'] = "Worn Graphite", ['23'] = "Worn Silver Grey", ['24'] = "Worn Silver", ['25'] = "Worn Blue Silver", ['26'] = "Worn Shadow Silver", ['27'] = "Metallic Red", ['28'] = "Metallic Torino Red", ['29'] = "Metallic Formula Red", ['30'] = "Metallic Blaze Red", ['31'] = "Metallic Graceful Red", ['32'] = "Metallic Garnet Red", ['33'] = "Metallic Desert Red", ['34'] = "Metallic Cabernet Red", ['35'] = "Metallic Candy Red", ['36'] = "Metallic Sunrise Orange", ['37'] = "Metallic Classic Gold", ['38'] = "Metallic Orange", ['39'] = "Matte Red", ['40'] = "Matte Dark Red", ['41'] = "Matte Orange", ['42'] = "Matte Yellow", ['43'] = "Util Red", ['44'] = "Util Bright Red", ['45'] = "Util Garnet Red", ['46'] = "Worn Red", ['47'] = "Worn Golden Red", ['48'] = "Worn Dark Red", ['49'] = "Metallic Dark Green", ['50'] = "Metallic Racing Green", ['51'] = "Metallic Sea Green", ['52'] = "Metallic Olive Green", ['53'] = "Metallic Green", ['54'] = "Metallic Gasoline Blue Green", ['55'] = "Matte Lime Green", ['56'] = "Util Dark Green", ['57'] = "Util Green", ['58'] = "Worn Dark Green", ['59'] = "Worn Green", ['60'] = "Worn Sea Wash", ['61'] = "Metallic Midnight Blue", ['62'] = "Metallic Dark Blue", ['63'] = "Metallic Saxony Blue", ['64'] = "Metallic Blue", ['65'] = "Metallic Mariner Blue", ['66'] = "Metallic Harbor Blue", ['67'] = "Metallic Diamond Blue", ['68'] = "Metallic Surf Blue", ['69'] = "Metallic Nautical Blue", ['70'] = "Metallic Bright Blue", ['71'] = "Metallic Purple Blue", ['72'] = "Metallic Spinnaker Blue", ['73'] = "Metallic Ultra Blue", ['74'] = "Metallic Bright Blue", ['75'] = "Util Dark Blue", ['76'] = "Util Midnight Blue", ['77'] = "Util Blue", ['78'] = "Util Sea Foam Blue", ['79'] = "Uil Lightning blue", ['80'] = "Util Maui Blue Poly", ['81'] = "Util Bright Blue", ['82'] = "Matte Dark Blue", ['83'] = "Matte Blue", ['84'] = "Matte Midnight Blue", ['85'] = "Worn Dark blue", ['86'] = "Worn Blue", ['87'] = "Worn Light blue", ['88'] = "Metallic Taxi Yellow", ['89'] = "Metallic Race Yellow", ['90'] = "Metallic Bronze", ['91'] = "Metallic Yellow Bird", ['92'] = "Metallic Lime", ['93'] = "Metallic Champagne", ['94'] = "Metallic Pueblo Beige", ['95'] = "Metallic Dark Ivory", ['96'] = "Metallic Choco Brown", ['97'] = "Metallic Golden Brown", ['98'] = "Metallic Light Brown", ['99'] = "Metallic Straw Beige", ['100'] = "Metallic Moss Brown", ['101'] = "Metallic Biston Brown", ['102'] = "Metallic Beechwood", ['103'] = "Metallic Dark Beechwood", ['104'] = "Metallic Choco Orange", ['105'] = "Metallic Beach Sand", ['106'] = "Metallic Sun Bleeched Sand", ['107'] = "Metallic Cream", ['108'] = "Util Brown", ['109'] = "Util Medium Brown", ['110'] = "Util Light Brown", ['111'] = "Metallic White", ['112'] = "Metallic Frost White", ['113'] = "Worn Honey Beige", ['114'] = "Worn Brown", ['115'] = "Worn Dark Brown", ['116'] = "Worn straw beige", ['117'] = "Brushed Steel", ['118'] = "Brushed Black steel", ['119'] = "Brushed Aluminium", ['120'] = "Chrome", ['121'] = "Worn Off White", ['122'] = "Util Off White", ['123'] = "Worn Orange", ['124'] = "Worn Light Orange", ['125'] = "Metallic Securicor Green", ['126'] = "Worn Taxi Yellow", ['127'] = "police car blue", ['128'] = "Matte Green", ['129'] = "Matte Brown", ['130'] = "Worn Orange", ['131'] = "Matte White", ['132'] = "Worn White", ['133'] = "Worn Olive Army Green", ['134'] = "Pure White", ['135'] = "Hot Pink", ['136'] = "Salmon pink", ['137'] = "Metallic Vermillion Pink", ['138'] = "Orange", ['139'] = "Green", ['140'] = "Blue", ['141'] = "Mettalic Black Blue", ['142'] = "Metallic Black Purple", ['143'] = "Metallic Black Red", ['144'] = "hunter green", ['145'] = "Metallic Purple", ['146'] = "Metaillic V Dark Blue", ['147'] = "MODSHOP BLACK1", ['148'] = "Matte Purple", ['149'] = "Matte Dark Purple", ['150'] = "Metallic Lava Red", ['151'] = "Matte Forest Green", ['152'] = "Matte Olive Drab", ['153'] = "Matte Desert Brown", ['154'] = "Matte Desert Tan", ['155'] = "Matte Foilage Green", ['156'] = "DEFAULT ALLOY COLOR", ['157'] = "Epsilon Blue",}
function getVehicleColours(vehicle)
 local primary, secondary = GetVehicleColours(vehicle)
 return {primary = vehicleColors[tostring(primary)], secondary = vehicleColors[tostring(secondary)]}
end

function getSuspectSex()
 local sex = 'Male'
 if GetEntityModel(GetPlayerPed(-1)) == -1667301416 then 
  sex = "Female" 
 else 
  sex = "Male" 
 end
 return sex
end

function getSuspectLocation()
 local pos = GetEntityCoords(GetPlayerPed(-1),  true)
 local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, pos.x, pos.y, pos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
 if s2 == 0 then 
  return {street1 = GetStreetNameFromHashKey(s1), street2 = GetStreetNameFromHashKey(s2), both = false, pos = {x = pos.x, y = pos.y, z = pos.z}}
 else 
  return {street1 = GetStreetNameFromHashKey(s1), street2 = GetStreetNameFromHashKey(s2), both = true, pos = {x = pos.x, y = pos.y, z = pos.z}}
 end
end

local zoneNames = {AIRP = "Los Santos International Airport",ALAMO = "Alamo Sea",ALTA = "Alta",ARMYB = "Fort Zancudo",BANHAMC = "Banham Canyon Dr",BANNING = "Banning",BAYTRE = "Baytree Canyon", BEACH = "Vespucci Beach",BHAMCA = "Banham Canyon",BRADP = "Braddock Pass",BRADT = "Braddock Tunnel",BURTON = "Burton",CALAFB = "Calafia Bridge",CANNY = "Raton Canyon",CCREAK = "Cassidy Creek",CHAMH = "Chamberlain Hills",CHIL = "Vinewood Hills",CHU = "Chumash",CMSW = "Chiliad Mountain State Wilderness",CYPRE = "Cypress Flats",DAVIS = "Davis",DELBE = "Del Perro Beach",DELPE = "Del Perro",DELSOL = "La Puerta",DESRT = "Grand Senora Desert",DOWNT = "Downtown",DTVINE = "Downtown Vinewood",EAST_V = "East Vinewood",EBURO = "El Burro Heights",ELGORL = "El Gordo Lighthouse",ELYSIAN = "Elysian Island",GALFISH = "Galilee",GALLI = "Galileo Park",golf = "GWC and Golfing Society",GRAPES = "Grapeseed",GREATC = "Great Chaparral",HARMO = "Harmony",HAWICK = "Hawick",HORS = "Vinewood Racetrack",HUMLAB = "Humane Labs and Research",JAIL = "Bolingbroke Penitentiary",KOREAT = "Little Seoul",LACT = "Land Act Reservoir",LAGO = "Lago Zancudo",LDAM = "Land Act Dam",LEGSQU = "Legion Square",LMESA = "La Mesa",LOSPUER = "La Puerta",MIRR = "Mirror Park",MORN = "Morningwood",MOVIE = "Richards Majestic",MTCHIL = "Mount Chiliad",MTGORDO = "Mount Gordo",MTJOSE = "Mount Josiah",MURRI = "Murrieta Heights",NCHU = "North Chumash",NOOSE = "N.O.O.S.E",OCEANA = "Pacific Ocean",PALCOV = "Paleto Cove",PALETO = "Paleto Bay",PALFOR = "Paleto Forest",PALHIGH = "Palomino Highlands",PALMPOW = "Palmer-Taylor Power Station",PBLUFF = "Pacific Bluffs",PBOX = "Pillbox Hill",PROCOB = "Procopio Beach",RANCHO = "Rancho",RGLEN = "Richman Glen",RICHM = "Richman",ROCKF = "Rockford Hills",RTRAK = "Redwood Lights Track",SanAnd = "San Andreas",SANCHIA = "San Chianski Mountain Range",SANDY = "Sandy Shores",SKID = "Mission Row",SLAB = "Stab City",STAD = "Maze Bank Arena",STRAW = "Strawberry",TATAMO = "Tataviam Mountains",TERMINA = "Terminal",TEXTI = "Textile City",TONGVAH = "Tongva Hills",TONGVAV = "Tongva Valley",VCANA = "Vespucci Canals",VESP = "Vespucci",VINE = "Vinewood",WINDF = "Ron Alternates Wind Farm",WVINE = "West Vinewood",ZANCUDO = "Zancudo River",ZP_ORT = "Port of South Los Santos",ZQ_UAR = "Davis Quartz"}

function GetTheStreet()
    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
    local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(x, y, z, currentStreetHash, intersectStreetHash)
    currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
    intersectStreetName = GetStreetNameFromHashKey(intersectStreetHash)
    zone = tostring(GetNameOfZone(x, y, z))
    playerStreetsLocation = zoneNames[tostring(zone)]

    if not zone then
        zone = "UNKNOWN"
        zoneNames['UNKNOWN'] = zone
    elseif not zoneNames[tostring(zone)] then
        local undefinedZone = zone .. " " .. x .. " " .. y .. " " .. z
        zoneNames[tostring(zone)] = "Undefined Zone"
    end

    if intersectStreetName ~= nil and intersectStreetName ~= "" then
        playerStreetsLocation = currentStreetName .. " | " .. intersectStreetName .. " | " .. zoneNames[tostring(zone)]
    elseif currentStreetName ~= nil and currentStreetName ~= "" then
        playerStreetsLocation = currentStreetName .. " | " .. zoneNames[tostring(zone)]
    else
        playerStreetsLocation = zoneNames[tostring(zone)]
    end

end








--== CDS Reports
RegisterNetEvent("dispatch:atm")
AddEventHandler("dispatch:atm", function()
  print("poo")
 local suspectSex = getSuspectSex()
  TriggerEvent('nrp:dispatch:notify', '10-31', json.encode({{drugsaleSex=suspectSex}}))
 if DecorGetBool(GetPlayerPed(-1), "isOfficer") and isInService then
  TriggerServerEvent('InteractSound_SV:PlayOnSource', 'VTheft', 0.05)
end
end)

RegisterNetEvent('dispatch:atmPos')
AddEventHandler('dispatch:atmPos', function(pos)
  if isInService then
    print("POOOOOO")
		local transG = 250
		local gunshotBlip = AddBlipForCoord(pos.x, pos.y, pos.z)
		SetBlipSprite(gunshotBlip,  1)
		SetBlipColour(gunshotBlip,  46)
		SetBlipAlpha(gunshotBlip,  transG)
		SetBlipAsShortRange(gunshotBlip,  1)
		while transG ~= 0 do
			Wait(250)
			transG = transG - 1
			SetBlipAlpha(gunshotBlip,  transG)
			if transG == 0 then
				SetBlipSprite(gunshotBlip,  2)
				return
			end
		end
  end
  if (exports['core']:GetItemQuantity(161) > 0) and (exports['core']:GetItemQuantity(261) > 0) then 
    TriggerEvent('chatMessage', "RADIO CHATTER ", {255, 0, 0}, "An emergency signal has been picked up on your radio scanner!")
    local transG = 250
    local gunshotBlip = AddBlipForCoord(pos.x, pos.y, pos.z)
    SetBlipSprite(gunshotBlip,  459)
    SetBlipColour(gunshotBlip,  4)
    SetBlipAlpha(gunshotBlip,  transG)
    SetBlipAsShortRange(gunshotBlip,  1)
    while transG ~= 0 do
    Wait(550)
    transG = transG-1
    SetBlipAlpha(gunshotBlip, transG)
    if transG == 0 then
      SetBlipSprite(gunshotBlip,  2)
      return
    end
    end		   
  elseif (exports['core']:GetItemQuantity(161) > 0) and (IsPedInAnyVehicle(GetPlayerPed(-1), false)) then 
    TriggerEvent('chatMessage', "RADIO CHATTER ", {255, 0, 0}, "An emergency signal has been picked up on your radio scanner!")
    local transG = 250
    local gunshotBlip = AddBlipForCoord(pos.x, pos.y, pos.z)
    SetBlipSprite(gunshotBlip,  459)
    SetBlipColour(gunshotBlip,  4)
    SetBlipAlpha(gunshotBlip,  transG)
    SetBlipAsShortRange(gunshotBlip,  1)
    while transG ~= 0 do
     Wait(550)
     transG = transG-1
     SetBlipAlpha(gunshotBlip, transG)
     if transG == 0 then
      SetBlipSprite(gunshotBlip,  2)
      return
     end
    end		   
  end
end)