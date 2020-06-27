TriggerEvent('core:addGroupCommand', 'grantgun', "user", function(source, args, user)
  local source = tonumber(source)
  local player = tonumber(args[2])
  TriggerEvent("core:getPlayerFromId", source, function(user)
   if user.getJob() == 25 or user.getJob() == 13 then
    TriggerEvent("core:getPlayerFromId", player, function(target)
     exports['GHMattiMySQL']:QueryAsync('INSERT INTO `gun_license` (char_id, fullname, reg, given) VALUES (@char_id, @fullname, @reg, @given)',{['@char_id'] = target.getCharacterID(), ['@fullname'] = target.getIdentity().fullname, ['@reg'] = args[3], ['@given'] = user.getIdentity().fullname})
     TriggerClientEvent('chatMessage', player, "THE LAW", {66, 134, 244}, "You have been granted a Gun License by: "..user.getIdentity().fullname)
     TriggerClientEvent('chatMessage', source, "THE LAW", {66, 134, 244}, "You have granted a Gun License to: "..target.getIdentity().fullname)
     TriggerEvent("core:log", tostring("[GRANT] "..user.getIdentity().fullname.."("..source..") has granted a gun license by "..target.getIdentity().fullname.."("..target..")"), "gun-license")
    end)
   end
  end)
 end)

RegisterServerEvent('gun:confiscateLicense')
AddEventHandler('gun:confiscateLicense', function()
  print("Running")
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM gun_license WHERE `char_id` = @char_id", {['@char_id'] = user.getCharacterID()}, function(result)
   if result[1] then
    TriggerClientEvent('chatMessage', source, "THE LAW", {66, 134, 244}, "Your Gun License has been revoked from you because of your jail time.")
    TriggerEvent("core:log", tostring("[CONFISCATE] "..user.getIdentity().fullname.."("..source..") has had their license revoked by the state due to their jail time."), "gun-license")
    exports['GHMattiMySQL']:QueryAsync("DELETE FROM `gun_license` WHERE char_id=@char_id", {['@char_id'] = user.getCharacterID()})
   end
  end)
 end)
end)

RegisterServerEvent('gun:addLicense')
AddEventHandler('gun:addLicense', function()
 local source = tonumber(source)
  TriggerEvent("core:getPlayerFromId", source, function(user)
    exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM gun_license WHERE `char_id` = @char_id", {['@char_id'] = user.getCharacterID()}, function(result)
  if result[1] then
    TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "You Already Have a Gun License"})
  else
    if user.getBank() >= 4000 then
    user.removeBank(4000)
    exports['GHMattiMySQL']:QueryAsync('INSERT INTO `gun_license` (char_id, fullname) VALUES (@char_id, @fullname)',{['@char_id'] = user.getCharacterID(), ['@fullname'] = user.getIdentity().fullname,})
    TriggerClientEvent('chatMessage', source, "THE LAW", {66, 134, 244}, "You have been granted a Gun License ")
    TriggerEvent("core:log", tostring("[GRANT] "..user.getIdentity().fullname.."("..source..") has granted a gun license."), "gun-license")
  else
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Insufficient Funds in Bank"})
     end
    end
   end) 
  end)
end)


RegisterServerEvent('gun:checkLicense')
AddEventHandler('gun:checkLicense', function()
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM gun_license WHERE `char_id` = @char_id", {['@char_id'] = user.getCharacterID()}, function(result)
   if result[1] then
    TriggerClientEvent('law:gunLicense', source, true)
   else
    TriggerClientEvent('law:gunLicense', source, false)
   end
  end)
 end)
end)

RegisterServerEvent("insurance:create")
AddEventHandler("insurance:create",function(fullname, date, address)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  if user.getBank() >= 250 then 
   user.removeBank(250)
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `dmv_users` (char_id, name, registered, address) VALUES (@char_id, @name, @registered, @address)',{['@char_id'] = user.getCharacterID(), ['@name'] = fullname, ['@registered'] = date, ['@address'] = address})
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Your new drivers license has been registed with the DMV Record Collectors"}) 
  else
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Insufficient Funds in Bank"}) 
  end
 end)
end)

RegisterServerEvent('license:check')
AddEventHandler('license:check', function()
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM dmv_users WHERE `char_id` = @char_id", {['@char_id'] = user.getCharacterID()}, function(character)
    if character[1] then
     TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "You already have an active drivers license!"}) 
    else
     TriggerClientEvent('license:opencreate', source)
    end
  end)
 end)
end)

RegisterServerEvent('license:changeaddress')
AddEventHandler('license:changeaddress', function(address)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM dmv_users WHERE `char_id` = @char_id", {['@char_id'] = user.getCharacterID()}, function(character)
    if character[1] then
     TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Your license address has been updated with the DMV Record Collectors"}) 
     exports['GHMattiMySQL']:QueryResultAsync("UPDATE `dmv_users` SET address=@address WHERE char_id=@id",{['@address'] = address, ['@id'] = user.getCharacterID()})
    else
     TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "You do not have an active Drivers License, please buy one."}) 
    end
  end)
 end)
end)