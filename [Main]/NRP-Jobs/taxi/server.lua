function activateTaxiSystem()
    local availableMissions = {}
    local activeTaxis = {}
    local acceptMultiple = true
    local callstatus = {
        onHold = 2,
        accepted = 1,
        none = 0,
    }

    function ms_setMission(target)
        target = target or -1
        TriggerClientEvent('taxi:changeMission', target, availableMissions)
    end

    function ms_cancelMission(source)
        TriggerClientEvent('taxi:cancelMission', source)
    end

    function ms_updateTaxis(target)
        target = target or -1
        TriggerClientEvent('taxi:updateactiveTaxis', target,  ms_getAllTaxis(), ms_getAvailableTaxis())
     end

    function ms_messageTaxis(msg)
        TriggerClientEvent('taxi:notifyallTaxis', -1, msg)
    end

    function ms_messageTaxi(source, msg)
        TriggerClientEvent('taxi:notifyallTaxis', source, msg)
    end

    function ms_messageClient(source, msg)
        TriggerClientEvent('taxi:notifyClient', source, msg)
    end

    function ms_messageClients(msg)
        TriggerClientEvent('taxi:notifyClient', -1 , msg)
    end

    function ms_setCallstatus(source, status)
        TriggerClientEvent('taxi:callStatus', source, status)
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
            ms_messageTaxis('A new alert has been posted, it has been added to your list of missions')
            ms_setMission()
        end
    end

    function ms_closeMission(source, missionId)
        if availableMissions[missionId] ~= nil then
            for _, v in pairs(availableMissions[missionId].acceptBy) do 
                if v ~= source then
                    ms_messageTaxi(v, 'Your customer has canceled')
                    ms_cancelMission(v)
                end
                ms_setTaxiAvailable(v)
            end
            availableMissions[missionId] = nil
            ms_messageClient(missionId, 'Your call has been resolved')
            ms_setCallstatus(missionId, callstatus.none)
            ms_setMission()
            ms_updateTaxis()
        end
    end

    function ms_acceptMission(source, missionId)
        local sMission = availableMissions[missionId]
        if sMission == nil then
            ms_messageTaxi(source,'The mission is no longer available')
        elseif #sMission.acceptBy ~= 0  and not acceptMultiple then 
            ms_messageTaxi(source, 'This mission is already under way')
        else
            ms_exitMission(source)
            if #sMission.acceptBy >= 1 then
                if sMission.acceptBy[1] ~= source then
                    for _, m in pairs(sMission.acceptBy) do
                        ms_messageTaxi(m, 'You are several people responding')
                    end
                    table.insert(sMission.acceptBy, source)
                end
            else
                table.insert(sMission.acceptBy, source)
                ms_messageClient(sMission.id, 'Your call has been accepted, a taximan is on the way')
                ms_messageTaxi(source, 'Mission accepted, get started')
            end
            TriggerClientEvent('taxi:acceptMission', source, sMission)
            ms_setCallstatus(missionId, callstatus.accepted)
            ms_setTaxiBusy(source)
            ms_setMission()
            ms_updateTaxis()
        end
    end

    function ms_exitMission(personnelId)
        for _, mission in pairs(availableMissions) do 
            for k, v in pairs(mission.acceptBy) do 
                if v == personnelId then
                    table.remove(mission.acceptBy, k)
                    if #mission.acceptBy == 0 then
                        ms_messageClient(mission.id, 'The taximan has abandoned your call')
                        TriggerClientEvent('taxi:callStatus', mission.id, 2)
                        ms_setCallstatus(mission.id, callstatus.onHold)
                        ms_messageTaxis('A new alert has been posted, it has been added to your list of missions')
                    end
                    break
                end
            end
        end
        ms_removeTaxi(personnelId)
        ms_updateTaxis()
    end

    function ms_cancelMissionclient(clientId)
        if availableMissions[clientId] ~= nil then
            for _, v in pairs(availableMissions[clientId].acceptBy) do 
                ms_messageTaxi(v, 'the call has been canceled')
                ms_cancelMission(v)
                ms_setTaxiAvailable(v)
            end
            availableMissions[clientId] = nil
            ms_setCallstatus(clientId, callstatus.none)
            ms_setMission()
            ms_updateTaxis()
        end
    end

    function ms_addTaxi(source)
        activeTaxis[source] = false
    end
    
    function ms_removeTaxi(source)
        activeTaxis[source] = nil
    end

    function ms_setTaxiBusy(source)
        activeTaxis[source] = true        
    end

    function ms_setTaxiAvailable(source)
        activeTaxis[source] = false
    end

    function ms_getAllTaxis()
        local count = 0
        for _, v in pairs(activeTaxis) do 
            count = count + 1
        end
        return count
    end

    function ms_getAvailableTaxis()
        local count = 0
        for _, v in pairs(activeTaxis) do 
            if v == false then
                count = count + 1
            end
        end
        return count
    end

    function ms_getBusyTaxis()
        local count = 0
        for _, v in pairs(activeTaxis) do 
            if v == true then
                count = count + 1
            end
        end
        return count
    end


    RegisterServerEvent('taxi:takeService')
    AddEventHandler('taxi:takeService', function ()
        ms_addTaxi(source)
        ms_updateTaxis()
    end)

    RegisterServerEvent('taxi:breakService')
    AddEventHandler('taxi:breakService', function ()
        ms_exitMission(source)
        ms_removeTaxi(source)
    end)

    RegisterServerEvent('taxi:requestMission')
    AddEventHandler('taxi:requestMission', function ()
        ms_setMission(source)
    end)

    RegisterServerEvent('taxi:getactiveTaxis')
    AddEventHandler('taxi:getactiveTaxis', function ()
        ms_updateTaxis(source)
    end)

    RegisterServerEvent('taxi:Call')
    AddEventHandler('taxi:Call',function(posX,posY,posZ,type)
        ms_addMission(source, {posX, posY, posZ}, type)
    end)

    RegisterServerEvent('taxi:CallCancel')
    AddEventHandler('taxi:CallCancel', function ()
        ms_cancelMissionclient(source)
    end)

    RegisterServerEvent('taxi:acceptMission')
    AddEventHandler('taxi:acceptMission', function (id)
        ms_acceptMission(source, id)
    end)

    RegisterServerEvent('taxi:finishMission')
    AddEventHandler('taxi:finishMission', function (id)
        ms_closeMission(source, id)
    end)

    RegisterServerEvent('taxi:cancelCall')
    AddEventHandler('taxi:cancelCall', function ()
        ms_cancelMissionclient(source)
    end)

    AddEventHandler('playerDropped', function()
        ms_exitMission(source)
        ms_cancelMissionclient(source)
    end)
end

activateTaxiSystem()