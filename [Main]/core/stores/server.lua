local ownedWeapons = {}

RegisterServerEvent("weapon:purchase")
AddEventHandler("weapon:purchase",function(name, label, price, owned, id, wid)
 local source = tonumber(source)
 local price = tonumber(price)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  if (tonumber(user.getMoney()) >= tonumber(price)) then
   user.addWeapon(name, label)
   user.removeMoney(price)
   TriggerEvent("core:moneylog", source, 'Weapon Payment: $'..price.." Weapon: "..label)
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Weapon Purchased"})
   if owned then 
    ownedWeapons[id].weapons[wid].q = ownedWeapons[id].weapons[wid].q-1
    ownedWeapons[id].bank = ownedWeapons[id].bank + price 
    TriggerEvent('weaponstores:refresh')
   end
  else
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Insufficient Funds"}) 
  end
 end)
end)

RegisterServerEvent("weapon:refresh")
AddEventHandler("weapon:refresh",function(source)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  TriggerClientEvent('weapon:updateitems', source, user.getWeapons())
 end)
end)

RegisterServerEvent('weapon:give')
AddEventHandler('weapon:give', function(model, name, id, target)
 local source = tonumber(source)
 local target = tonumber(target)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  TriggerEvent('core:getPlayerFromId', target, function(t)
   user.removeWeapon(id, model)
   t.addWeapon(model, name)
  end)
 end) 
end)

RegisterServerEvent('bmshops:purchase')
AddEventHandler('bmshops:purchase', function(label, price, qty, item)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  if user.getDirtyMoney() >= price then
   if item ~= 911 then
    local canGet = user.isAbleToReceive(qty)
    if canGet then
     user.addQuantity(item,qty)
     user.removeDirtyMoney(price)
     TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Purchased "..qty.."x "..label, timeout=1000})
     TriggerEvent("core:moneylog", source, 'Shop Payment: $'..price)
    else
     TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text =  'Inventory Full'})
    end
   end
  else
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Insufficient Funds"}) 
  end
 end)
end)


RegisterServerEvent('takewayshops:purchase')
AddEventHandler('takewayshops:purchase', function(label, price, qty, item)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  if user.getMoney() >= price then
   if item ~= 911 then
    local canGet = user.isAbleToReceive(qty)
    if canGet then
     user.addQuantity(item,qty)
     user.removeMoney(price)
     TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Purchased "..qty.."x "..label, timeout=1000})
     TriggerEvent("core:moneylog", source, 'Shop Payment: $'..price)
    else
     TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text =  'Inventory Full'})
    end
   end
  else
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Insufficient Funds"}) 
  end
 end)
end)

RegisterServerEvent('shops:purchase')
AddEventHandler('shops:purchase', function(label, price, qty, item)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  if user.getMoney() >= price then
   if item ~= 911 then
    local canGet = user.isAbleToReceive(qty)
    if canGet then
     user.addQuantity(item,qty)
     user.removeMoney(price)
     TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Purchased "..qty.."x "..label, timeout=1000})
     TriggerEvent("core:moneylog", source, 'Shop Payment: $'..price)
    else
     TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text =  'Inventory Full'})
    end
   end
  elseif user.getBank() >= price then
   if item ~= 911 then
    local canGet = user.isAbleToReceive(qty)
    if canGet then
     user.addQuantity(item,qty)
     user.removeBank(price)
     TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Purchased "..qty.."x "..label, timeout=1000})
     TriggerEvent("core:moneylog", source, 'Shop Payment: $'..price)
    else
     TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text =  'Inventory Full'})
    end
   end
  else
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Insufficient Funds"}) 
  end
 end)
end)

AddEventHandler('onResourceStart', function(resource)
 if resource == GetCurrentResourceName() then
  local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `owned_gunstores`")    
  for i,v in pairs(result) do
   ownedWeapons[v.id] = {id = v.id, owner = v.owner, bank = v.bank, weapons = json.decode(v.weapons), price = v.price, bought = v.bought}
  end
 end
end)

RegisterServerEvent('weaponstores:updateStations')
AddEventHandler('weaponstores:updateStations', function()
 ownedWeapons = {}
 local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `owned_gunstores`")   
 for i,v in pairs(result) do
  ownedWeapons[v.id] = {id = v.id, owner = v.owner, bank = v.bank, weapons = json.decode(v.weapons), price = v.price, bought = v.bought}
 end
 TriggerEvent("core:getPlayers", function(users)
  for _,v in pairs(users) do
   TriggerClientEvent('weaponstores:updateStations', v.getSource(), ownedWeapons, v.getCharacterID())
  end
 end)
end)

RegisterServerEvent('weaponstores:refresh')
AddEventHandler('weaponstores:refresh', function()
 TriggerEvent("core:getPlayers", function(users)
  for _,v in pairs(users) do
   TriggerClientEvent('weaponstores:updateStations', v.getSource(), ownedWeapons, v.getCharacterID())
  end
 end)
end)

RegisterServerEvent('weaponstores:load')
AddEventHandler('weaponstores:load', function(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  TriggerClientEvent('weaponstores:updateStations', source, ownedWeapons, user.getCharacterID())
 end)
end)

RegisterServerEvent('weaponstore:takeBank')
AddEventHandler('weaponstore:takeBank', function(bank, id)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  ownedWeapons[id].bank = 0
  exports['GHMattiMySQL']:QueryAsync('UPDATE `owned_gunstores` SET bank=@fuel WHERE `id`=@id',{['@fuel'] = 0, ['@id'] = id})
  TriggerClientEvent('NRP-notify:client:SendAlert', tonumber(source), { type = 'inform', text = "Store Bank Deposited Into Your Account",timeout = 2500,layout = "centerRight"})
  user.addBank(bank)
  TriggerEvent('weaponstores:updateStations')
 end)
end)


RegisterServerEvent('weaponstore:purchase')
AddEventHandler('weaponstore:purchase', function(id, price)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  if (tonumber(user.getMoney()) >= tonumber(price)) then
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `owned_gunstores` (id, weapons, price, owner) VALUES (@id, @weapons, @price, @owner)',{['@id'] = id, ['@weapons'] = json.encode({}), ['@price'] = price, ['@owner'] = user.getCharacterID()})
   user.removeMoney(price)
   TriggerClientEvent('NRP-notify:client:SendAlert', tonumber(source), { type = 'inform', text = "You have purchased this weapon store", timeout = 2500,layout = "centerRight"})
   TriggerEvent('weaponstores:updateStations')
  else
   TriggerClientEvent('NRP-notify:client:SendAlert', tonumber(source), { type = 'inform', text = "Insufficient funds",timeout = 2500,layout = "centerRight"})
  end
 end)
end)

RegisterServerEvent('weaponstore:add')
AddEventHandler('weaponstore:add', function(id, label, weapon, qty, sellprice, owned, bought, bulkPrice)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  if owned then
   table.insert(ownedWeapons[id].weapons, {label = label, name = weapon, price = sellprice, q = qty})
   if owned then user.removeWeapon(weapon, bought) end
   TriggerClientEvent('NRP-notify:client:SendAlert', tonumber(source), { type = 'inform', text = "You have added weapons", timeout = 2500,layout = "centerRight"})
   TriggerEvent('weaponstores:refresh')
  else
   if user.getMoney() > tonumber(bulkPrice) then 
    table.insert(ownedWeapons[id].weapons, {label = label, name = weapon, price = sellprice, q = qty})
    user.removeMoney(tonumber(bulkPrice))
    TriggerClientEvent('NRP-notify:client:SendAlert', tonumber(source), { type = 'inform', text = "You have added weapons", timeout = 2500,layout = "centerRight"})
    TriggerEvent('weaponstores:refresh')
   end
  end
 end)
end)  

RegisterServerEvent('weaponstore:modify')
AddEventHandler('weaponstore:modify', function(id, wid, price)
 local source = tonumber(source)
 ownedWeapons[id].weapons[wid].price = price
 TriggerClientEvent('NRP-notify:client:SendAlert', tonumber(source), { type = 'inform', text = "weapon price updated", timeout = 2500,layout = "centerRight"})
 TriggerEvent('weaponstores:refresh')
end)  

-- Saving Weapon Store Data
local function saveWeaponStores()
  SetTimeout(140000, function()
    Citizen.CreateThread(function()
      for k,v in pairs(ownedWeapons)do
        if ownedWeapons[k] ~= nil then
         exports['GHMattiMySQL']:QueryAsync("UPDATE `owned_gunstores` SET bank=@bank, weapons=@weapons WHERE id = @id", {
          ['@id'] = ownedWeapons[k].id,
          ['@bank'] = ownedWeapons[k].bank,
          ['@weapons'] = json.encode(ownedWeapons[k].weapons),
         })
        end
      end
      saveWeaponStores()
    end)
  end)
end 
saveWeaponStores()