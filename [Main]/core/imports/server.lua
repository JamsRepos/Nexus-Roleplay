--[[RegisterServerEvent("carshop:buy")
AddEventHandler("carshop:buy",function(data, price, model)
 local source = tonumber(source)
 if tonumber(price) <= 500 then
  StaffMessage("User ID: ^3"..source.." ^0may currently be abusing a car payment glitch. Please check money logs.")
 end
 TriggerEvent('core:getPlayerFromId', source, function(user)
  if (tonumber(user.getMoney()) >= tonumber(price)) then
   addVehicle(source, data, price, model)
   user.removeMoney(price)
   Wait(100)
   TriggerEvent("core:moneylog", source, 'Vehicle Bought: $'..price.." > "..model)
  else
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Insufficient Funds"}) 
  end
 end)
end)]]--

RegisterServerEvent("carshop:buy")
AddEventHandler("carshop:buy",function(data, price, model)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
 local identity = user.getIdentity()
 if tonumber(price) <= 999 then
  StaffMessage("User ID: ^3"..source.." ^0 is currently abusing a car payment glitch. Please check money logs.")
  TriggerEvent("core:moneylog", source, 'abusing a car payment glitch ,Vehicle Exploiter: $'..price.." > "..model.." Character Number :"..user.getPhoneNumber())
 end
  if (tonumber(user.getMoney()) >= tonumber(price)) and tonumber(price) >= 1000 then
    addVehicle(source, data, price, model)
    user.removeMoney(price)
    Wait(1000)
    TriggerEvent("core:moneylog", source, 'Vehicle Bought: $'..price.." > "..model)
  elseif tonumber(price) <= 999 then
    StaffMessage("User ID: ^3"..source.." ^0 is currently abusing a car payment glitch. Please check money logs.")
    TriggerEvent("core:moneylog", source, 'is abusing a car payment glitch , Vehicle Exploiter: $'..price.." > "..model.." Character Number : "..user.getPhoneNumber())
    TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Admins Have Been Notified Enjoy your ban"})
  else
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Insufficient Funds"}) 
  end
 end)
end)


local function randomString(stringLength)
    local chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
    local length = stringLength
    local randomString = ''
    math.randomseed(os.time())
    charTable = {}
    for c in chars:gmatch"." do
        table.insert(charTable, c)
    end
    for i = 1, length do
        randomString = randomString .. charTable[math.random(1, #charTable)]
    end
    return(randomString)
end
  
function addVehicle(sourcePlayer, data, price, model)
    TriggerEvent('core:getPlayerFromId', sourcePlayer, function(user)
    local plate = randomString(8)
    print(plate)
    local result = user.getVehicle(plate)
    if result == nil then
      data.plate = plate
      local character = GetActiveCharacter(sourcePlayer)
      user.addVehicle(data, price, model)
      local insurance = price*0.2
      Wait(100)
      exports['GHMattiMySQL']:QueryAsync('INSERT INTO `dmv_records` (char_id, owner, plate) VALUES (@charid, @owner, @plate)',{['@charid'] = user.getCharacterID(), ['@owner'] = character.firstname.." "..character.lastname, ['@plate'] = data.plate})
      TriggerClientEvent("carshop:bought", sourcePlayer, data, plate)
      TriggerClientEvent('NRP-notify:client:SendAlert', sourcePlayer, { type = 'inform', text ="Vehicle Purchased"}) 
    else
      addVehicle(sourcePlayer)
    end
  end)
end


RegisterServerEvent('carshop:sell')
AddEventHandler('carshop:sell', function(plate)
  local source = tonumber(source)
  TriggerEvent('core:getPlayerFromId', source, function(user)
    if user.isVehicleOwner(plate) then 
     local vehicle = user.getVehicle(plate)
     local price = vehicle.price
     local pay = price/2
     TriggerEvent("core:moneylog", source, 'Vehicle Sold Payment: $'..pay)
     user.removeVehicle(plate)
     exports['GHMattiMySQL']:QueryAsync("DELETE FROM `dmv_records` WHERE plate=@plate", {['@plate'] = plate})
     TriggerClientEvent('vehstore:delete', tonumber(source))
     TriggerClientEvent('NRP-notify:client:SendAlert', tonumber(source), { type = 'success', text ="You Sold Your Vehicle For $"..pay})
     user.addMoney(tonumber(pay))
    else
     TriggerClientEvent('NRP-notify:client:SendAlert', tonumber(source), { type = 'error', text ="This Vehicle Does Not Belong To You!"}) 
    end
  end)
end)
 

