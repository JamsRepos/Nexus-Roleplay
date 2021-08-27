
RegisterServerEvent('racing:recordTime')
AddEventHandler('racing:recordTime', function(currentTime,twveh)
  local source = tonumber(source)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  local fullname = user.getIdentity().fullname
  local charid = user.getCharacterID()
  --if currentTime <= 200 then
   PerformHttpRequest("https://discordapp.com/api/webhooks/699702380358533161/HbdOJCbWn8DCR4qkHm61cFJFEXfgicBEatUibtjooBo45RTVMQO12gd65xkGhrq-npMh",function(Error, Content, Head) end, 'POST',json.encode({username = SystemName, content = "```ID : "..charid.."\nNAME: "..fullname.."\nCAR : "..twveh.."\nTIME: "..currentTime.."```", avatar_url = SystemAvatar}), {['Content-Type'] = 'application/json'})
  --else
  -- TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = 'Try Again Your Time Was To Slow To Be Recorded. Better Luck Next Time!'})  
  --end 
  end)
end)
