RegisterServerEvent("turtle:timer")
AddEventHandler("turtle:timer", function()
    local source = tonumber(source)
    TriggerEvent("core:getPlayerFromId", source, function(user)
        if user.getTimer("Turtle") == nil then
            user.newTimer("Turtle", 1800)
        else
            user.setTimer("Turtle", 1800)
        end
        TriggerClientEvent('timers:character', source, user.getTimers())
    end)
end)

RegisterServerEvent('turtle:update')
AddEventHandler('turtle:update', function(timer)
 local source = tonumber(source)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  user.setTimer('Turtle', timer)
  TriggerClientEvent('timers:character', source, user.getTimers())
 end)
end)