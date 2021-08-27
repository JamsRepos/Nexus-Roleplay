RegisterCommand("nitro", function(source)
    TriggerEvent("NitroCheck", source)
end)

RegisterServerEvent("NitroCheck")
AddEventHandler("NitroCheck", function(source)
    if exports.discord_perms:IsRolePresent(source, "Nitro Booster") then
        TriggerClientEvent("NitroConfirmation", source, true)
    else
        TriggerClientEvent("NitroConfirmation", source, false)
    end
end)