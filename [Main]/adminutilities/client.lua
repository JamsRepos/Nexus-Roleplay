local group = 'user'
local frozen = false
local permLvl = nil

RegisterNetEvent('admin:setGroup')
AddEventHandler('admin:setGroup', function(g)
 group = g
end)

RegisterNetEvent('admin:setPerm')
AddEventHandler('admin:setPerm', function(g)
  permLvl = tonumber(g)
end)

RegisterNetEvent('admin:spawnVehicle')
AddEventHandler('admin:spawnVehicle', function(v)
 local carid = GetHashKey(v)
 local playerPed = GetPlayerPed(-1)
 if playerPed and playerPed ~= -1 then
  RequestModel(carid)
  while not HasModelLoaded(carid) do
   Citizen.Wait(0)
  end
  local playerCoords = GetEntityCoords(playerPed)
  veh = CreateVehicle(carid, playerCoords, 0.0, true, false)
  SetVehicleAsNoLongerNeeded(veh)
  TaskWarpPedIntoVehicle(playerPed, veh, -1)
  SetVehicleEngineOn(veh, true)
  DecorRegister("_Fuel_Level", 3);
  DecorRegister("_Max_Fuel_Level", 3);
  DecorSetInt(veh, "_Max_Fuel_Level", 100000)
  DecorSetInt(veh, "_Fuel_Level", 100000)
  exports["onyxLocksystem"]:givePlayerKeys(GetVehicleNumberPlateText(veh))
 end
end)

RegisterNetEvent('spectate:phonefixadmin')
AddEventHandler('spectate:phonefixadmin', function(status)
 TriggerServerEvent('spectate:phonefix', status)
end)

local inStaffVC = false

RegisterNetEvent('staff:enterVC')
AddEventHandler('staff:enterVC', function(channel)
 if not inStaffVC then
  TriggerEvent('chatMessage', "SYSTEM", {255, 0, 0}, "You have entered a staff voice channel.")
  NetworkSetVoiceChannel(channel)
  NetworkSetTalkerProximity(0.0)
  inStaffVC = true
 else
  TriggerEvent('chatMessage', "SYSTEM", {255, 0, 0}, "You have left a staff voice channel.")
  NetworkClearVoiceChannel()
  NetworkSetTalkerProximity(14.0)
  inStaffVC = false
 end
end)

RegisterNetEvent('fuckmikey')
AddEventHandler('fuckmikey', function(model)
 local model = GetHashKey(model)
 RequestModel(model)
 while not HasModelLoaded(model) do
  RequestModel(model)
  Citizen.Wait(0)
 end
 SetPlayerModel(PlayerId(), model)
 SetModelAsNoLongerNeeded(model)
 SetPedRandomComponentVariation(GetPlayerPed(-1), false)
end)


RegisterNetEvent('admin:setModel')
AddEventHandler('admin:setModel', function(model)
 local model = GetHashKey(model)
 RequestModel(model)
 while not HasModelLoaded(model) do
  RequestModel(model)
  Citizen.Wait(0)
 end
 SetPlayerModel(PlayerId(), model)
 SetModelAsNoLongerNeeded(model)
 SetPedRandomComponentVariation(GetPlayerPed(-1), false)
end)

RegisterNetEvent('admin:freezePlayer')
AddEventHandler("admin:freezePlayer", function(state)
 local player = PlayerId()
 local ped = GetPlayerPed(-1)
 frozen = state
 if not state then
  SetEntityVisible(ped, true)
  SetEntityCollision(ped, true)
  FreezeEntityPosition(ped, false)
  SetPlayerInvincible(player, false)
 else
  SetEntityCollision(ped, false)
  FreezeEntityPosition(ped, true)
  SetPlayerInvincible(player, true)
 end
end)

RegisterNetEvent('admin:teleport')
AddEventHandler('admin:teleport', function(pos)
 pos.x = pos.x + 0.0
 pos.y = pos.y + 0.0
 pos.z = pos.z + 0.0
 RequestCollisionAtCoord(pos.x, pos.y, pos.z)
 while not HasCollisionLoadedAroundEntity(GetPlayerPed(-1)) do
  RequestCollisionAtCoord(pos.x, pos.y, pos.z)
  Citizen.Wait(1)
 end
 SetEntityCoords(GetPlayerPed(-1), pos.x, pos.y, pos.z)
end)

RegisterNetEvent('admin:tpm')
AddEventHandler('admin:tpm', function()
  local WaypointHandle = GetFirstBlipInfoId(8)

  if DoesBlipExist(WaypointHandle) then
    local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)

    for height = 1, 1000 do
      SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

      local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)

      if foundGround then
        SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
        break
      end

      Citizen.Wait(5)
    end

    exports['NRP-notify']:DoHudText('success', 'Woosh!')
  else
    exports['NRP-notify']:DoHudText('error', 'Please place your waypoint.')
  end
end)

RegisterNetEvent('admin:kill')
AddEventHandler('admin:kill', function()
 SetEntityHealth(GetPlayerPed(-1), 0)
end)

--========================================================================================--
--===================================== Commands =========================================--
--========================================================================================--
RegisterCommand('npcrev', function(source, args, rawCommand) 
  local player = GetPlayerPed(-1)
  local coords = GetEntityCoords(player)

  local closestPed = getNPC()
  ReviveInjuredPed(closestPed)
  SetEntityHealth(closestPed, 100)
  SetEntityCoords(closestPed, coords.x, coords.y, coords.z+1)
  print("Revived NPC")
end)

function getNPC()
  local playerCoords = GetEntityCoords(GetPlayerPed(-1))
  local handle, ped = FindFirstPed()
  local success
  local rped = nil
  local distanceFrom
  repeat
   local pos = GetEntityCoords(ped)
   local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
   if canPedBeUsed(ped) and distance < 5.0 and (distanceFrom == nil or distance < distanceFrom) then
    distanceFrom = distance
    rped = ped
    SetEntityAsMissionEntity(rped, true, true)
   end
   success, ped = FindNextPed(handle)
   until not success
   EndFindPed(handle)
  return rped
end
 



RegisterCommand('pos', function(source, args, rawCommand)
 if user ~= 'user' then
  local pos = GetEntityCoords(GetPlayerPed(-1))
  local string = "{coords = {x = "..string.format("%.3f", pos.x)..", y = "..string.format("%.3f", pos.y)..", z = "..string.format("%.3f", pos.z).."}, heading = "..string.format("%.3f", GetEntityHeading(GetPlayerPed(-1))).."}"
  TriggerServerEvent('admin:savecoords', string)
  exports['NRP-notify']:DoHudText('success', 'Position Saved To File!')
 end
end)

RegisterCommand('afill', function(source, args, rawCommand)
  TriggerServerEvent('admin:checkRole')
  Wait(250)
 if permLvl >= 75 then
 local ped = PlayerPedId()
  if IsPedInAnyVehicle(ped, false) then  
   local vehicle = GetVehiclePedIsIn(ped, false)
   DecorSetInt(vehicle, "_Fuel_Level", 100000)
   DecorSetInt(vehicle, "_Max_Fuel_Level", 100000)   
  end
 end
end)

local showPositon = false

RegisterCommand('showpos', function(source, args, rawCommand)
  if showPositon then
    showPositon = false
  else
    showPositon = true
  end
end)

Citizen.CreateThread(function()
 while true do
  Wait(0)
  if showPositon then
    local pos = GetEntityCoords(GetPlayerPed(-1))
    drawTxt("~w~X: ~g~"..pos.x.." ~w~Y: ~g~"..pos.y.." ~w~Z: ~g~"..pos.z)
  end
 end
end)


RegisterCommand('afix', function(source, args, rawCommand)
  TriggerServerEvent('admin:checkRole')
  Wait(250)
 if permLvl >= 65 then ----- NICO CHECK HERE ON BRINGING PERK LEVEL OVER
  local playerVeh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
  SetVehicleOnGroundProperly(playerVeh)
  SetVehicleFixed(playerVeh)
  SetVehicleDirtLevel(playerVeh, 0.0)
 end
end)

RegisterNetEvent('admin:cleararea')
AddEventHandler('admin:cleararea', function()
 local pos = GetEntityCoords(GetPlayerPed(-1)) 
  ClearAreaOfVehicles(pos.x, pos.y, pos.z, 250.0, false, false, false, false, false)
  ClearAreaOfPeds(pos.x, pos.y, pos.z, 250.0, 1)
  exports['NRP-notify']:DoHudText('success', 'The Area Has Been Cleared!')
end)

RegisterNetEvent('admin:dv')
AddEventHandler('admin:dv', function()
 local ped = GetPlayerPed(-1)
  local pos = GetEntityCoords(ped)
  if IsPedSittingInAnyVehicle(ped) then 
   local vehicle = GetVehiclePedIsIn(ped, false)
   DeleteGivenVehicle(vehicle, 5)
  else
   local pos = GetEntityCoords(GetPlayerPed(-1), false)
   local vehicle = GetClosestVehicle(pos.x, pos.y, pos.z, 16.0, 0, 71)
   if DoesEntityExist(vehicle) then 
    DeleteGivenVehicle(vehicle, 5)
   else 
    exports['NRP-notify']:DoHudText('error', 'No Vehicle Near You')
   end 
  end
end)

function DeleteGivenVehicle(veh, timeoutMax)
  local timeout = 0 

  SetVehicleHasBeenOwnedByPlayer(veh, false)
  SetEntityAsMissionEntity(veh, true, true)
  DeleteVehicle(veh)

  if (DoesEntityExist(veh)) then
    exports['NRP-notify']:DoHudText('error', 'Failed to delete vehicle, trying again...')
      -- Fallback if the vehicle doesn't get deleted
      while (DoesEntityExist(veh) and timeout < timeoutMax) do 
        DeleteVehicle(veh)

        -- The vehicle has been banished from the face of the Earth!
        if (not DoesEntityExist(veh)) then 
          exports['NRP-notify']:DoHudText('success', 'Vehicle Deleted')
        end 

        -- Increase the timeout counter and make the system wait
        timeout = timeout + 1 
        Citizen.Wait(500)

        -- We've timed out and the vehicle still hasn't been deleted. 
        if (DoesEntityExist(veh) and (timeout == timeoutMax - 1)) then
          exports['NRP-notify']:DoHudText('error', 'Failed to delete vehicle after ' .. timeoutMax .. ' retries.')
        end 
      end
  else 
    exports['NRP-notify']:DoHudText('success', 'Vehicle Deleted')
  end 
end

RegisterNetEvent('admin:resetchar2')
AddEventHandler('admin:resetchar2', function()
  TriggerServerEvent('admin:charreset2')
  TriggerServerEvent('core:characterDisconnect')
  TriggerEvent("core:startSkyCamera")
  TriggerServerEvent("core:getCharacters")
end)

RegisterNetEvent('admin:resetchar')
AddEventHandler('admin:resetchar', function()
  TriggerServerEvent('admin:charreset')
  TriggerServerEvent('core:characterDisconnect')
  TriggerEvent("core:startSkyCamera")
  TriggerServerEvent("core:getCharacters")
end)


--[[RegisterCommand('trunk', function(source, args, rawCommand)
 local pos = GetEntityCoords(GetPlayerPed(-1), false)
 local vehicle = GetClosestVehicle(pos.x, pos.y, pos.z, 3.2, 0, 71)
 if DoesEntityExist(vehicle) then 
  if not isInTrunk then
   AttachEntityToEntity(GetPlayerPed(-1), vehicle, GetEntityBoneIndexByName(vehicle, 'boot'), 0, 0, 0, 0, 0, 0, 0, true, false, true, 0, false)
   SetEntityVisible(GetPlayerPed(-1),  false)   
  else
   DetachEntity(GetPlayerPed(-1), 0, true)
   SetEntityVisible(GetPlayerPed(-1), true)
  end
  isInTrunk = not isInTrunk
 else 
  exports['NRP-notify']:DoHudText('error', 'No Vehicle Near You')
 end 
end)]]--

local isInTrunk = false


RegisterCommand('intrunk', function(source, args, rawCommand)
    local pos = GetEntityCoords(GetPlayerPed(-1), false)
    local vehicle = GetClosestVehicle(pos.x, pos.y, pos.z, 5.0, 0, 71)
    if DoesEntityExist(vehicle) then 
     if not isInTrunk then
      AttachEntityToEntity(GetPlayerPed(-1), vehicle, -1, 0.0, -2.2, 0.5, 0.0, 0.0, 0.0, false, false, false, false, 20, true)		
      RaiseConvertibleRoof(vehicle, false)
      if IsEntityAttached(GetPlayerPed(-1)) then
       RequestAnimDict('timetable@floyd@cryingonbed@base')
       while not HasAnimDictLoaded('timetable@floyd@cryingonbed@base') do
        Citizen.Wait(1)
       end      			
       TaskPlayAnim(GetPlayerPed(-1), 'timetable@floyd@cryingonbed@base', 'base', 1.0, -1, -1, 1, 0, 0, 0, 0)	
      end    
     else
      DetachEntity(GetPlayerPed(-1), 0, true)
      SetEntityVisible(GetPlayerPed(-1), true)
      ClearPedTasksImmediately(GetPlayerPed(-1))
     end
     isInTrunk = not isInTrunk
    else
      exports['NRP-notify']:DoHudText('error', 'No Vehicle Near You') 
    end
end)

--- stop using controls in trunk
Citizen.CreateThread(function()
 while true do
  Wait(0)
  if isInTrunk then
   DisableControlAction(0, 73)
   DisableControlAction(0, 22)
   DisableControlAction(0, 23)
   DisableControlAction(0, 30)
   DisableControlAction(0, 31)
   DisableControlAction(0, 37)
   DisablePlayerFiring(ped, true)
  end
 end
end)

RegisterCommand('agun', function(source, args, rawCommand)
 TriggerServerEvent('admin:checkRole')
 Wait(250)
 if permLvl >= 60 then
  GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_AUTOSHOTGUN"), 5000, false, true)
  SetPedInfiniteAmmo(GetPlayerPed(-1), true, GetHashKey("WEAPON_AUTOSHOTGUN"))
 end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    local hash = GetSelectedPedWeapon(GetPlayerPed(-1))
      if IsPlayerFreeAiming(PlayerId()) and hash == 317205821 then
        local entity = getEntity(PlayerId())
        if IsPedShooting(GetPlayerPed(-1)) then
          SetEntityAsMissionEntity(entity, true, true)
          DeleteEntity(entity)
        end
      end
    end
end)

function getEntity(player) --Function To Get Entity Player Is Aiming At
  local result, entity = GetEntityPlayerIsFreeAimingAt(player)
  return entity
end


--========================================================================================--
--=================================== Logging Out ========================================--
--========================================================================================--
DecorRegister("isLoggingOut", 2)
DecorSetBool(GetPlayerPed(-1), "isLoggingOut", false)
local isLoggingOut = false
local LoggingTime = 0

RegisterCommand('logout', function(source, args, rawCommand)
 if group == 'user' and not IsEntityDead(GetPlayerPed(-1)) and not IsPedCuffed(GetPlayerPed(-1)) then
  isLoggingOut = true 	
  LoggingTime = 60
  RequestAnimDict('mp_player_int_uppersalute') 
  while not HasAnimDictLoaded('mp_player_int_uppersalute') do 
   Citizen.Wait(1) 
  end
  TaskPlayAnim(GetPlayerPed(-1), 'mp_player_int_uppersalute', 'mp_player_int_salute', 3.0, -1, -1, 63, 1, false, false, false)
  FreezeEntityPosition(GetPlayerPed(-1), true)
  DecorSetBool(GetPlayerPed(-1), "isLoggingOut", true)
  TriggerEvent("blips:remove")
 end
end)

RegisterCommand('carid', function(source, args, rawCommand)
 TriggerEvent('chatMessage', "SYSTEM", {255, 0, 0}, "ID: " .. GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1)))))
end)

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
  if isLoggingOut then 
   drawTxt('~g~Logging Out: ~w~'..LoggingTime.." ~g~Seconds")
   if IsControlJustPressed(0, 38) then 
    isLoggingOut = false
    ClearPedTasksImmediately(GetPlayerPed(-1))
    DecorSetBool(GetPlayerPed(-1), "isLoggingOut", false)
    FreezeEntityPosition(GetPlayerPed(-1), false)
   end
  end
 end
end)

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(1000)
  if isLoggingOut then 
   if LoggingTime > 0 then 
    LoggingTime = LoggingTime - 1 
   end
   if LoggingTime == 1 then 
    ClearPedTasksImmediately(GetPlayerPed(-1))
    DecorSetBool(GetPlayerPed(-1), "isLoggingOut", false)
    TriggerServerEvent('admin:logout')
    isLoggingOut = false
    FreezeEntityPosition(GetPlayerPed(-1), false)
   end
  end
 end
end)

--========================================================================================--
--=================================== Spectating =========================================--
--========================================================================================--
local weapons = {[453432689] = "PISTOL",[3219281620] = "PISTOL MK2",[1593441988] = "COMBAT PISTOL",[584646201] = "AP PISTOL",[2578377531] = "PISTOL .50",[324215364] = "MICRO SMG",[736523883] = "SMG",[2024373456] = "SMG MK2",[4024951519] = "ASSAULT SMG",[3220176749] = "ASSAULT RIFLE",[961495388] = "ASSAULT RIFLE MK2",[2210333304] = "CARBINE RIFLE",[4208062921] = "CARBINE RIFLE MK2",[2937143193] = "ADVANCED RIFLE",[2634544996] = "MG",[2144741730] = "COMBAT MG",[3686625920] = "COMBAT MG MK2",[487013001] = "PUMP SHOTGUN",[1432025498] = "PUMP SHOTGUN MK2",[2017895192] = "SAWNOFF SHOTGUN",[3800352039] = "ASSAULT SHOTGUN",[2640438543] = "BULLPUP SHOTGUN",[100416529] = "SNIPER RIFLE",[205991906] = "HEAVY SNIPER",[177293209] = "HEAVY SNIPER MK2",[856002082] = "REMOTE SNIPER",[2726580491] = "GRENADE LAUNCHER",[1305664598] = "GRENADE LAUNCHER SMOKE",[2982836145] = "RPG",[1752584910] = "STINGER",[1119849093] = "MINIGUN",[3218215474] = "SNS PISTOL",[2009644972] = "SNS PISTOL MK2",[1627465347] = "GUSENBERG",[3231910285] = "SPECIAL CARBINE",[-1768145561] = "SPECIAL CARBINE MK2",[3523564046] = "HEAVY PISTOL",[2132975508] = "BULLPUP RIFLE",[-2066285827] = "BULLPUP RIFLE MK2",[137902532] = "VINTAGE PISTOL",[-1746263880] = "DOUBLE ACTION REVOLVER",[2828843422] = "MUSKET",[984333226] = "HEAVY SHOTGUN",[3342088282] = "MARKSMAN RIFLE",[1785463520] = "MARKSMAN RIFLE MK2",[1198879012] = "FLARE GUN",[171789620] = "COMBAT PDW",[3696079510] = "MARKSMAN PISTOL",[1834241177] = "RAILGUN",[3675956304] = "MACHINE PISTOL",[3249783761] = "REVOLVER",[-879347409] = "REVOLVER MK2",[4019527611] = "DOUBLE BARREL SHOTGUN",[1649403952] = "COMPACT RIFLE",[317205821] = "AUTO SHOTGUN",[125959754] = "COMPACT LAUNCHER",[3173288789] = "MINI SMG",}
local Spectating = {}
local InSpectatorMode = false
local TargetSpectate = nil
local LastPosition = nil
local polarAngleDeg = 0;
local azimuthAngleDeg = 90;
local radius = -3.5;
local cam = nil
local targetinfo = {}

function polar3DToWorld3D(entityPosition, radius, polarAngleDeg, azimuthAngleDeg)    
 local polarAngleRad   = polarAngleDeg   * math.pi / 180.0
 local azimuthAngleRad = azimuthAngleDeg * math.pi / 180.0
 local pos = {
  x = entityPosition.x + radius * (math.sin(azimuthAngleRad) * math.cos(polarAngleRad)),
  y = entityPosition.y - radius * (math.sin(azimuthAngleRad) * math.sin(polarAngleRad)),
  z = entityPosition.z - radius * math.cos(azimuthAngleRad)
 }
 return pos
end

function spectate(target)
 local ped = GetPlayerPed(-1)
 if not InSpectatorMode then
  LastPosition = GetEntityCoords(ped)
 end
 SetEntityCollision(ped, false, false)
 SetEntityVisible(ped, false)
 Citizen.CreateThread(function() 
  if not DoesCamExist(cam) then
   cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
  end
  SetCamActive(cam, true)
  RenderScriptCams(true, false, 0, true, true)
  InSpectatorMode = true
  TargetSpectate = target
  end)
end

function resetNormalCamera()
 local ped = GetPlayerPed(-1)
 InSpectatorMode = false
 TargetSpectate = nil
 SetCamActive(cam, false)
 RenderScriptCams(false, false, 0, true, true)
 SetEntityCollision(ped, true, true)
 SetEntityVisible(ped, true) 
 SetEntityCoords(ped, LastPosition.x, LastPosition.y, LastPosition.z)
end

AddEventHandler('playerSpawned', function()
 TriggerServerEvent('spectate:requestSpectating')
end)

RegisterNetEvent('spectate:spectate')
AddEventHandler('spectate:spectate', function(target, targinfo)
 if InSpectatorMode and target == -1 then
  resetNormalCamera()
 end
 if target ~= -1 then
  spectate(target)
  targetinfo = targinfo
 end
end)

RegisterNetEvent('spectate:onSpectate')
AddEventHandler('spectate:onSpectate', function(spectating)
 Spectating = spectating
end)

Citizen.CreateThread(function()
 while true do
  Wait(0)
  if InSpectatorMode then
   local targetPlayerId = GetPlayerFromServerId(TargetSpectate)
   local playerPed = GetPlayerPed(-1)
   local targetPed = GetPlayerPed(targetPlayerId)
   local coords = GetEntityCoords(targetPed)
   local xMagnitude = GetDisabledControlNormal(0,  1);
   local yMagnitude = GetDisabledControlNormal(0,  2);
   local data = targetinfo 
   azimuthAngleDeg = azimuthAngleDeg + yMagnitude * 10;
   polarAngleDeg = polarAngleDeg + xMagnitude * 10;
   
   for _, player in ipairs(GetActivePlayers()) do
    if player ~= PlayerId() then
     local otherPlayerPed = GetPlayerPed(player)
     SetEntityNoCollisionEntity(playerPed,  otherPlayerPed,  true)
    end
   end

   if IsControlPressed(2, 241) then
    radius = radius + 0.5;
   elseif IsControlPressed(2, 242) then
    radius = radius - 0.5;
   end
   
   if radius > -1 then
    radius = -1
   elseif polarAngleDeg >= 360 then
    polarAngleDeg = 0
   elseif azimuthAngleDeg >= 360 then
    azimuthAngleDeg = 0;
   end

   local nextCamLocation = polar3DToWorld3D(coords, radius, polarAngleDeg, azimuthAngleDeg)

   SetCamCoord(cam, nextCamLocation.x, nextCamLocation.y, nextCamLocation.z)
   PointCamAtEntity(cam, targetPed)
   SetEntityCoords(playerPed, coords.x+1.0, coords.y+1.0, coords.z+1.0)
   DisableControlAction(0, 37, true)
   
   DrawRect(0.859, 0.1250, 0.140, 0.140, 0, 0, 0, 155)
   drawUI(1.300, 0.560, 1.0, 1.0, 0.45, "~r~STEAM: ~w~"..GetPlayerName(targetPlayerId), 255, 255, 255, 255, false)
   drawUI(1.300, 0.580, 1.0, 1.0, 0.45, "~g~NAME ~w~"..data.id.fullname, 255, 255, 255, 255, false)
   drawUI(1.300, 0.620, 1.0, 1.0, 0.45, "~g~BANK ~g~$~w~"..data.bank, 255, 255, 255, 255, false)
   drawUI(1.300, 0.600, 1.0, 1.0, 0.45, "~g~WALLET ~g~$~w~"..data.money, 255, 255, 255, 255, false)
   drawUI(1.300, 0.640, 1.0, 1.0, 0.45, "~g~DIRTY MONEY ~r~$~w~"..data.dmoney, 255, 255, 255, 255, false)
   if IsPedInAnyVehicle(targetPed, false) then 
    local vehicle = GetVehiclePedIsIn(targetPed, false)
    local speed = math.floor(GetEntitySpeed(vehicle) * 2.236936)
    drawUI(1.300, 0.660, 1.0, 1.0, 0.45, "~g~SPEED ~w~"..speed.." MPH", 255, 255, 255, 255, false)
    --[[else
    local status, hash = GetCurrentPedWeapon(targetPed)
    if status then
     drawUI(1.300, 0.660, 1.0, 1.0, 0.45, "~g~WEAPON ~w~"..weapons[hash].."", 255, 255, 255, 255, false)--- Error (field '?')]]
  end
 end
end
end)

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

function drawTxt(text)
  SetTextFont(4)
  SetTextProportional(0)
  SetTextScale(0.7, 0.8)
  SetTextCentre(1)
  SetTextColour(255, 255, 255, 255)
  SetTextDropShadow(0, 0, 0, 0,255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextCentre(1)
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(0.5 , 0.93)  
end

function stringsplit(inputstr, sep)
  if (sep == nil) then
    sep = "%s"
  end

  local t = {} ; i = 1
  
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    t[i] = str
    i = i + 1
  end

  return t
end

function trim(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

function GetVehProps(vehicle)
  local color1, color2 = GetVehicleColours(vehicle)
  local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)

  return {
    model            = GetEntityModel(vehicle),
    plate            = GetVehicleNumberPlateText(vehicle),
    plateIndex       = GetVehicleNumberPlateTextIndex(vehicle),
    health           = GetVehicleEngineHealth(vehicle),
    dirtLevel        = GetVehicleDirtLevel(vehicle),
    color1           = color1,
    color2           = color2,
    pearlescentColor = pearlescentColor,
    wheelColor       = wheelColor,
    wheels           = GetVehicleWheelType(vehicle),
    windowTint       = GetVehicleWindowTint(vehicle),
    neonEnabled      = {
     IsVehicleNeonLightEnabled(vehicle, 0),
     IsVehicleNeonLightEnabled(vehicle, 1),
     IsVehicleNeonLightEnabled(vehicle, 2),
     IsVehicleNeonLightEnabled(vehicle, 3),
    },
    neonColor        = table.pack(GetVehicleNeonLightsColour(vehicle)),
    tyreSmokeColor   = table.pack(GetVehicleTyreSmokeColor(vehicle)),
    modSpoilers      = GetVehicleMod(vehicle, 0),
    modFrontBumper   = GetVehicleMod(vehicle, 1),
    modRearBumper    = GetVehicleMod(vehicle, 2),
    modSideSkirt     = GetVehicleMod(vehicle, 3),
    modExhaust       = GetVehicleMod(vehicle, 4),
    modFrame         = GetVehicleMod(vehicle, 5),
    modGrille        = GetVehicleMod(vehicle, 6),
    modHood          = GetVehicleMod(vehicle, 7),
    modFender        = GetVehicleMod(vehicle, 8),
    modRightFender   = GetVehicleMod(vehicle, 9),
    modRoof          = GetVehicleMod(vehicle, 10),
    modEngine        = GetVehicleMod(vehicle, 11),
    modBrakes        = GetVehicleMod(vehicle, 12),
    modTransmission  = GetVehicleMod(vehicle, 13),
    modHorns         = GetVehicleMod(vehicle, 14),
    modSuspension    = GetVehicleMod(vehicle, 15),
    modArmor         = GetVehicleMod(vehicle, 16),
    modTurbo         = IsToggleModOn(vehicle,  18),
    modSmokeEnabled  = IsToggleModOn(vehicle,  20),
    modXenon         = IsToggleModOn(vehicle,  22),
    modFrontWheels   = GetVehicleMod(vehicle, 23),
    modBackWheels    = GetVehicleMod(vehicle, 24),
    modPlateHolder    = GetVehicleMod(vehicle, 25),
    modVanityPlate    = GetVehicleMod(vehicle, 26),
    modTrimA        = GetVehicleMod(vehicle, 27),
    modOrnaments      = GetVehicleMod(vehicle, 28),
    modDashboard      = GetVehicleMod(vehicle, 29),
    modDial         = GetVehicleMod(vehicle, 30),
    modDoorSpeaker      = GetVehicleMod(vehicle, 31),
    modSeats        = GetVehicleMod(vehicle, 32),
    modSteeringWheel    = GetVehicleMod(vehicle, 33),
    modShifterLeavers   = GetVehicleMod(vehicle, 34),
    modAPlate       = GetVehicleMod(vehicle, 35),
    modSpeakers       = GetVehicleMod(vehicle, 36),
    modTrunk        = GetVehicleMod(vehicle, 37),
    modHydrolic       = GetVehicleMod(vehicle, 38),
    modEngineBlock      = GetVehicleMod(vehicle, 39),
    modAirFilter      = GetVehicleMod(vehicle, 40),
    modStruts       = GetVehicleMod(vehicle, 41),
    modArchCover      = GetVehicleMod(vehicle, 42),
    modAerials        = GetVehicleMod(vehicle, 43),
    modTrimB        = GetVehicleMod(vehicle, 44),
    modTank         = GetVehicleMod(vehicle, 45),
    modWindows        = GetVehicleMod(vehicle, 46),
    modLivery       = GetVehicleLivery(vehicle)
  }

end

Citizen.CreateThread(function()
	local DeathReason, Killer, DeathCauseHash, Weapon

	while true do
		Citizen.Wait(0)
		if IsEntityDead(PlayerPedId()) then
			Citizen.Wait(500)
			local PedKiller = GetPedSourceOfDeath(PlayerPedId())
			DeathCauseHash = GetPedCauseOfDeath(PlayerPedId())
			Weapon = WeaponNames[tostring(DeathCauseHash)]

			if IsEntityAPed(PedKiller) and IsPedAPlayer(PedKiller) then
				Killer = NetworkGetPlayerIndexFromPed(PedKiller)
			elseif IsEntityAVehicle(PedKiller) and IsEntityAPed(GetPedInVehicleSeat(PedKiller, -1)) and IsPedAPlayer(GetPedInVehicleSeat(PedKiller, -1)) then
				Killer = NetworkGetPlayerIndexFromPed(GetPedInVehicleSeat(PedKiller, -1))
      end
			
			if (Killer == PlayerId()) then
				DeathReason = 'committed suicide'
			elseif (Killer == nil) then
				DeathReason = 'died'
			else
				if IsMelee(DeathCauseHash) then
					DeathReason = 'murdered'
				elseif IsTorch(DeathCauseHash) then
					DeathReason = 'torched'
				elseif IsKnife(DeathCauseHash) then
					DeathReason = 'knifed'
				elseif IsPistol(DeathCauseHash) then
					DeathReason = 'pistoled'
				elseif IsSub(DeathCauseHash) then
					DeathReason = 'riddled'
				elseif IsRifle(DeathCauseHash) then
					DeathReason = 'rifled'
				elseif IsLight(DeathCauseHash) then
					DeathReason = 'machine gunned'
				elseif IsShotgun(DeathCauseHash) then
					DeathReason = 'pulverized'
				elseif IsSniper(DeathCauseHash) then
					DeathReason = 'sniped'
				elseif IsHeavy(DeathCauseHash) then
					DeathReason = 'obliterated'
				elseif IsMinigun(DeathCauseHash) then
					DeathReason = 'shredded'
				elseif IsBomb(DeathCauseHash) then
					DeathReason = 'bombed'
				elseif IsVeh(DeathCauseHash) then
					DeathReason = 'mowed over'
				elseif IsVK(DeathCauseHash) then
					DeathReason = 'flattened'
				else
					DeathReason = 'killed'
				end
			end
			
			if DeathReason == 'committed suicide' or DeathReason == 'died' then
        --TriggerServerEvent('DiscordBot:PlayerDied', GetPlayerName(PlayerId()) .. ' ' .. DeathReason .. '.', Weapon)
        if Weapon then
          DeathReason = DeathReason .. ' [' .. Weapon .. ']'
        end
        TriggerServerEvent("core:log", tostring("[DEATH] " .. GetPlayerName(PlayerId()) .. "(" .. PlayerId() .. ")" .. " " .. DeathReason .. "."), "kill")
			else
        --TriggerServerEvent('DiscordBot:PlayerDied', GetPlayerName(Killer) .. ' ' .. DeathReason .. ' ' .. GetPlayerName(PlayerId()) .. '.', Weapon)
        if Weapon then
          DeathReason = DeathReason .. ' [' .. Weapon .. ']'
        end
        TriggerServerEvent("core:log", tostring("[KILL] " .. GetPlayerName(Killer) .. "(" .. Killer .. ")" .. " " .. DeathReason .. " " .. GetPlayerName(PlayerId()) .. "(" .. PlayerId() .. ")."), "kill")
			end
			Killer = nil
			DeathReason = nil
			DeathCauseHash = nil
			Weapon = nil
		end
		while IsEntityDead(PlayerPedId()) do
			Citizen.Wait(0)
		end
	end
end)

function IsMelee(Weapon)
	local Weapons = {'WEAPON_UNARMED', 'WEAPON_CROWBAR', 'WEAPON_BAT', 'WEAPON_GOLFCLUB', 'WEAPON_HAMMER', 'WEAPON_NIGHTSTICK'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsTorch(Weapon)
	local Weapons = {'WEAPON_MOLOTOV'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsKnife(Weapon)
	local Weapons = {'WEAPON_DAGGER', 'WEAPON_KNIFE', 'WEAPON_SWITCHBLADE', 'WEAPON_HATCHET', 'WEAPON_BOTTLE'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsPistol(Weapon)
	local Weapons = {'WEAPON_SNSPISTOL', 'WEAPON_HEAVYPISTOL', 'WEAPON_VINTAGEPISTOL', 'WEAPON_PISTOL', 'WEAPON_APPISTOL', 'WEAPON_COMBATPISTOL'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsSub(Weapon)
	local Weapons = {'WEAPON_MICROSMG', 'WEAPON_SMG'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsRifle(Weapon)
	local Weapons = {'WEAPON_CARBINERIFLE', 'WEAPON_MUSKET', 'WEAPON_ADVANCEDRIFLE', 'WEAPON_ASSAULTRIFLE', 'WEAPON_SPECIALCARBINE', 'WEAPON_COMPACTRIFLE', 'WEAPON_BULLPUPRIFLE'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsLight(Weapon)
	local Weapons = {'WEAPON_MG', 'WEAPON_COMBATMG'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsShotgun(Weapon)
	local Weapons = {'WEAPON_BULLPUPSHOTGUN', 'WEAPON_ASSAULTSHOTGUN', 'WEAPON_DBSHOTGUN', 'WEAPON_PUMPSHOTGUN', 'WEAPON_HEAVYSHOTGUN', 'WEAPON_SAWNOFFSHOTGUN'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsSniper(Weapon)
	local Weapons = {'WEAPON_MARKSMANRIFLE', 'WEAPON_SNIPERRIFLE', 'WEAPON_HEAVYSNIPER', 'WEAPON_ASSAULTSNIPER', 'WEAPON_REMOTESNIPER'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsHeavy(Weapon)
	local Weapons = {'WEAPON_GRENADELAUNCHER', 'WEAPON_RPG', 'WEAPON_FLAREGUN', 'WEAPON_HOMINGLAUNCHER', 'WEAPON_FIREWORK', 'VEHICLE_WEAPON_TANK'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsMinigun(Weapon)
	local Weapons = {'WEAPON_MINIGUN'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsBomb(Weapon)
	local Weapons = {'WEAPON_GRENADE', 'WEAPON_PROXMINE', 'WEAPON_EXPLOSION', 'WEAPON_STICKYBOMB'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsVeh(Weapon)
	local Weapons = {'VEHICLE_WEAPON_ROTORS'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsVK(Weapon)
	local Weapons = {'WEAPON_RUN_OVER_BY_CAR', 'WEAPON_RAMMED_BY_CAR'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

