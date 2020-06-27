RconLog({ msgType = 'serverStart', hostname = 'lovely', maxplayers = 32 })

RegisterServerEvent('rlPlayerActivated')

local names = {}

AddEventHandler('rlPlayerActivated', function()
    RconLog({ msgType = 'playerActivated', netID = source, name = GetPlayerName(source), guid = GetPlayerIdentifiers(source)[1], ip = GetPlayerEP(source) })

    names[source] = { name = GetPlayerName(source), id = source }

--    TriggerClientEvent('rlUpdateNames', GetHostId()) -- TEST ERROR FROM SCHEDULER .LUA41
end)

RegisterServerEvent('rlUpdateNamesResult')

AddEventHandler('rlUpdateNamesResult', function(res)
    if source ~= tonumber(GetHostId()) then
        print('bad guy')
        return
    end

    for id, data in pairs(res) do
        if data then
            if data.name then
                if not names[id] then
                    names[id] = data
                end

                if names[id].name ~= data.name or names[id].id ~= data.id then
                    names[id] = data

                    RconLog({ msgType = 'playerRenamed', netID = id, name = data.name })
                end
            end
        else
            names[id] = nil
        end
    end
end)

AddEventHandler('playerDropped', function()
    RconLog({ msgType = 'playerDropped', netID = source, name = GetPlayerName(source) })

    names[source] = nil
end)

AddEventHandler('chatMessage', function(netID, name, message)
    RconLog({ msgType = 'chatMessage', netID = netID, name = name, message = message, guid = GetPlayerIdentifiers(netID)[1] })
end)

AddEventHandler('rconCommand', function(commandName, args)
    if commandName == 'status' then
        for netid, data in pairs(names) do
            local guid = GetPlayerIdentifiers(netid)

            if guid and guid[1] and data then
                local ping = GetPlayerPing(netid)

                RconPrint(netid .. ' ' .. guid[1] .. ' ' .. data.name .. ' ' .. GetPlayerEP(netid) .. ' ' .. ping .. "\n")
            end
        end

        CancelEvent()
    elseif commandName:lower() == 'webkick' then
        local playerId = table.remove(args, 1)
        local msg = table.concat(args, ' ')

        TriggerEvent("core:getPlayers", function(pl)
            for k,v in pairs(pl) do
                TriggerEvent("core:getPlayerFromId", k, function(user)
                    if(user.getPermissions() > 50 and k ~= source)then
                        TriggerClientEvent('chatMessage', k, "SYSTEM", {255, 0, 0}, "Player ^2" .. GetPlayerName(playerId) .. "^0 has been kicked by ^2Website^0 for ^2" .. msg)
                    end
                end)
            end
        end)

        DropPlayer(playerId, msg)
                
        exports['GHMattiMySQL']:QueryAsync("INSERT INTO admin_history (`admin`, `user`, `action`) VALUES (@admin, @user, @action)",
        {['@admin'] = 'Website', ['@user'] = GetPlayerIdentifier(playerId), ['@action'] = msg})

        CancelEvent()
    elseif commandName:lower() == 'webban' then
        local playerId = table.remove(args, 1)
        local msg = table.concat(args, ' ')
        local playerIdentifiers = GetPlayerIdentifiers(playerId)
        local playerIdentifier = GetPlayerIdentifier(playerId)

        exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM `users` WHERE `identifier` = @identifier",
        {
            ['@identifier'] = playerIdentifiers[1]
        },
        function(result)
            if result[1]['id'] ~= nil then
                for k,v in ipairs(playerIdentifiers) do
                    exports['GHMattiMySQL']:QueryAsync("INSERT INTO bans (`user_id`, `identifier`, `reason`, `admin`) VALUES (@userid, @identifier, @reason, @admin)", 
                    {['@userid'] = result[1]['id'], ['@identifier'] = v, ['@reason'] = msg, ['@admin'] = 'Website'})
                end
            end
        end)

        TriggerEvent("core:getPlayers", function(pl)
            for k,v in pairs(pl) do
                TriggerEvent("core:getPlayerFromId", k, function(user)
                    if(user.getPermissions() > 50 and k ~= source)then
                        TriggerClientEvent('chatMessage', k, "SYSTEM", {255, 0, 0}, "Player ^2"..GetPlayerName(playerId).."^0 has been banned by ^2Website^0 for ^2" .. msg)
                    end
                end)
            end
        end)

        DropPlayer(playerId, "You are banned, you may appeal it at Discord.gg/ZaYvv4K | Reason: " .. msg)
    
        exports['GHMattiMySQL']:QueryAsync("INSERT INTO admin_history (`admin`, `user`, `action`) VALUES (@admin, @user, @action)",
        {['@admin'] = 'Website', ['@user'] = playerIdentifier, ['@action'] = "Banned: " .. msg})
        CancelEvent()
    elseif commandName == 'webcrash' then
        local playerId = table.remove(args, 1)
        TriggerClientEvent('es_admin:crash', playerId)
        CancelEvent()
    elseif commandName == 'process' then 
     local id = table.remove(args, 1)
     local fine = table.remove(args, 1)
     local jail = table.remove(args, 1)
     local charges = table.remove(args, 1)
     TriggerClientEvent('prison:process', id, fine, jail, charges)
    elseif commandName == 'asay' then
        TriggerEvent("core:getPlayers", function(pl)
            for k,v in pairs(pl) do
                TriggerEvent("core:getPlayerFromId", k, function(user)
                    if(user.getPermissions() > 50 and k ~= source)then
                        TriggerClientEvent('chatMessage', k, "AC", {255, 128, 0}, "^2WEB^0: " .. table.concat(args, " "))
                    end
                end)
            end
        end)      
        CancelEvent()
    elseif commandName == '' then
        CancelEvent()
    end
end)
