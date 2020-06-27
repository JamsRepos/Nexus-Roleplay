currentPolice = 0
currentMultipler = 1.0

local gunzones = {
  {title="Gun Runner's Import", colour=51, id=229, x= -1829.840, y= 4831.032, z= 2.403},
}

Citizen.CreateThread(function()
  if DecorGetInt(GetPlayerPed(-1), "Faction") == 1 and DecorGetInt(GetPlayerPed(-1), "Job") == 30  then
    for _, info in pairs(gunzones) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.6)
      if info.id == 153 then 
        SetBlipScale(info.blip, 0.8)
      end
      if info.colour ~= 0 then SetBlipColour(info.blip, info.colour) end
      SetBlipAsShortRange(info.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
  end
end)

RegisterCommand('cartel2', function(source, args, rawCommand)
 if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1829.840, 4831.032, 2.403, true) < 50) and DecorGetInt(GetPlayerPed(-1), "Faction") == 1 and DecorGetInt(GetPlayerPed(-1), "Job") == 30  then
  TriggerServerEvent('gun:startZone')
  TriggerServerEvent('addReputation', 250)
 else
  exports['NRP-notify']:DoHudText('inform',  "<font color='#fc5044'>The Cartel Wont Deliver Here, Go To Your Pickup Location!")
 end
end)

RegisterNetEvent('hud:updatepresence')
AddEventHandler('hud:updatepresence', function(copss)
 currentPolice = copss
 if currentPolice == 2 then 
  currentMultipler = 1.5
 elseif currentPolice == 3 then 
  currentMultipler = 2.0
 elseif currentPolice == 4 then 
  currentMultipler = 2.5
 elseif currentPolice > 4 then
  currentMultipler = 3.0
 else 
  currentMultipler = 1.0
 end 
end)

RegisterNetEvent("guns:delivery")
AddEventHandler("guns:delivery", function() 
    local pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 10.0, 0.0)
    Citizen.CreateThread(function()
    	local pilot, aircraft, crate
        local requiredModels = {"titan", "s_m_m_pilot_02", "prop_boxpile_06b"}

        for i = 1, #requiredModels do
            RequestModel(GetHashKey(requiredModels[i]))
            while not HasModelLoaded(GetHashKey(requiredModels[i])) do
                Wait(0)
            end
        end

        local rHeading = math.random(0, 360) + 0.0
        local planeSpawnDistance = (3000.0 and tonumber(3000.0) + 0.0) or 400.0
        local theta = (rHeading / 180.0) * 3.14
        local rPlaneSpawn = vector3(pos.x, pos.y, pos.z) - vector3(math.cos(theta) * planeSpawnDistance, math.sin(theta) * planeSpawnDistance, -500.0) 

        local dx = pos.x - rPlaneSpawn.x
        local dy = pos.y - rPlaneSpawn.y
        local heading = GetHeadingFromVector_2d(dx, dy)

        aircraft = CreateVehicle(GetHashKey("titan"), rPlaneSpawn, heading, true, true)
        SetEntityHeading(aircraft, heading)
        SetVehicleDoorsLocked(aircraft, 2)
        SetEntityDynamic(aircraft, true)
        ActivatePhysics(aircraft)
        SetVehicleForwardSpeed(aircraft, 60.0)
        SetHeliBladesFullSpeed(aircraft)
        SetVehicleEngineOn(aircraft, true, true, false)
        ControlLandingGear(aircraft, 3) 
        OpenBombBayDoors(aircraft)
        SetEntityProofs(aircraft, true, false, true, false, false, false, false, false)

        pilot = CreatePedInsideVehicle(aircraft, 1, GetHashKey("s_m_m_pilot_02"), -1, true, true)
        SetBlockingOfNonTemporaryEvents(pilot, true) 
        SetPedRandomComponentVariation(pilot, false)
        SetPedKeepTask(pilot, true)
        SetPlaneMinHeightAboveTerrain(aircraft, 50) 

        TaskVehicleDriveToCoord(pilot, aircraft, vector3(pos.x, pos.y, pos.z) + vector3(0.0, 0.0, 150.0), 60.0, 0, GetHashKey("titan"), 262144, 15.0, -1.0)

        local droparea = vector2(pos.x, pos.y)
        local planeLocation = vector2(GetEntityCoords(aircraft).x, GetEntityCoords(aircraft).y)
        while not IsEntityDead(pilot) and #(planeLocation - droparea) > 5.0 do
            Wait(100)
            planeLocation = vector2(GetEntityCoords(aircraft).x, GetEntityCoords(aircraft).y) 
        end

        TaskVehicleDriveToCoord(pilot, aircraft, 0.0, 0.0, 500.0, 60.0, 0, GetHashKey("titan"), 262144, -1.0, -1.0) 
        SetEntityAsNoLongerNeeded(pilot) 
        SetEntityAsNoLongerNeeded(aircraft)

        local crateSpawn = vector3(pos.x, pos.y, GetEntityCoords(aircraft).z - 5.0)
        crate = CreateObject(GetHashKey("prop_boxpile_06b"), crateSpawn, true, true, true) 
        SetEntityLodDist(crate, 1000) 
        ActivatePhysics(crate)
        SetDamping(crate, 2, 0.1) 
        SetEntityVelocity(crate, 0.0, 0.0, -0.2)
        if DoesEntityExist(crate) then 
  		 Wait(15000)
         gunsDelivered(crate)
        end

        for i = 1, #requiredModels do
            Wait(0)
            SetModelAsNoLongerNeeded(GetHashKey(requiredModels[i]))
        end
    end)
end)

function gunsDelivered(prop)
 DeleteObject(prop)
 local plate = "xxsdrtghyuujhdjsjenenfjfjtjtjtj"
 if(plate == "xxsdrtghyuujhdjsjenenfjfjtjtjtj") then
  showLoadingPrompt("Enter Plate", 3)
  DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8S", "", "", "", "", "", 20)
  while (UpdateOnscreenKeyboard() == 0) do
   DisableAllControlActions(0);
   Wait(0);
  end
  if (GetOnscreenKeyboardResult()) then
   local option = tostring(GetOnscreenKeyboardResult())
   if(option ~= nil and option ~= 0) then
    plate = ""..option
   end
  end
 end
 stopLoadingPrompt()
 if (plate ~= "xxsdrtghyuujhdjsjenenfjfjtjtjtj") then
  TriggerServerEvent('gun:addGuns', plate)
 end
end


function Teleport(x,y,z)
  RequestCollisionAtCoord(x,y,z)

  while not HasCollisionLoadedAroundEntity(GetPlayerPed(-1)) do
    RequestCollisionAtCoord(x,y,z)
    Citizen.Wait(0)
  end

  SetEntityCoords(GetPlayerPed(-1), x,y,z)
end