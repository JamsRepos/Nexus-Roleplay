RegisterServerEvent('skinCreation:save')
AddEventHandler('skinCreation:save', function(skinData)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  exports['GHMattiMySQL']:QueryAsync("UPDATE `characters` SET `skin` = @skin WHERE id = @id", {['@id'] = user.getCharacterID(), ['@skin'] = skinData})
 end)
end)

RegisterServerEvent('skinCreation:load')
AddEventHandler('skinCreation:load', function(gender)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM characters WHERE id = @id", {['@id'] = user.getCharacterID()})
  if result[1].skin then
   TriggerClientEvent('skinCreation:load', source, json.decode(result[1].skin))
  else 
   TriggerClientEvent('skinCreation:new', source, result[1].gender)
  end
 end)
end)

RegisterServerEvent('skinCreation:surgery')
AddEventHandler('skinCreation:surgery', function()
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM characters WHERE id = @id", {['@id'] = user.getCharacterID()})
  if result[1].gender then
   TriggerClientEvent('skin:surgery', source, result[1].gender)
  end
 end)
end)