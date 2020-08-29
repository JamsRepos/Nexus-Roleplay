inLocationSelect = false
local guiEnabled = true
local firstSpawn = true
local loadInCords = nil
local character = {}
local permission_level = 0

function EnableGui(enable, chars)
 SetNuiFocus(enable, enable)
 guiEnabled = enable
 SendNUIMessage({type = "enableui",  enable = enable, characters = chars})
end 

Citizen.CreateThread(function()
 while true do
  if guiEnabled then
   DisableControlAction(0, 1, guiEnabled) -- LookLeftRight
   DisableControlAction(0, 2, guiEnabled) -- LookUpDown
   DisableControlAction(0, 142, guiEnabled) -- MeleeAttackAlternate
   DisableControlAction(0, 106, guiEnabled) -- VehicleMouseControlOverride
   DisableAllControlActions(0)
   if IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
    SendNUIMessage({type = "click"})
   end
   if IsDisabledControlJustReleased(0, 22) then
    SetNuiFocus(true, true)
    print("Enabled Mouse Cursor")
   end
  end
  Citizen.Wait(0)
 end
end)

RegisterCommand('debug', function(source, args, rawCommand)
 if guiEnabled then 
  TriggerServerEvent("core:getCharacters")
 end
end)


AddEventHandler('playerSpawned', function(spawn)
 TriggerEvent("core:startSkyCamera")
 NetworkSetTalkerProximity(7.0)
 TriggerServerEvent("core:getCharacters")
end)

RegisterNetEvent('core:spawncharacter')
AddEventHandler('core:spawncharacter', function(coords)
  EnableGui(false ,false)
  guiEnabled = false
  --TriggerEvent("core:startSkyCamera")
  loadInCords = coords 
  --Wait(3000)
  -- DoScreenFadeIn(50)
 -- TriggerEvent('ems:heal')
end)

RegisterNetEvent("core:locationMenu")
AddEventHandler("core:locationMenu", function(coords)
 WarMenu.OpenMenu('waypoints')
end)

Citizen.CreateThread(function()
  WarMenu.CreateLongMenu('waypoints', 'Locations')
  while true do
   Wait(1)
    if WarMenu.IsMenuOpened('waypoints') then
     DisableControlAction(0,177,true)
     DisableControlAction(0,20,true)
     DisableControlAction(0,303,true)
     if WarMenu.Button('Previous Location') then
      WarMenu.CloseMenu()
      DoScreenFadeOut(50)
      TriggerEvent("core:stopSkyCamera")
      TriggerEvent('NRP-Hud:CharacterSpawned')
      FreezeEntityPosition(GetPlayerPed(-1), true)
      Teleport(loadInCords.x, loadInCords.y, loadInCords.z)
      Wait(3000)
      FreezeEntityPosition(GetPlayerPed(-1), false)
      DoScreenFadeIn(50)
      Wait(1000)
      TriggerServerEvent('prison:checkTime')
      TriggerServerEvent("core:newcharacter")
      ExecuteCommand('refreshmotels')     
     elseif WarMenu.Button('Alta Street - $1000') then
       WarMenu.CloseMenu()
       DoScreenFadeOut(50)
       TriggerEvent("core:stopSkyCamera")
       TriggerEvent('NRP-Hud:CharacterSpawned')
       FreezeEntityPosition(GetPlayerPed(-1), true)
       Teleport(-220.580, -1053.039, 30.140)
       Wait(3000)
       FreezeEntityPosition(GetPlayerPed(-1), false)
        DoScreenFadeIn(50)
       Wait(1000)
       TriggerServerEvent('prison:checkTime')
       TriggerServerEvent("core:newcharacter")
       ExecuteCommand('refreshmotels')
       TriggerServerEvent('core:locationcharge')
     elseif WarMenu.Button('Apartment Block - $1000') then
       WarMenu.CloseMenu()
       DoScreenFadeOut(50)
       TriggerEvent("core:stopSkyCamera")
       TriggerEvent('NRP-Hud:CharacterSpawned')
       FreezeEntityPosition(GetPlayerPed(-1), true)
       Teleport(328.135, -203.639, 54.086)
       Wait(3000)
       FreezeEntityPosition(GetPlayerPed(-1), false)
        DoScreenFadeIn(50)
       Wait(1000)
       TriggerServerEvent('prison:checkTime')
       TriggerServerEvent("core:newcharacter")
       ExecuteCommand('refreshmotels')
       TriggerServerEvent('core:locationcharge')
     elseif WarMenu.Button('Macdonald Street - $1000') then
       WarMenu.CloseMenu()
       DoScreenFadeOut(50)
       TriggerEvent("core:stopSkyCamera")
       TriggerEvent('NRP-Hud:CharacterSpawned')
       FreezeEntityPosition(GetPlayerPed(-1), true)
       Teleport(257.909, -1638.550, 29.286)
       Wait(3000)
       FreezeEntityPosition(GetPlayerPed(-1), false)
        DoScreenFadeIn(50)
       Wait(1000)
       TriggerServerEvent('prison:checkTime')
       TriggerServerEvent("core:newcharacter")
       ExecuteCommand('refreshmotels')
       TriggerServerEvent('core:locationcharge')
     elseif WarMenu.Button('Fleeca Bank - $1000') then
       WarMenu.CloseMenu()
       DoScreenFadeOut(50)
       TriggerEvent("core:stopSkyCamera")
       TriggerEvent('NRP-Hud:CharacterSpawned')
       FreezeEntityPosition(GetPlayerPed(-1), true)
       Teleport(151.634, -1035.179, 29.339)
       Wait(3000)
       FreezeEntityPosition(GetPlayerPed(-1), false)
        DoScreenFadeIn(50)
       Wait(1000)
       TriggerServerEvent('prison:checkTime')
       TriggerServerEvent("core:newcharacter")
       ExecuteCommand('refreshmotels')
       TriggerServerEvent('core:locationcharge')
     elseif WarMenu.Button('Mission Row - $1000') then
       WarMenu.CloseMenu()
       DoScreenFadeOut(50)
       TriggerEvent("core:stopSkyCamera")
       TriggerEvent('NRP-Hud:CharacterSpawned')
       FreezeEntityPosition(GetPlayerPed(-1), true)
       Teleport(427.541, -984.374, 30.711)
       Wait(3000)
       FreezeEntityPosition(GetPlayerPed(-1), false)
        DoScreenFadeIn(50)
       Wait(1000)
       TriggerServerEvent('prison:checkTime')
       TriggerServerEvent("core:newcharacter")
       ExecuteCommand('refreshmotels')
       TriggerServerEvent('core:locationcharge')
     elseif WarMenu.Button('Grove Street - $1000') then
       WarMenu.CloseMenu()
       DoScreenFadeOut(50)
       TriggerEvent("core:stopSkyCamera")
       TriggerEvent('NRP-Hud:CharacterSpawned')
       FreezeEntityPosition(GetPlayerPed(-1), true)
       Teleport(92.622, -1929.230, 20.804)
       Wait(3000)
       FreezeEntityPosition(GetPlayerPed(-1), false)
        DoScreenFadeIn(50)
       Wait(1000)
       TriggerServerEvent('prison:checkTime')
       TriggerServerEvent("core:newcharacter")
       ExecuteCommand('refreshmotels')
       TriggerServerEvent('core:locationcharge')
     elseif WarMenu.Button('Beach Gym - $1000') then
       WarMenu.CloseMenu()
       DoScreenFadeOut(50)
       TriggerEvent("core:stopSkyCamera")
       TriggerEvent('NRP-Hud:CharacterSpawned')
       FreezeEntityPosition(GetPlayerPed(-1), true)
       Teleport(-1202.033, -1569.531, 4.608)
       Wait(3000)
       FreezeEntityPosition(GetPlayerPed(-1), false)
       DoScreenFadeIn(50)
       Wait(1000)
       TriggerServerEvent('prison:checkTime')
       TriggerServerEvent("core:newcharacter")
       ExecuteCommand('refreshmotels')
       TriggerServerEvent('core:locationcharge')
     elseif WarMenu.Button('Sandy Apartments - $1000') then
       WarMenu.CloseMenu()
       DoScreenFadeOut(50)
       TriggerEvent("core:stopSkyCamera")
       TriggerEvent('NRP-Hud:CharacterSpawned')
       FreezeEntityPosition(GetPlayerPed(-1), true)
       Teleport(1110.766, 2646.932, 38.011)
       Wait(3000)
       FreezeEntityPosition(GetPlayerPed(-1), false)
       DoScreenFadeIn(50)
       Wait(1000)
       TriggerServerEvent('prison:checkTime')
       TriggerServerEvent("core:newcharacter")
       ExecuteCommand('refreshmotels')
       TriggerServerEvent('core:locationcharge')
     end
     WarMenu.Display()
    end
  end
end)

RegisterNetEvent("core:switchcharacter")
AddEventHandler("core:switchcharacter", function()
 TriggerServerEvent('core:characterDisconnect')
 TriggerEvent("core:startSkyCamera")
 TriggerServerEvent("core:getCharacters")
end)

--[[RegisterNetEvent("core:characterscreen")
AddEventHandler("core:characterscreen", function(characters, perm)
 permission_level = perm
 local html = ''
 character = characters
 for id,v in pairs(characters) do 
  local char = string.format('<div class="character" id="%s"><p>%s <span class="date">%s</span></p><p>Cash: $%s <span class="separator">•</span> Bank: $%s <span class="separator">•</span> Dirty Cash: $%s</p><p>Playtime: %s Hours</p></div>', id, v.name, v.dob, v.cash, v.bank, v.dirty_money, math.floor(v.playtime/60))
  html = html..char
 end
 EnableGui(true, html)
end)
]]

RegisterNetEvent("core:characterscreen")
AddEventHandler("core:characterscreen", function(characters, perm)
 permission_level = perm
 local html = ''
 character = characters
 for id,v in pairs(characters) do 
  local char = string.format('<div class="character" id="%s"><div class="char-header"><h2 class="name">%s</h2></div><div class="char-info"><p class="date">%s</p><p>Cash: $%s <span>•</span> Bank: $%s</p><p>Dirty Cash: %s</p><p>Playtime: %s Hours</p></div></div>', id, v.name, v.dob, v.cash, v.bank, v.dirty_money, math.floor(v.playtime/60))
  html = html..char
 end
 EnableGui(true, html)
end)


--[[RegisterNetEvent("core:characterscreen")
AddEventHandler("core:characterscreen", function(characters, perm)
 permission_level = perm
 local html = ''
 character = characters
 for id,v in pairs(characters) do 
  local char = string.format('<div class="character" id="%s" data-name="%s"><div class="char-header"><h2 class="name">%s</h2><h2 class="date">%s</h2></div><div class="char-info"><p>Cash: $%s <span>•</span> Bank: $%s</p><p>Dirty Cash: %s</p><p>Playtime: %s Hours</p></div><div class="char-options"><button class="select">Select</button><button class="delete-prompt">Delete</button></div></div>', id, v.name, v.name, v.dob, v.cash, v.bank, v.dirty_money, math.floor(v.playtime/60))
  html = html..char
 end
 EnableGui(true, html)
end)]]--
-- NUI Callback Events
RegisterNUICallback('selectcharacter', function(data, cb)
  --DoScreenFadeOut(50)
  EnableGui(false,false)
  TriggerServerEvent("core:loadcharacter", character[data.id])
  Wait(5000)
  TriggerServerEvent('skinCreation:load', character[data.id].gender)
  --TriggerEvent("core:stopSkyCamera")
  cb('ok') ---testing
  TriggerEvent('NRP-Hud:CharacterSpawned')
end)

RegisterNUICallback('deletecharacter', function(data, cb)
  if character[data.id].jailtime == 0 then
    EnableGui(false,false) 
    TriggerServerEvent("core:deletecharacter", character[data.id].id)
  end
end)

RegisterNUICallback('create', function(data, cb) 
  EnableGui(false,false)
  Wait(10)
  TriggerServerEvent("core:createcharacter", data)
  cb('ok')
end)

RegisterNUICallback('refreshload', function(data, cb)
 if guiEnabled then 
  TriggerServerEvent("core:getCharacters")
 end
end)

--Updating Position Of Player
Citizen.CreateThread(function()
 while true do
  Wait(7500)
  if not guiEnabled then
   local pos = GetEntityCoords(GetPlayerPed(-1))
   TriggerServerEvent('core:updateposition', pos.x, pos.y, pos.z)
  end
 end
end)

function Teleport(x,y,z)
 Citizen.CreateThread(function()
  RequestCollisionAtCoord(x, y, z)
  while not HasCollisionLoadedAroundEntity(GetPlayerPed(-1)) do
   RequestCollisionAtCoord(x, y, z)
   Citizen.Wait(1)
  end
  if x ~= 0.0 and y ~= 0.0 and z ~= 0.0 then
   SetEntityCoords(GetPlayerPed(-1), x, y, z)
  else
   SetEntityCoords(GetPlayerPed(-1), -220.744, -1053.473, 29.540)
  end
 end)
end

--==========================
--==== Character Switch ====
--==========================
local logout = {
 [1] = {x = 1699.973, y = 2521.186, z = -121.740}, -- Inside Prison Cell Block
 [2] = {x = 429.9541, y = -811.517, z = 28.541}, 
 [3] = {x = 1929.163, y = 3732.566, z = 31.864},
 [4] = {x = 3.835, y = 6505.733, z = 30.897},
 [5] = {x = 262.810, y = -1002.794, z = -99.008-0.97},
 [6] = {x = 349.519, y = -994.818, z = -99.196-0.97},
 [7] = {x = 165.879, y = 479.333, z = 133.843-0.97},
 [8] = {x = 376.693, y = 407.939, z = 142.125-0.97},
 [9] = {x = 153.580, y = -1002.832, z = -99.0-0.97}
} 

--[[Citizen.CreateThread(function()
 while true do
  local coords = GetEntityCoords(GetPlayerPed(-1))
  Wait(5)
  for k,v in pairs(logout) do
   if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 50) then
    DrawMarker(27, v.x, v.y, v.z+0.05, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 66, 255, 255, 10, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.5) then
     drawTxt('~m~Press ~g~E~m~ To Switch Character')
     if IsControlJustPressed(0, 38) then
      TriggerEvent('prison:switchcharacter')
      TriggerServerEvent('core:characterDisconnect')
      TriggerEvent("core:startSkyCamera")
      TriggerServerEvent("core:getCharacters")
     end
    end
   end
  end
 end
end)]]--

local timer = 120

Citizen.CreateThread(function()
 while true do
  Wait(0)
  local coords = GetEntityCoords(GetPlayerPed(-1))
  for k,v in pairs(logout) do
   if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 50) then
    DrawMarker(27, v.x, v.y, v.z+0.05, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 255,255, 0, 255, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.5) then
      if timer > 9 then drawTxt('~w~You Need To Wait ~g~'..timer..' ~w~Seconds To Change Characters Again')
      else
        drawTxt('~g~[E]~w~ Switch Character')
        if IsControlJustPressed(0, 38) then
          timer = 120
          TriggerEvent('prison:switchcharacter')
          TriggerServerEvent('core:characterDisconnect')
          TriggerEvent("core:startSkyCamera")
          TriggerServerEvent("core:getCharacters")
         end
       end
     end
   end
  end
 end
end)

-- Timer countdown
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
    if timer > 0 then
      timer = timer - 1
    end
  end
end)
