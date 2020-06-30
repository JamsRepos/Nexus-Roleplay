local status = false
local display = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)
        if status and exports['core']:GetItemQuantity(300) < 1 then
            status = false
            SendNUIMessage({
                type = "ui",
                display = false
              })
            exports['NRP-notify']:DoCustomHudText('error', 'GoPro: Connection Lost')
        end
    end
end)

RegisterNetEvent('items:gopro')
AddEventHandler('items:gopro', function()
    status = not status
    if status then
        SendNUIMessage({
            type = "ui",
            display = true
          })
        exports['NRP-notify']:DoCustomHudText('success', 'GoPro: Live & Recording')
    else
        SendNUIMessage({
            type = "ui",
            display = false
          })
        exports['NRP-notify']:DoCustomHudText('error', 'GoPro: Shutting Down')
    end
end)