--[[RegisterServerEvent("blackmarket:addWeapon")
AddEventHandler("blackmarket:addWeapon",function(name, label)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
   user.addBlackMarketWeapon(name, label)
   TriggerEvent('chatMessage', source, "POLICE", {66, 134, 244}, "This weapon is illegal! You must purchase a weapon at the Gun Stores for it to be registered as legal. This gun IS NOT traceable.")
 end)
end)]]--


RegisterServerEvent('NRP-B-Cashstacks-10k')
AddEventHandler('NRP-B-Cashstacks-10k', function()
 local source = tonumber(source)
  TriggerEvent('core:getPlayerFromId', source, function(user)
  user.addMoney(10000)
  TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = 'You have unstacked your cash!'})
  end)
end)

RegisterServerEvent("NRP-M-Cashstacks-10k")
AddEventHandler("NRP-M-Cashstacks-10k", function()
    local source = tonumber(source)
    TriggerEvent("core:getPlayerFromId", source, function(user)
        if user.getMoney() >= 10000 then
         user.removeMoney(10000)
         TriggerClientEvent("inventory:removeQty",source, 155, 3)
         TriggerClientEvent("inventory:addQty",source, 152, 1)
         TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = 'You have stacked your cash!'})
        else
         TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = 'You need more cash'})
        end
    end)
end)

RegisterServerEvent('NRP-B-Cashstacks-5k')
AddEventHandler('NRP-B-Cashstacks-5k', function()
 local source = tonumber(source)
  TriggerEvent('core:getPlayerFromId', source, function(user)
  user.addMoney(5000)
  TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = 'You have unstacked your cash!'})
  end)
end)

RegisterServerEvent("NRP-M-Cashstacks-5k")
AddEventHandler("NRP-M-Cashstacks-5k", function()
    local source = tonumber(source)
    TriggerEvent("core:getPlayerFromId", source, function(user)
        if user.getMoney() >= 5000 then
         user.removeMoney(5000)
         TriggerClientEvent("inventory:removeQty",source, 155, 2)
         TriggerClientEvent("inventory:addQty",source, 153, 1)
         TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = 'You have stacked your cash!'})
        else
         TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = 'You need more cash'})
        end
    end)
end)

RegisterServerEvent('NRP-B-Cashstacks-1k')
AddEventHandler('NRP-B-Cashstacks-1k', function()
 local source = tonumber(source)
  TriggerEvent('core:getPlayerFromId', source, function(user)
  user.addMoney(1000)
  TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = 'You have unstacked your cash!'})
  end)
end)

RegisterServerEvent("NRP-M-Cashstacks-1k")
AddEventHandler("NRP-M-Cashstacks-1k", function()
    local source = tonumber(source)
    TriggerEvent("core:getPlayerFromId", source, function(user)
        if user.getMoney() >= 1000 then
         user.removeMoney(1000)
         TriggerClientEvent("inventory:removeQty",source, 155, 1)
         TriggerClientEvent("inventory:addQty",source, 154, 1)
         TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = 'You have stacked your cash!'})
        else
         TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = 'You need more cash'})
        end
    end)
end)

RegisterServerEvent('NRP-B-Dirtystacks-10k')
AddEventHandler('NRP-B-Dirtystacks-10k', function()
 local source = tonumber(source)
  TriggerEvent('core:getPlayerFromId', source, function(user)
  user.addDirtyMoney(10000)
  TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = 'You have unstacked your cash!'})
  end)
end)

RegisterServerEvent("NRP-M-Dirtystacks-10k")
AddEventHandler("NRP-M-Dirtystacks-10k", function()
    local source = tonumber(source)
    TriggerEvent("core:getPlayerFromId", source, function(user)
        if user.getDirtyMoney() >= 10000 then
         user.removeDirtyMoney(10000)
         TriggerClientEvent("inventory:removeQty",source, 155, 3)
         TriggerClientEvent("inventory:addQty",source, 176, 1)
         TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = 'You have stacked your cash!'})
        else
         TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = 'You need more cash'})
        end
    end)
end)

RegisterServerEvent('NRP-B-Dirtystacks-5k')
AddEventHandler('NRP-B-Dirtystacks-5k', function()
 local source = tonumber(source)
  TriggerEvent('core:getPlayerFromId', source, function(user)
  user.addDirtyMoney(5000)
  TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = 'You have unstacked your cash!'})
  end)
end)

RegisterServerEvent("NRP-M-Dirtystacks-5k")
AddEventHandler("NRP-M-Dirtystacks-5k", function()
    local source = tonumber(source)
    TriggerEvent("core:getPlayerFromId", source, function(user)
        if user.getDirtyMoney() >= 5000 then
         user.removeDirtyMoney(5000)
         TriggerClientEvent("inventory:removeQty",source, 155, 2)
         TriggerClientEvent("inventory:addQty",source, 177, 1)
         TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = 'You have stacked your cash!'})
        else
         TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = 'You need more cash'})
        end
    end)
end)

RegisterServerEvent('NRP-B-Dirtystacks-1k')
AddEventHandler('NRP-B-Dirtystacks-1k', function()
 local source = tonumber(source)
  TriggerEvent('core:getPlayerFromId', source, function(user)
  user.addDirtyMoney(1000)
  TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = 'You have unstacked your cash!'})
  end)
end)

RegisterServerEvent("NRP-M-Dirtystacks-1k")
AddEventHandler("NRP-M-Dirtystacks-1k", function()
    local source = tonumber(source)
    TriggerEvent("core:getPlayerFromId", source, function(user)
        if user.getDirtyMoney() >= 1000 then
         user.removeDirtyMoney(1000)
         TriggerClientEvent("inventory:removeQty",source, 155, 1)
         TriggerClientEvent("inventory:addQty",source, 178, 1)
         TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = 'You have stacked your cash!'})
        else
         TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = 'You need more cash'})
        end
    end)
end)