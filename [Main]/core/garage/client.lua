local user_vehicles = {}                                                                                                             --
local user_garages = {}   
local insured_vehicles = {}
local slotprice = 500
local currentgaragecost = 0 
local selectedgarage = {}
local balla = DecorGetInt(GetPlayerPed(-1), "Faction") == 1
local garages = {  
    [1] = {name="Public Garage", colour=1, x = 351.129, y = -1685.806, z = 32.530, id=1, gname="[1] Macdonald Street", cost=0, heading=360.0, maxslots=5, type='Public', hidden=false}, -- Public Upper City
    [2] = {name="Public Garage", colour=1, x=-443.00497436523,y=185.29835510254,z=75.203712463379, id=2, gname="[2] Eclipse Boulevard", cost=0, heading=0.0, maxslots=5, type='Public', hidden=false}, -- Public Upper City
    [3] = {name="Public Garage", colour=1, x=1232.4792480469,y=2708.3212890625,z=38.005790710449, id=3, gname="[3] Route 68", cost=0, heading=0.0, maxslots=5, type='Public', hidden=false}, -- Public Sandy
    [4] = {name="Public Garage", colour=1, x=-294.412, y=6123.858, z=31.500, id=4, gname="[4] Great Ocean Highway", cost=0, heading=-90.0, maxslots=5, type='Public', hidden=false}, -- Public Paleto
    [5] = {name="Public Garage", colour=1, x=1737.714, y = 3719.109, z = 34.044,id=5, gname="[5] Mountain View", cost=0, heading=-90.0, maxslots=5, type='Public', hidden=false}, -- Public Paleto
    [6] = {name="Public Garage", colour=1, x=213.075, y = -795.764, z = 30.861, id=6, gname="[6] Legion Garage", cost=0, heading=342.95, maxslots=5, type='Public', hidden=false}, -- Public Legion
  }

local repairprice = {
  [0] = 25, --Compact
  [1] = 10, --Sedan
  [2] = 15, --SUV
  [3] = 20, --Coupes
  [4] = 25, --Muscle
  [5] = 25, --Sports Classics
  [6] = 55, --Sports
  [7] = 65, --Super
  [8] = 15, --Motorcycles
  [9] = 15, --Off-road
  [10] = 15, --Industrial
  [11] = 15, --Utility
  [12] = 15, --Vans
  [17] = 15, --Service
  [18] = 15, --Emergency
  [20] = 15, --Commercial
}

local function round(num, idp)
  if idp and idp>0 then
    local mult = 10^idp
    return math.floor(num * mult + 0.5) / mult
  end
  return math.floor(num + 0.5)
end


Citizen.CreateThread(function()
 addGarageBlips()
 WarMenu.CreateLongMenu('garage', 'Garage')
 WarMenu.CreateLongMenu('vehicle_list', 'Vehicles')
 WarMenu.CreateLongMenu('modify_garages', 'Garages')
 WarMenu.CreateLongMenu('modify_garages2', 'Garages')
 WarMenu.CreateLongMenu('modify_garages_veh', 'Garages')
 WarMenu.CreateLongMenu('give_vehicles_players', 'Garages')
 WarMenu.CreateLongMenu('impound_yard', 'Impound')
 WarMenu.CreateLongMenu('purchase_insurance', 'Insurance')
 local currentItemIndex = 1
 local PurchasedSlots = 1 
 while true do
  Citizen.Wait(5)
  if WarMenu.IsMenuOpened('garage') then
   local t = true
   for i = 1, #user_garages do
    if user_garages[i].id == currentgarage.id and t then
     currentgaragecost = currentgarage.cost
     t = false
    end
   end
   if t then 
    local slots = {}
    for i = 1, currentgarage.maxslots do
     table.insert(slots, ""..i)
    end
    if WarMenu.Button(currentgarage.gname, '~g~$'..currentgaragecost) then
     TriggerServerEvent("garage:buy", currentgaragecost, currentgarage.id, PurchasedSlots)
    elseif WarMenu.ComboBox('Slots', slots, currentItemIndex, PurchasedSlots, function(currentIndex)
     currentItemIndex = currentIndex 
     PurchasedSlots = currentIndex
     currentgaragecost = math.floor(currentgarage.cost + slotprice * (PurchasedSlots - 1))
     end) then
    end
   else

    local vehiclesOut = 0
    for i = 1,#user_vehicles do
      if (user_vehicles[i] ~= nil) then
       if user_vehicles[i].garage == currentgarage.id then
        if user_vehicles[i].impound or not user_vehicles[i].stored then
          vehiclesOut = vehiclesOut + 1
        end
       end
      end
     end

    local restoreprice = vehiclesOut * 1000
    if WarMenu.Button('Restore Cars ~g~$'..restoreprice) and IsPedOnFoot(GetPlayerPed(-1)) then
      if vehiclesOut >= 1 then
        exports['NRP-notify']:DoHudText('success', 'DMV: Please wait whilst we recover your vehicles.')
        Wait(5000)
        TriggerServerEvent('garagepayment:removemoney', restoreprice)
      else
        exports['NRP-notify']:DoHudText('error', 'You cannot restore any vehicles when they are already stored!')
      end
    elseif WarMenu.Button('List Vehicles', getCarQ().."/"..getGarageQ()) then
      WarMenu.OpenMenu('vehicle_list')
    end
   end
   WarMenu.Display()
  elseif WarMenu.IsMenuOpened('vehicle_list') then
   for i = 1,#user_vehicles do
    if (user_vehicles[i] ~= nil) then
     if user_vehicles[i].garage == currentgarage.id then
      if user_vehicles[i].stored and not user_vehicles[i].impound then
       if WarMenu.Button(user_vehicles[i].model,'~g~Stored') then
        SpawnVehicle(user_vehicles[i])
        SetVehicleOnGroundProperly(vehicle)
        --SetVehicleFixed(vehicle)
        --SetVehicleDirtLevel(vehicle, 0.0)
        WarMenu.CloseMenu()
       end
      else
       if WarMenu.Button(user_vehicles[i].model,'~r~Out') then
        exports['NRP-notify']:DoHudText('error', 'Your vehicle is not in this garage, you will need this to be recovered! If your vehicle has been impounded you will need to release at the impound!')
       end
      end
     end
    end
   end
   WarMenu.Display()
  elseif WarMenu.IsMenuOpened('modify_garages') then
   for i = 1,#user_garages do
    if WarMenu.Button(tostring(garages[user_garages[i].id].gname), tostring(garages[user_garages[i].id].type)) then 
     selectedgarage = {}
     selectedgarage = user_garages[i]
     WarMenu.OpenMenu('modify_garages2')
    end
   end
   WarMenu.Display()
  elseif WarMenu.IsMenuOpened('modify_garages2') then
   local slots = {}
   for a = (selectedgarage.count + 1), (garages[selectedgarage.id].maxslots) do
    table.insert(slots, ""..a)
   end
   if WarMenu.Button('Transfer Vehicle') then
    WarMenu.OpenMenu('modify_garages_veh')
   end
   --[[if selectedgarage.id > 4 then
    if WarMenu.Button('Sell Garage', '~g~$'..selectedgarage.cost) then
     TriggerServerEvent("garage:sellgarage", selectedgarage.id)
    end
   end
   --]]
   if selectedgarage.count ~= garages[selectedgarage.id].maxslots then
    if WarMenu.ComboBox('Increase Slots To ', slots, currentItemIndex, PurchasedSlots, function(currentIndex)
     currentItemIndex = currentIndex 
     PurchasedSlots = currentIndex
     currentgaragecost = math.floor(slotprice * PurchasedSlots)
     end) then
    elseif WarMenu.Button('Buy Slots', '~g~$'..currentgaragecost) then
     TriggerServerEvent("garage:buyslots", currentgaragecost, selectedgarage.id, (PurchasedSlots + selectedgarage.count))
    end
   end
   WarMenu.Display()
  elseif WarMenu.IsMenuOpened('modify_garages_veh') then
   for i = 1, #user_vehicles do
    if WarMenu.Button(user_vehicles[i].model, user_vehicles[i].plate) then  
     local count = 0
     for a = 1,#user_vehicles do
      if user_vehicles[a].cg == selectedgarage.id then
       count = count + 1
      end
     end
     local actualslots = selectedgarage.count
     if count <= actualslots then 
      if user_vehicles[i].stored then
       TriggerServerEvent("garage:transfer", user_vehicles[i].plate, selectedgarage.id)
      else
       exports['NRP-notify']:DoHudText('error', 'Vehicle Must Be Stored')
      end
     else
       exports['NRP-notify']:DoHudText('error', 'Garage Full, You Can Buy More Slots At The Vehicle Shop')
     end
    end
   end
   WarMenu.Display()
  elseif WarMenu.IsMenuOpened('impound_yard') then
   for i = 1, #user_vehicles do
    if (user_vehicles[i] ~= nil) then
     if user_vehicles[i].impound then
      if WarMenu.Button(user_vehicles[i].model, '~g~$'..(user_vehicles[i].price/10)) then
       TriggerServerEvent("garage:impound", user_vehicles[i], user_vehicles[i].price/10)
      end
     end
    end
   end
   WarMenu.Display()
  elseif WarMenu.IsMenuOpened('purchase_insurance') then -- add insurance with this
   for i = 1, #user_vehicles do
    if (user_vehicles[i] ~= nil) then
     if not user_vehicles[i].insured then
      if WarMenu.Button(user_vehicles[i].model, '~g~$'..math.floor(user_vehicles[i].price/10*getVat(5)).." WKLY") then
       TriggerServerEvent("garage:insure", user_vehicles[i].plate, user_vehicles[i].price/10*getVat(5))
      end
     else
      if WarMenu.Button(user_vehicles[i].model.." ["..user_vehicles[i].plate.."]", '~g~Insured') then
      end
     end
    end
   end
   WarMenu.Display()
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
  Wait(5)
  local coords = GetEntityCoords(GetPlayerPed(-1))
  for k,v in pairs(garages) do
   if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 25) and not IsPedInAnyVehicle(GetPlayerPed(-1)) then
    DrawMarker(2, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, 0.3,0.3,0.3, 255, 255, 0, 100, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 3.0) then
     DrawText3Ds(v.x, v.y, v.z+0.35,'~g~[E]~w~ Garage')
     if IsControlJustPressed(0, 38) then
      WarMenu.OpenMenu('garage')
      currentgarage = garages[k]
     end
    else
    if WarMenu.IsMenuOpened('garage') then
      WarMenu.CloseMenu('garage')
    end
    end
   elseif(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 25) and IsPedInAnyVehicle(GetPlayerPed(-1)) then
    DrawMarker(2, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, 0.3,0.3,0.3, 255, 255, 0, 100, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 3.0) then
      local veh = GetVehiclePedIsUsing(GetPlayerPed(-1))
      local maxvehhp = 1000
      local damage = 0 
      local enginedamage = 0
      damage = (maxvehhp - GetVehicleBodyHealth(veh))/100
      enginedamage = (maxvehhp - GetVehicleEngineHealth(veh))
     DrawText3Ds(v.x, v.y, v.z+0.35,'~g~[ENTER]~w~ Store Vehicle\n~g~Repair Costs: ~w~$'..round(repairprice[GetVehicleClass(veh)]*damage+enginedamage*2,0))
     if IsControlJustPressed(0, 176) then
      currentgarage = garages[k]
      SetVehicleForwardSpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
      StoreVehicle()
     end
    end
   elseif(GetDistanceBetweenCoords(coords, -56.352, -1089.531, 26.422, true) < 25) then
    DrawMarker(2, -56.352, -1089.531, 25.425, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 255, 255, 0, 100, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(coords, -56.352, -1089.531, 26.422, true) < 1.75) then
     DrawText3Ds(-56.352, -1089.531, 26.422,'~g~[E]~w~ Modify Garages')
     if IsControlJustPressed(0, 38) then
      WarMenu.OpenMenu('modify_garages')
     end
    else
      if WarMenu.IsMenuOpened('modify_garages') then
        WarMenu.CloseMenu('modify_garages')
      end
    end
   elseif(GetDistanceBetweenCoords(coords, 413.791, -1617.023, 28.341, true) < 25) then
    DrawMarker(2, 413.791, -1617.023, 28.341, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 255, 255, 0, 100, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(coords, 413.791, -1617.023, 28.341, true) < 1.35) then
     DrawText3Ds(413.791, -1617.023, 28.341,'~g~[E]~w~ Impound')
     if IsControlJustPressed(0, 38) then
      currentgarage = {x=395.98846435547, y=-1644.5775146484, z=29.291948318481, heading=100}
      WarMenu.OpenMenu('impound_yard')
     end
    else
      if WarMenu.IsMenuOpened('impound_yard') then
        WarMenu.CloseMenu('impound_yard')
      end
    end
   end
  end
 end
end)

function getCarQ()
    local count = 0
    for i=1,#user_vehicles do
        if user_vehicles[i].garage == currentgarage.id then
            count = count + 1
        end
    end
    return count
end

function getGarageQ()
    for i=1,#user_garages do
        if user_garages[i].id == currentgarage.id then
            return user_garages[i].count
        end
    end
end

RegisterNetEvent("garage:refresh")
AddEventHandler("garage:refresh", function(data, gdata, idata)
 user_vehicles = data
 user_garages = gdata
 insured_vehicles = idata
end)

function StoreVehicle()
 local vehicle = nil
 local coords = GetEntityCoords(GetPlayerPed(-1))
 if IsPedInAnyVehicle(GetPlayerPed(-1), false) then vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false) else vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71) end      
 local components = GetVehProps(vehicle)
 local fuel = DecorGetInt(vehicle, "_Fuel_Level") --- change this bozo
 for i = 1, #user_vehicles do
  components.plate = components.plate:gsub('[%p%c%s]', '') -- We do this to fix custom plates for some odd reason
  if tostring(components.plate) == tostring(user_vehicles[i].plate) then
   local count = 0
   for a = 1,#user_vehicles do
    if user_vehicles[a].garage == currentgarage.id then
     count = count + 1
    end
   end
   local actualslots
   for b = 1,#user_garages do
    if user_garages[b].id == currentgarage.id then
     actualslots = user_garages[b].count
    end
   end
   if count <= actualslots then
    local maxvehhp = 1000
    local damage = 0 
    local enginedamage = 0
    damage = (maxvehhp - GetVehicleBodyHealth(vehicle))/100
    enginedamage = (maxvehhp - GetVehicleEngineHealth(vehicle))
    local price = round(repairprice[GetVehicleClass(veh)]*damage+enginedamage*2,0)
    TriggerServerEvent("garage:store", components, currentgarage.id, fuel, price)
    TriggerEvent('persistent-vehicles/forget-vehicle', vehicle)
    SetEntityAsMissionEntity(vehicle, true, true)
    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
    exports['NRP-notify']:DoHudText('success', 'Vehicle Stored & Repaired')
   else
    exports['NRP-notify']:DoHudText('error', 'Garage Full, You can buy more slots at the vehicle shop!')
   end
  end
 end
end

function SpawnVehicle(data)
 local coords = GetEntityCoords(GetPlayerPed(-1), false)
 RequestModel(data.components.model)
 while not HasModelLoaded(data.components.model) do
  Citizen.Wait(0)
 end
 vehicle = CreateVehicle(data.components.model, coords.x, coords.y, coords.z, currentgarage.heading, true, false)
 DecorRegister("_Fuel_Level", 3);
 DecorRegister("_Max_Fuel_Level", 3);
 if data.components.maxFuelLevel ~= nil or 0 then  ----PETROL FIX
  DecorSetInt(vehicle, "_Max_Fuel_Level", data.components.maxFuelLevel)
 else
 DecorSetInt(vehicle, "_Max_Fuel_Level", 100000)
 end
 if data.fuel <= 10000 or data.fuel == nil then
  DecorSetInt(vehicle, "_Fuel_Level", 10000)
 else
  DecorSetInt(vehicle, "_Fuel_Level", data.fuel)
 end
 SetVehicleProperties(vehicle, data.components)
 TriggerServerEvent("garage:out", data)
 TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
 SetVehicleEngineOn(vehicle, true)
 SetVehicleHasBeenOwnedByPlayer(vehicle, true)
 SetEntityAsMissionEntity(vehicle, true, true)
 TriggerEvent('persistent-vehicles/register-vehicle', vehicle)
 exports["onyxLocksystem"]:givePlayerKeys(GetVehicleNumberPlateText(vehicle))
end

function addGarageBlips()
 for k,v in ipairs(garages)do
  if not v.hidden then 
   local blip = AddBlipForCoord(v.x, v.y, v.z)
   SetBlipSprite (blip, 357)
   SetBlipDisplay(blip, 4)
   SetBlipScale  (blip, 0.8)
   SetBlipColour (blip, 3)
   SetBlipAsShortRange(blip, true)
   BeginTextCommandSetBlipName("STRING")
   AddTextComponentString(v.name)
   EndTextCommandSetBlipName(blip)
  end
 end
-- Impound Yard
 local blip = AddBlipForCoord(401.239, -1632.444, 29.291)
 SetBlipSprite(blip, 68)
 SetBlipDisplay(blip, 4)
 SetBlipScale(blip, 0.8)
 SetBlipColour(blip, 64)
 SetBlipAsShortRange(blip, true)
 BeginTextCommandSetBlipName("STRING")
 AddTextComponentString('Impound Yard')
 EndTextCommandSetBlipName(blip)
end

RegisterNetEvent("garage:spawn")
AddEventHandler("garage:spawn", function(data)
 SpawnVehicle(data)
end)

RegisterNetEvent("garage:store")
AddEventHandler("garage:store", function(data)
 StoreVehicle()
end)
 
function HasKey(plate)
 for i=1,#user_vehicles do
  plate = plate:gsub('[%p%c%s]', '')
  if plate == user_vehicles[i].plate then
   return true 
  end
 end
 return false 
end

RegisterCommand('giftcar', function(source, args, rawCommand)
 local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
 local plate = GetVehicleNumberPlateText(vehicle)
 TriggerServerEvent('garage:transfervehicle', args[1], plate)
end)


function GetVehProps(vehicle)
  local color1, color2 = GetVehicleColours(vehicle)
  local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)

  return {
    model            = GetEntityModel(vehicle),
    plate            = GetVehicleNumberPlateText(vehicle),
    plateIndex       = GetVehicleNumberPlateTextIndex(vehicle),
    health           = GetVehicleBodyHealth(vehicle),
    dirtLevel        = GetVehicleDirtLevel(vehicle),
    color1           = color1,
    color2           = color2,
    pearlescentColor = pearlescentColor,
    wheelColor       = wheelColor,
    wheels           = GetVehicleWheelType(vehicle),
    customTires      = GetVehicleModVariation(vehicle, 23),
    windowTint       = GetVehicleWindowTint(vehicle),
    neonEnabled      = {
     IsVehicleNeonLightEnabled(vehicle, 0),
     IsVehicleNeonLightEnabled(vehicle, 1),
     IsVehicleNeonLightEnabled(vehicle, 2),
     IsVehicleNeonLightEnabled(vehicle, 3),
    },
    neonColor        = table.pack(GetVehicleNeonLightsColour(vehicle)),
    tyreSmokeColor   = table.pack(GetVehicleTyreSmokeColor(vehicle)),
    modSpoilers      = GetVehicleMod(vehicle, 0),
    modFrontBumper   = GetVehicleMod(vehicle, 1),
    modRearBumper    = GetVehicleMod(vehicle, 2),
    modSideSkirt     = GetVehicleMod(vehicle, 3),
    modExhaust       = GetVehicleMod(vehicle, 4),
    modFrame         = GetVehicleMod(vehicle, 5),
    modGrille        = GetVehicleMod(vehicle, 6),
    modHood          = GetVehicleMod(vehicle, 7),
    modFender        = GetVehicleMod(vehicle, 8),
    modRightFender   = GetVehicleMod(vehicle, 9),
    modRoof          = GetVehicleMod(vehicle, 10),
    modEngine        = GetVehicleMod(vehicle, 11),
    modBrakes        = GetVehicleMod(vehicle, 12),
    modTransmission  = GetVehicleMod(vehicle, 13),
    modHorns         = GetVehicleMod(vehicle, 14),
    modSuspension    = GetVehicleMod(vehicle, 15),
    modArmor         = GetVehicleMod(vehicle, 16),
    modTurbo         = IsToggleModOn(vehicle,  18),
    modSmokeEnabled  = IsToggleModOn(vehicle,  20),
    modXenon         = IsToggleModOn(vehicle,  22),
    modHeadlight     = GetVehicleHeadlightsColour(vehicle),
    modFrontWheels   = GetVehicleMod(vehicle, 23),
    modBackWheels    = GetVehicleMod(vehicle, 24),
    modPlateHolder    = GetVehicleMod(vehicle, 25),
    modVanityPlate    = GetVehicleMod(vehicle, 26),
    modTrimA        = GetVehicleMod(vehicle, 27),
    modOrnaments      = GetVehicleMod(vehicle, 28),
    modDashboard      = GetVehicleMod(vehicle, 29),
    modDial         = GetVehicleMod(vehicle, 30),
    modDoorSpeaker      = GetVehicleMod(vehicle, 31),
    modSeats        = GetVehicleMod(vehicle, 32),
    modSteeringWheel    = GetVehicleMod(vehicle, 33),
    modShifterLeavers   = GetVehicleMod(vehicle, 34),
    modAPlate       = GetVehicleMod(vehicle, 35),
    modSpeakers       = GetVehicleMod(vehicle, 36),
    modTrunk        = GetVehicleMod(vehicle, 37),
    modHydrolic       = GetVehicleMod(vehicle, 38),
    modEngineBlock      = GetVehicleMod(vehicle, 39),
    modAirFilter      = GetVehicleMod(vehicle, 40),
    modStruts       = GetVehicleMod(vehicle, 41),
    modArchCover      = GetVehicleMod(vehicle, 42),
    modAerials        = GetVehicleMod(vehicle, 43),
    modTrimB        = GetVehicleMod(vehicle, 44),
    modTank         = GetVehicleMod(vehicle, 45),
    modWindows        = GetVehicleMod(vehicle, 46),
    modLivery       = GetVehicleLivery(vehicle),
    maxFuelLevel = DecorGetInt(vehicle, "_Max_Fuel_Level")
  }

end

RegisterNetEvent('vehstore:delete')
AddEventHandler('vehstore:delete', function()
 local ped = GetPlayerPed(-1)
 local vehicle = GetVehiclePedIsIn(ped, false)
 SetEntityAsMissionEntity(vehicle, true, true)
 DeleteVehicle(vehicle)
 DeleteEntity(vehicle)
end)

function SetVehicleProperties(vehicle, props)
  SetVehicleModKit(vehicle,  0)

  if props.plate ~= nil then
    SetVehicleNumberPlateText(vehicle,  props.plate)
  end

  if props.plateIndex ~= nil then
    SetVehicleNumberPlateTextIndex(vehicle,  props.plateIndex)
  end

  if props.health ~= nil and not IsThisModelABike(GetEntityModel(vehicle)) then
    if tonumber(props.health) < 200 then
     SetVehicleDamage(vehicle, 0.0, 1.0, 0.1, 50.0, 850.0, true) --800
     SetVehicleDamage(vehicle, -0.2, 1.0, 0.5, 50.0, 650.0, true) -- 50
     SetVehicleDamage(vehicle, -0.7, -0.2, 0.3, 50.0, 500.0, true) --00 50
     SetEntityHealth(vehicle, 950)
     SetVehicleBodyHealth(vehicle, 950)
     SetVehicleEngineHealth(vehicle, 950)
    end
  end

  if props.dirtLevel ~= nil then
    SetVehicleDirtLevel(vehicle,  props.dirtLevel)
  end

  if props.color1 ~= nil then
    local color1, color2 = GetVehicleColours(vehicle)
    SetVehicleColours(vehicle, props.color1, color2)
  end

  if props.color2 ~= nil then
    local color1, color2 = GetVehicleColours(vehicle)
    SetVehicleColours(vehicle, color1, props.color2)
  end

  if props.pearlescentColor ~= nil then
    local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
    SetVehicleExtraColours(vehicle,  props.pearlescentColor,  wheelColor)
  end

  if props.wheelColor ~= nil then
    local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
    SetVehicleExtraColours(vehicle,  pearlescentColor,  props.wheelColor)
  end

  if props.wheels ~= nil then
    SetVehicleWheelType(vehicle,  props.wheels)
  end

  if props.windowTint ~= nil then
    SetVehicleWindowTint(vehicle,  props.windowTint)
  end

  if props.neonEnabled ~= nil then
    SetVehicleNeonLightEnabled(vehicle, 0, props.neonEnabled[1])
    SetVehicleNeonLightEnabled(vehicle, 1, props.neonEnabled[2])
    SetVehicleNeonLightEnabled(vehicle, 2, props.neonEnabled[3])
    SetVehicleNeonLightEnabled(vehicle, 3, props.neonEnabled[4])
  end

  if props.neonColor ~= nil then
    SetVehicleNeonLightsColour(vehicle,  props.neonColor[1], props.neonColor[2], props.neonColor[3])
  end

  if props.modSmokeEnabled ~= nil then
    ToggleVehicleMod(vehicle, 20, true)
  end

  if props.tyreSmokeColor ~= nil then
    SetVehicleTyreSmokeColor(vehicle,  props.tyreSmokeColor[1], props.tyreSmokeColor[2], props.tyreSmokeColor[3])
  end

  if props.modSpoilers ~= nil then
    SetVehicleMod(vehicle, 0, props.modSpoilers, false)
  end

  if props.modFrontBumper ~= nil then
    SetVehicleMod(vehicle, 1, props.modFrontBumper, false)
  end

  if props.modRearBumper ~= nil then
    SetVehicleMod(vehicle, 2, props.modRearBumper, false)
  end

  if props.modSideSkirt ~= nil then
    SetVehicleMod(vehicle, 3, props.modSideSkirt, false)
  end

  if props.modExhaust ~= nil then
    SetVehicleMod(vehicle, 4, props.modExhaust, false)
  end

  if props.modFrame ~= nil then
    SetVehicleMod(vehicle, 5, props.modFrame, false)
  end

  if props.modGrille ~= nil then
    SetVehicleMod(vehicle, 6, props.modGrille, false)
  end

  if props.modHood ~= nil then
    SetVehicleMod(vehicle, 7, props.modHood, false)
  end

  if props.modFender ~= nil then
    SetVehicleMod(vehicle, 8, props.modFender, false)
  end

  if props.modRightFender ~= nil then
    SetVehicleMod(vehicle, 9, props.modRightFender, false)
  end

  if props.modRoof ~= nil then
    SetVehicleMod(vehicle, 10, props.modRoof, false)
  end

  if props.modEngine ~= nil then
    SetVehicleMod(vehicle, 11, props.modEngine, false)
  end

  if props.modBrakes ~= nil then
    SetVehicleMod(vehicle, 12, props.modBrakes, false)
  end

  if props.modTransmission ~= nil then
    SetVehicleMod(vehicle, 13, props.modTransmission, false)
  end

  if props.modHorns ~= nil then
    SetVehicleMod(vehicle, 14, props.modHorns, false)
  end

  if props.modSuspension ~= nil then
    SetVehicleMod(vehicle, 15, props.modSuspension, false)
  end

  if props.modArmor ~= nil then
    SetVehicleMod(vehicle, 16, props.modArmor, false)
  end

  if props.modTurbo ~= nil then
    ToggleVehicleMod(vehicle,  18, props.modTurbo)
  end

  if props.modXenon ~= nil then
    ToggleVehicleMod(vehicle,  22, props.modXenon)
  end

  if props.modHeadlight ~= nil then 
   ToggleVehicleMod(vehicle, 22, true)
   SetVehicleHeadlightsColour(vehicle, props.modHeadlight)
  end

  if props.modFrontWheels ~= nil then
    SetVehicleMod(vehicle, 23, props.modFrontWheels, false)
  end

  if props.modBackWheels ~= nil then
    SetVehicleMod(vehicle, 24, props.modBackWheels, false)
  end

  if props.modPlateHolder ~= nil then
    SetVehicleMod(vehicle, 25, props.modPlateHolder , false)
  end

  if props.modVanityPlate ~= nil then
    SetVehicleMod(vehicle, 26, props.modVanityPlate , false)
  end

  if props.modTrimA ~= nil then
    SetVehicleMod(vehicle, 27, props.modTrimA , false)
  end

  if props.modOrnaments ~= nil then
    SetVehicleMod(vehicle, 28, props.modOrnaments , false)
  end

  if props.modDashboard ~= nil then
    SetVehicleMod(vehicle, 29, props.modDashboard , false)
  end

  if props.modDial ~= nil then
    SetVehicleMod(vehicle, 30, props.modDial , false)
  end

  if props.modDoorSpeaker ~= nil then
    SetVehicleMod(vehicle, 31, props.modDoorSpeaker , false)
  end

  if props.modSeats ~= nil then
    SetVehicleMod(vehicle, 32, props.modSeats , false)
  end

  if props.modSteeringWheel ~= nil then
    SetVehicleMod(vehicle, 33, props.modSteeringWheel , false)
  end

  if props.modShifterLeavers ~= nil then
    SetVehicleMod(vehicle, 34, props.modShifterLeavers , false)
  end

  if props.modAPlate ~= nil then
    SetVehicleMod(vehicle, 35, props.modAPlate , false)
  end

  if props.modSpeakers ~= nil then
    SetVehicleMod(vehicle, 36, props.modSpeakers , false)
  end

  if props.modTrunk ~= nil then
    SetVehicleMod(vehicle, 37, props.modTrunk , false)
  end

  if props.modHydrolic ~= nil then
    SetVehicleMod(vehicle, 38, props.modHydrolic , false)
  end

  if props.modEngineBlock ~= nil then
    SetVehicleMod(vehicle, 39, props.modEngineBlock , false)
  end

  if props.modAirFilter ~= nil then
    SetVehicleMod(vehicle, 40, props.modAirFilter , false)
  end

  if props.modStruts ~= nil then
    SetVehicleMod(vehicle, 41, props.modStruts , false)
  end

  if props.modArchCover ~= nil then
    SetVehicleMod(vehicle, 42, props.modArchCover , false)
  end

  if props.modAerials ~= nil then
    SetVehicleMod(vehicle, 43, props.modAerials , false)
  end

  if props.modTrimB ~= nil then
    SetVehicleMod(vehicle, 44, props.modTrimB , false)
  end

  if props.modTank ~= nil then
    SetVehicleMod(vehicle, 45, props.modTank , false)
  end

  if props.modWindows ~= nil then
    SetVehicleMod(vehicle, 46, props.modWindows , false)
  end

  if props.modLivery ~= nil then
    --SetVehicleMod(vehicle, 48, props.modLivery, false)
    SetVehicleLivery(vehicle, props.modLivery)
  end

  if props.customTires == 1 then
    SetVehicleMod(vehicle, 23, GetVehicleMod(vehicle, 23), true)
    SetVehicleMod(vehicle, 24, GetVehicleMod(vehicle, 23), true)
  end
end
