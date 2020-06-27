
local frozen = false

AddEventHandler('chatMessage', function(source, name, message)
      if string.sub(message, 1, string.len("/")) ~= "/" then
        TriggerEvent("core:getPlayerFromId", source, function(user)
            local name = user.getIdentity()
            fal = name.firstname .. " " .. name.lastname
            TriggerClientEvent("sendProximityMessage", -1, source, fal, message)
        end)
      end
      CancelEvent()
  end)

RegisterCommand('me', function(source, args, user)
    TriggerEvent("core:getPlayerFromId", source, function(user)
        local name = user.getIdentity()
        fal = name.firstname .. " " .. name.lastname
        TriggerEvent("core:log", tostring("[ME] " .. fal .. "(".. source ..") did: " .. table.concat(args, " ")), "chat")
        TriggerClientEvent("sendProximityMessageMe", -1, source, fal, table.concat(args, " "))
    end)
end)


 RegisterCommand('tweet', function(source, args, rawCommand)
    TriggerEvent("core:getPlayerFromId", source, function(user)
        local msg = rawCommand:sub(6)
        local name = user.getIdentity()
        fal = name.firstname .. " " .. name.lastname
        TriggerEvent("core:log", tostring("[TWITTER] " .. fal .. "(".. source ..") tweeted: " .. msg), "twitter")
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div style="padding: 0.5vw; background-color: rgba(28, 160, 242, 0.6); border-radius: 3px;"><i class="fab fa-twitter"></i> @{0}:<br> {1}</div>',
            args = { fal, msg }
        })
    end)
end, false)

RegisterCommand('anontweet', function(source, args, rawCommand)
    TriggerEvent("core:getPlayerFromId", source, function(user)
        local msg = rawCommand:sub(11)
        local name = user.getIdentity()
        fal = name.firstname .. " " .. name.lastname
        TriggerEvent("core:log", tostring("[ANON TWITTER] " .. fal .. "(".. source ..") tweeted: " .. msg), "twitter")
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div style="padding: 0.5vw; background-color: rgba(28, 160, 242, 0.6); border-radius: 3px;"><i class="fab fa-twitter"></i> @Anonymous:<br> {1}</div>',
            args = { fal, msg }
        })
    end)
end, false)

RegisterCommand('ad', function(source, args, rawCommand)
    TriggerEvent("core:getPlayerFromId", source, function(user)
        local msg = rawCommand:sub(4)
        local name = user.getIdentity()
        fal = name.firstname .. " " .. name.lastname
        TriggerEvent("core:log", tostring("[ADVERT] " .. fal .. "(".. source ..") advertised: " .. msg), "chat")
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div style="padding: 0.5vw; background-color: rgba(214, 168, 0, 1); border-radius: 3px;"><i class="fas fa-ad"></i> Advertisement:<br> {1}<br></div>',
            args = { fal, msg }
        })
    end)
end, false)

TriggerEvent('core:addGroupCommand', 'freezechat', "helper", function(source, args, user)
    if frozen then
        frozen = false
    else
        frozen = true
    end
    TriggerEvent("core:getPlayers", function(pl)
     for k,v in pairs(pl) do
       TriggerEvent("core:getPlayerFromId", k, function(user)
            if frozen then
                TriggerClientEvent('chatMessage', k, "FREEZE", {255, 0, 0}, " ^2" .. GetPlayerName(source) .." ("..source..")^0 has frozen OOC.")
            else
                TriggerClientEvent('chatMessage', k, "FREEZE", {255, 0, 0}, " ^2" .. GetPlayerName(source) .." ("..source..")^0 has un-frozen OOC.")
            end
       end)
     end
   end)
end)

RegisterCommand('ooc', function(source, args, rawCommand)
    TriggerEvent("core:getPlayerFromId", source, function(user)
        if frozen then
            TriggerClientEvent('chatMessage', source, "FREEZE", {255, 0, 0}, " OOC is currently frozen, please use local OOC.")
        else
            local msg = rawCommand:sub(5)
            local name = user.getIdentity()
            fal = name.firstname .. " " .. name.lastname
            TriggerEvent("core:log", tostring("[OOC] " .. fal .. "(".. source ..") said: " .. msg), "chat")
            TriggerClientEvent('chat:addMessage', -1, {
                template = '<div style="padding: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 3px;"><i class="fas fa-globe"></i> {0}:<br> {1}</div>',
                args = { fal, msg }
            })
        end
    end)
end, false)


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
