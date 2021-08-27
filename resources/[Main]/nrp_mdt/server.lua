local chargeList = ''
local warrantList = ''
local weaponBrass = ''

local warranthook = "https://discordapp.com/api/webhooks/732767906395586571/i5n4tbYVmCl8sHxjXDSPbZ7U0gFP78WaaJ--RUDUqwWZsabwZEjb8iTPcA3PWdSMqcwS"

function DiscordLog(description, color, titlename)
    local connect = {
        {
            ["color"] = color,
            ["title"] = titlename,
            ["description"] = description,
            ["footer"] = {
                ["text"] = "Copyright © 2020 NexusGTA.com",
            },
        }
    }
    PerformHttpRequest(warranthook, function(err, text, headers) end, 'POST', json.encode({username = "LSPD Warrants", embeds = connect}), { ['Content-Type'] = 'application/json' })
end


AddEventHandler('onResourceStart', function(resource)
 if resource == GetCurrentResourceName() then
  local charges = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `mdt_charges` ORDER BY `id` DESC")    
  for i,v in pairs(charges) do
   chargeList = '<div class="newCharge" onclick="addCharge(`'..v.name..'`, '..v.jail..', '..v.fine..')"><p>'..v.name..'<font style="float: right; color: #595959">'..v.jail..' Months | $'..v.fine..' Fine</font></p></div>'..chargeList
  end
  -- Warrant Shit
  local warrants = exports['GHMattiMySQL']:QueryResult("SELECT *, DATE_FORMAT(timestamp, '%T, %d/%m/%y') formatted_date FROM `mdt_warrants` WHERE `expired`=0")    
  for i,v in pairs(warrants) do
   warrantList = '<div class="warrant" onclick="viewWarrant(`'..v.name..'`,`'..v.description..'`,`'..v.knownVehicles..'`,`'..v.charges..'`, `'..v.issued..'`,'..v.id..', `'..v.formatted_date..'`)"><h4>'..v.name..'</h4></div>'..warrantList
  end

  -- Brass Shit
 --[[ local brass = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `mdt_weaponbrass` LIMIT 500")    
  for i,v in pairs(brass) do
   weaponBrass = '<tr><th>'..v.weapon..'</th><td>'..v.serial..'</td><td>'..v.officer..'</td><td>'..v.location..'</td><td>'..v.timestamp..'</td></tr>'..weaponBrass
  end]]
 end
end)

RegisterServerEvent('core:characterloaded')
AddEventHandler('core:characterloaded', function()
 TriggerClientEvent('mdt:initalize', -1, chargeList, warrantList, weaponBrass)
end)

RegisterServerEvent('mdt:newWarrant')
AddEventHandler('mdt:newWarrant', function(data)
 local source = tonumber(source)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  exports['GHMattiMySQL']:QueryAsync('INSERT INTO mdt_warrants (`name`, `charges`, `description`, `knownVehicles`, `issued`) VALUES (@name, @charges, @description, @knownVehicles, @issued)',{['@name'] = data.name, ['@charges'] = data.charges, ['@description'] = data.description, ["@knownVehicles"] = data.vehicles, ["@issued"] = user.getIdentity().fullname})        
  TriggerEvent('mdt:refreshWarrants')
  DiscordLog("Name: **"..data.name.."**\n Description: **"..data.description.."**\n Vehicles: **"..data.vehicles.."**\n Issued by: **"..user.getIdentity().fullname.."**".."\n Posted: **"..os.date("%d/%m/%Y %X").."**".."\n Charges: **"..data.charges.."**", 3447003, "**New Warrant**")
  policeMessage('^5[Police] ^3New Warrant Posted')
 end)
end)

RegisterServerEvent('mdt:deleteWarrant')
AddEventHandler('mdt:deleteWarrant', function(id)
 local source = tonumber(source)
 TriggerEvent("core:getPlayerFromId", source, function(user)
    local deletedwarrant = exports['GHMattiMySQL']:QueryResult("SELECT * FROM mdt_warrants WHERE `id`=@id AND `expired`=0",{['@id'] = id})
    for i,v in pairs(deletedwarrant) do
        DiscordLog("Name: **"..v.name.."**\n Description: **"..v.description.."**\n Vehicles: **"..v.knownVehicles.."**\n Issued by: **"..v.issued.."**".."\n Deleted: **"..os.date("%d/%m/%Y %X").."**".."\n Deleted by: **"..user.getIdentity().fullname.."**\n Charges: **"..v.charges.."**", 15158332, "**Deleted Warrant**")
    end
    exports['GHMattiMySQL']:QueryAsync('UPDATE mdt_warrants SET `expired`=1 WHERE `id`=@id',{['@id'] = id}) 
  TriggerClientEvent("pNotify:SendNotification", source, {text= "Warrant Deleted", timeout = 4000})  
  TriggerEvent('mdt:refreshWarrants')
 end)
end)

RegisterServerEvent('mdt:refreshWarrants')
AddEventHandler('mdt:refreshWarrants', function()
 warrantList = ''
 weaponBrass = ''
 local warrants = exports['GHMattiMySQL']:QueryResult("SELECT *, DATE_FORMAT(timestamp, '%T, %d/%m/%y') formatted_date FROM `mdt_warrants` WHERE `expired`=0")    
 for i,v in pairs(warrants) do
  warrantList = '<div class="warrant" onclick="viewWarrant(`'..v.name..'`,`'..v.description..'`,`'..v.knownVehicles..'`,`'..v.charges..'`, `'..v.issued..'`,'..v.id..', `'..v.formatted_date..'`)"><h4>'..v.name..'</h4></div>'..warrantList
 end
 -- Brass Shit
 --[[local brass = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `mdt_weaponbrass` LIMIT 500")    
 for i,v in pairs(brass) do
  weaponBrass = '<tr><th>'..v.weapon..'</th><td>'..v.serial..'</td><td>'..v.officer..'</td><td>'..v.location..'</td><td>'..v.timestamp..'</td></tr>'..weaponBrass
 end]]
 TriggerClientEvent('mdt:initalize', -1, chargeList, warrantList, weaponBrass)
end)


RegisterServerEvent('mdt:searchNCIC')
AddEventHandler('mdt:searchNCIC', function(searchType, data)
 local source = tonumber(source)
 local characterID = 0
 local searchData = {}
 
 if searchType == 'Person' then 
  local result = exports['GHMattiMySQL']:QueryResult("SELECT id FROM `characters` WHERE firstname=@firstname AND lastname=@lastname",{['@firstname'] = data.firstname, ['@lastname'] = data.lastname}) 
  characterID = result[1].id
  elseif searchType == 'Vehicle' then 
  local result = exports['GHMattiMySQL']:QueryResult("SELECT char_id FROM `dmv_records` WHERE plate=@plate",{['@plate'] = data.plate}) 
   if result[1] then
   characterID = result[1].char_id
   else
   TriggerClientEvent('chatMessage', source, '^5[Police] ^0'..data.plate.." Is Flagged As ^1Stolen")
   end
  elseif searchType == 'License' then 
   if string.match(data.license, "C000") then
   local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `characters` WHERE id=@id",{['@id'] = string.sub(data.license, 5)}) 
   characterID = result[1].id
   else
   local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `characters` WHERE id=@id",{['@id'] = data.license}) 
   characterID = result[1].id
   end 
 end

 -- Caution Codes
 local codeList = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `mdt_tags` WHERE char_id=@id",{['@id'] = characterID}) 
 searchData['cautionCodes'] = ''
 for id,v in pairs(codeList) do 
  if v.name == 1 and v.status == 1 then 
   searchData['cautionCodes'] = '<span class="badge badge-danger">Armed & Dangerious</span> '..searchData['cautionCodes']
  elseif v.name == 2 and v.status == 1 then 
   searchData['cautionCodes'] = '<span class="badge badge-primary">Fleeing Risk</span> '..searchData['cautionCodes']
  elseif v.name == 3 and v.status == 1 then  
   searchData['cautionCodes'] = '<span class="badge badge-warning">Drug Dealer</span> '..searchData['cautionCodes']
  elseif v.name == 4 and v.status == 1 then  
   searchData['cautionCodes'] = '<span class="badge badge-info">Gang Dealer</span> '..searchData['cautionCodes']
  elseif v.name == 5 and v.status == 1 then  
   searchData['cautionCodes'] = '<span class="badge badge-dark">Mental</span> '..searchData['cautionCodes']
  elseif v.name == 6 and v.status == 1 then  
   searchData['cautionCodes'] = '<span class="badge badge-success">Terrorist</span> '..searchData['cautionCodes']
  end
 end

 -- Character Information
 local characters = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `characters` WHERE id=@id",{['@id'] = characterID}) 
 searchData['info'] = {name = characters[1].firstname.." "..characters[1].lastname, gender = characters[1].gender, dob = characters[1].dob, job = getJobName(characters[1].job), license = 'C000'..characters[1].id--[[, number = characters[1].phone_number]]}

 -- Arrest History
 local arrestHistory = exports['GHMattiMySQL']:QueryResult("SELECT *, DATE_FORMAT(timestamp, '%T, %d/%m/%y') formatted_date  FROM `mdt_history` WHERE char_id=@id",{['@id'] = characterID}) 
  searchData['arrest'] = ''
 for id,v in pairs(arrestHistory) do 
  searchData['arrest'] = '<tr><th>'..v.time..'</th><td>$'..v.fine..'</td><td>'..v.charges..'</td><td>'..v.officer..'</td><td>'..v.formatted_date..'</td></tr>'..searchData['arrest']
 end 

 -- Warnings
 local warningsHistory = exports['GHMattiMySQL']:QueryResult("SELECT *, DATE_FORMAT(timestamp, '%T, %d/%m/%y') formatted_date FROM `mdt_warnings` WHERE char_id=@id",{['@id'] = characterID}) 
 searchData['warnings'] = ''
 for id,v in pairs(warningsHistory) do 
  searchData['warnings'] = '<tr><th>'..v.warning..'</th><td>'..v.officer..'</td><td>'..v.formatted_date..'</td></tr>'..searchData['warnings']
 end 


 -- Owned Vehicles
 local vehicleHistory = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `dmv_records` WHERE char_id=@id",{['@id'] = characterID}) 
  searchData['vehicle'] = ''
 for id,v in pairs(vehicleHistory) do 
  if v.insurance == 0 then 
   searchData['vehicle'] = '<tr><th>'..v.plate..'</th><td>Vehicle Un-Insured</td></tr>'..searchData['vehicle']
  elseif tonumber(v.insurance_due) > 0 then
   searchData['vehicle'] = '<tr><th>'..v.plate..'</th><td>Vehicle Un-Insured (Payment Due)</td></tr>'..searchData['vehicle']
  else
   searchData['vehicle'] = '<tr><th>'..v.plate..'</th><td>Vehicle Insured</td></tr>'..searchData['vehicle']
  end
 end 

 -- Owned Weapons
 --[[local weaponHistory = exports['GHMattiMySQL']:QueryResult("SELECT *, DATE_FORMAT(bought, '%T, %d/%m/%y') formatted_date FROM `owned_weapons` WHERE char_id=@id AND blackmarket=0",{['@id'] = characterID}) 
  searchData['weapons'] = ''
 for id,v in pairs(weaponHistory) do 
  searchData['weapons'] = '<tr><th>'..v.label..'</th><td>WSN'..v.id..'</td><td>'..v.formatted_date..'</td></tr>'..searchData['weapons']
 end 
]]--
 -- Owned Housing
 local homesHistory = exports['GHMattiMySQL']:QueryResult("SELECT owned_houses.house_id, owned_houses.rent, owned_houses.rent_due, houses.address FROM `owned_houses` INNER JOIN houses ON houses.id=owned_houses.house_id WHERE owned_houses.char_id=@id",{['@id'] = characterID}) 
 searchData['homes'] = ''
 for id,v in pairs(homesHistory) do 
  searchData['homes'] = '<tr><th>'..v.address..'</th><td>$'..v.rent..'</td><td>$'..v.rent_due..'</td></tr>'..searchData['homes']
 end 

 -- When Finished
 TriggerClientEvent('mdt:ncicData', source, searchData, characterID)
end)

RegisterServerEvent('mdt:newWarning')
AddEventHandler('mdt:newWarning', function(id, warning)
 local targetSource = tonumber(id)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  TriggerEvent("core:getPlayerFromId", targetSource, function(target)
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO mdt_warnings (`char_id`, `warning`, `officer`) VALUES (@char_id, @charges, @officer)',{['@char_id'] = target.getCharacterID(), ['@charges'] = warning, ['@officer'] = user.getIdentity().fullname})        
  end)
 end)
end)

RegisterServerEvent('mdt:updateTags')
AddEventHandler('mdt:updateTags', function(char_id, id, status)
 local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `mdt_tags` WHERE char_id=@char_id AND name=@name",{['@char_id'] = char_id, ['@name'] = id}) 
 if result[1] == nil then 
  exports['GHMattiMySQL']:QueryAsync('INSERT INTO `mdt_tags` (`char_id`, `name`, `status`) VALUES (@char_id, @name, @status)',{['@char_id'] = char_id, ['@name'] = id, ['@status'] = status})        
 else 
  exports['GHMattiMySQL']:QueryAsync('UPDATE `mdt_tags` SET status=@status WHERE char_id=@char_id AND name=@name',{['@char_id'] = char_id, ['@name'] = id, ['@status'] = status})
 end
end)


























function getJobName(id)
 local jobs = {
  [1] = 'Police Chief', 
  [2] = 'EMS',
  [3] = 'Mechanic',
  [4] = 'Taxi Driver',
  [5] = 'Fisherman',
  [6] = 'Post OP',
  [7] = 'Lumberjack',
  [10] = 'Trash Collecter',
  [11] = 'Trucker',
  [13] = 'Lawyer',
  [14] = 'maintenance',
  [15] = 'Car Dealer',
  [16] = 'Reporter',
  [17] = 'Detective',
  [18] = 'Pilot',
  [19] = 'Governor',
  [20] = 'Judge',
  [21] = 'Boat Dealer',
  [22] = 'Burgershot Chef',
  [23] = 'Burgershot Supplier',
  [24] = 'Entrepreneur',
  [25] = 'Police Cadet',
  [26] = 'Patrol Officer',
  [27] = 'Senior Officer',
  [28] = 'Sergeant',
  [29] = 'Lieutenant',
  [30] = 'Captain',
  [31] = 'Deputy Chief',
  [32] = 'Off Duty Mechanic',
  [33] = 'Tuner',
  [34] = 'Off Duty Tuner',
  [35] = 'Croupier',

 }
 return jobs[id] or 'Unknown'
end

function policeMessage(message)
 TriggerEvent('core:getPlayers', function(players)
  for i in pairs(players)do
   if players[i].getJob() == 1 then
    if players[i].isOnDuty() then
     TriggerClientEvent('chatMessage', players[i].get('source'), message)
    end
   end
  end 
 end)
end

function activateMissionSystem()
 local availableMissions = {}

 function ms_setMission(target)
  target = target or -1
  TriggerClientEvent('police:changeMission', target, availableMissions)
 end

 function ms_cancelMission(source)
  TriggerClientEvent('police:cancelMission', source)
 end

 function ms_messageCops(msg)
  TriggerClientEvent('police:notifyallCops', -1, msg)
 end

 function ms_messageCop(source, msg)
  TriggerClientEvent('police:notifyallCops', source, msg)
 end

 function ms_messageClient(source, msg)
  TriggerClientEvent('police:notifyClient', source, msg)
 end

 function ms_addMission(source, position, reason)
  local sMission = availableMissions[source]
  local character = exports['core']:GetActiveCharacter(source)
  if sMission == nil then
   availableMissions[source] = {
    id = source,
    name = character.firstname.." "..character.lastname,
    pos = position,
    acceptBy = {},
    type = reason,
    timestamp = os.date('*t').hour..":"..os.date('*t').min
   }
   ms_messageClient(source, 'Confirmation Your call has been registered')
   ms_messageCops('New Call Received, <br>Caller Information: '..reason)
   ms_setMission()
   TriggerClientEvent('police:updateMissions', -1, availableMissions)
  end
 end

 function ms_closeMission(source, missionId)
  if availableMissions[missionId] ~= nil then
   for _, v in pairs(availableMissions[missionId].acceptBy) do 
    if v ~= source then
     ms_messageCop(v, 'Your customer has canceled')
     ms_cancelMission(v)
    end
   end
   availableMissions[missionId] = nil
   ms_messageClient(missionId, 'Your call has been resolved')
   ms_setMission()
  end
 end

 function ms_acceptMission(source, id)
  local sMission = availableMissions[id]
  ms_exitMission(source)
  if sMission.acceptBy >= 1 then
   if sMission.acceptBy[1] ~= source then
    for _, m in pairs(sMission.acceptBy) do
     ms_messageCop(m, 'there are several units responding')
    end
    local character = exports['core']:GetActiveCharacter(source)
    table.insert(sMission.acceptBy, {source = source, name = character.firstname.." "..character.lastname})
   end
  else
   local character = exports['core']:GetActiveCharacter(source)
   table.insert(sMission.acceptBy, {source = source, name = character.firstname.." "..character.lastname})
   ms_messageClient(sMission.id, 'Your call has been accepted, an Officer is on the way')
  end
  TriggerClientEvent('police:acceptMission', source, availableMissions[id])
  TriggerClientEvent('police:updateMissions', -1, availableMissions)
  ms_setMission()
 end

 function ms_exitMission(personnelId)
  for _, mission in pairs(availableMissions) do 
   for k, v in pairs(mission.acceptBy) do 
    if v == personnelId then
     table.remove(mission.acceptBy, k)
     if #mission.acceptBy == 0 then
      ms_messageClient(mission.id, 'The police have marked your call as finished')
      ms_messageCops('A new alert has been posted, it has been added to your list of missions')
     end
     TriggerClientEvent('police:updateMissions', -1, availableMissions)
     break
    end
   end
  end
 end

 function ms_cancelMissionclient(clientId)
  if availableMissions[clientId] ~= nil then
   for _, v in pairs(availableMissions[clientId].acceptBy) do 
    ms_messageCop(v, 'the call has been canceled')
    ms_cancelMission(v)
   end
   availableMissions[clientId] = nil
   ms_setMission()
  end
 end

 RegisterServerEvent('police:Call')
 AddEventHandler('police:Call',function(posX,posY,posZ,type)
   ms_addMission(source, {posX, posY, posZ}, type)
   TriggerClientEvent('police:updateMissions', -1, availableMissions)
 end)

 RegisterServerEvent('police:CallCancel')
 AddEventHandler('police:CallCancel', function()
  ms_cancelMissionclient(source)
  TriggerClientEvent('police:updateMissions', -1, availableMissions)
 end)

 RegisterServerEvent('police:acceptMission')
 AddEventHandler('police:acceptMission', function(id)
  ms_acceptMission(source, id)
  TriggerClientEvent('police:updateMissions', -1, availableMissions)
 end)

 RegisterServerEvent('police:finishMission')
 AddEventHandler('police:finishMission', function(id)
  ms_closeMission(source, id)
  TriggerClientEvent('police:updateMissions', -1, availableMissions)
 end)

 RegisterServerEvent('police:cancelCall')
 AddEventHandler('police:cancelCall', function()
  ms_cancelMissionclient(source)
  TriggerClientEvent('police:updateMissions', -1, availableMissions)
 end)

 AddEventHandler('playerDropped', function()
  ms_exitMission(source)
  ms_cancelMissionclient(source)
  TriggerClientEvent('police:updateMissions', -1, availableMissions)
 end)
end

activateMissionSystem()


RegisterServerEvent('mdt:newCallReport')
AddEventHandler('mdt:newCallReport', function(data)
 local source = tonumber(source)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  exports['GHMattiMySQL']:QueryAsync('INSERT INTO mdt_incidentReports (`caller`, `info`, `incident`, `officer`) VALUES (@name, @info, @incident, @officer)',{['@name'] = data.name, ['@info'] = data.info, ['@incident'] = data.incident, ["@officer"] = user.getIdentity().fullname})        
  TriggerEvent('mdt:refreshWarrants')
  TriggerClientEvent('chatMessage', source, '^5[Police] ^3New Incident Report Submitted')
 end)
end)