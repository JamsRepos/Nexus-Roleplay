local stopRefueling = false
local fuelPricePerGallon = 1
local hasStation = false
local ownedGasStations = {}
local currentStation = {}
local myCharacterID = 0
local gasStations = {
  [1] = {x = 265.021, y = -1261.426, z = 27.561},
  [2] = {x = 49.413, y = 2778.794, z = 58.044},
  [3] = {x = 264.020, y = 2607.060, z = 45.077},
  [4] = {x = 1039.273, y = 2669.578, z = 39.519},
  [5] = {x = 1207.258, y = 2660.072, z = 38.370},
  [6] = {x = 2539.683, y = 2594.090, z = 37.945},
  [7] = {x = 2676.345, y = 3265.660, z = 55.241},
  [8] = {x = 2003.081, y = 3779.308, z = 32.181},
  [9] = {x = 1690.675, y = 4927.306, z = 42.232},
  [10] = {x = 1703.706, y = 6421.047, z = 32.637},
  [11] = {x = 180.106, y = 6602.975, z = 31.869},
  [12] = {x = -89.964, y = 6415.001, z = 31.542},
  [13] = {x = -2554.844, y = 2334.303, z = 33.078},
  [14] = {x = -1800.208, y = 803.479, z = 138.651},
  [15] = {x = -1436.596, y = -276.069, z = 46.208},
  [16] = {x = -2096.601, y = -319.175, z = 13.169},
  [17] = {x = -723.442, y = -932.854, z = 19.214},
  [18] = {x = -525.397, y = -1211.845, z = 18.185},
  [19] = {x = -68.785, y = -1760.784, z = 29.428},
  [20] = {x = 818.003, y = -1028.854, z = 26.327},
  [21] = {x = 1208.343, y = -1402.372, z = 35.224},
  [22] = {x = 1181.144, y = -329.479, z = 69.280},
  [23] = {x = 620.661, y = 268.569, z = 103.089},
  [24] = {x = 2580.882, y = 361.810, z = 108.469},
 }

local fuelBlacklist = {
 [1] = 'BMX',
 [2] = 'SCORCHER',
 [3] = 'FIXTER',
 [4] = 'CRUISER', 
}

 DecorRegister("_Fuel_Level", 3);
 DecorRegister("_Max_Fuel_Level", 3);

-- \o/ Gas Cans!!!!!!
-- Refueling Vehicles At Gas Stations
Citizen.CreateThread(function()
 while true do
  local ped = PlayerPedId() 
  Citizen.Wait(5)
  if not IsPedInAnyVehicle(ped, false) then
   if HasPedGotWeapon(ped, GetHashKey('WEAPON_PETROLCAN')) then 
    if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PETROLCAN") then
     local pos = GetEntityCoords(ped)
     local vehicle = GetClosestVehicle(pos.x, pos.y, pos.z, 3.0, 0, 71)
     if DoesEntityExist(vehicle) then 
      DrawText3Ds(pos.x, pos.y, pos.z,"~g~[E]~w~ Refuel ")
      if IsControlJustPressed(0, 38) then 
       local vehicleFuel = DecorGetInt(vehicle, "_Fuel_Level")
       if vehicleFuel < 45000 then 
        loadAnimDict("weapon@w_sp_jerrycan") 
        TaskPlayAnim(GetPlayerPed(-1), "weapon@w_sp_jerrycan", "fire", 1.0, 2, -1, 49, 0, 0, 0, 0)
        FreezeEntityPosition(GetPlayerPed(-1), true)
        Citizen.Wait(15000)
        FreezeEntityPosition(GetPlayerPed(-1), false)
        ClearPedTasksImmediately(ped)
        RemoveWeaponFromPed(ped, GetHashKey("WEAPON_PETROLCAN"))
        TriggerEvent("inventory:removeQty", 205, 1)
        TriggerServerEvent('fuel:removePetrolCan')
        local newFuel = (vehicleFuel + 50000)
        DecorSetInt(vehicle, "_Fuel_Level", newFuel)  
       else 
        exports['NRP-notify']:DoHudText('error', "Vehicle Must Have Less Than 45% Fuel") 
       end 
      end
     end
    end 
   end
  else 
   Citizen.Wait(2500)
  end
 end
end)

-- Burning Fuel
function initFuelRandom(vehicle)
  local randomFuel = math.random(25000,55000)
  DecorSetInt(vehicle, "_Fuel_Level", randomFuel)
  DecorSetInt(vehicle, "_Max_Fuel_Level", 100000)
end

function fuelCheckEmpty(vehicle)
 local currentFuel = DecorGetInt(vehicle, "_Fuel_Level")
 if currentFuel < 1 then
  SetVehicleEngineOn(vehicle, false, true, false)
  SetVehicleUndriveable(vehicle, true)
 end
end

function burnFuel(vehicle)
 if GetIsVehicleEngineRunning(vehicle) == 1 then
  if canVehicleUseFuel(vehicle) then 
   local currentFuel = DecorGetInt(vehicle, "_Fuel_Level")
   local speed = GetEntitySpeed(vehicle)
   local speedMph = math.ceil(speed * 2.236936)
   if speedMph < 5 then
    burnRate = 5
   else
    burnRate = speedMph
   end
   local afterFuelBurn = (currentFuel - burnRate)
   DecorSetInt(vehicle, "_Fuel_Level", afterFuelBurn)
  end
 end
end

function canVehicleUseFuel(vehicle)
 local isUsing = true
 for i=1, #fuelBlacklist do 
  if GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)) == fuelBlacklist[i] then 
   isUsing = false
  end
 end
 return isUsing
end

Citizen.CreateThread(function()
 while true do
  local ped = PlayerPedId()
  local vehicle = GetVehiclePedIsIn(ped, false)
  if IsPedInAnyVehicle(ped, false) and GetPedInVehicleSeat(vehicle, -1) == ped then
   if not DecorExistOn(vehicle, "_Fuel_Level") then
    initFuelRandom(vehicle)
   else
    burnFuel(vehicle)
   end
   fuelCheckEmpty(vehicle)
  end
  Wait(1000)
 end
end)

function loadAnimDict(dict)
  while(not HasAnimDictLoaded(dict)) do
    RequestAnimDict(dict)
    Citizen.Wait(1)
  end
end

-- Owning Fuel Stations
RegisterNetEvent('fuel:updateStations')
AddEventHandler('fuel:updateStations', function(owned, id)
 ownedGasStations = owned
 myCharacterID = id
end)

Citizen.CreateThread(function()
  WarMenu.CreateLongMenu('gasStation', 'Gas Station')
  WarMenu.CreateLongMenu('buyFuel', 'Gas Station')
  while true do
   Citizen.Wait(5)
   -- Menu
   if WarMenu.IsMenuOpened('gasStation') then
    if WarMenu.Button('Fuel Level', currentStation.fuel) then 
     WarMenu.OpenMenu('buyFuel')
    elseif WarMenu.Button('Fuel Price', '~g~$'..currentStation.price) then
     local newfuel = getResult()
     if newfuel <= 10 or newfuel >= 5 then
      TriggerServerEvent('fuel:updatefuel', newfuel, currentStation.id) 
     else
      exports['NRP-notify']:DoHudText('error', 'You cannot set your fuel price lower than $5 or higher than $10.')

     end
     WarMenu.CloseMenu()
    elseif WarMenu.Button('Station Bank', '~g~$'..currentStation.bank) then
     TriggerServerEvent('fuel:takeBank', currentStation.bank, currentStation.id) 
     WarMenu.CloseMenu()
    elseif WarMenu.Button('~r~Sell Station', '~g~$'..currentStation.station_price/2) then
     TriggerServerEvent('fuel:sell', currentStation.id, currentStation.station_price/2)
     WarMenu.CloseMenu()
    end
    WarMenu.Display()
   elseif WarMenu.IsMenuOpened('buyFuel') then
    if WarMenu.Button('1K Gallons', '~g~$500') then 
     TriggerServerEvent('fuel:buyFuel', currentStation.id, 500, 500)
     WarMenu.CloseMenu()
    elseif WarMenu.Button('2.5K Gallons', '~g~$1250') then 
     TriggerServerEvent('fuel:buyFuel', currentStation.id, 1250, 1250)
     WarMenu.CloseMenu()
    elseif WarMenu.Button('5K Gallons', '~g~$2500') then 
     TriggerServerEvent('fuel:buyFuel', currentStation.id, 2500, 2500)
     WarMenu.CloseMenu()
    elseif WarMenu.Button('10K Gallons', '~g~$5000') then 
     TriggerServerEvent('fuel:buyFuel', currentStation.id, 5000, 5000)
     WarMenu.CloseMenu()
    elseif WarMenu.Button('50K Gallons', '~g~$25000') then 
     TriggerServerEvent('fuel:buyFuel', currentStation.id, 25000, 25000)
     WarMenu.CloseMenu()
    elseif WarMenu.Button('250K Gallons', '~g~$125000') then 
     TriggerServerEvent('fuel:buyFuel', currentStation.id, 125000, 125000)
     WarMenu.CloseMenu()
    end
    WarMenu.Display()
   end
  end
 end)


function getResult()
 DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 6)
  while (UpdateOnscreenKeyboard() == 0) do
    DisableAllControlActions(0);
    Wait(0);
  end
  if (GetOnscreenKeyboardResult()) then
    local result = GetOnscreenKeyboardResult()
    return tonumber(result)
  end
end

function getMaxFuel(veh)
 if DecorExistOn(veh, "_Max_Fuel_Level") then 
  if DecorGetInt(veh, "_Max_Fuel_Level") < 100000 then
   return 100000
  else 
   return DecorGetInt(veh, "_Max_Fuel_Level")
  end
 else
  return 100000
 end
end

local isNearStation = false
local currentID = 0
local hold = false
local isPlayingAnimation = false 
local vehicleFuel = 0 

Citizen.CreateThread(function()
 for _, item in pairs(gasStations) do
  item.blip = AddBlipForCoord(item.x, item.y, item.z)
  SetBlipSprite(item.blip, 361)
  SetBlipScale(item.blip, 0.6)
  SetBlipAsShortRange(item.blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Gas Station')
  EndTextCommandSetBlipName(item.blip)
 end
 while true do
  Citizen.Wait(5)      -- needs fixing xzurv 
  for id,v in pairs(gasStations) do  
   if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), v.x, v.y, v.z, true) < 10 and IsPedOnFoot(PlayerPedId()) and GetInteriorFromEntity(PlayerPedId()) == 0 and DoesEntityExist(GetVehiclePedIsIn(PlayerPedId(), true)) then 
    isNearStation = true
    currentID = id
  elseif not IsPedOnFoot(PlayerPedId()) or IsPedRunning(PlayerPedId()) then 
    isNearStation = false
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


Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
  if isNearStation and not ownedGasStations[currentID] then  
   local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
   local vehCoords = GetEntityCoords(vehicle, true)
   --if GetVehiclePedIsIn(PlayerPedId(), true) then 
   DrawMarker(2, vehCoords.x, vehCoords.y, vehCoords.z+2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.4, 255, 255, 0, 50, true, true, 0, true, nil, nil, false)
   if not hold then DrawText3Ds(vehCoords.x, vehCoords.y, vehCoords.z,"~g~[E]~w~ Refuel ~g~[$"..fuelPricePerGallon.."]") else DrawText3Ds(vehCoords.x, vehCoords.y, vehCoords.z+0.5,"~g~Refueling") end    
   if IsControlJustPressed(0, 38) and not stopRefueling then vehicleFuel = DecorGetInt(vehicle, "_Fuel_Level") hold = false end
   if IsControlPressed(0, 38) and not stopRefueling then 
    hold = true
    --DisableControlAction(0, 200, true)
    if DecorGetInt(vehicle, "_Fuel_Level") < getMaxFuel(vehicle) then 
     stopRefueling = false
     refuelingVehicle = true
    end
   elseif IsControlJustReleased(0, 38) and not stopRefueling then 
    if DoesEntityExist(vehicle) then 
     refuelingVehicle = false hold = false stopRefueling = false Wait(100)
     TriggerServerEvent('fuel:pay', vehicleFuel, DecorGetInt(vehicle, "_Fuel_Level"), fuelPricePerGallon)
     isPlayingAnimation = false 
     ClearPedTasksImmediately(PlayerPedId())
    end
   elseif IsControlJustReleased(0, 38) and stopRefueling then 
    if DoesEntityExist(vehicle) then 
     refuelingVehicle = false hold = false stopRefueling = false Wait(100)
     TriggerServerEvent('fuel:pay', vehicleFuel, DecorGetInt(vehicle, "_Fuel_Level"), fuelPricePerGallon)
     isPlayingAnimation = false
     ClearPedTasksImmediately(PlayerPedId())
    end
   else 
    hold = false
   end
   DrawText3Ds(vehCoords.x, vehCoords.y, vehCoords.z,'\n~g~[K]~w~ Purchase Gas Station ~g~[~g~$200000]')
   if IsControlJustPressed(0, 311) then
    for _, item in pairs(ownedGasStations) do
      if item.char_id == myCharacterID then
        hasStation = true
      end
    end
    if hasStation then
      exports['NRP-notify']:DoHudText('error', 'You cannot purchase this as you already have a gas station.') 
    else
      TriggerServerEvent('fuel:purchase', currentID)
    end
   end
  else 
   Citizen.Wait(2500)
  end 
 --[[elseif GetVehiclePedIsIn(PlayerPedId(), false) and isNearStation and not ownedGasStations[currentID] then 
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
    local vehCoords = GetEntityCoords(vehicle, true)
    DrawText3Ds(vehCoords.x, vehCoords.y, vehCoords.z, "Exit to fuel your vehicle")
  end ]] 
  end
end) 

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
  if isNearStation and ownedGasStations[currentID] then  
   local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
   local vehCoords = GetEntityCoords(vehicle, true)
   DrawMarker(2, vehCoords.x, vehCoords.y, vehCoords.z+2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.4, 255, 255,0, 100, true, true, 0, true, nil, nil, false)
   if ownedGasStations[currentID].fuel > 5 then 
    if not hold then DrawText3Ds(vehCoords.x, vehCoords.y, vehCoords.z,"~g~[E]~w~ Refuel [~g~$"..ownedGasStations[currentID].price.."~w~]") else DrawText3Ds(vehCoords.x, vehCoords.y, vehCoords.z,"~g~Refueling") end    
    if IsControlJustPressed(0, 38) and not stopRefueling then vehicleFuel = DecorGetInt(vehicle, "_Fuel_Level") hold = false end
    if IsControlPressed(0, 38) and not stopRefueling then 
     hold = true
     if DecorGetInt(vehicle, "_Fuel_Level") < getMaxFuel(vehicle) then 
      stopRefueling = false
      refuelingVehicle = true
     end
    elseif IsControlJustReleased(0, 38) and not stopRefueling then 
     if DoesEntityExist(vehicle) then 
      refuelingVehicle = false hold = false stopRefueling = false Wait(100)
      TriggerServerEvent('fuel:payOwners', vehicleFuel, DecorGetInt(vehicle, "_Fuel_Level"), ownedGasStations[currentID])
      TriggerServerEvent('fuel:updateStations')
      isPlayingAnimation = false 
      ClearPedTasksImmediately(PlayerPedId())
     end
    elseif IsControlJustReleased(0, 38) and stopRefueling then 
     if DoesEntityExist(vehicle) then 
      refuelingVehicle = false hold = false stopRefueling = false Wait(100)
      TriggerServerEvent('fuel:payOwners', vehicleFuel,DecorGetInt(vehicle, "_Fuel_Level"), ownedGasStations[currentID])
      TriggerServerEvent('fuel:updateStations')
      isPlayingAnimation = false
      ClearPedTasksImmediately(PlayerPedId())
     end
    else 
     hold = false
    end
   else 
    DrawText3Ds(vehCoords.x, vehCoords.y, vehCoords.z,"~r~Gas Station Is Out Of Fuel") 
   end
  -- Owner Stuffz
   if ownedGasStations[currentID].char_id == myCharacterID then 
    DrawText3Ds(vehCoords.x, vehCoords.y, vehCoords.z,"\n~g~[H]~w~ Manage Gas Station") 
    if IsControlJustPressed(0, 74) then 
     currentStation = ownedGasStations[currentID]
     WarMenu.OpenMenu('gasStation')
    end
   else 
    DrawText3Ds(vehCoords.x, vehCoords.y, vehCoords.z,"\n~w~Station Owned") 
   end
  else 
   Citizen.Wait(2500)
  end
 end
end) 

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(0)
  if refuelingVehicle and hold then
   local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
   DecorSetInt(vehicle, "_Fuel_Level", tonumber(DecorGetInt(vehicle, "_Fuel_Level") + 25))
 
   if not isPlayingAnimation then 
    loadAnimDict("weapon@w_sp_jerrycan") 
    TaskPlayAnim(PlayerPedId(), "weapon@w_sp_jerrycan", "fire", 1.0, 2, -1, 49, 0, 0, 0, 0)
    isPlayingAnimation = true 
   end

   -- Drawing 
   local currentfuel = DecorGetInt(vehicle, "_Fuel_Level") * 0.001
   drawUI(0.514, 1.436, 1.0, 1.0, 0.42, "~g~FUEL ~w~"..round(currentfuel, 1).."%", 255, 255, 255, 255, false)
   --DrawText3Ds(vehicle.x, vehicle.y, vehicle.z+0.3,"~g~FUEL ~w~"..round(currentfuel, 1).."%")
   DisableControlAction(0, 23, true) -- INPUT_VEH_EXIT
   DisableControlAction(0, 20, true) -- Disable Z Menu

   if DecorGetInt(vehicle, "_Fuel_Level") == getMaxFuel(vehicle) then
    refuelingVehicle = false
    DecorSetInt(vehicle, "_Fuel_Level", getMaxFuel(vehicle))
    stopRefueling = true 
    TriggerEvent('chatMessage', "Fuel", {255, 0, 0}, "Your tank is full!")
    ClearPedTasksImmediately(PlayerPedId())
   elseif DecorGetInt(vehicle, "_Fuel_Level") > getMaxFuel(vehicle) then
    TriggerEvent('chatMessage', "Fuel", {255, 0, 0}, "Your tank is full!")
    ClearPedTasksImmediately(PlayerPedId())
    refuelingVehicle = false
    DecorSetInt(vehicle, "_Fuel_Level", getMaxFuel(vehicle))
    stopRefueling = true 
   end
  else
    refuelingVehicle = false
    hold = false
    if isPlayingAnimation then
      ClearPedTasksImmediately(PlayerPedId())
      isPlayingAnimation = false
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
 SetTextEdge(2, 0, 0, 0, 255)
 SetTextDropShadow()
 SetTextOutline()
 SetTextEntry("STRING")
 AddTextComponentString(text)
 DrawText(x - width/2, y - height/2 + 0.005)
end

function round(num, dec)
  local mult = 10^(dec or 0)
  return math.floor(num * mult + 0.5) / mult
end


RestrictEmer = false -- Only allow this feature for emergency vehicles.
keepDoorOpen = true -- Keep the door open when getting out.

--- Code ---
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = GetPlayerPed(-1)
        local veh = GetVehiclePedIsIn(ped, false)

        if RestrictEmer then
            if GetVehicleClass(veh) == 18 then
                if IsPedInAnyVehicle(ped, false) and IsControlPressed(2, 75) and not IsEntityDead(ped) then
                    Citizen.Wait(150)
                    if IsPedInAnyVehicle(ped, false) and IsControlPressed(2, 75) and not IsEntityDead(ped) then
                        SetVehicleEngineOn(veh, true, true, false)
                        if keepDoorOpen then
                            TaskLeaveVehicle(ped, veh, 256)
                        else
                            TaskLeaveVehicle(ped, veh, 0)
                        end
                    end
                end
            end
        else
            if IsPedInAnyVehicle(ped, false) and IsControlPressed(2, 75) and not IsEntityDead(ped) then
                Citizen.Wait(150)
                if IsPedInAnyVehicle(ped, false) and IsControlPressed(2, 75) and not IsEntityDead(ped) then
                    SetVehicleEngineOn(veh, true, true, false)
                    if keepDoorOpen then
                        TaskLeaveVehicle(ped, veh, 256)
                    else
                        TaskLeaveVehicle(ped, veh, 0)
                    end
                end
            end
        end
	end
end)

Citizen.CreateThread(function()
  while true do
      Citizen.Wait(500)
      local ped = GetPlayerPed(-1)
      local veh = GetVehiclePedIsUsing(ped)
      
      if IsPedInAnyVehicle(ped, false) then
          if not GetVehicleTyresCanBurst(veh) then
              SetVehicleTyresCanBurst(veh, true)
          end
      end
   end
end)