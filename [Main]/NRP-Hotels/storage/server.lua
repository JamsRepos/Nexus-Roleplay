-----New Housing
RegisterServerEvent('motel:storage:additems')
AddEventHandler('motel:storage:additems', function(id, item, name, qty, metadata)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  canGive = user.isAbleToGive(item,qty,metadata)
  if canGive then
   user.removeQuantity(item,qty,metadata)
    exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_inventorys` (unique_id, item, name, qty, meta) VALUES (@unique_id,@itemid,@item,@qty, @meta) ON DUPLICATE KEY UPDATE qty=qty+@qty',{['@unique_id'] = 'motel-'..id, ['@qty'] = qty, ['@item'] = name, ['@itemid'] = item, ['@meta'] = metadata})
    TriggerEvent('motel:storage:refresh', source, id)
  end
 end)
end)

RegisterServerEvent('motel:storage:addweapon')
AddEventHandler('motel:storage:addweapon', function(id, name, label, id, blackmarket)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  user.removeWeapon(id, name)
  exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_weapons` (name, label, unique_id, weapon_id, blackmarket) VALUES (@name, @label, @id, @id, @blackmarket)',{['@id'] = 'motel-'..id, ['@name'] = name, ['@label'] = label, ['@id'] = id, ['@blackmarket'] = blackmarket})
  TriggerEvent('motel:storage:refresh', source, id)
 end)
end)

RegisterServerEvent('motel:storage:removeitems')
AddEventHandler('motel:storage:removeitems', function(id, item, qty, meta)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  local canGet = user.isAbleToReceive(qty)
  if not canGet then
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = "Inventory Full"})
  else
   user.addQuantity(item,qty, meta)
   exports['GHMattiMySQL']:QueryAsync('UPDATE `stored_inventorys` SET `qty`= `qty` - @qty WHERE `unique_id` = @unique_id AND `item`= @item and `meta` = @meta',{['@unique_id'] = 'motel-'..id, ['@qty'] = qty, ['@item'] = item, ['@meta'] = meta})
   TriggerEvent('motel:storage:refresh', source, id)
  end
 end)
end)

RegisterServerEvent('motel:storage:removeweapon')
AddEventHandler('motel:storage:removeweapon', function(hid, name, id, label, weapon_id, blackmarket)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  user.addWeapon(name, label, blackmarket)
  exports['GHMattiMySQL']:QueryAsync("DELETE FROM `stored_weapons` WHERE id=@id", {['@id'] = id})
  TriggerEvent('motel:storage:refresh', source, id)
 end)
end)

RegisterServerEvent('motel:storage:getInventory')
AddEventHandler('motel:storage:getInventory', function(id)
 local source = tonumber(source)
 local storageitems = {}
 local storageweapons = {}
 local totalResult = 0
 local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `stored_inventorys` WHERE unique_id=@unique_id",{['@unique_id'] = 'motel-'..id}) 
 for _,v in pairs(result) do
  table.insert(storageitems, {id = v.id, name = v.name, item = v.item, q = v.qty, meta = v.meta})
  totalResult = totalResult + v.qty
 end
 TriggerClientEvent('motel:storage:updateitems', source, storageitems, storageweapons, totalResult)
 TriggerClientEvent('motel:storage:openInventory', source, id)
end)

RegisterServerEvent('motel:storage:refresh')
AddEventHandler('motel:storage:refresh', function(source, id)
 local source = tonumber(source)
 local storageitems = {}
 local storageweapons = {}
 local totalResult = 0
 local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `stored_inventorys` WHERE unique_id=@unique_id",{['@unique_id'] = 'motel-'..id}) 
 for _,v in pairs(result) do
  table.insert(storageitems, {id = v.id, name = v.name, item = v.item, q = v.qty, meta = v.meta})
  totalResult = totalResult + v.qty
 end
 TriggerClientEvent('motel:storage:updateitems', source, storageitems, storageweapons, totalResult)
end)