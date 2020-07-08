local carsReset = {}

RegisterServerEvent("core:characterloaded")
AddEventHandler("core:characterloaded", function()
 local source = tonumber(source)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  local garage = user.getGarages()
  local vehicles = user.getVehicles()
  local insured = {}
  local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `dmv_records` WHERE char_id=@id",{['@id'] = user.getCharacterID()})
  for _,v in pairs(result) do 
   insured[v.plate] = {insurance = v.insurance, insurance_due = v.insurance_due}
  end
  user.setAllVehicleState(true)
 end)
end)

AddEventHandler("garage:update", function(source)
 local source = tonumber(source)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  local garage = user.getGarages()
  local vehicles = user.getVehicles()
  local insured = {}
  local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `dmv_records` WHERE char_id=@id",{['@id'] = user.getCharacterID()})
  for _,v in pairs(result) do 
   insured[v.plate] = {insurance = v.insurance, insurance_due = v.insurance_due}
  end
  TriggerClientEvent('garage:refresh', source, vehicles, garage, insured)
 end)
end)


TriggerEvent('core:addGroupCommand', 'carreset', "helper", function(source, args, user)
 local target = tonumber(args[2])
 TriggerEvent("core:getPlayerFromId", target, function(user)
  user.setAllVehicleState(true)
  GNotify(source, 'Vehicle Reset Successful')
 end)
end)

RegisterServerEvent("garage:store")
AddEventHandler("garage:store", function(components, garage, fuel, price)
 local source = source
 TriggerEvent("core:getPlayerFromId", source, function(user)
  user.storeVehicle(components.plate, components, fuel, garage)
  user.removeBank(price)
 end)
end)

RegisterServerEvent("garage:out")
AddEventHandler("garage:out", function(data)
 local source = source
 TriggerEvent("core:getPlayerFromId", source, function(user)
  user.setVehicleOut(data.plate)
 end)
end)

RegisterServerEvent("garage:buy")
AddEventHandler("garage:buy", function(cost, id, slots)
    local source = tonumber(source)
    TriggerEvent("core:getPlayerFromId", source, function(user)
        if(user.getMoney() >= tonumber(cost))then
            user.addGarage(id,slots,cost)
            user.removeMoney(cost)
            GNotify(source,"Garage purchased!")
        else
            GNotify(source,"Insufficient funds!")
        end
    end)
end)

RegisterServerEvent("garage:repair")
AddEventHandler("garage:repair", function(cost)
    local source = tonumber(source)
    TriggerEvent("core:getPlayerFromId", source, function(user)
        if(user.getMoney() >= tonumber(cost))then
            user.removeMoney(cost)
            TriggerClientEvent('garage:store', source)
            GNotify(source,"Vehicle Repaired")
        else
            GNotify(source,"Insufficient funds!")
        end
    end)
end)

RegisterServerEvent("garage:buyslots")
AddEventHandler("garage:buyslots",function(cost, id, slots)
    local source = tonumber(source)
    TriggerEvent("core:getPlayerFromId", source, function(user)
        if(user.getMoney() >= tonumber(cost))then
            user.addGarage(id,slots,cost)
            user.removeMoney(cost)
            TriggerEvent("core:moneylog", source, 'Garage Payment: $'..cost)
            GNotify(source,"Garage slots purchased!")
            TriggerClientEvent("garage:buy", source)
        else
            GNotify(source,"Insufficient funds!")
        end
    end)
end)

RegisterServerEvent("garage:sellgarage")
AddEventHandler("garage:sellgarage", function(gid)
    local source = tonumber(source)
    TriggerEvent("core:getPlayerFromId", source, function(user)
        local data = user.getGarages()
        for i = 1, #data do 
            if data[i].id == gid then
                user.addMoney(data[i].cost)
                TriggerEvent("core:moneylog", source, 'Garage Sold: $'..data[i].cost)
                GNotify(source,"Garage Sold, $"..data[i].cost)
            end
        end
        user.removeGarage(gid)
    end)
end)

RegisterServerEvent("garage:transfer")
AddEventHandler("garage:transfer",function(plate, gid)
 local source = tonumber(source)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  user.setGarage(plate,gid)
  GNotify(source,"Vehicle Transferred")
 end)
end)

RegisterServerEvent("garage:insure")
AddEventHandler("garage:insure", function(plate, price)
 local source = tonumber(source)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  if user.getMoney() >= price then
   user.removeMoney(price)
   user.setVehicleInsurance(plate, true)
   GNotify(source,"Vehicle Plate: "..plate.." Now Insured") 
   TriggerEvent("core:moneylog", source, 'Insurance Payment: $'..price)
   exports['GHMattiMySQL']:QueryAsync('UPDATE `dmv_records` SET insurance=@value WHERE plate=@id',{['@value'] = price, ['@id'] = plate})
  else
   GNotify(source,"Insufficient Funds") 
  end
 end)
end)

function GNotify(source,message)
 TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = message})
end


RegisterServerEvent("garage:transfervehicle")
AddEventHandler("garage:transfervehicle", function(player, plate)  --- use this to transfer houses
 local source = tonumber(source)
 local player = tonumber(player)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  TriggerEvent("core:getPlayerFromId", player, function(target)
   local vehicle = user.getVehicle(plate)
   target.addVehicle(vehicle.components, vehicle.price, vehicle.model)
   user.removeVehicle(plate)
   exports['GHMattiMySQL']:QueryAsync("DELETE FROM `dmv_records` WHERE plate=@plate", {['@plate'] = plate})
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `dmv_records` (char_id, owner, plate) VALUES (@charid, @owner, @plate)',{['@charid'] = target.getCharacterID(), ['@owner'] = target.getIdentity().fullname, ['@plate'] = plate})
   --GNotify(source, 'Vehicle Transfer Successful, Tell The Target To Store The Vehicle To Enable Locking')
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = 'Vehicle Transfer Successful, Tell The Target To Store The Vehicle To Enable Locking'})
  end)
 end)
end)

RegisterServerEvent('garagepayment:removemoney')
AddEventHandler('garagepayment:removemoney', function(cost)
 local sourcePlayer = tonumber(source)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  if user.getMoney() >= cost then
   user.removeMoney(cost)
   user.setAllVehicleState(true)
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Cars Retrieved"})
   TriggerEvent("core:moneylog", source, "Paid For DMV To Retrieve Vehicles")
  elseif user.getBank() >= cost then
   user.removeBank(cost)
   user.setAllVehicleState(true)
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Cars Retrieved"})
   TriggerEvent("core:moneylog", source, "Paid For DMV To Retrieve Vehicles")
  else
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Not Enough Money"})
  end
 end)
end)
