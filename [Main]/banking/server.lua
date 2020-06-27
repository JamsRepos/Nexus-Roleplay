RegisterServerEvent('bank:deposit')
AddEventHandler('bank:deposit', function(amount)
  local source = tonumber(source)
  TriggerEvent('core:getPlayerFromId', source, function(user)
   if amount > 0 and tonumber(amount) <= tonumber(user.getMoney()) then
    user.removeMoney(amount)
    user.addBank(amount)
    TriggerClientEvent('bank:result', source, "success", "Deposit Successful.")
    TriggerClientEvent("banking:updateBalance", source, user.getBank(), user.getIdentity().fullname)
    TriggerEvent("core:moneylog", source, 'Deposited: $'..amount)
   else
    TriggerClientEvent('bank:result', source, "error", "Invalid Amount.")
   end
  end)
end)

RegisterServerEvent('bank:removeMoney')
AddEventHandler('bank:removeMoney', function(amount)
  local source = tonumber(source)
  TriggerEvent('core:getPlayerFromId', source, function(user)
    user.removeBank(amount)
    TriggerEvent("core:moneylog", source, ' Just used Mechanic fill and spent: $'..amount)
  end)
end)

RegisterServerEvent('bank:withdraw')
AddEventHandler('bank:withdraw', function(amount)
  local source = tonumber(source)
  TriggerEvent('core:getPlayerFromId', source, function(user)
   local balance = 0
   balance = user.getBank()
   if(tonumber(amount) <= tonumber(balance)) then
    user.removeBank(amount)
    user.addMoney(amount)
	  TriggerClientEvent("banking:updateBalance", source, user.getBank(), user.getIdentity().fullname)
    TriggerEvent("core:moneylog", source, 'Character:'..user.getIdentity().fullname..' Withdrew: $'..amount)
    TriggerClientEvent('bank:result', source, "success", "Withdraw Successful.")
   else
    TriggerClientEvent('bank:result', source, "error", "Invalid Amount.")
   end
  end)
end)

RegisterServerEvent('bank:balance')
AddEventHandler('bank:balance', function()
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
 TriggerClientEvent("banking:updateBalance", source, user.getBank(), user.getIdentity())
 --TriggerEvent("core:moneylog", source, 'bank balance: $'..user.getBank()'Name'..user.getIdentity())
 end)
end)

RegisterServerEvent('bank:transfer')
AddEventHandler('bank:transfer', function(toPlayer, amount)
 if amount > 0 then
 local source = tonumber(source)
 local toPlayer = tonumber(toPlayer)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  TriggerEvent('core:getPlayerFromId', toPlayer, function(user2)
   local balance = 0
   balance = user.getBank()
   if balance <= 0 or balance < tonumber(amount) then
    TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Invalid Amount"})
   else
    user.removeBank(amount)
    user2.addBank(amount)
    TriggerEvent("core:moneylog", source, 'Transfered: $'..amount.." > "..user2.getIdentity().fullname)
    
    TriggerClientEvent('NRP-notify:client:SendAlert', toPlayer, { type = 'success', text = '$'.. amount ..'Has Been Successfully Deposited Into Your Bank Account By'..user.getIdentity().fullname})
    TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = '$'.. amount ..'Has Been Successfully Transfered Into '..user2.getIdentity().fullname..'s Bank Account'})
  end
   TriggerClientEvent("banking:updateBalance", toPlayer, user2.getBank(), user2.getIdentity())
   TriggerClientEvent("banking:updateBalance", source, user.getBank(), user.getIdentity())
  end)
 end)
 end
end)

RegisterServerEvent('bank:giveDirtyMoney')
AddEventHandler('bank:giveDirtyMoney', function(task, amount)
  local source = tonumber(source)
  TriggerEvent('core:getPlayerFromId', source, function(user)
   user.addDirtyMoney(amount)
   TriggerEvent("core:moneylog", source, 'Transfered: $'..amount.." > "..user2.getIdentity().fullname)
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = '$'.. amount ..'Has Been Given To '..user2.getIdentity().fullname})
  end)
end)

RegisterServerEvent('illegal:washmoney')
AddEventHandler('illegal:washmoney', function(amount)
  local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  local blackMoney = tonumber(amount)
  local washedMoney = math.floor(blackMoney*0.85)
  if blackMoney > 0 and user.getDirtyMoney() >= blackMoney then
   user.removeDirtyMoney(blackMoney)
   user.addMoney(washedMoney)
   TriggerEvent("core:moneylog", source, 'Dirty Money IN: $'..blackMoney)
   TriggerEvent("core:moneylog", source, 'Washed Money OUT: $'..washedMoney)
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = 'Pleasure doing business with you. I took 15%, Your Cut: $'.. washedMoney})
  else
    TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = 'You do not have enough dirty money.'})
  end
 end)
end)

RegisterServerEvent('illegal:washmoney2')
AddEventHandler('illegal:washmoney2', function(amount)
  local source = tonumber(source) 
 TriggerEvent('core:getPlayerFromId', source, function(user)
  local blackMoney = tonumber(amount)
  local washedMoney = math.floor(blackMoney*0.90)
  if blackMoney > 0 and user.getDirtyMoney() >= blackMoney then
   user.removeDirtyMoney(blackMoney)
   user.addMoney(washedMoney)
   TriggerEvent("core:moneylog", source, 'Dirty Money IN: $'..blackMoney)
   TriggerEvent("core:moneylog", source, 'Washed Money OUT: $'..washedMoney)
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = 'Pleasure doing business with you. I took 10%, Your Cut: $'.. washedMoney})
  else
    TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = 'You do not have enough dirty money.'})
  end
 end)
end)

RegisterServerEvent('illegal:washmoney3')
AddEventHandler('illegal:washmoney3', function(amount)
  local source = tonumber(source) 
 TriggerEvent('core:getPlayerFromId', source, function(user)
  local blackMoney = tonumber(amount)
  local washedMoney = math.floor(blackMoney*0.95)
  if blackMoney > 0 and user.getDirtyMoney() >= blackMoney then
   user.removeDirtyMoney(blackMoney)
   user.addMoney(washedMoney)
   TriggerEvent("core:moneylog", source, 'Dirty Money IN: $'..blackMoney)
   TriggerEvent("core:moneylog", source, 'Washed Money OUT: $'..washedMoney)
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = 'Pleasure doing business with you. I took 5%, Your Cut: $'.. washedMoney})
  else
  TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = 'You do not have enough dirty money.'})
  end
 end)
end)

RegisterServerEvent('illegal:washmoney4')
AddEventHandler('illegal:washmoney4', function(amount)
  local source = tonumber(source) 
 TriggerEvent('core:getPlayerFromId', source, function(user)
  local blackMoney = tonumber(amount)
  local washedMoney = math.floor(blackMoney*0.99)
  if blackMoney > 0 and user.getDirtyMoney() >= blackMoney then
   user.removeDirtyMoney(blackMoney)
   user.addMoney(washedMoney)
   TriggerEvent("core:moneylog", source, 'Dirty Money IN: $'..blackMoney)
   TriggerEvent("core:moneylog", source, 'Washed Money OUT: $'..washedMoney)
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = 'Pleasure doing business with you. I took 1% For My Troubles, Your Cut: $'.. washedMoney})
  else
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = 'You do not have enough dirty money.'})
  end
 end)
end)

RegisterServerEvent('drug:addmoney')
AddEventHandler('drug:addmoney', function(pay)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  if pay < 1500 then
    user.addDirtyMoney(pay)
  else
    TriggerEvent('anticheat:message', source, pay)
  end
  TriggerEvent("core:moneylog", source, '[DIRTY] Drug Payment: $'..pay)
  --TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = 'Drug Payment: $'..pay})
 end)
end)