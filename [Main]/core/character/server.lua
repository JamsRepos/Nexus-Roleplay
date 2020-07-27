SetGameType('Nexus Roleplay')
SetMapName('Los Santos')
local characters = {}

RegisterServerEvent("core:getCharacters")
AddEventHandler("core:getCharacters", function()
 local source = tonumber(source)
 local character = {}
 local user = exports['GHMattiMySQL']:QueryResult("SELECT * FROM users WHERE identifier = @id", {['@id'] = GetPlayerIdentifier(source)})
 local current_chars = exports['GHMattiMySQL']:QueryResult("SELECT * FROM characters WHERE identifier = @identifier AND isDeleted = 0", {['@identifier'] = GetPlayerIdentifier(source)})
 for a = 1, #current_chars do
  character[a] = {
   id=current_chars[a].id,
   name = current_chars[a].firstname.." "..current_chars[a].lastname,
   firstname=current_chars[a].firstname,
   lastname=current_chars[a].lastname,
   dob=current_chars[a].dob,
   gender=current_chars[a].gender,
   cash=current_chars[a].money,
   bank=current_chars[a].bank,
   --dirtybank=current_chars[a].dirtybank, ---- test
   position=current_chars[a].position,
   jailtime=current_chars[a].jail,
   playtime=current_chars[a].playtime,
   dirty_money=current_chars[a].dirty_money,
  }
 end
 TriggerClientEvent("core:characterscreen", source, character, user[1].permission_level) 
end)

RegisterServerEvent("core:refreshcharacters")
AddEventHandler("core:refreshcharacters", function(src)
 local source = tonumber(src)
 local character = {}
 local user = exports['GHMattiMySQL']:QueryResult("SELECT * FROM users WHERE identifier = @id", {['@id'] = GetPlayerIdentifier(source)})
 local current_chars = exports['GHMattiMySQL']:QueryResult("SELECT * FROM characters WHERE identifier = @identifier AND isDeleted = 0", {['@identifier'] = GetPlayerIdentifier(source)})
 for a = 1, #current_chars do
  character[a] = {
   id=current_chars[a].id,
   name = current_chars[a].firstname.." "..current_chars[a].lastname,
   firstname=current_chars[a].firstname,
   lastname=current_chars[a].lastname,
   dob=current_chars[a].dob,
   gender=current_chars[a].gender,
   cash=current_chars[a].money,
   bank=current_chars[a].bank,
   --dirtybank=current_chars[a].dirtybank,       --- TESTING
   position=current_chars[a].position,
   jailtime=current_chars[a].jail,
   playtime=current_chars[a].playtime,
   --dirty_money=current_chars[a].dirty_money ---- TESTING
  }
 end
 TriggerClientEvent("core:characterscreen", source, character, user[1].permission_level) 
end)

RegisterServerEvent("core:createcharacter")
AddEventHandler("core:createcharacter", function(data)
 local source = tonumber(source)
 --TriggerEvent("core:getCharacters")
 exports['GHMattiMySQL']:QueryAsync("INSERT INTO characters (`identifier`,`firstname`,`lastname`, `dob`, `gender`, `inventory`, `vehicles`, `garages`, `position`, `tattoos`, `phone_number`) VALUES (@identifier, @firstname, @lastname, @dob, @gender, @inventory, @vehicles, @garages, @position, @tattoos, @phone_number)", {
  ['@identifier'] = GetPlayerIdentifier(source),
  ['@firstname'] = data.firstname,
  ['@lastname'] = data.lastname,
  ['@dob'] = data.dob,
  ['@gender'] = data.gender,
  ['@inventory'] = json.encode({}),
  ['@vehicles'] = json.encode({}),
  ['@garages'] = json.encode({{id=1,cost=0,count=1},{id=2,cost=0,count=1},{id=3,cost=0,count=1},{id=4,cost=0,count=1},{id=5,cost=0,count=1},{id=6,cost=0,count=1}}),
  ['@position'] = json.encode({x = -220.744, y = -1053.473, z = 29.540}),
  ['@tattoos'] = json.encode({}),
  ['@phone_number'] = GenerateUniquePhoneNumber()
 }, function(results)
  TriggerEvent("core:refreshcharacters", source)
 end)
end)

RegisterServerEvent("core:deletecharacter")
AddEventHandler("core:deletecharacter",function(id)
 local source = tonumber(source)
 exports['GHMattiMySQL']:QueryAsync("UPDATE `characters` SET `isDeleted` = 1 WHERE id = @id", {['@id'] = id})
 TriggerEvent("core:refreshcharacters", source)
end)

RegisterServerEvent("core:loadcharacter")
AddEventHandler("core:loadcharacter", function(data)
 local source = tonumber(source)
 characters[GetPlayerIdentifier(source)] = {char_id = data.id, firstname = data.firstname, lastname = data.lastname, dob = data.dob, gender = data.gender}
 TriggerEvent('core:loadplayer', source)
 TriggerClientEvent('core:spawncharacter', source, json.decode(data.position))
 TriggerEvent('skin:firstload', source)
 TriggerEvent('points:load', source)
 TriggerEvent('weaponstores:load', source)
 TriggerEvent('garage:update', source)
 --TriggerEvent('core:serverPasswordInitialize', source)
 Wait(1000)
 TriggerEvent('stats:load', source)
 TriggerEvent('timers:load', source)
end)
--[[
RegisterServerEvent('core:newcharacter')
AddEventHandler('core:newcharacter', function()
    local source = tonumber(source)
    TriggerEvent("core:getPlayerFromId", source, function(user)
        if user.getPlaytime() <= 10 then
            TriggerClientEvent('core:starttutorial', source, false)
        end
    end)
end)
--]]
function GetActiveCharacterID(source)
 local identifier = GetPlayerIdentifier(source)
 return characters[identifier].char_id   
end

function GetActiveCharacter(source)
 local identifier = GetPlayerIdentifier(source)
 return characters[identifier]   
end

function getPlayerFromId(source)
    local identifier = GetPlayerIdentifier(source)
    return characters[identifier].char_id   
end

function GetCharacterID(identifier)
 if identifier ~= nil then
  return characters[identifier].char_id
 end
end

RegisterServerEvent('core:updateposition')
AddEventHandler('core:updateposition', function(x,y,z)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  user.setCoords(x, y, z)
 end)
end)

RegisterServerEvent('core:updateVitals')
AddEventHandler('core:updateVitals', function(data)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  user.setVital('Health', 100)
  user.setVital('Armour', 0)
  user.setVital('Hunger', 100)
  user.setVital('Thirst', 100)
 end)
end)

-------------------------------------------------------------------
------------------------- Other Shit ------------------------------
-------------------------------------------------------------------
RegisterServerEvent('clothes:save')
AddEventHandler('clothes:save', function(data)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  local outfit = json.encode(data)
  user.setOutfit(outfit)
 end)
end)

RegisterServerEvent('skin:save')
AddEventHandler('skin:save', function(data)
 local source = tonumber(source)
 local skin = json.encode(data)
 exports['GHMattiMySQL']:QueryAsync("UPDATE `characters` SET `skin` = @skin WHERE identifier = @identifier AND id = @id", {['@identifier'] = GetPlayerIdentifier(source), ['@id'] = GetActiveCharacterID(source), ['@skin'] = skin})
end)

RegisterServerEvent('barber:save')
AddEventHandler('barber:save', function(skin)
 exports['GHMattiMySQL']:QueryAsync("UPDATE `characters` SET skin=@skin WHERE id=@id",{['@skin'] = skin, ['@id'] = GetActiveCharacterID(source)})
end)

TriggerEvent('core:addCommand', 'clothes', function(source, args, user)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  local outfit = json.decode(user.getOutfit())
  if outfit ~= nil then
   TriggerClientEvent('clothes:load', source, outfit)
  end
 end)
end)

RegisterServerEvent('clothes:firstload')
AddEventHandler('clothes:firstload', function()
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  local outfit = user.getOutfit()
  if outfit ~= {} and outfit ~= nil then
   TriggerClientEvent('clothes:load', source, json.decode(outfit))
  end
  TriggerClientEvent('weapons:updateback', source)
 end)
end)

RegisterServerEvent('skin:firstload')
AddEventHandler('skin:firstload', function(source)
 local source = tonumber(source)
 local skin = exports['GHMattiMySQL']:QueryResult("SELECT * FROM characters WHERE id = @id", {['@id'] = GetActiveCharacterID(source)})
 if skin[1].skin then
    
  TriggerClientEvent('skin:load', source, json.decode(skin[1].skin))
  TriggerClientEvent('barbers:getcharvairibles', source, json.decode(skin[1].skin))
  TriggerClientEvent('core:locationMenu', source)
 else
  TriggerClientEvent('skin:noskin', source, gender)
 end
end)

RegisterServerEvent('skin:load')
AddEventHandler('skin:load', function()
 local source = tonumber(source)
 local skin = exports['GHMattiMySQL']:QueryResult("SELECT * FROM characters WHERE id = @id", {['@id'] = GetActiveCharacterID(source)})
 if skin[1].skin then
  TriggerClientEvent('skin:load', source, json.decode(skin[1].skin))
  TriggerClientEvent('barbers:getcharvairibles', source, json.decode(skin[1].skin))
 end
end)

--[[RegisterServerEvent("carshop:buy")
AddEventHandler("carshop:buy",function(data, price, model)
 local source = tonumber(source)
 if tonumber(price) <= 990 then
  StaffMessage("User ID: ^3"..source.." ^0may currently be abusing a car payment glitch. Please check money logs.")
 end
 TriggerEvent('core:getPlayerFromId', source, function(user)
  if (tonumber(user.getMoney()) >= tonumber(price)) then
   addVehicle(source, data, price, model)
   user.removeMoney(price)
   TriggerEvent("core:moneylog", source, 'Vehicle Bought: $'..price.." > "..model)
  else
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Insufficient Funds"}) 
  end
 end)
end)]]--

function StaffMessage(message)
 TriggerEvent("core:getPlayers", function(pl)
  for k,v in pairs(pl) do
   TriggerEvent("core:getPlayerFromId", k, function(user)
    if(user.getPermissions() > 50)then
     if user.isAdminEnabled() then
      TriggerClientEvent('chatMessage', k, "SYSTEM", {255, 0, 0}, tostring(message))
     end
    end
   end)
  end
 end)
end

function GenerateUniquePhoneNumber()
    local foundNumber = false
    local phoneNumber = nil
    while not foundNumber do
        phoneNumber = math.random(1111111,9999999)
        local result = exports['GHMattiMySQL']:QueryResult('SELECT COUNT(*) as count FROM characters WHERE phone_number = @phoneNumber',{['@phoneNumber'] = phoneNumber})
        local count  = tonumber(result[1].count)

        if count == 0 then
            foundNumber = true
        end
    end
    return phoneNumber
end

RegisterServerEvent('core:giveweapons')
AddEventHandler('core:giveweapons', function()
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)  
  local weapons = user.getWeapons()
  for i = 1, #weapons do
   if weapons[i] ~= nil then
    TriggerClientEvent('core:addweapon', source, weapons[i].name)
   end
  end 
  TriggerClientEvent('weapon:updateitems', source, user.getWeapons())
 end)
end)

RegisterServerEvent('player:dmvl')
AddEventHandler('player:dmvl', function()
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM dmv_users WHERE `char_id` = @char_id", {['@char_id'] = user.getCharacterID()}, function(character)
   if character[1] then
    local fullname = character[1].name
    local address = character[1].address
    local points = character[1].points
    local reg = character[1].registered
    TriggerClientEvent('player:showdmv', -1, source, fullname, address, points, reg)
   else
    TriggerClientEvent('chatMessage', source, "THE LAW", {66, 134, 244}, "You do not have a Drivers License, You can get one of these at the Simeons Dealership.")
   end
  end)
 end)
end)

RegisterServerEvent('player:gunL')
AddEventHandler('player:gunL', function()
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM gun_license WHERE `char_id` = @char_id", {['@char_id'] = user.getCharacterID()}, function(character)
    if character[1] then
     local fullname = character[1].fullname
     local reg = character[1].reg
     local appointed = character[1].given
     TriggerClientEvent('player:gunlicense', -1, source, fullname, reg, appointed)
    else
     TriggerClientEvent('chatMessage', source, "THE LAW", {66, 134, 244}, "You do not have a Gun License, You can get one from the City Hall.")
    end
  end)
 end)
end)