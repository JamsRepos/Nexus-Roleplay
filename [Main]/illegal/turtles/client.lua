local poaching = false
local collecting = false

local turtle = {name = 'Turtle', price = 1250, item = 3}

local get_the_bait = {
  {x = 3611.800, y = 5026.807, z = 11.350},
}
local bait_timer = 0

turtle_zones = {
  {x = 3851.525, y = 3753.588, z = 0.830, dist = 25, drawmarker = false, markerdist = 50.0},
  {x =  3012.879, y = 1103.91, z = 0.830, dist = 25, drawmarker = false, markerdist = 50.0},
  {x = -700.228, y = -3436.810, z = 1.110, dist = 75, drawmarker = false, markerdist = 100.0},
  {x = 2343.579, y = -2285.579, z = 0.794, dist = 50, drawmarker = false, markerdist = 75.0},
  {x = 2639.362, y = -1431.073, z = 0.473, dist = 75, drawmarker = false, markerdist = 100.0},
  {x = -2050.154, y = -1036.570, z = 5.883, dist = 2.0, drawmarker = true, markerdist = 50.0},
  {x = 1299.269, y = -3326.054, z = 6.003, dist = 2.0, drawmarker = true, markerdist = 50.0},

}

function AttachEntityToPed(prop,bone_ID,x,y,z,RotX,RotY,RotZ)
    if DoesEntityExist(FishingRod) then DeleteEntity(FishingRod) end
  BoneID = GetPedBoneIndex(GetPlayerPed(-1), bone_ID)
  obj = CreateObject(GetHashKey(prop),  1729.73,  6403.90,  34.56,  true,  true,  true)
  AttachEntityToEntity(obj, GetPlayerPed(-1), BoneID, x,y,z, RotX,RotY,RotZ,  false, false, false, false, 2, true)
  return obj
end


function PlayAnim(ped,base,sub,nr,time) 
  Citizen.CreateThread(function() 
    RequestAnimDict(base) 
    while not HasAnimDictLoaded(base) do 
      Citizen.Wait(1) 
    end
    if IsEntityPlayingAnim(ped, base, sub, 3) then
      ClearPedSecondaryTask(ped) 
    else 
      for i = 1,nr do 
        TaskPlayAnim(ped, base, sub, 4.0, -1, -1, 50, 0, false, false, false)
        Citizen.Wait(time) 
      end 
    end 
  end) 
end

RegisterNetEvent('timers:character')
AddEventHandler('timers:character', function(data)
 for _,v in pairs(data) do
  if v.name == 'Turtle' then 
    bait_timer = v.value
  end
 end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
    if bait_timer > 0 then
      bait_timer = bait_timer - 1
    end
  end
end)

Citizen.CreateThread(function()
  while true do
  Citizen.Wait(10000)
    if bait_timer > 0 then
      TriggerServerEvent('turtle:update', bait_timer)
    end
  end
end)

Citizen.CreateThread(function()
  while true do
  Citizen.Wait(1)
  local rep = DecorGetInt(GetPlayerPed(-1), "Reputation")
  if not poaching and rep >= 1500 then
    for k,v in pairs(turtle_zones) do
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < v.markerdist) then
        if v.drawmarker then DrawMarker(27, v.x, v.y, v.z-0.95, 0, 0, 0, 0, 0, 0, 0.8,0.8,0.5, 252, 3, 107, 255, 0, 0, 2, 0, 0, 0, 0) end
        if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < v.dist) then
          DrawText3Ds(v.x, v.y, v.z,'~g~[E]~w~ Start Poaching')
         if IsControlJustPressed(0, 38) then
          if exports['core']:GetItemQuantity(288) >= 1 and exports['core']:GetItemQuantity(290) >= 1 then
            FreezeEntityPosition(GetPlayerPed(-1), true)
            FishingRod = AttachEntityToPed('prop_fishing_rod_01',60309, 0,0,0, 0,0,0)
            PlayAnim(GetPlayerPed(-1),'amb@world_human_stand_fishing@idle_a','idle_c',1,0)
            poaching=true
            exports['pogressBar']:drawBar(30000, 'Poaching', function()
              local chance = math.random(1, 6)
              if chance > 3 then
                local police_chance = math.random(1,10)
                if police_chance < 7 then
                  exports['NRP-notify']:DoHudText('success', 'You caught a turtle!')
                else
                  TriggerEvent('dispatch:poaching')
                  exports['NRP-notify']:DoHudText('success', 'You caught a turtle!')
                  exports['NRP-notify']:DoHudText('error', 'Someone has spotted you poaching!')
                end
                  TriggerEvent("inventory:addQty", 292, 1)
                  TriggerEvent("inventory:removeQty", 290, 1)
                  TriggerServerEvent('addReputation', 1)
              elseif chance == 1 then
                local chance2 = math.random(1, 10)
                if chance2 >= 7 then
                  TriggerEvent('dispatch:poaching')
                  exports['NRP-notify']:DoHudText('error', 'You caught nothing & someone has spotted you poaching!')
                elseif chance2 >= 2 and chance < 7 then
                  exports['NRP-notify']:DoHudText('inform', 'You found some scrap')
                  local scrap = {81, 114, 82}
                  local find = scrap[math.random(1, 3)]
                  TriggerEvent("inventory:addQty", find, math.random(1, 2))
                elseif chance2 == 1 then
                  exports['NRP-notify']:DoHudText('inform', 'You found something shiny!')
                  local shiny = {66, 128, 129}
                  local find_shiny = shiny[math.random(1,3)]
                  TriggerEvent("inventory:addQty", find_shiny, 1)
                  TriggerEvent("inventory:removeQty", 290, 1)
                end
              else
                exports['NRP-notify']:DoHudText('error', 'You caught nothing')
              end
              print(chance)
              poaching = false
              FreezeEntityPosition(GetPlayerPed(-1), false)
              ClearPedTasksImmediately(GetPlayerPed(-1))
              DeleteEntity(FishingRod)
            end)
          else
            exports['NRP-notify']:DoHudText('error', 'You do not have the right equipment to poach')
          end
           end
          end
         end
    end
  end
end
end)

  Citizen.CreateThread(function()
    while true do
     Citizen.Wait(5)
     for _,v in pairs(get_the_bait) do
      local rep = DecorGetInt(GetPlayerPed(-1), "Reputation")
      if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z) <= 1 and rep >= 1500 and not collecting then
        DrawText3Ds(v.x, v.y, v.z,'~g~[E]~w~ Retreive')
       if IsControlJustPressed(0, 38) then
        collecting = true
        if bait_timer <= 0 then
          TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_DRUG_DEALER", 0, true)
          FreezeEntityPosition(GetPlayerPed(-1), true)
          TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_DRUG_DEALER", 0, true)
          exports['pogressBar']:drawBar(30000, 'Aquiring Bait', function()
            TriggerEvent("inventory:addQty", 290, 10)
            exports['NRP-notify']:DoHudText('Success', "You have collected turtle bait")
            FreezeEntityPosition(GetPlayerPed(-1), false)
            ClearPedTasksImmediately(GetPlayerPed(-1))
            TriggerServerEvent("turtle:timer")
            collecting = false
          end)
        else
          exports['NRP-notify']:DoHudText('error', "I'm out of bait, Come back in "..bait_timer.." seconds.")
          collecting = false
        end
      end
      end
     end
    end
  end)


  Citizen.CreateThread(function()
    while true do 
    Citizen.Wait(0)
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -643.300,-1227.660, 11.547, true) < 50) then
      DrawMarker(25, -643.300,-1227.660, 11.547-0.95, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 3.0, 50, 102, 255, 200, 0, 0, 2, 0, 0, 0, 0)
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -643.300,-1227.660, 11.547, true) < 2.0) then
        DrawText3Ds(-643.300,-1227.660, 11.547,'~g~[E]~w~ Sell Turtles')
        if IsControlJustPressed(0, 38) then
          TriggerEvent("inventory:sellTurtle")
        end
      end
    end
    end
  end)  



--Citizen.CreateThread(function()
-- while true do
--  Citizen.Wait(0)
--  while IsFishing do
--   local time = 4*3000
--   TaskStandStill(GetPlayerPed(-1), time+7000)
--   FishingRod = AttachEntityToPed('prop_fishing_rod_01',60309, 0,0,0, 0,0,0)
--   PlayAnim(GetPlayerPed(-1),'amb@world_human_stand_fishing@idle_a','idle_c',1,0)
--   CFish = true
--   IsFishing = false
--  end
--  while CFish do
--   Citizen.Wait(0)
--   FishGUI()
--   if TimerAnimation <= 0 then
--    CFish = false
--    TimerAnimation = 0.2
--    ClearPedTasksImmediately(GetPlayerPed(-1))
--    DeleteEntity(FishingRod)
--    print('No Time Left')
--   end
--   if IsControlJustPressed(1, 38) then
--    if BarAnimation >= SuccessLimit then
--     Wait(10)
--     CFish = false
--     TimerAnimation = 0.2
--     ClearPedTasksImmediately(GetPlayerPed(-1))
--     DeleteEntity(FishingRod)
--     SuccessLimit = SuccessLimit+0.00025
--     local chance = math.random(1,3)
--     TriggerEvent("inventory:removeQty", 289, 1)
--     if chance == 2 then 
--      Notify('You Have Successfully Caught 1x '..catch.name)
--      TriggerEvent("inventory:addQty", catch.item, 1)
--     end
--    else
--     CFish = false
--     TimerAnimation = 0.2
--     ClearPedTasksImmediately(GetPlayerPed(-1))
--     DeleteEntity(FishingRod)
--     print('Fail')
--    end
--   end  
--  end
-- end 
--end)
--
--
--
--function FishingBlips()
--  for k,v in pairs(fishing_zones) do
--   local blip = AddBlipForCoord(v.x, v.y, v.z)
--   SetBlipSprite (blip, 88)
--   SetBlipDisplay(blip, 4)
--   SetBlipScale  (blip, 0.8)
--   SetBlipColour (blip, 3)
--   SetBlipAsShortRange(blip, true)
--   BeginTextCommandSetBlipName("STRING")
--   AddTextComponentString("Fishing Zone")
--   EndTextCommandSetBlipName(blip)
--  end
--
--  local blip2 = AddBlipForCoord(-245.244,-354.201, 29.985)
--  SetBlipSprite (blip2, 88)
--  SetBlipDisplay(blip2, 4)
--  SetBlipScale  (blip2, 0.6)
--  SetBlipColour (blip2, 3) 
--  SetBlipAsShortRange(blip2, true)
--  BeginTextCommandSetBlipName("STRING")
--  AddTextComponentString("Fish Sell Point")
--  EndTextCommandSetBlipName(blip2)
--end
--
--function AttachEntityToPed(prop,bone_ID,x,y,z,RotX,RotY,RotZ)
--    if DoesEntityExist(FishingRod) then DeleteEntity(FishingRod) end
--  BoneID = GetPedBoneIndex(GetPlayerPed(-1), bone_ID)
--  obj = CreateObject(GetHashKey(prop),  1729.73,  6403.90,  34.56,  true,  true,  true)
--  AttachEntityToEntity(obj, GetPlayerPed(-1), BoneID, x,y,z, RotX,RotY,RotZ,  false, false, false, false, 2, true)
--  return obj
--end
--
--function PlayAnim(ped,base,sub,nr,time) 
--  Citizen.CreateThread(function() 
--    RequestAnimDict(base) 
--    while not HasAnimDictLoaded(base) do 
--      Citizen.Wait(1) 
--    end
--    if IsEntityPlayingAnim(ped, base, sub, 3) then
--      ClearPedSecondaryTask(ped) 
--    else 
--      for i = 1,nr do 
--        TaskPlayAnim(ped, base, sub, 4.0, -1, -1, 50, 0, false, false, false)
--        Citizen.Wait(time) 
--      end 
--    end 
--  end) 
--end
 

