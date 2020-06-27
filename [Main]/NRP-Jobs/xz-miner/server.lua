RegisterServerEvent("xz_miner:givestone")
AddEventHandler("xz_miner:givestone", function(item, count)
    local source = tonumber(source)
    TriggerEvent('core:getPlayerFromId', source, function(user)
        if user ~= nil then
         TriggerClientEvent("inventory:addQty",source, 282, 5)          
        end
    end)
end)
RegisterServerEvent("xz_miner:givedoublestone")
AddEventHandler("xz_miner:givedoublestone", function(item, count)
    local source = tonumber(source)
    TriggerEvent('core:getPlayerFromId', source, function(user)
        if user ~= nil then
         TriggerClientEvent("inventory:addQty",source, 282, 10)          
        end
    end)
end) 
--[[RegisterServerEvent("xz_miner:washing")
AddEventHandler("xz_miner:washing", function(item, count)
    local source = tonumber(source)
    TriggerEvent('core:getPlayerFromId', source, function(user)
        if user ~= nil then
         TriggerClientEvent("xz_miner:washing", source)
         Citizen.Wait(15900)
         TriggerClientEvent("inventory:removeQty",source, 282,10)
         TriggerClientEvent("inventory:addQty",source, 283, 10)
        end
    end)
end)
]]--
RegisterServerEvent("xz_miner:washing")
AddEventHandler("xz_miner:washing", function(item, count)
    local source = tonumber(source)
    TriggerEvent('core:getPlayerFromId', source, function(user)
        if user ~= nil then
          TriggerClientEvent("inventory:removeQty",source, 282,10)
          TriggerClientEvent("inventory:addQty",source, 283, 10)
        end
    end)
end)
RegisterServerEvent("xz_miner:remelting")
AddEventHandler("xz_miner:remelting", function(item, count)
    local source = tonumber(source)
  TriggerEvent('core:getPlayerFromId', source, function(user)
    local randomChance = math.random(1, 100)
        if user ~= nil then
          for _,v in pairs(user.getPoints()) do -------------
            if v.name == 'Mining' then       ----------------   NEW JOB POINT SYSTEM SERVER SIDE LEVEL FIVE == DIAMONDS
              if v.value >= 150 then     --------------------
                TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = 'Level 5 Mining or Above , You have now access to find diamonds when remelting stones!'})
               if randomChance < 5 then
                TriggerClientEvent("inventory:addQty",source, 284, 1) 
                TriggerClientEvent("inventory:removeQty",source, 283, 10) 
                TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = 'You get 1 diamond from 5 washed stones.!'})
               elseif randomChance > 4 and randomChance < 20 then
                TriggerClientEvent("inventory:addQty",source, 285, 5) 
                TriggerClientEvent("inventory:removeQty",source, 283, 10) 
                TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = 'You get 5 pieces of gold from 5 washed stones.!'})
               elseif randomChance > 19 and randomChance < 50 then
                TriggerClientEvent("inventory:addQty",source, 286, 10)
                TriggerClientEvent("inventory:removeQty",source, 283, 10)
                TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = 'You get 10 pieces of iron from 5 washed stones.!'})
               elseif randomChance > 49 then
                TriggerClientEvent("inventory:addQty",source, 287, 20)
                TriggerClientEvent("inventory:removeQty",source, 283, 10)
                TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = 'You get 20 pieces of copper from 5 washed stones.!'})
               end
              else
                if randomChance >= 0 and randomChance < 20 then
                    TriggerClientEvent("inventory:addQty",source, 285, 5) 
                    TriggerClientEvent("inventory:removeQty",source, 283, 10) 
                    TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = 'You get 5 pieces of gold from 5 washed stones.!'})
                elseif randomChance > 19 and randomChance < 51 then
                    TriggerClientEvent("inventory:addQty",source, 286, 10)
                    TriggerClientEvent("inventory:removeQty",source, 283, 10)
                    TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = 'You get 5 pieces of iron from 5 washed stones.!'})
                elseif randomChance > 51 then
                    TriggerClientEvent("inventory:addQty",source, 287, 20)
                    TriggerClientEvent("inventory:removeQty",source, 283, 10)
                    TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = 'You get 10 pieces of copper from 5 washed stones.!'}) 
                end
              end
            end   
          end
        end
    end)
end)
RegisterServerEvent("xz_miner:selldiamond")
AddEventHandler("xz_miner:selldiamond", function(item, count)
    local source = tonumber(source)
    TriggerEvent('core:getPlayerFromId', source, function(user)
        local payday = 1000
        if user ~= nil then
            for _,v in pairs(user.getPoints()) do
                if v.name == 'Mining' then          
                  if v.value >= 350 then 
                    TriggerClientEvent("inventory:removeQty",source, 284, 1) 
                    user.addMoney(payday*1.50)
                    TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = 'You sell 1 diamond for '..(payday*1.50)..'!'})
                  elseif v.value >= 50 then
                    TriggerClientEvent("inventory:removeQty",source, 284, 1) 
                    user.addMoney(payday*1.25)
                    TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = 'You sell 1 diamond for '..(payday*1.25)..'!'})
                  else
                    TriggerClientEvent("inventory:removeQty",source, 284, 1) 
                    user.addMoney(payday)
                    TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = 'You sell 1 diamond for '..payday..'!'})                  
                  end
                end
            end    
        end
    end)
end)
RegisterServerEvent("xz_miner:sellgold")
AddEventHandler("xz_miner:sellgold", function(item, count)
    local source = tonumber(source)
    TriggerEvent('core:getPlayerFromId', source, function(user)
        local payday = 1250
        if user ~= nil then
            for _,v in pairs(user.getPoints()) do
                if v.name == 'Mining' then          
                  if v.value >= 100 then                
                   TriggerClientEvent("inventory:removeQty",source, 285, 5)
                   user.addMoney(payday*1.50)
                   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = 'You sell 5 gold for '..(payday*1.50)..'!'})
                  elseif v.value >= 50 then                
                    TriggerClientEvent("inventory:removeQty",source, 285, 5)
                    user.addMoney(payday*1.25)
                    TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = 'You sell 5 gold for '..(payday*1.25)..'!'})
                  else
                    TriggerClientEvent("inventory:removeQty",source, 285, 5)
                    user.addMoney(payday)
                    TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = 'You sell 5 gold for '..payday..'!'})
                  end            
                end
             end

        end
    end)
end)
RegisterServerEvent("xz_miner:selliron")
AddEventHandler("xz_miner:selliron", function(item, count)
    local source = tonumber(source)
    TriggerEvent('core:getPlayerFromId', source, function(user)
        local payday = 800
        if user ~= nil then
          for _,v in pairs(user.getPoints()) do
            if v.name == 'Mining' then          
              if v.value >= 350 then 
                TriggerClientEvent("inventory:removeQty",source, 286, 10)
                user.addMoney(payday*1.50)
                TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = 'You sell 10 iron for '..(payday*1.50)..'!'})
              elseif v.value >= 50 then
                TriggerClientEvent("inventory:removeQty",source, 286, 10)
                user.addMoney(payday*1.25)
                TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = 'You sell 10 iron for '..(payday*1.25)..'!'})
              else
                TriggerClientEvent("inventory:removeQty",source, 286, 10)
                user.addMoney(payday)
                TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = 'You sell 10 iron for '..payday..'!'})
              end
            end
          end
        end
    end)
end)
RegisterServerEvent("xz_miner:sellcopper")
AddEventHandler("xz_miner:sellcopper", function(item, count)
    local source = tonumber(source)
    TriggerEvent('core:getPlayerFromId', source, function(user)
        local payday = 600
        if user ~= nil then
          for _,v in pairs(user.getPoints()) do
            if v.name == 'Mining' then          
              if v.value >= 350 then
                TriggerClientEvent("inventory:removeQty",source, 287, 20)
                user.addMoney(payday*1.50)
                TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = 'You sell 20 copper for '..(payday*1.50)..'!'})
              elseif v.value >= 50 then
                TriggerClientEvent("inventory:removeQty",source, 287, 20)
                user.addMoney(payday*1.25)
                TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = 'You sell 20 copper for '..(payday*1.25)..'!'})
              else
                TriggerClientEvent("inventory:removeQty",source, 287, 20)
                user.addMoney(payday)
                TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = 'You sell 20 copper for '..payday..'!'})
              end
            end
          end
        end
    end)
end)    

