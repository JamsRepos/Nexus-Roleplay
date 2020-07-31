local neededVehicles = {}
local currentPolice = 0
local chop_locations = {
 {x = 144.939, y = -3081.098, z = 5.896},
}

local list_locations = {
 {x = 109.301, y = -2016.146, z = 18.406},
}


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

Citizen.CreateThread(function()
 while true do
  Wait(5)
  if currentPolice >= 0 then 
   for _,v in pairs(chop_locations) do
    if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x,v.y,v.z, true) < 20) and IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
     DrawMarker(27, v.x,v.y,v.z-0.95, 0, 0, 0, 0, 0, 0, 2.0,2.0,0.5, 0, 82, 165, 240, 0, 0, 2, 0, 0, 0, 0)
     if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x,v.y,v.z, true) < 2.2) then 
      drawTxt('~b~Press ~g~E~b~ To Chop Vehicle')
      if IsControlJustPressed(0, 38) then 
       local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
       for id,v in pairs(neededVehicles) do
        if GetEntityModel(vehicle) == v.model then 
         if not exports['core']:HasKey(GetVehicleNumberPlateText(vehicle)) then
          if not v.chopped then  
           TriggerServerEvent('chopshop:scrap', id, GetVehicleNumberPlateText(vehicle))
           SetEntityAsMissionEntity(vehicle, true, true)
           DeleteVehicle(vehicle)
           DeleteVehicle(vehicle)
           ExecuteCommand('dv')
           if ProgressBar('Chopping Vehicle', 55) then
            giveParts()
           end
          end
         else 
          TriggerEvent('chatMessage', '^1You Cannot Chop Your Own Vehicle')
         end
        end
       end
      end
     end
    end
   end

   for _,v in pairs(list_locations) do 
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x,v.y,v.z, true) < 20) and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
     DrawMarker(27, v.x,v.y,v.z-0.98, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 0, 82, 165, 240, 0, 0, 2, 0, 0, 0, 0)
     if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x,v.y,v.z, true) < 1.2) then 
      drawTxt('~b~Press ~g~E~b~ To Get Chop List')
      if IsControlJustPressed(0, 38) then 
       TriggerServerEvent('chopshop:getVehicleList')
      end
     end
    end
   end
  end
 end
end)

RegisterNetEvent('chopshop:vehicleList')
AddEventHandler('chopshop:vehicleList', function(list)
 neededVehicles = list 
end)

function giveParts()
 TriggerServerEvent('addReputation', 1)
 for i=1, 5 do
  if i == 1 then 
   if math.random(1,3) > 2 then 
    TriggerEvent("inventory:addQty", 52, 1)
   end
  elseif i == 2 then 
   if math.random(1,6) > 2 then 
    TriggerEvent("inventory:addQty", 53, 1)
   end
  elseif i == 3 then 
   if math.random(1,4) > 2 then 
    TriggerEvent("inventory:addQty", 54, math.floor(1,2))
   end
  elseif i == 4 then 
   if math.random(1,7) > 2 then 
    TriggerEvent("inventory:addQty", 55, math.floor(1,5))
   end
  elseif i == 5 then 
   if math.random(1,8) > 2 then 
    TriggerEvent("inventory:addQty", 56, math.floor(1,5))
   end   
  end
 end
 if reputation > 25 then
  TriggerEvent("inventory:addQty", 53, 1)
  TriggerEvent("inventory:addQty", 54, math.floor(1,2))
  TriggerEvent("inventory:addQty", 55, math.floor(1,5))
 end
end

RegisterNetEvent('hud:updatepresence')
AddEventHandler('hud:updatepresence', function(copss)
 currentPolice = copss
end)

