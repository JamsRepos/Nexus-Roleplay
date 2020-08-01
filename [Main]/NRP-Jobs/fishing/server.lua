RegisterServerEvent('fishing:sellfish')
AddEventHandler('fishing:sellfish', function(payout)
    TriggerEvent('core:getPlayerFromId', source, function(user)
        user.addMoney(payout)
      end)
end)

