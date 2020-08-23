
local callingcar = false

RegisterNetEvent("NitroConfirmation")
AddEventHandler("NitroConfirmation", function(cb)
    if cb then
        local car = GetHashKey("panto")
        RequestModel(car)

        while not HasModelLoaded(car) do
            RequestModel(car)
            Citizen.Wait(0)
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
            ExecuteCommand("e c")
        end)
    else
        exports['NRP-notify']:DoHudText('error', 'You are not currently a Nitro Booster.')
    end
end)
