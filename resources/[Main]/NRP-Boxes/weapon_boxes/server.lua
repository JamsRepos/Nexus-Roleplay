local weapon_boxes = {}

RegisterServerEvent('weapon_box:addweapon')
AddEventHandler('weapon_box:addweapon', function(box_id, name, label, id, blackmarket)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  user.removeWeapon(id, name)
  exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_weapons` (name, label, unique_id, weapon_id, blackmarket) VALUES (@name, @label, @box_id, @id, @blackmarket)',{['@box_id'] = 'wbox-'..box_id, ['@name'] = name, ['@label'] = label, ['@id'] = id, ['@blackmarket'] = blackmarket})
  TriggerEvent('weapon_box:refresh', source, box_id)
 end)
end)

RegisterServerEvent('weapon_box:removeweapon')
AddEventHandler('weapon_box:removeweapon', function(boxid, name, id, label, weapon_id, blackmarket)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  user.addStoredWeapon(weapon_id, name, label, blackmarket)
  exports['GHMattiMySQL']:QueryAsync("DELETE FROM `stored_weapons` WHERE id=@id", {['@id'] = id})
  TriggerEvent('weapon_box:refresh', source, boxid)
 end)
end)

RegisterServerEvent('weapon_box:getInventory')
AddEventHandler('weapon_box:getInventory', function(boxid)
 local source = tonumber(source)
 local storageweapons = {}
 local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `stored_weapons` WHERE unique_id=@unique_id",{['@unique_id'] = "wbox-"..boxid}) 
 for _,v in pairs(result) do
  table.insert(storageweapons, {id = v.id, name = v.name, label = v.label, weapon_id = weapon_id, blackmarket = v.blackmarket})
 end
 TriggerClientEvent('weapon_box:updateitems', source, storageweapons)
end)

RegisterServerEvent('weapon_box:refresh')
AddEventHandler('weapon_box:refresh', function(source, boxid)
 local source = tonumber(source)
 local storageweapons = {}
 local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `stored_weapons` WHERE unique_id=@unique_id",{['@unique_id'] = "wbox-"..boxid}) 
 for _,v in pairs(result) do
  table.insert(storageweapons, {id = v.id, name = v.name, label = v.label, weapon_id = weapon_id, blackmarket = v.blackmarket})
 end
 TriggerClientEvent('weapon_box:updateitems', source, storageweapons)
end)

-- Adding Boxes And Stuff
RegisterServerEvent('weapon_box:addbox')
AddEventHandler('weapon_box:addbox', function(x, y, z, pin)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  exports['GHMattiMySQL']:QueryAsync('INSERT INTO `weapon_boxes` (char_id, pin, location) VALUES (@charid, @pin, @location)',{['@charid'] = user.getCharacterID(), ['@pin'] = pin, ['@location'] = json.encode({x=x, y=y, z=z})})
  weapon_boxes = {}
  local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `weapon_boxes`")
  for _,v in pairs(result) do
   table.insert(weapon_boxes, {box_id = v.id, pin = v.pin, location = json.decode(v.location)})
  end
  TriggerClientEvent('weapon_box:updateboxes', -1, weapon_boxes)
 end)
end)

AddEventHandler('onResourceStart', function(resource)
 if resource == GetCurrentResourceName() then
  weapon_boxes = {}
  local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `weapon_boxes`")
  for _,v in pairs(result) do
   table.insert(weapon_boxes, {box_id = v.id, pin = v.pin, location = json.decode(v.location)})
  end
 end
end)

RegisterServerEvent('core:characterloaded')
AddEventHandler('core:characterloaded', function()
 TriggerClientEvent('weapon_box:updateboxes', source, weapon_boxes)
end)

RegisterServerEvent('weapon_box:removebox')
AddEventHandler('weapon_box:removebox', function(boxid)
 local source = tonumber(source)
 exports['GHMattiMySQL']:QueryAsync("DELETE FROM `weapon_boxes` WHERE id=@id", {['@id'] = boxid})
 exports['GHMattiMySQL']:QueryAsync("DELETE FROM `stored_weapons` WHERE unique_id=@id", {['@id'] = "wbox-"..boxid})
 weapon_boxes = {}
 local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `weapon_boxes`")
 for _,v in pairs(result) do
  table.insert(weapon_boxes, {box_id = v.id, pin = v.pin, location = json.decode(v.location)})
 end
 TriggerClientEvent('weapon_box:updateboxes', -1, weapon_boxes)
 TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Weapon Box Removed"})
end)

-- Adding Boxes And Stuff
RegisterServerEvent('weapon_box:move')
AddEventHandler('weapon_box:move', function(id, x, y, z)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  exports['GHMattiMySQL']:QueryAsync('UPDATE `weapon_boxes` SET `location`= @qty WHERE `id` = @id',{['@id'] = id, ['@qty'] = json.encode({x=x, y=y, z=z})})
  weapon_boxes = {}
  local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `weapon_boxes`")
  for _,v in pairs(result) do
   table.insert(weapon_boxes, {box_id = v.id, pin = v.pin, location = json.decode(v.location)})
  end
  TriggerClientEvent('weapon_box:updateboxes', -1, weapon_boxes)
 end)
end)
