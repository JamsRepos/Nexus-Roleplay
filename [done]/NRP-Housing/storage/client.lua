Citizen.CreateThread(function()
 while true do
  Wait(5)
  if lastipl ~= nil then
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), lastipl.item_storage.x, lastipl.item_storage.y, lastipl.item_storage.z, true) < 25) then
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), lastipl.item_storage.x, lastipl.item_storage.y, lastipl.item_storage.z, true) < 1.2) then
      DrawText3Ds(lastipl.item_storage.x, lastipl.item_storage.y, lastipl.item_storage.z,'~g~[E]~w~ Storage ')
     if IsControlJustPressed(0, 38) then
      TriggerServerEvent("housing:storage:getInventory", currentHouse.id, lastipl.storage)
     end
    end
   end
  end
 end
end)

function GetClosestPlayer()
  local players = GetPlayers()
  local closestDistance = -1
  local closestPlayer = -1
  local ply = GetPlayerPed(-1)
  local plyCoords = GetEntityCoords(ply, 0)
  
  for index,value in ipairs(players) do
      local target = GetPlayerPed(value)
      if(target ~= ply) then
          local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
          local distance = Vdist(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"])
          if(closestDistance == -1 or closestDistance > distance) then
              closestPlayer = value
              closestDistance = distance
          end
      end
  end
  
  return closestPlayer, closestDistance
end

function GetPlayers()
  local players = {}

  for i = 0, 255 do
      if NetworkIsPlayerActive(i) then
          table.insert(players, i)
      end
  end

  return players
end

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
