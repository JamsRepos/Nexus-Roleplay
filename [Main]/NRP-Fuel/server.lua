local ownedGasStations = {}

RegisterServerEvent('fuel:payOwners')
AddEventHandler('fuel:payOwners', function(pfuelcount, fuelcount, station)
 local source = tonumber(source)
 local addedFuel = (tonumber(fuelcount) - tonumber(pfuelcount))
 local cost = math.floor(tonumber(addedFuel)/1000*station.price)
 local fuellevel = math.floor(tonumber(station.fuel) - tonumber(addedFuel)/1000)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  if cost < 1 then
    cost = 1
  end 
  if (tonumber(user.getMoney()) >= tonumber(cost)) then
   exports['GHMattiMySQL']:QueryAsync('UPDATE `owned_stations` SET station_bank=station_bank+@price WHERE `id`=@id',{['@price'] = cost, ['@id'] = station.id})
   exports['GHMattiMySQL']:QueryAsync('UPDATE `owned_stations` SET station_fuel=@fuel WHERE `id`=@id',{['@fuel'] = fuellevel, ['@id'] = station.id})
   user.removeMoney(tonumber(cost))
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = "You have paid $"..cost.." for fuel!"})
  else
   if (tonumber(user.getBank()) >= tonumber(cost)) then
    user.removeBank(tonumber(cost))
    TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = "You have paid $"..cost.." for fuel!"})
    exports['GHMattiMySQL']:QueryAsync('UPDATE `owned_stations` SET station_bank=station_bank+@price WHERE `id`=@id',{['@price'] = cost, ['@id'] = station.id})
    exports['GHMattiMySQL']:QueryAsync('UPDATE `owned_stations` SET station_fuel=@fuel WHERE `id`=@id',{['@fuel'] = fuellevel, ['@id'] = station.id})
   end
  end
 end)
end)

RegisterServerEvent('fuel:pay')
AddEventHandler('fuel:pay', function(pfuelcount, fuelcount, fuelPrice)
 local source = tonumber(source)
 local addedFuel = (tonumber(fuelcount) - tonumber(pfuelcount))
 local cost = math.floor(tonumber(addedFuel)/1000*fuelPrice)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  if cost < 1 then
    cost = 1
  end 
  if (tonumber(user.getMoney()) >= tonumber(cost)) then
   user.removeMoney(tonumber(cost))
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = "You have paid $"..cost.." for fuel!"})
  else
   if (tonumber(user.getBank()) >= tonumber(cost)) then
   user.removeBank(tonumber(cost))
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = "You have paid $"..cost.." for fuel!"})
   end
  end
 end)
end)

RegisterServerEvent('fuel:purchase')
AddEventHandler('fuel:purchase', function(id)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  if (tonumber(user.getMoney()) >= tonumber(200000)) then
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `owned_stations` (id, station_price, station_owner, owner_name) VALUES (@id, @price, @owner, @owner_name)',{['@id'] = id, ['@price'] = 200000, ['@owner'] = user.getCharacterID(), ['@owner_name'] = user.getIdentity().fullname})
   user.removeMoney(200000)
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = "You have purchased this fuel station"})
   TriggerEvent('fuel:updateStations')
  else
   if (tonumber(user.getBank()) >= tonumber(cost)) then
    exports['GHMattiMySQL']:QueryAsync('INSERT INTO `owned_stations` (id, station_price, station_owner, owner_name) VALUES (@id, @price, @owner, @owner_name)',{['@id'] = id, ['@price'] = 200000, ['@owner'] = user.getCharacterID(), ['@owner_name'] = user.getIdentity().fullname})
    user.removeBank(tonumber(cost))
    TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = "You have purchased this fuel station"})
    TriggerEvent('fuel:updateStations')
   end
  end
 end)
end)

AddEventHandler('onResourceStart', function(resource)
 if resource == GetCurrentResourceName() then
  local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `owned_stations`")    
  for i,v in pairs(result) do
   ownedGasStations[v.id] = {id = v.id, price = v.fuel_price, station_price = v.station_price, fuel = v.station_fuel, char_id = v.station_owner, bank = v.station_bank, owner = v.owner_name}
  end
 end
end)

RegisterServerEvent('fuel:updateStations')
AddEventHandler('fuel:updateStations', function()
 ownedGasStations = {}
 local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `owned_stations`")   
 for i,v in pairs(result) do
  ownedGasStations[v.id] = {id = v.id, price = v.fuel_price, station_price = v.station_price, fuel = v.station_fuel, char_id = v.station_owner, bank = v.station_bank, owner = v.owner_name}
 end
 TriggerEvent("core:getPlayers", function(users)
  for _,v in pairs(users) do
   TriggerClientEvent('fuel:updateStations', v.getSource(), ownedGasStations, v.getCharacterID())
  end
 end)
end)

RegisterServerEvent('core:characterloaded')
AddEventHandler('core:characterloaded', function()
 TriggerEvent('core:getPlayerFromId', source, function(user)
  TriggerClientEvent('fuel:updateStations', source, ownedGasStations, user.getCharacterID())
 end)
end)

TriggerEvent('core:addGroupCommand', 'fueldebug', 'admin', function(source, args, user)
 ownedGasStations = {}
 local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `owned_stations`")   
 for i,v in pairs(result) do
  ownedGasStations[v.id] = {id = v.id, price = v.fuel_price, station_price = v.station_price, fuel = v.station_fuel, char_id = v.station_owner, bank = v.station_bank, owner = v.owner_name}
 end
 TriggerEvent("core:getPlayers", function(users)
  for _,v in pairs(users) do
   TriggerClientEvent('fuel:updateStations', v.getSource(), ownedGasStations, v.getCharacterID())
  end
 end)
end)

RegisterServerEvent('fuel:sell')
AddEventHandler('fuel:sell', function(id, price)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  exports['GHMattiMySQL']:QueryAsync('DELETE FROM `owned_stations` WHERE id=@id',{['@id'] = id})
  user.addMoney(price)
  TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = "You have sold this fuel station"})
  TriggerEvent('fuel:updateStations')
 end)
end)


RegisterServerEvent('fuel:updatefuel')
AddEventHandler('fuel:updatefuel', function(price, id)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  exports['GHMattiMySQL']:QueryAsync('UPDATE `owned_stations` SET fuel_price=@fuel WHERE `id`=@id',{['@fuel'] = price, ['@id'] = id})
  TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text ="Fuel Price Updated"})
  TriggerEvent('fuel:updateStations')
 end)
end)

RegisterServerEvent('fuel:buyFuel')
AddEventHandler('fuel:buyFuel', function(id, fuel, price)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  if (tonumber(user.getBank()) >= tonumber(price)) then
   user.removeBank(price)
   exports['GHMattiMySQL']:QueryAsync('UPDATE `owned_stations` SET station_fuel=station_fuel+@fuel WHERE `id`=@id',{['@fuel'] = fuel, ['@id'] = id})
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text ="Fuel Delivery Ordered"})
   TriggerEvent('fuel:updateStations')
  end
 end)
end)

RegisterServerEvent('fuel:takeBank')
AddEventHandler('fuel:takeBank', function(bank, id)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  exports['GHMattiMySQL']:QueryAsync('UPDATE `owned_stations` SET station_bank=@fuel WHERE `id`=@id',{['@fuel'] = 0, ['@id'] = id})
  TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text ="Station Bank Deposited Into Your Account"})
  user.addBank(bank)
  TriggerEvent('fuel:updateStations')
 end)
end)

RegisterServerEvent('fuel:upgradeTank')
AddEventHandler('fuel:upgradeTank', function(fuel, price)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  if (tonumber(user.getMoney()) >= tonumber(price)) then
   user.removeMoney(price)
   TriggerClientEvent('fuel:upgradeTank', source, fuel)
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text ="Fuel Tank Upgraded"})
  end
 end)
end)