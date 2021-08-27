
local generated = false

local cars = {
    {name="Rolls Royce Phantom",model="rrphantom",price=500000},
    --{name="BMW i8",model="i8",price=1000000},
    {name="BMW X6M",model="x6m",price=500000},
    {name="1969 Mustang",model="boss302",price=325000},
    {name="Mercedes c63",model="rmodamgc63",price=425000},
    {name="2013 Audi RS7",model="2013rs7",price=375000},
    {name="Audi A6",model="a6",price=350000},
    {name="Toyota Supra",model="a80",price=250000},
    {name="Mercedes e400",model="e400",price=365000},
    {name="BMW M4",model="f82",price=400000},
    {name="Honda Civic Type-R",model="fk8",price=275000},
    {name="Volkswagen Golf",model="golfp",price=400000},
    {name="Honda CBR 1000RR",model="hcbr17",price=250000},
    --{name="Mitsubishi Lancer Evolution X",model="lanex400",price=300000},
    {name="BMW M3",model="m3e30",price=275000},
    {name="Ford Mustang GT",model="mgt",price=400000},
    {name="Honda Civic EK9",model="EK9",price=275000},
    {name="Mazda MX5",model="mxpan",price=300000},
    {name="Honda NSX",model="na1",price=300000},
    {name="Tesla Model X",model="teslax",price=500000},
    {name="Renault Twizy",model="twizy",price=75000},
    {name="Lamborghini Urus",model="urus",price=500000},
    {name="Nissan z32",model="z32",price=275000},
    {name="BMW z48",model="z48",price=250000},
    {name="BMW s1000rr",model="s1000rr",price=250000},
    {name="Subaru STI",model="subisti08",price=300000},
    {name="Range Rover Velar",model="velar",price=500000},
    {name="Nissan Silvia S15",model="s15",price=300000},
    {name="Bentley Continental GT",model="contss18",price=400000},
    {name="Slingshot",model="slingshot",price=200000},
    --{name="Porsche RUF RGT-8 GT3",model="pruf",price=700000},
    --{name="McClaren 720s",model="720s",price=950000},
    --{name="Ford GT",model="gt17",price=900000},
    --{name="Lamborghini Aventador",model="lp700",price=950000},
    --{name="Corvette C8",model="c8",price=600000},
    {name="BMW z4 Alchemist",model="z4alchemist",price=350000},
    {name="Bentley Bentayga",model="bentaygam",price=500000},
}

local chosen = {}

function GetVehicles() 
  if not generated then
      for i=1,5  do
        local num = math.random(1, #cars)
        local choice = cars[num]
        table.remove(cars, num)
        table.insert(chosen, choice)
      end
      generated = true
  end
end


RegisterServerEvent('garage:imports')
AddEventHandler('garage:imports', function()
  if not generated then
    GetVehicles()
  end
  Wait(150)
  TriggerClientEvent('g:imports', -1, chosen)
end)


RegisterServerEvent("importdealership:buy")
AddEventHandler("importdealership:buy",function(data, price, model, carid)
 if model ~= 'CARNOTFOUND' then 
  local source = tonumber(source)
  TriggerEvent('core:getPlayerFromId', source, function(user)
    if (tonumber(user.getMoney()) >= price) then
       addVehicle(source, data, price, model)
       user.removeMoney(price)
       TriggerEvent("core:moneylog", source, 'Vehicle Bought: $'..price.." > "..model)
    elseif (tonumber(user.getBank()) >= price) then
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