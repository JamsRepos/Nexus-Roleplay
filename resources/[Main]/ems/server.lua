local inServiceEMS = {}

RegisterServerEvent('ems:duty')
AddEventHandler('ems:duty', function(status)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  user.setOnDuty(status)
 end)
end)

RegisterServerEvent('ems:revive')
AddEventHandler('ems:revive', function(target)
  TriggerClientEvent('ems:revive', target)
  ms_cancelMissionclient(source)
end)

RegisterServerEvent('ems:administerDrug')
AddEventHandler('ems:administerDrug', function(t)
 TriggerClientEvent('ems:drug:anastetic', t)
end)


RegisterServerEvent('ems:administerDDrug')
AddEventHandler('ems:administerDDrug', function(t)
 TriggerClientEvent('ems:drug:morphine', t)
end)


RegisterServerEvent('ems:damage')
AddEventHandler('ems:damage', function(target)
 local source = tonumber(source)
 TriggerClientEvent("ems:damage", source, target)
end)

RegisterServerEvent('ems:panic')
AddEventHandler('ems:panic', function(x, y, z)
 local source = tonumber(source)
 TriggerClientEvent('ems:panic', -1, x, y, z)
 TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Panic Button Triggered All Officer's Alerted"})
end)

RegisterServerEvent('medical:additems')
AddEventHandler('medical:additems', function(item, name, qty, metadata)
    print("add")
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  canGive = user.isAbleToGive(item,qty,metadata)
  if canGive then
   user.removeQuantity(item,qty,metadata)
    exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_inventorys` (unique_id, item, name, qty, meta) VALUES (@unique_id,@itemid,@item,@qty, @meta) ON DUPLICATE KEY UPDATE qty=qty+@qty',{['@unique_id'] = 'medical', ['@qty'] = qty, ['@item'] = name, ['@itemid'] = item, ['@meta'] = metadata})
    TriggerEvent('medical:refresh', source, id)
    TriggerEvent("core:log", tostring("[MEDICAL] "..GetPlayerName(source).."("..source..") put "..qty.."x "..name.."("..item..") into the medical cabinet."), "item")
  end
 end)
end)

RegisterServerEvent('medical:getInventory')
AddEventHandler('medical:getInventory', function()
    print("get inven")
 local source = tonumber(source)
 local storageitems = {}
 local totalResult = 0
 local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `stored_inventorys` WHERE unique_id=@unique_id",{['@unique_id'] = 'medical'}) 
 for _,v in pairs(result) do
  table.insert(storageitems, { name = v.name, item = v.item, q = v.qty, meta = v.meta})
  totalResult = totalResult + v.qty
 end
 TriggerClientEvent('medical:updateitems', source, storageitems, totalResult)
 TriggerClientEvent("medical:openInventory", source)
end)

RegisterServerEvent('medical:wipeInventory')
AddEventHandler('medical:wipeInventory', function(rctruck, gunkit)
    local source = tonumber(source)
    TriggerEvent('core:getPlayerFromId', source, function(user)
        user.wipeInventory()
        user.removeMoney(user.getMoney())
        user.removeDirtyMoney(user.getDirtyMoney())
    end)
    TriggerClientEvent("medical:giveWhitelisted", source, rctruck, gunkit)
end)


RegisterServerEvent('medical:refresh')
AddEventHandler('medical:refresh', function(source, id)
 local source = tonumber(source)
 local storageitems = {}
 local totalResult = 0
 local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `stored_inventorys` WHERE unique_id=@unique_id",{['@unique_id'] = 'medical'}) 
 for _,v in pairs(result) do
  table.insert(storageitems, {id = v.id, name = v.name, item = v.item, q = v.qty, meta = v.meta})
  totalResult = totalResult + v.qty
 end
 TriggerClientEvent('medical:updateitems', source, storageitems, totalResult)
end)

RegisterServerEvent('medical:removeitems')
AddEventHandler('medical:removeitems', function(item, name, qty, meta)
    print("remove")
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  local canGet = user.isAbleToReceive(qty)
  if not canGet then
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = "Inventory Full"})
  else
   user.addQuantity(item,qty, meta)
   --exports['GHMattiMySQL']:QueryAsync('UPDATE `stored_inventorys` SET `qty`= `qty` - @qty WHERE `unique_id` = @unique_id AND `item`= @item and `meta` = @meta',{['@unique_id'] = 'medical', ['@qty'] = qty, ['@item'] = item, ['@meta'] = meta})
   TriggerEvent('medical:refresh', source, id)
   TriggerEvent("core:log", tostring("[MEDICAL] "..GetPlayerName(source).."("..source..") took "..qty.."x "..name.."("..item..") from the medical cabinet."), "item")
  end
 end)
end)

TriggerEvent('core:addGroupCommand', 'revive', 'helper', function(source, args, user)
 if args[2] ~= nil then
  TriggerClientEvent('ems:revive', tonumber(args[2]))
 else
  TriggerClientEvent('ems:revive', source)
 end
end)

TriggerEvent('core:addGroupCommand', 'heal', 'helper', function(source, args, user)
 if args[2] ~= nil then
  TriggerClientEvent('ems:heal', tonumber(args[2]))
  TriggerClientEvent('hud:varibles', tonumber(args[2]), {hunger = 100, thirst = 100})
 else
  TriggerClientEvent('ems:heal', source)
  TriggerClientEvent('hud:varibles', source, {hunger = 100, thirst = 100}) 
 end
end)

function activateMissionSystem()
    local availableMissions = {}
    local activeMedics = {}
    local acceptMultiple = true
    local callstatus = {
        onHold = 2,
        accepted = 1,
        none = 0,
    }

    function ms_setMission(target)
        target = target or -1
        TriggerClientEvent('paramedic:changeMission', target, availableMissions)
    end

    function ms_cancelMission(source)
        TriggerClientEvent('paramedic:cancelMission', source)
    end

    function ms_updateMedics(target)
        target = target or -1
        TriggerClientEvent('paramedic:updateactiveMedics', target,  ms_getAllMedics(), ms_getAvailableMedics())
     end

    function ms_messageMedics(msg)
        TriggerClientEvent('paramedic:notifyallMedics', -1, msg)
    end

    function ms_messageMedic(source, msg)
        TriggerClientEvent('paramedic:notifyallMedics', source, msg)
    end

    function ms_messageClient(source, msg)
        TriggerClientEvent('paramedic:notifyClient', source, msg)
    end

    function ms_messageClients(msg)
        TriggerClientEvent('paramedic:notifyClient', -1 , msg)
    end

    function ms_setCallstatus(source, status)
        TriggerClientEvent('paramedic:callStatus', source, status)
    end

    function ms_addMission(source, position, reason)
        local sMission = availableMissions[source]
        local sourcePlayer = source
        local character = exports['core']:GetActiveCharacter(sourcePlayer)
        if sMission == nil then
            availableMissions[sourcePlayer] = {
                id = sourcePlayer,
                name = character.firstname.." "..character.lastname,
                pos = position,
                acceptBy = {},
                type = reason
            }
            ms_messageClient(sourcePlayer, 'Confirmation\nYour call has been registered')
            ms_setCallstatus(sourcePlayer, callstatus.onHold)
            ms_messageMedics('A new alert has been posted, it has been added to your list of missions')
            ms_setMission()
        else
            ms_messageClient(sourcePlayer, 'You Call Is Already In Our System, There Are Currently '..#availableMissions[sourcePlayer].acceptBy.." Unit/s Responding")
        end
    end

    function ms_closeMission(source, missionId)
        if availableMissions[missionId] ~= nil then
            for _, v in pairs(availableMissions[missionId].acceptBy) do 
                if v ~= source then
                    ms_messageMedic(v, 'Your customer has canceled')
                    ms_cancelMission(v)
                end
                ms_setMedicAvailable(v)
            end
            availableMissions[missionId] = nil
            ms_messageClient(missionId, 'Your call has been resolved')
            ms_setCallstatus(missionId, callstatus.none)
            ms_setMission()
            ms_updateMedics()
        end
    end

    function ms_acceptMission(source, missionId)
        local sMission = availableMissions[missionId]
        if sMission == nil then
            ms_messageMedic(source,'The mission is no longer current')
        elseif #sMission.acceptBy ~= 0  and not acceptMultiple then 
            ms_messageMedic(source, 'This mission is already under way')
        else
            ms_exitMission(source)
            if #sMission.acceptBy >= 1 then
                if sMission.acceptBy[1] ~= source then
                    for _, m in pairs(sMission.acceptBy) do
                        ms_messageMedic(m, 'You are several on the spot')
                    end
                    table.insert(sMission.acceptBy, source)
                end
            else
                table.insert(sMission.acceptBy, source)
                ms_messageClient(sMission.id, 'Your call has been accepted, a Paramedic is on the way')
                ms_messageMedic(source, 'Mission accepted, get started')
            end
            TriggerClientEvent('paramedic:acceptMission', source, sMission)
            ms_setCallstatus(missionId, callstatus.accepted)
            ms_setMedicBusy(source)
            ms_setMission()
            ms_updateMedics()
        end
    end

    function ms_exitMission(personnelId)
        for _, mission in pairs(availableMissions) do 
            for k, v in pairs(mission.acceptBy) do 
                if v == personnelId then
                    table.remove(mission.acceptBy, k)
                    if #mission.acceptBy == 0 then
                        ms_messageClient(mission.id, 'The paramedic has just abandoned your call')
                        TriggerClientEvent('paramedic:callStatus', mission.id, 2)
                        ms_setCallstatus(mission.id, callstatus.onHold)
                        ms_messageMedics('A new alert has been posted, it has been added to your list of missions')
                    end
                    break
                end
            end
        end
        ms_removeMedic(personnelId)
        ms_updateMedics()
    end

    function ms_cancelMissionclient(clientId)
        if availableMissions[clientId] ~= nil then
            for _, v in pairs(availableMissions[clientId].acceptBy) do 
                ms_messageMedic(v, 'Your customer has canceled')
                ms_cancelMission(v)
                ms_setMedicAvailable(v)
            end
            availableMissions[clientId] = nil
            ms_setCallstatus(clientId, callstatus.none)
            ms_setMission()
            ms_updateMedics()
        end
    end

    function ms_addMedic(source)
        activeMedics[source] = false
    end
    
    function ms_removeMedic(source)
        activeMedics[source] = nil
    end

    function ms_setMedicBusy(source)
        activeMedics[source] = true        
    end

    function ms_setMedicAvailable(source)
        activeMedics[source] = false
    end

    function ms_getAllMedics()
        local count = 0
        for _, v in pairs(activeMedics) do 
            count = count + 1
        end
        return count
    end

    function ms_getAvailableMedics()
        local count = 0
        for _, v in pairs(activeMedics) do 
            if v == false then
                count = count + 1
            end
        end
        return count
    end

    function ms_getBusyMedics()
        local count = 0
        for _, v in pairs(activeMedics) do 
            if v == true then
                count = count + 1
            end
        end
        return count
    end


    RegisterServerEvent('paramedic:takeService')
    AddEventHandler('paramedic:takeService', function ()
        ms_addMedic(source)
        ms_updateMedics()
    end)

    RegisterServerEvent('paramedic:breakService')
    AddEventHandler('paramedic:breakService', function ()
        ms_exitMission(source)
        ms_removeMedic(source)
    end)

    RegisterServerEvent('paramedic:requestMission')
    AddEventHandler('paramedic:requestMission', function()
        ms_setMission(source)
    end)

    RegisterServerEvent('paramedic:getactiveMedics')
    AddEventHandler('paramedic:getactiveMedics', function()
        ms_updateMedics(source)
    end)

    RegisterServerEvent('paramedic:Call')
    AddEventHandler('paramedic:Call',function(posX,posY,posZ,type)
        ms_addMission(source, {posX, posY, posZ}, type)
    end)

    RegisterServerEvent('paramedic:CallCancel')
    AddEventHandler('paramedic:CallCancel', function()
        ms_cancelMissionclient(source)
    end)

    RegisterServerEvent('paramedic:acceptMission')
    AddEventHandler('paramedic:acceptMission', function(id)
        ms_acceptMission(source, id)
    end)

    RegisterServerEvent('paramedic:finishMission')
    AddEventHandler('paramedic:finishMission', function(id)
        ms_closeMission(source, id)
    end)

    RegisterServerEvent('paramedic:cancelCall')
    AddEventHandler('paramedic:cancelCall', function()
        ms_cancelMissionclient(source)
    end)

    AddEventHandler('playerDropped', function()
        ms_exitMission(source)
        ms_cancelMissionclient(source)
    end)
end

function getPlayerID(source)
    local identifiers = GetPlayerIdentifiers(source)
    local player = getIdentifiant(identifiers)
    return player
end

function getIdentifiant(id)
    for _, v in ipairs(id) do
        return v
    end
end

RegisterServerEvent('ems:purchase')
AddEventHandler('ems:purchase', function(label, price, qty, item)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  if user.getMoney() >= price then
   if item ~= 911 then
    local canGet = user.isAbleToReceive(qty)
    if canGet then
     user.addQuantity(item,qty)
     user.removeMoney(price)
     TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Given "..qty.."x "..label, timeout=1000})
    else
     TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text =  'Inventory Full'})
    end
   end
  else
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Insufficient Funds"}) 
  end
 end)
end)

local bed1 = 0
local bed2 = 0
local bed3 = 0
local bed4 = 0
local bed5 = 0

RegisterServerEvent('ems:setBedStatus')
AddEventHandler('ems:setBedStatus', function(id)
 if id == 1 then
  bed1 = 0
 elseif id == 2 then
  bed2 = 0
 elseif id == 3 then
  bed3 = 0
 elseif id == 4 then
  bed4 = 0
 elseif id == 4 then
  bed4 = 0
 end
end)

RegisterServerEvent('ems:freeBeds')
AddEventHandler('ems:freeBeds', function()
 local source = tonumber(source)
 if bed1 == 0 then
  TriggerClientEvent('ems:setFreeBed', source, 1)
  bed1 = 1
 elseif bed2 == 0 then
  TriggerClientEvent('ems:setFreeBed', source, 2)
  bed2 = 1
 elseif bed3 == 0 then
  TriggerClientEvent('ems:setFreeBed', source, 3)
  bed3 = 1
 elseif bed4 == 0 then
  TriggerClientEvent('ems:setFreeBed', source, 4)
  bed4 = 1
 elseif bed5 == 0 then
  TriggerClientEvent('ems:setFreeBed', source, 5)
  bed4 = 1
 else
  TriggerClientEvent('ems:setFreeBed', source, 100)
 end
end)

activateMissionSystem()
