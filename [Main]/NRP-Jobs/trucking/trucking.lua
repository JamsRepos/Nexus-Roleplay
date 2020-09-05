Citizen.CreateThread(function()
 WarMenu.CreateMenu('trucking_jobs', "Transport")
 while true do
  Citizen.Wait(1)
  if DecorGetInt(GetPlayerPed(-1), "Job") == 11 then
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1200.460, -1276.810, 35.369, true) < 50) then
    DrawMarker(27,  1200.460, -1276.810, 35.369-0.98, 0, 0, 0, 0, 0, 0, 1.0,1.0,1.0, 16,197,244, 200, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1200.460, -1276.810, 35.369, true) < 1.2) then
      DrawText3Ds(1200.460, -1276.810, 35.369,'~g~[E]~w~ Get a Trucking Shift') 
     if IsControlJustPressed(0, 38) then
      WarMenu.OpenMenu('trucking_jobs')
     end
    end
   end
  end
  if WarMenu.IsMenuOpened('trucking_jobs') then
   if WarMenu.Button('Vehicle Delivery') then
    WarMenu.CloseMenu('trucking_jobs')
    VehicleDelivery()
   elseif WarMenu.Button('Container Delivery') then
    WarMenu.CloseMenu('trucking_jobs')
    BoatDelivery()
   elseif WarMenu.Button('Box Truck Delivery') then
    WarMenu.CloseMenu('trucking_jobs')
    BoxDelivery()
   elseif WarMenu.Button('Fuel Station Delivery') then
    WarMenu.CloseMenu('trucking_jobs')
    FuelDelivery()
   end
   WarMenu.Display()
  end
 end
end)

-------------------------------------------------------

local truck = 0
local trailer = 0
local stage = 0
local jobname = ''
local earnedmoney = 0
local nearAThing = false

function VehicleDelivery()
 truckhash = GetHashKey('phantom')
 RequestModel(truckhash)
 Citizen.CreateThread(function() 
  while not HasModelLoaded(truckhash) do  
   Citizen.Wait(0)  
  end
  truck = CreateVehicle(GetHashKey('phantom'), 1204.779, -1267.024, 35.227, 175.0, true, true)
  TaskWarpPedIntoVehicle(GetPlayerPed(-1), truck, -1)
  SetVehicleEngineOn(truck, true, true)
  SetVehicleIsConsideredByPlayer(truck, true)
  DecorRegister("_Fuel_Level", 3);
  DecorRegister("_Max_Fuel_Level", 3);
  DecorSetInt(truck, "_Max_Fuel_Level", 100000)
  DecorSetInt(truck, "_Fuel_Level", 75000)
  exports["onyxLocksystem"]:givePlayerKeys(GetVehicleNumberPlateText(truck))
  SetJobBlip(1748.6330566406, 3257.4597167969)
  exports['NRP-notify']:DoLongHudText('inform', 'Drive to the marked waypoint and collect your cargo. Remember, damage to the truck or trailer will reduce payout!')
 end)
 stage = 1
 jobname = 'Vehicle'
 earnedmoney = math.random(4000, 4500)
end

local loaded = false

local spawnLocations = 
{
    [1] = {x = 1778.633, y = 3257.459, z = 41.457},
    [2] = {x = 1771.199, y = 3257.972, z = 41.786},
    [3] = {x = 1762.517, y = 3258.028, z = 41.645},
    [4] = {x = 1752.734, y = 3256.334, z = 41.524},
    [5] = {x = 1743.153, y = 3255.382, z = 41.478},
}

local spawnnumber = math.random(1, #spawnLocations)

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
  if DecorGetInt(GetPlayerPed(-1), "Job") == 11 and jobname == 'Vehicle' then
   if stage == 1 then 
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), spawnLocations[spawnnumber].x, spawnLocations[spawnnumber].y, spawnLocations[spawnnumber].z, true) < 100) and not loaded then
      loaded = true
      RequestModel(GetHashKey('tr4'))
      Citizen.CreateThread(function() 
       while not HasModelLoaded(GetHashKey('tr4')) do  
        Citizen.Wait(0)  
       end
       trailer = CreateVehicle(GetHashKey('tr4'), spawnLocations[spawnnumber].x, spawnLocations[spawnnumber].y, spawnLocations[spawnnumber].z, 0, true, false)
       SetVehicleOnGroundProperly(trailer)
      end)
    elseif(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), spawnLocations[spawnnumber].x, spawnLocations[spawnnumber].y, spawnLocations[spawnnumber].z, true) < 100) and loaded then
      DrawMarker(2, spawnLocations[spawnnumber].x, spawnLocations[spawnnumber].y, spawnLocations[spawnnumber].z+10.0, 0, 0, 0, 0, 0, 0, 3.0,3.0,3.0, 16,197,244, 200, 0, 0, 2, 0, 0, 0, 0)
    end
    if IsVehicleAttachedToTrailer(truck) and loaded then
      exports['NRP-notify']:DoLongHudText('inform', 'Collect The Cargo and Drive The Vehicle Down To The Car Dealership')
      SetJobBlip(-17.805, -1106.066)
      stage = 2
    end 
   elseif stage == 2 then
    DrawMarker(2,  -20.089574813843, -1114.9820556641, 28.672052383423, 0, 0, 0, 0, 0, 0, 2.0,2.0,2.0, 16,197,244, 200, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -20.089574813843, -1114.9820556641, 26.672052383423, true) < 10) then
     nearAThing = true
     if IsVehicleAttachedToTrailer(truck) then
      DrawText3Ds(-20.089574813843, -1114.9820556641, 28.672052383423,'~g~[E]~w~ Deliver Vehicle Trailer')
      if IsControlJustPressed(0, 38) then
       DetachVehicleFromTrailer(truck)
       DeleteVehicle(trailer)
       stage = 3
       CheckHealth()
       exports['NRP-notify']:DoLongHudText('inform', 'Return The Truck To The Depot')
       SetJobBlip(1204.956, -1264.899, 37.227)
      end
     end
    else
     nearAThing = false
    end
   elseif stage == 3 then
    DrawMarker(2, 1204.956, -1264.899, 37.227, 0, 0, 0, 0, 0, 0, 2.0,2.0,2.0, 16,197,244, 200, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1204.956, -1264.899, 37.227, true) < 5) then
     nearAThing = true
     DrawText3Ds(1204.956, -1264.899, 37.227,'~g~[E]~w~ Return Truck And Get Payed')
     if IsControlJustPressed(0, 38) then
      DeleteVehicle(truck)
      stage = 0 
      CheckHealth()
      TriggerServerEvent('jobs:paytheplayer', earnedmoney, 'Trucking: Vehicle')
      jobname = ''
      loaded = false
     end
    else
     nearAThing = false
    end
   end
  end
 end
end)

--------------------------------------------------------------------

function CheckHealth()
 local truckhealth = GetVehicleBodyHealth(truck)
 if truckhealth > 970 then
  earnedmoney = earnedmoney
 elseif truckhealth > 800 and truckhealth < 970 then 
  earnedmoney = earnedmoney-100
 elseif truckhealth > 600 and truckhealth < 800 then
  earnedmoney = earnedmoney-150
 elseif truckhealth > 400 and truckhealth < 600 then
  earnedmoney = earnedmoney-200
 elseif truckhealth > 50 and truckhealth < 400 then
  earnedmoney = earnedmoney-250
 end
end