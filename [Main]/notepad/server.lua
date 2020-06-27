RegisterServerEvent('notepad:save')
AddEventHandler('notepad:save', function(text, page)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  exports['GHMattiMySQL']:QueryAsync('INSERT INTO `notepad_entrys` (char_id, page, text) VALUES (@char_id, @page, @text) ON DUPLICATE KEY UPDATE text=@text',{['@char_id'] = user.getCharacterID(), ['@page'] = page, ['@text'] = text})
 end)
end)

TriggerEvent('core:addGroupCommand', 'notepad', 'user', function(source, args, user)
 local source = tonumber(source)
 local page = '1'
 if args[2] then page = args[2] end
 TriggerEvent('core:getPlayerFromId', source, function(user)
  local data = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `notepad_entrys` WHERE char_id=@char_id AND page=@page",{['@char_id'] = user.getCharacterID(), ['@page'] = page})
  if data[1] then 
   TriggerClientEvent("notepad:load", source, data[1].text, page) 
  else 
   TriggerClientEvent("notepad:load", source, 'Enter Some Stuff', page)  
  end
 end)
end)