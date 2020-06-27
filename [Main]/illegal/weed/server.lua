--local location1 = false
local location2 = false
local xzurvcoco = false
local xzurvbreakingbad = false
local xzurvsmackheads = false

RegisterServerEvent('seed:check')
AddEventHandler('seed:check', function()
 TriggerEvent("core:getPlayerFromId", source, function(user)
 TriggerEvent("core:moneylog", source, "[SEEDS] seed has been picked")
 end)
end)

RegisterServerEvent('xzurv:purchasemeth')
AddEventHandler('xzurv:purchasemeth', function(amount)
 local source = tonumber(source)
if xzurvbreakingbad then
 TriggerClientEvent('chatMessage', source, "CRYSTAL METH", {27, 186, 0}, "The seller has ran out of stock. Check back another day for more!")
 TriggerClientEvent('xzurv:purchasemeth', -1)
else
 local price = 0
 if amount == 1 then
  price = 1300
 else
  price = 2200
 end
 TriggerEvent("core:getPlayerFromId", source, function(user)
  if user.getMoney() >= price then
    xzurvbreakingbad = true
   TriggerClientEvent('xzurv:purchasemeth', -1)
   user.removeMoney(price)
   TriggerClientEvent('chatMessage', source, "CRYSTAL METH", {27, 186, 0}, "You have purchased "..amount.."x Oz of Crystal Meth")
   TriggerClientEvent("inventory:addQty", source, 156, amount)
   TriggerEvent("core:moneylog", source, "[Meth] Meth has been purchased")
  end
end)
end
end)

RegisterServerEvent('xzurv:purchaseheroin')
AddEventHandler('xzurv:purchaseheroin', function(amount)
 local source = tonumber(source)
if xzurvsmackheads then
 TriggerClientEvent('chatMessage', source, "HEROIN", {27, 186, 0}, "The seller has ran out of stock. Check back another day for more!")
 TriggerClientEvent('xzurv:purchaseheroin', -1)
else
 local price = 0
 if amount == 1 then
  price = 1300
 else
  price = 2400
 end
 TriggerEvent("core:getPlayerFromId", source, function(user)
  if user.getMoney() >= price then
    xzurvsmackheads = true
   TriggerClientEvent('xzurv:purchaseheroin', -1)
   user.removeMoney(price)
   TriggerClientEvent('chatMessage', source, "HEROIN", {27, 186, 0}, "You have purchased "..amount.."x Oz of Heroin")
   TriggerClientEvent("inventory:addQty", source, 158, amount)
   TriggerEvent("core:moneylog", source, "[HEROIN] HEROIN has been purchased")
  end
end)
end
end)

RegisterServerEvent('xzurv:purchasecoke')
AddEventHandler('xzurv:purchasecoke', function(amount)
 local source = tonumber(source)
if xzurvcoco then
 TriggerClientEvent('chatMessage', source, "COCAINE", {27, 186, 0}, "The seller has ran out of stock. Check back another day for more!")
 TriggerClientEvent('xzurv:purchasecoke', -1)
else
 local price = 0
 if amount == 1 then
  price = 1400
 else
  price = 2700
 end
 TriggerEvent("core:getPlayerFromId", source, function(user)
  if user.getMoney() >= price then
    xzurvcoco = true
   TriggerClientEvent('xzurv:purchasecoke', -1)
   user.removeMoney(price)
   TriggerClientEvent('chatMessage', source, "COCAINE", {27, 186, 0}, "You have purchased "..amount.."x Oz of Cocaine")
   TriggerClientEvent("inventory:addQty", source, 109, amount)
   TriggerEvent("core:moneylog", source, "[COCAINE] COCAINE has been purchased")
  end
end)
end
end)


RegisterServerEvent('weed:purchaseseeds1')
AddEventHandler('weed:purchaseseeds1', function(amount)
 local source = tonumber(source)
if location1 then
 TriggerClientEvent('chatMessage', source, "WEED", {27, 186, 0}, "The seller has ran out of stock. Check back another day for more!")
 TriggerClientEvent('weed:seedspurchased1', -1)
else
 local price = 0
 if amount == 1 then
  price = 250
 else
  price = 350
 end
 TriggerEvent("core:getPlayerFromId", source, function(user)
  if user.getMoney() >= price then
   location1 = true
   TriggerClientEvent('weed:seedspurchased1', -1)
   user.removeMoney(price)
   TriggerClientEvent('chatMessage', source, "WEED", {27, 186, 0}, "You have purchased "..amount.."x Weed Seed")
   TriggerClientEvent("inventory:addQty", source, 118, amount)
  end
end)
end
end)

--[[RegisterServerEvent('weed:purchaseseeds2')
AddEventHandler('weed:purchaseseeds2', function(amount)
 local source = tonumber(source)
if location2 then
 TriggerClientEvent('chatMessage', source, "WEED", {27, 186, 0}, "The seller has ran out of stock. Check back another day for more!")
 TriggerClientEvent('weed:seedspurchased2', -1)
else
 local price = 0
 if amount == 1 then
  price = 250
 else
  price = 350
 end
 TriggerEvent("core:getPlayerFromId", source, function(user)
  if user.getMoney() >= price then
   location2 = true
   TriggerClientEvent('weed:seedspurchased2', -1)
   user.removeMoney(price)
   TriggerClientEvent('chatMessage', source, "WEED", {27, 186, 0}, "You have purchased "..amount.."x Weed Seed")
   TriggerClientEvent("inventory:addQty", source, 118, amount)
  end
end)
end
end)
]]--
