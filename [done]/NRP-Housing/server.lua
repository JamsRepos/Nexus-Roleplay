local allHouses = {}
local ownedHouses = {}
local instances = {}
local vehicles = {}
local firstjoin = false

AddEventHandler('playerConnecting', function()
  if not firstjoin then
    TriggerEvent("housing:updateAll")
    firstjoin = true
  end
end)

TriggerEvent('core:addGroupCommand', 'refreshhouses', "admin", function(source, args, user)
  local source = tonumber(source)
  TriggerEvent("housing:updateAll")
  TriggerEvent('core:log', "[HOUSES] "..GetPlayerName(source).."("..source..") has refreshed all houses.", "staff") 
end)

AddEventHandler('onResourceStart', function(resource)
 if resource == GetCurrentResourceName() then
  local houses = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `houses`")    
  local owned = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `owned_houses`")    
  for i,v in pairs(houses) do
   allHouses[v.id] = {address = v.address, pos = json.decode(v.position), price = v.price, ipl = v.ipl, id = v.id}
  end
  for i,v in pairs(owned) do
   ownedHouses[v.house_id] = {id = v.house_id, char_id = v.char_id, owner = v.owner, keys = v.keys, rent = v.rent, rent_due = v.rent_due}
  end
 end
end)

AddEventHandler('housing:updateAll', function()
 allHouses = {}
 ownedHouses = {} 
 vehicles = {}
 local houses = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `houses`")    
 local owned = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `owned_houses`")    
 for i,v in pairs(houses) do
  allHouses[v.id] = {address = v.address, pos = json.decode(v.position), price = v.price, ipl = v.ipl, id = v.id}
 end
 for i,v in pairs(owned) do
  ownedHouses[v.house_id] = {id = v.house_id, char_id = v.char_id, owner = v.owner, keys = v.keys, rent = v.rent, rent_due = v.rent_due}
 end
 TriggerEvent("core:getPlayers", function(users)
  for _,v in pairs(users) do
   TriggerClientEvent('housing:update', v.getSource(), allHouses, ownedHouses, v.getCharacterID())
  end
 end)
end)


RegisterServerEvent('core:characterloaded')
AddEventHandler('core:characterloaded', function()
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  TriggerClientEvent('housing:update', source, allHouses, ownedHouses, user.getCharacterID())

  local result = exports['GHMattiMySQL']:QueryScalar("SELECT house FROM `characters` WHERE id=@char_id",{['@char_id'] = user.getCharacterID()})
  if result > 0 then
    local houseid = result
    TriggerClientEvent("housing:removefromhouse", source, houseid)
  end
 end)
end)

RegisterServerEvent('housing:updateHouse')
AddEventHandler('housing:updateHouse', function(houseid)
 local source = tonumber(source)
 TriggerEvent("core:getPlayerFromId", source, function(user)
    exports['GHMattiMySQL']:QueryAsync("UPDATE `characters` SET house=@houseid WHERE id=@id",{['@houseid'] = houseid, ['@id'] = user.getCharacterID()})
 end)
end)

RegisterServerEvent('housing:addProperty')
AddEventHandler('housing:addProperty', function(address, price, interior, pos)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `houses` (address, position, price, ipl, agent) VALUES (@address, @position, @price, @ipl, @agent)',{['@address'] = address, ['@position'] = json.encode(pos), ['@price'] = price, ['@ipl'] = interior, ['@agent'] = user.getIdentity().fullname})
   TriggerEvent("core:log", tostring("[ADD] " .. user.getIdentity().fullname .. "(" .. source .. ") added property "..address.." for a price of $"..price.."."), "realestate")
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = "Property Added!"})
   TriggerEvent('housing:updateAll')
 end)
end)

RegisterServerEvent('housing:removeProperty')
AddEventHandler('housing:removeProperty', function(id)
  local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
   exports['GHMattiMySQL']:QueryAsync('DELETE FROM `houses` WHERE `id`=@id',{['@id'] = id})
   exports['GHMattiMySQL']:QueryAsync('DELETE FROM `owned_houses` WHERE `house_id`=@id',{['@id'] = id})
   TriggerEvent("core:log", tostring("[REMOVE] " .. user.getIdentity().fullname .. "(" .. source .. ") removed property ID "..id.."."), "realestate")
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = "Property Removed!"})
   TriggerEvent('housing:updateAll')
 end)
end)

RegisterServerEvent('housing:rentProperty')
AddEventHandler('housing:rentProperty', function(rent, id, pedids)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  if user.getBank() >= rent then 
   user.removeBank(rent)
   for _,v in pairs(pedids) do
    TriggerEvent('core:getPlayerFromId', v, function(d8)
      local commission = tonumber(rent / 10)
      d8.addBank(commission)
      TriggerClientEvent('NRP-notify:client:SendAlert', v, { type = 'inform', text = "You received $"..commission.." in commission."})
      TriggerEvent("core:log", tostring("[SOLD] " .. d8.getIdentity().fullname .. "(" .. v .. ") sold property ID "..id.." for a price of $"..rent.." with $"..commission.." commission."), "realestate")
     end)
   end
   Wait(100)
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `owned_houses` (house_id, char_id, owner, rent) VALUES (@houseid, @char_id, @owner, @rent)',{['@houseid'] = id, ['@char_id'] = user.getCharacterID(), ['@owner'] = user.getIdentity().fullname, ['@rent'] = rent})
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "House Bought!"})
   TriggerEvent('housing:updateAll')
  else 
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Insufficient Funds"}) 
  end 
 end)
end)

RegisterServerEvent('housing:stopRenting')
AddEventHandler('housing:stopRenting', function(id, sellprice)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  exports['GHMattiMySQL']:QueryAsync('DELETE FROM `owned_houses` WHERE `house_id`=@id',{['@id'] = id})
  TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "You have sold this house for $"..sellprice})
  user.addBank(sellprice)
  TriggerEvent('housing:updateAll')
 end)
end)

RegisterServerEvent('housing:payRent')
AddEventHandler('housing:payRent', function(id, rent)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  if user.getBank() >= rent then 
   user.removeBank(rent)
   exports['GHMattiMySQL']:QueryAsync('UPDATE `owned_houses` SET rent_due=@rent WHERE house_id=@id',{['@rent'] = 0, ['@id'] = id})
   TriggerEvent("core:moneylog", source, 'Bills Payed: $'..rent)
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "bills Paid!"})
   TriggerEvent('housing:updateAll')
  else 
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Insufficient Funds"}) 
  end 
 end)
end)


function getExistingInstance(hid)
  for _,v in pairs(instances) do
    if (v.houseid and v.houseid == hid) then
      return v
    end
  end
end

function updateInstanceMembers(source, inst)
  local part = inst.participants
  local exist = false

  for _,v in pairs(part) do
    if (v == source) then
      exist = true
      break
    end
  end

  if (not exist) then
    table.insert(part, source)
  end

  for _,v in pairs(part) do
    TriggerClientEvent("housing:updateInstanceMembers", v, inst)
  end
end

function removeFromInstance(source, inst)
  local part = inst.participants

  for i = #part, 1, -1 do
    local p = part[i]
    
    if (p == source) then
      table.remove(part, i)
    end
  end

  if (#part == 0) then
    local ridx = 0
    
    for i,v in ipairs(instances) do
      if (v.houseid == inst.houseid) then
        ridx = i
        break
      end
    end

    if (ridx > 0) then
      table.remove(instances, i)
    end
  else
    for _,v in pairs(part) do
      TriggerClientEvent("housing:updateInstanceMembers", v, inst)
    end
  end
end

RegisterServerEvent("housing:createInstance")
AddEventHandler("housing:createInstance", function(house)
  local source = tonumber(source)
  local inst = getExistingInstance(house.id)
  if (inst) then -- update instance with us as new member
    updateInstanceMembers(source, inst)
    TriggerClientEvent("housing:sendToInstance", source, inst, house)
  else -- create new instance with this house id and send me there
    math.randomseed(os.time())
    inst = {houseid = house.id, participants = {source}, vchan = math.random(1000,9000)}
    table.insert(instances, inst)
    TriggerClientEvent("housing:sendToInstance", source, inst, house)
  end
end)

RegisterServerEvent("housing:removeFromInstance")
AddEventHandler("housing:removeFromInstance", function(house)
  if (house) then
    local source = tonumber(source)
    local inst = getExistingInstance(house.id)
    if (inst) then
      removeFromInstance(source, inst)
    end
  end
end)

RegisterServerEvent("housing:enterallowfriends")
AddEventHandler("housing:enterallowfriends", function(pedids, house)
 local source = tonumber(source)
 local inst = getExistingInstance(house.id)
 if (inst) then
  local sexists = false
  for _,v in pairs(inst.participants) do
   if (v == source) then
    sexists = true
    break
   end
  end
  if (not sexists) then
   table.insert(inst.participants, source)
  end

  for _,v in pairs(pedids) do
   local exists = false
   for _,p in pairs(inst.participants) do
    if (p == v) then
     exists = true
    end
   end

   if (not exists) then
    table.insert(inst.participants, v)
   end
  end

  for _,v in pairs(inst.participants) do
   TriggerClientEvent("housing:sendToInstance", inst, house)
   TriggerClientEvent("housing:isInHouse")
  end
 else
  math.randomseed(os.time())
  local inst = {houseid = house.id, participants = pedids, vchan = math.random(1000, 9000)}
  table.insert(inst.participants, source)
  table.insert(instances, inst)
    
  for _,v in pairs(pedids) do
   TriggerClientEvent("housing:sendToInstance", v, inst, house)
   TriggerClientEvent("housing:isInHouse", v)
  end
 end
end)

RegisterServerEvent("housing:givekey")
AddEventHandler("housing:givekey", function(house, sid)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', sid, function(user) 
  local results = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `owned_houses` WHERE house_id=@hid", {["@hid"] = house.id})
  local result = results[1].keys
  local keys = nil
  if result ~= 'No Keys' then
   local keys = json.decode(result)
   table.insert(keys, {id = user.getCharacterID(), name = user.getIdentity().fullname})
   local keyenc = json.encode(keys)
   exports['GHMattiMySQL']:QueryAsync('UPDATE owned_houses SET `keys`=@keys WHERE `house_id`=@hid',{['@keys'] = keyenc, ['@hid'] = house.id})
  else 
   local keys = {}
   table.insert(keys, {id = user.getCharacterID(), name = user.getIdentity().fullname})
   local keyenc = json.encode(keys)
   exports['GHMattiMySQL']:QueryAsync('UPDATE owned_houses SET `keys`=@keys WHERE `house_id`=@hid',{['@keys'] = keyenc, ['@hid'] = house.id})
  end
  TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text =("You give a house key to " ..user.getIdentity().fullname)})
  TriggerClientEvent('NRP-notify:client:SendAlert', sid, { type = 'success', text =("You have been given a house key")})
  TriggerEvent('housing:updateAll')
 end)
end)


RegisterServerEvent("housing:takekey")
AddEventHandler("housing:takekey", function(house, target)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user) 
  local results = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `owned_houses` WHERE house_id=@hid", {["@hid"] = house.id})
  local result = results[1].keys
  local target = GetClosestPlayer()
  local fullname = ''
  local keys = {}
  if result ~= 'null' then 
   for _,v in pairs(keys) do
    if(distance ~= -1 and distance < 5 ) then
     if (v.id == target) then 
      fullname = v.name
      table.remove(keys, _)
     --table.remove(keys, {id = user.getCharacterID(), name = user.getIdentity().fullname})
    else
      TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = "No PLayers Near You Have a Key To One Of Your Houses"})
     end
    end
   end
  end

  local keyenc = json.encode(keys)
  exports['GHMattiMySQL']:QueryAsync('UPDATE owned_houses SET `keys`=@keys WHERE `house_id`=@hid',{['@keys'] = keyenc, ['@hid'] = house.id})
  TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = string.format("you have taken a key from .", fullname)})
  TriggerEvent('housing:updateAll')
 end)
end)

RegisterServerEvent("housing:changelocks")
AddEventHandler("housing:changelocks", function(id)
 if (id) then
  local source = tonumber(source)
  exports['GHMattiMySQL']:QueryAsync('UPDATE owned_houses SET `keys`=@keys WHERE `house_id`=@hid',{['@keys'] = 'No Keys', ['@hid'] = id})
  TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "The locks on your property have been changed."})
  TriggerEvent('housing:updateAll')
 end
end)



RegisterServerEvent('homes:setGarage')
AddEventHandler('homes:setGarage', function(id, pos,target)
 local source = tonumber(source)
 local target = tonumber(target)

 TriggerEvent('core:getPlayerFromId', source, function(user)  
  TriggerEvent('core:getPlayerFromId', target, function(targ)
    target.addGarage(id, 5, 15000)
   end)  
   exports['GHMattiMySQL']:QueryAsync('UPDATE `owned_houses` SET garage=@garage WHERE house_id=@id',{['@garage'] = json.encode(pos),['@id'] = id})

  TriggerClientEvent('chatMessage', source, '^2Garage Point Set')
  TriggerEvent('housing:updateAll')
 end)
end)


------------------------------------
-- Vehicle Garage Added To Houses --
------------------------------------

RegisterServerEvent("housegarage:buy")
AddEventHandler("housegarage:buy", function(cost, id, slots)
    local source = tonumber(source)
    local slots = 5
    local cost = 15000
    TriggerEvent("core:getPlayerFromId", source, function(user)
        if(user.getMoney() >= tonumber(cost))then
          print(id,slots,cost)
            user.addGarage(id,slots,cost)
            user.removeMoney(cost)
            GNotify(source,"Garage purchased!")
        else
            GNotify(source,"Insufficient funds!")
        end
    end)
end)
function GNotify(source,message)
  TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = message})
end
 
RegisterServerEvent("housegarage:out")
AddEventHandler("housegarage:out", function(data)
 local source = source
 TriggerEvent("core:getPlayerFromId", source, function(user)
  user.setVehicleOut(data.plate)
 end)
end)

RegisterServerEvent('homes:removeVehicle')
AddEventHandler('homes:removeVehicle', function(id, plate)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  local vehicles = ownedHouses[id].Vehicles
  for vid,v in pairs(vehicles) do
   if v.components.plate == plate then  
    table.remove(vehicles, vid)
    exports['GHMattiMySQL']:QueryAsync('UPDATE `owned_houses` SET vehicles=@vehicles WHERE house_id=@id AND char_id=@char_id',{['@char_id'] = user.getCharacterID(), ['@id'] = id, ['@vehicles'] = json.encode(vehicles)})
    TriggerEvent('housing:updateAll')
   end
  end
 end)
end)

RegisterServerEvent('homes:vehicles')
AddEventHandler('homes:vehicles', function(id)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  local vehicles = ownedHouses[id].Vehicles

  TriggerClientEvent('chat:addMessage', source, {template = '<div style="text-align: center;">My Vehicles - '..#vehicles..'/2</div> <hr/>'})
  for i=1, #vehicles do 
   TriggerClientEvent('chat:addMessage', source, {template = '<div><font style="font-weight: 550;">['..i..'] '..vehicles[i].name..'</font> - '..vehicles[i].components.plate..'</div>'})
  end
 end)
end)
