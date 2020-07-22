local weedThirst = 0
local growthTimer = 0
local weedThirst2 = 0
local growthTimer2 = 0
local weedPlanted = false 
local weedPlanted2 = false 
local currentPolice = 0

local weed_cooldowntimer = 0
local ammonia_cooldowntimer = 0
local cyclopentyl_cooldowntimer = 0
local magnesium_cooldowntimer = 0
local methylamine_cooldowntimer = 0
local heroin_cooldowntimer = 0
local cocaine_cooldowntimer = 0

RegisterNetEvent('timers:character')
AddEventHandler('timers:character', function(data)
 for _,v in pairs(data) do
  if v.name == 'Weed' then 
    weed_cooldowntimer = v.value
  elseif v.name == 'Ammonia' then
    ammonia_cooldowntimer = v.value
  elseif v.name == 'Cyclopentyl' then 
    cyclopentyl_cooldowntimer = v.value
  elseif v.name == 'Magnesium' then 
    magnesium_cooldowntimer = v.value
  elseif v.name == 'Methylamine' then 
    methylamine_cooldowntimer = v.value
  elseif v.name == 'Heroin' then 
    heroin_cooldowntimer = v.value
  elseif v.name == 'Cocaine' then 
    cocaine_cooldowntimer = v.value
  end
 end
end)

Citizen.CreateThread(function()
  while true do
  Citizen.Wait(10000)
    if weed_cooldowntimer > 0 or ammonia_cooldowntimer > 0 or cyclopentyl_cooldowntimer > 0 or magnesium_cooldowntimer > 0 or methylamine_cooldowntimer > 0 or heroin_cooldowntimer > 0 or cocaine_cooldowntimer > 0 then
      TriggerServerEvent('timers:set', weed_cooldowntimer, ammonia_cooldowntimer, cyclopentyl_cooldowntimer, magnesium_cooldowntimer, methylamine_cooldowntimer, heroin_cooldowntimer, cocaine_cooldowntimer)
    end
  end
 end)

RegisterCommand('plant', function(source, args, rawCommand)
 local ped = PlayerPedId()
 if GetDistanceBetweenCoords(GetEntityCoords(ped), 1059.991, -3199.147, -39.154) <= 11 then 
  if not IsPedInAnyVehicle(ped, false) and not weedPlanted then 
   if exports['core']:GetItemQuantity(118) > 0 then
    local pos = GetEntityCoords(ped)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_GARDENER_PLANT", 0, true)
    TriggerEvent('weed:plant', {x = pos.x, y = pos.y, z = pos.z}, ped)
    TriggerEvent("inventory:removeQty", 118, 1)
    Wait(10000)
    ClearPedTasks(ped)
   else 
    TriggerEvent('chatMessage', "WEED", {27, 186, 0}, " You need a weed seed to start the cultivation process.")
   end 
  end
 else 
  TriggerEvent('chatMessage', "WEED", {27, 186, 0}, " You need to be in the growery to plant a seed.")
 end
end)

RegisterCommand('plant2', function(source, args, rawCommand)
 local ped = PlayerPedId()
 if GetDistanceBetweenCoords(GetEntityCoords(ped), 1059.991, -3199.147, -39.154) <= 11 then 
  if not IsPedInAnyVehicle(ped, false) and not weedPlanted2 then 
   if exports['core']:GetItemQuantity(118) > 0 then
    local pos = GetEntityCoords(ped)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_GARDENER_PLANT", 0, true)
    TriggerEvent('weed:plant2', {x = pos.x, y = pos.y, z = pos.z}, ped)
    TriggerEvent("inventory:removeQty", 118, 1)
    Wait(10000)
    ClearPedTasks(ped)
   else 
    TriggerEvent('chatMessage', "WEED", {27, 186, 0}, " You need a weed seed to start the cultivation process.")
   end 
  end
 else 
  TriggerEvent('chatMessage', "WEED", {27, 186, 0}, " You need to be in the growery to plant a seed.")
 end
end)

RegisterNetEvent('weed:plant')
AddEventHandler('weed:plant', function(pos, ped)
 local weedStageOne = true
 local weedStageTwo = false 
 local weedStageThree = false
 local weedFertilized = false
 weedThirst = 0 
 weedPlanted = true
 growthTimer = 300
 while weedStageOne do
  Wait(5) 
  local coords = GetEntityCoords(ped)
  if not weedFertilized then 
    if GetDistanceBetweenCoords(coords, pos.x, pos.y, pos.z, true) < 1 then 
      DrawText3Ds(pos.x, pos.y, pos.z,'~w~[~g~E~w~] Fertilize')
      if exports['core']:GetItemQuantity(16) > 0 then 
        if IsControlJustPressed(0, 38) then  
          weedFertilized = true
          TriggerEvent("inventory:removeQty", 16, 1) 
          Wait(200)
        end    
      end
    end
  end
  -- Water
  if weedFertilized and weedThirst < 75 and IsPedOnFoot(ped) then 
    if GetDistanceBetweenCoords(coords, pos.x, pos.y, pos.z, true) < 1 then 
      DrawText3Ds(pos.x, pos.y, pos.z,'~w~[~g~E~w~] Water')
    if exports['core']:GetItemQuantity(13) > 0 then 
     if IsControlJustPressed(0, 38) then 
      weedThirst = 100 
      TriggerEvent("inventory:removeQty", 13, 1)
     end
    end
   end
  end
  if weedThirst > 25 and growthTimer == 200 then 
   weedStageOne = false 
   weedStageTwo = true
  end
 end
 -- Stage 2
 if weedStageTwo then 
  local _, worldZ = GetGroundZFor_3dCoord(pos.x, pos.y, pos.z)
  local weedPlant = CreateObject(GetHashKey('prop_weed_02'), pos.x, pos.y, worldZ+0.40, true, true, true)
  local weedPlantPot = CreateObject(GetHashKey('prop_oiltub_01'), pos.x, pos.y, worldZ, true, true, true)
  FreezeEntityPosition(weedPlant, true)
  FreezeEntityPosition(weedPlantPot, true)
  SetEntityAsMissionEntity(weedPlantPot, true, true)
  SetEntityAsMissionEntity(weedPlant, true, true)
  while weedStageTwo do 
   Wait(5)
   local coords = GetEntityCoords(ped)
   if GetDistanceBetweenCoords(coords, pos.x, pos.y, pos.z, true) < 1 and IsPedOnFoot(ped) then 
     DrawText3Ds(pos.x, pos.y, pos.z,'~w~Water: ~g~'..weedThirst..'% ~w~| Growth: ~g~'..growthTimer..'%') 
    if weedThirst < 45 then 
     if GetDistanceBetweenCoords(coords, pos.x, pos.y, pos.z, true) < 1 and IsPedOnFoot(ped) then 
      DrawText3Ds(pos.x, pos.y, pos.z-0.5,'~w~[~g~E~w~] Water')
      if exports['core']:GetItemQuantity(13) > 0 then 
      if IsControlJustPressed(0, 38) then 
       weedThirst = weedThirst + 55 
       TriggerEvent("inventory:removeQty", 13, 1)
       end
      end
     end
    end
   end
   if growthTimer < 1 then
   	DeleteObject(weedPlant)
    DeleteObject(weedPlantPot)
    weedStageThree = true 
    weedStageTwo = false 
   end
  end
 end

 -- Weed Stage 3
 if weedStageThree then 
  local _, worldZ = GetGroundZFor_3dCoord(pos.x, pos.y, pos.z)
  local weedPlant = CreateObject(GetHashKey('prop_weed_01'), pos.x, pos.y, worldZ+0.40, true, true, true)
  local weedPlantPot = CreateObject(GetHashKey('prop_oiltub_01'), pos.x, pos.y, worldZ, true, true, true)
  FreezeEntityPosition(weedPlant, true)
  FreezeEntityPosition(weedPlantPot, true)
  SetEntityAsMissionEntity(weedPlantPot, true, true)
  SetEntityAsMissionEntity(weedPlant, true, true)
  while weedStageThree do 
   Wait(5)
   local coords = GetEntityCoords(ped)
   if GetDistanceBetweenCoords(coords, pos.x, pos.y, pos.z, true) < 1 then 
    DrawText3Ds(pos.x, pos.y, pos.z,'~w~[~g~E~w~]Cut Down') 
    if IsControlJustPressed(0, 38) then 
     TriggerEvent("inventory:addQty", 120,math.random(3,6))
     TriggerEvent('chatMessage', "WEED", {27, 186, 0}, "You have cropped your Plant")
     DeleteObject(weedPlant)
     DeleteObject(weedPlantPot)
     weedPlant = nil
     weedPlanted = false 
     weedThirst = 0 
	   growthTimer = 0
	   weedStageThree = false 
    end
   end
  end
 end
end)


RegisterNetEvent('weed:plant2')
AddEventHandler('weed:plant2', function(pos, ped)
 local weedStageOne = true
 local weedStageTwo = false 
 local weedStageThree = false
 local weedFertilized = false
 weedThirst2 = 0 
 weedPlanted2 = true
 growthTimer2 = 300
 while weedStageOne do
  Wait(5) 
  local coords = GetEntityCoords(ped)
  if not weedFertilized then 
    if GetDistanceBetweenCoords(coords, pos.x, pos.y, pos.z, true) < 1 then 
      DrawText3Ds(pos.x, pos.y, pos.z,'~w~[~g~E~w~]Fertilize')
      if exports['core']:GetItemQuantity(16) > 0 then 
        if IsControlJustPressed(0, 38) then  
          weedFertilized = true
          TriggerEvent("inventory:removeQty", 16, 1) 
          Wait(200)
        end    
      end
    end
  end
  -- Water
  if weedFertilized and weedThirst2 < 75 and IsPedOnFoot(ped) then 
    if GetDistanceBetweenCoords(coords, pos.x, pos.y, pos.z, true) < 1 then 
      DrawText3Ds(pos.x, pos.y, pos.z,'~w~[~g~E~w~]Water')
    if exports['core']:GetItemQuantity(13) > 0 then 
     if IsControlJustPressed(0, 38) then 
      weedThirst2 = 100 
      TriggerEvent("inventory:removeQty", 13, 1)
     end
    end
   end
  end
  if weedThirst2 > 25 and growthTimer2 == 200 then 
   weedStageOne = false 
   weedStageTwo = true
  end
 end
 -- Stage 2
 if weedStageTwo then 
  local _, worldZ = GetGroundZFor_3dCoord(pos.x, pos.y, pos.z)
  local weedPlant2 = CreateObject(GetHashKey('prop_weed_02'), pos.x, pos.y, worldZ+0.40, true, true, true)
  local weedPlantPot2 = CreateObject(GetHashKey('prop_oiltub_01'), pos.x, pos.y, worldZ, true, true, true)
  FreezeEntityPosition(weedPlant2, true)
  FreezeEntityPosition(weedPlantPot2, true)
  SetEntityAsMissionEntity(weedPlantPot2, true, true)
  SetEntityAsMissionEntity(weedPlant2, true, true)
  while weedStageTwo do 
   Wait(5)
   local coords = GetEntityCoords(ped)
   if GetDistanceBetweenCoords(coords, pos.x, pos.y, pos.z, true) < 1 and IsPedOnFoot(ped) then 
     DrawText3Ds(pos.x, pos.y, pos.z,'~w~Water: ~g~'..weedThirst2..'% ~w~| Growth: ~g~'..growthTimer2..'%') 
    if weedThirst2 < 45 then 
     if GetDistanceBetweenCoords(coords, pos.x, pos.y, pos.z, true) < 1 and IsPedOnFoot(ped) then 
      DrawText3Ds(pos.x, pos.y, pos.z-0.5,'~w~[~g~E~w~]Water')
      if exports['core']:GetItemQuantity(13) > 0 then 
      if IsControlJustPressed(0, 38) then 
       weedThirst2 = weedThirst2 + 55 
       TriggerEvent("inventory:removeQty", 13, 1)
       end
      end
     end
    end
   end
   if growthTimer2 < 1 then
   	DeleteObject(weedPlant2)
    DeleteObject(weedPlantPot2)
    weedStageThree = true 
    weedStageTwo = false 
   end
  end
 end
 -- Weed Stage 3
  if weedStageThree then 
  local _, worldZ = GetGroundZFor_3dCoord(pos.x, pos.y, pos.z)
  local weedPlant2 = CreateObject(GetHashKey('prop_weed_01'), pos.x, pos.y, worldZ+0.40, true, true, true)
  local weedPlantPot2 = CreateObject(GetHashKey('prop_oiltub_01'), pos.x, pos.y, worldZ, true, true, true)
  FreezeEntityPosition(weedPlant2, true)
  FreezeEntityPosition(weedPlantPot2, true)
  SetEntityAsMissionEntity(weedPlantPot2, true, true)
  SetEntityAsMissionEntity(weedPlant2, true, true)
  while weedStageThree do 
   Wait(5)
   local coords = GetEntityCoords(ped)
   if GetDistanceBetweenCoords(coords, pos.x, pos.y, pos.z, true) < 1 then 
    DrawText3Ds(pos.x, pos.y, pos.z,'~w~[~g~E~w~]Cut Down') 
    if IsControlJustPressed(0, 38) then 
     TriggerEvent("inventory:addQty", 120,math.random(3,6))
     TriggerEvent('chatMessage', "WEED", {27, 186, 0}, "You have cropped your Plant")
     DeleteObject(weedPlant2)
     DeleteObject(weedPlantPot2)
     weedPlant2 = nil
     weedPlanted2 = false 
     weedThirst2 = 0 
	   growthTimer2 = 0
	   weedStageThree = false 
    end
   end
  end
 end
end)



Citizen.CreateThread(function()
 while true do
  Citizen.Wait(895)
  if weedPlanted then 
   if weedThirst > 0 then 
    weedThirst = weedThirst - 1
   end
  end 
 end
end)


Citizen.CreateThread(function()
  while true do
   Citizen.Wait(895)
   if weedPlanted2 then 
    if weedThirst2 > 0 then 
     weedThirst2 = weedThirst2 - 1
    end
   end 
  end
end)

local xzurvfarmerfucked = math.random(1,100)

local tobacco = {
  {x = 2232.594, y = 5576.342, z = 54.043},
  {x = 2230.081, y = 5576.63, z = 53.959},
  {x = 2227.583, y = 5576.740, z = 53.883},
  {x = 2225.287, y = 5576.852, z = 53.856},
}

local pickingTob = false

Citizen.CreateThread(function()
  while true do
   Citizen.Wait(5)
   for _,v in pairs(tobacco) do
    if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z) <= 2 and not pickingTob then
      DrawText3Ds(v.x, v.y, v.z,'~g~[E]~w~ Pick Tobacco')
     if IsControlJustPressed(0, 38) then 
      pickingTob = true
      TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_ATM", 0, true)
      API_ProgressBar('Picking Leaf', 20)
      Wait(5000)
      TriggerEvent("inventory:addQty", 122, 1)
      ClearPedTasksImmediately(GetPlayerPed(-1))
      pickingTob = false
     end
    end
   end
  end
 end)

 --[XZURV WEEDSEED PICKING SCRIPT]--
local seeds = {
  {x = 2222.878, y = 5577.190, z = 53.840},
  {x = 2220.643, y = 5577.203, z = 53.846},
  {x = 2218.552, y = 5577.349, z = 53.854},
  {x = 2216.169, y = 5577.622, z = 53.842},
}

local pickingseeds = false
local seedcount = 0

Citizen.CreateThread(function()
  while true do
   Citizen.Wait(5)
   for _,v in pairs(seeds) do
    if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z) <= 1 and not pickingseeds then
      DrawText3Ds(v.x, v.y, v.z,'~g~[E]~w~ Pick Weed Seed')
     if IsControlJustPressed(0, 38) then 
      pickingseeds = true 
      TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_GARDENER_PLANT", 0, true)
      FreezeEntityPosition(GetPlayerPed(-1), true)
      TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_GARDENER_PLANT", 0, true)

      TriggerEvent("mythic_progbar:client:progress", {
        name = "weedseed",
        duration = 60000,
        label = "Searching for Weed Seed",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
           disableMovement = true,
           disableCarMovement = true,
           disableMouse = false,
           disableCombat = true,
        },
      }, function(status)
       if not status then
         FreezeEntityPosition(GetPlayerPed(-1), false)
         ClearPedTasksImmediately(GetPlayerPed(-1))
         if pickingseeds == true then
          if weed_cooldowntimer < 9 and seedcount <= 1 then
            pickingseeds = false
            seedcount = seedcount + 1
            TriggerEvent("inventory:addQty", 118, 2)
            TriggerEvent('NRP-notify:client:SendAlert', { type = 'success', text = "You picked a weed seed!", length = 5000})
            TriggerServerEvent("seed:check")
            if seedcount == 1 then
              TriggerServerEvent('timers:set', 1200, ammonia_cooldowntimer, cyclopentyl_cooldowntimer, magnesium_cooldowntimer, methylamine_cooldowntimer, heroin_cooldowntimer, cocaine_cooldowntimer)
            end
          else
            pickingseeds = false
            TriggerEvent('NRP-notify:client:SendAlert', { type = 'error', text = "Your hands are tired, seems like you need to rest. Come back in ".. weed_cooldowntimer .. " seconds.", length = 5000})
          end
         end
        end
      end)

    end
    end
   end
  end
end)

-- Timer countdown
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
    if weed_cooldowntimer > 0 then
      weed_cooldowntimer = weed_cooldowntimer - 1
      if weed_cooldowntimer == 1 then
        seedcount = 0
      end
    end
  end
end)


local ammonia = {
  {x = -549.789, y = -1688.444, z = 19.497},
}

local pickingammonia = false
local ammoniacount = 0

Citizen.CreateThread(function()
  while true do
   Citizen.Wait(5)
   for _,v in pairs(ammonia) do
    if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z) <= 1 and not pickingammonia then
      DrawText3Ds(v.x, v.y, v.z,'~g~[E]~w~ Search')
     if IsControlJustPressed(0, 38) then 
      pickingammonia = true 
      TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_ATM", 0, true)
      FreezeEntityPosition(GetPlayerPed(-1), true)
      TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_ATM", 0, true)

      TriggerEvent("mythic_progbar:client:progress", {
        name = "ammonia",
        duration = 60000,
        label = "Searching for Ammonia",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
           disableMovement = true,
           disableCarMovement = true,
           disableMouse = false,
           disableCombat = true,
        },
      }, function(status)
       if not status then
         FreezeEntityPosition(GetPlayerPed(-1), false)
         ClearPedTasksImmediately(GetPlayerPed(-1))
         if pickingammonia == true then
          if ammonia_cooldowntimer < 9 and ammoniacount <= 1 then
            pickingammonia = false
            ammoniacount = ammoniacount + 1
            TriggerEvent("inventory:addQty", 90, 5)
            TriggerEvent('NRP-notify:client:SendAlert', { type = 'success', text = "You obtained ammonia!", length = 5000})
            if ammoniacount == 1 then
              TriggerServerEvent('timers:set', weed_cooldowntimer, 7200, cyclopentyl_cooldowntimer, magnesium_cooldowntimer, methylamine_cooldowntimer, heroin_cooldowntimer, cocaine_cooldowntimer)
            end
          else
            pickingammonia = false
            TriggerEvent('NRP-notify:client:SendAlert', { type = 'error', text = "Looks like the hospital has ran out. Come back in ".. ammonia_cooldowntimer .. " seconds.", length = 5000})
          end
         end
        end
      end)

    end
    end
   end
  end
end)

-- Timer countdown
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
    if ammonia_cooldowntimer > 0 then
      ammonia_cooldowntimer = ammonia_cooldowntimer - 1
      if ammonia_cooldowntimer == 1 then
        ammoniacount = 0
      end
    end
  end
end)


local cyclopentyl = {
  {x = 3560.023, y = 3674.492, z = 28.121}, ----- ketamine
}

local pickingcyclopentyl = false
local cyclopentylcount = 0

Citizen.CreateThread(function()
  while true do
   Citizen.Wait(5)
   for _,v in pairs(cyclopentyl) do
    local rep = DecorGetInt(GetPlayerPed(-1), "Reputation")
    if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z) <= 1 and not pickingcyclopentyl and rep >= 1000 then
      DrawText3Ds(v.x, v.y, v.z,'~g~[E]~w~ Search')
     if IsControlJustPressed(0, 38) then 
      pickingcyclopentyl = true 
      TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_ATM", 0, true)
      FreezeEntityPosition(GetPlayerPed(-1), true)
      TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_ATM", 0, true)

      TriggerEvent("mythic_progbar:client:progress", {
        name = "cyclopentyl",
        duration = 60000,
        label = "Searching for Chemicals",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
           disableMovement = true,
           disableCarMovement = true,
           disableMouse = false,
           disableCombat = true,
        },
      }, function(status)
       if not status then
         FreezeEntityPosition(GetPlayerPed(-1), false)
         ClearPedTasksImmediately(GetPlayerPed(-1))
         if pickingcyclopentyl == true then
          if cyclopentyl_cooldowntimer < 9 and cyclopentylcount <= 1 then
            pickingcyclopentyl = false
            cyclopentylcount = cyclopentylcount + 1
            TriggerEvent("inventory:addQty", 18, 5)
            TriggerEvent('NRP-notify:client:SendAlert', { type = 'success', text = "You found cyclopentyl!", length = 5000})
            if cyclopentylcount == 1 then
              TriggerServerEvent('timers:set', weed_cooldowntimer, ammonia_cooldowntimer, 3600, magnesium_cooldowntimer, methylamine_cooldowntimer, heroin_cooldowntimer, cocaine_cooldowntimer)
            end
          else
            pickingcyclopentyl = false
            TriggerEvent('NRP-notify:client:SendAlert', { type = 'error', text = "Looks like the morgue has ran out. Come back in ".. cyclopentyl_cooldowntimer .. " seconds.", length = 5000})
          end
         end
        end
      end)

    end
    end
   end
  end
end)

-- Timer countdown
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
    if cyclopentyl_cooldowntimer > 0 then
      cyclopentyl_cooldowntimer = cyclopentyl_cooldowntimer - 1
      if cyclopentyl_cooldowntimer == 1 then
        cyclopentylcount = 0
      end
    end
  end
end)


local magnesium = {
  {x = -84.610, y = 6230.592, z = 31.090}, ----- ketamine
}

local pickingmagnesium = false
local magnesiumcount = 0

Citizen.CreateThread(function()
  while true do
   Citizen.Wait(5)
   for _,v in pairs(magnesium) do
    local rep = DecorGetInt(GetPlayerPed(-1), "Reputation")
    if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z) <= 1 and not pickingmagnesium and rep >= 1000 then
      DrawText3Ds(v.x, v.y, v.z,'~g~[E]~w~ Search')
     if IsControlJustPressed(0, 38) then 
      pickingmagnesium = true 
      TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_ATM", 0, true)
      FreezeEntityPosition(GetPlayerPed(-1), true)
      TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_ATM", 0, true)

      TriggerEvent("mythic_progbar:client:progress", {
        name = "magnesium",
        duration = 60000,
        label = "Searching for Minerals",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
           disableMovement = true,
           disableCarMovement = true,
           disableMouse = false,
           disableCombat = true,
        },
      }, function(status)
       if not status then
         FreezeEntityPosition(GetPlayerPed(-1), false)
         ClearPedTasksImmediately(GetPlayerPed(-1))
         if pickingmagnesium == true then
          if magnesium_cooldowntimer < 9 and magnesiumcount <= 1 then
            pickingmagnesium = false
            magnesiumcount = magnesiumcount + 1
            TriggerEvent("inventory:addQty", 17, 5)
            TriggerEvent('NRP-notify:client:SendAlert', { type = 'success', text = "You found magnesium!", length = 5000})
            if magnesiumcount == 1 then
              TriggerServerEvent('timers:set', weed_cooldowntimer, ammonia_cooldowntimer, cyclopentyl_cooldowntimer, 3600, methylamine_cooldowntimer, heroin_cooldowntimer, cocaine_cooldowntimer)
            end
          else
            pickingmagnesium = false
            TriggerEvent('NRP-notify:client:SendAlert', { type = 'error', text = "Looks like the barrels has ran out. Come back in ".. magnesium_cooldowntimer .. " seconds.", length = 5000})
          end
         end
        end
      end)

    end
    end
   end
  end
end)

-- Timer countdown
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
    if magnesium_cooldowntimer > 0 then
      magnesium_cooldowntimer = magnesium_cooldowntimer - 1
      if magnesium_cooldowntimer == 1 then
        magnesiumcount = 0
      end
    end
  end
end)

local methylamine = {
  {x = 3535.116, y = 3662.923, z = 28.121}, ----- ketamine
}

local ketamine_craft = {
  {x = 975.46, y = -2358.08, z = 31.82},
}

local pickingmethylamine = false
local methylaminecount = 0

Citizen.CreateThread(function()
  while true do
   Citizen.Wait(5)
   for _,v in pairs(methylamine) do
    local rep = DecorGetInt(GetPlayerPed(-1), "Reputation")
    if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z) <= 1 and not pickingmethylamine and rep >= 1000 then
      DrawText3Ds(v.x, v.y, v.z,'~g~[E]~w~ Search')
     if IsControlJustPressed(0, 38) then 
      pickingmethylamine = true 
      TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_ATM", 0, true)
      FreezeEntityPosition(GetPlayerPed(-1), true)
      TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_ATM", 0, true)

      TriggerEvent("mythic_progbar:client:progress", {
        name = "methylamine",
        duration = 60000,
        label = "Searching for Chemicals",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
           disableMovement = true,
           disableCarMovement = true,
           disableMouse = false,
           disableCombat = true,
        },
      }, function(status)
       if not status then
         FreezeEntityPosition(GetPlayerPed(-1), false)
         ClearPedTasksImmediately(GetPlayerPed(-1))
         if pickingmethylamine == true then
          if methylamine_cooldowntimer < 9 and methylaminecount <= 1 then
            pickingmethylamine = false
            methylaminecount = methylaminecount + 1
            TriggerEvent("inventory:addQty", 20, 5)
            TriggerEvent('NRP-notify:client:SendAlert', { type = 'success', text = "You found methylamine!", length = 5000})
            if methylaminecount == 1 then
              TriggerServerEvent('timers:set', weed_cooldowntimer, ammonia_cooldowntimer, cyclopentyl_cooldowntimer, magnesium_cooldowntimer, 3600, heroin_cooldowntimer, cocaine_cooldowntimer)
            end
          else
            pickingmethylamine = false
            TriggerEvent('NRP-notify:client:SendAlert', { type = 'error', text = "Looks like the barrel is empty. Come back in ".. methylamine_cooldowntimer .. " seconds.", length = 5000})
          end
         end
        end
      end)

    end
    end
   end
  end
end)

local craftingketamine = false

Citizen.CreateThread(function()
  while true do
   Citizen.Wait(5)
   for _,v in pairs(ketamine_craft) do
    local rep = DecorGetInt(GetPlayerPed(-1), "Reputation")
    if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z) <= 1 and not craftingketamine and rep >= 1000 and exports['core']:GetItemQuantity(19) > 0 and exports['core']:GetItemQuantity(20) > 0 then
      DrawText3Ds(v.x, v.y, v.z,'~g~[E]~w~ Create Ketamine')
     if IsControlJustPressed(0, 38) then 
      craftingketamine = true 
      TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_ATM", 0, true)
      FreezeEntityPosition(GetPlayerPed(-1), true)
      TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_ATM", 0, true)

      TriggerEvent("mythic_progbar:client:progress", {
        name = "cooking_ketamine",
        duration = 10000,
        label = "Cooking Ketamine",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
           disableMovement = true,
           disableCarMovement = true,
           disableMouse = false,
           disableCombat = true,
        },
      }, function(status)
       if not status then
         FreezeEntityPosition(GetPlayerPed(-1), false)
         ClearPedTasksImmediately(GetPlayerPed(-1))
         if craftingketamine == true then
            craftingketamine = false
            TriggerEvent("inventory:removeQty", 19, 1)
            TriggerEvent("inventory:removeQty", 20, 1) 
            TriggerEvent("inventory:addQty", 49, 1)
            TriggerEvent('NRP-notify:client:SendAlert', { type = 'success', text = "You made 1 ounce of Ketamine.", length = 5000})
         end
        end
      end)

    end
    end
   end
  end
end)

-- Timer countdown
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
    if methylamine_cooldowntimer > 0 then
      methylamine_cooldowntimer = methylamine_cooldowntimer - 1
      if methylamine_cooldowntimer == 1 then
        methylaminecount = 0
      end
    end
  end
end)

local heroin_brick = {
  {x = 62.76, y = 6664.29, z = 31.79},
}

local heroin_oz = {
  {x = 1975.869, y = 3821.018, z = 33.450},
}

local pickingheroin = false
local heroincount = 0

Citizen.CreateThread(function()
  while true do
   Citizen.Wait(5)
   for _,v in pairs(heroin_brick) do
    local rep = DecorGetInt(GetPlayerPed(-1), "Reputation")
    if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z) <= 1 and not pickingheroin and rep >= 1500 then
      DrawText3Ds(v.x, v.y, v.z,'~g~[E]~w~ Retreive')
     if IsControlJustPressed(0, 38) then 
      pickingheroin = true 
      TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_ATM", 0, true)
      FreezeEntityPosition(GetPlayerPed(-1), true)
      TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_ATM", 0, true)

      TriggerEvent("mythic_progbar:client:progress", {
        name = "heroin",
        duration = 60000,
        label = "Retreiving Heroin",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
           disableMovement = true,
           disableCarMovement = true,
           disableMouse = false,
           disableCombat = true,
        },
      }, function(status)
       if not status then
         FreezeEntityPosition(GetPlayerPed(-1), false)
         ClearPedTasksImmediately(GetPlayerPed(-1))
         if pickingheroin == true then
          if heroin_cooldowntimer < 9 and heroincount <= 1 then
            pickingheroin = false
            heroincount = heroincount + 1
            TriggerEvent("inventory:addQty", 305, 1)
            TriggerEvent('NRP-notify:client:SendAlert', { type = 'success', text = "You obtained heroin!", length = 5000})
            if heroincount == 1 then
              TriggerServerEvent('timers:set', weed_cooldowntimer, ammonia_cooldowntimer, cyclopentyl_cooldowntimer, magnesium_cooldowntimer, methylamine_cooldowntimer, 3600, cocaine_cooldowntimer)
            end
          else
            pickingheroin = false
            TriggerEvent('NRP-notify:client:SendAlert', { type = 'error', text = "I am out of stock right now. Come back in ".. heroin_cooldowntimer .. " seconds.", length = 5000})
          end
         end
        end
      end)

    end
    end
   end
  end
end)

local craftingheroin = false

Citizen.CreateThread(function()
  while true do
   Citizen.Wait(5)
   for _,v in pairs(heroin_oz) do
    local rep = DecorGetInt(GetPlayerPed(-1), "Reputation")
    if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z) <= 1 and not craftingheroin and rep >= 1500 and exports['core']:GetItemQuantity(305) > 0 then
      DrawText3Ds(v.x, v.y, v.z,'~g~[E]~w~ Breakdown Brick')
     if IsControlJustPressed(0, 38) then 
      craftingheroin = true 
      TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_ATM", 0, true)
      FreezeEntityPosition(GetPlayerPed(-1), true)
      TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_ATM", 0, true)

      TriggerEvent("mythic_progbar:client:progress", {
        name = "break_heroin",
        duration = 10000,
        label = "Breaking Down Heroin",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
           disableMovement = true,
           disableCarMovement = true,
           disableMouse = false,
           disableCombat = true,
        },
      }, function(status)
       if not status then
         FreezeEntityPosition(GetPlayerPed(-1), false)
         ClearPedTasksImmediately(GetPlayerPed(-1))
         if craftingheroin == true then
            craftingheroin = false
            TriggerEvent("inventory:removeQty", 305, 1)
            TriggerEvent("inventory:addQty", 31, 3)
            TriggerEvent('NRP-notify:client:SendAlert', { type = 'success', text = "You crafted 3 ounces of heroin.", length = 5000})
         end
        end
      end)

    end
    end
   end
  end
end)

-- Timer countdown
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
    if heroin_cooldowntimer > 0 then
      heroin_cooldowntimer = heroin_cooldowntimer - 1
      if heroin_cooldowntimer == 1 then
        heroincount = 0
      end
    end
  end
end)

local cocaine_brick = {
  {x = -2054.24, y = -1034.94, z = 5.88},
}

local cocaine_oz = {
  {x = 1093.171, y = -3196.666, z = -38.993},
}

local pickingcocaine = false
local cocainecount = 0

Citizen.CreateThread(function()
  while true do
   Citizen.Wait(5)
   for _,v in pairs(cocaine_brick) do
    local rep = DecorGetInt(GetPlayerPed(-1), "Reputation")
    if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z) <= 1 and not pickingcocaine and rep >= 2000 then
      DrawText3Ds(v.x, v.y, v.z,'~g~[E]~w~ Retreive')
     if IsControlJustPressed(0, 38) then 
      pickingcocaine = true 
      TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_ATM", 0, true)
      FreezeEntityPosition(GetPlayerPed(-1), true)
      TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_ATM", 0, true)

      TriggerEvent("mythic_progbar:client:progress", {
        name = "cocaine",
        duration = 60000,
        label = "Retreiving Cocaine",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
           disableMovement = true,
           disableCarMovement = true,
           disableMouse = false,
           disableCombat = true,
        },
      }, function(status)
       if not status then
         FreezeEntityPosition(GetPlayerPed(-1), false)
         ClearPedTasksImmediately(GetPlayerPed(-1))
         if pickingcocaine == true then
          if cocaine_cooldowntimer < 9 and cocainecount <= 1 then
            pickingcocaine = false
            cocainecount = cocainecount + 1
            TriggerEvent("inventory:addQty", 107, 1)
            TriggerEvent('NRP-notify:client:SendAlert', { type = 'success', text = "You obtained cocaine!", length = 5000})
            if cocainecount == 1 then
              TriggerServerEvent('timers:set', weed_cooldowntimer, ammonia_cooldowntimer, cyclopentyl_cooldowntimer, magnesium_cooldowntimer, methylamine_cooldowntimer, heroin_cooldowntimer, 3600)
            end
          else
            pickingcocaine = false
            TriggerEvent('NRP-notify:client:SendAlert', { type = 'error', text = "I am out of stock right now. Come back in ".. cocaine_cooldowntimer .. " seconds.", length = 5000})
          end
         end
        end
      end)

    end
    end
   end
  end
end)

local craftingcocaine = false

Citizen.CreateThread(function()
  while true do
   Citizen.Wait(5)
   for _,v in pairs(cocaine_oz) do
    local rep = DecorGetInt(GetPlayerPed(-1), "Reputation")
    if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z) <= 1 and not craftingcocaine and rep >= 2000 and exports['core']:GetItemQuantity(107) > 0 then
      DrawText3Ds(v.x, v.y, v.z,'~g~[E]~w~ Breakdown Brick')
     if IsControlJustPressed(0, 38) then 
      craftingcocaine = true
      TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_ATM", 0, true)
      FreezeEntityPosition(GetPlayerPed(-1), true)
      TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_ATM", 0, true)

      TriggerEvent("mythic_progbar:client:progress", {
        name = "break_cocaine",
        duration = 10000,
        label = "Breaking Down Cocaine",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
           disableMovement = true,
           disableCarMovement = true,
           disableMouse = false,
           disableCombat = true,
        },
      }, function(status)
       if not status then
         FreezeEntityPosition(GetPlayerPed(-1), false)
         ClearPedTasksImmediately(GetPlayerPed(-1))
         if craftingcocaine == true then
            craftingcocaine = false
            TriggerEvent("inventory:removeQty", 107, 1)
            TriggerEvent("inventory:addQty", 109, 3)
            TriggerEvent('NRP-notify:client:SendAlert', { type = 'success', text = "You crafted 3 ounces of cocaine.", length = 5000})
         end
        end
      end)

    end
    end
   end
  end
end)

-- Timer countdown
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
    if cocaine_cooldowntimer > 0 then
      cocaine_cooldowntimer = cocaine_cooldowntimer - 1
      if cocaine_cooldowntimer == 1 then
        cocainecount = 0
      end
    end
  end
end)


Citizen.CreateThread(function()
 while true do
  Citizen.Wait(2125)
  if weedPlanted then 
   if weedThirst > 0 then
    if growthTimer > 0 then 
     if exports['sync']:isDay() then
      growthTimer = growthTimer - 2
     else 
      growthTimer = growthTimer - 1
     end
    end
   end
  end 
 end
end)             ------ WEEED SYNC


Citizen.CreateThread(function()
  while true do
   Citizen.Wait(2125)
   if weedPlanted2 then 
    if weedThirst2 > 0 then
     if growthTimer2 > 0 then 
      if exports['sync']:isDay() then
       growthTimer2 = growthTimer2 - 2
      else 
       growthTimer2 = growthTimer2 - 1
      end
     end
    end
   end 
  end
end)

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

-- Peds
Citizen.CreateThread(function()
  spawnDrugDealers()
 end)
 
 local drug1 = nil
 --local drug2 = nil
 local xzurv = nil
 local smack = nil
 local baghead = nil

 function spawnDrugDealers()
  if drug1 == nil then
   RequestModel(GetHashKey('s_m_y_dealer_01'))
   while not HasModelLoaded(GetHashKey('s_m_y_dealer_01')) do
    Wait(1)
   end
 
   drug1 = CreatePed(2, GetHashKey('s_m_y_dealer_01'), -601.715,-1122.444, 22.324,279.036, false, false)
   SetPedFleeAttributes(drug1, 0, 0)
   SetPedDiesWhenInjured(drug1, false)
   TaskStartScenarioInPlace(drug1, "WORLD_HUMAN_DRUG_DEALER", 0, true)
   SetPedKeepTask(drug1, true)
  end -- add drug dealers
 if drug2 == nil then 
   RequestModel(GetHashKey('a_m_m_mexcntry_01'))
   while not HasModelLoaded(GetHashKey('a_m_m_mexcntry_01')) do
    Wait(1)
   end
 
   drug2 = CreatePed(2, GetHashKey('a_m_m_mexcntry_01'), -128.920, -1568.182, 37.408, 223.289, false, false)
   SetPedFleeAttributes(drug2, 0, 0)
   SetPedDiesWhenInjured(drug2, false)
   TaskStartScenarioInPlace(drug2, "WORLD_HUMAN_DRUG_DEALER", 0, true)
   SetPedKeepTask(drug2, true)
  end 
  if xzurv == nil then 
    RequestModel(GetHashKey('g_m_m_armboss_01'))
    while not HasModelLoaded(GetHashKey('g_m_m_armboss_01')) do
     Wait(1)
    end
  
    xzurv = CreatePed(2, GetHashKey('g_m_m_armboss_01'), 12.287, 340.183, 111.485, 317.488, false, false)
    SetPedFleeAttributes(xzurv, 0, 0)
    SetPedDiesWhenInjured(xzurv, false)
    TaskStartScenarioInPlace(xzurv, "WORLD_HUMAN_DRUG_DEALER", 0, true)
    SetPedKeepTask(xzurv, true)
   end 
   if baghead == nil then 
    RequestModel(GetHashKey('a_m_o_acult_02'))
    while not HasModelLoaded(GetHashKey('a_m_o_acult_02')) do
     Wait(1)
    end

    baghead = CreatePed(2, GetHashKey('a_m_o_acult_02'), 859.274, 2877.221, 57.983, 235.780, false, false)
    SetPedFleeAttributes(baghead, 0, 0)
    SetPedDiesWhenInjured(baghead, false)
    TaskStartScenarioInPlace(baghead, "WORLD_HUMAN_DRUG_DEALER", 0, true)
    SetPedKeepTask(baghead, true)
   end 
   if smack == nil then 
    RequestModel(GetHashKey('A_M_M_Malibu_01'))
    while not HasModelLoaded(GetHashKey('A_M_M_Malibu_01')) do
     Wait(1)
    end
    smack = CreatePed(2, GetHashKey('A_M_M_Malibu_01'), -1104.616, -1091.601, 2.150, 30.534, false, false)
    SetPedFleeAttributes(smack, 0, 0)
    SetPedDiesWhenInjured(smack, false)
    TaskStartScenarioInPlace(smack, "WORLD_HUMAN_DRUG_DEALER", 0, true)
    SetPedKeepTask(smack, true)
   end 
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