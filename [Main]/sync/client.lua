CurrentWeather = 'EXTRASUNNY'
local lastWeather = CurrentWeather
local baseTime = 0
local timeOffset = 0
local timer = 0
local blackout = false
local insideInterior = false 

RegisterNetEvent('sync:updateWeather')
AddEventHandler('sync:updateWeather', function(NewWeather, newblackout)
 if insideInterior then
  CurrentWeather = 'EXTRASUNNY'
 else
  CurrentWeather = NewWeather
  blackout = newblackout
 end
end)

RegisterNetEvent('sync:updateTime')
AddEventHandler('sync:updateTime', function(base, offset)
 if insideInterior then
  CurrentWeather = 'EXTRASUNNY'
 else
  timeOffset = offset
  baseTime = base
 end
end)

Citizen.CreateThread(function()
    while true do
        if lastWeather ~= CurrentWeather then
            lastWeather = CurrentWeather
            SetWeatherTypeOverTime(CurrentWeather, 15.0)
            Citizen.Wait(15000)
        end
        Citizen.Wait(100)
        SetBlackout(blackout)
        ClearOverrideWeather()
        ClearWeatherTypePersist()
        SetWeatherTypePersist(lastWeather)
        SetWeatherTypeNow(lastWeather)
        SetWeatherTypeNowPersist(lastWeather)
        if lastWeather == 'XMAS' then
            SetForceVehicleTrails(true)
            SetForcePedFootstepsTracks(true)
        else
            SetForceVehicleTrails(false)
            SetForcePedFootstepsTracks(false)
        end
    end
end)

--[[Citizen.CreateThread(function()
 while true do
  SetWeatherTypePersist("XMAS")
  SetWeatherTypeNowPersist("XMAS")
  SetWeatherTypeNow("XMAS")
  SetOverrideWeather("XMAS")
  SetForcePedFootstepsTracks(true)
  SetForceVehicleTrails(true)
  Citizen.Wait(1)
 end
end)]]--


Citizen.CreateThread(function()
    local hour = 0
    local minute = 0
    while true do
      Citizen.Wait(0)
      if not insideInterior then
        local newBaseTime = baseTime
        if GetGameTimer() - 500  > timer then
            newBaseTime = newBaseTime + 0.25
            timer = GetGameTimer()
        end
        baseTime = newBaseTime
        hour = math.floor(((baseTime+timeOffset)/60)%24)
        minute = math.floor((baseTime+timeOffset)%60)
        NetworkOverrideClockTime(hour, minute, 0)
      else
        NetworkOverrideClockTime(00, 00, 0)
      end
    end
end)

AddEventHandler('playerSpawned', function()
    TriggerServerEvent('sync:requestSync')
end)

AddEventHandler('sync:insideInterior', function(v)
 insideInterior = v
 if not v then 
  TriggerServerEvent('sync:requestSync')
 end
end)

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(0)
  if insideInterior then
   SetTrafficDensity(0.0)
   SetPedDensity(0.0)
  else
   if isNight() then 
    SetTrafficDensity(0.4)
    SetPedDensity(0.2)
   else 
    SetTrafficDensity(0.6)
    SetPedDensity(0.7)
   end
  end
 end
end)



function SetTrafficDensity(density)
    SetParkedVehicleDensityMultiplierThisFrame(density)
    SetVehicleDensityMultiplierThisFrame(density)
    SetRandomVehicleDensityMultiplierThisFrame(density)
end

function SetPedDensity(density)
    SetPedDensityMultiplierThisFrame(density)
    SetScenarioPedDensityMultiplierThisFrame(density, density)
end

function isNight()
 local hour = GetClockHours()
 if hour > 23 or hour < 3 then 
  return true
 end
end

function isDay()
 local hour = GetClockHours()
 if hour > 3 and hour < 23 then
  return true
 end
end