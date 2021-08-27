RegisterServerEvent('chopshop:openlist')
AddEventHandler('chopshop:openlist', function(id)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  local data = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `chopshop_lists` WHERE id=@id",{['@id'] = id})
  if data[1] then 
   print('Opening the thing')
   TriggerClientEvent("choplist:load", source, data[1].text) 
  else 
   print('Chopshop Error')
  end
 end)
end)

RegisterServerEvent('chopshop:getlist')
AddEventHandler('chopshop:getlist', function(chopPossibility)
 local source = tonumber(source)
  local data = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `chopshop_lists` WHERE id=@id",{['@id'] = chopPossibility})
   local car1 = data[1].car1
   local car2 = data[1].car2
   local car3 = data[1].car3
   local car4 = data[1].car4
   local car5 = data[1].car5
   local car6 = data[1].car6
   local car7 = data[1].car7
   local car8 = data[1].car8
   local car9 = data[1].car9
   local car10 = data[1].car10  
    TriggerClientEvent('choplist:sendlist', source, car1, car2, car3, car4, car5, car6, car7, car8, car9, car10)  
end)