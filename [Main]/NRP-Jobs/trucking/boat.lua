-------------------------------------------------------

local truck = 0
local trailer = 0
local stage = 0
local jobname = ''
local earnedmoney = 0
local nearAThing = false

function BoatDelivery()
 truckhash = GetHashKey('hauler')
 RequestModel(truckhash)
 Citizen.CreateThread(function() 
  while not HasModelLoaded(truckhash) do  
   Citizen.Wait(0)  
  end
  truck = CreateVehicle(GetHashKey('hauler'), 1204.779, -1267.024, 35.227, 175.0, true, true)
  TaskWarpPedIntoVehicle(GetPlayerPed(-1), truck, -1)
  SetVehicleEngineOn(truck, true, true)
  SetVehicleIsConsideredByPlayer(truck, true)
  DecorRegister("_Fuel_Level", 3);
  DecorRegister("_Max_Fuel_Level", 3);
  DecorSetInt(truck, "_Max_Fuel_Level", 100000)
  DecorSetInt(truck, "_Fuel_Level", 75000)
  exports["onyxLocksystem"]:givePlayerKeys(GetVehicleNumberPlateText(truck))
  SetJobBlip(2852.90, 4486.90, 48.90)
  exports['NRP-notify']:DoLongHudText('inform', 'Drive to the marked waypoint and collect your cargo. Remember, damage to the truck or trailer will reduce payout!')
 end)
 stage = 1
 jobname = 'Boat'
 earnedmoney = math.random(4000, 6000)
end

local loaded = false

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
  if DecorGetInt(GetPlayerPed(-1), "Job") == 11 and jobname == 'Boat' then
   if stage == 1 then 
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 2852.90, 4486.90, 48.90, true) < 100) and not loaded then
      loaded = true
      RequestModel(GetHashKey('TrailerS4'))
      Citizen.CreateThread(function() 
       while not HasModelLoaded(GetHashKey('TrailerS4')) do  
        Citizen.Wait(0)  
       end
       trailer = CreateVehicle(GetHashKey('TrailerS4'), 2852.90, 4486.90, 48.90, 0, true, false)
       SetVehicleOnGroundProperly(trailer)
      end)
    elseif(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 2852.90, 4486.90, 48.90, true) < 100) and loaded then
      DrawMarker(2, 2852.90, 4486.90, 48.90, 0, 0, 0, 0, 0, 0, 3.0,3.0,3.0, 16,197,244, 200, 0, 0, 2, 0, 0, 0, 0)
    end
    if IsVehicleAttachedToTrailer(truck) and loaded then
      exports['NRP-notify']:DoLongHudText('inform', 'Collect The Cargo and Drive The Vehicle Down To The City Docks')
      SetJobBlip(978.29, -3076.38, 5.90)
      stage = 2
    end 
   elseif stage == 2 then
    DrawMarker(2,  978.29, -3076.38, 5.90, 0, 0, 0, 0, 0, 0, 2.0,2.0,2.0, 16,197,244, 200, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 978.29, -3076.38, 5.90, true) < 10) then
     nearAThing = true
     if IsVehicleAttachedToTrailer(truck) then
      DrawText3Ds(978.29, -3076.38, 5.90,'~g~[E]~w~  Deliver The Container')
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
    DrawMarker(2,  1204.956, -1264.899, 37.227, 0, 0, 0, 0, 0, 0, 2.0,2.0,2.0, 16,197,244, 200, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1204.956, -1264.899, 37.227, true) < 5) then
     nearAThing = true
     DrawText3Ds(1204.956, -1264.899, 37.227,'~g~[E]~w~ Return Truck And Get Paid')
     if IsControlJustPressed(0, 38) then
      DeleteVehicle(truck)
      stage = 0 
      CheckHealth()
      TriggerServerEvent('jobs:paytheplayer', earnedmoney, 'Trucking: Boat')
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