RegisterServerEvent('onyx:updateSearchedVehTable')
AddEventHandler('onyx:updateSearchedVehTable', function(plate)
    local _source = source
    local vehPlate = plate

    TriggerClientEvent('onyx:returnSearchedVehTable', -1, vehPlate)
end)

RegisterServerEvent('onyx:reqHotwiring')
AddEventHandler('onyx:reqHotwiring', function(plate)
    local _source = source
    TriggerClientEvent('onyx:beginHotwire', source, plate)
end)


RegisterServerEvent('onyx:reqAdvHotwiring')
AddEventHandler('onyx:reqAdvHotwiring', function(plate)
    local _source = source
    TriggerClientEvent('onyx:beginAdvHotwire', source, plate)
end)

RegisterServerEvent("onyx:giveKey")
AddEventHandler("onyx:giveKey", function(target, plate)
    local source = tonumber(source)
    local target = tonumber(target)
    TriggerEvent('core:getPlayerFromId', target, function(them)
        TriggerClientEvent('onyx:updatePlates', target, plate)
        TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = "You have given a spare key to " .. them.getIdentity().fullname .. " for plate: " .. plate, length = 5000})
    end)
end)