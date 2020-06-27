local statistics = {}

-- Arms
Citizen.CreateThread(function()
 while true do
  Citizen.Wait(0)
  if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1197.334, -1572.727, 4.6115, true) < 50) then
   DrawMarker(27, -1197.334, -1572.727, 4.6115-0.95, 0, 0, 0, 0, 0, 0, 0.8,0.8,1.0, 255,0,0, 200, 0, 0, 2, 0, 0, 0, 0)
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),  -1197.334, -1572.727, 4.6115, true) < 1.0) then
    drawTxt('~m~Press ~g~E~m~ To Work On Your Strength')
    if IsControlJustPressed(0, 38) then
      TaskStartScenarioInPlace(GetPlayerPed(-1), "world_human_muscle_free_weights", 0, true)
      Citizen.Wait(60000)
      TriggerServerEvent('stats:add', 'Strength', 1)
      exports['NRP-notify']:DoHudText('success', 'Increasing Your Strength')
      ClearPedTasksImmediately(GetPlayerPed(-1))
      exports['NRP-notify']:DoHudText('inform', 'You Are Too Tired To Continue')
      Wait(300000)
    end
   end
  end 
 end
end)


-- Arms 2
Citizen.CreateThread(function()
 while true do
  Citizen.Wait(0)
  if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1199.216, -1574.137, 4.610, true) < 50) then
   DrawMarker(27, -1199.216, -1574.137, 4.610-0.95, 0, 0, 0, 0, 0, 0, 0.8,0.8,1.0, 255,0,0, 200, 0, 0, 2, 0, 0, 0, 0)
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),  -1199.216, -1574.137, 4.610, true) < 1.0) then
    drawTxt('~m~Press ~g~E~m~ To Work On Your Strength')
    if IsControlJustPressed(0, 38) then
      TaskStartScenarioInPlace(GetPlayerPed(-1), "world_human_muscle_free_weights", 0, true)
      Citizen.Wait(60000)
      TriggerServerEvent('stats:add', 'Strength', 1)
      exports['NRP-notify']:DoHudText('success', 'Increasing Your Strength')
      ClearPedTasksImmediately(GetPlayerPed(-1))
      exports['NRP-notify']:DoHudText('inform', 'You Are Too Tired To Continue')
      Wait(300000)
    end
   end
  end 
 end
end)


--========================Jogging==========================--

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(0)
  if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1195.740, -1568.039, 4.621, true) < 50) then
   DrawMarker(27, -1195.740, -1568.039, 4.621-0.95, 0, 0, 0, 0, 0, 0, 0.8,0.8,1.0, 100,20,255, 200, 0, 0, 2, 0, 0, 0, 0)
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1195.740, -1568.039, 4.621, true) < 0.5) then
    drawTxt('~m~Press ~g~E~m~ To Work On Your Stamina')
    if IsControlJustPressed(0, 38) then
      TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_JOG_STANDING", 0, true)
      Citizen.Wait(40000)
      exports['NRP-notify']:DoHudText('inform', 'You are Sweating')
      ExecuteCommand('me Sweats')
      Citizen.Wait(35000)
      TriggerServerEvent('stats:add', 'Stamina', 1)
      exports['NRP-notify']:DoHudText('success', 'Stamina Increased!')
      ClearPedTasksImmediately(GetPlayerPed(-1))
      ExecuteCommand('me Gets Tired and Stops Running')
      Wait(300000)
    end
   end
  end 
 end
end)

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(0)
  if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1194.141, -1570.373, 4.621, true) < 50) then
   DrawMarker(27, -1194.141, -1570.373, 4.621-0.95, 0, 0, 0, 0, 0, 0, 0.8,0.8,1.0, 100,20,255, 200, 0, 0, 2, 0, 0, 0, 0)
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1194.141, -1570.373, 4.621, true) < 0.5) then
    drawTxt('~m~Press ~g~E~m~ To Work On Your Stamina')
    if IsControlJustPressed(0, 38) then
      TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_JOG_STANDING", 0, true)
      Citizen.Wait(40000)
      exports['NRP-notify']:DoHudText('success', 'You are Sweating')
      ExecuteCommand('me Sweats')
      Citizen.Wait(35000)
      TriggerServerEvent('stats:add', 'Stamina', 1)
      exports['NRP-notify']:DoHudText('success', 'Stamina Increased')
      ClearPedTasksImmediately(GetPlayerPed(-1))
      ExecuteCommand('me Gets Tired and Stops Running')
      Wait(300000)
    end
   end
  end 
 end
end)

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(0)
  if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1197.267, -1566.061, 4.620, true) < 50) then
   DrawMarker(27, -1197.267, -1566.061, 4.620-0.95, 0, 0, 0, 0, 0, 0, 0.8,0.8,1.0, 100,20,255, 200, 0, 0, 2, 0, 0, 0, 0)
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1197.267, -1566.061, 4.620, true) < 0.5) then
    drawTxt('~m~Press ~g~E~m~ To Work On Your Stamina')
    if IsControlJustPressed(0, 38) then
      TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_JOG_STANDING", 0, true)
      Citizen.Wait(40000)
      exports['NRP-notify']:DoHudText('success', 'You are Sweating')
      ExecuteCommand('me Sweats')
      Citizen.Wait(35000)
      TriggerServerEvent('stats:add', 'Stamina', 1)
      exports['NRP-notify']:DoHudText('success', 'Stamina Increased')
      ClearPedTasksImmediately(GetPlayerPed(-1))
      ExecuteCommand('me Gets Tired and Stops Running')
      Wait(300000)
    end
   end
  end 
 end
end)


--========================PushUps==========================--

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(0)
  if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1207.974, -1562.175, 4.608, true) < 50) then
   DrawMarker(27, -1207.974, -1562.175, 4.608-0.95, 0, 0, 0, 0, 0, 0, 0.8,0.8,1.0, 255,0,0, 200, 0, 0, 2, 0, 0, 0, 0)
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1207.974, -1562.175, 4.608, true) < 0.5) then
    drawTxt('~m~Press ~g~E~m~ To Work On Your Strength')
    if IsControlJustPressed(0, 38) then
      TaskStartScenarioInPlace(GetPlayerPed(-1), "world_human_push_ups", 0, true)
      Citizen.Wait(25000)
      exports['NRP-notify']:DoHudText('inform', 'You are Sweating')
      Citizen.Wait(45000)
      TriggerServerEvent('stats:add', 'Strength', 1)
      exports['NRP-notify']:DoHudText('success', 'Stamina Increased')
      ClearPedTasksImmediately(GetPlayerPed(-1))
      ExecuteCommand('me Gets Tired and Stops Running')
      Wait(300000)
    end
   end
  end 
 end
end)

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(0)
  if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1205.172, -1560.063, 4.614, true) < 50) then
   DrawMarker(27, -1205.172, -1560.063, 4.614-0.95, 0, 0, 0, 0, 0, 0, 0.8,0.8,1.0, 255,0,0, 200, 0, 0, 2, 0, 0, 0, 0)
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1205.172, -1560.063, 4.614, true) < 0.5) then
    drawTxt('~m~Press ~g~E~m~ To Work On Your Strength')
    if IsControlJustPressed(0, 38) then
      TaskStartScenarioInPlace(GetPlayerPed(-1), "world_human_push_ups", 0, true)
      Citizen.Wait(45000)
      exports['NRP-notify']:DoHudText('inform', 'You are Sweating')
      Citizen.Wait(25000)
      TriggerServerEvent('stats:add', 'Strength', 1)
      exports['NRP-notify']:DoHudText('success', 'Stamina Increased')
      ClearPedTasksImmediately(GetPlayerPed(-1))
      ExecuteCommand('me Gets Tired and Stops Running')
      Wait(300000)
    end
   end
  end 
 end
end)

--=============Strength and Stamina=============-
Citizen.CreateThread(function()
 while true do
  Citizen.Wait(0)
  if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1199.400, -1563.382, 4.620, true) < 50) then
   DrawMarker(27, -1199.400, -1563.382, 4.620-0.95, 0, 0, 0, 0, 0, 0, 0.8,0.8,1.0, 0, 255, 0, 200, 0, 0, 2, 0, 0, 0, 0)
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1199.400, -1563.382, 4.620, true) < 0.5) then
    drawTxt('~m~Press ~g~E~m~ To Work On Your Stamina & Strength ')
    if IsControlJustPressed(0, 38) then
      TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_JOG_STANDING", 0, true)
      Citizen.Wait(5000)
      ClearPedTasksImmediately(GetPlayerPed(-1))
      TaskStartScenarioInPlace(GetPlayerPed(-1), "world_human_push_ups", 0, true)
      Citizen.Wait(5000)
      ClearPedTasksImmediately(GetPlayerPed(-1))
      TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_JOG_STANDING", 0, true)
      Citizen.Wait(5000)
      TaskStartScenarioInPlace(GetPlayerPed(-1), "world_human_push_ups", 0, true)
      Citizen.Wait(5000)
      ClearPedTasksImmediately(GetPlayerPed(-1))
      TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_JOG_STANDING", 0, true)
      Citizen.Wait(5000)
      ClearPedTasksImmediately(GetPlayerPed(-1))
      TaskStartScenarioInPlace(GetPlayerPed(-1), "world_human_push_ups", 0, true)
      Citizen.Wait(5000)
      ClearPedTasksImmediately(GetPlayerPed(-1))
      TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_JOG_STANDING", 0, true)
      Citizen.Wait(40000)
      ClearPedTasksImmediately(GetPlayerPed(-1))
      TaskStartScenarioInPlace(GetPlayerPed(-1), "world_human_push_ups", 0, true)
      Citizen.Wait(45000)
      exports['NRP-notify']:DoHudText('inform', 'You are Sweating')
      TriggerServerEvent('stats:add', 'Strength', 1)
      TriggerServerEvent('stats:add', 'Stamina', 1)
      exports['NRP-notify']:DoHudText('success', 'Stamina & Strength Increased')
      ClearPedTasksImmediately(GetPlayerPed(-1))
      ExecuteCommand('me Gets Tired and Stops Running')
      Wait(300000)
    end
   end
  end 
 end
end)

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(0)
  if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1201.441, -1561.108, 4.619, true) < 50) then
   DrawMarker(27, -1201.441, -1561.108, 4.619-0.95, 0, 0, 0, 0, 0, 0, 0.8,0.8,1.0, 0, 255, 0, 200, 0, 0, 2, 0, 0, 0, 0)
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1201.441, -1561.108, 4.619, true) < 0.5) then
    drawTxt('~m~Press ~g~E~m~ To Work On Your Stamina & Strength ')
    if IsControlJustPressed(0, 38) then
      TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_JOG_STANDING", 0, true)
      Citizen.Wait(5000)
      ClearPedTasksImmediately(GetPlayerPed(-1))
      TaskStartScenarioInPlace(GetPlayerPed(-1), "world_human_push_ups", 0, true)
      Citizen.Wait(5000)
      ClearPedTasksImmediately(GetPlayerPed(-1))
      TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_JOG_STANDING", 0, true)
      Citizen.Wait(5000)
      TaskStartScenarioInPlace(GetPlayerPed(-1), "world_human_push_ups", 0, true)
      Citizen.Wait(5000)
      ClearPedTasksImmediately(GetPlayerPed(-1))
      TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_JOG_STANDING", 0, true)
      Citizen.Wait(5000)
      ClearPedTasksImmediately(GetPlayerPed(-1))
      TaskStartScenarioInPlace(GetPlayerPed(-1), "world_human_push_ups", 0, true)
      Citizen.Wait(5000)
      ClearPedTasksImmediately(GetPlayerPed(-1))
      TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_JOG_STANDING", 0, true)
      Citizen.Wait(40000)
      ClearPedTasksImmediately(GetPlayerPed(-1))
      TaskStartScenarioInPlace(GetPlayerPed(-1), "world_human_push_ups", 0, true)
      Citizen.Wait(45000)
      exports['NRP-notify']:DoHudText('inform', 'You are Sweating')
      TriggerServerEvent('stats:add', 'Strength', 1)
      TriggerServerEvent('stats:add', 'Stamina', 1)
      exports['NRP-notify']:DoHudText('success', 'Stamina & Strength Increased')
      ClearPedTasksImmediately(GetPlayerPed(-1))
      ExecuteCommand('me Gets Tired and Stops Running')
      Wait(300000)
    end
   end
  end 
 end
end)

---------------------------------------------------- MRPD

Citizen.CreateThread(function()
  while true do
   Citizen.Wait(0)
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 463.144, -1016.047, 32.98, true) < 50) then
    DrawMarker(27, 463.144, -1016.047, 32.98-0.95, 0, 0, 0, 0, 0, 0, 0.8,0.8,1.0, 0, 255, 0, 200, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 463.144, -1016.047, 32.98, true) < 0.5) then
     drawTxt('~m~Press ~g~E~m~ To Work On Your Stamina & Strength ')
     if IsControlJustPressed(0, 38) then
       TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_JOG_STANDING", 0, true)
       Citizen.Wait(5000)
       ClearPedTasksImmediately(GetPlayerPed(-1))
       TaskStartScenarioInPlace(GetPlayerPed(-1), "world_human_push_ups", 0, true)
       Citizen.Wait(5000)
       ClearPedTasksImmediately(GetPlayerPed(-1))
       TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_JOG_STANDING", 0, true)
       Citizen.Wait(5000)
       TaskStartScenarioInPlace(GetPlayerPed(-1), "world_human_push_ups", 0, true)
       Citizen.Wait(5000)
       ClearPedTasksImmediately(GetPlayerPed(-1))
       TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_JOG_STANDING", 0, true)
       Citizen.Wait(5000)
       ClearPedTasksImmediately(GetPlayerPed(-1))
       TaskStartScenarioInPlace(GetPlayerPed(-1), "world_human_push_ups", 0, true)
       Citizen.Wait(5000)
       ClearPedTasksImmediately(GetPlayerPed(-1))
       TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_JOG_STANDING", 0, true)
       Citizen.Wait(40000)
       ClearPedTasksImmediately(GetPlayerPed(-1))
       TaskStartScenarioInPlace(GetPlayerPed(-1), "world_human_push_ups", 0, true)
       Citizen.Wait(45000)
       exports['NRP-notify']:DoHudText('inform', 'You are Sweating')
       TriggerServerEvent('stats:add', 'Strength', 1)
       TriggerServerEvent('stats:add', 'Stamina', 1)
       exports['NRP-notify']:DoHudText('success', 'Stamina & Strength Increased')
       ClearPedTasksImmediately(GetPlayerPed(-1))
       ExecuteCommand('me Gets Tired and Stops Running')
       Wait(300000)
     end
    end
   end 
  end
 end)


---------------------------------------------------- PRISON
-- Arms
Citizen.CreateThread(function()
 while true do
  Citizen.Wait(0)
  if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1639.214, 2527.591, 45.565, true) < 50) then
   DrawMarker(27, 1639.214, 2527.591, 45.565-0.95, 0, 0, 0, 0, 0, 0, 0.8,0.8,1.0, 100,20,255, 200, 0, 0, 2, 0, 0, 0, 0)
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1639.214, 2527.591, 45.565, true) < 1.0) then
    drawTxt('~m~Press ~g~E~m~ To Work On Your Strength')
    if IsControlJustPressed(0, 38) then
      TaskStartScenarioInPlace(GetPlayerPed(-1), "world_human_muscle_free_weights", 0, true)
      Citizen.Wait(60000)
      TriggerServerEvent('stats:add', 'Strength', 1)
      exports['NRP-notify']:DoHudText('success', 'Incresing Your Strength')
      ClearPedTasksImmediately(GetPlayerPed(-1))
      exports['NRP-notify']:DoHudText('inform', 'You Are Too Tired To Continue')
      Wait(300000)
    end
   end
  end 
 end
end)

-- Strength 2
Citizen.CreateThread(function()
 while true do
  Citizen.Wait(0)
  if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1643.222, 2527.781, 45.565, true) < 50) then
   DrawMarker(27, 1643.222, 2527.781, 45.565-0.95, 0, 0, 0, 0, 0, 0, 0.8,0.8,1.0, 100,20,255, 200, 0, 0, 2, 0, 0, 0, 0)
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1643.222, 2527.781, 45.565, true) < 0.5) then
    drawTxt('~m~Press ~g~E~m~ To Work On Your Stamina')
    if IsControlJustPressed(0, 38) then
      TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_JOG_STANDING", 0, true)
      Citizen.Wait(40000)
      exports['NRP-notify']:DoHudText('inform', 'You Are Sweating')
      ExecuteCommand('me Sweats')
      Citizen.Wait(35000)
      TriggerServerEvent('stats:add', 'Stamina', 1)
      exports['NRP-notify']:DoHudText('success', 'Stamina Increased')
      ClearPedTasksImmediately(GetPlayerPed(-1))
      ExecuteCommand('me Gets Tired and Stops Running')
      Wait(300000)
    end
   end
  end 
 end
end)


RegisterNetEvent('stats:character')
AddEventHandler('stats:character', function(data)
 for _,v in pairs(data) do
  if v.name == 'Stamina' then 
   StatSetInt(GetHashKey("MP0_STAMINA"), v.value, true)
  elseif v.name == 'Strength' then
   StatSetInt(GetHashKey("MP0_STRENGTH"), v.value, true)
  elseif v.name == '' then 
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



--===============================BRAND NEW SYSTEM====================================--


--========Sweating System

--Running--
local ped = GetPlayerPed(-1)
Citizen.CreateThread(function()
  while true do 
    Citizen.Wait(0)
    if IsPedRunning(ped) and math.random(1, 1000) > 998 then 
    exports['NRP-notify']:DoHudText('inform', 'Fitness Meter: Sweating Increased')
    PlaySoundFrontend(-1, 'CONFIRM_BEEP', 'HUD_MINI_GAME_SOUNDSET', 0, 1)
    Wait(10000)
    if math.random(1, 1000) > 999 then 
    exports['NRP-notify']:DoHudText('inform', 'Fitness Meter: Sweating Decreased')
    PlaySoundFrontend(-1, 'CONFIRM_BEEP', 'HUD_MINI_GAME_SOUNDSET', 0, 1)
   end
  end
 end
end)

--walking--
local ped = GetPlayerPed(-1)
Citizen.CreateThread(function()
  while true do 
    Citizen.Wait(1000)
    if IsPedWalking(ped) and math.random(1, 1000) > 998 then 
    exports['NRP-notify']:DoHudText('inform', 'Fitness Meter: Sweating Increased')
    PlaySoundFrontend(-1, 'CONFIRM_BEEP', 'HUD_MINI_GAME_SOUNDSET', 0, 1)
    Wait(10000)
    if math.random(1, 1000) > 998 then 
    exports['NRP-notify']:DoHudText('inform', 'Fitness Meter: Sweating Decreased')
    PlaySoundFrontend(-1, 'CONFIRM_BEEP', 'HUD_MINI_GAME_SOUNDSET', 0, 1)
   end
  end
 end
end)

--===========================Increase System===================================-


--================Running

local ped = GetPlayerPed(-1)
Citizen.CreateThread(function()
  while true do 
    Citizen.Wait(0)
    if IsPedRunning(ped) and math.random(1, 1000) > 999 then 
      TriggerServerEvent('stats:add', 'Stamina', 0.5)
      exports['NRP-notify']:DoHudText('inform', 'Fitness Meter: Stamina Increased By 0.5')
      PlaySoundFrontend(-1, 'CONFIRM_BEEP', 'HUD_MINI_GAME_SOUNDSET', 0, 1)
      Wait(10000)
    end
   end
  end)

--==============Swimming Lung Capacity

local ped = GetPlayerPed(-1)
Citizen.CreateThread(function()
  while true do 
    Citizen.Wait(0)
    if IsPedSwimming(ped) and math.random(1, 1000) > 999 then 
      TriggerServerEvent('stats:add', 'Lung Capacity', 1)
      Wait(1000)
      exports['NRP-notify']:DoHudText('inform', 'Fitness Meter: Lung Capacity Increased By 1')
      PlaySoundFrontend(-1, 'CONFIRM_BEEP', 'HUD_MINI_GAME_SOUNDSET', 0, 1)
      Wait(1000)
    end
   end
  end)