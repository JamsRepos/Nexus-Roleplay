
RegisterNetEvent("NitroConfirmation")
AddEventHandler("NitroConfirmation", function(cb)
    if cb then
        print("YOU ARE A NITRO BOOSTER")
        local car = GetHashKey("panto")
  
        RequestModel(car)
        while not HasModelLoaded(car) do
            RequestModel(car)
            Citizen.Wait(0)
        end
        local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 8.0, 0.5))
        local nitrocar = CreateVehicle(car, x, y, z, 0.0, true, false)
        SetVehicleColours(nitrocar, 135, 135)
        SetVehicleNumberPlateText(nitrocar, "BOOSTER")
        DecorSetInt(nitrocar, "_Fuel_Level", 100000)
        TaskWarpPedIntoVehicle(GetPlayerPed(-1), nitrocar, -1)
        exports["onyxLocksystem"]:givePlayerKeys(GetVehicleNumberPlateText(nitrocar))

    else
        print("YOU ARE NOT A NITRO BOOSTER")
    end
end)
