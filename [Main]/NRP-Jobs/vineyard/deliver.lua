local deliveryVehicle = nil
local currentJobID = nil
local grapeReturn = false
local onJob = false

local delPos = {
    ['Max'] = 4,
    [1] = {x = -1231.840, y = -894.026, z = 12.298},
    [2] = {x = 1199.814, y = -1384.160, z = 35.227}, 
    [3] = {x = 1974.732, y = 3742.681, z = 32.185},
    [4] = {x = 1719.892, y = 6423.055, z = 33.456},
}

Citizen.CreateThread(function()
    while true do
     Citizen.Wait(5)
     if DecorGetInt(GetPlayerPed(-1), "Job") == 42 then
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1909.432, 2071.818, 140.388, true) < 215) then
          DrawMarker(27, -1909.432, 2071.818, 140.388-0.98, 0,0,0,0,0,0,1.0,1.0,1.0,255,165,0,165,0,0,0,0)
          if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1909.432, 2071.818, 140.388, true) < 1.5) then
           if DoesEntityExist(deliveryVehicle) then drawTxt('~w~Press ~g~[E]~w~ To End Work') else drawTxt('~w~Press ~g~[E]~w~ To Start Work') end
           if IsControlJustPressed(0, 38) then 
            if DecorGetInt(GetPlayerPed(-1), "Reputation") > 1000 then
                exports['NRP-notify']:DoHudText('error', "You're a known criminal, i don't think the vineyard wants you working for them.")
            else
                if DoesEntityExist(deliveryVehicle) then 
                    onJob = false
                    DeleteVehicle(deliveryVehicle)
                else
                    newDelLocs()
                    SpawnDelivery(-1891.097, 2046.453, 140.855, 71.426)
                    onJob = true
                end
            end
        end
       end
      end
      if onJob and (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), delPos[currentJobID].x,delPos[currentJobID].y,delPos[currentJobID].z, true) < 220) and not grapeReturn and IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey('mule')) then
        DrawMarker(27, delPos[currentJobID].x,delPos[currentJobID].y,delPos[currentJobID].z-0.95, 0,0,0,0,0,0,4.0,4.0,4.0,255,165,0,165,0,0,0,0)
       if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), delPos[currentJobID].x,delPos[currentJobID].y,delPos[currentJobID].z, true) < 5.5) then
        drawTxt('~w~Press ~g~[E]~w~ To Deliver Wine')
        if IsControlJustPressed(0, 38) then
         RemoveJobBlip()
         SetJobBlip(-1909.137, 2056.916, 140.738)
         grapeReturn = true
        end
       end
      end
      if grapeReturn then
       drawTxt('~w~Return to the Vineyard\nPress ~g~[E]~w~ To Get Paid')
       DrawMarker(27, -1909.137, 2056.916, 140.738-0.95, 0,0,0,0,0,0,4.0,4.0,4.0,255,165,0,165,0,0,0,0)
       if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1909.137, 2056.916, 140.738, true) < 5.5) then
        if IsControlJustPressed(0, 38) then
         if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey('mule')) then
          onJob = false
          grapeReturn = false
          DeleteVehicle(deliveryVehicle)
          local pay = math.random(5000, 6000)
          RemoveJobBlip()
          TriggerServerEvent('jobs:paytheplayer', pay, 'Vineyard: Delivery')
         else
          Notify('You must return the vehicle that was rented for the job.')
         end
        end
       end
      end
     end
    end
end)

function SpawnDelivery(x,y,z,h)
    local vehicleHash = GetHashKey('mule')
    RequestModel(vehicleHash)
    while not HasModelLoaded(vehicleHash) do
     Citizen.Wait(0)
    end
   
    deliveryVehicle = CreateVehicle(vehicleHash, x, y, z, h, true, false)
    local id = NetworkGetNetworkIdFromEntity(deliveryVehicle)
    SetNetworkIdCanMigrate(id, true)
    SetNetworkIdExistsOnAllMachines(id, true)
    SetVehicleDirtLevel(deliveryVehicle, 0)
    SetVehicleHasBeenOwnedByPlayer(deliveryVehicle, true)
    SetEntityAsMissionEntity(deliveryVehicle, true, true)
    SetVehicleEngineOn(deliveryVehicle, true)
    exports["onyxLocksystem"]:givePlayerKeys(GetVehicleNumberPlateText(deliveryVehicle))
end

function newDelLocs()
    local jobID = math.random(1, delPos['Max'])
    SetJobBlip(delPos[jobID].x,delPos[jobID].y,delPos[jobID].z)
    currentJobID = jobID
end