--[[

  ESX RP Chat

--]]

RegisterNetEvent('sendProximityMessage')
AddEventHandler('sendProximityMessage', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent('chatMessage', "^7[^2Local OOC^7] ^2" .. name .. ": ", {0, 153, 204}, "^7 " .. message)
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
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