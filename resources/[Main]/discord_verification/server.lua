local mysql_notReady = true
local attempts = {}
Citizen.CreateThread(function()
	while mysql_notReady do
		Citizen.Wait(1000)
		MySQL.ready(function ()
			mysql_notReady = false
		end)
	end
end)

AddEventHandler('playerConnecting', function(name, setCallback, deferrals)
    deferrals.defer()
    deferrals.update(config.checkingInfo)
	local _s = source

    Citizen.Wait(100)

	local ids = GetPlayerIdentifiers(_s)
	local steamid
	for i in ipairs(ids) do
		if(string.find(ids[i], "steam:") ~= nil) then
			steamid = ids[i]
		end
	end
    
    if steamid then
        deferrals.done()
    else
        deferrals.done(config.noEntry)
    end
end)

RegisterServerEvent('core:characterloaded')
AddEventHandler('core:characterloaded', function()
	local _s = source
	local ids = GetPlayerIdentifiers(source)
	local steamid
	for i in ipairs(ids) do
		if(string.find(ids[i], "steam:") ~= nil) then
			steamid = ids[i]
		end
	end

	if(mysql_notReady == true) then TriggerClientEvent('SkayVerifier:clientCheck') return end
	
	MySQL.Async.fetchAll('SELECT * FROM ' .. config.tableName .. ' WHERE steam_id = @sid', {['@sid'] = steamid}, function(rows)
    	if(rows[1] == nil) then TriggerClientEvent('SkayVerifier:toggleChecker', _s, true) end
	end)
end)

RegisterNetEvent('SkayVerifier:checkPlayer')
AddEventHandler('SkayVerifier:checkPlayer', function()
	local _s = source
	local ids = GetPlayerIdentifiers(source)
	local steamid
	for i in ipairs(ids) do
		if(string.find(ids[i], "steam:") ~= nil) then
			steamid = ids[i]
		end
	end

	if(mysql_notReady == true) then TriggerClientEvent('SkayVerifier:clientCheck') return end
	
	MySQL.Async.fetchAll('SELECT * FROM ' .. config.tableName .. ' WHERE steam_id = @sid', {['@sid'] = steamid}, function(rows)
    	if(rows[1] == nil) then TriggerClientEvent('SkayVerifier:toggleChecker', _s, true) end
	end)

end)

RegisterNetEvent('SkayVerifier:checkCode')
AddEventHandler('SkayVerifier:checkCode', function(code)
	local _s = source
	local givenCode = code
	local ids = GetPlayerIdentifiers(source)
	local steamid
	for i in ipairs(ids) do
		if(string.find(ids[i], "steam:") ~= nil) then
			steamid = ids[i]
		end
	end
	MySQL.Async.fetchAll('SELECT * FROM ' .. config.tableName .. ' WHERE code = @code AND steam_id IS null', {['@code'] = givenCode}, function(rows)
		if(#rows == 0) then
			if(attempts[steamid] == nil) then
				attempts[steamid] = 1
			else
				attempts[steamid] = attempts[steamid] + 1
				if(attempts[steamid] >= config.attempts) then
					DropPlayer(_s, config.tooManyWrongs)
					attempts[steamid] = nil
					return
				end
			end
			TriggerClientEvent('SkayVerifier:giveError', _s, config.attempts - attempts[steamid])
		elseif(#rows ~= 0) then
			MySQL.Async.execute('UPDATE SkayVerifier SET steam_id = @steamid WHERE code = @code', {['@steamid'] = steamid, ['@code'] = givenCode})
			TriggerClientEvent('SkayVerifier:toggleChecker', _s, false)
		end
	end)
end)

RegisterNetEvent('SkayVerifier:giveFalse')
AddEventHandler('SkayVerifier:giveFalse', function()
	local _s = source
	TriggerClientEvent('SkayVerifier:toggleChecker', _s, false)
end)

