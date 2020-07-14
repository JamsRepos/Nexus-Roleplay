local DynamicWeather = true
local CurrentWeather = "EXTRASUNNY"
local baseTime = 0
local timeOffset = 0
local freezeTime = false
local blackout = false
local newWeatherTimer = 30

RegisterServerEvent('sync:requestSync')
AddEventHandler('sync:requestSync', function()
    TriggerClientEvent('sync:updateWeather', -1, CurrentWeather, blackout)
    TriggerClientEvent('sync:updateTime', -1, baseTime, timeOffset, freezeTime)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local newBaseTime = os.time(os.date("!*t"))/2 + 360
        baseTime = newBaseTime
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        TriggerClientEvent('sync:updateTime', -1, baseTime, timeOffset, freezeTime)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(300000)
        TriggerClientEvent('sync:updateWeather', -1, CurrentWeather, blackout)
    end
end)

Citizen.CreateThread(function()
    while true do
        newWeatherTimer = newWeatherTimer - 1
        Citizen.Wait(60000)
        if newWeatherTimer == 0 then
            if DynamicWeather then
                NextWeatherStage()
            end
            newWeatherTimer = 30
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local newBaseTime = os.time(os.date("!*t"))/2 + 360
        if freezeTime then
            timeOffset = timeOffset + baseTime - newBaseTime			
        end
        baseTime = newBaseTime
    end
end)

function NextWeatherStage()
    if CurrentWeather == "CLEAR" or CurrentWeather == "CLOUDS" or CurrentWeather == "EXTRASUNNY"  then
        local new = math.random(1,2)
        if new == 1 then
            CurrentWeather = "CLEARING"
        else
            CurrentWeather = "OVERCAST"
        end
    elseif CurrentWeather == "CLEARING" or CurrentWeather == "OVERCAST" then
        local new = math.random(1,6)
        if new == 1 then
            if CurrentWeather == "CLEARING" then CurrentWeather = "FOGGY" else CurrentWeather = "RAIN" end
        elseif new == 2 then
            CurrentWeather = "CLOUDS"
        elseif new == 3 then
            CurrentWeather = "CLEAR"
        elseif new == 4 then
            CurrentWeather = "EXTRASUNNY"
        elseif new == 5 then
            CurrentWeather = "SMOG"
        else
            CurrentWeather = "FOGGY"
        end
    elseif CurrentWeather == "THUNDER" or CurrentWeather == "RAIN" then
        CurrentWeather = "CLEARING"
    elseif CurrentWeather == "SMOG" or CurrentWeather == "FOGGY" then
        CurrentWeather = "CLEAR"
    end
    TriggerEvent("sync:requestSync")
end

TriggerEvent('core:addGroupCommand', 'freezetime', "admin", function(source, args)
    if source ~= 0 then
        freezeTime = not freezeTime
        if freezeTime then
            TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = "Time is now frozen."})
        else
            TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = "Time is no longer frozen."})
        end
    else
        freezeTime = not freezeTime
        if freezeTime then
            print("Time is now frozen.")
        else
            print("Time is no longer frozen.")
        end
    end
end)

TriggerEvent('core:addGroupCommand', 'blackout', "admin", function(source)
    if source == 0 then
        blackout = not blackout
        if blackout then
            print("Blackout is now enabled.")
        else
            print("Blackout is now disabled.")
        end
    else
        blackout = not blackout
        if blackout then
            TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = "Blackout is enabled."})
        else
            TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = "Blackout is disabled"})
        end
        TriggerEvent('sync:requestSync')
    end
end)

TriggerEvent('core:addGroupCommand', 'morning', "admin", function(source)
    if source == 0 then
        print("For console, use the \"/time <hh> <mm>\" command instead!")
        return
    end
    ShiftToMinute(0)
    ShiftToHour(9)
    TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = "Time set to morning."})
    TriggerEvent('sync:requestSync')
end)

TriggerEvent('core:addGroupCommand', 'noon', "admin", function(source)
    if source == 0 then
        print("For console, use the \"/time <hh> <mm>\" command instead!")
        return
    end
    ShiftToMinute(0)
    ShiftToHour(12)
    TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = "Time set to noon."})
    TriggerEvent('sync:requestSync')
end)

TriggerEvent('core:addGroupCommand', 'evening', "admin", function(source)
    if source == 0 then
        print("For console, use the \"/time <hh> <mm>\" command instead!")
        return
    end
    ShiftToMinute(0)
    ShiftToHour(18)
    TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = "Time set to evening."})
    TriggerEvent('sync:requestSync')
end)

TriggerEvent('core:addGroupCommand', 'night', "admin", function(source)
    if source == 0 then
        print("For console, use the \"/time <hh> <mm>\" command instead!")
        return
    end
    ShiftToMinute(0)
    ShiftToHour(23)
    TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = "Time set to night."})
    TriggerEvent('sync:requestSync')
end)

function ShiftToMinute(minute)
    timeOffset = timeOffset - ( ( (baseTime+timeOffset) % 60 ) - minute )
end

function ShiftToHour(hour)
    timeOffset = timeOffset - ( ( ((baseTime+timeOffset)/60) % 24 ) - hour ) * 60
end