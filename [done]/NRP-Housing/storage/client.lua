Citizen.CreateThread(function()
 while true do
  Wait(5)
  if lastipl ~= nil then
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), lastipl.item_storage.x, lastipl.item_storage.y, lastipl.item_storage.z, true) < 25) then
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), lastipl.item_storage.x, lastipl.item_storage.y, lastipl.item_storage.z, true) < 1.2) then
      DrawText3Ds(lastipl.item_storage.x, lastipl.item_storage.y, lastipl.item_storage.z,'~g~[E]~w~ Storage ')
     if IsControlJustPressed(0, 38) then
      if currentHouse.id == 1841 or currentHouse.id == 1842 or currentHouse.id == 1843 or currentHouse.id == 1844 or currentHouse.id == 1845 then
        exports['NRP-notify']:DoHudText('error', 'This is a show room, you cannot access this.')
      else
        local t, distance = GetClosestInstancedPlayer()
        if(distance ~= -1 and distance < 2) then
          exports['NRP-notify']:DoHudText('error', 'Player near the storage, tell them to move back.')
        else
          TriggerServerEvent("housing:storage:getInventory", currentHouse.id, lastipl.storage)
        end
      end
     end
    end
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
end
