RegisterServerEvent('baseevents:onPlayerDied')
RegisterServerEvent('baseevents:onPlayerKilled')
RegisterServerEvent('baseevents:onPlayerWasted')
RegisterServerEvent('baseevents:enteringVehicle')
RegisterServerEvent('baseevents:enteringAborted')
RegisterServerEvent('baseevents:enteredVehicle')
RegisterServerEvent('baseevents:leftVehicle')

AddEventHandler('baseevents:onPlayerKilled', function(killedBy, data)
	local victim = source

	RconLog({msgType = 'playerKilled', victim = victim, attacker = killedBy, data = data})
end)

AddEventHandler('baseevents:onPlayerDied', function(killedBy, pos)
	local victim = source

	RconLog({msgType = 'playerDied', victim = victim, attackerType = killedBy, pos = pos})
end)

AddEventHandler('baseevents:enteredVehicle', function(veh, seat, displayName, class)
 if (class >= 0 and class <= 7) or (class >= 9 and class <= 12) or (class >= 17 and class <= 20) then
  TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = 'Press B to Buckle Your SeatBelt', length = 3000})  
 end
end)
