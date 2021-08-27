--[[RegisterServerEvent("blackmarket:addWeapon")
AddEventHandler("blackmarket:addWeapon",function(name, label)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
   user.addBlackMarketWeapon(name, label)
   TriggerEvent('chatMessage', source, "POLICE", {66, 134, 244}, "This weapon is illegal! You must purchase a weapon at the Gun Stores for it to be registered as legal. This gun IS NOT traceable.")
 end)
end)]]--