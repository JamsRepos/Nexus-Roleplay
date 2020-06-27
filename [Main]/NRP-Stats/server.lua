RegisterServerEvent('stats:add')
AddEventHandler('stats:add', function(name, value)
 local source = tonumber(source)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  user.addStatistic(name, value)
  TriggerClientEvent('stats:character', source, user.getStatistics())
 end)
end)

RegisterServerEvent('stats:remove')
AddEventHandler('stats:remove', function(name, value)
 local source = tonumber(source)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  user.removeStatistic(name, value)
  TriggerClientEvent('stats:character', source, user.getStatistics())
 end)
end)


RegisterServerEvent('stats:load')
AddEventHandler('stats:load', function(source)
 local source = tonumber(source)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  TriggerClientEvent('stats:character', source, user.getStatistics())
 end)
end)


    
TriggerEvent('core:addGroupCommand', 'stats', 'user', function(source, args, user)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  TriggerClientEvent('chatMessage', source, "^5You Character Statistics: ")
  for _,v in pairs(user.getStatistics()) do
   TriggerClientEvent('chatMessage', source, v.name.." - "..v.value)
  end
 end)
end)



TriggerEvent('core:addGroupCommand', 'playtime', 'user', function(source, args, user)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  TriggerClientEvent('chatMessage', source, "^5Your Playtime On This Character Is "..user.getPlaytime().." Minutes")
 end)
end)