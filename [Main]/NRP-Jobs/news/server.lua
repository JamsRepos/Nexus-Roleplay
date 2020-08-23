RegisterCommand("cam", function(source, args, raw)

    TriggerEvent("core:getPlayerFromId", source, function(user)
        if user.getFaction() == 3 then
            TriggerClientEvent("Cam:ToggleCam", source)
        end
    end)
end)

RegisterCommand("bmic", function(source, args, raw)

    TriggerEvent("core:getPlayerFromId", source, function(user)
        if user.getFaction() == 3 then
            TriggerClientEvent("Mic:ToggleBMic", source)
        end
    end)
end)

RegisterCommand("mic", function(source, args, raw)

    TriggerEvent("core:getPlayerFromId", source, function(user)
        if user.getFaction() == 3 then
            TriggerClientEvent("Mic:ToggleMic", source)
        end
    end)
end)
