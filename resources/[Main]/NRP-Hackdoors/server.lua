local doorInfo = {}
RegisterServerEvent('doorlock:updateState')
AddEventHandler('doorlock:updateState', function(doorID, state)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', -1, function(user)
	if type(doorID) ~= 'number' then
		print(('doorlock: %s didn\'t send a number!'):format(user.identifier))
		return
	end
	if type(state) ~= 'boolean' then
		print(('doorlock: %s attempted to update invalid state!'):format(user.identifier))
		return
	end
	if not Config.DoorList[doorID] then
		print(('doorlock: %s attempted to update invalid door!'):format(user.identifier))
		return
	end
	doorInfo[doorID] = state
	TriggerClientEvent('doorlock:setState', -1, doorID, state)
 end)	
end)
