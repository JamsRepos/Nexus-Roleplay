local voipRange = 5.0
local isTalking = false 

DecorRegister('currentCallID', 3)
DecorRegister("isInCall", 2)
DecorRegister("isInService", 2)

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(500)
  for i = 0, 255 do
   if NetworkIsPlayerActive(i) then 
    local otherPed, serverID = GetPlayerPed(i), GetPlayerServerId(i)
    if GetDistanceBetweenCoords(GetEntityCoords(otherPed), GetEntityCoords(PlayerPedId()), true) <= voipRange then 
     SendVoiceToPlayer(i, true)
    elseif DecorGetBool(PlayerPedId(), 'isInCall') then 
     if DecorGetInt(PlayerPedId(), 'currentCallID') == DecorGetInt(otherPed, 'currentCallID') then 
      SendVoiceToPlayer(i, true)
     end
    else 
     SendVoiceToPlayer(i, false)
    end
   end
  end
 end
end)


function SendVoiceToPlayer(intPlayer, boolSend)
 Citizen.InvokeNative(0x97DD4C5944CC2E6A, intPlayer, boolSend)
 NetworkOverrideSendRestrictions(intPlayer, boolSend)
end

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
  if IsControlPressed(1, 21) and IsControlJustPressed(1, 74) then 
   updateVOIPRange()
  elseif IsControlPressed(1, 74) and IsControlPressed(1, 21) then 
   local pos = GetEntityCoords(PlayerPedId(), true)
   DrawMarker(28, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, voipRange+0.00, voipRange+0.00, voipRange+0.00, 0, 128, 255, 100, false, false, 0, true, nil, nil, false)
  end
 end
end) 

function updateVOIPRange()
 if voipRange == 5.0 then 
  voipRange = 8.0
  DecorSetInt(PlayerPedId(), 'voipRange', 2)
 elseif voipRange == 8.0 then 
  voipRange = 16.0
  DecorSetInt(PlayerPedId(), 'voipRange', 3)
 elseif voipRange == 16.0 then 
  voipRange = 5.0 
  DecorSetInt(PlayerPedId(), 'voipRange', 1)
 end
end

AddEventHandler('playerSpawned', function()
 DecorSetInt(PlayerPedId(), 'voipRange', 2)
 DecorSetBool(PlayerPedId(), "isInService", false)
 DecorSetBool(PlayerPedId(), "isInCall", false)
 DecorSetBool(PlayerPedId(), "hudStatus", true)
 NetworkSetTalkerProximity(-1000.0)

 for i = 0, 255 do
  SendVoiceToPlayer(i, false) 
 end
end)
