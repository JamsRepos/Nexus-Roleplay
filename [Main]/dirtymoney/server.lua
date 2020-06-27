RegisterServerEvent('bank:deposit2')
AddEventHandler('bank:deposit2', function(amount)
  local source = tonumber(source)
  TriggerEvent('core:getPlayerFromId', source, function(user)
   if amount > 0 and tonumber(amount) <= tonumber(user.getDirtyMoney()) then
    user.removeDirtyMoney(amount)
    user.addDirtybank(amount)
    TriggerClientEvent('bank:result2', source, "success", "Deposit Successful.")
    TriggerClientEvent("banking:updateBalance2", source, user.getDirtybank(), user.getIdentity().fullname)
    TriggerEvent("core:moneylog", source, 'Stashed: Dirty $'..amount)
   else
    TriggerClientEvent('bank:result2', source, "error", "Invalid Amount.")
   end
  end)
end)

RegisterServerEvent('bank:withdraw2')
AddEventHandler('bank:withdraw2', function(amount)
  local source = tonumber(source)
  TriggerEvent('core:getPlayerFromId', source, function(user)
   local balance = 0
   balance = user.getDirtybank()
   if(tonumber(amount) <= tonumber(balance)) then
    user.removeDirtybank(amount)
    user.addDirtyMoney(amount)
	  TriggerClientEvent("banking:updateBalance2", source, user.getDirtybank(), user.getIdentity().fullname)
    TriggerEvent("core:moneylog", source, 'Withdrew: Dirty $'..amount)
    TriggerClientEvent('bank:result2', source, "success", "Withdraw Successful.")
   else
    TriggerClientEvent('bank:result2', source, "error", "Invalid Amount.")
   end
  end)
end)

RegisterServerEvent('bank:balance2')
AddEventHandler('bank:balance2', function()
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
 TriggerClientEvent("banking:updateBalance2", source, user.getDirtybank(), user.getIdentity())
 --TriggerEvent("core:moneylog", source, 'bank balance: $'..user.getBank()'Name'..user.getIdentity())
 end)
end)
