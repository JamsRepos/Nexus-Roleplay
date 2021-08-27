
local weedDealer = nil 
local moonshineDealer = nil 
local cokeDealer = nil 

Citizen.CreateThread(function()
 while true do
  local coords = GetEntityCoords(GetPlayerPed(-1))
  Wait(5)
  if currentPolice > 0 then
   if(GetDistanceBetweenCoords(coords, 1009.5, -3196.6, -38.99682, true) < 10.0) then
    DrawMarker(27, 1009.5, -3196.6, -38.99682-0.96, 0, 0, 0, 0, 0, 0, 1.6,1.6,0.5, 232, 210, 132, 155, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(coords, 1009.5, -3196.6, -38.99682, true) < 1.5) then
     drawTxt('~m~[~g~E~m~] Bottle Moonshine')
     if IsControlJustPressed(0, 38) then
      ProgressBar('Bottling Moonshine', 85)
      Citizen.Wait(6250)
      TriggerEvent("inventory:addQty", 77, math.random(1,3))
     end
    end
   end
  end
  -- Enter And Exiting Weed Farm
  if(GetDistanceBetweenCoords(coords, -575.363, -1623.843, 33.011, true) < 20) then
    DrawMarker(27, -575.363, -1623.843, 33.011-0.95, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 255,255,0,20, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(coords, -575.363, -1623.843, 33.011, 19.784, true) < 1.2) then
     drawTxt('~m~[~g~E~m~] Enter')
     if IsControlJustPressed(0, 38) then
      Teleport(997.286, -3200.582, -36.394)
     end
    end
   elseif (GetDistanceBetweenCoords(coords, 997.286, -3200.582, -36.394, true) < 20) then
    DrawMarker(27, 997.286, -3200.582, -36.394-0.95, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 255,255,0,20, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(coords, 997.286, -3200.582, -36.394, true) < 1.2) then
     drawTxt('~m~[~g~E~m~] Exit')
     if IsControlJustPressed(0, 38) then
      Teleport(-575.363, -1623.843, 33.011)
     end
    end
   end
  end
 end)

--[[Citizen.CreateThread(function()
 while true do
  Wait(5)
  if currentPolice >= 0 then 
   local pos = GetEntityCoords(GetPlayerPed(-1), true)
   rped = GetRandomPedAtCoord(pos['x'], pos['y'], pos['z'], 1.3, 1.35, 1.35, 3, _r)
   if DoesEntityExist(rped) and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
    if exports['core']:GetItemQuantity(77) > 0 then
     drawTxt('~m~[~g~E~m~]Offer Moonshine')
     if IsControlJustPressed(0, 38) then
      TaskStandStill(rped, 7000)
      TaskStartScenarioInPlace(GetPlayerPed(-1), 'PROP_HUMAN_ATM', false, true)
      ProgressBar('Offering Moonshine', 55)
      Citizen.Wait(6250)
      if math.random(1,100) > 60 then
       TriggerEvent('dispatch:cds')
       exports['EGRP_notify']:DoHudText('error', 'Offer Rejected, The Civillian Has Called The Police')
      else
       sellMoonshine()
      end
      ClearPedTasksImmediately(rped)
      ClearPedTasksImmediately(GetPlayerPed(-1))
      Wait(5000)
      DeleteEntity(rped)
      nearNPC = false
     end
    end
   end
  end
 end
end)]]--

Citizen.CreateThread(function()
  while true do
    Wait(5)
    local pos = GetEntityCoords(GetPlayerPed(-1), true)
    rped = GetRandomPedAtCoord(pos['x'], pos['y'], pos['z'], 1.3, 1.35, 1.35, 3, _r)
    if DoesEntityExist(rped) and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
      if exports['core']:GetItemQuantity(77) > 0 then
        DrawText3Ds(pos['x'], pos['y'], pos['z']-0.30,'~g~[E]~w~ Offer Moonshine')
        if IsControlJustPressed(0, 38) then
          if currentPolice > -1 then
            local randomizer = math.random(0,100)
            if randomizer >= 80 then
              rpped = rped
              TriggerEvent('dispatch:cds')
              exports['NRP-notify']:DoHudText('error', 'Offer Rejected, The Civillian Has Called The Police')
              SetEntityAsMissionEntity(rped)
              ClearPedTasksImmediately(rpped)
              SetPedAsNoLongerNeeded(rpped)
              TriggerServerEvent('removeReputation', 1)
            else 
              rpped = rped
              SetEntityAsMissionEntity(rped)
              TaskStartScenarioInPlace(GetPlayerPed(-1), 'prop_human_parking_meter', false, true)
              TaskStartScenarioInPlace(rped, 'prop_human_parking_meter', false, true)
              Wait(6000)
              ClearPedTasksImmediately(rpped)
              ClearPedTasksImmediately(GetPlayerPed(-1))
              sellMoonshine()
              SetPedAsNoLongerNeeded(rpped)
            end 
          else
            exports['NRP-notify']:DoHudText('inform',  "Not Enough Police In Town")
          end
        end
      end
    end
  end
end)

function sellMoonshine()
local moonshine = exports['core']:GetItemQuantity(77)
local moonshinePricePerBag = math.random(10, 15)
if moonshine > 0 then -- and or > 5
  local moonshineSoldBags = math.random(1, moonshine) --- remove and just put 1
  if moonshine >= 7 then
    moonshineSoldBags = math.random(1, 7)
   end     
 local moonshineSoldPrice = math.floor(moonshineSoldBags * moonshinePricePerBag* currentMultipler) 
 exports['NRP-notify']:DoHudText('inform',  "You Sold " .. moonshineSoldBags .." Gram(s) Of Moonshine For $".. moonshineSoldPrice .." ")
 TriggerEvent("inventory:removeQty", 77, moonshineSoldBags)
 TriggerServerEvent('drug:addmoney', moonshineSoldPrice)
 TriggerServerEvent('addReputation', 1)
 end
end

--[[function sellMoonshine()
  local moonshine = exports['core']:GetItemQuantity(77)
  local moonshinePriceBottle = 0

  if moonshine > 0 then 
   if reputation > 1200 then 
    moonshinePriceBottle = math.random(20,30)
   else
    moonshinePriceBottle = math.random(5,15)
   end
   local moonshineSold = math.random(1, moonshine)
   if moonshine >= 8 then
    moonshineSold = math.random(1, 7)
   end
   local moonshineSoldPrice = math.floor(moonshineSold * moonshinePriceBottle * exports['core']:getVat(21) * currentMultipler) 
   exports['EGRP_notify']:DoHudText('inform',  "You Sold " .. moonshineSold .." Bottles Of Moonshine For $".. moonshineSoldPrice)
   TriggerEvent("inventory:removeQty", 77, moonshineSold)
   TriggerServerEvent('drug:addmoney', moonshineSoldPrice)
   TriggerServerEvent('addReputation', 1)
  end
end]]--