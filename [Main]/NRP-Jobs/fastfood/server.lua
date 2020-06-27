RegisterServerEvent('fastfood:getstock')
AddEventHandler('fastfood:getstock', function(storeid)
 local source = tonumber(source)
 exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM restraunt_stock WHERE `storeid` = @storeid", {['@storeid'] = storeid}, function(results)
   TriggerClientEvent('fastfood:getstock', source, results)
 end)
end)

RegisterServerEvent('fastfood:addstock')
AddEventHandler('fastfood:addstock', function(storeid, itemid, amount)
 local stock = exports['GHMattiMySQL']:QueryResult("SELECT * FROM restraunt_stock WHERE storeid = @storeid AND itemid = @itemid", {['@storeid'] = storeid, ['@itemid'] = itemid})
 local currentStock = stock[1].amount
 local newStock = currentStock + amount

 exports['GHMattiMySQL']:QueryAsync('UPDATE `restraunt_stock` SET amount=@amount WHERE storeid=@storeid AND itemid = @itemid',{['@amount'] = newStock, ['@storeid'] = storeid, ['@itemid'] = itemid})
end)

RegisterServerEvent('fastfood:removestock')
AddEventHandler('fastfood:removestock', function(storeid, itemid, amount, price)
 local source = tonumber(source)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  if user.getMoney() >= price then
   local stock = exports['GHMattiMySQL']:QueryResult("SELECT * FROM restraunt_stock WHERE storeid = @storeid AND itemid = @itemid", {['@storeid'] = storeid, ['@itemid'] = itemid})
   local currentStock = stock[1].amount
   local newStock = currentStock - amount

   exports['GHMattiMySQL']:QueryAsync('UPDATE `restraunt_stock` SET amount=@amount WHERE storeid=@storeid AND itemid = @itemid',{['@amount'] = newStock, ['@storeid'] = storeid, ['@itemid'] = itemid})
  end
 end)
end)










