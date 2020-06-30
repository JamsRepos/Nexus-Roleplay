local hud = true
local wantsHolster = false
AddEventHandler('hud:status', function(status) hud = status end)




RegisterCommand("allowholster", function(source, args, rawCommand)
  if DecorGetBool(GetPlayerPed(-1), "isOfficer") then
   if wantsHolster then
    wantsHolster = false
    TriggerEvent('chatMessage', '^0Holster Disabled.')
   elseif not wantsHolster then
    wantsHolster = true
    TriggerEvent('chatMessage', '^0Holster Enabled.')
   end
  end
end)


Citizen.CreateThread(function()
  while true do
   local ped = PlayerPedId()
   local pos = GetEntityCoords(ped)
   Citizen.Wait(5)
   if hud then
    if IsPedInAnyVehicle(ped) then
     DisplayRadar(true) 
    else 
     DisplayRadar(false)
    end
   end
  end     
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(100)
    if IsPedDeadOrDying(GetPlayerPed(-1), true) then 
      SetEntityHealth(GetPlayerPed(-1), 0)
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

local nearObject = false 
local isNearObject = false
local objectLoc = {}
local clostestProp = nil
local label = "Donut"
local models = {
  [1] = 1421582485,
}

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(1500)
  nearObject = false
  isNearObject = false
  local myCoords = GetEntityCoords(GetPlayerPed(-1))
   
  for i = 1, #models do
   clostestProp = GetClosestObjectOfType(myCoords.x, myCoords.y, myCoords.z, 2.5, models[i], false, false)
   if clostestProp ~= nil and clostestProp ~= 0 then
    local coords = GetEntityCoords(clostestProp)
    isNearObject = true
    objectLoc = {['x'] = coords.x, ['y'] = coords.y, ['z'] = coords.z + 1.2}
    break
   end
  end
 end
end)

Citizen.CreateThread(function()
 while true do
  Wait(5)
  if isNearObject then 
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), objectLoc.x, objectLoc.y, objectLoc.z-0.5, true) < 1.3) then
    DrawText3Ds(objectLoc.x, objectLoc.y, objectLoc.z-0.20,'~g~[E]~w~ Buy Donut ~g~$6') 
	if IsControlJustPressed(0, 38) then
		TaskStartScenarioInPlace(GetPlayerPed(-1), 'PROP_HUMAN_ATM', false, true) Wait(3000) ClearPedTasksImmediately(GetPlayerPed(-1))
    TriggerServerEvent('shops:purchase', label, 6, 1, 260)
    end
   end ---- add shared banking to vending machines then somecan buy them
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

--============================================================
--====================== Vehicle HUD =========================
--============================================================

local speedLimiter = false
local setSpeed = 0
--[[
local vehicleSpeeds = {["lx570"] = 125,["r8lb"] = 245,["A45"] = 150, ["diablous2"] = 160,["mz3"] = 145,["sentinel"] = 135,["turismo2"] = 245,["bmwm4"] = 185, ["hh1"] = 110, ["luxor"] = 350,["gtrnismo"] = 200, ["1000rr"] = 270,["supra2"] = 180,["gt17"] = 230,["exor"] = 230,["str20"] = 200, ["s15rb"] = 180,["skylinekaira"] = 190,["mlmansory"] = 185,["nsexrb"] = 350,["MLEC"] = 168, ["civicek9rb"] = 155, ["tempesta2"] = 168, ["SCHWARZER2"] = 168,["sentinel6str2"] = 168,["zentenario"] = 245, ["MK7PANDEM"] = 154,["futo2"] = 155,["GTRLB"] = 215,["yRenault5TA"] = 154,["F60"] = 204,["NZP"] = 175,["rmodbmwi8"] = 209, ['schlagen'] = 155, ["rmodmi8"] = 205, ["180SXRB"] = 185, ["luxor2"] = 350, ["nimbus"] = 350, ["velum2"] = 350, ["shamal"] = 350, ["a40"] = 135, ["elegy2"] = 150, ['2015polstang'] = 210, ['370z'] = 145,['supra2'] = 180, ['suburban'] = 160, ['fbi'] = 180, ["bs17"] = 155, ["subwrx"] = 140, ["mers63s"] = 150, ["africat"] = 130, ["dm1200"] = 135, ["m3"] = 155, ["entity2"] = 140, ["vogue"] = 135, ["coquette3"] = 150, ["feltzer3"] = 150, ["guardian"] = 150, ["contender"] = 140, ["trophytruck2"] = 140, ["lurcher"] = 130, ["btype"] = 140, ["slamvan"] = 140, ["slamvan2"] = 140, ["slamvan3"] = 140, ["minivan2"] = 120, ["sultanrs"] = 150, ["nero2"] = 190, ["blista"] = 120, ["brioso"] = 120, ["dilettante"] = 120, ["issi2"] = 130, ["panto"] = 130, ["prairie"] = 120, ["rhapsody"] = 120, ["cogcabrio"] = 130, ["exemplar"] = 130, ["f620"] = 140, ["felon"] = 130, ["felon2"] = 140, ["jackal"] = 140, ["oracle"] = 130, ["oracle2"] = 140, ["sentinel"] = 130, ["sentinel2"] = 140, ["windsor"] = 130, ["windsor2"] = 140, ["zion"] = 130, ["zion2"] = 140, ["futo"] = 140, ["ninef"] = 150, ["ninef2"] = 165, ["alpha"] = 130, ["banshee"] = 150, ["bestiagts"] = 165, ["buffalo"] = 140, ["buffalo2"] = 140, ["carbonizzare"] = 140, ["comet2"] = 150, ["coquette"] = 150, ["feltzer2"] = 150, ["furoregt"] = 150, ["fusilade"] = 140, ["jester"] = 140, ["jester2"] = 150, ["lynx"] = 140, ["massacro"] = 140, ["massacro2"] = 150, ["omnis"] = 150, ["penumbra"] = 130, ["tampa2"] = 130, ["rapidgt"] = 140, ["rapidgt2"] = 140, ["schafter3"] = 130, ["sultan"] = 140, ["surano"] = 140, ["tropos"] = 140, ["verlierer2"] = 140, ["kuruma"] = 140, ["casco"] = 120, ["coquette2"] = 130, ["jb700"] = 130, ["pigalle"] = 120, ["stinger"] = 140, ["stingergt"] = 150, ["feltzer3"] = 150, ["ztype"] = 130, ["adder"] = 160, ["84rx7k"] = 150, ["banshee2"] = 150, ["bullet"] = 150, ["cheetah"] = 160, ["entityxf"] = 160, ["sheava"] = 150, ["fmj"] = 160, ["infernus"] = 140, ["osiris"] = 150, ["le7b"] = 150, ["reaper"] = 140, ["t20"] = 170, ["turismor"] = 170, ["tyrus"] = 170, ["vacca"] = 160, ["Voltic"] = 150, ["prototipo"] = 185, ["zentorno"] = 175, ["blade"] = 120, ["buccaneer"] = 120, ["chino"] = 120, ["coquette3"] = 140, ["dominator"] = 140, ["dukes"] = 130, ["gauntlet"] = 130, ["hotknife"] = 140, ["faction"] = 120, ["nightshade"] = 120, ["picador"] = 120, ["sabregt"] = 130, ["tampa"] = 120, ["virgo"] = 120, ["vigero"] = 130, ["bifta"] = 120, ["blazer"] = 120, ["brawler"] = 120, ["sadler"] = 120, ["dubsta3"] = 130, ["rebel"] = 120, ["sandking2"] = 130, ["sandking"] = 130, ["trophytruck"] = 140, ["baller"] = 130, ["cavalcade"] = 120, ["granger"] = 120, ["huntley"] = 120, ["landstalker"] = 120, ["radi"] = 120, ["rocoto"] = 120, ["seminole"] = 120, ["xls"] = 140, ["bison"] = 120, ["bobcatxl"] = 125, ["gburrito"] = 120, ["journey"] = 115, ["minivan"] = 120, ["paradise"] = 125, ["rumpo"] = 120, ["surfer"] = 125, ["youga"] = 125, ["asea"] = 120, ["fugitive"] = 120, ["asterope"] = 120, ["glendale"] = 120, ["ingot"] = 120, ["intruder"] = 120, ["premier"] = 130, ["primo"] = 120, ["primo2"] = 130, ["schafter2"] = 130, ["tailgater"] = 120, ["warrener"] = 120, ["washington"] = 130, ["surge"] = 130, ["superd"] = 130, ["stretch"] = 120, ["blazer"] = 120, ["faggio2"] = 120, ['gsxr'] = 165, ['cbrr'] = 160, ['cbb'] = 150, ['z10'] = 180, ['cb500x'] = 140, ["sanchez"] = 120, ["enduro"] = 130, ["akuma"] = 150, ["bagger"] = 130, ["bati"] = 150, ["bati2"] = 160, ["bf400"] = 120, ["carbonrs"] = 150, ["cliffhanger"] = 120, ["daemon"] = 120, ["double"] = 120, ["gargoyle"] = 95, ["hakuchou"] = 150, ["hexer"] = 120, ["diablous2"] = 150, ["blazer4"] = 150, ["blazer"] = 150, ["fbi2"] = 165, ["police"] = 165, ["policeb"] = 195, ["police2"] = 185, ["police3"] = 175, ["police4"] = 160, ["police5"] = 160, ["police6"] = 180, ["police7"] = 180, ["police8"] = 180, ["polaventa"] = 210, ["polmav"] = 310, ["emscar"] = 165, ["sheriff2"] = 175, ["emscar2"] = 185, ["emscar4"] = 185, ["cprotection"] = 185, ["emssuv2"] = 175, ["emssuv"] = 160, ["polmav"] = 255, ["ambulance"] = 155, ["ambulance2"] = 155, ["emscar3"] = 175, ["emschiron"] = 210, ["supervolito"] = 310, ["annihilator"] = 310, ["tezeract"] = 210, ["raiden"] = 155, ["rmodx6"] = 190,["demonhawk"] = 185, ["cyclone"] = 155, ["visione"] = 145, ["vortex"] = 100, ["teslax"] = 145, ["c63s"] = 150, ["police32"] = 180, ["s65"] = 160, ['ap2'] = 140, ['a45'] = 150, ["f82"] = 185, ["v242"] = 250, ['m3tp'] = 150, ['m5e60'] = 155, ['mxrb'] = 200, ['s15rb'] = 200, ['FD'] = 190, ['brzrbv3'] = 200, ['180sxrb'] = 180, ['2016rs7'] = 200, ['laferrari'] = 280, ['hemi'] = 240, ['rx7twerk'] = 160, ['CLA45SB2'] = 165, ['lp770cop'] = 290, ['mk6pol'] = 290, ['CLA45POL'] = 230, ['challengerrt'] = 160, ['rmodm4gts'] = 260, ['DEMON'] = 210, ['BMWS'] = 150,['AUDIRS6TK'] = 165,['s15mak'] = 185, ['HS'] = 220, ['SENTINELC'] = 220, ['pd458wb'] = 220, ['pitbike'] = 60, ['rmodamgc63'] = 245,['911rwb'] = 265 }
--]]
DecorRegister('Seatbelt', 2)
DecorSetBool(PlayerPedId(), 'Seatbelt', false)
--[[
function getMaxSpeed(vehicle)
  local vehicle = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
  local veh = string.lower(vehicle)
  return vehicleSpeeds[veh]
end
--]]

local fuelcooldowntimer = 60

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
    if fuelcooldowntimer > 0 then
      fuelcooldowntimer = fuelcooldowntimer - 1
      if fuelcooldowntimer == 1 then
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped) then
          local vehicle = GetVehiclePedIsIn(ped, false)
          local fuelcount = DecorGetInt(vehicle, "_Fuel_Level")
          fuelcooldowntimer = 60
          if fuelcount <= 25000 then
            TriggerEvent('NRP-notify:client:SendAlert', { type = 'error', text = "Low Fuel!", length = 5000})
            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 1.0, 'fuel', 0.5)
          end
        end
      end
    end
  end
end)

Citizen.CreateThread(function()
 while true do
  local ped = PlayerPedId()  
  local vehicle = GetVehiclePedIsIn(ped, false)
  local speed = math.floor(GetEntitySpeed(vehicle) * 2.236936)
  Citizen.Wait(5)
  if hud then
   if IsPedInAnyVehicle(ped) then
    -- Speed & Fuel
    local currentfuel = DecorGetInt(vehicle, "_Fuel_Level") * 0.001
    local currentfuelraw = DecorGetInt(vehicle, "_Fuel_Level")
    --drawUI(0.517, 1.302, 1.0, 1.0, 0.4, "MPH", 255, 255, 255, 255, false)
    if currentfuelraw >= 75000 then
      drawUI(0.985, 1.475, 1.0, 1.0, 0.3,"~g~FUEL "..round(currentfuel,1).."%", 255, 255, 255, 255, 0, 1)
    elseif currentfuelraw <= 75000 and currentfuelraw >= 50000 then
      drawUI(0.985, 1.475, 1.0, 1.0, 0.3,"~y~FUEL "..round(currentfuel,1).."%", 255, 255, 255, 255, 0, 1)
    elseif currentfuelraw <= 50000 and currentfuelraw >= 25000 then
      drawUI(0.985, 1.475, 1.0, 1.0, 0.3,"~o~FUEL "..round(currentfuel,1).."%", 255, 255, 255, 255, 0, 1)
    elseif currentfuelraw <= 25000 then
      drawUI(0.985, 1.475, 1.0, 1.0, 0.3,"~r~FUEL "..round(currentfuel,1).."%", 255, 255, 255, 255, 0, 1)
    end
    --drawUI(0.517, 1.302, 1.0, 1.0, 0.4, "~g~MPH:~w~", 255, 255, 255, 255, false)
    -- Cruise
    if speedLimiter then
      drawUI(1.032, 1.475, 1.0, 1.0, 0.3, "~g~LIMITER", 255, 255, 255, 255, false)
    else
      drawUI(1.032, 1.475, 1.0, 1.0, 0.3, "~r~LIMITER", 255, 255, 255, 255, false)
    end
    -- Seatbelt Display
    local class = GetVehicleClass(vehicle)
    if (class >= 0 and class <= 7) or (class >= 9 and class <= 12) or (class >= 17 and class <= 20) then
	 if DecorGetBool(ped, 'Seatbelt') then
    drawUI(0.950, 1.475, 1.0, 1.0, 0.3, "~g~BELT", 255, 255, 255, 255, false)
  else
    drawUI(0.950, 1.475, 1.0, 1.0, 0.3, "~r~BELT", 255, 255, 255, 255, false)
	 end
    end

    if GetPedInVehicleSeat(vehicle, -1) == ped and IsPedInAnyVehicle(ped, false) then
     if IsControlJustPressed(1, 244) and not IsVehicleModel(GetVehiclePedIsIn(ped, false), GetHashKey("BMX")) and not IsVehicleModel(GetVehiclePedIsIn(ped, false), GetHashKey("Cruiser")) and not IsVehicleModel(GetVehiclePedIsIn(ped, false), GetHashKey("Scorcher")) and not IsVehicleModel(GetVehiclePedIsIn(ped, false), GetHashKey("Fixter")) then
      if speedLimiter == false then setSpeed = GetEntitySpeed(vehicle) speedLimiter = true else speedLimiter = false end
     end
    end
   end
  end
 end
end)

function round(num, dec)
  local mult = 10^(dec or 0)
  return math.floor(num * mult + 0.5) / mult
end


Citizen.CreateThread(function()
 while true do
  Citizen.Wait(350)
  if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
   local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
   	local match = false
   if not speedLimiter then
    maxSpeed = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel")
    SetEntityMaxSpeed(vehicle, maxSpeed)
   else 
    SetEntityMaxSpeed(vehicle, setSpeed)
   end
  end
 end
end)

--============================================================
--====================== VOIP System =========================
--============================================================
local money = 0

RegisterNetEvent('hud:money')
AddEventHandler('hud:money', function(data)
 money = data
end)
--============================================================
--====================== ID Above Head =======================
--============================================================
local enableids = true
local enablemarkers = true

Citizen.CreateThread(function()
 AddTextEntry('FE_THDR_GTAO', 'Nexus Roleplay')
 while true do
  Citizen.Wait(1)
  if hud then
   for i=0,99 do N_0x31698aa80e0223f8(i) end
   for id = 0, 255 do
    if (NetworkIsPlayerActive(id)) then
     ped = GetPlayerPed(id)
     x1, y1, z1 = table.unpack(GetEntityCoords(GetPlayerPed( -1 ), true ))
     x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed( id ), true ))
     distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))
     local phone = DecorGetFloat(ped, 'Phone')
     local loggingOut = DecorGetBool(ped, 'isLoggingOut')

     if ((distance < 30)) and IsEntityVisible(ped) and HasEntityClearLosToEntity(PlayerPedId(), ped, 17) and enableids then
      if loggingOut == 1 then 
       DrawText3D(x2, y2, z2+1.2, 'Logging Out', false)
      else
       if NetworkIsPlayerTalking(id) then
        DrawText3D(x2, y2, z2+1.2, GetPlayerServerId(id), true)
       else
        DrawText3D(x2, y2, z2+1.2, GetPlayerServerId(id), false)
       end
      end
     end
         --VO-IP MARKER UNDER TALKING PLAYER
     if enablemarkers and ((distance < 30)) and IsEntityVisible(ped) and not enableids then
      if NetworkIsPlayerTalking(id) then
        DrawText3D(x2, y2, z2+1.2, "...", true)
      end
     end
    end
   end
  end
 end
end)

function DrawText3D(x,y,z, text, talking)
 local onScreen,_x,_y=World3dToScreen2d(x,y,z)
 local px,py,pz=table.unpack(GetGameplayCamCoords())
 local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 local scale = (2/dist)*2
 local fov = (1/GetGameplayCamFov())*100
 local scale = scale*fov
 if onScreen then
  SetTextScale(0.0*scale, 0.55*scale)
  SetTextFont(4)
  SetTextProportional(0)
  if talking then SetTextColour(50, 200, 50, 255) else SetTextColour(255, 255, 255, 255) end
  SetTextDropshadow(0, 0, 0, 0, 255)
  SetTextEdge(2, 0, 0, 0, 150)
  SetTextDropShadow()
  SetTextOutline()
  SetTextEntry("STRING")
  SetTextCentre(1)
  AddTextComponentString(text)
  DrawText(_x,_y)
 end
end


--========================================================================================--
--==================================== Seat Belt =========================================--
--========================================================================================--
local speedBuffer  = {}
local velBuffer    = {}
local wasInCar     = false
local carspeed = 0

Citizen.CreateThread(function()
 Citizen.Wait(500)
  while true do
   local ped = GetPlayerPed(-1)
   local car = GetVehiclePedIsIn(ped) 
   if car ~= 0 and (wasInCar or IsCar(car)) then
    wasInCar = true
    speedBuffer[2] = speedBuffer[1]
    speedBuffer[1] = GetEntitySpeed(car) 
    if speedBuffer[2] ~= nil and GetEntitySpeedVector(car, true).y > 1.0 and speedBuffer[2] > 18.00 and (speedBuffer[2] - speedBuffer[1]) > (speedBuffer[2] * 0.465) and DecorGetBool(GetPlayerPed(-1), 'Seatbelt') == false then
    local co = GetEntityCoords(ped)
    local fw = Fwv(ped)
    SetEntityCoords(ped, co.x + fw.x, co.y + fw.y, co.z - 0.47, true, true, true)
    SetEntityVelocity(ped, velBuffer[2].x-10/2, velBuffer[2].y-10/2, velBuffer[2].z-10/4)
    Citizen.Wait(1)
    SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
   end    
    velBuffer[2] = velBuffer[1]
    velBuffer[1] = GetEntityVelocity(car)    
 

    if IsControlJustPressed(0, 29) and speed < 60 then 
     if DecorGetBool(GetPlayerPed(-1), 'Seatbelt') == false then
      TriggerEvent("mythic_progbar:client:progress", {
         name = "seatbelt",
         duration = 2500,
         label = "Buckling Seatbelt",
         useWhileDead = false,
         canCancel = false,
         controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
         },
       }, function(status)
        if not status then
          DecorSetBool(GetPlayerPed(-1), 'Seatbelt', true)
          
          end
       end)
    else
      TriggerEvent("mythic_progbar:client:progress", {
         name = "seatbelt",
         duration = 1500,
         label = "Unbuckling Seatbelt",
         useWhileDead = false,
         canCancel = false,
         controlDisables = {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
         },
       }, function(status)
        if not status then
          DecorSetBool(GetPlayerPed(-1), 'Seatbelt', false)
          end
       end)   
     end 
    end
   elseif wasInCar then
    wasInCar = false
    DecorSetBool(GetPlayerPed(-1), 'Seatbelt', false)
    speedBuffer[1], speedBuffer[2] = 0.0, 0.0
   end
   Citizen.Wait(5)
   speed = math.floor(GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1))) * 2.236936)
  end
end)

function IsCar(veh)
 local vc = GetVehicleClass(veh)
 return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)
end 

function Fwv(entity)
 local hr = GetEntityHeading(entity) + 90.0
 if hr < 0.0 then hr = 360.0 + hr end
 hr = hr * 0.0174533
 return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
end

--========================================================================================--
--================================== Progress Bar ========================================--
--========================================================================================--
local progress_time = 0.20
local progress_bar = false
local progress_bar_duration = 20
local progress_bar_text = ''

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(progress_bar_duration)
  if(progress_time > 0)then
   progress_time = progress_time - 0.002
  end
 end
end)

function ProgressBar(text, time)
 progress_bar_text = text
 progress_bar_duration = time
 progress_time = 0.20
 progress_bar = true
 while progress_bar do
  Citizen.Wait(0)
  DrawRect(0.50, 0.90, 0.20, 0.05, 0, 0, 0, 100)
  drawUI(0.910, 1.375, 1.0, 1.0, 0.55, progress_bar_text,135, 135, 135, 255, false)
  if progress_time > 0 then
   DrawRect(0.50, 0.90, 0.20-progress_time, 0.05, 255, 255, 0, 225)
  elseif progress_time < 1 and progress_bar then 
   progress_bar = false
   return true
  end
 end
end



local players = {}
local cops = 'Weak'
local ems = 'Unavailable'
local mechanic = 'Unavailable'
local qCount = 0

RegisterCommand("mechanic", function(source, rawCommand)   -- Modify the "mechanic" value to change activation command.
  if mechanic == 'Unavailable' then
    if IsPedInAnyVehicle(GetPlayerPed(-1), false) then  
     TriggerServerEvent("mechanic:repair")
     TriggerEvent("knb:mech")
    else
      exports['NRP-notify']:DoHudText('error', 'You need to be in a Vehicle to use this service!') 
   end
  else 
    exports['NRP-notify']:DoHudText('error', 'There is a civilian mechanic awake, call them from your favourites!') 
  end	
end, false)

RegisterCommand("tow", function(source,rawCommand)												--Change "tow" value to change activation command.
  if mechanic == 'Unavailable' then
    if IsPedInAnyVehicle(GetPlayerPed(-1), false) then  
     TriggerServerEvent("mechanic:repair")
     TriggerEvent("knb:tow")
    else
      exports['NRP-notify']:DoHudText('error', 'You need to be in a Vehicle to use this service!') 
   end
  else 
     exports['NRP-notify']:DoHudText('error', 'There is a civilian mechanic awake, call them from your favourites!') 
  end	
end, false)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        if DecorGetBool(GetPlayerPed(-1), 'Seatbelt') then
         DisableControlAction(0, 75, true) -- INPUT_VEH_ATTACK
        end
    end
end)

Citizen.CreateThread(function()
  WarMenu.CreateLongMenu('player_list', "Players")
  WarMenu.CreateSubMenu('player_list2', "player_list", 'player_list2')
  while true do
   Wait(5)
   if WarMenu.IsMenuOpened('player_list') then
    enableids = true 
    if WarMenu.Button('Player ID ', GetPlayerServerId(PlayerId())) then
    elseif WarMenu.Button('Police', cops) then
    elseif WarMenu.Button("Mechanic ", mechanic) then
    elseif WarMenu.Button('EMS', ems) then  
    elseif WarMenu.Button('Player Count', #players..'/40') then
      WarMenu.OpenMenu('player_list2')  
    end
    if qCount > 0 then
     if WarMenu.Button('Queued:', qCount) then
     end
    end
    WarMenu.Display()
   elseif WarMenu.IsMenuOpened('player_list2') then
     enableids = true 
    for i = 0, 255 do
     if NetworkIsPlayerActive( i ) then
      if WarMenu.Button(GetPlayerName(i), GetPlayerServerId(i)) then
      end
     end
    end
    WarMenu.Display()
   elseif enableids then
    enableids = false
   end
   if IsControlJustPressed(0, 303) then
    if not WarMenu.IsMenuOpened('player_list') then
     players = {} 
     WarMenu.OpenMenu('player_list')
     ExecuteCommand('me is looking into your soul')
     for i = 0, 255 do
      if NetworkIsPlayerActive( i ) then
       table.insert( players, i )
      end
     end
    else
      WarMenu.CloseMenu('player_list')
    end
   end
  end
 end)

--[[Citizen.CreateThread(function(copss) ---- updates like every 7 Mins
  while true do 
    Citizen.Wait(1)
    if cops == 'Weak' then 
     TriggerEvent('chatMessage', "ANNOUNCEMENT", {255, 0, 0}, "Police is Level Weak No Player Vs Player Crime is to be Commited")
     Wait(1000000)
    end 
   end
end)
]]--

RegisterNetEvent('hud:updatepresence')
AddEventHandler('hud:updatepresence', function(copss, emss, mechc)
 if copss == 0 then
  cops = 'Unavailable'
 elseif copss > 0 then
  cops = copss
 end
 if emss == 0 then
  ems = 'Unavailable'
 elseif emss > 0 then
  ems = emss
 end
 if mechc == 0 then
  mechanic = 'Unavailable'
 elseif mechc > 0 then 
  mechanic = mechc
 end
end)

RegisterNetEvent('debug:queueCount')
AddEventHandler('debug:queueCount', function(count)
 qCount = count
end)

function ToggleMarkers()
  if enablemarkers then
    enablemarkers = false
    exports['NRP-notify']:DoHudText('inform', 'Player Markers Have Now Been Disabled')
  else
    enablemarkers = true
    exports['NRP-notify']:DoHudText('inform', 'Player Markers Have Now Been Enabled"')
  end
end


local holstered = true
local holsteranim = false
local weapon = nil
local pdweapon = nil

local weapons = {
  "WEAPON_PISTOL",
  "WEAPON_SNSPISTOL",
  "WEAPON_COMBATPISTOL",
  "WEAPON_PISTOL50",
  "WEAPON_APPISTOL",
  "WEAPON_MICROSMG",
  "WEAPON_ASSAULTSMG",
  "WEAPON_ASSAULTRIFLE",
  "WEAPON_MG",
  "WEAPON_MACHINEPISTOL",
  "WEAPON_ADVANCEDRIFLE",
  "WEAPON_HEAVYPISTOL",
  "WEAPON_PUMPSHOTGUN",
  "WEAPON_SNIPERRIFLE",
  "WEAPON_SMG",
  "WEAPON_CARBONRIFLE",
  "WEAPON_STUNGUN",
  "WEAPON_KNIFE",
  "WEAPON_BAT",
  "WEAPON_NIGHTSTICK",
  "WEAPON_TORCH"
}

local pdweapons = {
  "WEAPON_HEAVYPISTOL",
  "WEAPON_STUNGUN",
  "WEAPON_COMBATPISTOL",
  "WEAPON_REVOLVER",
  "WEAPON_PISTOL",
  "WEAPON_PISTOL50",
}

Citizen.CreateThread(function()
  while true do
    local ped = PlayerPedId()
    Citizen.Wait(10)
    if not IsPedInAnyVehicle(ped, true) then
      loadAnimDict( "reaction@intimidation@1h" )
      loadAnimDict( "rcmjosh4" )
			loadAnimDict( "weapons@pistol@" )
      if CheckWeapon(ped) then
        if holstered then
         if DecorGetBool(GetPlayerPed(-1), "isOfficer") and CheckPDWeapon(ped) then
          holsteranim = true 
          SetCurrentPedWeapon(GetPlayerPed(-1), -1569615261, true)
          TaskPlayAnim(ped, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
          Citizen.Wait(150)
          if wantsHolster or DecorGetInt(GetPlayerPed(-1), "Job") == 29 then 
           SetPedComponentVariation(ped, 7, 2, 0, 0)
          end
          SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey(weapon), true)
          Wait(600)
          ClearPedTasks(ped)
          holstered = false
          holsteranim = false
         else
          holsteranim = true 
          SetCurrentPedWeapon(GetPlayerPed(-1), -1569615261, true)
          TaskPlayAnim(ped, "reaction@intimidation@1h", "intro", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
          Citizen.Wait(2000)
          SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey(weapon), true)
          ClearPedTasks(ped)
          holstered = false
          holsteranim = false
         end
        end
      elseif not CheckWeapon(ped) then
        if not holstered then
           holsteranim = true 
            TaskPlayAnim(ped, "reaction@intimidation@1h", "outro", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
            Citizen.Wait(2000)
            if DecorGetBool(GetPlayerPed(-1), "isOfficer") and wantsHolster then
              SetPedComponentVariation(ped, 7, 8, 0, 0)
            end
            SetCurrentPedWeapon(GetPlayerPed(-1), -1569615261, true)
            ClearPedTasks(ped)
            holstered = true
            holsteranim = false 
        end
      end
    end
  end
end)

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
  if holsteranim then
   DisableControlAction(0, 69, true) -- INPUT_VEH_ATTACK
   DisableControlAction(0, 92, true) -- INPUT_VEH_PASSENGER_ATTACK
   DisableControlAction(0, 114, true) -- INPUT_VEH_FLY_ATTACK
   DisableControlAction(0, 140, true) -- INPUT_MELEE_ATTACK_LIGHT
   DisableControlAction(0, 141, true) -- INPUT_MELEE_ATTACK_HEAVY
   DisableControlAction(0, 142, true) -- INPUT_MELEE_ATTACK_ALTERNATE
   DisableControlAction(0, 257, true) -- INPUT_ATTACK2
   DisableControlAction(0, 263, true) -- INPUT_MELEE_ATTACK1
   DisableControlAction(0, 264, true) -- INPUT_MELEE_ATTACK2
   DisableControlAction(0, 24, true) -- INPUT_ATTACK
   DisableControlAction(0, 25, true) -- INPUT_AIM
   DisableControlAction(0, 23, true) -- INPUT_ENTER
   DisableControlAction(0, 75, true) -- INPUT_VEH_EXIT
  end
 end
end)

function CheckWeapon(ped)
  for i = 1, #weapons do
    if GetHashKey(weapons[i]) == GetSelectedPedWeapon(ped) then
      weapon = weapons[i]
      return true
    end
  end
  return false
end

function CheckPDWeapon(ped)
  for i = 1, #pdweapons do
    if GetHashKey(pdweapons[i]) == GetSelectedPedWeapon(ped) then
      pdweapon = pdweapons[i]
      return true
    end
  end
  return false
end

function loadAnimDict( dict )
  while ( not HasAnimDictLoaded( dict ) ) do
    RequestAnimDict( dict )
    Citizen.Wait( 0 )
  end
end

Citizen.CreateThread( function()
 while true do 
  local ped = GetPlayerPed(-1)
  Citizen.Wait(4500)
  if IsPedInAnyVehicle(ped) then
   local vehicle = GetVehiclePedIsIn(ped, false)
   if GetVehicleEngineHealth(vehicle) < 275 then 
    if math.random(1,50) > 20 then 
     SetVehicleUndriveable(vehicle, true)
     PlaySoundFrontend(-1, "CHECKPOINT_MISSED", 'HUD_MINI_GAME_SOUNDSET', 1)
     SetVehicleDoorShut(vehicle, 4, false)
    end
   end
  end
 end
end)

--[[Citizen.CreateThread(function()
 local loaded = true
 while true do
  Citizen.Wait(0)
  if IsNextWeatherType('XMAS') then 
   N_0xc54a08c85ae4d410(3.0)            
   SetForceVehicleTrails(true)
   SetForcePedFootstepsTracks(true)
   if not loaded then
    RequestScriptAudioBank("ICE_FOOTSTEPS", false)
    RequestScriptAudioBank("SNOW_FOOTSTEPS", false)
    RequestNamedPtfxAsset("core_snow")
    while not HasNamedPtfxAssetLoaded("core_snow") do
     Citizen.Wait(0)
    end
    UseParticleFxAssetNextCall("core_snow")
    loaded = true
   end
   RequestAnimDict('anim@mp_snowball')
   if IsControlJustReleased(0, 74) and not IsPedInAnyVehicle(GetPlayerPed(-1), true) and not IsPlayerFreeAiming(PlayerId()) and not IsPedSwimming(PlayerPedId()) and not IsPedSwimmingUnderWater(PlayerPedId()) and not IsPedRagdoll(PlayerPedId()) and not IsPedFalling(PlayerPedId()) and not IsPedRunning(PlayerPedId()) and not IsPedSprinting(PlayerPedId()) and GetInteriorFromEntity(PlayerPedId()) == 0 and not IsPedShooting(PlayerPedId()) and not IsPedUsingAnyScenario(PlayerPedId()) and not IsPedInCover(PlayerPedId(), 0) then
    TaskPlayAnim(PlayerPedId(), 'anim@mp_snowball', 'pickup_snowball', 8.0, -1, -1, 0, 1, 0, 0, 0) 
    Citizen.Wait(1950) 
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey('WEAPON_SNOWBALL'), 4, false, true)
   end 
  else
   if loaded then N_0xc54a08c85ae4d410(0.0) end
   loaded = false
   RemoveNamedPtfxAsset("core_snow")
   ReleaseNamedScriptAudioBank("ICE_FOOTSTEPS")
   ReleaseNamedScriptAudioBank("SNOW_FOOTSTEPS")
   SetForceVehicleTrails(false)
   SetForcePedFootstepsTracks(false)
  end
  if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_SNOWBALL') or GetSelectedPedWeapon(PlayerPedId()) == GetHashKey('WEAPON_KNUCKLE') then
   SetPlayerWeaponDamageModifier(PlayerId(), 0.0)
  end
 end
end)]]--