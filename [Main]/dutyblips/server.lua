local clients = {}

RegisterServerEvent("blips:activate")
AddEventHandler("blips:activate", function(ser)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  local source = source
  clients[source] = {id = tonumber(source), service = ser, name = user.getIdentity().fullname}
  TriggerClientEvent("blips:sync", -1, clients)
 end)
end)

RegisterServerEvent("blips:deactivate")
AddEventHandler("blips:deactivate", function()
  local source = source
  clients[source] = nil
  TriggerClientEvent("blips:remove", source)
  TriggerClientEvent("blips:sync", -1, clients)
end)

AddEventHandler("playerDropped", function()
  local source = source
  if clients[source] then
    clients[source] = nil
    TriggerClientEvent("blips:sync", -1, clients)
  end
end)