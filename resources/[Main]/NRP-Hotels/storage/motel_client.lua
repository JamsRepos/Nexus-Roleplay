local box_inventory = {}
local storedcash = 0
local weapon_inv = {}

Citizen.CreateThread(function()
 while true do
  Wait(5)
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 151.268, -1003.089, -99.000, true) < 25) and inHotel then
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 151.268, -1003.089, -99.000, true) < 0.5) then
      DrawText3Ds(151.268, -1003.089, -99.000, "~g~[E]~w~ Storage")
     if IsControlJustPressed(0, 38) then
      TriggerServerEvent("motel:storage:getInventory", currentHotel.id)
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
RegisterNetEvent('motel:storage:updateitems')
AddEventHandler('motel:storage:updateitems', function(items, weapons)
 box_inventory = items

end)

RegisterNetEvent('motel:storage:check')
AddEventHandler('motel:storage:check', function(id, item,name,quantity)
  print(id, item,name,quantity)
  local meta = "This Item Contains No Meta Data"
     if tonumber(quantity) + getHousingQuantity() <= 50 then
      TriggerServerEvent('motel:storage:additems', id, item, name, quantity,meta)
    else
      exports['NRP-notify']:DoHudText('error', 'Max Storage: 50 items')
    end
end)


function getHousingQuantity()
 local quantity = 0
 for i=1,#box_inventory do
  quantity = quantity + box_inventory[i].q
 end
 return quantity
end


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

  for _, player in ipairs(GetActivePlayers()) do
    table.insert(players, player)
  end

  return players
end