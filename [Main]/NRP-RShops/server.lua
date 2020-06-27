local robberyInProgress = false 
local storeRobberyInProgress = false
local storeRobbery = false

RegisterServerEvent('robberies:start')
AddEventHandler('robberies:start', function(name, loc)
  if not storeRobbery then
   storeRobberyInProgress = true
   AlertPolice('Reports Of A '..name..' Robbery In Progress')	
   TriggerClientEvent('robberies:addBlip', -1, loc)
   TriggerClientEvent('xzurvRobbery:started', source)
  end
end)

RegisterServerEvent('robberies:end')
AddEventHandler('robberies:end', function(name, loc, pay)
 AlertPolice('Latest Reported '..name..' Robbery Has Been Finished')	 
 TriggerEvent('core:getPlayerFromId', source, function(user)
  user.addDirtyMoney(pay)
  TriggerEvent("core:moneylog", source, 'Robbery Payout: $'..pay)
  TriggerClientEvent('robberies:killBlip', -1)
  TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Robbery Complete, You Have Received: $"..pay})
 end)
end)

RegisterServerEvent('robberies:cancel')
AddEventHandler('robberies:cancel', function(name, loc)
 AlertPolice('Latest Reported '..name..' Robbery Has Been Cancelled')	
 TriggerClientEvent('robberies:killBlip', -1)
 TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Robbery Cancelled, You Have Received Nothing"})
end)

function AlertPolice(message)
  TriggerEvent('core:getPlayers', function(players)
   for i in pairs(players)do
   if players[i].getJob() == 1 or players[i].getJob() == 31 or players[i].getJob() == 32 or players[i].getJob() == 33 or players[i].getJob() == 34 or players[i].getJob() == 35 or players[i].getJob() == 36 or players[i].getJob() == 37 or players[i].getJob() == 90 or players[i].getJob() == 91 then
     if players[i].isOnDuty() then
     TriggerClientEvent('NRP-notify:client:SendAlert', players[i].get('source'), { type = 'error', text =message, duration = 10000})
     end
    end 
   end 
 end)
end 

local vangelicoRobbery = false

RegisterServerEvent('vangelicoRobbery:start')
AddEventHandler('vangelicoRobbery:start', function(loc)
 if not vangelicoRobbery then 
  AlertPolice('Reports Of Robbery At Vangelicos') 
  TriggerClientEvent('robberies:addBlip', -1, loc)
  vangelicoRobbery = true
  TriggerClientEvent('vangelicoRobbery:started', source)
 end
end)

RegisterServerEvent('vangelicoRobbery:cancel')
AddEventHandler('vangelicoRobbery:cancel', function()
 AlertPolice('Latest Robbery At Vangelicos Has Been Cancelled') 
 TriggerClientEvent('robberies:killBlip', -1)
 TriggerClientEvent('vangelicoRobbery:ended', source) 
end)

RegisterServerEvent('robbery:giveCash')
AddEventHandler('robbery:giveCash', function(pay)
 robberyInProgress = false
 TriggerEvent('core:getPlayerFromId', source, function(user)
  user.addMoney(pay)
  TriggerEvent("core:moneylog", source, 'Civ Robbery Payout: $'..pay)
 end)
end)

function heistCooldown()
 SetTimeout(6000000, function()  
  Citizen.CreateThread(function()
   if vangelicoRobbery then 
    vangelicoRobbery = false 
    print('^5Vangelico Robbery Has Been Reset^0')
   end 
   heistCooldown()
  end)
 end)
end 
heistCooldown()

function storeCooldown()
  SetTimeout(1500000, function()  
   Citizen.CreateThread(function()
    if storeRobbery then 
      storeRobbery = false 
     print('^5Store Robbery Has Been Reset^0')
    end 
    storeCooldown()
   end)
  end)
 end 
storeCooldown()
 
