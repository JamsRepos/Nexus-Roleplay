--[[

  ESX RP Chat

--]]

local ooc = true 

RegisterNetEvent('sendProximityMessage')
AddEventHandler('sendProximityMessage', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId and ooc then
    TriggerEvent('chatMessage', "^7[^2Local OOC^7] ^2" .. name .. ": ", {0, 153, 204}, "^7 " .. message)
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 and ooc then
    TriggerEvent('chatMessage', "^7[^2Local OOC^7] ^2" .. name .. ": ", {0, 153, 204}, "^7 " .. message)
  end
end)

RegisterNetEvent('sendProximityMessageMe')
AddEventHandler('sendProximityMessageMe', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent('chatMessage', "^7[^3Action^7] ^2" .. name .. " ", {0, 153, 204}, "^3 " .. message)
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
    TriggerEvent('chatMessage', "^7[^3Action^7] ^2" .. name .. " ", {0, 153, 204}, "^3 " .. message)
  end
end)

RegisterNetEvent('sendProximityMessageDice')
AddEventHandler('sendProximityMessageDice', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent('chatMessage', "^7[^5Dice^7] ^5" .. name .. " ", {0, 153, 204}, "^5 " .. message)
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 9.999 then
    TriggerEvent('chatMessage', "^7[^5Dice^7] ^5" .. name .. " ", {0, 153, 204}, "^5 " .. message)
  end
end)

RegisterCommand('toggleooc', function()
  if ooc then 
    ooc = false
    exports['NRP-notify']:DoHudText('error', 'Local OOC Toggled Off')
  else
    ooc = true
    exports['NRP-notify']:DoHudText('success', 'Local OOC Toggled On')
  end
end)