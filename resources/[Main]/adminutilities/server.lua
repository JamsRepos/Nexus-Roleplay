--[[
TriggerEvent('core:addGroupCommand', 'tempban', "mod", function(source, args, user)
 local banCode = createUniqueCode()
 local source = tonumber(source) 
 if args[2] then
  if(GetPlayerName(tonumber(args[2])))then
   local player = tonumber(args[2])
   TriggerEvent("core:getPlayerFromId", player, function(target)
  local reason = args
  table.remove(reason, 1)
  table.remove(reason, 1)
  reason = table.concat(reason, " ")
  exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM `users` WHERE `identifier` = @identifier",{['@identifier'] = target.getIdentifier()},function(result)
   if result[1]['id'] ~= nil then
    for k,v in ipairs(GetPlayerIdentifiers(player)) do
       exports['GHMattiMySQL']:QueryAsync("INSERT INTO bans (`user_id`, `identifier`, `reason`, `admin`, `ban_id`, `duration`) VALUES (@userid, @identifier, @reason, @admin, @ban_id, @duration)", {['@userid'] = result[1]['id'], ['@identifier'] = v, ['@reason'] = reason.." | ID: "..banCode, ['@admin'] = user.getIdentifier(), ['@ban_id'] = banCode, ['@duration'] = duration})
    end
   end
  end)
  StaffMessage("^5Banned: "..GetPlayerName(player).." | Admin: "..GetPlayerName(source).." Reason: "..reason)
  PerformHttpRequest("https://discordapp.com/api/webhooks/699702380358533161/HbdOJCbWn8DCR4qkHm61cFJFEXfgicBEatUibtjooBo45RTVMQO12gd65xkGhrq-npMh", function(Error, Content, Head) end, 'POST', json.encode({username = SystemName, content = "```Banned: "..GetPlayerName(player).." | Admin: "..GetPlayerName(source).." | Reason: "..reason.."```", avatar_url = SystemAvatar}), {['Content-Type'] = 'application/json'})
  exports['GHMattiMySQL']:QueryAsync("INSERT INTO admin_history (`admin`, `user`, `action`, `when`) VALUES (@admin, @user, @action, @when)",{['@admin'] = user.getIdentifier(), ['@user'] = target.getIdentifier(), ['@action'] = "Banned: " .. reason.." | ID: "..banCode, ['@when'] =  os.date("%d/%m/%Y %X")})
  DropPlayer(player, "You have been banned, you may appeal it at Discord.gg/ZaYvv4K | Reason: " .. reason.." | ID: "..banCode)
   end)
  end
 end
end)


]]--



local voteKick = {count = 0, votes = {}}
local voteBan = {count = 0, votes = {}}
local lastlocation = {}
--[[
TriggerEvent('core:addGroupCommand', 'startserver', "admin", function(source, args, user)
 if args[2] then
  if args[2] == 'two' then
   TriggerClientEvent('chatMessage', -1, "SYSTEM", {255, 0, 0}, "Due to the high player queue, the second server is now being booted online!")
   os.execute("bash /srv/daemon-data/4e8fd6e9-286d-42d1-a7e5-ca558b26095d/secondServer.sh")
  elseif args[2] == 'three' then
   TriggerClientEvent('chatMessage', -1, "SYSTEM", {255, 0, 0}, "Due to the high player queue, the third server is now being booted online!")
   os.execute("bash /srv/daemon-data/4e8fd6e9-286d-42d1-a7e5-ca558b26095d/thirdServer.sh")
  end
 end
end)
]]--
 TriggerEvent('core:addGroupCommand', 'giveitem', "admin", function(source, args, user)
  local player = tonumber(args[2])
  local item = tonumber(args[3])
  TriggerClientEvent("inventory:addQty", player, item, 1)
  TriggerEvent('core:log', "[GIVE] "..GetPlayerName(player).."("..player..") has been given "..item.." by "..GetPlayerName(source).."("..source..")", "staff")
  --local chatlog = "[ITEM] " .. GetPlayerName(source) .. " GAVE ITEM TO " .. GetPlayerName(player)
    --TriggerEvent("core:log", chatlog, "admin")  
end)

RegisterServerEvent("core:carlog")
AddEventHandler("core:carlog", function(source, text)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  local fullname = user.getIdentity().fullname
  PerformHttpRequest("https://discordapp.com/api/webhooks/713848960858456165/ozQzkFlh8GMCZNDS-iW4cDETUPW1BIZcyvqT6E0xLeCfxrD9wDM8DndpcfvkVA9PpZF_", function(Error, Content, Head) end, 'POST', json.encode({username = SystemName, content = "```[Money Log] "..fullname..": "..text.."```\n", avatar_url = SystemAvatar}), {['Content-Type'] = 'application/json'})
 end)
end)


--[[TriggerEvent('core:addGroupCommand', 'setmodel', "admin", function(source, args, user)
  if args[2] and args[3] then
   if(GetPlayerName(tonumber(args[2])))then
    local player = tonumber(args[2])
    local model = args[3]
    TriggerClientEvent('admin:setModel', player, model)
    TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Model Set")
   else
    TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Incorrect player ID!")
   end
  end
end)]]--

--[[TriggerEvent('core:addGroupCommand', 'nomike', "admin", function(source, args, user)
  if args[2] then
   if(GetPlayerName(tonumber(args[2])))then
    local player = tonumber(args[2])
    local model = 'mp_m_freemode_01'
    TriggerClientEvent('fuckmikey', player, model)
    TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Wahoo Fuck Micheal Dude!")
    print(model,player)
   else
    TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Incorrect player ID!")
   end
  end
end)]]--

--[[TriggerEvent('core:addGroupCommand', 'unban', "mod", function(source, args, user)
  if args[2] then
    exports['GHMattiMySQL']:QueryAsync("DELETE FROM `bans` WHERE ban_id=@ban_id",{['@ban_id'] = args[2]})
    PerformHttpRequest("https://discordapp.com/api/webhooks/699702380358533161/HbdOJCbWn8DCR4qkHm61cFJFEXfgicBEatUibtjooBo45RTVMQO12gd65xkGhrq-npMh", function(Error, Content, Head) end, 'POST', json.encode({username = SystemName, content = "```Unban: [ID: "..args[2].."] | Admin: "..GetPlayerName(source).."```", avatar_url = SystemAvatar}), {['Content-Type'] = 'application/json'})
  end
 end)
]]--

RegisterServerEvent("admin:clientGetGroup")
AddEventHandler("admin:clientGetGroup", function()
 local source = tonumber(source)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  TriggerClientEvent('admin:setGroup', source, user.getGroup())
 end)
end)

RegisterServerEvent("admin:checkRole")
AddEventHandler("admin:checkRole", function()
  local source = tonumber(source)
  TriggerEvent("core:getPlayerFromId", source, function(user)
   TriggerClientEvent('admin:setPerm', source, user.getPermissions())
  end)
end)

TriggerEvent('core:addGroupCommand', 'setrank', "manager", function(source, args, user)
  local player = tonumber(args[2])
  local rank = args[3]
  TriggerEvent("core:getPlayerFromId", player, function(user)
   if rank == 'helper' then
    exports['GHMattiMySQL']:QueryAsync("UPDATE `users` SET `permission_level`='50', `group`='helper' WHERE identifier=@id",{['@id'] = GetPlayerIdentifier(player)})
    exports['GHMattiMySQL']:QueryAsync("UPDATE `discord_verification` SET `rank`='helper' WHERE user_id=@id",{['@id'] = GetPlayerIdentifier(player)})
   elseif rank == 'mod' then
    exports['GHMattiMySQL']:QueryAsync("UPDATE `users` SET `permission_level`='60', `group`='mod' WHERE identifier=@id",{['@id'] = GetPlayerIdentifier(player)})
    exports['GHMattiMySQL']:QueryAsync("UPDATE `discord_verification` SET `rank`='mod' WHERE user_id=@id",{['@id'] = GetPlayerIdentifier(player)})
   elseif rank == 'admin' then
     exports['GHMattiMySQL']:QueryAsync("UPDATE `users` SET `permission_level`='65', `group`='admin' WHERE identifier=@id",{['@id'] = GetPlayerIdentifier(player)})
     exports['GHMattiMySQL']:QueryAsync("UPDATE `discord_verification` SET `rank`='admin' WHERE user_id=@id",{['@id'] = GetPlayerIdentifier(player)})
   elseif rank == 'developer' then
     exports['GHMattiMySQL']:QueryAsync("UPDATE `users` SET `permission_level`='75', `group`='developer' WHERE identifier=@id",{['@id'] = GetPlayerIdentifier(player)})
     exports['GHMattiMySQL']:QueryAsync("UPDATE `discord_verification` SET `rank`='developer' WHERE user_id=@id",{['@id'] = GetPlayerIdentifier(player)})
   elseif rank == 'support' then
    exports['GHMattiMySQL']:QueryAsync("UPDATE `users` SET `permission_level`='55', `group`='support' WHERE identifier=@id",{['@id'] = GetPlayerIdentifier(player)})
    exports['GHMattiMySQL']:QueryAsync("UPDATE `discord_verification` SET `rank`='support' WHERE user_id=@id",{['@id'] = GetPlayerIdentifier(player)})
   elseif rank == 'owner' then
     exports['GHMattiMySQL']:QueryAsync("UPDATE `users` SET `permission_level`='80', `group`='owner' WHERE identifier=@id",{['@id'] = GetPlayerIdentifier(player)})
     exports['GHMattiMySQL']:QueryAsync("UPDATE `discord_verification` SET `rank`='owner' WHERE user_id=@id",{['@id'] = GetPlayerIdentifier(player)})
  elseif rank == 'manager' then
    exports['GHMattiMySQL']:QueryAsync("UPDATE `users` SET `permission_level`='70', `group`='manager' WHERE identifier=@id",{['@id'] = GetPlayerIdentifier(player)})
    exports['GHMattiMySQL']:QueryAsync("UPDATE `discord_verification` SET `rank`='manager' WHERE user_id=@id",{['@id'] = GetPlayerIdentifier(player)})
   elseif not args[3] or rank == 'user' then
    rank = 'user'
    exports['GHMattiMySQL']:QueryAsync("UPDATE `users` SET `permission_level`='0', `group`='user' WHERE identifier=@id",{['@id'] = GetPlayerIdentifier(player)})
    exports['GHMattiMySQL']:QueryAsync("UPDATE `discord_verification` SET `rank`='user' WHERE user_id=@id",{['@id'] = GetPlayerIdentifier(player)})
   end
   TriggerEvent('core:loadplayer', player)
   TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, GetPlayerName(player).." has had their rank and permission level updated to: "..rank)
   TriggerEvent("core:log", tostring("[RANK] " .. GetPlayerName(source) .. " edited " .. GetPlayerName(player) .. " staff rank to: "..rank), "staff")
  end)
 end)
--[[
TriggerEvent('core:addGroupCommand', 'donolevel', "admin", function(source, args, user)
 local player = tonumber(args[2])
 local rank = args[3]
 TriggerEvent("core:getPlayerFromId", player, function(user)
  if rank == 'one' then
   exports['GHMattiMySQL']:QueryAsync("UPDATE `users` SET permission_level=@permission_level WHERE identifier=@id",{['@permission_level'] = 10, ['@id'] = GetPlayerIdentifier(player)})
  elseif rank == 'two' then
   exports['GHMattiMySQL']:QueryAsync("UPDATE `users` SET permission_level=@permission_level WHERE identifier=@id",{['@permission_level'] = 15, ['@id'] = GetPlayerIdentifier(player)})
  elseif rank == 'three' then
   exports['GHMattiMySQL']:QueryAsync("UPDATE `users` SET permission_level=@permission_level WHERE identifier=@id",{['@permission_level'] = 20, ['@id'] = GetPlayerIdentifier(player)})
  elseif rank == 'three' then
   exports['GHMattiMySQL']:QueryAsync("UPDATE `users` SET permission_level=@permission_level WHERE identifier=@id",{['@permission_level'] = 25, ['@id'] = GetPlayerIdentifier(player)})
  else
   exports['GHMattiMySQL']:QueryAsync("UPDATE `users` SET permission_level=@permission_level WHERE identifier=@id",{['@permission_level'] = 0, ['@id'] = GetPlayerIdentifier(player)})
  end
  TriggerEvent('core:loadplayer', player)
  TriggerClientEvent('chatMessage', player, "SYSTEM", {255, 0, 0}, "Thank you for your support towards the server! The permission levels have now been applied to your account.")
  TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, GetPlayerName(player).." has had their donator level updated to: "..rank)
  TriggerEvent("core:log", tostring("[RANK] " .. GetPlayerName(source) .. " edited " .. GetPlayerName(player) .. " donator rank to: "..rank), "staff")
 end)
end)
]]--
AddEventHandler('core:playerLoaded', function(Source, user)
  TriggerClientEvent('admin:setGroup', Source, user.getGroup())
end)

TriggerEvent('core:addGroupCommand', 'watch', "helper", function(source, args, user)
 local player = tonumber(args[2])
 TriggerEvent("core:getPlayerFromId", player, function(user)
  exports['GHMattiMySQL']:QueryAsync("UPDATE `users` SET watched=@watch WHERE identifier=@id",{['@watch'] = 1, ['@id'] = GetPlayerIdentifier(player)})
  TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, GetPlayerName(player).." Has Been Added From The Watch List")
  TriggerEvent("core:log", tostring("[WATCH] " .. GetPlayerName(source) .. " added " .. GetPlayerName(player) .. " to the Watchlist."), "staff")
 end)
end)

TriggerEvent('core:addGroupCommand', 'pvc', "admin", function(source, args, user)
  if args[2] then
   local player = tonumber(args[2])
   local source = tonumber(source)
   TriggerEvent("core:getPlayerFromId", player, function(user)
    TriggerClientEvent('staff:enterVC', player, tonumber(source))
    TriggerClientEvent('staff:enterVC', source, tonumber(source))
   end)
  end
 end)

 TriggerEvent('core:addGroupCommand', 'othervc', "admin", function(source, args, user)
 if args[2] then
  local player = tonumber(args[2])
  local source = tonumber(source)
  TriggerEvent("core:getPlayerFromId", player, function(user)
   TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "You have added ^2"..GetPlayerName(player).."^0 to the active voice channel.")
   TriggerClientEvent('staff:enterVC', player, tonumber(source))
  end)
 end
end)

TriggerEvent('core:addGroupCommand', 'unwatch', "helper", function(source, args, user)
 local player = tonumber(args[2])
 TriggerEvent("core:getPlayerFromId", player, function(user)
  exports['GHMattiMySQL']:QueryAsync("UPDATE `users` SET watched=@watch WHERE identifier=@id",{['@watch'] = 0, ['@id'] = GetPlayerIdentifier(player)})
  TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, GetPlayerName(player).." Has Been Removed From The Watch List")
  TriggerEvent("core:log", tostring("[WATCH] " .. GetPlayerName(source) .. " removed " .. GetPlayerName(player) .. " to the Watchlist."), "staff")
 end)
end)

TriggerEvent('core:addGroupCommand', 'devtp', "manager", function(source, args, user)
 local source = tonumber(source)
 TriggerClientEvent('admin:teleport', source, {x = args[2], y = args[3], z = args[4]})
 TriggerEvent("core:log", tostring("[DEVTP] " .. GetPlayerName(source) .. "teleported to some co-ordinates."), "staff")
end)

TriggerEvent('core:addGroupCommand', 'tpm', "manager", function(source, args, user)
 local source = tonumber(source)
 TriggerClientEvent('admin:tpm', source)
 TriggerEvent("core:log", tostring("[TPM] " .. GetPlayerName(source) .. "teleported to a waypoint."), "staff")
end)

TriggerEvent('core:addGroupCommand', 'tp', "mod", function(source, args, user)
  local source = tonumber(source)
  TriggerClientEvent('admin:tp', source)
  TriggerEvent("core:log", tostring("[TP] " .. GetPlayerName(source) .. " used the teleport menu."), "staff")
 end)

TriggerEvent('core:addGroupCommand', 'givemoney', "admin", function(source, args, user)
 local source = tonumber(source)
 local player = tonumber(args[2])
 local money = tonumber(args[3])
 TriggerEvent("core:getPlayerFromId", player, function(user)
  user.addMoney(money)
  TriggerEvent('core:log', "[GIVEMONEY] "..GetPlayerName(player).."("..player..") has been given $"..money.." by "..GetPlayerName(source).."("..source..")", "staff")
 end)
end)

TriggerEvent('core:addGroupCommand', 'removemoney', "admin", function(source, args, user)
 local source = tonumber(source)
 local player = tonumber(args[2])
 local money = tonumber(args[3])
 TriggerEvent("core:getPlayerFromId", player, function(user)
  user.removeMoney(money)
  TriggerEvent('core:log', "[REMOVEMONEY] "..GetPlayerName(player).."("..player..") has had $"..money.." taken by "..GetPlayerName(source).."("..source..")", "staff")
 end)
end)

TriggerEvent('core:addGroupCommand', 'givedirtymoney', "admin", function(source, args, user)
 local source = tonumber(source)
 local player = tonumber(args[2])
 local money = tonumber(args[3])
 TriggerEvent("core:getPlayerFromId", player, function(user)
  user.addDirtyMoney(money)
  TriggerEvent('core:log', "[GIVEDIRTYMONEY] "..GetPlayerName(player).."("..player..") has been given $"..money.." (dirty) by "..GetPlayerName(source).."("..source..")", "staff")
 end)
end)

TriggerEvent('core:addGroupCommand', 'removedirtymoney', "admin", function(source, args, user)
 local source = tonumber(source)
 local player = tonumber(args[2])
 local money = tonumber(args[3])
 TriggerEvent("core:getPlayerFromId", player, function(user)
  user.removeDirtyMoney(money)
  TriggerEvent('core:log', "[REMOVEDIRTYMONEY] "..GetPlayerName(player).."("..player..") has had $"..money.." (dirty) taken by "..GetPlayerName(source).."("..source..")", "staff")
 end)
end)

TriggerEvent('core:addGroupCommand', 'flop', "helper", function(source, args, user)
 local source = tonumber(source)
 TriggerEvent("core:getPlayerFromId", source, function(user)
 local player = tonumber(args[2])
  TriggerEvent('power:tackle', player)
  TriggerEvent('core:log', "[FLOP] "..GetPlayerName(source).."("..source..") has flopped "..GetPlayerName(player).."("..player..")", "staff")
end)
end)

--[[TriggerEvent('core:addGroupCommand', 'giveweapon', "admin", function(source, args, user)
 local player = tonumber(args[2])
 local name = tostring(args[3])
 local label = tostring(args[4])
 TriggerEvent("core:getPlayerFromId", player, function(user)
  user.addWeapon(name, label)
  TriggerEvent("core:log", tostring("[GUNSPAWN] " .. GetPlayerName(source) ' GUN: '..args[3]..args[4]), "admin")
 end)
end)
]]--
TriggerEvent('core:addGroupCommand', 'removeallweapons', "helper", function(source, args, user)
 local player = tonumber(args[2])
 TriggerEvent("core:getPlayerFromId", player, function(user)
  user.removeAllWeapons()
 end)
end)

TriggerEvent('core:addGroupCommand', 'car', "admin", function(source, args, user)
 TriggerClientEvent('admin:spawnVehicle', source, args[2])
 TriggerEvent("core:log", tostring("[CARSPAWN] " .. GetPlayerName(source).. ' CAR: ' ..args[2]), "staff")
end)

TriggerEvent('core:addGroupCommand', 'clearchat', "helper", function(source, args, user)
 TriggerClientEvent('chat:clear', -1)
 TriggerEvent("core:getPlayers", function(pl)
  for k,v in pairs(pl) do
    TriggerEvent("core:getPlayerFromId", k, function(user)
      TriggerClientEvent('chatMessage', k, "CLEAR", {255, 0, 0}, " ^2" .. GetPlayerName(source) .." ("..source..")^0 has cleared the chat.")
    end)
  end
end)
end)

TriggerEvent('core:addCommand', 'report', function(source, args, user)
 table.remove(args, 1)
 TriggerClientEvent('chatMessage', source, "REPORT", {255, 0, 0}, " (^2" .. GetPlayerName(source) .." | "..source.."^0) " .. table.concat(args, " "))
 local embed = {
  {
    ["color"] = 3661319,
    ["title"] = "Report",
    ["footer"] = {
      ["text"] = os.date('%Y-%m-%d %H:%M:%S')
    }, 
    ["fields"] = {
      {
        ["name"] = "Player",
        ["value"] = source.." | "..GetPlayerName(source),
        ["inline"] = false
      },
      {
        ["name"] = "Reason",
        ["value"] = table.concat(args, " "),
        ["inline"] = false
      }
    }
  }
}
PerformHttpRequest("https://discordapp.com/api/webhooks/713843936245841980/gSpwXzO-EC3EkWQVvXStoGyLWgktQn0qHvQFgg3-hSUGL2z2uVRFmdt0ucQqjeDqs69E", function(Error, Content, Head) end, 'POST', json.encode({username = SystemName, embeds = embed, avatar_url = SystemAvatar}), {['Content-Type'] = 'application/json'})
 TriggerEvent("core:getPlayers", function(pl)
  for k,v in pairs(pl) do
   TriggerEvent("core:getPlayerFromId", k, function(user)
    if(user.getPermissions() > 50 and k ~= source)then
     if user.isAdminEnabled() then
      TriggerClientEvent('chatMessage', k, "REPORT", {255, 0, 0}, " (^2" .. GetPlayerName(source) .." | "..source.."^0) " .. table.concat(args, " "))
     end
    end
   end)
  end
 end)
end)

TriggerEvent('core:addGroupCommand', 'am', "helper", function(source, args, user)
 if args[2] then
  if(GetPlayerName(tonumber(args[2])))then
   local player = tonumber(args[2])
   local reason = args
   table.remove(reason, 1)
   table.remove(reason, 1)
   reason = table.concat(reason, " ")
   TriggerClientEvent('chatMessage', player, "^9" ..GetPlayerName(source).." > You^0: "..reason)
   TriggerEvent("core:log", tostring("[AM] "..GetPlayerName(source).." > "..GetPlayerName(player) ..": "..reason), "am")
   StaffMessage(tostring("^9" .. GetPlayerName(source).." > "..GetPlayerName(player) .."^0: "..reason)) 
  end
 end
end)

-- Admin Chat
TriggerEvent('core:addGroupCommand', 'ac', "helper", function(source, args, user)
 table.remove(args, 1)
 TriggerEvent("core:log", tostring("[AC] "..GetPlayerName(source)..": "..table.concat(args, " ")), "ac")
 TriggerEvent("core:getPlayers", function(pl)
  for k,v in pairs(pl) do
   TriggerEvent("core:getPlayerFromId", k, function(user)
    if(user.getPermissions() > 50)then
     if user.isAdminEnabled() then 
      TriggerClientEvent('chatMessage', k, "^0[^3AC^0] ^2" .. GetPlayerName(source) .. " ", {255, 128, 0}, table.concat(args, " "))
     end
    end
   end)
  end
 end)
end)

TriggerEvent('core:addGroupCommand', 'gc', "admin", function(source, args, user)
 table.remove(args, 1)
 TriggerEvent("core:getPlayers", function(pl)
  for k,v in pairs(pl) do
   TriggerEvent("core:getPlayerFromId", k, function(user)
    if(user.getPermissions() > 65) then
     if user.isAdminEnabled() then 
      TriggerClientEvent('chatMessage', k, "^0[^6GOD^0] ^6" .. GetPlayerName(source) .. " ", {255, 128, 0}, table.concat(args, " "))
     end
    end
   end)
  end
 end)
end)

TriggerEvent('core:addGroupCommand', 'toggleadmin', "helper", function(source, args, user)
 local source = tonumber(source)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  if user.isAdminEnabled() then
   user.setAdminEnabled(false)
   StaffMessage(tostring("^9" .. GetPlayerName(source).." Has Turned Off Admin Notifications"))
   TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "^9 Notifications Turned OFF")
  else
   user.setAdminEnabled(true)
   StaffMessage(tostring("^9" .. GetPlayerName(source).." Has Turned On Admin Notifications")) 
  end
 end)
end)

-- Announcing
TriggerEvent('core:addGroupCommand', 'announce', "helper", function(source, args, user)
 table.remove(args, 1)
 TriggerClientEvent('chatMessage', -1, "ANNOUNCEMENT", {255, 0, 0}, " " .. table.concat(args, " "))
end)

-- Freezing
local frozen = {}
TriggerEvent('core:addGroupCommand', 'freeze', "helper", function(source, args, user)
 if args[2] then
  if(GetPlayerName(tonumber(args[2])))then
   local player = tonumber(args[2])
   TriggerEvent("core:getPlayerFromId", player, function(target)
    frozen[player] = not frozen[player]
    TriggerClientEvent('admin:freezePlayer', player, frozen[player])
    if frozen[player] then 
     TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Frozen")
     TriggerEvent("core:log", tostring("[FREEZE] " .. GetPlayerName(source) .. " frozen " .. GetPlayerName(player)), "staff")
    else 
     TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Un-Frozen")
     TriggerEvent("core:log", tostring("[FREEZE] " .. GetPlayerName(source) .. " unfrozen " .. GetPlayerName(player)), "staff")
    end
   end)
  else
   TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Incorrect player ID!")
  end
 end
end)

-- Bring
TriggerEvent('core:addGroupCommand', 'bring', "helper", function(source, args, user)
 if args[2] then
  if(GetPlayerName(tonumber(args[2])))then
   local player = tonumber(args[2])
   TriggerEvent("core:getPlayerFromId", player, function(target)
    TriggerEvent("core:getPlayerFromId", player, function(target)
     TriggerClientEvent('admin:teleport', target.get('source'), user.getCoords())
     TriggerClientEvent('chatMessage', player, "SYSTEM", {255, 0, 0}, "You have been brought by ^2" .. GetPlayerName(source))
     TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Player ^2" .. GetPlayerName(player) .. "^0 has been brought")
     TriggerEvent("core:log", tostring("[BRING] " .. GetPlayerName(source) .. " brought " .. GetPlayerName(player)), "staff")
    end)
   end)
  end
 end
end)

local function antimickymale()
  if(GetEntityModel(GetPlayerPed(-1)) == 22551469) then
     TriggerEvent('outfit:set', json.decode('{"clothing":{"model":1885233650}'))
  end
end 

local function antimickyfemale()
  if(GetEntityModel(GetPlayerPed(-1)) == 22551469) then
     TriggerEvent('outfit:set', json.decode('{"clothing":{"model":-1667301416}'))
  end
end

TriggerEvent('core:addGroupCommand', 'resetskin', "helper", function(source, args, user)
 if args[2] then
  if(GetPlayerName(tonumber(args[2])))then
   local player = tonumber(args[2])
   local source = tonumber(source)
   TriggerEvent("core:getPlayerFromId", player, function(target)
    local gender = user.getIdentity().gender
    exports['GHMattiMySQL']:QueryAsync("UPDATE `characters` SET skin=NULL WHERE id=@id",{['@id'] = exports['core']:GetActiveCharacterID(player)})
    TriggerClientEvent('skin:noskin', player,gender)
    TriggerEvent("core:log", tostring("[CORE] " .. GetPlayerName(source) .. " has reset " .. GetPlayerName(player).. " (Character ID: ".. exports['core']:GetActiveCharacterID(player)..") skin/player model."), "staff")
    TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Player ^2" .. GetPlayerName(player) .. " (Character ID: ".. exports['core']:GetActiveCharacterID(player)..") ^0skin/player model.")
   end)
  end
 end
end)

TriggerEvent('core:addGroupCommand', 'refreshhotels', "admin", function(source, args, user)
 TriggerEvent('hotels:update')
end)

TriggerEvent('core:addGroupCommand', 'setname', "admin", function(source, args, user)
 if args[2] then
  if(GetPlayerName(tonumber(args[2]))) then
   local player = tonumber(args[2])
   local source = tonumber(source)
   TriggerEvent("core:getPlayerFromId", player, function(target)
    if args[3] then
     exports['GHMattiMySQL']:QueryAsync("UPDATE `characters` SET firstname=@firstname WHERE id=@id",{['@id'] = exports['core']:GetActiveCharacterID(player), ['@firstname'] = args[3]})
    end
    if args[4] then
     exports['GHMattiMySQL']:QueryAsync("UPDATE `characters` SET lastname=@lastname WHERE id=@id",{['@id'] = exports['core']:GetActiveCharacterID(player), ['@lastname'] = args[4]})
    end
    TriggerEvent('core:loadplayer', player)
    TriggerEvent("core:log", tostring("[CORE] " .. GetPlayerName(source) .. " has updated " .. GetPlayerName(player).. " character name.", "staff"))
    TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Player ^2" .. GetPlayerName(player) .. "^0's name has been updated.")
   end)
  end
 end
end)

TriggerEvent('core:addGroupCommand', 'deletechar', "admin", function(source, args, user)
 if args[2] then
  if(GetPlayerName(tonumber(args[2])))then
   local player = tonumber(args[2])
   local source = tonumber(source)
   TriggerEvent("core:getPlayerFromId", player, function(target)
    exports['GHMattiMySQL']:QueryAsync("UPDATE `characters` SET isDeleted=@isDeleted WHERE id=@id",{['@id'] = exports['core']:GetActiveCharacterID(player), ['@isDeleted'] = 1})
    TriggerClientEvent('prison:switchcharacter', tonumber(args[2]))
    TriggerEvent('core:playerDropped', tonumber(args[2]))
    TriggerClientEvent("core:switchcharacter", tonumber(args[2]))
    TriggerEvent("core:log", tostring("[CORE] " .. GetPlayerName(source) .. " has deleted " .. GetPlayerName(player).. "'s Character."), "staff")
    TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Player ^2" .. GetPlayerName(player) .. " ^0has just been deleted and logged out.")
   end)
  end
 end
end)

TriggerEvent('core:addGroupCommand', 'breakbox', "mod", function(source, args, user)
 if args[2] then
  local boxid = args[3]
  local source = tonumber(source)
  if args[2] == 's' then
    TriggerClientEvent('storage_box:admindel', source, boxid)
    TriggerEvent("core:log", tostring("[CORE] " .. GetPlayerName(source) .. " has just broken into a box with the ID: "..boxid), "staff")
    TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "You have just broken into a storage box with the ^2ID: "..boxid)
  elseif args[2] == 'l' then
    TriggerClientEvent('large_storage_box:admindel', source, boxid)
    TriggerEvent("core:log", tostring("[CORE] " .. GetPlayerName(source) .. " has just broken into a large storage box with the ID: "..boxid), "staff")
    TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "You have just broken into a large storage box with the ^2ID: "..boxid)
  elseif args[2] == 'w' then
    TriggerClientEvent('weapon_box:admindel', source, boxid)
    TriggerEvent("core:log", tostring("[CORE] " .. GetPlayerName(source) .. " has just broken into a weapon storage box with the ID: "..boxid), "staff")
    TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "You have just broken into a weapon storage box with the ^2ID: "..boxid)
  end
 end
end)

TriggerEvent('core:addGroupCommand', 'dv', "helper", function(source, args, user)
 local source = tonumber(source)
  TriggerClientEvent('admin:dv', source)
end)

TriggerEvent('core:addGroupCommand', 'cleararea', "helper", function(source, args, user)
 local source = tonumber(source)
  TriggerClientEvent('admin:cleararea', source)
end)

-- Kill yourself
TriggerEvent('core:addCommand', 'die', function(source, args, user)
  TriggerClientEvent('admin:kill', source)
end)

-- Logging Out [Multiple Characters]
TriggerEvent('core:addGroupCommand', 'lgtout', 'helper', function(source, args, user)
 if args[2] ~= nil then
  TriggerClientEvent('prison:switchcharacter', tonumber(args[2]))
  TriggerEvent('core:playerDropped', tonumber(args[2]))
  TriggerClientEvent("core:switchcharacter", tonumber(args[2]))
 else
  TriggerClientEvent('prison:switchcharacter', source)
  TriggerEvent('core:playerDropped', source)
  TriggerClientEvent("core:switchcharacter", source)
 end
end)

TriggerEvent('core:addGroupCommand', 'slay', "helper", function(source, args, user)
 if args[2] then
  if(GetPlayerName(tonumber(args[2])))then
   local player = tonumber(args[2])
   TriggerEvent("core:getPlayerFromId", player, function(target)
    TriggerClientEvent('admin:kill', player)

    TriggerClientEvent('chatMessage', player, "SYSTEM", {255, 0, 0}, "You have been killed by ^2" .. GetPlayerName(source))
    TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Player ^2" .. GetPlayerName(player) .. "^0 has been killed.")
    TriggerEvent("core:log", tostring("[SLAY] " .. GetPlayerName(source) .. " slayed " .. GetPlayerName(player)), "staff")
   end)
  end
 end
end)

-- Crashing
TriggerEvent('core:addGroupCommand', 'crash', "admin", function(source, args, user)
 if args[2] then
  if(GetPlayerName(tonumber(args[2])))then
   local player = tonumber(args[2])
   TriggerEvent("core:getPlayerFromId", player, function(target)
  TriggerEvent("core:log", tostring("[CRASH] "..GetPlayerName(source).." has been crashed by" ..GetPlayerName(player)), "staff")
  TriggerClientEvent('admin:crash', player)
  TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Player ^2" .. GetPlayerName(player) .. "^0 has been crashed.")
   end)
  end
 end
end)

RegisterServerEvent("admin:savecoords")
AddEventHandler("admin:savecoords", function(string)
  local f,err = io.open("pos.txt", "a")
    f:write(string..", \n")
    f:close()
end)

RegisterServerEvent("core:log")
AddEventHandler("core:log", function(text, channel)
  local f,err = io.open("server.log","a")
  local formattedlog = string.format("["..os.date("%d/%m/%Y %X").."] "..text.."\n")
  local webhook = nil
  local mention = nil
  f:write(formattedlog)
  f:close()

	local date = os.date('*t')
	
	if date.month < 10 then date.month = '0' .. tostring(date.month) end
	if date.day < 10 then date.day = '0' .. tostring(date.day) end
	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
  if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

  if channel == "evidence" and string.match(text, "from the evidence locker") then
    mention = "<@&713175715994140753>"
  else
    mention = ""
  end
  
  if channel == "staff" then
    webhook = "https://discordapp.com/api/webhooks/713815904659439737/6hOzj8gaNOl5p-2GF5pIZlxlYdt_Rz_xeEsCxcxvq9KEz9vf1tsIUQUKR0H01BUdID6p"
  elseif channel == "join" then
    webhook = "https://discordapp.com/api/webhooks/699702380358533161/HbdOJCbWn8DCR4qkHm61cFJFEXfgicBEatUibtjooBo45RTVMQO12gd65xkGhrq-npMh"
  elseif channel == "report" then
    webhook = "https://discordapp.com/api/webhooks/713843936245841980/gSpwXzO-EC3EkWQVvXStoGyLWgktQn0qHvQFgg3-hSUGL2z2uVRFmdt0ucQqjeDqs69E"
  elseif channel == "kill" then
    webhook = "https://discordapp.com/api/webhooks/713848433219338362/iDNdq8XG49TFI4ffhIp5EyeZzcwqaa9yV7_6WZCIH8jKiMnIUZLSbboISOHk4Tx44b4i"
  elseif channel == "chat" then
    webhook = "https://discordapp.com/api/webhooks/713848561867161660/T0JQQcKt596e22nwstqXPExcLQoASXP6gorYbK0z5_gJvDrOQuU42cD6YZ2Ai_9vuwvk"
  elseif channel == "jail" then
    webhook = "https://discordapp.com/api/webhooks/713809211879850026/oTbCuDh-BC8hb-HVYpz3sRHGQ1boaV-P4GZ9Mg9MdzZwJ-B0FWaoyvrX6t1o6hQ8m6-w"
  elseif channel == "fine" then
    webhook = "https://discordapp.com/api/webhooks/713814084411457537/imYzGoJyvut7NawAVWcihpHXt5rYjT0tr_A-cs75AQFekcdl3a48SCDfvae8kiT6JCpF"
  elseif channel == "house" then
    webhook = "https://discordapp.com/api/webhooks/713848847843197048/71OWdGP4_tgv0-KM5YnXYR4hDV9iV_nVLpZUBXNOPOxF-bhEVeWGgJzYTDDww46IYIYe"
  elseif channel == "vehicle-transfer" then
    webhook = "https://discordapp.com/api/webhooks/713848960858456165/ozQzkFlh8GMCZNDS-iW4cDETUPW1BIZcyvqT6E0xLeCfxrD9wDM8DndpcfvkVA9PpZF_"
  elseif channel == "item" then
    webhook = "https://discordapp.com/api/webhooks/713850541347831930/lwE6td7Nquf93tP0how_KcBdHd-SAJkjf-DKg9e-sVK2G7KHg4sDJH42V7ncwcu1hsJC"
  elseif channel == "drug" then
    webhook = "https://discordapp.com/api/webhooks/713854547294158938/Gh1BndkaalNP2CS8G1SGzmvGNbIfO2uDtnjtNXgXRqJ0iSJbdjJpZ4Q1nZ8VC6B3I8mQ"
  elseif channel == "gun-license" then
    webhook = "https://discordapp.com/api/webhooks/713855686492160093/ie1tQg93YSGxzoQo5kXYH97Uhy0X847bJVZRi0liNz_HssBUviSsrDZl5yd6vCU3eFmq"
  elseif channel == "evidence" then
    webhook = "https://discordapp.com/api/webhooks/718604581407293450/2ofUaf7xBM-QiBIND_Sit2i9MYZsj5ThEjWshRJ7Sof71UH2BD_S1iwsguRCGxRKPYTP"
  elseif channel == "twitter" then
    webhook = "https://discordapp.com/api/webhooks/718874789133025370/Apl3CQUBQgKFLM8O1WZOWv5CwR-0YHLmmGItRqjYYUgYyTyjhf7Q4Aye9Uv6OgMDEFMG"
  elseif channel == "realestate" then
    webhook = "https://discordapp.com/api/webhooks/719396840755167293/loW-pTVKWppZwT8N4_hMoS2VIThOKLAGlLAM1UAWAlne_hSepoNMKdKu3Z0u_i1Sqt75"
  elseif channel == "bad-weapon" then
    webhook = "https://discordapp.com/api/webhooks/741302756035395604/FrTOrhnWbUEIeDxiceQSyXF9gR46Yg5dHsu7MhIGFOA6A78BryJ58KQ8csgZSjNB5yzd"
  end
  PerformHttpRequest(webhook, function(Error, Content, Head) end, 'POST', json.encode({username = SystemName, content = mention.."```\n"..text.."\n[" .. date.day .. '/' .. date.month .. '/' .. date.year .. ' - ' .. date.hour .. ':' .. date.min .. ':' .. date.sec .. "]```", avatar_url = SystemAvatar}), {['Content-Type'] = 'application/json'})
end)

RegisterServerEvent("core:moneylog")
AddEventHandler("core:moneylog", function(source, text)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  local fullname = user.getIdentity().fullname
  local embed = {
    {
      ["color"] = 3661319,
      ["title"] = "Money Log",
      ["fields"] = {
        {
          ["name"] = "Character",
          ["value"] = user.getCharacterID().." | "..fullname,
          ["inline"] = false
        },
        {
          ["name"] = "Transaction",
          ["value"] = text,
          ["inline"] = false
        }
      }
    }
  }
  PerformHttpRequest("https://discordapp.com/api/webhooks/713836428303401020/GEGZ47vplwxhs9QlTxKIY2X6v85PAxkMUyQIQ46MMVK6Qw8XzbK8gZcVm5XlyKEvT4xP", function(Error, Content, Head) end, 'POST', json.encode({username = SystemName, embeds = embed, avatar_url = SystemAvatar}), {['Content-Type'] = 'application/json'})
 end)
end)

function stringsplit(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t={} ; i=1
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    t[i] = str
    i = i + 1
  end
  return t
end

local Spectating = {}

RegisterServerEvent('spectate:requestSpectating')
AddEventHandler('spectate:requestSpectating', function()
  TriggerClientEvent('spectate:onSpectate', source, Spectating)
end)

TriggerEvent('core:addGroupCommand', 'spectate', "helper", function(source, args, user)
 local target = -1
 if args[2] ~= nil then
  target = tonumber(args[2])
 end
 if target == -1 then
  for i=1, #Spectating, 1 do
   if Spectating[i] == source then
  Spectating[i] = nil
  break
   end
  end
  TriggerClientEvent('spectate:onSpectate', -1, Spectating)
  TriggerClientEvent('spectate:spectate', source, target)
  TriggerEvent("core:log", tostring("[SPECTATE] "..GetPlayerName(source).."("..source..") stopped spectating."), "staff")
 elseif target == source then
  TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "You cannot spectate yourself.")
 else
  local found = false
  for i=1, #Spectating, 1 do
   if Spectating[i] == source then
    found = true
    break
   end
  end
  if not found then
   table.insert(Spectating, source)
  end
 
  local target = tonumber(target)

  TriggerEvent("core:getPlayerFromId", target, function(targ)
   TriggerClientEvent('spectate:onSpectate', -1, Spectating)
   TriggerClientEvent('spectate:spectate', source, target, {money = targ.getMoney(), bank = targ.getBank(), dmoney = targ.getDirtyMoney(), id = targ.getIdentity()})
   TriggerEvent("core:log", tostring("[SPECTATE] "..GetPlayerName(source).."("..source..") started spectating "..GetPlayerName(target).."("..target..")"), "staff")
  end)
 end
end)

AddEventHandler('playerDropped', function()
 for i=1, #Spectating, 1 do
  if Spectating[i] == source then
   Spectating[i] = nil
   break
  end
 end
end)

TriggerEvent('core:addCommand', 'cash', function(source, args, user)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = 'Cash: $'..user.getMoney()})
 end)
end)


TriggerEvent('core:addCommand', 'bank', function(source, args, user)
  local source = tonumber(source)
  TriggerEvent('core:getPlayerFromId', source, function(user)
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = 'Bank: $'..user.getBank()})
  end)
end)

TriggerEvent('core:addCommand', 'dm', function(source, args, user)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = 'Dirty Money: $'..user.getDirtyMoney()})
 end)
end) 

RegisterServerEvent('admin:logout')
AddEventHandler('admin:logout', function()
  TriggerClientEvent('prison:switchcharacter', source)
  TriggerClientEvent("core:switchcharacter", source)
end)

function createUniqueCode()
  local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `bans`")
  local generatedCode = math.random(100000, 999999)
  for i,v in pairs(result) do
   while generatedCode == v.ban_id do
    generatedCode = math.random(100000, 999999)
   end
  end
  return(generatedCode)
end

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

function addVehicle(sourcePlayer, data, price, model, seller)
  TriggerEvent('core:getPlayerFromId',source, function(user)
    local plate = randomString(8)
    local result2 = exports['GHMattiMySQL']:QueryResult("SELECT * FROM dmv_records WHERE plate = @plate", {['@plate'] = plate})
    local result = user.getVehicle(plate)
    if result == nil and not result2[1] then
      data.plate = plate
      local character = user.getIdentity()
      user.addVehicle(data, price, model)
      exports['GHMattiMySQL']:QueryAsync('INSERT INTO `dmv_records` (char_id, owner, plate) VALUES (@charid, @owner, @plate)',{['@charid'] = user.getCharacterID(), ['@owner'] = character.firstname.." "..character.lastname, ['@plate'] = data.plate})
      TriggerClientEvent("super:bought", seller, data, plate)
      TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = 'Vehicle Purchased!'})
    else
      addVehicle(sourcePlayer)
    end
  end)
end

-------------------------------------------------------------------------------------------------
-------------------------------------- NEW ADMIN COMMAND SYSTEM ---------------------------------
-------------------------------------------------------------------------------------------------

-- Warning
--[[TriggerEvent('core:addGroupCommand', 'warn', "helper", function(source, args, user)
 local source = tonumber(source) 
 if args[2] then
  if(GetPlayerName(tonumber(args[2])))then
   local player = tonumber(args[2])
   TriggerEvent("core:getPlayerFromId", player, function(target)
  local reason = args
  table.remove(reason, 1)
  table.remove(reason, 1)
  reason = table.concat(reason, " ")
  StaffMessage("^5Warned: "..GetPlayerName(player).." | Admin: "..GetPlayerName(source).." | Reason: "..reason)
  TriggerEvent("core:log", tostring("[WARN] "..GetPlayerName(source).."("..source..") warned "..GetPlayerName(player).."("..player..") for "..reason), "staff")
  TriggerClientEvent('NRP-notify:client:SendAlert', player, { type = 'error', text = "You Have Been Warned! Reason: "..reason.."",length = 20000})
  exports['GHMattiMySQL']:QueryAsync("INSERT INTO admin_history (`admin`, `user`, `action`, `when`) VALUES (@admin, @user, @action, @when)",{['@admin'] = GetPlayerIdentifier(source), ['@user'] = target.getIdentifier(), ['@action'] = "Warned: " .. reason, ['@when'] =  os.date("%d/%m/%Y %X")})
   end)
  end
 end
end)]]--

-- Kicking
TriggerEvent('core:addGroupCommand', 'kick', "helper", function(source, args, user)
 local source = tonumber(source) 
 if args[2] then
  if(GetPlayerName(tonumber(args[2])))then
   local player = tonumber(args[2])
   TriggerEvent("core:getPlayerFromId", player, function(target)
  local reason = args
  table.remove(reason, 1)
  table.remove(reason, 1)
  reason = table.concat(reason, " ")
  StaffMessage("^5Kicked: "..GetPlayerName(player).." | Admin: "..GetPlayerName(source).." Reason: "..reason)
  TriggerEvent("core:log", tostring("[KICK] "..GetPlayerName(source).."("..source..") kicked "..GetPlayerName(player).."("..player..") for "..reason), "staff")
  exports['GHMattiMySQL']:QueryAsync("INSERT INTO admin_history (`admin`, `user`, `action`, `when`) VALUES (@admin, @user, @action, @when)",{['@admin'] = user.getIdentifier(), ['@user'] = target.getIdentifier(), ['@action'] = "Kicked: " .. reason, ['@when'] = os.date("%d/%m/%Y %X")})
  DropPlayer(player, "Kicked: "..reason)
   end)
  end
 end 
end)

-- Banning

--[[TriggerEvent('core:addGroupCommand', 'ban', "helper", function(source, args, user)
  local source = tonumber(source) 
  if args[2] then
   if(GetPlayerName(tonumber(args[2])))then
    local player = tonumber(args[2])
    TriggerEvent("core:getPlayerFromId", player, function(target)
   local reason = args
   table.remove(reason, 1)
   table.remove(reason, 1)
   reason = table.concat(reason, " ")
   local playerIdentifiers = GetPlayerIdentifiers(player)
   exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM `users` WHERE `identifier` = @identifier",
   {
     ['@identifier'] = playerIdentifiers[1]
   },
   function(result)
     if result[1]['id'] ~= nil then
       for k,v in ipairs(playerIdentifiers) do
         exports['GHMattiMySQL']:QueryAsync("INSERT INTO bans (`user_id`, `identifier`, `reason`, `admin`) VALUES (@userid, @identifier, @reason, @admin)", {['@userid'] = result[1]['id'], ['@identifier'] = v, ['@reason'] = reason, ['@admin'] = user.getIdentifier()})
       end
     end
   end)
   StaffMessage("^5Banned: "..GetPlayerName(player).." | Admin: "..GetPlayerName(source).." Reason: "..reason)
   TriggerEvent("core:log", tostring("[BAN] "..GetPlayerName(source).."("..source..") banned "..GetPlayerName(player).."("..player..") for "..reason), "staff")
   exports['GHMattiMySQL']:QueryAsync("INSERT INTO admin_history (`admin`, `admin_name`, `user`, `user_name`, `action`, `when`) VALUES (@admin, @adminname, @user, @username, @action, @when)",{['@admin'] = user.getIdentifier(), ['@user'] = target.getIdentifier(), ['@action'] = "Banned: " .. reason, ['@when'] =  os.date("%d/%m/%Y %X"), ['@adminname'] = GetPlayerName(source), ['@username'] = GetPlayerName(player)})
   DropPlayer(player, "You are banned, you may appeal it at Discord.gg/ZaYvv4K | Reason: " .. reason)
    end)
   end
  end
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

RegisterServerEvent('anticheat:message')
AddEventHandler('anticheat:message', function(source, value)
  local source = tonumber(source)
  TriggerEvent("core:getPlayerFromId", source, function(user)
    TriggerEvent("core:getPlayers", function(pl)
      for k,v in pairs(pl) do
        TriggerEvent("core:getPlayerFromId", k, function(user)
          if(user.getPermissions() > 50 and k ~= source)then
            if user.isAdminEnabled() then
              TriggerClientEvent('chatMessage', k, "ANTI-CHEAT", {255, 0, 0}, GetPlayerName(source).."^0 Has Tried To Modify The Game | Value: $"..value)
            end
          end
        end)
      end
    end)
  end)
end)

-- Banning
--[[TriggerEvent('core:addGroupCommand', 'voteban', "helper", function(source, args, user)
 local source = tonumber(source) 
 local voted = false
 if args[2] then
  if(GetPlayerName(tonumber(args[2]))) then
   local player = tonumber(args[2])
   if not voteBan[player] then
    voteBan[player] = {count = 0, votes = {}}
   end
   -- Check 
   for _,v in pairs(voteBan[player].votes) do
    if v.name == GetPlayerName(source) then 
     voted = true
    end
   end
   -- Vote1
   if not voted then
    voteBan[player].count = voteBan[player].count + 1
    table.insert(voteBan[player].votes, {name = GetPlayerName(source)})
    StaffMessage("^5Admin: "..GetPlayerName(source).." Voted To Ban | "..GetPlayerName(player))
    -- Ban Him
    if voteBan[player].count >= 2 then
   TriggerEvent("core:getPlayerFromId", player, function(target)
    exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM `users` WHERE `identifier` = @identifier",{['@identifier'] = target.getIdentifier()},function(result)
     if result[1]['id'] ~= nil then
      for k,v in ipairs(GetPlayerIdentifiers(player)) do
       exports['GHMattiMySQL']:QueryAsync("INSERT INTO bans (`user_id`, `identifier`, `reason`, `admin`) VALUES (@userid, @identifier, @reason, @admin)", {['@userid'] = result[1]['id'], ['@identifier'] = v, ['@reason'] = reason, ['@admin'] = user.getIdentifier()})
      end
     end
    end)
    StaffMessage("^5Banned: "..GetPlayerName(player).." | Admin: "..GetPlayerName(source).." Reason: Vote Banned By 2x Moderators")
    TriggerEvent("core:log", tostring("[VOTE BAN] "..GetPlayerName(source).."("..source..") vote banned "..GetPlayerName(player).."("..player..")"), "staff")
    exports['GHMattiMySQL']:QueryAsync("INSERT INTO admin_history (`admin`, `user`, `action`, `when`) VALUES (@admin, @user, @action, @when)",{['@admin'] = user.getIdentifier(), ['@user'] = target.getIdentifier(), ['@action'] = "Banned: " .. reason, ['@when'] =  os.date("%d/%m/%Y %X")})
    voteBan[player] = nil 
    DropPlayer(player, "You are banned, you may appeal it at Discord.gg/ZaYvv4K | Reason: Automatic Vote System")
   end)
    end
   else
    print('You Have Already Voted')
   end
  end
 end
end)]]--

-- Kicking
TriggerEvent('core:addGroupCommand', 'votekick', "helper", function(source, args, user)
 local source = tonumber(source) 
 local voted = false
 if args[2] then
  if(GetPlayerName(tonumber(args[2]))) then
   local player = tonumber(args[2])
   if not voteKick[player] then
    voteKick[player] = {count = 0, votes = {}}
   end
   -- Check 
   for _,v in pairs(voteKick[player].votes) do
    if v.name == GetPlayerName(source) then 
     voted = true
    end
   end
   -- Vote1
   if not voted then
    voteKick[player].count = voteKick[player].count + 1
    table.insert(voteKick[player].votes, {name = GetPlayerName(source)})
    StaffMessage("^5Admin: "..GetPlayerName(source).." Voted To Kick | "..GetPlayerName(player))
    -- Ban Him
    if voteKick[player].count >= 2 then
     TriggerEvent("core:getPlayerFromId", player, function(target)
    StaffMessage("^5Kicked: "..GetPlayerName(player).." | Admin: "..GetPlayerName(source).." Reason: Vote Kicked By 2x Helpers")
    TriggerEvent("core:log", tostring("[VOTE KICK] "..GetPlayerName(source).."("..source..") vote kicked "..GetPlayerName(player).."("..player..")"), "staff")
    exports['GHMattiMySQL']:QueryAsync("INSERT INTO admin_history (`admin`, `user`, `action`, `when`) VALUES (@admin, @user, @action, @when)",{['@admin'] = user.getIdentifier(), ['@user'] = target.getIdentifier(), ['@action'] = "Kicked: " .. "Vote Kicked By 2x Helpers", ['@when'] = os.date("%d/%m/%Y %X")})
    voteKick[player].count = 0 
    DropPlayer(player, "Kicked: Automatic Vote System")
   end)
    end
   else
    print('You Have Already Voted')
   end
  end
 end
end)

-- Goto
TriggerEvent('core:addGroupCommand', 'goto', "helper", function(source, args, user)
 if args[2] then 
  if(GetPlayerName(tonumber(args[2])))then
   local player = tonumber(args[2])
   TriggerEvent("core:getPlayerFromId", source, function(user)
   TriggerEvent("core:getPlayerFromId", player, function(target)
    if(target)then
     lastlocation[source] = user.getCoords()
     TriggerClientEvent('admin:teleport', source, target.getCoords())
     TriggerClientEvent('chatMessage', player, "SYSTEM", {255, 0, 0}, "You have been teleported to by ^2" .. GetPlayerName(source))
     TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Teleported to player ^2" .. GetPlayerName(player) .. "")
     TriggerEvent("core:log", tostring("[GOTO] "..GetPlayerName(source).."("..source..") went to "..GetPlayerName(player).."("..player..")"), "staff")
  else
   TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Incorrect player ID!")
  end
   end)
   end)
  end
 end
end)

TriggerEvent('core:addGroupCommand', 'back', "helper", function(source, args, user)
 if lastlocation[source] then 
  pos = lastlocation[source]
  TriggerClientEvent('admin:teleport', source, pos)
 end
end)

AddEventHandler('playerConnecting', function()
  local identifier = PlayerIdentifier('license', source)
  local embed = {
    {
      ["color"] = 3661319,
      ["title"] = "JOIN",
      ["footer"] = {
        ["text"] = os.date('%Y-%m-%d %H:%M:%S')
      }, 
      ["fields"] = {
        {
          ["name"] = "Player",
          ["value"] = GetPlayerName(source),
          ["inline"] = false
        },
        {
          ["name"] = "Licence",
          ["value"] = identifier,
          ["inline"] = false
        }
      }
    }
  }
  PerformHttpRequest("https://discordapp.com/api/webhooks/699702380358533161/HbdOJCbWn8DCR4qkHm61cFJFEXfgicBEatUibtjooBo45RTVMQO12gd65xkGhrq-npMh", function(Error, Content, Head) end, 'POST', json.encode({username = SystemName, embeds = embed, avatar_url = SystemAvatar}), {['Content-Type'] = 'application/json'})
end)
 
AddEventHandler('playerDropped', function(reason)
  local identifier = PlayerIdentifier('license', source)
  local embed = {
    {
      ["color"] = 12062479,
      ["title"] = "LEAVE",
      ["footer"] = {
        ["text"] = os.date('%Y-%m-%d %H:%M:%S')
      }, 
      ["fields"] = {
        {
          ["name"] = "Player",
          ["value"] = GetPlayerName(source),
          ["inline"] = false
        },
        {
          ["name"] = "Licence",
          ["value"] = identifier,
          ["inline"] = false
        },
        {
          ["name"] = "Reason",
          ["value"] = reason,
          ["inline"] = false
        }
      }
    }
  }
  PerformHttpRequest("https://discordapp.com/api/webhooks/699702380358533161/HbdOJCbWn8DCR4qkHm61cFJFEXfgicBEatUibtjooBo45RTVMQO12gd65xkGhrq-npMh", function(Error, Content, Head) end, 'POST', json.encode({username = SystemName, embeds = embed, avatar_url = SystemAvatar}), {['Content-Type'] = 'application/json'})
  TriggerEvent("core:playerDropped", source)
end)

RegisterServerEvent('log:player_death')
AddEventHandler('log:player_death', function(pid, deathreason, player_name)
  local embed = {
    {
      ["color"] = 3661319,
      ["title"] = "DEATH",
      ["footer"] = {
        ["text"] = os.date('%Y-%m-%d %H:%M:%S')
      }, 
      ["fields"] = {
        {
          ["name"] = "Player",
          ["value"] = pid.." | "..player_name,
          ["inline"] = false
        },
        {
          ["name"] = "Reason",
          ["value"] = deathreason,
          ["inline"] = false
        }
      }
    }
  }
  PerformHttpRequest("https://discordapp.com/api/webhooks/713848433219338362/iDNdq8XG49TFI4ffhIp5EyeZzcwqaa9yV7_6WZCIH8jKiMnIUZLSbboISOHk4Tx44b4i", function(Error, Content, Head) end, 'POST', json.encode({username = SystemName, embeds = embed, avatar_url = SystemAvatar}), {['Content-Type'] = 'application/json'})
end)

RegisterServerEvent('log:player_killed')
AddEventHandler('log:player_killed', function(pid, player_name, kid, killer_name, deathreason)
  local embed = {
    {
      ["color"] = 3661319,
      ["title"] = "KILL",
      ["footer"] = {
        ["text"] = os.date('%Y-%m-%d %H:%M:%S')
      }, 
      ["fields"] = {
        {
          ["name"] = "Player",
          ["value"] = pid.." | "..player_name,
          ["inline"] = false
        },
        {
          ["name"] = "Killer",
          ["value"] = kid.." | "..killer_name,
          ["inline"] = false
        },
        {
            ["name"] = "Reason",
            ["value"] = deathreason,
            ["inline"] = false
        }
      }
    }
  }
  PerformHttpRequest("https://discordapp.com/api/webhooks/713848433219338362/iDNdq8XG49TFI4ffhIp5EyeZzcwqaa9yV7_6WZCIH8jKiMnIUZLSbboISOHk4Tx44b4i", function(Error, Content, Head) end, 'POST', json.encode({username = SystemName, embeds = embed, avatar_url = SystemAvatar}), {['Content-Type'] = 'application/json'})
end)

AddEventHandler('chatMessage', function(source, name, message)

  local embed = {
    {
      ["color"] = 3661319,
      ["title"] = "Chat Message",
      ["fields"] = {
        {
          ["name"] = "Character",
          ["value"] = source.." | "..name,
          ["inline"] = false
        },
        {
          ["name"] = "Message",
          ["value"] = message,
          ["inline"] = false
        }
      }
    }
  }
  PerformHttpRequest("https://discordapp.com/api/webhooks/713848561867161660/T0JQQcKt596e22nwstqXPExcLQoASXP6gorYbK0z5_gJvDrOQuU42cD6YZ2Ai_9vuwvk", function(Error, Content, Head) end, 'POST', json.encode({username = SystemName, embeds = embed, avatar_url = SystemAvatar}), {['Content-Type'] = 'application/json'})
end)

function PlayerIdentifier(type, id)
  local identifiers = {}
  local numIdentifiers = GetNumPlayerIdentifiers(id)

  for a = 0, numIdentifiers do
      table.insert(identifiers, GetPlayerIdentifier(id, a))
  end

  for b = 1, #identifiers do
      if string.find(identifiers[b], type, 1) then
          return identifiers[b]
      end
  end
  return false
end