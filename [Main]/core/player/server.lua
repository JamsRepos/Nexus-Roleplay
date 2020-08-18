Users = {}
commands = {}
commandSuggestions = {}
groups = {}
Group = {}
Group.__index = Group

AddEventHandler("playerConnecting", function(name, setKickReason, deferrals)
    local player = source
    local name, setKickReason, deferrals = name, setKickReason, deferrals;
    local ipIdentifier
    local identifiers = GetPlayerIdentifiers(player)
    deferrals.defer()
    Wait(0)
    deferrals.update(string.format("Hello %s. Your IP Address is being checked.", name))
    for _, v in pairs(identifiers) do
        if string.find(v, "ip") then
            ipIdentifier = v:sub(4)
            break
        end
    end
    Wait(0)
    if not ipIdentifier then
        deferrals.done("We could not find your IP Address.")
    else
        PerformHttpRequest("http://proxycheck.io/v2/" .. ipIdentifier .. "?key=06rbj9-65d161-484056-y08c3d&vpn=1&days=2", function(err, text, headers)
            if tonumber(err) == 200 then
                local tbl = json.decode((text))
				if tbl[ipIdentifier]["type"] == "VPN" then
					deferrals.done("You are using a VPN. Please disable and try again.")
                else
                    deferrals.done()
                end
            else
                deferrals.done("There was an error in the API. Please go to our Discord for support.")
            end
        end)
    end
end)

RegisterServerEvent('core:checkuser')
AddEventHandler('core:checkuser', function()
 local source = tonumber(source)
 local identifier = getIdentifiers(source)
 exports['GHMattiMySQL']:QueryResultAsync('SELECT * FROM users WHERE `identifier`=@identifier OR `discord`=@discord;', {identifier = identifier.steam, discord = identifier.discord}, function(users)
  if users[1] then
   TriggerEvent('core:playerDropped', source)
  else
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO users (`identifier`, `discord`, `name`, `license`, `ip`, `permission_level`, `group`) VALUES (@identifier, @discord, @name, @license, @ip, @permission_level, @group);', {['@identifier'] = identifier.steam, ['@discord'] = identifier.discord, ['@name'] = GetPlayerName(source), ['@license'] = identifier.license, ['@ip'] = identifier.ip, ['@permission_level'] = 0, ['@group'] = 'user'})
   TriggerEvent('core:playerDropped', source)
  end
 end)
end) 

RegisterServerEvent('core:checkjob')
AddEventHandler('core:checkjob', function()
 local source = tonumber(source)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  local job = user.getJob()
  local jobs = user.getAllJobs()
  local factions = user.getFaction()
  TriggerClientEvent("core:setjob", source, job, jobs)
  TriggerClientEvent("core:setfac", source, factions)
 end)
end)

RegisterServerEvent('core:loadplayer')
AddEventHandler('core:loadplayer', function(source)
 local Source = tonumber(source)
 exports['GHMattiMySQL']:QueryResultAsync('SELECT * FROM users WHERE `identifier`=@identifier OR `discord`=@discord;', {['@identifier'] = GetPlayerIdentifier(Source), ['@discord'] = getIdentifiers(Source).discord}, function(user)
  exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM characters WHERE `id` = @id", {['@id'] = GetActiveCharacterID(Source)}, function(character)
   if user[1] and character[1] then
	if user[1].discord == "" or user[1].discord == nil then
		user[1].discord = getIdentifiers(source).discord
	end
    Users[Source] = CreatePlayer(Source, {
     -- Player Data
     permission_level = user[1].permission_level, 
     identifier = user[1].identifier,
     discord = user[1].discord,
     license = user[1].license,
     group = user[1].group,
     watched = user[1].watched,
     -- Character Data
     id = GetActiveCharacterID(Source),
     identity = {firstname = character[1].firstname, lastname = character[1].lastname, gender = character[1].gender, dob = character[1].dob, fullname = character[1].firstname.." "..character[1].lastname},
     money = character[1].money,
	 bank = character[1].bank,
	 --dirtybank = character[1].dirtybank, 
     dirty_money = character[1].dirty_money,
     job = character[1].job,
     faction = character[1].faction,
     alive = character[1].alive,
     inventory = json.decode(character[1].inventory),
     outfit = character[1].outfit,
     vehicles = json.decode(character[1].vehicles),
     garages = json.decode(character[1].garages),
     phone_number = character[1].phone_number,
     vitals = json.decode(character[1].vitals),
	 statistics = json.decode(character[1].statistics),
	 points = json.decode(character[1].points),
	 timers = json.decode(character[1].timers),
     reputation = character[1].reputation,
     playtime = character[1].playtime,
    })
    exports['GHMattiMySQL']:QueryAsync("UPDATE `users` SET discord=@discord, character_id=@character_id, isOnline=@isonline, character_name=@character, current_id=@cid WHERE identifier=@id",{['@discord'] = user[1].discord, ['@character_id'] = GetActiveCharacterID(Source), ['@id'] = user[1].identifier, ['@isonline'] = 1, ['@character'] = character[1].firstname.." "..character[1].lastname, ['@cid'] = Source})
    Users[Source].setSessionVar('idType', 'identifier')
    TriggerEvent('core:playerLoaded', Source, Users[Source])
    TriggerClientEvent('core:setPlayerDecorator', Source, 'rank', Users[Source]:getPermissions())
    TriggerEvent('housing:load', Source)
    TriggerEvent("garage:reload", Source)
    if Users[Source]:isWatched() then 
		AlertMessage("WATCH", "^0(^2" .. GetPlayerName(Source) .." | "..Source.."^0) Has Joined The Server")
	end
	if not Users[Source]:isAlive() then
		Wait(5000)
		TriggerClientEvent('admin:kill', Source)
	end
   end
  end)
 end)
end)

RegisterServerEvent('core:playerDied')
AddEventHandler('core:playerDied', function()
 local source = tonumber(source)
 TriggerEvent("core:getPlayerFromId", source, function(user)
	exports['GHMattiMySQL']:QueryAsync("UPDATE `characters` SET alive=@alive WHERE id=@id",{['@id'] = exports['core']:GetActiveCharacterID(source), ['@alive'] = 0})
 end)
end)

RegisterServerEvent('core:playerRevived')
AddEventHandler('core:playerRevived', function()
 local source = tonumber(source)
 TriggerEvent("core:getPlayerFromId", source, function(user)
	exports['GHMattiMySQL']:QueryAsync("UPDATE `characters` SET alive=@alive WHERE id=@id",{['@id'] = exports['core']:GetActiveCharacterID(source), ['@alive'] = 1})
 end)
end)

RegisterServerEvent('core:playerDropped')
AddEventHandler('core:playerDropped', function(source)
 local source = tonumber(source)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  exports['GHMattiMySQL']:QueryAsync("UPDATE `characters` SET money=@money, bank=@bank,dirty_money=@dirty_money, position=@position, job=@job, faction=@faction, inventory=@inventory, vehicles=@vehicles, garages=@garages, outfit=@outfit, vitals=@vitals, reputation=@reputation, timers=@timers WHERE id = @id", {
   ['@id'] = user.getCharacterID(),
   ['@money'] = user.getMoney(),
   ['@bank'] = user.getBank(),
   --['@dirtybank'] = user.getDirtybank(),
   ['@dirty_money'] = user.getDirtyMoney(),
   ['@position'] = json.encode(user.getCoords()),
   ['@inventory'] = json.encode(user.getInventory()),
   ['@vehicles'] = json.encode(user.getVehicles()),
   ['@garages'] = json.encode(user.getGarages()),
   ['@outfit'] = user.getOutfit(),
   ['@job'] = user.getJob(),
   ['@faction'] = user.getFaction(),
   ['@reputation'] = user.getReputation(),
   ['@vitals'] = json.encode(user.getVitals()),
   ['@timers'] = json.encode(user.getTimers()),
  })
  exports['GHMattiMySQL']:QueryAsync("UPDATE `users` SET isOnline=@isonline, current_id=@cid WHERE identifier=@id",{['@id'] = user.getIdentifier(), ['@isonline'] = 0, ['@cid'] = 0})
  TriggerEvent('phone:removePhoneNumber', user.getPhoneNumber())
  if user.getJob() == 1 or user.getJob() == 32 or user.getJob() == 33 or user.getJob() == 34 or user.getJob() == 35 or user.getJob() == 36 or user.getJob() == 37  or user.getJob() == 90 or user.getJob() == 91 then
	TriggerClientEvent("dutylog:dutyChange", source, "police", false)
  elseif user.getJob() == 2 or user.getJob() == 50 or user.getJob() == 51 or user.getJob() == 52 or user.getJob() == 53 or user.getJob() == 54 or user.getJob() == 55 or user.getJob() == 56 or user.getJob() == 57 then
	TriggerClientEvent("dutylog:dutyChange", source, "ems", false)
  end
 end)
 Users[source] = nil
end)

RegisterServerEvent('core:characterDisconnect')
AddEventHandler('core:characterDisconnect', function()
 local source = tonumber(source)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  exports['GHMattiMySQL']:QueryAsync("UPDATE `characters` SET money=@money, bank=@bank, dirty_money=@dirty_money, position=@position, job=@job, faction=@faction, inventory=@inventory, vehicles=@vehicles, garages=@garages, outfit=@outfit, vitals=@vitals, reputation=@reputation, timers=@timers WHERE id = @id", {
   ['@id'] = user.getCharacterID(),
   ['@money'] = user.getMoney(),
   ['@bank'] = user.getBank(),
   --['@dirtybank'] = user.getDirtybank(),
   ['@dirty_money'] = user.getDirtyMoney(),
   ['@position'] = json.encode(user.getCoords()),
   ['@inventory'] = json.encode(user.getInventory()),
   ['@vehicles'] = json.encode(user.getVehicles()),
   ['@garages'] = json.encode(user.getGarages()),
   ['@outfit'] = user.getOutfit(),
   ['@job'] = user.getJob(),
   ['@faction'] = user.getFaction(),
   ['@reputation'] = user.getReputation(),
   ['@vitals'] = json.encode(user.getVitals()),
   ['@timers'] = json.encode(user.getTimers()),
  })
  TriggerClientEvent('NRP-Hud:Logout')
  if user.getJob() == 1 or user.getJob() == 32 or user.getJob() == 33 or user.getJob() == 34 or user.getJob() == 35 or user.getJob() == 36 or user.getJob() == 37  or user.getJob() == 90 or user.getJob() == 91 then
	TriggerClientEvent("dutylog:dutyChange", source, "police", false)
  elseif user.getJob() == 2 or user.getJob() == 50 or user.getJob() == 51 or user.getJob() == 52 or user.getJob() == 53 or user.getJob() == 54 or user.getJob() == 55 or user.getJob() == 56 or user.getJob() == 57 then
	TriggerClientEvent("dutylog:dutyChange", source, "ems", false)
  end
 end)
 Users[source] = nil
end)

AddEventHandler('core:getPlayers', function(cb)
 cb(Users)
end)

AddEventHandler("core:getPlayerFromId", function(user, cb)
 if(Users)then
  if(Users[user])then
   cb(Users[user])
  end
 end
end)

AddEventHandler("core:getPlayerFromIdentifier", function(identifier, cb)
 exports['GHMattiMySQL']:QueryResultAsync('SELECT * FROM users WHERE `identifier`=@identifier;', {identifier = identifier}, function(user)
  if user[1] then
   cb(user[1])
  end
 end)
end)

function getPlayerFromId(id)
 return Users[id]
end

--===================================================================--
--========================= Database Functions ======================--
--===================================================================--
function updateUser(identifier, new, callback)
 Citizen.CreateThread(function()
  local updateString = ""
  local length = tLength(new)
  local cLength = 1
  for k,v in pairs(new)do
   if cLength < length then
	if(type(v) == "number")then
	 updateString = updateString .. "`" .. k .. "`=" .. v .. ","
    else
	 updateString = updateString .. "`" .. k .. "`='" .. v .. "',"
	end
   else
	if(type(v) == "number")then
	 updateString = updateString .. "`" .. k .. "`=" .. v .. ""
	else
	 updateString = updateString .. "`" .. k .. "`='" .. v .. "'"
	end
   end
   cLength = cLength + 1
  end

  exports['GHMattiMySQL']:QueryResultAsync('UPDATE users SET ' .. updateString .. ' WHERE `identifier`=@identifier', {identifier = identifier}, function(done)
   if callback then
	callback(true)
   end
  end)
 end)
end

--===================================================================--
--============================= Needed ==============================--
--===================================================================--
function tLength(t)
	local l = 0
	for k,v in pairs(t)do
		l = l + 1
	end

	return l
end

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

function startswith(String,Start)
	return string.sub(String,1,string.len(Start))==Start
end

--===================================================================--
--============================= Groups ==============================--
--===================================================================--
setmetatable(Group, {
	__eq = function(self)
		return self.group
	end,
	__tostring = function(self)
		return self.group
	end,
	__call = function(self, group, inh, ace)
		local gr = {}

		gr.group = group
		gr.inherits = inh
		gr.aceGroup = ace

		groups[group] = gr

		for k, v in pairs(Group) do
			if type(v) == 'function' then
				gr[k] = v
			end
		end

		return gr
	end
})

function Group:canTarget(gr)
	if(gr == "")then
		return true
	elseif(self.group == 'developer')then	
		return true
	elseif(self.group == 'user')then
		if(gr == 'user')then
			return true
		else
			return false
		end
	else
		if(self.group == gr)then
			return true
		elseif(self.inherits == gr)then
			return true
		elseif(self.inherits == 'admin')then
			return true
		else
			if(self.inherits == 'user')then
				return false
			else
				return groups[self.inherits]:canTarget(gr)
			end
		end
	end
end

user = Group("user", "")
donator = Group("donator", "user")
trainee = Group("trainee", "donator")
helper = Group("helper", "trainee")
mod = Group("mod", "helper")
admin = Group("admin", "mod")
developer = Group("developer", "admin")
owner = Group("owner", "developer")

_P3 = "33f774893e"
function canGroupTarget(group, targetGroup, cb)
	if groups[group] and groups[targetGroup] then
		if cb then
			cb(groups[group]:canTarget(targetGroup))
		else
			return groups[group]:canTarget(targetGroup)
		end
	else
		if cb then
			cb(false)
		else
			return false
		end
	end
end

AddEventHandler("core:canGroupTarget", function(group, targetGroup, cb)
	canGroupTarget(group, targetGroup, cb)
end)

AddEventHandler("core:getAllGroups", function(cb)
	cb(groups)
end)

function getIdentifiers(source)
 local license
 local steam
 local ip
 local discord
 for k,v in ipairs(GetPlayerIdentifiers(source)) do
  if string.sub(v, 1, string.len("license:")) == "license:" then
   license = v
  elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
   steam = v
  elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
   ip = v
  elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
   discord = v
  end
 end
 return {license = license, steam = steam, ip = ip, discord = discord}
end


--===================================================================--
--============================= Commands ============================--
--===================================================================--
AddEventHandler('chatMessage', function(source, n, message)
	if(startswith(message, '/'))then
		local command_args = stringsplit(message, " ")

		command_args[1] = string.gsub(command_args[1], '/', "")

		local command = commands[command_args[1]]

		if(command)then
			local Source = source
			CancelEvent()
			if(command.perm > 0)then
				if(Users[source].getPermissions() >= command.perm or groups[Users[source].getGroup()]:canTarget(command.group))then
					command.cmd(source, command_args, Users[source])
					TriggerEvent("core:adminCommandRan", source, command_args, Users[source])
				else
					TriggerClientEvent('chatMessage', source, '^1Access Denied')
					TriggerEvent("core:adminCommandFailed", source, command_args, Users[source])
				end
			else
				command.cmd(source, command_args, Users[source])
				TriggerEvent("core:userCommandRan", source, command_args)
			end
			
			TriggerEvent("core:commandRan", source, command_args, Users[source])
		else
			TriggerEvent('core:invalidCommandHandler', source, command_args, Users[source])

			if WasEventCanceled() then
				CancelEvent()
			end
		end
	else
		TriggerEvent('core:chatMessage', source, message, Users[source])
	end
end)

function addCommand(command, callback, suggestion)
	commands[command] = {}
	commands[command].perm = 0
	commands[command].group = "user"
	commands[command].cmd = callback

	if suggestion then
		if not suggestion.params or not type(suggestion.params) == "table" then suggestion.params = {} end
		if not suggestion.help or not type(suggestion.help) == "string" then suggestion.help = "" end

		commandSuggestions[command] = suggestion
	end
end

AddEventHandler('core:addCommand', function(command, callback, suggestion)
	addCommand(command, callback, suggestion)
end)

function addAdminCommand(command, perm, callback, callbackfailed, suggestion)
	commands[command] = {}
	commands[command].perm = perm
	commands[command].group = "senioradmin"
	commands[command].cmd = callback
	commands[command].callbackfailed = callbackfailed

	if suggestion then
		if not suggestion.params or not type(suggestion.params) == "table" then suggestion.params = {} end
		if not suggestion.help or not type(suggestion.help) == "string" then suggestion.help = "" end

		commandSuggestions[command] = suggestion
	end
end

AddEventHandler('core:addAdminCommand', function(command, perm, callback, callbackfailed, suggestion)
	addAdminCommand(command, perm, callback, callbackfailed, suggestion)
end)

function addGroupCommand(command, group, callback, callbackfailed, suggestion)
	commands[command] = {}
	commands[command].perm = math.maxinteger
	commands[command].group = group
	commands[command].cmd = callback
	commands[command].callbackfailed = callbackfailed

	if suggestion then
		if not suggestion.params or not type(suggestion.params) == "table" then suggestion.params = {} end
		if not suggestion.help or not type(suggestion.help) == "string" then suggestion.help = "" end

		commandSuggestions[command] = suggestion
	end
end

AddEventHandler('core:addGroupCommand', function(command, group, callback, callbackfailed, suggestion)
	addGroupCommand(command, group, callback, callbackfailed, suggestion)
end)

function addACECommand(command, group, callback)
	local allowedEveryone = false
	if group == true then allowedEveryone = true end
	RegisterCommand(command, function(source, args)
		if source ~= 0 then
			callback(source, args, Users[source])
		end
	end, allowedEveryone)

	if not allowedEveryone then 
		ExecuteCommand('add_ace group.' .. group .. ' command.' .. command .. ' allow')
	end
end

AddEventHandler('core:addACECommand', function(command, group, callback)
	addACECommand(command, group, callback)
end)

RegisterServerEvent("core:afkkick")
AddEventHandler("core:afkkick", function()
	DropPlayer(source, "You were AFK for too long.")
end)
 
function getCops()
 local cops = 0
 Citizen.CreateThread(function()
  for k,v in pairs(Users)do
   if Users[k] ~= nil then
	if v.getJob() == 1 then
		cops = cops + 1
	   elseif v.getJob() == 31 then
		cops = cops + 1
	   elseif v.getJob() == 32 then
		cops = cops + 1
	   elseif v.getJob() == 33 then
		cops = cops + 1
	   elseif v.getJob() == 34 then
		cops = cops + 1
	   elseif v.getJob() == 35 then
		cops = cops + 1
	   elseif v.getJob() == 36 then
		cops = cops + 1 
	   elseif v.getJob() == 37 then
		cops = cops + 1 
	   elseif v.getJob() == 90 then
		cops = cops + 1 
	   elseif v.getJob() == 91 then
		cops = cops + 1 		
    end
   end 
  end
 end)
 return cops 
end

function getEMS()
 local ems = 0
 Citizen.CreateThread(function()
  for k,v in pairs(Users)do
   if Users[k] ~= nil then
    if v.getJob() == 2 then
	 ems = ems + 1
	elseif v.getJob() == 50 then
	 ems = ems + 1
	elseif v.getJob() == 51 then
	 ems = ems + 1
	elseif v.getJob() == 52 then
	 ems = ems + 1
	elseif v.getJob() == 53 then
	 ems = ems + 1
	elseif v.getJob() == 54 then
	 ems = ems + 1
	elseif v.getJob() == 55 then
	 ems = ems + 1 
	elseif v.getJob() == 56 then
	 ems = ems + 1 
	elseif v.getJob() == 57 then
     ems = ems + 1	
	end
   end 
  end
 end)
 return ems 
end

function getMechanics()
 local mechanics = 0
 Citizen.CreateThread(function()
  for k,v in pairs(Users)do
   if Users[k] ~= nil then
    if v.getJob() == 3 then 
	 mechanics = mechanics + 1
    end
   end 
  end
 end)
 return mechanics 
end


function AlertMessage(title, message)
 TriggerEvent("core:getPlayers", function(pl)
  for k,v in pairs(pl) do
   TriggerEvent("core:getPlayerFromId", k, function(user)
    if(user.getPermissions() > 50)then
     if user.isAdminEnabled() then
      TriggerClientEvent('chatMessage', k, title, {255, 0, 0}, tostring(message))
     end
    end
   end)
  end
 end)
end