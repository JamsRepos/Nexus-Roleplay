-------------------------------------------------------

local truck = 0
local trailer = 0
local stage = 0
local jobname = ''
local earnedmoney = 0
local nearAThing = false

function FuelDelivery()
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
  SetJobBlip(2685.01, 1557.01, 24.01)
  exports['NRP-notify']:DoLongHudText('inform', "Drive to the marked waypoint and collect your cargo. Remember, damage to the truck or trailer will reduce payout!")
 end)
 stage = 1
 jobname = 'Fuel'
 earnedmoney = math.random(6000, 7000)
end

local loaded = false

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
  if DecorGetInt(GetPlayerPed(-1), "Job") == 11 and jobname == 'Fuel' then
   if stage == 1 then 
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 2685.01, 1557.01, 24.01, true) < 100) and not loaded then
      loaded = true
      RequestModel(GetHashKey('tanker2'))
      Citizen.CreateThread(function() 
       while not HasModelLoaded(GetHashKey('tanker2')) do  
        Citizen.Wait(0)  
       end
       trailer = CreateVehicle(GetHashKey('tanker2'), 2685.01, 1557.01, 24.01, 0, true, false)
       SetEntityHeading(trailer, 354.476)
       SetVehicleOnGroundProperly(trailer)
      end)
    elseif(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 2685.01, 1557.01, 24.01, true) < 100) and loaded then
      DrawMarker(2,  2685.01, 1557.01, 24.01, 0, 0, 0, 0, 0, 0, 3.0,3.0,3.0, 16,197,244, 200, 0, 0, 2, 0, 0, 0, 0)
    end
    if IsVehicleAttachedToTrailer(truck) and loaded then
      exports['NRP-notify']:DoLongHudText('inform', "Collect The Cargo and Drive The Vehicle Down To The City Docks")
      SetJobBlip(-2555.01, 2338.01, 33.01)
      stage = 2
    end 
   elseif stage == 2 then
    DrawMarker(2,  -2555.01, 2338.01, 33.01, 0, 0, 0, 0, 0, 0, 2.0,2.0,2.0, 16,197,244, 200, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -2555.01, 2338.01, 33.01, true) < 10) then
     nearAThing = true
     if IsVehicleAttachedToTrailer(truck) then
      DrawText3Ds(-2555.01, 2338.01, 33.01,'~g~[E]~w~ Deliver The Container') 
      if IsControlJustPressed(0, 38) then
       DetachVehicleFromTrailer(truck)
       DeleteVehicle(trailer)
       stage = 3
       CheckHealth()
       exports['NRP-notify']:DoLongHudText('inform', "Return The Truck To The Depot")
       SetJobBlip(1204.956, -1264.899, 37.227)
      end
     end
    else
     nearAThing = false
    end
   elseif stage == 3 then
    DrawMarker(2,  1204.956, -1264.899, 37.227, 0, 0, 0, 0, 0, 0, 2.0,2.0,2.0, 16,197,244, 200, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1204.956, -1264.899, 37.227, true) < 5) then
     nearAThing = true
     DrawText3Ds(1204.956, -1264.899, 37.227,'~g~[E]~w~ Return Truck And Get Payed') 
     if IsControlJustPressed(0, 38) then
      DeleteVehicle(truck)
      stage = 0 
      CheckHealth()
      TriggerServerEvent('jobs:paytheplayer', earnedmoney, 'Trucking: Fuel')
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
