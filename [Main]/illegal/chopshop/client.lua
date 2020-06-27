local currentPolice = 0
local guiEnabled = false
local chopPossibility = nil
local activeChop = false

local Car1 = nil
local Car2 = nil
local Car3 = nil
local Car4 = nil
local Car5 = nil
local Car6 = nil
local Car7 = nil
local Car8 = nil
local Car9 = nil
local Car10 = nil

RegisterNetEvent('choplist:sendlist')
AddEventHandler('choplist:sendlist', function(car1, car2, car3, car4, car5, car6, car7, car8, car9, car10)
 Car1 = car1
 Car2 = car2
 Car3 = car3
 Car4 = car4
 Car5 = car5
 Car6 = car6
 Car7 = car7
 Car8 = car8
 Car9 = car9
 Car10 = car10
end)

Citizen.CreateThread(function()
 while true do
  local coords = GetEntityCoords(GetPlayerPed(-1))
  Wait(5)
  if currentPolice >= 0 then
   if(GetDistanceBetweenCoords(coords, 163.835, -1674.880, 29.774, true) < 10.0) and not IsPedInAnyVehicle(GetPlayerPed(-1)) then
    DrawMarker(27, 163.835, -1674.880, 29.774-0.95, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 255, 255, 0, 240, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(coords, 163.835, -1674.880, 29.774, true) < 1.5) then
      DrawText3Ds(163.835, -1674.880, 29.774,'~g~[E]~w~ Choplist')
     if IsControlJustPressed(0, 38) then
      if not activeChop then
       TriggerEvent('chopshop:randomchop')
       exports['NRP-notify']:DoHudText('inform', "You have been given the latest choplist! Press K to view it!")
       TriggerServerEvent('chopshop:getlist', chopPossibility)
       activeChop = true
      else
        exports['NRP-notify']:DoHudText('inform', "You already have already got an active Choplist! Press K to view it!")
     end
    end
   end
  end
  if IsControlJustPressed(0, 311) and activeChop then
   TriggerServerEvent('chopshop:openlist', chopPossibility)
  end
  if currentPolice >= 0 then
   if(GetDistanceBetweenCoords(coords, 152.694, -1673.939, 29.680, true) < 10.0) and IsPedInAnyVehicle(GetPlayerPed(-1)) and activeChop then
    DrawMarker(27, 152.694, -1673.939, 29.680-0.95, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 0, 82, 165, 240, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(coords, 152.694, -1673.939, 29.680, true) < 1.5) then
      DrawText3Ds(152.694, -1673.939, 29.680,'~g~[E]~w~ Chop Vehicle')
     if IsControlJustPressed(0, 38) then
       if GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1)))) == Car1 then
        Car1 = "COMPLETE"
        DeleteVehicle()
        giveParts()
        exports['NRP-notify']:DoHudText('inform', "You have chopped a vehicle!")
        completedChops()
       elseif GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1)))) == Car2 then
        Car2 = "COMPLETE"
        DeleteVehicle()
        giveParts()
        exports['NRP-notify']:DoHudText('inform', "You have chopped a vehicle!")
        completedChops()
       elseif GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1)))) == Car3 then
        Car3 = "COMPLETE"
        DeleteVehicle()
        giveParts()
        exports['NRP-notify']:DoHudText('inform', "You have chopped a vehicle!")
        completedChops()
       elseif GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1)))) == Car4 then
        Car4 = "COMPLETE"
        DeleteVehicle()
        giveParts()
        exports['NRP-notify']:DoHudText('inform', "You have chopped a vehicle!")
        completedChops()
       elseif GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1)))) == Car5 then
        Car5 = "COMPLETE"
        DeleteVehicle()
        giveParts()
        exports['NRP-notify']:DoHudText('inform', "You have chopped a vehicle!")
        completedChops()
       elseif GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1)))) == Car6 then
        Car6 = "COMPLETE"
        DeleteVehicle()
        giveParts()
        exports['NRP-notify']:DoHudText('inform', "You have chopped a vehicle!")
        completedChops()
       elseif GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1)))) == Car7 then
        Car7 = "COMPLETE"
        DeleteVehicle()
        giveParts()
        exports['NRP-notify']:DoHudText('inform', "You have chopped a vehicle!")
        completedChops()
       elseif GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1)))) == Car8 then
        Car8 = "COMPLETE"
        DeleteVehicle()
        giveParts()
        exports['NRP-notify']:DoHudText('inform', "You have chopped a vehicle!")
        completedChops()
       elseif GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1)))) == Car9 then
        Car9 = "COMPLETE"
        DeleteVehicle()
        giveParts()
        exports['NRP-notify']:DoHudText('inform', "You have chopped a vehicle!")
        completedChops()
       elseif GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1)))) == Car10 then
        Car10 = "COMPLETE"
        DeleteVehicle()
        giveParts()
        exports['NRP-notify']:DoHudText('inform', "You have chopped a vehicle!")
        completedChops()
       else

        exports['NRP-notify']:DoHudText('inform', "The vehicle you are attempting to chop is not on your list!")
       end
     end
    end
   end
  end
 end
end
end)

RegisterNUICallback('escape', function() 
 if guiEnabled then 
  EnableGui(false)
  guiEnabled = false
 end
end)

RegisterNetEvent('choplist:load')
AddEventHandler('choplist:load', function(text, pageg)
 guiEnabled = not guiEnabled
 page = pageg
 EnableGui(guiEnabled, text)
end)

function completedChops()
 if Car1 == "COMPLETE" and Car2 == "COMPLETE" and Car3 == "COMPLETE"and Car4 == "COMPLETE" and Car5 == "COMPLETE" and Car6 == "COMPLETE" and Car7 == "COMPLETE"and Car8 == "COMPLETE" and Car9 == "COMPLETE" and Car10 == "COMPLETE" then
  activeChop = false
  exports['NRP-notify']:DoHudText('inform', "You have completed your choplist, please return to the office to recieve a new one!")
  Car1 = nil
  Car2 = nil
  Car3 = nil
  Car4 = nil
  Car5 = nil
  Car6 = nil
  Car7 = nil
  Car8 = nil
  Car9 = nil
  Car10 = nil
 end
end

function DeleteVehicle()
  local car = GetVehiclePedIsIn(GetPlayerPed(-1), false )
  SetEntityAsMissionEntity(car, true, true)
  Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(car))
end

function EnableGui(enable, txt)
 SetNuiFocus(enable, false)
 SendNUIMessage({type = "enableui", enable = enable, text = txt})
 if enable then 
  if not IsPedInAnyVehicle(PlayerPedId(), false) then
   TaskStartScenarioInPlace(PlayerPedId(), "CODE_HUMAN_MEDIC_TIME_OF_DEATH", 0, false)
  end
 else 
  if not IsPedInAnyVehicle(PlayerPedId(), false) then
   ClearPedTasksImmediately(PlayerPedId())
  end
 end
end 

RegisterNetEvent('chopshop:randomchop')
AddEventHandler('chopshop:randomchop', function()
 if chopPossibility == nil then
  chopPossibility = math.random(1,1)
 else
  local tempchop = chopPossibility
  chopPossibility = math.random(1,1)
  if chopPossibility == tempchop then
   randomChop()
  else
   tempchop = nil
  end
 end
end)

function giveParts()
 TriggerServerEvent('addReputation', 3)
 for i=1, 5 do
  if i == 1 then 
   if math.random(1,10) <= 6 then 
    TriggerEvent("inventory:addQty", 52, 1)
   end
  elseif i == 2 then 
   if math.random(1,10) <= 5 then 
    TriggerEvent("inventory:addQty", 53, 1)
   end
  elseif i == 3 then 
   if math.random(1,10) <= 10 then 
    TriggerEvent("inventory:addQty", 54, math.floor(1,2))
   end
  elseif i == 4 then 
   if math.random(1,10) <= 5 then 
    TriggerEvent("inventory:addQty", 55, math.floor(1,5))
   end
  elseif i == 5 then 
   if math.random(1,10) <= 1 then 
    TriggerEvent("inventory:addQty", 114, math.floor(1,2))
   end   
  end
 end
 if DecorGetInt(GetPlayerPed(-1), "Reputation") > 1000 then
  TriggerEvent("inventory:addQty", 53, 1)
  TriggerEvent("inventory:addQty", 54, math.floor(2,4))
  TriggerEvent("inventory:addQty", 55, math.floor(2,7))
  TriggerEvent("inventory:addQty", 114, math.floor(2,4))
 end
end

RegisterNetEvent('hud:updatepresence')
AddEventHandler('hud:updatepresence', function(copss)
 currentPolice = copss
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