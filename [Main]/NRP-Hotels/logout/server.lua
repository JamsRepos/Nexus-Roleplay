RegisterServerEvent("hotel:setLogStat")
AddEventHandler("hotel:setLogStat", function(hotel, status)
  local source = tonumber(source)
  TriggerEvent('core:getPlayerFromId', source, function(user)
   if status == true then 
    exports['GHMattiMySQL']:QueryAsync("UPDATE `characters` SET loggedHome=@loggedHome WHERE id=@char_id",{['@loggedHome'] = "motel-"..hotel, ['@char_id'] = user.getCharacterID()})
   else 
    exports['GHMattiMySQL']:QueryAsync("UPDATE `characters` SET loggedHome=@loggedHome WHERE id=@char_id",{['@loggedHome'] = "", ['@char_id'] = user.getCharacterID()})
   end
  end)
end)

RegisterServerEvent("hotel:checkInside")
AddEventHandler("hotel:checkInside", function()
  local source = tonumber(source)
  TriggerEvent('core:getPlayerFromId', source, function(user)
    exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM characters WHERE `char_id` = @char_id", {['@char_id'] = user.getCharacterID()}, function(character)
        if character[1].loggedHome and character[1].loggedHome ~= "" then
            local hotel = string.match(
                character[1].loggedHome,
                "%d+"
            )
         TriggerClientEvent('hotel:setLoginSet', source, hotel)
         TriggerEvent('hotel:createInstance', hotel)
         print("Returning User to latest Motel Room")
        end
    end)
  end)
end)