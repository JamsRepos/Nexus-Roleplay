local status = false
local display = false
currentPolice = 0

DecorRegister("isBlindfolded", 2)
DecorSetBool(GetPlayerPed(-1), "isBlindfolded", false)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)
        if status and exports['core']:GetItemQuantity(300) < 1 then
            status = false
            SendNUIMessage({
                type = "gopro",
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
            type = "gopro",
            display = true
        })
        exports['NRP-notify']:DoCustomHudText('success', 'GoPro: Live & Recording')
    else
        SendNUIMessage({
            type = "gopro",
            display = false
        })
        exports['NRP-notify']:DoCustomHudText('error', 'GoPro: Shutting Down')
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)
        if status and exports['core']:GetItemQuantity(300) < 1 then
            status = false
            SendNUIMessage({
                type = "bodycam",
                display = false
            })
            exports['NRP-notify']:DoCustomHudText('error', 'BodyCamera: Connection Lost')
        end
    end
end)

RegisterNetEvent('items:bodycam')
AddEventHandler('items:bodycam', function()
    status = not status
    if status then
        SendNUIMessage({
            type = "bodycam",
            display = true
        })
        exports['NRP-notify']:DoCustomHudText('success', 'BodyCamera: Live & Recording')
    else
        SendNUIMessage({
            type = "bodycam",
            display = false
        })
        exports['NRP-notify']:DoCustomHudText('error', 'BodyCamera: Shutting Down')
    end
end)

RegisterNetEvent('items:blindfold')
AddEventHandler('items:blindfold', function()
    if not IsPedInAnyVehicle(GetPlayerPed(-1), false) and not DecorGetBool(GetPlayerPed(-1), "Handsup") then
        local t, distance = GetClosestPlayer()
        if(distance ~= -1 and distance < 2) then
            if DecorGetBool(GetPlayerPed(t), "Handsup") == 1 then
                if currentPolice >= 0 then
                    if not DecorGetBool(GetPlayerPed(t), "isBlindfolded") then
                        exports['NRP-notify']:DoHudText('success',  "You apply the blindfold.")
                        TriggerServerEvent("item:blindfold:victim", GetPlayerServerId(t))
                    end
                else
                    exports['NRP-notify']:DoHudText('inform',  "Not Enough Police In Town")
                end
            else
                if DecorGetBool(GetPlayerPed(t), "isBlindfolded") then
                    exports['NRP-notify']:DoHudText('error',  "You remove the blindfold.")
                    TriggerServerEvent("item:blindfold:victim", GetPlayerServerId(t))
                end
            end
        end
    end
end)

RegisterNetEvent('items:blindfold:toggle')
AddEventHandler('items:blindfold:toggle', function()
    if not DecorGetBool(GetPlayerPed(-1), "isBlindfolded") then
        blindfold = CreateObject(GetHashKey("prop_money_bag_01"), 0, 0, 0, true, true, true) -- Create head bag object!
        AttachEntityToEntity(blindfold, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 12844), 0.2, 0.04, 0, 0, 270.0, 60.0, true, true, false, true, 1, true) -- Attach object to head
        TriggerEvent('clothing:togglehelmet')
        DecorSetBool(GetPlayerPed(-1), "isBlindfolded", true)
        SetNuiFocus(false, false)
        SendNUIMessage({
            type = "blindfold",
            display = true
        })
        exports['NRP-notify']:DoCustomHudText('success', 'You have been blindfolded.')
    else
        DeleteEntity(blindfold)
        SetEntityAsNoLongerNeeded(blindfold)
        TriggerEvent('clothing:togglehelmet')
        DecorSetBool(GetPlayerPed(-1), "isBlindfolded", false)
        SendNUIMessage({
            type = "blindfold",
            display = false
        })
        exports['NRP-notify']:DoCustomHudText('error', 'You have had your blindfold removed.')
    end
end)

AddEventHandler('playerSpawned', function()
    DeleteEntity(blindfold)
    SetEntityAsNoLongerNeeded(blindfold)
    SendNUIMessage({
        type = "blindfold",
        display = false
    })
end)

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)
    
    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = Vdist(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"])
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    
    return closestPlayer, closestDistance
end

function GetPlayers()
    local players = {}

    for _, player in ipairs(GetActivePlayers()) do
        table.insert(players, player)
    end

    return players
end