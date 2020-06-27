local stealTimer = false

RegisterServerEvent('xz-meth:start')
AddEventHandler('xz-meth:start', function(name, storeLoc)
    stealTimer = true
 AlertPolice('Reports Of A Robbery In Progress at Lower Pillbox Hospital')	
 TriggerClientEvent('xz-meth:addBlip', -1, storeLoc)
end)

RegisterServerEvent('xz-meth:end') 
AddEventHandler('xz-meth:end', function(name, storeLoc)
 stealtimer = false
 AlertPolice('Latest Reported Robbery Has Been Finished at Lower Pillbox Hospital')	 
TriggerEvent('core:getPlayerFromId', source, function(user)
TriggerEvent("core:moneylog", source, 'Just Finished Robbing Ammonia From The Hospital')
  TriggerClientEvent('xz-meth:killBlip', -1)
  TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Robbery Succesful"})
  end)
end)



RegisterServerEvent('xz-meth:cancel')
AddEventHandler('xz-meth:cancel', function(name, loc)
AlertPolice('Latest Reported '..name..' The Person Left The Building')	
 TriggerClientEvent('xz-meth:killBlip', -1)
 TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "You Dipped"})
end)


function AlertPolice(message)
 TriggerEvent('core:getPlayers', function(players)
  for i in pairs(players)do
  if players[i]:getJob() == 1 or players[i]:getJob() == 31 or players[i]:getJob() == 32 or players[i]:getJob() == 33 or players[i]:getJob() == 34 or players[i]:getJob() == 35 or players[i]:getJob() == 36 or players[i]:getJob() == 37 or players[i]:getJob() == 90 or players[i]:getJob() == 91  then
    if players[i].isOnDuty() then
     TriggerClientEvent('NRP-notify:client:SendAlert', players[i].get('source'), { type = 'error', text =message})
    end
   end 
   end 
 end)
end 