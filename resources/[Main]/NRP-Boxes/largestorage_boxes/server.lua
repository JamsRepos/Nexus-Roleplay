local storage_boxes2 = {}
 
RegisterServerEvent('storage_box2:additems')
AddEventHandler('storage_box2:additems', function(boxid, item, name, qty, metadata)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  canGive = user.isAbleToGive(item,qty,metadata)
  local meta = user.getItemMeta(item)
  if canGive then
   user.removeQuantity(item,qty,metadata)
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_inventorys` (unique_id, item, name, qty, meta) VALUES (@unique_id,@itemid,@item,@qty, @meta) ON DUPLICATE KEY UPDATE qty=qty+@qty',{['@unique_id'] = "lbox-"..boxid, ['@qty'] = qty, ['@item'] = name, ['@itemid'] = item, ['@meta'] = metadata})   TriggerEvent('storage_box2:refresh', source, boxid)
  end
 end)
end)
 
RegisterServerEvent('storage_box2:removeitems')
AddEventHandler('storage_box2:removeitems', function(boxid, item, qty, meta)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  local canGet = user.isAbleToReceive(qty)
  if not canGet then
   GNotify(source, 'Inventory Full')
  else
   user.addQuantity(item,qty, meta)
   exports['GHMattiMySQL']:QueryAsync('UPDATE `stored_inventorys` SET `qty`= `qty` - @qty WHERE `unique_id` = @unique_id AND `item`= @item and `meta` = @meta',{['@unique_id'] = "lbox-"..boxid, ['@qty'] = qty, ['@item'] = item, ['@meta'] = meta})
   TriggerEvent('storage_box2:refresh', source, boxid)
  end
 end)
end)
 
RegisterServerEvent('storage_box2:getInventory')
AddEventHandler('storage_box2:getInventory', function(boxid)
 local source = tonumber(source)
 local storageitems = {}
 local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `stored_inventorys` WHERE unique_id=@unique_id",{['@unique_id'] = "lbox-"..boxid})
 for _,v in pairs(result) do
  table.insert(storageitems, {id = v.id, name = v.name, item = v.item, q = v.qty, meta = v.meta})
 end
 TriggerClientEvent('storage_box2:updateitems', source, storageitems)
 TriggerClientEvent('storage_box2:openInventory', source, boxid)
end)
 
RegisterServerEvent('storage_box2:refresh')
AddEventHandler('storage_box2:refresh', function(source, boxid)
 local source = tonumber(source)
 local storageitems = {}
 local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `stored_inventorys` WHERE unique_id=@unique_id",{['@unique_id'] = "lbox-"..boxid})
 for _,v in pairs(result) do
  table.insert(storageitems, {id = v.id, name = v.name, item = v.item, q = v.qty, meta = v.meta})
 end
 TriggerClientEvent('storage_box2:updateitems', source, storageitems)
end)
 
-- Adding Boxes And Stuff
RegisterServerEvent('storage_box2:addbox')
AddEventHandler('storage_box2:addbox', function(x, y, z, pin)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  exports['GHMattiMySQL']:QueryAsync('INSERT INTO `large_storage_boxes` (char_id, pin, location) VALUES (@charid, @pin, @location)',{['@charid'] = user.getCharacterID(), ['@pin'] = pin, ['@location'] = json.encode({x=x, y=y, z=z})})
  storage_boxes2 = {}
  local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `large_storage_boxes`")
  for _,v in pairs(result) do
   table.insert(storage_boxes2, {box_id = v.id, pin = v.pin, location = json.decode(v.location)})
  end
  TriggerClientEvent('storage_box2:updateboxes', -1, storage_boxes2)
 end)
end)
 
AddEventHandler('onResourceStart', function(resource)
 if resource == GetCurrentResourceName() then
  storage_boxes2 = {}
  local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `large_storage_boxes`")
  for _,v in pairs(result) do
   table.insert(storage_boxes2, {box_id = v.id, pin = v.pin, location = json.decode(v.location)})
  end
 end
end)
 
RegisterServerEvent('core:characterloaded')
AddEventHandler('core:characterloaded', function()
 TriggerClientEvent('storage_box2:updateboxes', source, storage_boxes2)
end)
 
RegisterServerEvent('storage_box2:removebox')
AddEventHandler('storage_box2:removebox', function(boxid)
 local source = tonumber(source)
 exports['GHMattiMySQL']:QueryAsync("DELETE FROM `large_storage_boxes` WHERE id=@id", {['@id'] = boxid})
 exports['GHMattiMySQL']:QueryAsync("DELETE FROM `stored_inventorys` WHERE unique_id=@id", {['@id'] = "lbox-"..boxid})
 storage_boxes2 = {}
 local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `large_storage_boxes`")
 for _,v in pairs(result) do
  table.insert(storage_boxes2, {box_id = v.id, pin = v.pin, location = json.decode(v.location)})
 end
 TriggerClientEvent('storage_box2:updateboxes', -1, storage_boxes2)
 TriggerClientEvent("pNotify:SendNotification", source, {text = "Storage Box Removed"})
end)

RegisterServerEvent('storage_box2:is_owner')
AddEventHandler('storage_box2:is_owner', function(bid) 
    local src = source
    TriggerEvent('core:getPlayerFromId', source, function(user)
        local characterid = nil
        local character_id = user.getCharacterID()
        local dbox = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `large_storage_boxes` WHERE char_id = "..character_id.." AND id = "..bid)
        for k, v in pairs(dbox) do
            characterid = v.char_id
        end
        if character_id == characterid then
            TriggerEvent('storage_box2:removebox', bid)
            TriggerClientEvent('NRP-notify:client:SendAlert', src, { type = 'inform', text = "Box sold for $40,000"})
            TriggerEvent("core:moneylog", src, 'Large Storage Box sold for $40,000')
            user.addBank(40000)
        else
            TriggerClientEvent('NRP-notify:client:SendAlert', src, { type = 'inform', text = "You don't own this box"})
        end
    end)
end)
 
-- Adding Boxes And Stuff
RegisterServerEvent('storage_box2:move')
AddEventHandler('storage_box2:move', function(id, x, y, z)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  exports['GHMattiMySQL']:QueryAsync('UPDATE `large_storage_boxes` SET `location`= @qty WHERE `id` = @id',{['@id'] = id, ['@qty'] = json.encode({x=x, y=y, z=z})})
  storage_boxes2 = {}
  local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `large_storage_boxes`")
  for _,v in pairs(result) do
   table.insert(storage_boxes2, {box_id = v.id, pin = v.pin, location = json.decode(v.location)})
  end
  TriggerClientEvent('storage_box2:updateboxes', -1, storage_boxes2)
 end)
end)