local rentedHotels = {}
local instances = {}

AddEventHandler('onResourceStart', function(resource)
 if resource == GetCurrentResourceName() then
  local owned = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `owned_hotels`")    
  for i,v in pairs(owned) do
   rentedHotels[v.hotel_id] = {id = v.hotel_id, char_id = v.char_id, days_left = v.days_left, char_name = v.char_name, address = v.address}
  end
 end
end)

TriggerEvent('core:addGroupCommand', 'refreshmotels', "user", function(source, args, user)
  TriggerEvent('hotels:update')
end)

RegisterServerEvent("motels:enterallowfriends")
AddEventHandler("motels:enterallowfriends", function(pedids, house)
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
  TriggerClientEvent("hotel:sendToInstance", source, inst, house)
  end
 else
  math.randomseed(os.time())
  local inst = {houseid = house.id, participants = pedids, vchan = math.random(1000, 9000)}
  table.insert(inst.participants, source)
  table.insert(instances, inst)
    
  for _,v in pairs(pedids) do
   TriggerClientEvent("hotel:sendToInstance", v, inst, house)
  end
 end
end)

AddEventHandler('hotels:update', function()
 rentedHotels = {}
 local owned = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `owned_hotels`")    
 for i,v in pairs(owned) do
  rentedHotels[v.hotel_id] = {id = v.hotel_id, char_id = v.char_id, days_left = v.days_left, char_name = v.char_name, address = v.address, management_id = v.management_id}
 end
 TriggerEvent("core:getPlayers", function(users)
  for _,v in pairs(users) do
   TriggerClientEvent('hotels:update', v.getSource(), rentedHotels, v.getCharacterID())
  end
 end)
end)

RegisterServerEvent('core:characterloaded')
AddEventHandler('core:characterloaded', function()
 TriggerEvent("core:getPlayers", function(users)
  for _,v in pairs(users) do
   TriggerClientEvent('hotels:update', v.getSource(), rentedHotels, v.getCharacterID())
  end
 end)
end)

RegisterServerEvent('hotel:rentRoom')
AddEventHandler('hotel:rentRoom', function(id, address, days, price, management)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  local identity = user.getIdentity()
  if user.getMoney() >= price then 
   user.removeMoney(price)
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `owned_hotels` (char_id, char_name, address, hotel_id, days_left, management_id) VALUES (@char_id, @char_name, @address, @hotel_id, @days, @management_id)',{['@char_id'] = user.getCharacterID(), ['@char_name'] = identity.fullname, ['@hotel_id'] = id, ['@days'] = days, ['@address'] = address, ['@management_id'] = management})
   TriggerEvent("core:moneylog", source, "Hotel Room Rented For "..days.." Days! > $"..price)
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Hotel Room Rented For "..days.." Days!"})
   TriggerEvent('hotels:update')
  else 
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Insufficient Funds"}) 
  end 
 end)
end)

RegisterServerEvent('hotel:unrentHotel')
AddEventHandler('hotel:unrentHotel', function(id)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
   exports['GHMattiMySQL']:QueryAsync('DELETE FROM `owned_hotels` WHERE `hotel_id`=@hotel_id AND `char_id`=@char_id',{['@char_id'] = user.getCharacterID(), ['@hotel_id'] = id})
   TriggerEvent('hotels:update')
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Motel Successfully Unrented!"}) 
 end)
end)

--[[RegisterServerEvent('hotel:addExtraDays')
AddEventHandler('hotel:addExtraDays', function(id, days, price)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  local identity = user.getIdentity()
  if user.getMoney() >= price then 
   
   local finalDays = 0
   exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM owned_hotels WHERE `hotel_id` = @id", {['@id'] = id}, function(results)
   finalDays = results[1].days_left + days
   end)
   Wait(10)
   if tonumber(finalDays) >= 15 then
    TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "You can not rent a hotel for more than 14 days at a time!"}) 
   else
    user.removeMoney(price)
    exports['GHMattiMySQL']:QueryAsync('UPDATE `owned_hotels` SET `days_left`=@days WHERE `hotel_id`=@id',{['@days'] = finalDays, ['@id'] = id})
    TriggerEvent("core:moneylog", source, "Hotel Room Rented For Extra"..days.." Days! > $"..price)
    TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Hotel Room Rented For Extra "..days.." Days!"})
    TriggerEvent('hotels:update')
   end
  else 
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Insufficient Funds"}) 
  end 
 end)
end)
]]--

RegisterServerEvent('hotel:addExtraDays')
AddEventHandler('hotel:addExtraDays', function(id, days, price)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
   if user.getMoney() >= price then    
   local results = exports['GHMattiMySQL']:QueryResult("SELECT * FROM owned_hotels WHERE `hotel_id` = @id", {['@id'] = id})
   local finalDays = results[1].days_left + days
    if tonumber(finalDays) >= 15 then
    TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "You can not rent a hotel for more than 14 days at a time!"})
   else
    user.removeMoney(price)
    exports['GHMattiMySQL']:QueryAsync('UPDATE `owned_hotels` SET `days_left`=@days_left WHERE `hotel_id`=@id',{['@days_left'] = finalDays, ['@id'] = id})
    TriggerEvent("core:moneylog", source, "Hotel Room Rented For Extra"..days.." Days! > $"..price)
    TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = "Hotel Room Rented For Extra "..days.." Days!"})
    TriggerEvent('hotels:update')
   end
  else 
    TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Insufficient Funds"}) 
  end 
 end)
end)

function getExistingInstance(hid)
  for _,v in pairs(instances) do
    if (v.hotelid and v.hotelid == hid) then
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
    TriggerClientEvent("hotel:updateInstanceMembers", v, inst)
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
      if (v.hotelid == inst.hotelid) then
        ridx = i
        break
      end
    end

    if (ridx > 0) then
      table.remove(instances, i)
    end
  else
    for _,v in pairs(part) do
      TriggerClientEvent("hotel:updateInstanceMembers", v, inst)
    end
  end
end

RegisterServerEvent("hotel:createInstance")
AddEventHandler("hotel:createInstance", function(hotel)
  local source = tonumber(source)
  local inst = getExistingInstance(hotel.id)
  if (inst) then -- update instance with us as new member
    updateInstanceMembers(source, inst)
    TriggerClientEvent("hotel:sendToInstance", source, inst, hotel)
  else -- create new instance with this hotel id and send me there
    math.randomseed(os.time())
    inst = {hotelid = hotel.id, participants = {source}, vchan = math.random(1000,9000)}
    table.insert(instances, inst)
    TriggerClientEvent("hotel:sendToInstance", source, inst, hotel)
    TriggerEvent('motel:storage:refresh', source, hotel.id)
  end
end)

RegisterServerEvent("hotel:removeFromInstance")
AddEventHandler("hotel:removeFromInstance", function(hotel)
  if (hotel) then
    local source = tonumber(source)
    local inst = getExistingInstance(hotel.id)
    if (inst) then
      removeFromInstance(source, inst)
    end
  end
end)