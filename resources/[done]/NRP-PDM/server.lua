    RegisterServerEvent("carshop:buy")
AddEventHandler("carshop:buy",function(data, price, model, menu, currentOption)
 if model ~= 'CARNOTFOUND' then 
  local source = tonumber(source)
  TriggerEvent('core:getPlayerFromId', source, function(user)
    if (tonumber(user.getMoney()) >= tonumber(price)) and tonumber(price) >= 1000 then
      if tonumber(price) == math.floor(vehicles[menu][currentOption].price*exports['core']:getVat(2)) then 
       addVehicle(source, data, price, model)
       user.removeMoney(price)
       TriggerEvent("core:moneylog", source, 'Vehicle Bought: $'..price.." > "..model)
      else   --- CHANGE ME
      PerformHttpRequest("https://discordapp.com/api/webhooks/713836428303401020/GEGZ47vplwxhs9QlTxKIY2X6v85PAxkMUyQIQ46MMVK6Qw8XzbK8gZcVm5XlyKEvT4xP", function(Error, Content, Head) end, 'POST', json.encode({username = SystemName, content = "@everyone ```"..GetPlayerName(source).." Is Attempting To Use Cheat Engine At Simeons, His Price: "..price.." | Our Price: "..math.floor(vehicles[menu][currentOption].price*exports['core']:getVat(2)).."```\n", avatar_url = SystemAvatar}), {['Content-Type'] = 'application/json'})
      end
    elseif (tonumber(user.getBank()) >= tonumber(price)) and tonumber(price) >= 1000 then
      if tonumber(price) == math.floor(vehicles[menu][currentOption].price*exports['core']:getVat(2)) then 
        addVehicle(source, data, price, model)
        user.removeBank(price)
        TriggerEvent("core:moneylog", source, 'Vehicle Bought: $'..price.." > "..model)
       else   --- CHANGE ME
       PerformHttpRequest("https://discordapp.com/api/webhooks/713836428303401020/GEGZ47vplwxhs9QlTxKIY2X6v85PAxkMUyQIQ46MMVK6Qw8XzbK8gZcVm5XlyKEvT4xP", function(Error, Content, Head) end, 'POST', json.encode({username = SystemName, content = "@everyone ```"..GetPlayerName(source).." Is Attempting To Use Cheat Engine At Simeons, His Price: "..price.." | Our Price: "..math.floor(vehicles[menu][currentOption].price*exports['core']:getVat(2)).."```\n", avatar_url = SystemAvatar}), {['Content-Type'] = 'application/json'})
       end
    else
     TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Insufficient Funds"}) 
    end
  end)
 end
end)

  
--[[function addVehicle(sourcePlayer, data, price, model)
  TriggerEvent('core:getPlayerFromId', sourcePlayer, function(user)
    local plate = 0
    local randomNum = math.random(111,999)
    if randomNum < 10 then
      plate = "FL"..user.getCharacterID().." "..randomNum
    else
      plate = "FL"..user.getCharacterID().." "..randomNum
    end
    local result = user.getVehicle(plate)
    if result == nil then
      data.plate = plate
      local character = exports['core']:GetActiveCharacter(sourcePlayer)
      user.addVehicle(data, price, model)
      exports['GHMattiMySQL']:QueryAsync('INSERT INTO `dmv_records` (char_id, owner, plate) VALUES (@charid, @owner, @plate)',{['@charid'] = user.getCharacterID(), ['@owner'] = character.firstname.." "..character.lastname, ['@plate'] = data.plate})
      TriggerClientEvent("carshop:bought", sourcePlayer, data, plate)
      TriggerClientEvent("pNotify:SendNotification", sourcePlayer, {text= "Vehicle Purchased"}) 
    else
      addVehicle(sourcePlayer)
    end
  end)
end
]]--
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
    local character = user.getIdentity()
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
 