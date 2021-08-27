local vat = {}

RegisterNetEvent('vat:update')
AddEventHandler('vat:update', function(v)
 vat = v
end)

function getVat(id)
 return vat[id]
end
