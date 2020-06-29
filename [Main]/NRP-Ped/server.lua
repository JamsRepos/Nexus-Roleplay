RegisterServerEvent('civ:skydive')
AddEventHandler('civ:skydive', function(price, pos)
 local sourcePlayer = tonumber(source)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  if user.getMoney() >= price then
   user.removeMoney(price)
   TriggerClientEvent('civ:skydrive', source, pos)
  else
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Not Enough Money"})
  end
 end)
end)

RegisterServerEvent('cinema:pay')
AddEventHandler('cinema:pay', function(price)
 local sourcePlayer = tonumber(source)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  if user.getMoney() >= price then
   user.removeMoney(price)
   TriggerClientEvent('cinema:cinemaPayed', sourcePlayer)
  else
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Not Enough Money"})
  end
 end)
end)

--[[RegisterServerEvent('civ:gokart')
AddEventHandler('civ:gokart', function()
 local sourcePlayer = tonumber(source)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  if user.getMoney() >= 500 then
   user.removeMoney(500)
   TriggerClientEvent('civ:gokart', sourcePlayer)
  else
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Not Enough Money"})
  end
 end)
end)]]--

RegisterServerEvent('rental:bike')
AddEventHandler('rental:bike', function(price, model)
  local sourcePlayer = tonumber(source)
  TriggerEvent('core:getPlayerFromId', source, function(user)
  if user.getMoney() >= price then
    user.removeMoney(price)
    local bike = model
    TriggerClientEvent('rental:spawnbike', tonumber(sourcePlayer), bike)
    TriggerClientEvent('NRP-notify:client:SendAlert', tonumber(sourcePlayer), { type = 'inform', text = "I Will Come Collect The Bike At Sun Down"})
  else
    TriggerClientEvent('NRP-notify:client:SendAlert', tonumber(sourcePlayer), { type = 'inform', text = "You Don't Have Enough Money"})
  end
  end)                
end)

RegisterServerEvent('rental:boat')
AddEventHandler('rental:boat', function(price, model)
  local sourcePlayer = tonumber(source)
  TriggerEvent('core:getPlayerFromId', source, function(user)
  if user.getMoney() >= price then
    user.removeMoney(price)
    TriggerClientEvent('rental:spawnboat', tonumber(sourcePlayer), model)
    TriggerClientEvent('NRP-notify:client:SendAlert', tonumber(sourcePlayer), { type = 'inform', text = "I Will Come Collect The Boat At Sun Down"})
  else
    TriggerClientEvent('NRP-notify:client:SendAlert', tonumber(sourcePlayer), { type = 'inform', text = "You Don't Have Enough Money"})
  end
  end)                
end)

RegisterServerEvent('rental:return')
AddEventHandler('rental:return', function()
  local sourcePlayer = tonumber(source)
  TriggerEvent('core:getPlayerFromId', source, function(user)
  user.addMoney(5)
  TriggerClientEvent('NRP-notify:client:SendAlert', tonumber(sourcePlayer), { type = 'inform', text = "Thanks For Returning The Bike Take <font color'lightgreen'>$5 Back"})
  end)                
end)

RegisterNetEvent('power:tackle')
AddEventHandler('power:tackle', function(target)
  TriggerClientEvent('power:toggletackle', target)
end)

RegisterServerEvent('tackle:tryTackle')
AddEventHandler('tackle:tryTackle', function(target)
	TriggerClientEvent('tackle:getTackled', target, source)
	TriggerClientEvent('tackle:playTackle', source)
end)

RegisterServerEvent('trash:additems')
AddEventHandler('trash:additems', function(item, qty)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  canGive = user.isAbleToGive(item,qty)
  if canGive then
   user.removeQuantity(item,qty)
  end
 end)
end)

RegisterServerEvent('train:removemoney')
AddEventHandler('train:removemoney', function(pay)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  if pay < 200000 then
   user.removeMoney(pay)
   TriggerEvent("core:moneylog", source, '[Train] Money Charged: $'..pay)
  else
   TriggerEvent('anticheat:message', source, pay)
  end
 end)
end)

local ownedWeapons = {}
RegisterServerEvent('petrol:removemoney')
AddEventHandler('petrol:removemoney', function(name, owned,price, id, wid)
  local sourcePlayer = tonumber(source)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  if user.getMoney() >= 200 then
   user.removeMoney(200)
   TriggerClientEvent('petrol:removemoney', sourcePlayer)
   user.addWeapon(name , 'Jerry Can')
   --TriggerClientEvent("pNotify:SendNotification", sourcePlayer, {text = "Gas Can Bought"})
   --TriggerEvent("core:moneylog", source, "Weapon Payment:$200 | Weapon: Jerry Can | Purchased at a Gas station")
    if owned then 
     ownedWeapons[id].weapons[wid].q = ownedWeapons[id].weapons[wid].q-1
     ownedWeapons[id].bank = ownedWeapons[id].bank + price
  end
  else
    TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = "Not Enough Money"})
  end
 end)
end)

RegisterServerEvent('carwash:removemoney')
AddEventHandler('carwash:removemoney', function(name, pay)
 local sourcePlayer = tonumber(source)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  if user.getMoney() >= 50 then
   user.removeMoney(50)
   TriggerClientEvent('carwash:washing', sourcePlayer)
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "$50 Paid To CarWashers.LS"})
   TriggerEvent("core:moneylog", source, "Detailed Their Vehicle For $50")
  else
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Not Enough Money"})
  end
 end)
end)