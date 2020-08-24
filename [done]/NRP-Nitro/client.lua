
local callingcar = false
local carout = false

RegisterNetEvent("NitroConfirmation")
AddEventHandler("NitroConfirmation", function(cb)
    if cb then
        local car = GetHashKey("panto")
        RequestModel(car)

        while not HasModelLoaded(car) do
            RequestModel(car)
            Citizen.Wait(0)
        end

        if carout then
            if IsPedInAnyVehicle(GetPlayerPed(-1)) then
                DeleteGivenVehicle(nitrocar, 5)
                carout = false
            else
                exports['NRP-notify']:DoHudText('error', 'You already have a car out. Use /nitro in the previous vehicle to delete it.')
                return
            end
        end

        if callingcar then
            exports['NRP-notify']:DoHudText('error', 'You already have a car on the way.')
            return
        end

        callingcar = true
        ExecuteCommand("e phonecall")

        exports['pogressBar']:drawBar(30000, 'Calling Courtesy Car', function()
            local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 8.0, 0.5))
            local nitrocar = CreateVehicle(car, x, y, z, 0.0, true, false)
            SetVehicleColours(nitrocar, 135, 135)
            SetVehicleNumberPlateText(nitrocar, "BOOSTER")
            DecorSetInt(nitrocar, "_Fuel_Level", 100000)
            --TaskWarpPedIntoVehicle(GetPlayerPed(-1), nitrocar, -1)
            exports["onyxLocksystem"]:givePlayerKeys(GetVehicleNumberPlateText(nitrocar))
            exports['NRP-notify']:DoHudText('success', 'Thank you for choosing Nitro Courtesy Cars!')
            callingcar = false
            carout = true
            ExecuteCommand("e c")
        end)
    else
        exports['NRP-notify']:DoHudText('error', 'You are not currently a Nitro Booster.')
    end
end)

function DeleteGivenVehicle(veh, timeoutMax)
    local timeout = 0 
  
    SetVehicleHasBeenOwnedByPlayer(veh, false)
    SetEntityAsMissionEntity(veh, true, true)
    TriggerEvent('persistent-vehicles/forget-vehicle', veh)
    DeleteVehicle(veh)
  
    if (DoesEntityExist(veh)) then
      exports['NRP-notify']:DoHudText('error', 'Failed to collect vehicle, trying again...')
        -- Fallback if the vehicle doesn't get deleted
        while (DoesEntityExist(veh) and timeout < timeoutMax) do 
          DeleteVehicle(veh)
  
          -- The vehicle has been banished from the face of the Earth!
          if (not DoesEntityExist(veh)) then 
            exports['NRP-notify']:DoHudText('success', 'Vehicle Collected')
          end 
  
          -- Increase the timeout counter and make the system wait
          timeout = timeout + 1 
          Citizen.Wait(500)
  
          -- We've timed out and the vehicle still hasn't been deleted. 
          if (DoesEntityExist(veh) and (timeout == timeoutMax - 1)) then
            exports['NRP-notify']:DoHudText('error', 'Failed to collect vehicle after ' .. timeoutMax .. ' retries.')
          end 
        end
    else 
      exports['NRP-notify']:DoHudText('success', 'Vehicle Collected')
    end 
  end
