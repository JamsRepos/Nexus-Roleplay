local allIDs = {}
local policeID = {}
local policeTarget = nil

RegisterNUICallback('confirmsale', function(data, cb) 
  TriggerServerEvent('fakeids:create', data.newname, data.newjob, data.newdob, data.newgender)
  _GuiEnabled = false
  SetNuiFocus(false)
  SendNUIMessage({open = false})
  cb('ok')
end)

RegisterNUICallback('escape', function()
  _GuiEnabled = false
  SetNuiFocus(false)
  SendNUIMessage({open = false})
end)

RegisterNetEvent('fakeids:polrefresh')
AddEventHandler('fakeids:polrefresh', function(character, t)
 policeTarget = t
 policeID = character
 Wait(10)
 WarMenu.OpenMenu('policesearch')
end)

RegisterNetEvent('fakeids:refresh')
AddEventHandler('fakeids:refresh', function(fakeids)
 allIDs = fakeids
end)

RegisterNetEvent('fakeids:openmenu')
AddEventHandler('fakeids:openmenu', function()
 TriggerServerEvent('fakeids:allids')
 Wait(10)
 WarMenu.OpenMenu('fakeids')
end)

RegisterNUICallback('escape', function(data, cb)
  _GuiEnabled = false
  SetNuiFocus(false)
  SendNUIMessage({open = false})
  cb('ok')
end)

function ShowPurchase()  
 _GuiEnabled = true
 SetNuiFocus(true, true)
 SendNUIMessage({open = true})
end

Citizen.CreateThread(function()
 WarMenu.CreateMenu('fakeids', 'Fake IDs')
 WarMenu.CreateMenu('policesearch', 'Found IDs')
 while true do
  Citizen.Wait(5)
  local coords = GetEntityCoords(GetPlayerPed(-1))
  if WarMenu.IsMenuOpened('fakeids') then
   for ind,v in pairs(allIDs) do
    if WarMenu.Button(v.newname) then
     TriggerServerEvent('fakeids:showid', v.id, v.newname, v.gender, v.newdob, v.newjob)
     if 90 <= math.random(1, 100) then
      ExecuteCommand('me notices small smudge on given ID')
      WarMenu.CloseMenu()
    end
         WarMenu.Display()
      end      
  end
end
 if WarMenu.IsMenuOpened('policesearch') then
   for ind,v in pairs(policeID) do
    if WarMenu.Button(v.newname) then
     TriggerServerEvent('fakeids:showid', v.id, v.newname, v.gender, v.newdob, v.newjob)
    end
   end
    if WarMenu.Button("Confiscate IDs") then
     TriggerServerEvent('fakeids:confiscate', policeTarget)
     WarMenu.CloseMenu()
    end
   end
   WarMenu.Display()

 if DecorGetInt(GetPlayerPed(-1), "Reputation") >= 1500 then
  if(GetDistanceBetweenCoords(coords, 1164.630, -3191.682, -39.008, true) < 10.0) then
   DrawMarker(27, 1164.630, -3191.682, -39.008-0.98, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 255, 255, 0, 100, 0, 0, 2, 0, 0, 0, 0)
   if(GetDistanceBetweenCoords(coords, 1164.630, -3191.682, -39.008, true) < 1.5) then
    API_DrawTxt('~m~Press ~g~E ~m~To Create Fake ID')
    if IsControlJustPressed(0, 38) then
     ShowPurchase()
    end
   end
  end
 end
end
end)