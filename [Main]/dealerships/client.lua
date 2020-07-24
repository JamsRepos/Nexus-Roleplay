local spawnedCars = {}
local testdriving = false
local cooldowntimer = nil

function getCarId(cartbl)
    for _,v in ipairs(Config.cars) do if v==cartbl then return _ end end
    return false
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Config.render_center, false)<=Config.render_distance then
            local closest_car = nil
            for k,v in ipairs(Config.cars) do
                if spawnedCars[k]==nil or (not DoesEntityExist(spawnedCars[k][2]) and spawnedCars[k]~="spawning") then
                    spawnedCars[k]="spawning"
                    RequestModel(v.model)
                    while not HasModelLoaded(v.model) do
                     Citizen.Wait(10)
                    end
                    local veh = CreateVehicle(v.model, v.pos, v.heading*1.0, false, true)
                    local props = GetVehProps(veh, false)
                    SetVehicleOnGroundProperly(veh)
                    spawnedCars[k] = {v,veh,k,props}
                    SetVehicleDoorsLocked(veh, 2)
                    SetVehicleAsNoLongerNeeded(veh)
                    --for i=0,7 do SetVehicleDoorCanBreak(veh, i, false) ;SetVehicleDoorOpen(veh, i, false, false) end
                    SetEntityInvincible(veh, true)
                    SetVehicleUndriveable(veh, true)
                    SetEntityMaxSpeed(veh, 0.0)
                end
                closest_car = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),v.pos,false)<GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),closest_car~=nil and closest_car.pos or vector3(0,0,0),false) and v or closest_car
                closest_car.properties = v.props
            end
            local x,y,z = table.unpack(closest_car.pos)
            local close = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),closest_car.pos,false)<2.5
            if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),closest_car.pos,false)<5.0 then
                DrawText3Ds(x, y, z+1.55, "[~r~"..(closest_car.label~=nil and closest_car.label or GetDisplayNameFromVehicleModel(GetHashKey(closest_car.model))).."~s~] : [~g~"..Config["currency"]..format_int(closest_car.price).."~s~]")
                DrawText3Ds(x, y, z+1.45, "Press ["..(close and "~g~" or "~c~").."E".."~s~] to buy. Press ["..((close and Config.allow_test_drive and not testdriving) and "~g~" or "~c~").."F".."~s~] to test drive.")
            end
            if close and IsControlJustPressed(0, 51) then
                TriggerServerEvent('importdealership:buy', spawnedCars[getCarId(closest_car)][4], closest_car.price, closest_car.model, getCarId(closest_car))
            elseif close and IsControlJustPressed(0, 23) and Config.allow_test_drive and not testdriving then
                RequestModel(closest_car.model)
                while not HasModelLoaded(closest_car.model) do
                 Citizen.Wait(10)
                end
                local vehicle = CreateVehicle(closest_car.model, Config.test_point.pos, Config.test_point.heading, true, true)
                SetVehicleNumberPlateText(vehicle, "DEALER")
                DecorSetInt(vehicle, "_Fuel_Level", 100000)
                TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
                exports["onyxLocksystem"]:givePlayerKeys(GetVehicleNumberPlateText(vehicle))
                startTimer(Config.test_drive_time)
                testdriving = true
                cooldowntimer = 300
                Wait(Config.test_drive_time*1000)
                DoScreenFadeOut(500)
                Wait(500)
                DoScreenFadeIn(500)
                DeleteEntity(vehicle)
                SetEntityCoords(GetPlayerPed(-1),Config.test_point.pos,0,0,0,false)
            end
        else
            for k,v in ipairs(spawnedCars) do
                DeleteEntity(v[2])
                spawnedCars[k]=nil
            end
        end
    end
end)

-- Timer countdown
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

RegisterNetEvent("importdealership:bought")
AddEventHandler("importdealership:bought",function(data, plate)
 FreezeEntityPosition(GetPlayerPed(-1),false)
 SetEntityVisible(GetPlayerPed(-1),true)
 RequestModel(data.model)
 while not HasModelLoaded(data.model) do
 Citizen.Wait(0)
 end
 spawned = CreateVehicle(data.model, Config.buy_point.pos, Config.buy_point.heading, true, false)
 SetVehicleProperties(spawned, data)
 SetVehicleNumberPlateText(spawned, plate)
 SetEntityAsMissionEntity(spawned, true, true)
 SetVehicleIsConsideredByPlayer(spawned, true)
 TaskWarpPedIntoVehicle(GetPlayerPed(-1), spawned, -1)
 TriggerEvent('persistent-vehicles/register-vehicle', spawned)
 exports["onyxLocksystem"]:givePlayerKeys(GetVehicleNumberPlateText(spawned))
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

function format_int(number)
    local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')
    -- reverse the int-string and append a comma to all blocks of 3 digits
    int = int:reverse():gsub("(%d%d%d)", "%1,")
    -- reverse the int-string back remove an optional comma and put the 
    -- optional minus and fractional part back
    return minus .. int:reverse():gsub("^,", "") .. fraction
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