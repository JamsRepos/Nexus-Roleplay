local dispatchStatus = {}

RegisterServerEvent('police:prisontrans')
AddEventHandler('police:prisontrans', function(t)
 TriggerClientEvent('police:prisontrans', t)
end)


TriggerEvent('core:addGroupCommand', 'setchief', 'user', function(source, args, user) 
    local player = tonumber(args[2])
    local source = tonumber(source)
    TriggerEvent('core:getPlayerFromId', source, function(user)
        TriggerEvent('core:getPlayerFromId', player, function(targ)
      if user.getJob() == 1 then
        user.setJob(1)
        TriggerClientEvent('NRP-notify:client:SendAlert', player, { type = 'inform', text = "Your Job Has Been Set To ".. user.getJobName(jobid), duration= 10000})
        TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Job Set to Police Chief!", duration= 10000})
      end 
    end)
    end)
end)

TriggerEvent('core:addGroupCommand', 'setcadet', 'user', function(source, args, user)
    local player = tonumber(args[2])
    local source = tonumber(source)
    TriggerEvent('core:getPlayerFromId', player, function(user)
      if user.getJob() == 1 then
        user.setJob(31)
        TriggerClientEvent('NRP-notify:client:SendAlert', player, { type = 'inform', text = "Your Job Has Been Set To ".. user.getJobName(jobid), duration= 10000})
        TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Job Set to Police Cadet ", duration= 10000})
      end  
    end)
end)

TriggerEvent('core:addGroupCommand', 'setpatrol', 'user', function(source, args, user)
    local player = tonumber(args[2])
    local source = tonumber(source)
    TriggerEvent('core:getPlayerFromId', player, function(user)
      if user.getJob() == 1 then  
        user.setJob(32)
        TriggerClientEvent('NRP-notify:client:SendAlert', player, { type = 'inform', text = "Your Job Has Been Set To ".. user.getJobName(jobid), duration= 10000})
        TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Job Set to Police Patrol Officer ", duration= 10000})
      end 
    end)
end)

TriggerEvent('core:addGroupCommand', 'setsenior', 'user', function(source, args, user)
    local player = tonumber(args[2])
    local source = tonumber(source)
    TriggerEvent('core:getPlayerFromId', player, function(user)
      if user.getJob() == 1 then
        user.setJob(33)
        TriggerClientEvent('NRP-notify:client:SendAlert', player, { type = 'inform', text = "Your Job Has Been Set To ".. user.getJobName(jobid), duration= 10000})
        TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Job Set to Police Senior Officer ", duration= 10000})
      end  
    end)
end)

TriggerEvent('core:addGroupCommand', 'setserg', 'user', function(source, args, user)
    local player = tonumber(args[2])
    local source = tonumber(source)
    TriggerEvent('core:getPlayerFromId', player, function(user)
      if user.getJob() == 1 then
        user.setJob(34)
        TriggerClientEvent('NRP-notify:client:SendAlert', player, { type = 'inform', text = "Your Job Has Been Set To ".. user.getJobName(jobid), duration= 10000})
        TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Job Set to Police Sergeant ", duration= 10000})
      end 
    end)
end)

TriggerEvent('core:addGroupCommand', 'setlieut', 'user', function(source, args, user)
    local player = tonumber(args[2])
    local source = tonumber(source)
    TriggerEvent('core:getPlayerFromId', player, function(user)
      if user.getJob() == 1 then
        user.setJob(35)
        TriggerClientEvent('NRP-notify:client:SendAlert', player, { type = 'inform', text = "Your Job Has Been Set To ".. user.getJobName(jobid), duration= 10000})
        TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Job Set to Police Lieutenant ", duration= 10000})
      end 
    end)
end)

TriggerEvent('core:addGroupCommand', 'setcapt', 'user', function(source, args, user)
    local player = tonumber(args[2])
    local source = tonumber(source)
    TriggerEvent('core:getPlayerFromId', player, function(user)
      if user.getJob() == 1 then
        user.setJob(36)
        TriggerClientEvent('NRP-notify:client:SendAlert', player, { type = 'inform', text = "Your Job Has Been Set To ".. user.getJobName(jobid), duration= 10000})
        TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Job Set to Police Captain ", duration= 10000})
      end 
    end)
end)

TriggerEvent('core:addGroupCommand', 'setdetective', 'user', function(source, args, user)
    local player = tonumber(args[2])
    local source = tonumber(source)
    TriggerEvent('core:getPlayerFromId', player, function(user)
      if user.getJob() == 1 then
        user.setJob(18)
        TriggerClientEvent('NRP-notify:client:SendAlert', player, { type = 'inform', text = "Your Job Has Been Set To ".. user.getJobName(jobid), duration= 10000})
        TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Job Set to Police Detective ", duration= 10000})
      end 
    end)
end)

TriggerEvent('core:addGroupCommand', 'setdept', 'user', function(source, args, user)
    local player = tonumber(args[2])
    local source = tonumber(source)
    TriggerEvent('core:getPlayerFromId', player, function(user)
      if user.getJob() == 1 then
        user.setJob(37)
        TriggerClientEvent('NRP-notify:client:SendAlert', player, { type = 'inform', text = "Your Job Has Been Set To ".. user.getJobName(jobid), duration= 10000})
        TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Job Set to Police Deputy Chief ", duration= 10000})
      end
    end)
end)

TriggerEvent('core:addGroupCommand', 'setems', 'helper', function(source, args, user)
    local player = tonumber(args[2])
    local source = tonumber(source)
    TriggerEvent('core:getPlayerFromId', player, function(user)
        user.setJob(2)
        TriggerClientEvent('NRP-notify:client:SendAlert', player, { type = 'inform', text = "Your Job Has Been Set To ".. user.getJobName(jobid), duration= 10000})
        TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Job Set to EMS", duration= 10000})
    end)
end)

RegisterServerEvent('police:vehiclein')
AddEventHandler('police:vehiclein', function(target)
 TriggerClientEvent('police:vehiclein', target)
end)

RegisterServerEvent('police:vehicleout')
AddEventHandler('police:vehicleout', function(target)
 TriggerClientEvent('police:vehicleout', target)
end)

RegisterServerEvent('police:duty')
AddEventHandler('police:duty', function(status)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  user.setOnDuty(status)
 end)
end)

RegisterServerEvent('sirenStatus')
AddEventHandler('sirenStatus', function(status, vehicle)
 TriggerClientEvent('sirenStatus', -1, status, vehicle)
end)

RegisterServerEvent('police:drag')
AddEventHandler('police:drag', function(target)
  local _source = source
  TriggerClientEvent('police:drag', target, _source)
end)

RegisterServerEvent('police:handcuff')
AddEventHandler('police:handcuff', function(t)
 TriggerClientEvent('police:handcuff', t)
end)

RegisterServerEvent('police:handcuff:toggle')
AddEventHandler('police:handcuff:toggle', function(t, status)
 TriggerClientEvent('police:handcuff:toggle', t, status)
end)

RegisterServerEvent('police:hardcuff')
AddEventHandler('police:hardcuff', function(t)
 TriggerClientEvent('police:hardcuff', t)
end)

RegisterServerEvent('police:triggerpanic')
AddEventHandler('police:triggerpanic', function(x,y,z)
 TriggerClientEvent('police:panic', -1,x,y,z)
 TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Panic Button Triggered All Officer's Alerted"})
end)

RegisterServerEvent('ss:triggerpanic')
AddEventHandler('ss:triggerpanic', function(x,y,z)
 TriggerClientEvent('ss:panic', -1,x,y,z)
 TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Panic Button Triggered All Officer's Alerted"})
end)

RegisterServerEvent('police:1020')
AddEventHandler('police:1020', function(x,y,z)
 TriggerClientEvent('police:11020', -1,x,y,z)
 TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "You have Dropped Your 10-20"})
end)

RegisterServerEvent('police:targetCheckInventory')
AddEventHandler('police:targetCheckInventory', function(target)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', target, function(user)
  local inventory = user.getInventory()
  local strResult = "Items of " .. user.getIdentity().fullname .. " : "
                
  for _, v in ipairs(inventory) do
   if(v.q > 0) then
    strResult = strResult .. v.name .. " - " .. v.q .. ", "
   end                 
  end
  
  local probs = "Items of " .. user.getIdentity().fullname .. " : "
  if strResult == probs then
   strResult = user.getIdentity().fullname.." has no items"
  end
  TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = strResult , duration=20000})
  TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = user.getIdentity().fullname.." has $"..user.getDirtyMoney().."in dirty money!"})
  TriggerClientEvent('NRP-notify:client:SendAlert', target, { type = 'inform', text = "you are being searched for illegal goods!"})
 end)
end)

TriggerEvent('core:addGroupCommand', 'getid', "user", function(source, args, user)
 local player = tonumber(args[2])
 TriggerEvent("core:getPlayerFromId", source, function(user)
  TriggerEvent("core:getPlayerFromId", player, function(target)
    if user.getJob() == 1 or user.getJob() == 32 or user.getJob() == 33 or user.getJob() == 34 or user.getJob() == 35 or user.getJob() == 36 or user.getJob() == 37  or user.getJob() == 90 or user.getJob() == 91 then
  TriggerClientEvent("fs_freemode:notify", source, 'CHAR_MULTIPLAYER' , 4, 2, "ID Card", false, 'Name: '..target.getIdentity().fullname..'~n~ DOB: '..target.getIdentity().dob..'~n~Gender: '..user.getIdentity().gender..'~n~Job: '..target.getJobName())
   end
  end)
 end)
end)

RegisterServerEvent('police:targetSeizeInventory')
AddEventHandler('police:targetSeizeInventory', function(target)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', target, function(user)
  local inventory = user.getInventory()
  for _, v in ipairs(inventory) do
   item = user.isItemIllegal(v.id)
   if item then
    user.removeQuantity(v.id, v.q)
   end
  end
  TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = user.getIdentity().fullname.."'s illegal items have been seized"})
  TriggerClientEvent('NRP-notify:client:SendAlert', target, { type = 'inform', text = "Your illegal items have been seized"})
  user.setDirtyMoney(0)
  TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = user.getIdentity().fullname.."'s dirty money has been seized"})
  TriggerClientEvent('NRP-notify:client:SendAlert', target, { type = 'inform', text = "Your dirty money has been seized"})
 end)
end)

--Check the players guns
RegisterServerEvent('police:targetCheckGuns')
AddEventHandler('police:targetCheckGuns', function(target)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', target, function(user)
  local weapons = user.getWeapons()
  local strResult = "Weapons of " .. user.getIdentity().fullname.. " : "
  for _, v in ipairs(weapons) do
   if v.blackmarket == 1 then
    strResult = strResult .. v.name .." | Scratched Off, "
   else
    strResult = strResult .. v.name .." | WSN"..v.id..", "
   end
  end
  local probs = "Weapons of " .. user.getIdentity().fullname.. " : "
  if strResult == probs then
   strResult = user.getIdentity().fullname.." has no weapons"
  end
  TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = strResult})
  TriggerClientEvent('NRP-notify:client:SendAlert', target, { type =  "you are being searched for weapons!"})
 end)
end)

--Remove a players weapons
RegisterServerEvent('police:byebyeweapons')
AddEventHandler('police:byebyeweapons', function(target)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', target, function(user)
  user.removeAllWeapons()
  TriggerClientEvent('NRP-notify:client:SendAlert', target, { type = 'inform', text = "Your weapons have been confiscated!"})  
  TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Players weapons have been removed!"})
  TriggerClientEvent("police:byebyeweapons", target)
 end)
end)

-- Save & Load Police Uniforms
RegisterServerEvent("police:loadclothing")
AddEventHandler("police:loadclothing", function()
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  local data = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `police_uniforms` WHERE char_id=@char_id",{['@char_id'] = user.getCharacterID()})
  local main = json.decode(data[1].clothing)
  if main ~= nil then
   if main.model == "mp_m_freemode_01" or main.model == "mp_f_freemode_01" then 
    TriggerClientEvent("police:changempmodel", source, main)
   else
    TriggerClientEvent("police:changemodel", source, main)
   end
  else
   TriggerClientEvent("police:nomodel", source)
  end
 end)
end)

RegisterServerEvent("police:saveclothing")
AddEventHandler("police:saveclothing",function(model, d, t)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
    local data = {}
    data.model = model
    data.d1 = d.head
    data.d2 = d.mask
    data.d3 = d.hair
    data.d4 = d.hand
    data.d5 = d.pants
    data.d6 = d.gloves
    data.d7 = d.shoes
    data.d8 = d.eyes
    data.d9 = d.accessories
    data.d10 = d.items
    data.d11 = d.decals
    data.d12 = d.shirts
    data.a13 = d.helmet
    data.a14 = d.glasses
    data.a15 = d.earrings
    data.f16 = d.beard
    data.f17 = d.eyebrow
    data.f18 = d.makeup
    data.f19 = d.lipstick
    data.t1 = t.head
    data.t2 = t.mask
    data.t3 = t.hair
    data.t4 = t.hand
    data.t5 = t.pants
    data.t6 = t.gloves
    data.t7 = t.shoes
    data.t8 = t.eyes
    data.t9 = t.accessories
    data.t10 = t.items
    data.t11 = t.decals
    data.t12 = t.shirts
    data.ta13 = t.helmet
    data.ta14 = t.glasses
    data.ta15 = t.earrings
    exports['GHMattiMySQL']:QueryAsync('INSERT INTO `police_uniforms` (char_id, clothing) VALUES (@char_id, @clothing) ON DUPLICATE KEY UPDATE clothing=@clothing',{['@char_id'] = user.getCharacterID(), ['@clothing'] = json.encode(data)})
 end)
end)

function activateMissionSystem()
    local availableMissions = {}
    local activeCops = {}
    local acceptMultiple = true
    local callstatus = {
        onHold = 2,
        accepted = 1,
        none = 0,
    }

    function ms_setMission(target)
        target = target or -1
        TriggerClientEvent('police:changeMission', target, availableMissions)
    end

    function ms_cancelMission(source)
        TriggerClientEvent('police:cancelMission', source)
    end

    function ms_updateCops(target)
        target = target or -1
        TriggerClientEvent('police:updateactiveCops', target,  ms_getAllCops(), ms_getAvailableCops())
     end

    function ms_messageCops(msg)
        TriggerClientEvent('police:notifyallCops', -1, msg)
    end

    function ms_messageCop(source, msg)
        TriggerClientEvent('police:notifyallCops', source, msg)
    end

    function ms_messageClient(source, msg)
        TriggerClientEvent('police:notifyClient', source, msg)
    end

    function ms_messageClients(msg)
        TriggerClientEvent('police:notifyClient', -1 , msg)
    end

    function ms_setCallstatus(source, status)
        TriggerClientEvent('police:callStatus', source, status)
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
            ms_messageCops('A new alert has been posted, it has been added to your list of missions')
            ms_setMission()
        end
    end

    function ms_closeMission(source, missionId)
        if availableMissions[missionId] ~= nil then
            for _, v in pairs(availableMissions[missionId].acceptBy) do 
                if v ~= source then
                    ms_messageCop(v, 'Your customer has canceled')
                    ms_cancelMission(v)
                end
                ms_setCopAvailable(v)
            end
            availableMissions[missionId] = nil
            ms_messageClient(missionId, 'Your call has been resolved')
            ms_setCallstatus(missionId, callstatus.none)
            ms_setMission()
            ms_updateCops()
        end
    end

    function ms_acceptMission(source, missionId)
        local sMission = availableMissions[missionId]
        if sMission == nil then
            ms_messageCop(source,'The mission is no longer available')
        elseif #sMission.acceptBy ~= 0  and not acceptMultiple then 
            ms_messageCop(source, 'This mission is already under way')
        else
            ms_exitMission(source)
            if #sMission.acceptBy >= 1 then
                if sMission.acceptBy[1] ~= source then
                    for _, m in pairs(sMission.acceptBy) do
                        ms_messageCop(m, 'You are several units responding')
                    end
                    table.insert(sMission.acceptBy, source)
                end
            else
                table.insert(sMission.acceptBy, source)
                ms_messageClient(sMission.id, 'Your call has been accepted, a Policeman is on the way')
                ms_messageCop(source, 'Mission accepted, get started')
            end
            TriggerClientEvent('police:acceptMission', source, sMission)
            ms_setCallstatus(missionId, callstatus.accepted)
            ms_setCopBusy(source)
            ms_setMission()
            ms_updateCops()
        end
    end

    function ms_exitMission(personnelId)
        for _, mission in pairs(availableMissions) do 
            for k, v in pairs(mission.acceptBy) do 
                if v == personnelId then
                    table.remove(mission.acceptBy, k)
                    if #mission.acceptBy == 0 then
                        ms_messageClient(mission.id, 'The policeman has abandoned your call')
                        TriggerClientEvent('police:callStatus', mission.id, 2)
                        ms_setCallstatus(mission.id, callstatus.onHold)
                        ms_messageCops('A new alert has been posted, it has been added to your list of missions')
                    end
                    break
                end
            end
        end
        ms_removeCop(personnelId)
        ms_updateCops()
    end

    function ms_cancelMissionclient(clientId)
        if availableMissions[clientId] ~= nil then
            for _, v in pairs(availableMissions[clientId].acceptBy) do 
                ms_messageCop(v, 'the call has been canceled')
                ms_cancelMission(v)
                ms_setCopAvailable(v)
            end
            availableMissions[clientId] = nil
            ms_setCallstatus(clientId, callstatus.none)
            ms_setMission()
            ms_updateCops()
        end
    end

    function ms_addCop(source)
        activeCops[source] = false
    end
    
    function ms_removeCop(source)
        activeCops[source] = nil
    end

    function ms_setCopBusy(source)
        activeCops[source] = true        
    end

    function ms_setCopAvailable(source)
        activeCops[source] = false
    end

    function ms_getAllCops()
        local count = 0
        for _, v in pairs(activeCops) do 
            count = count + 1
        end
        return count
    end

    function ms_getAvailableCops()
        local count = 0
        for _, v in pairs(activeCops) do 
            if v == false then
                count = count + 1
            end
        end
        return count
    end

    function ms_getBusyCops()
        local count = 0
        for _, v in pairs(activeCops) do 
            if v == true then
                count = count + 1
            end
        end
        return count
    end


    RegisterServerEvent('police:takeService')
    AddEventHandler('police:takeService', function ()
        ms_addCop(source)
        ms_updateCops()
    end)

    RegisterServerEvent('police:breakService')
    AddEventHandler('police:breakService', function ()
        ms_exitMission(source)
        ms_removeCop(source)
    end)

    RegisterServerEvent('police:requestMission')
    AddEventHandler('police:requestMission', function ()
        ms_setMission(source)
    end)

    RegisterServerEvent('police:getactiveCops')
    AddEventHandler('police:getactiveCops', function ()
        ms_updateCops(source)
    end)

    RegisterServerEvent('police:Call')
    AddEventHandler('police:Call',function(posX,posY,posZ,type)
        ms_addMission(source, {posX, posY, posZ}, type)
    end)

    RegisterServerEvent('police:CallCancel')
    AddEventHandler('police:CallCancel', function ()
        ms_cancelMissionclient(source)
    end)

    RegisterServerEvent('police:acceptMission')
    AddEventHandler('police:acceptMission', function (id)
        ms_acceptMission(source, id)
    end)

    RegisterServerEvent('police:finishMission')
    AddEventHandler('police:finishMission', function (id)
        ms_closeMission(source, id)
    end)

    RegisterServerEvent('police:cancelCall')
    AddEventHandler('police:cancelCall', function ()
        ms_cancelMissionclient(source)
    end)

    AddEventHandler('playerDropped', function()
        ms_exitMission(source)
        ms_cancelMissionclient(source)
    end)
end

activateMissionSystem()


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

TriggerEvent('core:addGroupCommand', 'duty', 'user', function(source, args, user)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  local status = args[2]
  if user.getJob() == 1 or user.getJob() == 32 or user.getJob() == 33 or user.getJob() == 34 or user.getJob() == 35 or user.getJob() == 36 or user.getJob() == 37 or user.getJob() == 90 or user.getJob() == 91 then
   if status == '1' then
    TriggerClientEvent('police:dutystatus', source, 1)
   else
    TriggerClientEvent('police:dutystatus', source, 0)
   end
  elseif user.getJob() == 2 then
   if status == '1' then
    TriggerClientEvent('ems:dutystatus', source, 1)
   else
    TriggerClientEvent('ems:dutystatus', source, 0)
   end
  end
 end)
end)

TriggerEvent('core:addGroupCommand', 'runweapon', 'user', function(source, args, user)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  local gun = args[2]
  if user.getJob() == 1 or user.getJob() == 32 or user.getJob() == 33 or user.getJob() == 34 or user.getJob() == 35 or user.getJob() == 36 or user.getJob() == 37 or user.getJob() == 90 or user.getJob() == 91 then
   local owner = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `owned_weapons` WHERE id = @id", {['@id'] = gun})
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Weapon ("..owner[1].id..") is registered to: "..owner[1].owner})  
  end
 end)
end)

TriggerEvent('core:addGroupCommand', 'dutyveh', 'user', function(source, args, user)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  if user.getJob() == 1 or user.getJob() == 32 or user.getJob() == 33 or user.getJob() == 34 or user.getJob() == 35 or user.getJob() == 36 or user.getJob() == 37 or user.getJob() == 90 or user.getJob() == 91 then
   TriggerClientEvent('police:spawnbackup', source)
  elseif user.getJob() == 2 then
   TriggerClientEvent('ems:spawnbackup', source)
  end
 end)
end)

TriggerEvent('core:addGroupCommand', 'dutyboat', 'user', function(source, args, user)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  if user.getJob() == 1 or user.getJob() == 32 or user.getJob() == 33 or user.getJob() == 34 or user.getJob() == 35 or user.getJob() == 36 or user.getJob() == 37 or user.getJob() == 90 or user.getJob() == 91 then
   TriggerClientEvent('police:spawnboat', source)
  elseif user.getJob() == 2 then
   TriggerClientEvent('ems:spawnboat', source)
  end
 end)
end)

TriggerEvent('core:addGroupCommand', 'dispatch', 'user', function(source, args, user)
    TriggerEvent('core:getPlayerFromId', source, function(user)
        if user.getJob() == 1 or user.getJob() == 32 or user.getJob() == 33 or user.getJob() == 34 or user.getJob() == 35 or user.getJob() == 36 or user.getJob() == 37 or user.getJob() == 90 or user.getJob() == 91 then
            local status = nil
            if dispatchStatus[source] == true then
                dispatchStatus[source] = false
                status = "Off"
            else
                dispatchStatus[source] = true
                status = "On"
            end
            TriggerClientEvent('dispatch:toggle', source, dispatchStatus[source])
            TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Dispatch HUD: "..status.."."}) 
        end
    end)
end)

local firstnames = {[1] = 'Barb',[2] = 'Dick',[3] = 'Steve',[4] = 'Margie ',[5] = 'Sean',[6] = 'Jim',[7] = 'Robert',[8] = 'Erika',[9] = 'Laura',[10] = 'Isabel',[11] = 'Craig',[12] = 'Tommy',[13] = 'Greg',[14] = 'Ralph',[15] = 'Donald',[16] = 'Bruce',[17] = 'Jackie',[18] = 'Lee',[19] = 'Jane',[20] = 'Kate'}
local secondnames = {[1] = 'Miller',[2] = 'Walker',[3] = 'Henderson',[4] = 'Watson',[5] = 'Jones',[6] = 'King',[7] = 'Martin',[8] = 'Murphy',[9] = 'Edwards',[10] = 'Davis',[11] = 'Jenkins',[12] = 'Mallard',[13] = 'Gibbs',[14] = 'McGee',[15] = 'Palmer',[16] = 'DiNozzo',[17] = 'Todd',[18] = 'Bishop',[19] = 'Fornell',[20] = 'Marray'}

RegisterServerEvent('radar:check')
AddEventHandler('radar:check', function(radar, model, plate, mph)
 local source = tonumber(source)
 local insured = 'Insured'
 local res = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `dmv_records` WHERE plate = @plate", {['@plate'] = plate})
 if res[1] ~= nil then
  if res[1].insurance_due > '0' then 
   insured = 'Plan Suspended' 
  elseif res[1].insurance > '0' then 
   insured = 'Insured' 
  end
  TriggerClientEvent('chatMessage', source, tostring("^5"..radar..' | ^3'..model..' | '..plate..' | '..mph..' MPH | '..res[1].owner..' | '..insured))
 else
  TriggerClientEvent('chatMessage', source, tostring("^5"..radar..' | ^3'..model..' | '..plate..' | '..mph..' MPH | '..firstnames[math.random(1,20)].." "..secondnames[math.random(1,20)]..' | '..insured))
 end
end)

---------------------------------------------------------------------------
-- Spawn Spikestrip Command --
---------------------------------------------------------------------------
-- Spikestrips Configs --
SpikeConfig = {}
SpikeConfig.MaxSpikes = 2
---------------------------
RegisterCommand("setspikes", function(source, args, raw, user)
    local src = source
     TriggerEvent("core:getPlayerFromId", source, function(user)
    if user.getJob() == 1 or user.getJob() == 32 or user.getJob() == 33 or user.getJob() == 34 or user.getJob() == 35 or user.getJob() == 36 or user.getJob() == 37 or user.getJob() == 90 or user.getJob() == 91 then
    if(args[1] == nil) then
        args[1] = 2
    end
        
    if tonumber(args[1]) <= SpikeConfig.MaxSpikes then
        SpawnSpikestrips(src, args[1])
    end
end
end)
end)
function SpawnSpikestrips(src, amount)
    if SpikeConfig.IdentifierRestriction then
        local player_identifier = PlayerIdentifier(SpikeConfig.Identifier, src)
        for a = 1, #SpikeConfig.IdentifierList do
            if SpikeConfig.IdentifierList[a] == player_identifier then
                TriggerClientEvent("Spikes:SpawnSpikes", src, {amount = amount, isRestricted = SpikeConfig.PedRestriction, pedList = SpikeConfig.PedList})
                break
            end
        end
    else
        TriggerClientEvent("Spikes:SpawnSpikes", src, {amount = amount, isRestricted = SpikeConfig.PedRestriction, pedList = SpikeConfig.PedList})
    end
end

---------------------------------------------------------------------------
-- Delete Spikestrips --
---------------------------------------------------------------------------
RegisterServerEvent("Spikes:TriggerDeleteSpikes")
AddEventHandler("Spikes:TriggerDeleteSpikes", function(netid)
    TriggerClientEvent("Spikes:DeleteSpikes", -1, netid)
end)

---------------------------------------------------------------------------
-- Get Player Identifier --
---------------------------------------------------------------------------
function PlayerIdentifier(type, id)
    local identifiers = {}
    local numIdentifiers = GetNumPlayerIdentifiers(id)

    for a = 0, numIdentifiers do
        table.insert(identifiers, GetPlayerIdentifier(id, a))
    end

    for b = 1, #identifiers do
        if string.find(identifiers[b], type, 1) then
            return identifiers[b]
        end
    end
    return false
end

RegisterServerEvent('police:k9targetCheckInventory')
AddEventHandler('police:k9targetCheckInventory', function(target)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', target, function(user)
  local inventory = user.getInventory()
  local strResult = "Items of " .. user.getIdentity().fullname .. " : "
                
  for _, v in ipairs(inventory) do
   if(v.q > 0) then
    strResult = strResult .. v.name .. " - " .. v.q .. ", "
   end                 
  end
  
  local probs = "Items of " .. user.getIdentity().fullname .. " : "
  if strResult == probs then
   strResult = user.getIdentity().fullname.." has no items"
  end
  TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = strResult,duration = 20000})
  TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = user.getIdentity().fullname.." has <span style='color:lime'>$</span><span style='color:white'>"..user.getDirtyMoney().."</span> in dirty money!"})
  TriggerClientEvent('NRP-notify:client:SendAlert', target, { type = 'inform', text = "You notice the dog sniffing around you.."})
 end)
end)

RegisterServerEvent('police:k9targetCheckGuns')
AddEventHandler('police:k9targetCheckGuns', function(target)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', target, function(user)
  local weapons = user.getWeapons()
  local strResult = "Weapons of " .. user.getIdentity().fullname.. " : "
  for _, v in ipairs(weapons) do
   if v.blackmarket == 1 then
    strResult = strResult .. v.name .." | Scratched Off, "
   else
    strResult = strResult .. v.name .." | WSN"..v.id..", "
   end
  end
  local probs = "Weapons of " .. user.getIdentity().fullname.. " : "
  if strResult == probs then
   strResult = user.getIdentity().fullname.." has no weapons"
  end
  TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = strResult})
  TriggerClientEvent('NRP-notify:client:SendAlert', target, { type =  "You notice the dog sniffing around you.."})
 end)
end)

RegisterServerEvent('armoury:additems')
AddEventHandler('armoury:additems', function(item, name, qty, metadata)
    print("add")
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  canGive = user.isAbleToGive(item,qty,metadata)
  if canGive then
   user.removeQuantity(item,qty,metadata)
    exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_inventorys` (unique_id, item, name, qty, meta) VALUES (@unique_id,@itemid,@item,@qty, @meta) ON DUPLICATE KEY UPDATE qty=qty+@qty',{['@unique_id'] = 'armoury', ['@qty'] = qty, ['@item'] = name, ['@itemid'] = item, ['@meta'] = metadata})
    TriggerEvent('armoury:refresh', source, id)
    TriggerEvent("core:log", tostring("[ARMOURY] "..GetPlayerName(source).."("..source..") put "..qty.."x "..name.."("..item..") into the armoury."), "item")
  end
 end)
end)

RegisterServerEvent('armoury:getInventory')
AddEventHandler('armoury:getInventory', function()
    print("get inven")
 local source = tonumber(source)
 local storageitems = {}
 local totalResult = 0
 local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `stored_inventorys` WHERE unique_id=@unique_id",{['@unique_id'] = 'armoury'}) 
 for _,v in pairs(result) do
  table.insert(storageitems, { name = v.name, item = v.item, q = v.qty, meta = v.meta})
  totalResult = totalResult + v.qty
 end
 TriggerClientEvent('armoury:updateitems', source, storageitems, totalResult)
 TriggerClientEvent("armoury:openInventory", source)
end)

RegisterServerEvent('armoury:refresh')
AddEventHandler('armoury:refresh', function(source, id)
 local source = tonumber(source)
 local storageitems = {}
 local totalResult = 0
 local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `stored_inventorys` WHERE unique_id=@unique_id",{['@unique_id'] = 'armoury'}) 
 for _,v in pairs(result) do
  table.insert(storageitems, {id = v.id, name = v.name, item = v.item, q = v.qty, meta = v.meta})
  totalResult = totalResult + v.qty
 end
 TriggerClientEvent('armoury:updateitems', source, storageitems, totalResult)
end)

RegisterServerEvent('armoury:removeitems')
AddEventHandler('armoury:removeitems', function(item, name, qty, meta)
    print("remove")
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  local canGet = user.isAbleToReceive(qty)
  if not canGet then
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = "Inventory Full"})
  else
   user.addQuantity(item,qty, meta)
   --exports['GHMattiMySQL']:QueryAsync('UPDATE `stored_inventorys` SET `qty`= `qty` - @qty WHERE `unique_id` = @unique_id AND `item`= @item and `meta` = @meta',{['@unique_id'] = 'armoury', ['@qty'] = qty, ['@item'] = item, ['@meta'] = meta})
   TriggerEvent('armoury:refresh', source, id)
   TriggerEvent("core:log", tostring("[ARMOURY] "..GetPlayerName(source).."("..source..") took "..qty.."x "..name.."("..item..") from the armoury."), "item")
  end
 end)
end)

RegisterServerEvent('evidence:additems')
AddEventHandler('evidence:additems', function(item, name, qty, metadata)
    print("add")
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  canGive = user.isAbleToGive(item,qty,metadata)
  if canGive then
   user.removeQuantity(item,qty,metadata)
    exports['GHMattiMySQL']:QueryAsync('INSERT INTO `stored_inventorys` (unique_id, item, name, qty, meta) VALUES (@unique_id,@itemid,@item,@qty, @meta) ON DUPLICATE KEY UPDATE qty=qty+@qty',{['@unique_id'] = 'evidence', ['@qty'] = qty, ['@item'] = name, ['@itemid'] = item, ['@meta'] = metadata})
    TriggerEvent('evidence:refresh', source, id)
    TriggerEvent("core:log", tostring("[EVIDENCE] "..user.getIdentity().fullname.."("..source..") put "..qty.."x "..name.."("..item..") into the evidence locker."), "evidence")
  end
 end)
end)

RegisterServerEvent('evidence:getInventory')
AddEventHandler('evidence:getInventory', function()
    print("get inven")
 local source = tonumber(source)
 local storageitems = {}
 local totalResult = 0
 local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `stored_inventorys` WHERE unique_id=@unique_id",{['@unique_id'] = 'evidence'}) 
 for _,v in pairs(result) do
  table.insert(storageitems, { name = v.name, item = v.item, q = v.qty, meta = v.meta})
  totalResult = totalResult + v.qty
 end
 TriggerClientEvent('evidence:updateitems', source, storageitems, totalResult)
 TriggerClientEvent("evidence:openInventory", source)
end)

RegisterServerEvent('evidence:refresh')
AddEventHandler('evidence:refresh', function(source, id)
 local source = tonumber(source)
 local storageitems = {}
 local totalResult = 0
 local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `stored_inventorys` WHERE unique_id=@unique_id",{['@unique_id'] = 'evidence'}) 
 for _,v in pairs(result) do
  table.insert(storageitems, {id = v.id, name = v.name, item = v.item, q = v.qty, meta = v.meta})
  totalResult = totalResult + v.qty
 end
 TriggerClientEvent('evidence:updateitems', source, storageitems, totalResult)
end)

RegisterServerEvent('evidence:removeitems')
AddEventHandler('evidence:removeitems', function(item, name, qty, meta)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  local canGet = user.isAbleToReceive(qty)
  if not canGet then
   TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = "Inventory Full"})
  else
    if user.getJob() == 1 then
        user.addQuantity(item,qty, meta)
        exports['GHMattiMySQL']:QueryAsync('UPDATE `stored_inventorys` SET `qty`= `qty` - @qty WHERE `unique_id` = @unique_id AND `item`= @item and `meta` = @meta',{['@unique_id'] = 'evidence', ['@qty'] = qty, ['@item'] = item, ['@meta'] = meta})
        TriggerEvent('evidence:refresh', source, id)
        TriggerEvent("core:log", tostring("[EVIDENCE] "..user.getIdentity().fullname.."("..source..") took "..qty.."x "..name.."("..item..") from the evidence locker."), "evidence")
    else
        TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = "You are not the sufficient rank to do this."})
    end
  end
 end)
end)