inMenu			= true
local atbank	= false
local banks = {
  { x= 349.29, y=-994.97, z= -99.1 }
}	

Citizen.CreateThread(function()
 while true do
  Wait(5)
  if nearBank() then
   if IsControlJustPressed(0, 38) then
    inMenu = true
    SetNuiFocus(true, true)
    SendNUIMessage({type = 'openGeneral'})
    TriggerServerEvent('bank:balance2')
   end
  end 
 end
end)
function DrawText3Ds(x,y,z, text)
  local onScreen,_x,_y=World3dToScreen2d(x,y,z)
  local px,py,pz=table.unpack(GetGameplayCamCoords())
  
  SetTextScale(0.35, 0.35)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextColour(255, 255, 255, 215)
  SetTextEntry("STRING")
  SetTextCentre(1)
  AddTextComponentString(text)
  DrawText(_x,_y)
  --local factor = (string.len(text)) / 370
  --DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end
RegisterNetEvent('banking:updateBalance2')
AddEventHandler('banking:updateBalance2', function(balance, playerName)
 SendNUIMessage({type = "balanceHUD", balance = balance, player = playerName})
end)

RegisterNUICallback('deposit2', function(data)
 if nearBank() == true then
  TriggerServerEvent('bank:deposit2', tonumber(data.amount))
  TriggerServerEvent('bank:balance2')
 else
  TriggerClientEvent('bank:result2', source, "error", "invalid amount.")
 end
end)

RegisterNUICallback('withdrawl2', function(data)
 if nearBank() == true then 
  TriggerServerEvent('bank:withdraw2', tonumber(data.amountw))
  TriggerServerEvent('bank:balance2')	
 end
end)

RegisterNUICallback('balance2', function()
	TriggerServerEvent('bank:balance2')
end)

RegisterNetEvent('balance:back2')
AddEventHandler('balance:back2', function(balance)
	SendNUIMessage({type = 'balanceReturn', bal = balance})
end)

RegisterNUICallback('transfer2', function(data)
	TriggerServerEvent('bank:transfer2', tonumber(data.player), tonumber(data.amount))
end)

RegisterNetEvent('bank:result2')
AddEventHandler('bank:result2', function(type, message)
	SendNUIMessage({type = 'result', m = message, t = type})
end)

RegisterNUICallback('NUIFocusOff', function()
	inMenu = false
	SetNuiFocus(false, false)
	SendNUIMessage({type = 'closeAll'})
end)

function nearBank()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)
	
	for _, search in pairs(banks) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
		
    if distance <= 0.8 then
      DrawText3Ds(search.x, search.y, search.z-0.95,"~g~[E]~w~ Stash Dirty Money")
			return true
		end
	end
end


function drawTxt(text)
  SetTextFont(0)
  SetTextProportional(0)
  SetTextScale(0.32, 0.32)
  SetTextColour(0, 255, 255, 255)
  SetTextDropShadow(0, 0, 0, 0, 255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextCentre(1)
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(0.5, 0.93)
end
