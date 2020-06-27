RegisterServerEvent("importdealership:buy")
AddEventHandler("importdealership:buy",function(data, price, model, carid)
 if model ~= 'CARNOTFOUND' then 
  local source = tonumber(source)
  TriggerEvent('core:getPlayerFromId', source, function(user)
    if (tonumber(user.getMoney()) >= Config.cars[carid].price) then
       addVehicle(source, data, price, model)
       user.removeMoney(price)
       TriggerEvent("core:moneylog", source, 'Vehicle Bought: $'..price.." > "..model)
    elseif (tonumber(user.getBank()) >= Config.cars[carid].price) then
        addVehicle(source, data, price, model)
        user.removeBank(price)
        TriggerEvent("core:moneylog", source, 'Vehicle Bought: $'..price.." > "..model)
    else
     TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Insufficient Funds"}) 
    end
  end)
 end
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
      local character = user.getIdentity()
      user.addVehicle(data, price, model)
      local insurance = price*0.2
      Wait(100)
      exports['GHMattiMySQL']:QueryAsync('INSERT INTO `dmv_records` (char_id, owner, plate) VALUES (@charid, @owner, @plate)',{['@charid'] = user.getCharacterID(), ['@owner'] = character.firstname.." "..character.lastname, ['@plate'] = data.plate})
      TriggerClientEvent("importdealership:bought", sourcePlayer, data, plate)
      TriggerClientEvent('NRP-notify:client:SendAlert', sourcePlayer, { type = 'inform', text ="Vehicle Purchased"}) 
    else
      addVehicle(sourcePlayer)
    end
  end)
end