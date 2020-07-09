local droppedItems = {}

RegisterServerEvent("inventory:updateitems")
AddEventHandler("inventory:updateitems",function(source)
    local source = tonumber(source)
    TriggerEvent('core:getPlayerFromId', source, function(user)
        local inventory = user.getInventory()
        TriggerClientEvent("inventory:updateitems", source, inventory)
    end)
end)

AddEventHandler('core:playerLoaded', function(Source, user)
    local source = tonumber(Source)
    TriggerEvent('core:getPlayerFromId', source, function(user)
        local inventory = user.getInventory()
        TriggerClientEvent("inventory:updateitems", source, inventory)
    end)
end)

RegisterServerEvent("inventory:add")
AddEventHandler("inventory:add",function(i,q,meta)
    local source = tonumber(source)
    TriggerEvent('core:getPlayerFromId', source, function(user)
        local canGet = user.isAbleToReceive(q)
        if not canGet then
          Notify(source, 'Inventory Full')
        else
          user.addQuantity(i,q,meta)
        end
    end)
end)

RegisterServerEvent("inventory:remove")
AddEventHandler("inventory:remove",function(i,q)
    local source = tonumber(source)
    TriggerEvent('core:getPlayerFromId', source, function(user)
        user.removeQuantity(i,q)
    end)
end)

RegisterServerEvent("inventory:give")
AddEventHandler("inventory:give",function(i,q,meta,target)
    local source = tonumber(source)
    local canGive = false
    local canRecieve = false
    local itemData = nil
    local To
    local From
    TriggerEvent('core:getPlayerFromId', source, function(user)
        canGive = user.isAbleToGive(i,q,meta)
        From = user
    end)
    TriggerEvent('core:getPlayerFromId', tonumber(target), function(t)
        canRecieve = t.isAbleToReceive(q)
        To = t
    end)
    if canGive then
        if canRecieve then
          itemData = From.getItemMeta(i)
          From.removeQuantity(i,q,meta)
          To.addQuantity(i,q, meta)
          local data = To.getItemData(i)
          TriggerClientEvent('NRP-notify:client:SendAlert', tonumber(target), { type = 'success', text ="You Recieved "..q.."x "..data.name})
          TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = "You Gave "..q.."x "..data.name}) 
          TriggerClientEvent('chat:actionmessage', -1, source, GetActiveCharacter(source).firstname.." gives something to "..GetActiveCharacter(tonumber(target)).firstname)
        else
          TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = "Target Inventory Is Full"})    
          TriggerClientEvent('NRP-notify:client:SendAlert', tonumber(target), { type = 'inform', text ="Inventory Full"})       
        end
    else 
        TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = "You cannot give an item u don't own!"})    
    end
end)

RegisterServerEvent("inventory:drop")
AddEventHandler("inventory:drop",function(i,q,pos,meta)
 local source = tonumber(source)
 print(i)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  canDrop = user.isAbleToDrop(i,q,meta)
  print(canDrop)
  if canDrop then
   local data = user.getItemData(i)
   table.insert(droppedItems, {item = i, name = data.name, qty = q, pos = pos, meta = meta})
   print("item id: "..i.." item name: "..data.name.." qty: "..q.." meta data: "..meta)
   user.removeQuantity(i,q,meta)
   TriggerClientEvent("inventory:droppeditems", -1, droppedItems)
  else
    TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = "You cannot drop an item u don't own!"})    
  end
 end)
end)

RegisterServerEvent('inventory:pickup')
AddEventHandler('inventory:pickup', function(id, item, qty, meta)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  local canGet = user.isAbleToReceive(qty)
  if not canGet then
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = "Inventory Full"})
  else
   user.addQuantity(item, qty, meta)
   table.remove(droppedItems, id)
   TriggerClientEvent("inventory:droppeditems", -1, droppedItems)
  end
 end)
end)


RegisterServerEvent("player:givemoney")
AddEventHandler("player:givemoney", function(target, amount)
 local source = tonumber(source)
 local target = tonumber(target)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  TriggerEvent('core:getPlayerFromId', target, function(targ)
   if tonumber(user.getMoney()) >= tonumber(amount) then 
    user.removeMoney(amount)
    targ.addMoney(amount)
    TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = "You Gave $"..amount.." To "..targ.getIdentity().fullname})
    TriggerClientEvent('NRP-notify:client:SendAlert', target, { type = 'success', text ="You Recieved $"..amount.." From "..user.getIdentity().fullname})
    TriggerClientEvent('chat:actionmessage', -1, source, user.getIdentity().firstname.." gives some cash to "..targ.getIdentity().firstname)   
    TriggerEvent("core:moneylog", source, 'Gave Money To:['..target..'] $'..amount)
   else
    TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = "You Can't Afford $"..amount})
   end
  end)
 end)
end)

RegisterServerEvent("player:givedmoney")
AddEventHandler("player:givedmoney", function(target, amount)
 local source = tonumber(source)
 local target = tonumber(target)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  TriggerEvent('core:getPlayerFromId', target, function(target)
   if user.getDirtyMoney() >= amount then 
    user.removeDirtyMoney(amount)
    target.addDirtyMoney(amount)
    TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = "You Have Given $"..amount.." To "..target.getIdentity().fullname})
    TriggerClientEvent('NRP-notify:client:SendAlert', target, { type = 'success', text = "You Have Been Given $"..amount.." From "..user.getIdentity().fullname})   
    --TriggerEvent("core:moneylog", source, 'Gave Dirty Money To:['..target..'] $'..amount)
   else
    TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = "You Can't Afford $"..amount})
   end
  end)
 end)
end)

function Notify(source,message)
    TriggerClientEvent("pNotify:SendNotification", source, {text = message})
end

RegisterServerEvent("pNotify:SendNotification")
AddEventHandler("pNotify:SendNotification", function(target, data)
 TriggerClientEvent("pNotify:SendNotification", target, data)
end)


RegisterServerEvent('player:showid')
AddEventHandler('player:showid', function()
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  local fullname = user.getIdentity().fullname
  local gender = user.getIdentity().gender
  local dob = user.getIdentity().dob
  local job = user.getJobName()
  TriggerClientEvent('player:showid', -1, source, fullname, gender, dob, job)
 end)
end)

local fakeIds = {
 [1] = {name = 'Joseph Hirschman', dob = '28/05/1970', job = 'Taxi'},
 [2] = {name = 'Bryan Sandoval', dob = '29/06/1969', job = 'Post OP'},
 [3] = {name = 'Spencer Gray', dob = '12/10/1986', job = 'Fisherman'},
 [4] = {name = 'Reese Christian', dob = '29/06/1969', job = 'Unemployed'},
 [5] = {name = 'Harris Buckner', dob = '29/06/1969', job = 'Fisherman'},
 [6] = {name = 'Victor Donovan', dob = '29/06/1969', job = 'Post OP'},
 [7] = {name = 'Coty Ray', dob = '29/06/1969', job = 'Taxi'},
 [8] = {name = 'Jerald Best', dob = '29/06/1969', job = 'Reporter'},
 [9] = {name = 'Chase Bowen', dob = '29/06/1969', job = 'Drug Dealer'},
 [10] = {name = 'Keon Frost', dob = '29/06/1969', job = 'Contact Killer'},
}


RegisterServerEvent('player:showfakeid')
AddEventHandler('player:showfakeid', function()
 local source = tonumber(source)
 local randomID = fakeIds[math.random(1, #fakeIds)]
 TriggerEvent('core:getPlayerFromId', source, function(user)
  local fullname = randomID.name
  local gender = user.getIdentity().gender
  local dob = randomID.dob
  local job = randomID.job
  TriggerClientEvent('player:showid', -1, source, fullname, gender, dob, job)
 end)
end)



