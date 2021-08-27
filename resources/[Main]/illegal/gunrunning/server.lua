RegisterServerEvent('gun:startZone')
AddEventHandler('gun:startZone', function()
 local source = tonumber(source)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  if user.getFaction() == 1 or user.getFaction() == 7 or user.getFaction() == 9 then
   if user.getBank() >= 125000 then 
    TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Brum Brum, Harry Potter is on his way!"})
    TriggerClientEvent('guns:delivery', source)
    TriggerEvent("core:adminlog", tostring("[AIRDROP] "..user.getIdentity().fullname.." has just called in big fuck-off plane for more guns.", "admin"))
    user.removeBank(125000)
   else
    TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Harry Potter's want isn't hard enough. Get more money.."})
   end
  end
 end)
end)

RegisterServerEvent('gun:addGuns')
AddEventHandler('gun:addGuns', function(plate)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  if user.getFaction() == 6 then
   -- Handjob
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_weapons` (unique_id, name, label, blackmarket) VALUES (@unique_id, @name, @label, @blackmarket)',{['@unique_id'] = 'vehicle-'..plate, ['@name'] = 'WEAPON_ASSAULTRIFLE', ['@label'] = 'Assault Rifle', ['@blackmarket'] = 1})
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_weapons` (unique_id, name, label, blackmarket) VALUES (@unique_id, @name, @label, @blackmarket)',{['@unique_id'] = 'vehicle-'..plate, ['@name'] = 'WEAPON_ASSAULTRIFLE', ['@label'] = 'Assault Rifle', ['@blackmarket'] = 1})
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_weapons` (unique_id, name, label, blackmarket) VALUES (@unique_id, @name, @label, @blackmarket)',{['@unique_id'] = 'vehicle-'..plate, ['@name'] = 'WEAPON_GUSENBERG', ['@label'] = 'Gusenberg Sweaper', ['@blackmarket'] = 1})
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_weapons` (unique_id, name, label, blackmarket) VALUES (@unique_id, @name, @label, @blackmarket)',{['@unique_id'] = 'vehicle-'..plate, ['@name'] = 'WEAPON_GUSENBERG', ['@label'] = 'Gusenberg Sweaper', ['@blackmarket'] = 1})
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_weapons` (unique_id, name, label, blackmarket) VALUES (@unique_id, @name, @label, @blackmarket)',{['@unique_id'] = 'vehicle-'..plate, ['@name'] = 'WEAPON_GUSENBERG', ['@label'] = 'Gusenberg Sweaper', ['@blackmarket'] = 1})
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_weapons` (unique_id, name, label, blackmarket) VALUES (@unique_id, @name, @label, @blackmarket)',{['@unique_id'] = 'vehicle-'..plate, ['@name'] = 'WEAPON_REVOLVER', ['@label'] = 'Revolver', ['@blackmarket'] = 1})
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_weapons` (unique_id, name, label, blackmarket) VALUES (@unique_id, @name, @label, @blackmarket)',{['@unique_id'] = 'vehicle-'..plate, ['@name'] = 'WEAPON_REVOLVER', ['@label'] = 'Revolver', ['@blackmarket'] = 1})
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_weapons` (unique_id, name, label, blackmarket) VALUES (@unique_id, @name, @label, @blackmarket)',{['@unique_id'] = 'vehicle-'..plate, ['@name'] = 'WEAPON_REVOLVER', ['@label'] = 'Revolver', ['@blackmarket'] = 1})
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_weapons` (unique_id, name, label, blackmarket) VALUES (@unique_id, @name, @label, @blackmarket)',{['@unique_id'] = 'vehicle-'..plate, ['@name'] = 'WEAPON_REVOLVER', ['@label'] = 'Revolver', ['@blackmarket'] = 1})
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_weapons` (unique_id, name, label, blackmarket) VALUES (@unique_id, @name, @label, @blackmarket)',{['@unique_id'] = 'vehicle-'..plate, ['@name'] = 'WEAPON_REVOLVER', ['@label'] = 'Revolver', ['@blackmarket'] = 1})
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_weapons` (unique_id, name, label, blackmarket) VALUES (@unique_id, @name, @label, @blackmarket)',{['@unique_id'] = 'vehicle-'..plate, ['@name'] = 'WEAPON_BULLPUPSHOTGUN', ['@label'] = 'Bullpup Shotgun', ['@blackmarket'] = 1})
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_weapons` (unique_id, name, label, blackmarket) VALUES (@unique_id, @name, @label, @blackmarket)',{['@unique_id'] = 'vehicle-'..plate, ['@name'] = 'WEAPON_BULLPUPSHOTGUN', ['@label'] = 'Bullpup Shotgun', ['@blackmarket'] = 1})
  elseif user.getFaction() == 7 then
  -- Street Gang Guns
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_weapons` (unique_id, name, label, blackmarket) VALUES (@unique_id, @name, @label, @blackmarket)',{['@unique_id'] = 'vehicle-'..plate, ['@name'] = 'WEAPON_COMPACTRIFLE', ['@label'] = 'Compact Rifle', ['@blackmarket'] = 1})
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_weapons` (unique_id, name, label, blackmarket) VALUES (@unique_id, @name, @label, @blackmarket)',{['@unique_id'] = 'vehicle-'..plate, ['@name'] = 'WEAPON_COMPACTRIFLE', ['@label'] = 'Compact Rifle', ['@blackmarket'] = 1})
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_weapons` (unique_id, name, label, blackmarket) VALUES (@unique_id, @name, @label, @blackmarket)',{['@unique_id'] = 'vehicle-'..plate, ['@name'] = 'WEAPON_MICROSMG', ['@label'] = 'Micro SMG', ['@blackmarket'] = 1})
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_weapons` (unique_id, name, label, blackmarket) VALUES (@unique_id, @name, @label, @blackmarket)',{['@unique_id'] = 'vehicle-'..plate, ['@name'] = 'WEAPON_MICROSMG', ['@label'] = 'Micro SMG', ['@blackmarket'] = 1})
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_weapons` (unique_id, name, label, blackmarket) VALUES (@unique_id, @name, @label, @blackmarket)',{['@unique_id'] = 'vehicle-'..plate, ['@name'] = 'WEAPON_MICROSMG', ['@label'] = 'Micro SMG', ['@blackmarket'] = 1})
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_weapons` (unique_id, name, label, blackmarket) VALUES (@unique_id, @name, @label, @blackmarket)',{['@unique_id'] = 'vehicle-'..plate, ['@name'] = 'WEAPON_MACHINEPISTOL', ['@label'] = 'Machine Pistol', ['@blackmarket'] = 1})
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_weapons` (unique_id, name, label, blackmarket) VALUES (@unique_id, @name, @label, @blackmarket)',{['@unique_id'] = 'vehicle-'..plate, ['@name'] = 'WEAPON_MACHINEPISTOL', ['@label'] = 'Machine Pistol', ['@blackmarket'] = 1})
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_weapons` (unique_id, name, label, blackmarket) VALUES (@unique_id, @name, @label, @blackmarket)',{['@unique_id'] = 'vehicle-'..plate, ['@name'] = 'WEAPON_MACHINEPISTOL', ['@label'] = 'Machine Pistol', ['@blackmarket'] = 1})
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_weapons` (unique_id, name, label, blackmarket) VALUES (@unique_id, @name, @label, @blackmarket)',{['@unique_id'] = 'vehicle-'..plate, ['@name'] = 'WEAPON_MACHINEPISTOL', ['@label'] = 'Machine Pistol', ['@blackmarket'] = 1})
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_weapons` (unique_id, name, label, blackmarket) VALUES (@unique_id, @name, @label, @blackmarket)',{['@unique_id'] = 'vehicle-'..plate, ['@name'] = 'WEAPON_MACHINEPISTOL', ['@label'] = 'Machine Pistol', ['@blackmarket'] = 1})
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_weapons` (unique_id, name, label, blackmarket) VALUES (@unique_id, @name, @label, @blackmarket)',{['@unique_id'] = 'vehicle-'..plate, ['@name'] = 'WEAPON_MACHETE', ['@label'] = 'Machete', ['@blackmarket'] = 1})
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_weapons` (unique_id, name, label, blackmarket) VALUES (@unique_id, @name, @label, @blackmarket)',{['@unique_id'] = 'vehicle-'..plate, ['@name'] = 'WEAPON_MACHETE', ['@label'] = 'Machete', ['@blackmarket'] = 1})
  elseif user.getFaction() == 9 then
   -- Tommy
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_weapons` (unique_id, name, label, blackmarket) VALUES (@unique_id, @name, @label, @blackmarket)',{['@unique_id'] = 'vehicle-'..plate, ['@name'] = 'WEAPON_SAWNOFFSHOTGUN', ['@label'] = 'Sawnoff Shotgun', ['@blackmarket'] = 1})
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_weapons` (unique_id, name, label, blackmarket) VALUES (@unique_id, @name, @label, @blackmarket)',{['@unique_id'] = 'vehicle-'..plate, ['@name'] = 'WEAPON_SAWNOFFSHOTGUN', ['@label'] = 'Sawnoff Shotgun', ['@blackmarket'] = 1})
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_weapons` (unique_id, name, label, blackmarket) VALUES (@unique_id, @name, @label, @blackmarket)',{['@unique_id'] = 'vehicle-'..plate, ['@name'] = 'WEAPON_VINTAGEPISTOL', ['@label'] = 'Vintage Pistol', ['@blackmarket'] = 1})
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_weapons` (unique_id, name, label, blackmarket) VALUES (@unique_id, @name, @label, @blackmarket)',{['@unique_id'] = 'vehicle-'..plate, ['@name'] = 'WEAPON_VINTAGEPISTOL', ['@label'] = 'Vintage Pistol', ['@blackmarket'] = 1})
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_weapons` (unique_id, name, label, blackmarket) VALUES (@unique_id, @name, @label, @blackmarket)',{['@unique_id'] = 'vehicle-'..plate, ['@name'] = 'WEAPON_VINTAGEPISTOL', ['@label'] = 'Vintage Pistol', ['@blackmarket'] = 1})
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_weapons` (unique_id, name, label, blackmarket) VALUES (@unique_id, @name, @label, @blackmarket)',{['@unique_id'] = 'vehicle-'..plate, ['@name'] = 'WEAPON_VINTAGEPISTOL', ['@label'] = 'Vintage Pistol', ['@blackmarket'] = 1})
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_inventorys` (item, name, qty, unique_id) VALUES (@item, @name, @qty, @unique_id)',{['@unique_id'] = 'vehicle-'..plate, ['@name'] = 'Lockpick Kit', ['@qty'] = 5, ['@item'] = 21})
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_inventorys` (item, name, qty, unique_id) VALUES (@item, @name, @qty, @unique_id)',{['@unique_id'] = 'vehicle-'..plate, ['@name'] = 'Lockpick', ['@qty'] = 65, ['@item'] = 7})
  end
  TriggerEvent('vehicle_inventory:refresh', source, plate)
 end)
end)