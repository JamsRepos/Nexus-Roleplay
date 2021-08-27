local vat = {}

AddEventHandler('onResourceStart', function(resource)
 if resource == GetCurrentResourceName() then
  local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `server_statistics`")    
  for i,v in pairs(result) do
   vat[v.id] = v.value
  end
 end
end)

RegisterServerEvent('core:characterloaded')
AddEventHandler('core:characterloaded', function()
 TriggerClientEvent('vat:update', -1, vat)
end)

function getVat(id)
 return vat[id]
end
