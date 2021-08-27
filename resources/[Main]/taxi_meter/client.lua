-- Settings
local enableTaxiGui = true -- Enables the GUI (Default: true)
local fareCost = 0.09  --(1.66 = $100 per minute) Cost per second
local costPerMile = 10.0 
local initialFare = 250.0 -- the cost to start a fare

DecorRegister("fares", 1)
DecorRegister("miles", 1)
DecorRegister("meteractive", 2)
DecorRegister("initialFare", 1)
DecorRegister("costPerMile", 1)
DecorRegister("fareCost", 1)

-- NUI Variables
local inTaxi = false
local meterOpen = false
local meterActive = false

-- Open Gui and Focus NUI
function openGui()
  SendNUIMessage({openMeter = true})
end

-- Close Gui and disable NUI
function closeGui()
  SendNUIMessage({openMeter = false})
  meterOpen = false
end

Citizen.CreateThread(function()
  while true do
    Wait(10)
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsIn(ped, false)
    if GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1)))) == "TAXI" then
      TriggerEvent('taxi:updatefare', veh)
      openGui()
      meterOpen = true
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsIn(ped, false)
    if IsPedInAnyTaxi(GetPlayerPed(-1)) and GetPedInVehicleSeat(veh, -1) ~= ped then
      local ped = GetPlayerPed(-1)
      local veh = GetVehiclePedIsIn(ped, false)
      TriggerEvent('taxi:updatefare', veh)
      openGui()
      meterOpen = true
    end
    if meterActive and GetPedInVehicleSeat(veh, -1) == ped then
      local _fare = DecorGetFloat(veh, "fares")
      local _miles = DecorGetFloat(veh, "miles")
      local _fareCost = DecorGetFloat(veh, "fareCost")

      if _fareCost ~= 0 then
        DecorSetFloat(veh, "fares", _fare + _fareCost)
      else
        DecorSetFloat(veh, "fares", _fare + fareCost)
      end
      DecorSetFloat(veh, "miles", _miles + round(GetEntitySpeed(veh) * 0.000621371, 5))
      TriggerEvent('taxi:updatefare', veh)
    end
    if IsPedInAnyTaxi(GetPlayerPed(-1)) and not GetPedInVehicleSeat(veh, -1) == ped then
      TriggerEvent('taxi:updatefare', veh)
    end
  end
end)

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
  if(IsPedInAnyTaxi(GetPlayerPed(-1))) then
    if (inTaxi == false) then
      TriggerEvent('taxi:toggleDisplay')
    end
    inTaxi = true
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsIn(ped, false)
    if(IsPedInAnyTaxi(GetPlayerPed(-1)) and GetPedInVehicleSeat(veh, -1) == ped) then
      if IsControlJustReleased(0, 311)  then -- K
      	openGui()
        TriggerEvent('taxi:toggleHire')
        Citizen.Wait(100)
      end
      if IsControlJustReleased(0,7) then -- L
      	openGui()
        TriggerEvent('taxi:resetMeter')
        TriggerEvent('chatMessage', "CAB-CO", {255, 204, 0}, "Your cab meter has been reset to ^2$"..initialFare)
        Citizen.Wait(100)
      end
    end
  else
    if(meterOpen) then
      closeGui()
    end
    meterOpen = false
  end
 end
end)


function round(num, numDecimalPlaces)
  local mult = 5^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

-- NUI Callback Methods
RegisterNUICallback('close', function(data, cb)
  closeGui()
  cb('ok')
end)

AddEventHandler('taxi:toggleDisplay', function()
  local ped = GetPlayerPed(-1)
  local veh = GetVehiclePedIsIn(ped, false)
  if(IsPedInAnyTaxi(GetPlayerPed(-1)) and GetPedInVehicleSeat(veh, -1) == ped) then
    if meterOpen then
      closeGui()
      meterOpen = false
    else
      local _fare = DecorGetFloat(veh, "fares")
      if _fare < initialFare then
        DecorSetFloat(veh, "fares", initialFare)
      end
      TriggerEvent('taxi:updatefare', veh)
      openGui()
      meterOpen = true
    end
  end
end)

AddEventHandler('taxi:toggleHire', function()
  local ped = GetPlayerPed(-1)
  local veh = GetVehiclePedIsIn(ped, false)
  if(IsPedInAnyTaxi(GetPlayerPed(-1)) and GetPedInVehicleSeat(veh, -1) == ped) then
    if meterActive then
      SendNUIMessage({meterActive = false})
      meterActive = false
      DecorSetBool(veh, "meteractive", false)
      TriggerEvent('chatMessage', "CAB-CO", {255, 204, 0}, "Your cab meter has ^1STOPPED")
    else
      SendNUIMessage({meterActive = true})
      meterActive = true
      DecorSetBool(veh, "meteractive", true)
      TriggerEvent('chatMessage', "CAB-CO", {255, 204, 0}, "Your cab meter has ^2STARTED")
    end
  end
end)

AddEventHandler('taxi:resetMeter', function()
  local ped = GetPlayerPed(-1)
  local veh = GetVehiclePedIsIn(ped, false)
  if(IsPedInAnyTaxi(GetPlayerPed(-1)) and GetPedInVehicleSeat(veh, -1) == ped) then
    local _fare = DecorGetFloat(veh, "fares")
    local _miles = DecorGetFloat(veh, "miles")
    DecorSetFloat(veh, "initialFare", initialFare)
    DecorSetFloat(veh, "costPerMile", costPerMile)
    DecorSetFloat(veh, "fareCost", fareCost)
    DecorSetFloat(veh, "fares", DecorGetFloat(veh, "initialFare"))
    DecorSetFloat(veh, "miles", 0.0)
    TriggerEvent('taxi:updatefare', veh)
  end
end)


-- Send NUI message to update
RegisterNetEvent('taxi:updatefare')
AddEventHandler('taxi:updatefare', function(veh)
  local _fare = DecorGetFloat(veh, "fares")*exports['core']:getVat(3)
  local _miles = DecorGetFloat(veh, "miles")*exports['core']:getVat(3)
  local farecost = _fare + (_miles * DecorGetFloat(veh, "costPerMile"))*exports['core']:getVat(3)

	SendNUIMessage({
		updateBalance = true,
		balance = string.format("%.2f", farecost),
    player = string.format("%.2f", _miles),
   	meterActive = DecorGetBool(veh, "meteractive")
	})
end)

--[[

local npcSearch = false
local activeMission = false
local taxiClient = nil 

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
  if DecorGetInt(GetPlayerPed(-1), "Job") == 4 and IsPedInAnyVehicle(GetPlayerPed(-1), false) then
   if IsControlJustPressed(1, 214) or IsDisabledControlJustPressed(1, 214) then -- DEL
    npcSearch = not npcSearch 
   end

   if npcSearch then 
    NearestNPC()
   end

   if activeMission then 
   	local clientPos = GetEntityCoords(taxiClient, false)
   	local taxiCab = GetVehiclePedIsIn(GetPlayerPed(-1), false)
   	
    if not IsPedInAnyVehicle(taxiClient, false) then
   	 DrawMarker(2, clientPos.x, clientPos.y, clientPos.z+0.25, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
   	 if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), clientPos.x, clientPos.y, clientPos.z, true) < 25 then
   	  TaskEnterVehicle(taxiClient, taxiCab, -1, 1, 2.0, 1)
   	 end
   	end
   end
  end
 end
end)

function NearestNPC()
 if not activeMission then 
  print('Checking')
  local playerCoords = GetEntityCoords(GetPlayerPed(-1))
  local handle, ped = FindFirstPed()
  local success
  local rped = nil
  local distanceFrom
  repeat
   local pos = GetEntityCoords(ped)
   local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
   if canPedBeUsed(ped) and distance < 75.0 and (distanceFrom == nil or distance < distanceFrom) then
    distanceFrom = distance
    rped = ped
   end
   success, ped = FindNextPed(handle)
   Wait(250)
  until not success
  EndFindPed(handle)
  taxiClient = rped
  TriggerEvent('chatMessage', "^4A Client Has Been Found")
  activeMission = true
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

]]