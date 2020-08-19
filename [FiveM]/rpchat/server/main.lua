
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

RegisterCommand('roll', function(source, args, user)
    TriggerEvent("core:getPlayerFromId", source, function(user)
        local name = user.getIdentity()
        fal = name.firstname .. " " .. name.lastname
        local rolled = "rolled a "..math.random(1, 6).." and a "..math.random(1, 6).."."
        TriggerEvent("core:log", tostring("[DICE] " .. fal .. "(".. source ..") rolled: " .. rolled), "chat")
        TriggerClientEvent("NRP-Games:roll", source)
        TriggerClientEvent("sendProximityMessageDice", -1, source, fal, rolled)
    end)
end)

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

RegisterCommand('lspd', function(source, args, rawCommand)	
    TriggerEvent("core:getPlayerFromId", source, function(user)	
        if user.getJob() == 1 or user.getJob() == 32 or user.getJob() == 33 or user.getJob() == 34 or user.getJob() == 35 or user.getJob() == 36 or user.getJob() == 37 or user.getJob() == 90 or user.getJob() == 91 then
            local msg = rawCommand:sub(5)	
            local name = user.getIdentity()	
            fal = "LSPD"
            TriggerEvent("core:log", tostring("[LSPD ANNOUNCEMENTS] " .. name.firstname .. " " .. name.lastname	 .. "(".. source ..") said: " .. msg), "twitter")	
            TriggerClientEvent('chat:addMessage', -1, {	
                template = '<div style="padding: 0.5vw; background-color: rgba(28, 31, 77, 0.6); border-radius: 3px;"><i class="fab fa-twitter"></i> @{0}<br> {1}</div>',	
                args = { fal, msg }	
            })	
        end
    end)	
end, false)	

RegisterCommand('mech', function(source, args, rawCommand)	
    TriggerEvent("core:getPlayerFromId", source, function(user)	
        if user.getJob() == 3 or user.getJob() == 38 then
            local msg = rawCommand:sub(5)	
            local name = user.getIdentity()	
            fal = "Mechanic"
            TriggerEvent("core:log", tostring("[MECHANIC ANNOUNCEMENTS] " .. name.firstname .. " " .. name.lastname	 .. "(".. source ..") said: " .. msg), "twitter")	
            TriggerClientEvent('chat:addMessage', -1, {	
                template = '<div style="padding: 0.5vw; background-color: rgba(120, 70, 12, 0.6); border-radius: 3px;"><i class="fab fa-twitter"></i> @{0}<br> {1}</div>',	
                args = { fal, msg }	
            })	
        end
    end)	
end, false)	

RegisterCommand('lsa', function(source, args, rawCommand)	
    TriggerEvent("core:getPlayerFromId", source, function(user)	
        if user.getJob() == 13 then
            local msg = rawCommand:sub(3)	
            local name = user.getIdentity()	
            fal = "Los Santos Attorneys"
            TriggerEvent("core:log", tostring("[LSA ANNOUNCEMENTS] " .. name.firstname .. " " .. name.lastname	 .. "(".. source ..") said: " .. msg), "twitter")	
            TriggerClientEvent('chat:addMessage', -1, {	
                template = '<div style="padding: 0.5vw; background-color: rgba(120, 70, 12, 0.6); border-radius: 3px;"><i class="fab fa-twitter"></i> @{0}<br> {1}</div>',	
                args = { fal, msg }	
            })	
        end
    end)	
end, false)	

RegisterCommand('d8', function(source, args, rawCommand)	
    TriggerEvent("core:getPlayerFromId", source, function(user)	
        if user.getFaction() == 30 then
            local msg = rawCommand:sub(2)	
            local name = user.getIdentity()	
            fal = "Dynasty 8"
            TriggerEvent("core:log", tostring("[D8 ANNOUNCEMENTS] " .. name.firstname .. " " .. name.lastname	 .. "(".. source ..") said: " .. msg), "twitter")	
            TriggerClientEvent('chat:addMessage', -1, {	
                template = '<div style="padding: 0.5vw; background-color: rgba(47, 189, 34, 0.6); border-radius: 3px;"><i class="fab fa-twitter"></i> @{0}<br> {1}</div>',	
                args = { fal, msg }	
            })	
        end
    end)	
end, false)	

RegisterCommand('ems', function(source, args, rawCommand)
    TriggerEvent("core:getPlayerFromId", source, function(user)	
        if user.getJob() == 51 or user.getJob() == 52 or user.getJob() == 53 or user.getJob() == 54 or user.getJob() == 55 then
            local msg = rawCommand:sub(5)	
            local name = user.getIdentity()	
            fal = "EMS"
            TriggerEvent("core:log", tostring("[EMS ANNOUNCEMENTS] " .. name.firstname .. " " .. name.lastname	 .. "(".. source ..") said: " .. msg), "twitter")	
            TriggerClientEvent('chat:addMessage', -1, {	
                template = '<div style="padding: 0.5vw; background-color: rgba(163, 0, 79, 0.6); border-radius: 3px;"><i class="fab fa-twitter"></i> @{0}<br> {1}</div>',	
                args = { fal, msg }	
            })	
        end
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

RegisterCommand('r', function(source, args, rawCommand)
    TriggerEvent("core:getPlayerFromId", source, function(user)
        if user.getJob() == 1 or user.getJob() == 31 or user.getJob() == 32 or user.getJob() == 33 or user.getJob() == 34 or user.getJob() == 35 or user.getJob() == 36 or user.getJob() == 37 or user.getJob() == 90 or user.getJob() == 91 or user.getJob() == 2 or user.getJob() == 50 or user.getJob() == 51 or user.getJob() == 52 or user.getJob() == 53 or user.getJob() == 54 or user.getJob() == 55 or user.getJob() == 56 or user.getJob() == 57 then
            local msg = rawCommand:sub(3)
            local name = user.getIdentity()
            fal = name.firstname .. " " .. name.lastname
            TriggerEvent("core:log", tostring("[RADIO] " .. fal .. "(".. source ..") said: " .. msg), "chat")

            Citizen.CreateThread(function()
                TriggerEvent('core:getPlayers', function(Users)
                    for k,v in pairs(Users)do
                        local job = Users[k]:getJob()
                        if job == 1 or job == 31 or job == 32 or job == 33 or job == 34 or job == 35 or job == 36 or job == 37 or job == 90 or job == 91 or job == 2 or job == 50 or job == 51 or job == 52 or job == 53 or job == 54 or job == 55 or job == 56 or job == 57 then
                            TriggerClientEvent('chat:addMessage', k, {
                                template = '<div style="padding: 0.5vw; background-color: rgba(200, 0, 0, 0.6); border-radius: 3px;"><i class="fa fa-taxi"></i> {0}:<br> {1}</div>',
                                args = { fal, msg }
                            })
                        end
                    end
                end)
            end)
        else
            TriggerClientEvent('chatMessage', source, "RADIO", {255, 0, 0}, " You are not a police officer or an EMS.")
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