TriggerEvent('core:addGroupCommand', 'sendInv', "user", function(source, args, user)
 local targetSource = tonumber(args[2])
 local amount = tonumber(args[3])
 TriggerEvent("core:getPlayerFromId", source, function(user)
  TriggerEvent("core:getPlayerFromId", targetSource, function(target)
   TriggerClientEvent('chatMessage', source, '^5Invoice Of ^2$'..amount..'^5 Has Been Sent To ^2'..target.getIdentity().fullname)
   TriggerClientEvent('chatMessage', targetSource, '^5New Invoice `')
   table.remove(args, 1)
   table.remove(args, 1)
   table.remove(args, 1)
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `unpayed_invoices` (char_id, sender, sender_id, amount, reason) VALUES (@char_id, @sender, @sender_id, @amount, @reason)',{['@char_id'] = target.getCharacterID(), ['@sender'] = user.getIdentity().fullname, ['@sender_id'] = user.getCharacterID(), ['@amount'] = amount, ['@reason'] = table.concat(args, " ")})
  end) 
 end)
end)

TriggerEvent('core:addGroupCommand', 'myInv', "user", function(source, args, user)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  local myInvoices = ''
  local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `unpayed_invoices` WHERE char_id=@char_id", {['@char_id'] = user.getCharacterID()})	
  for id,v in pairs(result) do 
   myInvoices = '<font color="lightgreen">'..v.id..'</font> - <font color="lightblue">'..v.sender..'</font> - <font color="lightgreen">$'..v.amount..'</font> - <font color="lightblue">'..v.reason..',</font><br/>'..myInvoices
  end
  TriggerClientEvent("pNotify:SendNotification", source, {text= myInvoices})
 end)
end)

TriggerEvent('core:addGroupCommand', 'payInv', "user", function(source, args, user)
 local id = tonumber(args[2])
 local invoicePayed = false
 TriggerEvent("core:getPlayerFromId", source, function(user)
  local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `unpayed_invoices` WHERE char_id=@char_id AND id=@id", {['@char_id'] = user.getCharacterID(), ['@id'] = id})	
  if result[1].id == id then 

   -- Player Online
   TriggerEvent("core:getPlayers", function(users)
    for _,v in pairs(users) do
     if result[1].sender_id == v.getCharacterID() then 
      v.addBank(result[1].amount)
      user.removeBank(result[1].amount)
	  TriggerClientEvent('chatMessage', v.getSource(), '^5Invoice Payed By ^2'..user.getIdentity().fullname)
	  TriggerClientEvent('chatMessage', source, '^2Invoice Payed')
	  exports['GHMattiMySQL']:QueryAsync('DELETE FROM `unpayed_invoices` WHERE `id`=@id',{['@id'] = id})
	  invoicePayed = true
     end
    end
   end)

   -- Player Offline
   if not invoicePayed then 
	exports['GHMattiMySQL']:QueryAsync("UPDATE `characters` SET `bank` = bank+@amount WHERE id = @id", {['@id'] = user.getCharacterID(), ['@amount'] = result[1].amount})
	TriggerClientEvent('chatMessage', source, '^2Invoice Payed')
	exports['GHMattiMySQL']:QueryAsync('DELETE FROM `unpayed_invoices` WHERE `id`=@id',{['@id'] = id})
	invoicePayed = true
   end
  end
 end)
end)

TriggerEvent('core:addGroupCommand', 'rejectInvoice', "user", function(source, args, user)
 local id = tonumber(args[2])
 local invoicePayed = false
 TriggerEvent("core:getPlayerFromId", source, function(user)
  local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `unpayed_invoices` WHERE char_id=@char_id AND id=@id", {['@char_id'] = user.getCharacterID(), ['@id'] = id})	
  if result[1].id == id then 

   -- Player Online
   TriggerEvent("core:getPlayers", function(users)
    for _,v in pairs(users) do
     if result[1].sender_id == v.getCharacterID() then 
	  TriggerClientEvent('chatMessage', v.getSource(), '^5Invoice Rejected By ^2'..user.getIdentity().fullname)
	  TriggerClientEvent('chatMessage', source, '^2Invoice Rejected')
	  exports['GHMattiMySQL']:QueryAsync('DELETE FROM `unpayed_invoices` WHERE `id`=@id',{['@id'] = id})
	  invoicePayed = true
     end
    end
   end)

   -- Player Offline
   if not invoicePayed then 
	TriggerClientEvent('chatMessage', source, '^2Invoice Rejected')
	exports['GHMattiMySQL']:QueryAsync('DELETE FROM `unpayed_invoices` WHERE `id`=@id',{['@id'] = id})
	invoicePayed = true
   end
  end
 end)
end)

--[[TriggerEvent('core:addGroupCommand', 'payTow', "user", function(source, args, user)
 local targetSource = tonumber(args[2])
 local randomCash = math.random(1750,15000)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  TriggerEvent("core:getPlayerFromId", targetSource, function(target)
   target.addMoney(randomCash)
   TriggerClientEvent('chatMessage', targetSource, '^2Payment Of $'..randomCash..' Received From '..user.getIdentity().fullname)
  end)
 end)
end)]]
