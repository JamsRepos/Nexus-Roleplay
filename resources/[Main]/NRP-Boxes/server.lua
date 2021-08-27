RegisterServerEvent('vehicle_inventory:additems')
AddEventHandler('vehicle_inventory:additems', function(plate, item, name, qty)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  canGive = user.isAbleToGive(item,qty)
  local meta = user.getItemMeta(item)
  if canGive then
   user.removeQuantity(item,qty)
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_inventorys` (unique_id, item, name, qty) VALUES (@unique_id,@itemid,@item,@qty) ON DUPLICATE KEY UPDATE qty=qty+@qty',{['@unique_id'] = 'vehicle-'..plate, ['@qty'] = qty, ['@item'] = name, ['@itemid'] = item})
   TriggerEvent('vehicle_inventory:refresh', source, plate)
  end
 end)
end)

RegisterServerEvent('vehicle_inventory:addweapon')
AddEventHandler('vehicle_inventory:addweapon', function(plate, name, label, id, blackmarket)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  user.removeWeapon(id, model)
  exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_weapons` (name, label, unique_id, weapon_id, blackmarket) VALUES (@name, @label, @plate, @id, @blackmarket)',{['@plate'] = 'vehicle-'..plate, ['@name'] = name, ['@label'] = label, ['@id'] = id, ['@blackmarket'] = blackmarket})
  TriggerEvent('vehicle_inventory:refresh', source, plate)
 end)
end)

RegisterServerEvent('vehicle_inventory:removeitems')
AddEventHandler('vehicle_inventory:removeitems', function(plate, item, qty, meta)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user) 
  local canGet = user.isAbleToReceive(qty)
  if not canGet then
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = "Inventory Full"})
  else
   user.addQuantity(item,qty, meta)
   exports['GHMattiMySQL']:QueryAsync('UPDATE `stored_inventorys` SET `qty`= `qty` - @qty WHERE `unique_id` = @unique_id AND `item`= @item',{['@unique_id'] = 'vehicle-'..plate, ['@qty'] = qty, ['@item'] = item})
   TriggerEvent('vehicle_inventory:refresh', source, plate)
  end
 end)
end)

RegisterServerEvent('vehicle_inventory:removeweapon')
AddEventHandler('vehicle_inventory:removeweapon', function(plate, name, id, label, weapon_id, blackmarket)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  user.addStoredWeapon(weapon_id, name, label, blackmarket)
  exports['GHMattiMySQL']:QueryAsync("DELETE FROM `stored_weapons` WHERE id=@id", {['@id'] = id})
  TriggerEvent('vehicle_inventory:refresh', source, plate)
 end)
end)

RegisterServerEvent('vehicle_inventory:getInventory')
AddEventHandler('vehicle_inventory:getInventory', function(plate)
 local source = tonumber(source)
 local storageitems = {}
 local storageweapons = {}
 local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `stored_inventorys` WHERE unique_id=@unique_id",{['@unique_id'] = 'vehicle-'..plate}) 
 for _,v in pairs(result) do
  table.insert(storageitems, {id = v.id, name = v.name, item = v.item, q = v.qty, meta = v.meta})
 end
 local weapons = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `stored_weapons` WHERE unique_id=@plate",{['@plate'] = 'vehicle-'..plate}) 
 for _,v in pairs(weapons) do
  table.insert(storageweapons, {id = v.id, name = v.name, label = v.label, weapon_id = weapon_id, blackmarket = v.blackmarket})
 end
 TriggerClientEvent('vehicle_inventory:updateitems', source, storageitems, storageweapons)
 TriggerEvent("weapon:refresh", source) 
end)

RegisterServerEvent('vehicle_inventory:refresh')
AddEventHandler('vehicle_inventory:refresh', function(source, plate)
 local source = tonumber(source)
 local storageitems = {}
 local storageweapons = {}
 local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `stored_inventorys` WHERE unique_id=@unique_id",{['@unique_id'] = 'vehicle-'..plate}) 
 for _,v in pairs(result) do
  table.insert(storageitems, {id = v.id, name = v.name, item = v.item, q = v.qty, meta = v.meta})
 end
 local weapons = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `stored_weapons` WHERE unique_id=@plate",{['@plate'] = 'vehicle-'..plate}) 
 for _,v in pairs(weapons) do
  table.insert(storageweapons, {id = v.id, name = v.name, label = v.label, weapon_id = weapon_id, blackmarket = v.blackmarket})
 end
 TriggerClientEvent('vehicle_inventory:updateitems', source, storageitems, storageweapons)
 TriggerEvent("weapon:refresh", source) 
end)