local missionblip = nil
local blip = nil 
local vehicle = nil

function getParkingPosition(spots)
  for id,v in pairs(spots) do 
   if GetClosestVehicle(v.x, v.y, v.z, 3.0, 0, 70) == 0 then  
    return true, v
   end
  end 
  TriggerEvent('chatMessage', '^1Parking Spots Full, Please Wait')
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

function SetWorkPlace(x,y,z)
 if DoesBlipExist(blip) then RemoveBlip(blip) end
 blip = AddBlipForCoord(x, y, z)
 SetBlipSprite (blip, 430)
 SetBlipDisplay(blip, 4)
 SetBlipScale  (blip, 0.8)
 SetBlipColour (blip, 18)
 SetBlipAsShortRange(blip, true)
 BeginTextCommandSetBlipName("STRING")
 AddTextComponentString("Place of Work")
 EndTextCommandSetBlipName(blip)
end 

function SpawnJobVehicle(model, x,y,z)
 if DoesEntityExist(vehicle) then DeleteVehicle(vehicle) end
 local vehiclehash = GetHashKey(model)
 RequestModel(vehiclehash)
 while not HasModelLoaded(vehiclehash) do
  Citizen.Wait(0)
 end
 vehicle = CreateVehicle(vehiclehash, x,y,z, GetEntityHeading(PlayerPedId()), true, false)
 SetVehicleDirtLevel(vehicle, 0)
 TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
 SetVehicleHasBeenOwnedByPlayer(vehicle, true)
 SetEntityAsMissionEntity(vehicle, true, true)
 SetVehicleMod(vehicle,16, 20)
 SetVehicleEngineOn(vehicle, true)
 SetVehicleLivery(vehicle, vehlivery)
 DecorRegister("_Fuel_Level", 3);
 DecorRegister("_Max_Fuel_Level", 3);
 DecorSetInt(vehicle, "_Max_Fuel_Level", 100000)
 DecorSetInt(vehicle, "_Fuel_Level", 100000)
 exports["onyxLocksystem"]:givePlayerKeys(GetVehicleNumberPlateText(vehicle))
end

function SetJobBlip(x,y,z)
 if DoesBlipExist(missionblip) then RemoveBlip(missionblip) end
 missionblip = AddBlipForCoord(x,y,z)
 SetBlipSprite(missionblip, 164)
 SetBlipColour(missionblip, 53)
 SetBlipRoute(missionblip, true)
 BeginTextCommandSetBlipName("STRING")
 AddTextComponentString("Destination")
 EndTextCommandSetBlipName(missionblip)
end

function RemoveJobBlip()
 if DoesBlipExist(missionblip) then RemoveBlip(missionblip) end
end

function Notify(message)
 exports['NRP-notify']:DoHudText('inform', message)
end

function LoadAnim(animDict)
  RequestAnimDict(animDict)

  while not HasAnimDictLoaded(animDict) do
    Citizen.Wait(10)
  end
end

function LoadModel(model)
  RequestModel(model)

  while not HasModelLoaded(model) do
    Citizen.Wait(10)
  end
end
