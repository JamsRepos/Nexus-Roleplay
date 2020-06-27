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