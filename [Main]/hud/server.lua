local cops = 0
local ems = 0
local mech = 0

--[[
RegisterServerEvent("mechanic:repair")
AddEventHandler("mechanic:repair", function(source)
    local source = tonumber(source)
    TriggerEvent("core:getPlayerFromId", source, function(user)
        if user.getMoney() >= 500 then
            user.removeMoney(500)
            TriggerClientEvent("knb:mech")
            TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = 'Mechanic on the way $500 has been taken!', length = 5000})
        elseif user.getBank() >= 500 then
            user.removeBank(500)
            TriggerClientEvent("knb:mech")
            TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = 'Mechanic on the way $500 has been taken!', length = 5000})
        else
            TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = 'You need $500 to use this service!', length = 5000})
        end
    end)
end)
--]]

RegisterServerEvent('mechanic:repair')
AddEventHandler('mechanic:repair', function(name, pay)
 local sourcePlayer = tonumber(source)
  TriggerEvent("core:getPlayerFromId", source, function(user)
   user.removeBank(500)
 end)
end)

local function policeCheck()
  SetTimeout(60000, function()
    Citizen.CreateThread(function()
     ems = 0
     cops = 0 
     mech = 0
     TriggerEvent('core:getPlayers', function(Users)
      for k,v in pairs(Users)do
       TriggerClientEvent('hud:money', Users[k]:getSource(), Users[k]:getMoney())
       TriggerClientEvent('banking:updateBalance', Users[k]:getSource(), Users[k]:getBank())
       if Users[k]:getJob() == 1 or Users[k]:getJob() == 31 or Users[k]:getJob() == 32 or Users[k]:getJob() == 33 or Users[k]:getJob() == 34 or Users[k]:getJob() == 35 or Users[k]:getJob() == 36 or Users[k]:getJob() == 37 or Users[k]:getJob() == 90 or Users[k]:getJob() == 91 then
        if Users[k]:isOnDuty() then 
         cops = cops + 1
        end
       elseif Users[k]:getJob() == 2 or Users[k]:getJob() == 50 or Users[k]:getJob() == 51 or Users[k]:getJob() == 52 or Users[k]:getJob() == 53 or Users[k]:getJob() == 54 or Users[k]:getJob() == 55 or Users[k]:getJob() == 56 or Users[k]:getJob() == 57 then
        ems = ems + 1
       elseif Users[k]:getJob() == 3 then
        mech = mech + 1
       end
      end
      TriggerClientEvent('hud:updatepresence', -1, cops, ems, tonumber(mech))
      TriggerClientEvent('ems:count', -1, cops, ems)
      policeCheck()
     end)
    end)
  end)
end
policeCheck()

--[[RegisterServerEvent('NRP-Hud:GetMoneyStuff')
AddEventHandler('NRP-Hud:GetMoneyStuff', function()
    local data = {}
    while exports['core']:GetActiveCharacter(source) == nil do
        Citizen.Wait(0)
    end
    while exports['core']:GetActiveCharacter(source) == nil do
        Citizen.Wait(0)
    end
    data = exports['core']:GetActiveCharacter(source)
    TriggerClientEvent('NRP-Hud:DisplayMoneyStuff', source, data.money, data.bank)
end)]]--
