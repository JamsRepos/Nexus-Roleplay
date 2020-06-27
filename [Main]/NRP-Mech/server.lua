RegisterServerEvent('mechanic:charge')
AddEventHandler('mechanic:charge', function(amount)
  local source = tonumber(source)
  TriggerEvent('core:getPlayerFromId', source, function(user)
   user.removeMoney(amount)
   TriggerEvent("core:moneylog", source, '[MECHANICS] Part Delivery Charge: $'..amount)
  end)
end)


RegisterServerEvent('xz-mech:onduty')
AddEventHandler('xz-mech:onduty',function()
    print("CALLING ON DUTY")
    local source = tonumber(source)
    TriggerEvent('core:getPlayerFromId', source, function(user)
        user.setJob(3)
        TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = "Your Now On Duty", timeout= 10000})
    end)
end)

RegisterServerEvent('xz-mech:offduty')
AddEventHandler('xz-mech:offduty',function()
    print("CALLING OFF DUTY")
    local source = tonumber(source)
    TriggerEvent('core:getPlayerFromId', source, function(user)
        user.setJob(38)
        TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = "Your Now Off Duty", timeout= 10000})
    end)
end)


TriggerEvent('core:addGroupCommand', 'impound', "user", function(source, args, user)
 local source = tonumber(source)
 local plate = tostring(args[2])
 TriggerEvent("core:getPlayerFromId", source, function(user)
 if user.getJob() == 1 or user.getJob() == 32 or user.getJob() == 33 or user.getJob() == 34 or user.getJob() == 35 or user.getJob() == 36 or user.getJob() == 37 or user.getJob() == 90 or user.getJob() == 91 then
   TriggerEvent('core:getPlayerFromId', source, function(user)
    Citizen.CreateThread(function()
     TriggerEvent('core:getPlayers', function(Users)
      for k,v in pairs(Users)do
       local vehicles = Users[k]:getVehicles()
       for i=1, #vehicles do 
        if vehicles[i].plate == plate then 
         TriggerEvent('mechanic:impound', Users[k]:getSource(), plate, vehicles[i].model, user.getIdentity().fullname)
         TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Vehicle Impounded, Remove The Vehicle Using Impound"})           
        end
       end
      end
     end)
    end)
   end)
  end
 end)
end)

TriggerEvent('core:addGroupCommand', 'crush', "user", function(source, args, user)
 local source = tonumber(source)
 local plate = tostring(args[2])
 TriggerEvent("core:getPlayerFromId", source, function(user)
  if user.getJob() == 1 then
   TriggerEvent('core:getPlayerFromId', source, function(user)
    Citizen.CreateThread(function()
     TriggerEvent('core:getPlayers', function(Users)
      for k,v in pairs(Users)do
       local vehicles = Users[k]:getVehicles()
       for i=1, #vehicles do 
        if vehicles[i].plate == plate then 
         TriggerEvent('mechanic:crush', Users[k]:getSource(), plate, vehicles[i].model, user.getIdentity().fullname)
         TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Vehicle Crushed, Remove The Vehicle Using Impound"})           
        end
       end
      end
     end)
    end)
   end)
  end
 end)
end)

AddEventHandler('mechanic:impound', function(source, plate, model, officer)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  user.setVehicleImpound(plate, true)
  TriggerEvent('phone:addEmail', source, 'Your '..model..' | '..plate..' Has Been Impounded By '..officer.." Of The LSPD")
 end)
end)

--[[RegisterServerEvent('mechanic:impound2')
AddEventHandler('mechanic:impound2', function()
  local sourcePlayer = tonumber(source)
  TriggerEvent('core:getPlayerFromId', source, function(user)
  user.addMoney(1000)
  TriggerClientEvent('NRP-notify:client:SendAlert', tonumber(sourcePlayer), { type = 'inform', text = "You've been Given $1000 From the Impound"})
  end)                
end)]]--

AddEventHandler('mechanic:crush', function(source, plate, model, officer)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  user.removeVehicle(plate)
  TriggerEvent('phone:addEmail', source, 'Your '..model..' | '..plate..' Has Been Crushed By '..officer.." Of The LSPD")
 end)
end)

RegisterServerEvent("garage:impound")
AddEventHandler("garage:impound", function(data, impoundfee)
 local source = tonumber(source)
 local mechanicPay = math.floor(impoundfee / 10)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  if user.getMoney() >= impoundfee then
   user.removeMoney(impoundfee)
   TriggerEvent("core:moneylog", source, 'Impound Payment: $'..impoundfee)
   user.setVehicleImpound(data.plate, false)
   TriggerClientEvent('garage:spawn', source, data)
   Citizen.CreateThread(function()
    TriggerEvent('core:getPlayers', function(Users)
     for k,v in pairs(Users)do
      if Users[k]:getJob() == 3 then 
       Users[k]:addMoney(mechanicPay)
       TriggerClientEvent('phone:notification', Users[k]:getSource(), 'Impound Payment Recieved: $'..mechanicPay..'')
      end
     end
    end)
   end)
  else 
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Insufficient Funds"})           
  end
 end)
end)

function activatemechanicSystem()
    local availableMissions = {}
    local activemechanics = {}
    local acceptMultiple = true
    local callstatus = {
        onHold = 2,
        accepted = 1,
        none = 0,
    }

    function ms_setMission(target)
        target = target or -1
        TriggerClientEvent('mechanic:changeMission', target, availableMissions)
    end

    function ms_cancelMission(source)
        TriggerClientEvent('mechanic:cancelMission', source)
    end

    function ms_updatemechanics(target)
        target = target or -1
        TriggerClientEvent('mechanic:updateactivemechanics', target,  ms_getAllmechanics(), ms_getAvailablemechanics())
     end

    function ms_messagemechanics(msg)
        TriggerClientEvent('mechanic:notifyallmechanics', -1, msg)
    end

    function ms_messagemechanic(source, msg)
        TriggerClientEvent('mechanic:notifyallmechanics', source, msg)
    end

    function ms_messageClient(source, msg)
        TriggerClientEvent('mechanic:notifyClient', source, msg)
    end

    function ms_messageClients(msg)
        TriggerClientEvent('mechanic:notifyClient', -1 , msg)
    end

    function ms_setCallstatus(source, status)
        TriggerClientEvent('mechanic:callStatus', source, status)
    end

    function ms_addMission(source, position, reason)
        local sMission = availableMissions[source]
        local character = exports['core']:GetActiveCharacter(source)
        if sMission == nil then
            availableMissions[source] = {
                id = source,
                name = character.firstname.." "..character.lastname,
                pos = position,
                acceptBy = {},
                type = reason
            }
            ms_messageClient(source, 'Confirmation Your call has been registered')
            ms_setCallstatus(source, callstatus.onHold)
            ms_messagemechanics('A new alert has been posted, it has been added to your list of missions')
            ms_setMission()
        end
    end

    function ms_closeMission(source, missionId)
        if availableMissions[missionId] ~= nil then
            for _, v in pairs(availableMissions[missionId].acceptBy) do 
                if v ~= source then
                    ms_messagemechanic(v, 'Your customer has canceled')
                    ms_cancelMission(v)
                end
                ms_setmechanicAvailable(v)
            end
            availableMissions[missionId] = nil
            ms_messageClient(missionId, 'Your call has been resolved')
            ms_setCallstatus(missionId, callstatus.none)
            ms_setMission()
            ms_updatemechanics()
        end
    end

    function ms_acceptMission(source, missionId)
        local sMission = availableMissions[missionId]
        if sMission == nil then
            ms_messagemechanic(source,'The mission is no longer available')
        elseif #sMission.acceptBy ~= 0  and not acceptMultiple then 
            ms_messagemechanic(source, 'This mission is already under way')
        else
            ms_exitMission(source)
            if #sMission.acceptBy >= 1 then
                if sMission.acceptBy[1] ~= source then
                    for _, m in pairs(sMission.acceptBy) do
                        ms_messagemechanic(m, 'You are several people responding')
                    end
                    table.insert(sMission.acceptBy, source)
                end
            else
                table.insert(sMission.acceptBy, source)
                ms_messageClient(sMission.id, 'Your call has been accepted, a mechanicman is on the way')
                ms_messagemechanic(source, 'Mission accepted, get started')
            end
            TriggerClientEvent('mechanic:acceptMission', source, sMission)
            ms_setCallstatus(missionId, callstatus.accepted)
            ms_setmechanicBusy(source)
            ms_setMission()
            ms_updatemechanics()
        end
    end

    function ms_exitMission(personnelId)
        for _, mission in pairs(availableMissions) do 
            for k, v in pairs(mission.acceptBy) do 
                if v == personnelId then
                    table.remove(mission.acceptBy, k)
                    if #mission.acceptBy == 0 then
                        ms_messageClient(mission.id, 'The mechanicman has abandoned your call')
                        TriggerClientEvent('mechanic:callStatus', mission.id, 2)
                        ms_setCallstatus(mission.id, callstatus.onHold)
                        ms_messagemechanics('A new alert has been posted, it has been added to your list of missions')
                    end
                    break
                end
            end
        end
        ms_removemechanic(personnelId)
        ms_updatemechanics()
    end

    function ms_cancelMissionclient(clientId)
        if availableMissions[clientId] ~= nil then
            for _, v in pairs(availableMissions[clientId].acceptBy) do 
                ms_messagemechanic(v, 'the call has been canceled')
                ms_cancelMission(v)
                ms_setmechanicAvailable(v)
            end
            availableMissions[clientId] = nil
            ms_setCallstatus(clientId, callstatus.none)
            ms_setMission()
            ms_updatemechanics()
        end
    end

    function ms_addmechanic(source)
        activemechanics[source] = false
    end
    
    function ms_removemechanic(source)
        activemechanics[source] = nil
    end

    function ms_setmechanicBusy(source)
        activemechanics[source] = true        
    end

    function ms_setmechanicAvailable(source)
        activemechanics[source] = false
    end

    function ms_getAllmechanics()
        local count = 0
        for _, v in pairs(activemechanics) do 
            count = count + 1
        end
        return count
    end

    function ms_getAvailablemechanics()
        local count = 0
        for _, v in pairs(activemechanics) do 
            if v == false then
                count = count + 1
            end
        end
        return count
    end

    function ms_getBusymechanics()
        local count = 0
        for _, v in pairs(activemechanics) do 
            if v == true then
                count = count + 1
            end
        end
        return count
    end


    RegisterServerEvent('mechanic:takeService')
    AddEventHandler('mechanic:takeService', function ()
        ms_addmechanic(source)
        ms_updatemechanics()
    end)

    RegisterServerEvent('mechanic:breakService')
    AddEventHandler('mechanic:breakService', function ()
        ms_exitMission(source)
        ms_removemechanic(source)
    end)

    RegisterServerEvent('mechanic:requestMission')
    AddEventHandler('mechanic:requestMission', function ()
        ms_setMission(source)
    end)

    RegisterServerEvent('mechanic:getactivemechanics')
    AddEventHandler('mechanic:getactivemechanics', function ()
        ms_updatemechanics(source)
    end)

    RegisterServerEvent('mechanic:Call')
    AddEventHandler('mechanic:Call',function(posX,posY,posZ,type)
        ms_addMission(source, {posX, posY, posZ}, type)
    end)

    RegisterServerEvent('mechanic:CallCancel')
    AddEventHandler('mechanic:CallCancel', function ()
        ms_cancelMissionclient(source)
    end)

    RegisterServerEvent('mechanic:acceptMission')
    AddEventHandler('mechanic:acceptMission', function (id)
        ms_acceptMission(source, id)
    end)

    RegisterServerEvent('mechanic:finishMission')
    AddEventHandler('mechanic:finishMission', function (id)
        ms_closeMission(source, id)
    end)

    RegisterServerEvent('mechanic:cancelCall')
    AddEventHandler('mechanic:cancelCall', function ()
        ms_cancelMissionclient(source)
    end)

    AddEventHandler('playerDropped', function()
        ms_exitMission(source)
        ms_cancelMissionclient(source)
    end)
end

activatemechanicSystem()