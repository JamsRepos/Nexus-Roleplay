local playerInjury = {}

function GetCharsInjuries(source)
    return playerInjury[source]
end

RegisterServerEvent('NRP-hospital:server:SyncInjuries')
AddEventHandler('NRP-hospital:server:SyncInjuries', function(data)
    playerInjury[source] = data
end)