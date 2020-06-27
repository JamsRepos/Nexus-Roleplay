RegisterServerEvent('xz:getstock')
AddEventHandler('xz:getstock', function(storeid)
 local source = tonumber(source)
 exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM smokeonwater WHERE `storeid` = @storeid", {['@storeid'] = storeid}, function(results)
   TriggerClientEvent('xz:getstock', source, results)
 end)
end)

RegisterServerEvent('xz:addstock')
AddEventHandler('xz:addstock', function(storeid, itemid, amount)
 local stock = exports['GHMattiMySQL']:QueryResult("SELECT * FROM smokeonwater WHERE storeid = @storeid AND itemid = @itemid", {['@storeid'] = storeid, ['@itemid'] = itemid})
 local currentStock = stock[1].amount
 local newStock = currentStock + amount

 exports['GHMattiMySQL']:QueryAsync('UPDATE `smokeonwater` SET amount=@amount WHERE storeid=@storeid AND itemid = @itemid',{['@amount'] = newStock, ['@storeid'] = storeid, ['@itemid'] = itemid})
end)

RegisterServerEvent('xz:removestock')
AddEventHandler('xz:removestock', function(storeid, itemid, amount, price)
 local source = tonumber(source)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  if user.getMoney() >= price then
   local stock = exports['GHMattiMySQL']:QueryResult("SELECT * FROM smokeonwater WHERE storeid = @storeid AND itemid = @itemid", {['@storeid'] = storeid, ['@itemid'] = itemid})
   local currentStock = stock[1].amount
   local newStock = currentStock - amount

   exports['GHMattiMySQL']:QueryAsync('UPDATE `smokeonwater` SET amount=@amount WHERE storeid=@storeid AND itemid = @itemid',{['@amount'] = newStock, ['@storeid'] = storeid, ['@itemid'] = itemid})
  end
 end)
end)

--- MAKE NEW DATABASE TABLE AND COLUMS AND THIS SHOULD BE DONE 



RegisterServerEvent('weedrun:check')
AddEventHandler('weedrun:check', function()
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM dmv_users WHERE `char_id` = @char_id", {['@char_id'] = user.getCharacterID()}, function(character)
    if character[1] then
	 TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Do /drops to toggle on and off duty, Make sure to Stay Stocked up"})
    else
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "You need a driving license to deliver"})
    end
  end)
 end)
end)