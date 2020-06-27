RegisterServerEvent('housing:storage:additems')
AddEventHandler('housing:storage:additems', function(id, item, name, qty, metadata)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  canGive = user.isAbleToGive(item,qty,metadata)
  if canGive then
   user.removeQuantity(item,qty,metadata)
    exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_inventorys` (unique_id, item, name, qty, meta) VALUES (@unique_id,@itemid,@item,@qty, @meta) ON DUPLICATE KEY UPDATE qty=qty+@qty',{['@unique_id'] = 'house-'..id, ['@qty'] = qty, ['@item'] = name, ['@itemid'] = item, ['@meta'] = metadata})
    TriggerEvent('housing:storage:refresh', source, id)
  end
 end)
end)

RegisterServerEvent('housing:storage:addweapon')
AddEventHandler('housing:storage:addweapon', function(id, name, label, id, blackmarket)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  user.removeWeapon(id, name)
  exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_weapons` (name, label, unique_id, weapon_id, blackmarket) VALUES (@name, @label, @id, @id, @blackmarket)',{['@id'] = 'house-'..id, ['@name'] = name, ['@label'] = label, ['@id'] = id, ['@blackmarket'] = blackmarket})
  TriggerEvent('housing:storage:refresh', source, id)
 end)
end)

RegisterServerEvent('housing:storage:removeitems')
AddEventHandler('housing:storage:removeitems', function(id, item, qty, meta)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  local canGet = user.isAbleToReceive(qty)
  if not canGet then
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = "Inventory Full"})
  else
   user.addQuantity(item,qty, meta)
   exports['GHMattiMySQL']:QueryAsync('UPDATE `stored_inventorys` SET `qty`= `qty` - @qty WHERE `unique_id` = @unique_id AND `item`= @item and `meta` = @meta',{['@unique_id'] = 'house-'..id, ['@qty'] = qty, ['@item'] = item, ['@meta'] = meta})
   TriggerEvent('housing:storage:refresh', source, id)
  end
 end)
end)

RegisterServerEvent('housing:storage:removeweapon')
AddEventHandler('housing:storage:removeweapon', function(hid, name, id, label, weapon_id, blackmarket)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  user.addWeapon(name, label, blackmarket)
  exports['GHMattiMySQL']:QueryAsync("DELETE FROM `stored_weapons` WHERE id=@id", {['@id'] = id})
  TriggerEvent('housing:storage:refresh', source, id)
 end)
end)

RegisterServerEvent('housing:storage:getInventory')
AddEventHandler('housing:storage:getInventory', function(id, storage)
 local source = tonumber(source)
 local storageitems = {}
 local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `stored_inventorys` WHERE unique_id=@unique_id",{['@unique_id'] = 'house-'..id}) 
 for _,v in pairs(result) do
  table.insert(storageitems, {id = v.id, name = v.name, item = v.item, q = v.qty, meta = v.meta})
 end
 ipl_storage = storage
 TriggerClientEvent('housing:storage:updateitems', source, storageitems, ipl_storage)
 TriggerClientEvent('housing:storage:openInventory', source, id, ipl_storage)
end)

RegisterServerEvent('housing:storage:refresh')
AddEventHandler('housing:storage:refresh', function(source, id)
 local source = tonumber(source)
 local storageitems = {}
 local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `stored_inventorys` WHERE unique_id=@unique_id",{['@unique_id'] = 'house-'..id}) 
 for _,v in pairs(result) do
  table.insert(storageitems, {id = v.id, name = v.name, item = v.item, q = v.qty, meta = v.meta})
 end
 --[[local weapons = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `stored_weapons` WHERE unique_id=@id",{['@id'] = 'house-'..id}) 
 for _,v in pairs(weapons) do
  table.insert(storageweapons, {id = v.id, name = v.name, label = v.label, weapon_id = weapon_id, blackmarket = v.blackmarket})
 end]]--
 TriggerClientEvent('housing:storage:updateitems', source, storageitems, ipl_storage)
end)