local droppedShells = {}

RegisterServerEvent("weapons:dropShell")
AddEventHandler("weapons:dropShell",function(weapon, pos)
 if weapon.noserial == 1 then
  weapon.serial = 'Scratched Off'
 end 
 table.insert(droppedShells, {pos = pos, serial = weapon.serial, name = weapon.name})
 TriggerClientEvent('weapons:updateShells', -1, droppedShells)
end)

RegisterServerEvent("weapons:removeShell")
AddEventHandler("weapons:removeShell",function(id)
 table.remove(droppedShells, id)
 TriggerClientEvent('weapons:updateShells', -1, droppedShells)
end)

RegisterServerEvent("weapons:collectShell")
AddEventHandler("weapons:collectShell",function(id)
 if droppedShells[id] ~= nil then 
  TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Bullet Fired From A "..droppedShells[id].name.." With Serial Number: "..droppedShells[id].serial})
  table.remove(droppedShells, id)
  TriggerClientEvent('weapons:updateShells', -1, droppedShells)
 end
end)

RegisterServerEvent("blackmarket:purchase")
AddEventHandler("blackmarket:purchase",function(name, label, price)
 local source = tonumber(source)
 local price = tonumber(price)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  if (tonumber(user.getDirtyMoney()) >= tonumber(price)) then
   user.addBlackMarketWeapon(name, label)
   user.removeDirtyMoney(price)
   TriggerEvent("core:moneylog", source, 'Weapon Payment: $'..price.." Weapon: "..label)
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Weapon Purchased"})
  else
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Not Enough Dirty Money On You"}) 
  end
 end)
end)

--[[RegisterServerEvent("foodmarket:purchase")
AddEventHandler("foodmarket:purchase",function(name, label, price)
 local source = tonumber(source)
 local price = tonumber(price)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  if (tonumber(user.getMoney()) >= tonumber(price)) then
   user.addBlackMarketWeapon(name, label)
   user.removeMoney(price)
   TriggerEvent("core:moneylog", source, 'Weapon Payment: $'..price.." Weapon: "..label)
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Item Purchased"})
  else
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Not Enough Money On You"}) 
  end
 end)
end)]]

RegisterServerEvent("foodmarket:purchase")
AddEventHandler("foodmarket:purchase",function(name, label, price)
 local source = tonumber(source)
 local price = tonumber(price)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  if (tonumber(user.getMoney()) >= tonumber(price)) then
   user.addBlackMarketWeapon(name, label)
   user.removeMoney(price)
   TriggerEvent("core:moneylog", source, 'Weapon Payment: $'..price.." Weapon: "..label)
   TriggerClientEvent("pNotify:SendNotification", source, {text= "Weapon Purchased"})
  else
   TriggerClientEvent("pNotify:SendNotification", source, {text= "Insufficient Funds"}) 
  end
 end)
end)