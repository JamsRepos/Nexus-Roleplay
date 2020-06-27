local shared_accounts = {}

RegisterServerEvent('bank:intoSharedBank')
AddEventHandler('bank:intoSharedBank', function(amount, id)
  local source = tonumber(source)
  local id = tonumber(id)
  print(source..id..amount)
  shared_accounts[id].balance = shared_accounts[id].balance + amount
  TriggerEvent("core:moneylog", source, 'Auto Shared Banking [Account ID: '..id..'] Deposited: $'..amount.." | New Balance: "..shared_accounts[id].balance)
  TriggerClientEvent("currentbalsh", -1, shared_accounts[id].balance)
end)

RegisterServerEvent('shared_bank:deposit')
AddEventHandler('shared_bank:deposit', function(id, amount)
  local source = tonumber(source)
  TriggerEvent('core:getPlayerFromId', source, function(user)
   if amount > 0 and tonumber(amount) <= tonumber(user.getMoney()) then
    user.removeMoney(amount)
    shared_accounts[id].balance = shared_accounts[id].balance + amount
    TriggerClientEvent('shared_bank:result', source, "success", "Deposit Successful.")
    TriggerClientEvent("currentbalsh", source, shared_accounts[id].balance)
    TriggerEvent("core:moneylog", source, 'Shared Banking [Account ID: '..id..'] Deposited: $'..amount.." | New Balance: $"..user.getMoney().." - $"..user.getBank())
   else
    TriggerClientEvent('shared_bank:result', source, "error", "Invalid Amount.")
   end
  end)
end) 

RegisterServerEvent('shared_bank:withdraw')
AddEventHandler('shared_bank:withdraw', function(id, amount)
  local source = tonumber(source)
  TriggerEvent('core:getPlayerFromId', source, function(user)
   local balance = 0
   balance = shared_accounts[id].balance
   if(tonumber(amount) <= tonumber(balance)) then
    shared_accounts[id].balance = shared_accounts[id].balance - amount
    user.addMoney(amount)
    TriggerClientEvent("currentbalsh", source, shared_accounts[id].balance)
    TriggerEvent("core:moneylog", source, 'Shared Banking [Account ID: '..id..'] Withdrew: $'..amount.." | New Balance: $"..user.getMoney().." - $"..user.getBank())
    TriggerClientEvent('shared_bank:result', source, "success", "Withdraw Successful.")
   else
    TriggerClientEvent('shared_bank:result', source, "error", "Invalid Amount.")
   end
  end)
end)

AddEventHandler('onResourceStart', function(resource)
 if resource == GetCurrentResourceName() then
  shared_accounts = {}
  local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `shared_banking`")
  for _,v in pairs(result) do
   shared_accounts[v.id] = {id = v.id, account = v.account, name = v.name, balance = v.balance}
  end
 end
end)

RegisterServerEvent('core:characterloaded')
AddEventHandler('core:characterloaded', function()
 local source = tonumber(source)
 TriggerClientEvent('shared_bank:getaccounts', source, shared_accounts) 
end)

RegisterServerEvent('shared_bank:getbalance')
AddEventHandler('shared_bank:getbalance', function(id)
  local source = tonumber(source)
  TriggerClientEvent("currentbalsh", source, shared_accounts[id].balance)
end)

local function saveSharedBanks()
  SetTimeout(60000, function()
    Citizen.CreateThread(function()
      for k,v in pairs(shared_accounts)do
        exports['GHMattiMySQL']:QueryAsync("UPDATE `shared_banking` SET balance=@bank WHERE id = @id", {['@id'] = shared_accounts[k].id,['@bank'] = shared_accounts[k].balance})
      end
     saveSharedBanks()
    end)
  end)
end 
saveSharedBanks()