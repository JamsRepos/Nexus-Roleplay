RegisterServerEvent('NRP-Hud:GetMoneyStuff')
AddEventHandler('NRP-Hud:GetMoneyStuff', function()
    local data = {}
    while exports['core']:GetActiveCharacter(source) == nil do
        Citizen.Wait(0)
    end
    while exports['core']:GetActiveCharacter(source) == nil do
        Citizen.Wait(0)
    end
    data = exports['core']:GetActiveCharacter(source)
    TriggerClientEvent('NRP-Hud:DisplayMoneyStuff', source)
end)
