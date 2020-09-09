RegisterServerEvent("bounty:GiveItem")
AddEventHandler("bounty:GiveItem", function(x,y,z)
  local myPed = GetPlayerPed(source)
	local myPos = GetEntityCoords(myPed)
	local dist = #(vector3(x,y,z) - myPos)
	if dist <= 3 then
    TriggerClientEvent("inventory:addQty", source, 308, 1)
  else
		TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = 'Nice try'})
	end
end)

RegisterServerEvent("bounty:GiveItem:elite")
AddEventHandler("bounty:GiveItem:elite", function(x,y,z)
  local myPed = GetPlayerPed(source)
	local myPos = GetEntityCoords(myPed)
	local dist = #(vector3(x,y,z) - myPos)
	if dist <= 3 then
    TriggerClientEvent("inventory:addQty", source, 309, 1)
  else
		TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = 'Nice try'})
	end
end)

RegisterNetEvent('bounty:updatetable')
AddEventHandler('bounty:updatetable', function(bool)
    TriggerClientEvent('bounty:synctable', -1, bool)
end)

RegisterServerEvent("bounty:syncMission")
AddEventHandler("bounty:syncMission", function(missionData)
	local missionData = missionData
	TriggerClientEvent('bounty:syncMissionClient', -1, missionData)
end)

RegisterServerEvent('bounty:selltags')
AddEventHandler('bounty:selltags', function(payout)
    TriggerEvent('core:getPlayerFromId', source, function(user)
        user.addDirtyMoney(payout)
      end)
end)

RegisterServerEvent('bounty:moneylog')
AddEventHandler('bounty:moneylog', function(text)
    TriggerEvent("core:moneylog", source, text)
end)
