local cooldowntimer = 0

local locations = {
 {garage = {x=-35.001, y=-1101.657, z=26.422}, spawn = {x=-46.677, y=-1110.872, z=26.436, heading=70.008}, preview = {x=-32.89, y=-1090.53, z=26.42, heading=69.23}},
 --{garage = {x=1224.850, y=2727.356, z=38.004}, spawn = {x=1230.095, y=2717.908, z=37.502, heading=131.941}, preview = {x=1218.155, y=2717.167, z=37.501, heading=204.264}}
}

local maxCapacity = {
  [0] = {["item"] = 20, ["weapons"] = 1}, --Compact
  [1] = {["item"] = 30, ["weapons"] = 2}, --Sedan
  [2] = {["item"] = 50, ["weapons"] = 3}, --SUV
  [3] = {["item"] = 30, ["weapons"] = 2}, --Coupes
  [4] = {["item"] = 25, ["weapons"] = 1}, --Muscle
  [5] = {["item"] = 20, ["weapons"] = 1}, --Sports Classics
  [6] = {["item"] = 20, ["weapons"] = 1}, --Sports
  [7] = {["item"] = 15, ["weapons"] = 1}, --Super
  [8] = {["item"] = 5, ["weapons"] = 1}, --Motorcycles
  [9] = {["item"] = 40, ["weapons"] = 1}, --Off-road
  [10] = {["item"] = 100, ["weapons"] = 8}, --Industrial
  [11] = {["item"] = 25, ["weapons"] = 1}, --Utility
  [12] = {["item"] = 75, ["weapons"] = 4}, --Vans
  [14] = {["item"] = 0, ["weapons"] = 1}, --Boats
  [15] = {["item"] = 0, ["weapons"] = 1}, --Helicopters
  [16] = {["item"] = 0, ["weapons"] = 1}, --Planes
  [17] = {["item"] = 40, ["weapons"] = 1}, --Service
  [18] = {["item"] = 40, ["weapons"] = 2}, --Emergency
  [20] = {["item"] = 100, ["weapons"] = 5}, --Commercial
}
local menuOpen = false
local garage = {}
local menu = nil
local demo = { car = nil, model = nil, price = 0 }
local buyconfirmation = false
local sellconfirmation = false

Citizen.CreateThread(function()
 for _, v in pairs(locations) do
  local blip = AddBlipForCoord(v.garage.x, v.garage.y, v.garage.z)
  SetBlipSprite(blip, 326)
  SetBlipDisplay(blip, 4)
  SetBlipScale(blip, 0.8)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString("Vehicle Shop")
  EndTextCommandSetBlipName(blip)
 end
 while true do
  Wait(5)
  for _, info in pairs(locations) do
   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), info.garage.x, info.garage.y, info.garage.z, true) < 25 and menuOpen == false then
    DrawMarker(27, info.garage.x, info.garage.y, info.garage.z-0.98, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5, 255,255,0,200,0,0,0,0)
    --DrawMarker(25, info.garage.x, info.garage.y, info.garage.z-0.98, 0.5, 0, 0, 0, 0.0, 0, 1.75, 1.75, 0.75, 62, 60, 255, 225, false, false, 0, 0)
    if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), info.garage.x, info.garage.y, info.garage.z, true) < 1.2 then
      DrawText3Ds(info.garage.x, info.garage.y, info.garage.z,"~g~[E]~w~ Vehicle Store")
     if IsControlPressed(0, 38) then
      garage = info
      menuOpen = true
      menu = nil
      currentOption = 1
     end
    end
   end
  end 
  if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -45.357, -1082.406, 26.207, true) < 25 then
    DrawMarker(27, -45.357, -1082.406, 25.807, 0, 0, 0, 0, 0, 0, 2.5, 2.5, 0.5, 255,255,0,200,0,0,0,0)
   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -45.357, -1082.406, 26.207, true) < 2.5 then
    if sellconfirmation then
      DrawText3Ds(-45.357, -1082.406, 26.207,'~g~[E]~w~ Press again to confirm.')
    else
      DrawText3Ds(-45.357, -1082.406, 26.207,'~g~[E]~w~ Sell Vehicle For 50% Of The Purchase Price')
    end
    if IsControlJustPressed(0, 38) and sellconfirmation then
      local plate = exports['core']:TrimPlate(GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false)))
      TriggerServerEvent('carshop:sell', plate)
      sellconfirmation = false
    elseif IsControlJustPressed(0, 38) and not sellconfirmation then
      sellconfirmation = true
    end
   else
    sellconfirmation = false
   end
  end
 end
end)

function disp_time(time)
  local minutes = math.floor((time%3600)/60)
  local seconds = math.floor((time%60))
  return string.format("~g~%02d~w~m ~g~%02d~w~s", minutes, seconds)
end

function startTimer(timer)
  Citizen.CreateThread(function()
      Citizen.CreateThread(function()
          while timer>0 do
              Citizen.Wait(1000)
              timer=timer-1
          end
      end)
      while timer>0 do
          Citizen.Wait(0)
          SetTextFont(4)
          SetTextScale(0.45, 0.45)
          SetTextColour(255, 255, 255, 255)
          SetTextDropshadow(0, 0, 0, 0, 255)
          SetTextEdge(1, 0, 0, 0, 255)
          SetTextDropShadow()
          SetTextOutline()
          BeginTextCommandDisplayText('STRING')
          AddTextComponentSubstringPlayerName("Time Left on Test Drive: "..disp_time(timer))
          EndTextCommandDisplayText(0.05, 0.55)
      end
  end)
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
    if cooldowntimer > 0 then
      cooldowntimer = cooldowntimer - 1
      if cooldowntimer == 1 then
      end
    end
  end
end)

Citizen.CreateThread(function()
 while true do
  Wait(0)
  if menuOpen then
   local ped = GetPlayerPed(-1)
   for _, player in ipairs(GetActivePlayers()) do
    if player ~= PlayerId() then
     local otherPlayerPed = GetPlayerPed(player)
     SetEntityLocallyInvisible(otherPlayerPed)
     SetEntityNoCollisionEntity(ped, otherPlayerPed, true)
    end
   end
   if menu == nil then
    Menu.Title("Vehicle Shop")
    spawnMenu("Compacts")
    spawnMenu("Coupes")
    spawnMenu("Motorcycles")
    spawnMenu("Motorcycles Continued")
    spawnMenu("Muscle")
    spawnMenu("Off-Road")
    spawnMenu("SUVs")
    spawnMenu("Sedans")
    spawnMenu("Sports")
    spawnMenu("Sports Continued")
    spawnMenu("Sports Classic")
    spawnMenu("Super")
    spawnMenu("Super Continued")
    spawnMenu("Vans")

    Menu.updateSelection()
    if IsControlJustPressed(0, 202) then 
     menuOpen = false
     buyconfirmation = false
    end

   else
    if type(vehicles[menu]) == "table" then
     Menu.Title(menu)
     for _, v in pairs(vehicles[menu]) do
      local price = v.price
      spawnCar(v.name, v.model, price)
     end
     Menu.updateSelection()
     if IsControlJustPressed(0, 202) then
      menu = nil
      if demo.car ~= nil then
       SetEntityCoords(GetPlayerPed(-1), garage.garage.x, garage.garage.y, garage.garage.z-0.95)
       DeleteVehicle(demo.car)
      end
     end
     if IsControlJustReleased(0, 246) then
      if cooldowntimer <= 0 then
          RequestModel(demo.model)
          while not HasModelLoaded(demo.model) do
          Citizen.Wait(10)
          end
          local vehicle = CreateVehicle(demo.model, -9.28, -1082.86, 26.7-0.85, 99.49, true, true)
          SetVehicleNumberPlateText(vehicle, "DEALER")
          DecorSetInt(vehicle, "_Fuel_Level", 100000)
          TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
          exports["onyxLocksystem"]:givePlayerKeys(GetVehicleNumberPlateText(vehicle))
          startTimer(120)
          Wait(120*1000)
          DoScreenFadeOut(500)
          Wait(500)
          DoScreenFadeIn(500)
          cooldowntimer = 120
          DeleteEntity(vehicle)
          SetPedIntoVehicle(GetPlayerPed(-1), demo.car, -1)
        else
          exports['NRP-notify']:DoHudText('error', 'Please wait '..cooldowntimer..' seconds before test driving another vehicle')
        end

      end
     if DoesEntityExist(demo.car) then
      --local speed = exports['hud']:getMaxSpeed(demo.car) or 150
      local items = 80 
      local guns = 1 
      local insurance = math.floor(demo.price/10)
      if maxCapacity[GetVehicleClass(demo.car)] ~= nil then 
       items = maxCapacity[GetVehicleClass(demo.car)].item 
      end
      DrawRect(0.090, 0.59, 0.145, 0.11, 40, 40, 40, 200)
      drawUI(0.524, 1.042, 1.0, 1.0, 0.475, "~g~Price: ~w~$"..demo.price, 255, 255, 255, 255, false)
      drawUI(0.524, 1.072, 1.0, 1.0, 0.475, "~g~Max Items: ~w~"..items.." Items", 255, 255, 255, 255, false)
      drawUI(0.524, 1.102, 1.0, 1.0, 0.475, "~w~Press ~g~[Y] ~w~to test drive", 255, 255, 255, 255, false)
     end
    end
   end
  end
 end
end)


function spawnMenu(option)
 if Menu.Option(option, true) then
  menu = option
  if demo.car ~= nil then
   SetEntityCoords(GetPlayerPed(-1), garage.garage.x, garage.garage.y, garage.garage.z)
   DeleteVehicle(demo.car)
   SetEntityAsNoLongerNeeded(demo.car)
   SetModelAsNoLongerNeeded(GetHashKey(demo.car))
  end
  currentOption = 1
 end
end

function spawnCar(option, model, price)
 if vehicles[menu][currentOption] ~= nil and demo.model ~= vehicles[menu][currentOption].model then
  buyconfirmation = false
  DeleteVehicle(demo.car)
  SetEntityAsNoLongerNeeded(demo.car)
  SetModelAsNoLongerNeeded(GetHashKey(demo.car))

  demo.model = vehicles[menu][currentOption].model
  demo.price = math.floor(vehicles[menu][currentOption].price)
  RequestModel(GetHashKey(demo.model))
  while not HasModelLoaded(GetHashKey(demo.model)) do
   RequestModel(GetHashKey(demo.model))
   Wait(1)
  end
  demo.car = CreateVehicle(GetHashKey(demo.model), garage.preview.x, garage.preview.y, garage.preview.z, garage.preview.heading, false, false)
  SetVehicleOnGroundProperly(demo.car)
  SetVehicleEngineOn(demo.car, false)
  SetPedIntoVehicle(GetPlayerPed(-1), demo.car, -1)
  FreezeEntityPosition(demo.car, true)
  exports["onyxLocksystem"]:givePlayerKeys(GetVehicleNumberPlateText(demo.car))
 end


 local vehicleProps = GetVehProps(GetVehiclePedIsIn(GetPlayerPed(-1), false))
 local model = GetDisplayNameFromVehicleModel(vehicleProps.model)

  if Menu.OptionData(option, tostring(price)) then
    if buyconfirmation then
      menuOpen = false
      buyconfirmation = false
      Wait(100)
      local vehicleProps = GetVehProps(GetVehiclePedIsIn(GetPlayerPed(-1), false))
      local model = GetDisplayNameFromVehicleModel(vehicleProps.model)
      DeleteVehicle(demo.car)
      TriggerServerEvent('carshop:buy', vehicleProps, demo.price, model, menu, currentOption)
    else
      TriggerEvent('NRP-notify:client:SendAlert', { type = 'inform', text = "Press Enter again to confirm your purchase.", timeout=5000})
      buyconfirmation = true
    end
  end
end

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

RegisterNetEvent("carshop:bought")
AddEventHandler("carshop:bought",function(data, plate)
 FreezeEntityPosition(GetPlayerPed(-1),false)
 SetEntityVisible(GetPlayerPed(-1),true)
 RequestModel(data.model)
 while not HasModelLoaded(data.model) do
 Citizen.Wait(0)
 end
 spawned = CreateVehicle(data.model, garage.spawn.x, garage.spawn.y, garage.spawn.z, garage.spawn.heading, true, false)
 SetVehicleProperties(spawned, data)
 SetVehicleNumberPlateText(spawned, plate)
 SetEntityAsMissionEntity(spawned, true, true)
 SetVehicleIsConsideredByPlayer(spawned, true)
 TaskWarpPedIntoVehicle(GetPlayerPed(-1), spawned, -1)
 exports["onyxLocksystem"]:givePlayerKeys(GetVehicleNumberPlateText(spawned))
end)

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
    customTires      = GetVehicleModVariation(vehicle, 23),
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
    modLivery       = GetVehicleLivery(vehicle),
    modLivery2       = GetVehicleMod(vehicle, 48),
	maxFuelLevel = DecorGetInt(vehicle, "_Max_Fuel_Level")
	
  }

end

function SetVehicleProperties(vehicle, props)
  SetVehicleModKit(vehicle,  0)

  if props.plate ~= nil then
    SetVehicleNumberPlateText(vehicle,  props.plate)
  end

  if props.plateIndex ~= nil then
    SetVehicleNumberPlateTextIndex(vehicle,  props.plateIndex)
  end

  if props.health ~= nil and not IsThisModelABike(GetEntityModel(vehicle)) then
	if tonumber(props.health) < 750 then
     SetEntityHealth(vehicle, 700)
     SetVehicleDamage(vehicle, 0.0, 1.0, 0.1, 250.0, 1650.0, true) --800
     SetVehicleDamage(vehicle, -0.2, 1.0, 0.5, 250.0, 600.0, true) -- 50
     SetVehicleDamage(vehicle, -0.7, -0.2, 0.3, 250.0, 450.0, true) --00 50
     SetEntityHealth(vehicle, 700)
     SetVehicleBodyHealth(vehicle, 700)
	 SetVehicleEngineHealth(vehicle, 700)
	end
	if tonumber(props.health) < 500 then
		SetEntityHealth(vehicle, 500)
		SetVehicleDamage(vehicle, 0.0, 1.0, 0.1, 250.0, 1950.0, true) --800
		SetVehicleDamage(vehicle, -0.2, 1.0, 0.5, 250.0, 700.0, true) -- 50
		SetVehicleDamage(vehicle, -0.7, -0.2, 0.3, 250.0, 550.0, true) --00 50
		SetEntityHealth(vehicle, 500)
		SetVehicleBodyHealth(vehicle, 500)
		SetVehicleEngineHealth(vehicle, 500)
	end
	if tonumber(props.health) < 250 then
		SetEntityHealth(vehicle, 250)
		SetVehicleDamage(vehicle, 0.0, 1.0, 0.1, 250.0, 2400.0, true) --800
		SetVehicleDamage(vehicle, -0.2, 1.0, 0.5, 250.0, 750.0, true) -- 50
		SetVehicleDamage(vehicle, -0.7, -0.2, 0.3, 250.0, 600.0, true) --00 50
		SetEntityHealth(vehicle, 250)
		SetVehicleBodyHealth(vehicle, 250)
		SetVehicleEngineHealth(vehicle, 250)
	end
	if tonumber(props.health) < 100 then
		SetEntityHealth(vehicle, 100)
		SetVehicleDamage(vehicle, 0.0, 1.0, 0.1, 250.0, 2500.0, true) --800
		SetVehicleDamage(vehicle, -0.2, 1.0, 0.5, 250.0, 850.0, true) -- 50
		SetVehicleDamage(vehicle, -0.7, -0.2, 0.3, 250.0, 700.0, true) --00 50
		SetEntityHealth(vehicle, 100)
		SetVehicleBodyHealth(vehicle, 100)
		SetVehicleEngineHealth(vehicle, 100)
	end
	exports['NRP-notify']:DoHudText('inform', 'Vehicle Health : '..props.health..'%')
  end

  if props.dirtLevel ~= nil then
    SetVehicleDirtLevel(vehicle,  props.dirtLevel)
  end

  if props.color1 ~= nil then
    local color1, color2 = GetVehicleColours(vehicle)
    SetVehicleColours(vehicle, props.color1, color2)
  end

  if props.color2 ~= nil then
    local color1, color2 = GetVehicleColours(vehicle)
    SetVehicleColours(vehicle, color1, props.color2)
  end

  if props.pearlescentColor ~= nil then
    local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
    SetVehicleExtraColours(vehicle,  props.pearlescentColor,  wheelColor)
  end

  if props.wheelColor ~= nil then
    local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
    SetVehicleExtraColours(vehicle,  pearlescentColor,  props.wheelColor)
  end

  if props.wheels ~= nil then
    SetVehicleWheelType(vehicle,  props.wheels)
  end

  if props.windowTint ~= nil then
    SetVehicleWindowTint(vehicle,  props.windowTint)
  end

  if props.neonEnabled ~= nil then
    SetVehicleNeonLightEnabled(vehicle, 0, props.neonEnabled[1])
    SetVehicleNeonLightEnabled(vehicle, 1, props.neonEnabled[2])
    SetVehicleNeonLightEnabled(vehicle, 2, props.neonEnabled[3])
    SetVehicleNeonLightEnabled(vehicle, 3, props.neonEnabled[4])
  end

  if props.neonColor ~= nil then
    SetVehicleNeonLightsColour(vehicle,  props.neonColor[1], props.neonColor[2], props.neonColor[3])
  end

  if props.modSmokeEnabled ~= nil then
    ToggleVehicleMod(vehicle, 20, true)
  end

  if props.tyreSmokeColor ~= nil then
    SetVehicleTyreSmokeColor(vehicle,  props.tyreSmokeColor[1], props.tyreSmokeColor[2], props.tyreSmokeColor[3])
  end

  if props.modSpoilers ~= nil then
    SetVehicleMod(vehicle, 0, props.modSpoilers, false)
  end

  if props.modFrontBumper ~= nil then
    SetVehicleMod(vehicle, 1, props.modFrontBumper, false)
  end

  if props.modRearBumper ~= nil then
    SetVehicleMod(vehicle, 2, props.modRearBumper, false)
  end

  if props.modSideSkirt ~= nil then
    SetVehicleMod(vehicle, 3, props.modSideSkirt, false)
  end

  if props.modExhaust ~= nil then
    SetVehicleMod(vehicle, 4, props.modExhaust, false)
  end

  if props.modFrame ~= nil then
    SetVehicleMod(vehicle, 5, props.modFrame, false)
  end

  if props.modGrille ~= nil then
    SetVehicleMod(vehicle, 6, props.modGrille, false)
  end

  if props.modHood ~= nil then
    SetVehicleMod(vehicle, 7, props.modHood, false)
  end

  if props.modFender ~= nil then
    SetVehicleMod(vehicle, 8, props.modFender, false)
  end

  if props.modRightFender ~= nil then
    SetVehicleMod(vehicle, 9, props.modRightFender, false)
  end

  if props.modRoof ~= nil then
    SetVehicleMod(vehicle, 10, props.modRoof, false)
  end

  if props.modEngine ~= nil then
    SetVehicleMod(vehicle, 11, props.modEngine, false)
  end

  if props.modBrakes ~= nil then
    SetVehicleMod(vehicle, 12, props.modBrakes, false)
  end

  if props.modTransmission ~= nil then
    SetVehicleMod(vehicle, 13, props.modTransmission, false)
  end

  if props.modHorns ~= nil then
    SetVehicleMod(vehicle, 14, props.modHorns, false)
  end

  if props.modSuspension ~= nil then
    SetVehicleMod(vehicle, 15, props.modSuspension, false)
  end

  if props.modArmor ~= nil then
    SetVehicleMod(vehicle, 16, props.modArmor, false)
  end

  if props.modTurbo ~= nil then
    ToggleVehicleMod(vehicle,  18, props.modTurbo)
  end

  if props.modXenon ~= nil then
    ToggleVehicleMod(vehicle,  22, props.modXenon)
  end

  if props.modFrontWheels ~= nil then
    SetVehicleMod(vehicle, 23, props.modFrontWheels, false)
  end

  if props.modBackWheels ~= nil then
    SetVehicleMod(vehicle, 24, props.modBackWheels, false)
  end

  if props.modPlateHolder ~= nil then
    SetVehicleMod(vehicle, 25, props.modPlateHolder , false)
  end

  if props.modVanityPlate ~= nil then
    SetVehicleMod(vehicle, 26, props.modVanityPlate , false)
  end

  if props.modTrimA ~= nil then
    SetVehicleMod(vehicle, 27, props.modTrimA , false)
  end

  if props.modOrnaments ~= nil then
    SetVehicleMod(vehicle, 28, props.modOrnaments , false)
  end

  if props.modDashboard ~= nil then
    SetVehicleMod(vehicle, 29, props.modDashboard , false)
  end

  if props.modDial ~= nil then
    SetVehicleMod(vehicle, 30, props.modDial , false)
  end

  if props.modDoorSpeaker ~= nil then
    SetVehicleMod(vehicle, 31, props.modDoorSpeaker , false)
  end

  if props.modSeats ~= nil then
    SetVehicleMod(vehicle, 32, props.modSeats , false)
  end

  if props.modSteeringWheel ~= nil then
    SetVehicleMod(vehicle, 33, props.modSteeringWheel , false)
  end

  if props.modShifterLeavers ~= nil then
    SetVehicleMod(vehicle, 34, props.modShifterLeavers , false)
  end

  if props.modAPlate ~= nil then
    SetVehicleMod(vehicle, 35, props.modAPlate , false)
  end

  if props.modSpeakers ~= nil then
    SetVehicleMod(vehicle, 36, props.modSpeakers , false)
  end

  if props.modTrunk ~= nil then
    SetVehicleMod(vehicle, 37, props.modTrunk , false)
  end

  if props.modHydrolic ~= nil then
    SetVehicleMod(vehicle, 38, props.modHydrolic , false)
  end

  if props.modEngineBlock ~= nil then
    SetVehicleMod(vehicle, 39, props.modEngineBlock , false)
  end

  if props.modAirFilter ~= nil then
    SetVehicleMod(vehicle, 40, props.modAirFilter , false)
  end

  if props.modStruts ~= nil then
    SetVehicleMod(vehicle, 41, props.modStruts , false)
  end

  if props.modArchCover ~= nil then
    SetVehicleMod(vehicle, 42, props.modArchCover , false)
  end

  if props.modAerials ~= nil then
    SetVehicleMod(vehicle, 43, props.modAerials , false)
  end

  if props.modTrimB ~= nil then
    SetVehicleMod(vehicle, 44, props.modTrimB , false)
  end

  if props.modTank ~= nil then
    SetVehicleMod(vehicle, 45, props.modTank , false)
  end

  if props.modWindows ~= nil then
    SetVehicleMod(vehicle, 46, props.modWindows , false)
  end

  if props.modLivery ~= nil then
    SetVehicleLivery(vehicle, props.modLivery)
  end

  if props.modLivery2 ~= nil then
    SetVehicleMod(vehicle, 48, props.modLivery2, false)
  end
  
  if props.customTires == 1 then
	SetVehicleMod(vehicle, 23, GetVehicleMod(vehicle, 23), true)
	SetVehicleMod(vehicle, 24, GetVehicleMod(vehicle, 23), true)	
  end
  if props.health ~= nil then
	SetVehicleEngineHealth(vehicle, props.health+0.00)
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

