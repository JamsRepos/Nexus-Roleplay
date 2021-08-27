local inRace = false
local raceMode = 6
local currentTime = 0
local twveh = 'sanchez'

local maxCheckpoints = 26

local currentCheckpoint = 0
local checkpoints = {
  [1] = {x = -1086.874, y = 4909.134, z = 214.378},
  [2] = {x = -1047.376, y = 4910.880, z = 208.780}, 
  [3] = {x = -1009.792, y = 4959.157, z = 195.226},
  [4] = {x = -969.436, y = 5009.988, z = 180.860},
  [5] = {x = -923.025, y = 5045.712, z = 161.826},
  [6] = {x = -876.925, y = 5110.139, z = 145.646},
  [7] = {x = -828.037, y = 5166.021, z = 107.531},
  [8] = {x = -824.548, y = 5199.297, z = 100.949},
  [9] = {x = -824.234, y = 5237.613, z = 86.514},
  [10] = {x = -794.885, y = 5261.908, z = 88.410},
  [11] = {x = -737.956, y = 5243.437, z = 95.724},
  [12] = {x = -708.050, y = 5254.252, z = 72.708},
  [13] = {x = -688.603, y = 5288.948, z = 65.903},
  [14] = {x = -642.361, y = 5328.520, z = 54.534}, 
  [15] = {x = -645.279, y = 5381.262, z = 47.649},
  [16] = {x = -681.017, y = 5433.572, z = 42.014},
  [17] = {x = -750.488, y = 5453.177, z = 32.912},
  [18] = {x = -799.874, y = 5499.107, z = 24.534},
  [19] = {x = -820.332, y = 5559.110, z = 30.917},
  [20] = {x = -845.392, y = 5626.170, z = 16.640},
  [21] = {x = -811.148, y = 5765.957, z = 4.542},
  [22] = {x = -847.316, y = 5895.238, z = 2.910},
  [23] = {x = -921.690, y = 6004.183, z = 1.623},
  [24] = {x = -944.813, y = 6129.822, z = 3.391},
  [25] = {x = -975.608, y = 6219.666, z = 2.990},
}


function startRacing()
  DoScreenFadeOut(3000)
  Wait(3000)
  RequestModel(twveh)
  local vehicle = CreateVehicle(twveh, -1118.724, 4923.465, 218.254-0.95, 260, 1, 0)
  TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
  SetEntityHeading(vehicle, 240.569)
  FreezeEntityPosition(vehicle, true)
  exports["onyxLocksystem"]:givePlayerKeys(GetVehicleNumberPlateText(vehicle))
  Wait(1000)
  DoScreenFadeIn(1000)
  raceMode = 5
  Wait(1000)
  raceMode = 4
  Wait(1000)
  raceMode = 3
  Wait(1000)
  raceMode = 2
  Wait(1000)
  raceMode = 1
  Wait(1000)
  FreezeEntityPosition(vehicle, false)         -- freezes car for start
  startTime = GetGameTimer()
  raceMode = 0 
  inRace = true
  if IsPedOnFoot(GetPlayerPed(-1)) then
    RequestModel(twveh)
    local vehicle = CreateVehicle(twveh, -1118.724, 4923.465, 218.254-0.95, 260, 1, 0)
    TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
    SetEntityHeading(vehicle, 240.569)
    FreezeEntityPosition(vehicle, true)
    exports["onyxLocksystem"]:givePlayerKeys(GetVehicleNumberPlateText(vehicle))
    Wait(1000)
    DoScreenFadeIn(1000)
    raceMode = 5
    Wait(1000)
    raceMode = 4
    Wait(1000)
    raceMode = 3
    Wait(1000)
    raceMode = 2
    Wait(1000)
    raceMode = 1
    Wait(1000)
    FreezeEntityPosition(vehicle, false)         -- freezes car for start
    startTime = GetGameTimer()
    raceMode = 0 
    inRace = true
  end    
end

RegisterCommand('dnf', function(source)
 if inRace then
    inRace = false
    TriggerEvent('chatMessage', "RACING", {255, 182, 0}, "You did not complete the race in time and were given a DNF")
    endRaceView()
  end  
end)

Citizen.CreateThread(function()
  while true do
  Wait(0)
  if inRace or raceMode == 5 or raceMode == 4 or raceMode == 3 or raceMode == 2 or raceMode == 1 then 
    DisableControlAction(0, 75, true) -- Disable exit vehicle
    DisableControlAction(27, 75, true)   
  end
 end
end)

Citizen.CreateThread(function()
  while true do
   Wait(1)
   local ped = GetPlayerPed(-1)
   local vehicle = GetVehiclePedIsIn(ped, false)
   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1659.968, -228.013, 54.972, true) < 65 and IsPedOnFoot(ped) and not inRace and not IsPedOnAnyBike(ped) then
    if exports['core']:GetItemQuantity(281) >= 1 and not inRace then
    DrawMarker(27, -1659.968, -228.013, 54.972-0.95, 0, 0, 0, 0, 0, 0, 4.0,4.0,4.0, 255, 246,0,100, 0, 0, 2, 0, 0, 0, 0)
    if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1659.968, -228.013, 54.972, true) < 2.0 then
      DrawText3Ds(-1659.968, -228.013, 54.972,"~g~[E]~w~ Set Time Trial")
     DrawRect(0.470, 0.1020, 0.140, 0.100, 0, 0, 0, 155)
     drawUI(0.920, 0.550, 1.0, 1.0, 0.45, "~g~WELCOME TO THE TIME TRIAL ~w~", 255, 255, 255, 255, false)
     drawUI(0.908, 0.600, 1.0, 1.0, 0.45, "~r~THIS WEEKS VEHICLE IS:  ~w~" ..GetDisplayNameFromVehicleModel(GetHashKey(twveh)), 255, 255, 255, 255, false)
     if IsControlJustPressed(0, 38) then
      TriggerEvent("inventory:removeQty", 281, 1)
      startRacing()
      currentTime = 0
      currentCheckpoint = 0
     end
     end
    end
   end
  end
end)

Citizen.CreateThread(function()
 while true do 
  Wait(5)
  local pos = GetEntityCoords(GetPlayerPed(-1))
    if inRace then
    -- Display Waypoint Code
    if currentCheckpoint+1 < maxCheckpoints then
     DrawMarker(20, checkpoints[currentCheckpoint+1].x, checkpoints[currentCheckpoint+1].y, checkpoints[currentCheckpoint+1].z+1, 0, 0, 0, 0, 0, 0, 2.0,2.0,2.0, 255, 246,0,255, 0, 0, 2, 0, 0, 0, 0)
     DrawMarker(1, checkpoints[currentCheckpoint+1].x, checkpoints[currentCheckpoint+1].y, checkpoints[currentCheckpoint+1].z-0.95, 0, 0, 0, 0, 0, 0, 3.0,3.0,3.0, 196, 198, 198,80, 0, 0, 2, 0, 0, 0, 0)

     if GetDistanceBetweenCoords(pos, checkpoints[currentCheckpoint+1].x, checkpoints[currentCheckpoint+1].y, checkpoints[currentCheckpoint+1].z) <= 6 then
      currentCheckpoint = currentCheckpoint + 1
     end

     if currentCheckpoint+2 < maxCheckpoints then
        DrawMarker(20, checkpoints[currentCheckpoint+2].x, checkpoints[currentCheckpoint+2].y, checkpoints[currentCheckpoint+2].z+1, 0, 0, 0, 0, 0, 0, 2.0,2.0,2.0, 255, 246,0,255, 0, 0, 2, 0, 0, 0, 0)
        DrawMarker(1, checkpoints[currentCheckpoint+2].x, checkpoints[currentCheckpoint+2].y, checkpoints[currentCheckpoint+2].z-0.95, 0, 0, 0, 0, 0, 0, 3.0,3.0,3.0, 196, 198, 198,80, 0, 0, 2, 0, 0, 0, 0)
     end

     if currentCheckpoint+3 < maxCheckpoints then
        DrawMarker(20, checkpoints[currentCheckpoint+3].x, checkpoints[currentCheckpoint+3].y, checkpoints[currentCheckpoint+3].z+1, 0, 0, 0, 0, 0, 0, 2.0,2.0,2.0, 255, 246,0,255, 0, 0, 2, 0, 0, 0, 0)
        DrawMarker(1, checkpoints[currentCheckpoint+3].x, checkpoints[currentCheckpoint+3].y, checkpoints[currentCheckpoint+3].z-0.95, 0, 0, 0, 0, 0, 0, 3.0,3.0,3.0, 196, 198, 198,80, 0, 0, 2, 0, 0, 0, 0)
     end
    else
     DrawMarker(4, -998.150, 6261.266, 2.227+1, 0, 0, 0, 0, 0, 0, 2.0,2.0,2.0, 255, 246,0,255, 0, 0, 2, 0, 0, 0, 0)
     DrawMarker(1, -998.150, 6261.266, 2.227-0.95, 0, 0, 0, 0, 0, 0, 3.0,3.0,3.0, 196, 198, 198,80, 0, 0, 2, 0, 0, 0, 0)
     if GetDistanceBetweenCoords(pos, -998.150, 6261.266, 2.227) <= 6 then
      inRace = false
      TriggerEvent('chatMessage', "RACING", {255, 182, 0}, "You completed the circuit in the time: ^3"..currentTime)
      TriggerServerEvent('racing:recordTime', currentTime,twveh)
      endRaceView()
     end
    end
   end
   if raceMode == 0 then
    drawTxt('~g~'..currentTime)
   elseif raceMode ~= 6 then
    drawTxt('~w~Race Begins in.. ~g~'..raceMode)
   end
 end
end)

Citizen.CreateThread(function()
    while true do 
     Wait(1)
      if inRace then
        currentTime = formatTimer(startTime, GetGameTimer())
      end
    end
   end)

   function endRaceView()
    local vehicle = GetVehiclePedIsUsing(GetPlayerPed(-1))
     DoScreenFadeOut(1000)
     Wait(1000)
     DeleteVehicle(vehicle)
     raceMode = 6
     currentTime = 0
     currentCheckpoint = 0
     Wait(3000)
     SetEntityCoords(GetPlayerPed(-1), -1675.950, -221.823, 55.565)
     SetEntityHeading(GetPlayerPed(-1), 248.218)
     DoScreenFadeIn(1000)
   end 

   function drawTxt(text)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(1.0, 1.1)
    SetTextCentre(1)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(1)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(0.9, 0.5)   
  end

  function formatTimer(startTime, currTime)
    local newString = currTime - startTime
        local ms = string.sub(newString, -3, -2)
        local sec = string.sub(newString, -5, -4)
        local min = string.sub(newString, -7, -6)
        --newString = string.sub(newString, -1)
        newString = string.format("%s%s.%s", min, sec, ms)
    return newString
end

function drawUI(x,y ,width,height,scale, text, r,g,b,a, center)
  SetTextFont(4)
  SetTextProportional(0)
  SetTextScale(scale, scale)
  SetTextColour(r, g, b, a)
  SetTextDropShadow(0, 0, 0, 0,255)
  SetTextEdge(2, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(x - width/2, y - height/2 + 0.005)
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