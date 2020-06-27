local cooler_boxes = {}

RegisterServerEvent('cooler_box:additems')
AddEventHandler('cooler_box:additems', function(boxid, item, name, qty)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  canGive = user.isAbleToGive(item,qty)
  if canGive then
   user.removeQuantity(item,qty)
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_inventorys` (unique_id, item, name, qty) VALUES (@unique_id,@itemid,@item,@qty) ON DUPLICATE KEY UPDATE qty=qty+ @qty',{['@unique_id'] = "cooler-"..boxid, ['@qty'] = qty, ['@item'] = name, ['@itemid'] = item})
   TriggerEvent('cooler_box:refresh', source, boxid)
  end
 end)
end)

RegisterServerEvent('cooler_box:removeitems')
AddEventHandler('cooler_box:removeitems', function(boxid, item, qty)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  local canGet = user.isAbleToReceive(qty)
  if not canGet then
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = "Inventory Full"})
  else
   user.addQuantity(item,qty)
   exports['GHMattiMySQL']:QueryAsync('UPDATE `stored_inventorys` SET `qty`= `qty` - @qty WHERE `unique_id` = @unique_id AND `item`= @item',{['@unique_id'] = "cooler-"..boxid, ['@qty'] = qty, ['@item'] = item})
   TriggerEvent('cooler_box:refresh', source, boxid)
  end
 end)
end)

RegisterServerEvent('cooler_box:getInventory')
AddEventHandler('cooler_box:getInventory', function(boxid)
 local source = tonumber(source)
 local cooleritems = {}
 local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `stored_inventorys` WHERE unique_id=@unique_id",{['@unique_id'] = "cooler-"..boxid}) 
 for _,v in pairs(result) do
  table.insert(cooleritems, {id = v.id, name = v.name, item = v.item, q = v.qty})
 end
 TriggerClientEvent('cooler_box:updateitems', source, cooleritems)
end)

RegisterServerEvent('cooler_box:refresh')
AddEventHandler('cooler_box:refresh', function(source, boxid)
 local source = tonumber(source)
 local cooleritems = {}
 local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `stored_inventorys` WHERE unique_id=@unique_id",{['@unique_id'] = "cooler-"..boxid}) 
 for _,v in pairs(result) do
  table.insert(cooleritems, {id = v.id, name = v.name, item = v.item, q = v.qty})
 end
 TriggerClientEvent('cooler_box:updateitems', source, cooleritems)
end)

-- Adding Boxes And Stuff
RegisterServerEvent('cooler_box:addbox')
AddEventHandler('cooler_box:addbox', function(x, y, z)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  exports['GHMattiMySQL']:QueryAsync('INSERT INTO `cooler_boxes` (char_id, location) VALUES (@charid, @location)',{['@charid'] = user.getCharacterID(), ['@location'] = json.encode({x=x, y=y, z=z})})
  cooler_boxes = {}
  local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `cooler_boxes`")
  for _,v in pairs(result) do
   table.insert(cooler_boxes, {box_id = v.id, location = json.decode(v.location)})
  end
  TriggerClientEvent('cooler_box:updateboxes', -1, cooler_boxes)
 end)
end)

AddEventHandler('onResourceStart', function(resource)
 if resource == GetCurrentResourceName() then
  cooler_boxes = {}
  local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `cooler_boxes`")
  for _,v in pairs(result) do
   table.insert(cooler_boxes, {box_id = v.id, location = json.decode(v.location)})
  end
 end
end)

RegisterServerEvent('core:characterloaded')
AddEventHandler('core:characterloaded', function()
 TriggerClientEvent('cooler_box:updateboxes', source, cooler_boxes)
end)

RegisterServerEvent('cooler_box:removebox')
AddEventHandler('cooler_box:removebox', function(boxid)
 local source = tonumber(source)
 exports['GHMattiMySQL']:QueryAsync("DELETE FROM `cooler_boxes` WHERE id=@id", {['@id'] = boxid})
 exports['GHMattiMySQL']:QueryAsync("DELETE FROM `stored_inventorys` WHERE unique_id=@id", {['@id'] = "cooler-"..boxid})
 cooler_boxes = {}
 local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `cooler_boxes`")
 for _,v in pairs(result) do
  table.insert(cooler_boxes, {box_id = v.id, location = json.decode(v.location)})
 end
 TriggerClientEvent('cooler_box:updateboxes', -1, cooler_boxes)
 TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Storage Box Removed"})
end)

-- Adding Boxes And Stuff
RegisterServerEvent('cooler_box:move')
AddEventHandler('cooler_box:move', function(id, x, y, z)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  exports['GHMattiMySQL']:QueryAsync('UPDATE `cooler_boxes` SET `location`= @qty WHERE `id` = @id',{['@id'] = id, ['@qty'] = json.encode({x=x, y=y, z=z})})
  cooler_boxes = {}
  local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `cooler_boxes`")
  for _,v in pairs(result) do
   table.insert(cooler_boxes, {box_id = v.id, location = json.decode(v.location)})
  end
  TriggerClientEvent('cooler_box:updateboxes', -1, cooler_boxes)
 end)
end)
