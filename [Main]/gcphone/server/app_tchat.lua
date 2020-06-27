function TchatGetMessageChannel (channel, cb)
  exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM phone_app_chat WHERE channel = @channel ORDER BY time DESC LIMIT 100;", { 
        ['@channel'] = channel
    }, cb)
end

function TchatAddMessage (channel, message)
  local Query = "INSERT INTO phone_app_chat (`channel`, `message`) VALUES(@channel, @message);"
  local Query2 = 'SELECT * from phone_app_chat WHERE `id` = @id;'
  local Parameters = {
    ['@channel'] = channel,
    ['@message'] = message
  }
  --exports['GHMattiMySQL']:QueryAsync(Query, Parameters, function (id)
    --exports['GHMattiMySQL']:QueryResult(Query2, { ['@id'] = id }, function (reponse)
  return exports['GHMattiMySQL']:QueryResult(Query .. Query2, Parameters)[1],function (reponse)
    TriggerClientEvent('gcPhone:tchat_receive', -1, reponse[1])
  end
end


RegisterServerEvent('gcPhone:tchat_channel')
AddEventHandler('gcPhone:tchat_channel', function(channel)
  local sourcePlayer = tonumber(source)
  TchatGetMessageChannel(channel, function (messages)
    TriggerClientEvent('gcPhone:tchat_channel', sourcePlayer, channel, messages)
  end)
end)

RegisterServerEvent('gcPhone:tchat_addMessage')
AddEventHandler('gcPhone:tchat_addMessage', function(channel, message)
  TchatAddMessage(channel, message)
end)