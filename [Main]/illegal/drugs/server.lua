RegisterServerEvent('drugs:startZone')
AddEventHandler('drugs:startZone', function()
 local source = tonumber(source)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  if user.getFaction() == 1 then
   if user.getBank() >= 36000 then 
    TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Flour is on route to the bakery"})
    TriggerEvent("core:log", tostring("[AIRDROP] "..user.getIdentity().fullname.."("..source..") has called in a plane for more drugs.."), "drug")
    TriggerClientEvent('drugs:delivery', source)
    user.removeBank(36000)
   else
    TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Factory is out of flour or you can't afford a new order"})
   end
  end
 end)
end)

RegisterServerEvent('drugs:addDrugs')
AddEventHandler('drugs:addDrugs', function(plate)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_inventorys` (unique_id, item, name, qty) VALUES (@unique_id,@itemid,@item,@qty) ON DUPLICATE KEY UPDATE qty=qty+ @qty',{['@unique_id'] = 'vehicle-'..plate,  ['@qty'] = 36, ['@item'] = 'Brick of Weed', ['@itemid'] = 108})
  TriggerEvent('vehicle_inventory:refresh', source, plate)
  TriggerEvent("core:log", tostring("[AIRDROP] "..user.getIdentity().fullname.."("..source..") called in a drug shipment."), "drug")
 end)
end)

RegisterServerEvent('coke:startZone')
AddEventHandler('coke:startZone', function()
 local source = tonumber(source)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  if user.getFaction() == 1 then
   if user.getBank() >= 500000 then 
    TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Flour is on route to the bakery"})
    TriggerEvent("core:log", tostring("[AIRDROP] "..user.getIdentity().fullname.."("..source..") has called in a plane full of bricks of cocaine."), "drug")
    TriggerClientEvent('coke:delivery', source)
    user.removeBank(500000)
   else
    TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "you haven't got enough cash to order any flour"})
   end
  end
 end)
end)

RegisterServerEvent('coke:addDrugs')
AddEventHandler('coke:addDrugs', function(plate)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  TriggerEvent('addReputation', 1000)
  exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_inventorys` (unique_id, item, name, qty) VALUES (@unique_id,@itemid,@item,@qty) ON DUPLICATE KEY UPDATE qty=qty+ @qty',{['@unique_id'] = 'vehicle-'..plate,  ['@qty'] = 10, ['@item'] = 'Brick of Cocaine', ['@itemid'] = 107})
  TriggerEvent('vehicle_inventory:refresh', source, plate)
  TriggerEvent("core:log", tostring("[DRUG CALL] "..user.getIdentity().fullname.."("..source..") called in a drug shipment."), "drug")
 end)
end)



--[[RegisterCommand('drugdrop', function(source, args, rawCommand)
 TriggerEvent('drugs:addDrugs', function(plate)              NNEEDS TESTING MORE XZURV
   local source = tonumber(source)
   TriggerEvent("core:getPlayerFromId", source, function(user)
    if user.getFaction() == 1 then
     if user.getBank() >= 1 then 
     TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Flour is on route to the bakery"})
        user.removeBank(1)    
     exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_inventorys` (unique_id, item, name, qty) VALUES (@unique_id,@itemid,@item,@qty) ON DUPLICATE KEY UPDATE qty=qty+ @qty',{['@unique_id'] = 'vehicle-'..plate,  ['@qty'] = 1, ['@item'] = 'Brick Of Cocaine', ['@itemid'] = 107})
     TriggerEvent('vehicle_inventory:refresh', source, plate)
     PerformHttpRequest("https://discordapp.com/api/webhooks/699702380358533161/HbdOJCbWn8DCR4qkHm61cFJFEXfgicBEatUibtjooBo45RTVMQO12gd65xkGhrq-npMh", function(Error, Content, Head) end, 'POST', json.encode({username = SystemName, content = "```[DRUG CALL] "..user.getIdentity().fullname.." has just called in a new Drug Shipment.```", avatar_url = SystemAvatar}), {['Content-Type'] = 'application/json'}) 
   end
  end) 
 end)      
end)]]--