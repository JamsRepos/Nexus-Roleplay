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

RegisterNetEvent('bounty:updatetable')
AddEventHandler('bounty:updatetable', function(bool)
    TriggerClientEvent('bounty:synctable', -1, bool)
end)

RegisterServerEvent("bounty:syncMission")
AddEventHandler("bounty:syncMission", function(missionData)
	local missionData = missionData
	TriggerClientEvent('bounty:syncMissionClient', -1, missionData)
end)

RegisterServerEvent("bounty:delivery")
AddEventHandler("bounty:delivery", function()
    local check = xPlayer.getInventoryItem('dogtags').count

    if check >= 1 then
      TriggerClientEvent("inventory:removeQty", source, 308, 1)
      TriggerEvent('core:getPlayerFromId', source, function(user)
        if not Config.useDirtyMoney then
          user.addMoney(Config.reward)
        else
          user.addDirtyMoney(Config.reward)
        end
      end)
    	 TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = '$'..Config.reward..' received'})
    else
    	TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = 'You do not have any Dog Tags'})
    end
end)

-- call this function if you want to print the table in server console - (debugging)
function tprint (tbl, indent)
  if not indent then indent = 0 end
  for k, v in pairs(tbl) do
    formatting = string.rep("  ", indent) .. k .. ": "
    if type(v) == "table" then
      print(formatting)
      tprint(v, indent+1)
    elseif type(v) == 'boolean' then
      print(formatting .. tostring(v))
    else
      print(formatting .. v)
    end
  end
end

