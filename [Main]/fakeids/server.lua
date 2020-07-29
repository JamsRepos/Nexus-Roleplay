RegisterServerEvent("fakeids:create")
AddEventHandler("fakeids:create",function(newname, newjob, newdob, newgender)
  local source = tonumber(source)
  TriggerEvent('core:getPlayerFromId', source, function(user)
  if user.getMoney() >= 20000 then 
    user.removeMoney(20000)
    print(source.." "..newname.." "..newjob.." "..newdob)
    exports['GHMattiMySQL']:QueryAsync('INSERT INTO `fakeids` (char_id, newname, newjob, newdob, gender) VALUES (@char_id, @newname, @newjob, @newdob, @gender)',{['@char_id'] = user.getCharacterID(), ['@newname'] = newname, ['@newjob'] = newjob, ['@newdob'] = newdob, ['@gender'] = newgender})
    TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "New Fake Identity Purchased and Registered"}) 
  else
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Insufficient Funds in Bank"}) 
  end
 end)
end)

RegisterServerEvent('fakeids:giveid')
AddEventHandler('fakeids:giveid', function(id)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM fakeids WHERE `id` = @id", {['@id'] = id}, function(fakeid)
   local fullname = fakeid[1].newname
   local gender = user.getIdentity().gender
   local dob = fakeid[1].newdob
   local job = fakeid[1].newjob
  TriggerClientEvent("fs_freemode:notify", source, 'CHAR_BLANK_ENTRY', 4, 2, "ID Card", false, 'Name: '..fullname..'~n~ DOB: '..dob..'~n~Gender: '..gender..'~n~Job: '..job) 
  end)
 end)
end)

RegisterServerEvent('fakeids:deletesingleid')
AddEventHandler('fakeids:shareid', function(id)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  exports['GHMattiMySQL']:QueryResultAsync("DELETE FROM fakeids WHERE `id` = @id", {['@id'] = id}, function(fakeid)
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "You have given the ID Card!"})
  end)
 end)
end)

RegisterServerEvent('fakeids:allids')
AddEventHandler('fakeids:allids', function(id)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM fakeids WHERE `char_id` = @char_id", {['@char_id'] = user.getCharacterID()}, function(character)
    TriggerClientEvent('fakeids:refresh', source, character)
  end)
 end)
end)

RegisterServerEvent('fakeids:police')
AddEventHandler('fakeids:police', function(t)
 local source = tonumber(source)
 local target = tonumber(t)
 TriggerEvent('core:getPlayerFromId', target, function(user)
  exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM fakeids WHERE `char_id` = @char_id", {['@char_id'] = user.getCharacterID()}, function(character)
    TriggerClientEvent('fakeids:polrefresh', source, character, t)
  end)
 end)
end)

RegisterServerEvent('fakeids:confiscate')
AddEventHandler('fakeids:confiscate', function(policeTarget)
 local source = tonumber(source)
 local target = tonumber(policeTarget)
 TriggerEvent('core:getPlayerFromId', target, function(user)
  exports['GHMattiMySQL']:QueryResultAsync("DELETE FROM fakeids WHERE `char_id` = @char_id", {['@char_id'] = user.getCharacterID()}, function(character)
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "All Fake Identification Has Been Confiscated!"})
   TriggerClientEvent('NRP-notify:client:SendAlert', target, { type = 'inform', text = "Your fake Identifications have been Confiscated!"})
  end)
 end)
end)

RegisterServerEvent('fakeids:showid')
AddEventHandler('fakeids:showid', function(id, newname, gender, newdob, newjob)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  local fullname = newname
  local gender = gender
  local dob = newdob
  local job = newjob
  TriggerClientEvent('player:showid', -1, source, fullname, gender, dob, job)
 end)
end)