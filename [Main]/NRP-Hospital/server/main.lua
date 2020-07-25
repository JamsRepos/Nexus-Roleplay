local beds = {
    { x = 309.356, y = -577.331, z = 44.2, h = 338.84, taken = false, model = 1631638868 },
    { x = 313.92, y = -579.12, z = 44.2, h = 338.84, taken = false, model = 1631638868 },
    { x = 319.26, y = -581.17, z = 44.2, h = 338.84, taken = false, model = 1631638868 },
    { x = 324.24, y = -582.82, z = 44.2, h = 338.84, taken = false, model = 1631638868 },
    { x = 322.73, y = -587.11, z = 44.2, h = 158.8, taken = false, model = 1631638868 },
    { x = 317.75, y = -585.3, z = 44.2, h = 158.8, taken = false, model = 1631638868 },
    { x = 314.49, y = -584.15, z = 44.2, h = 158.8, taken = false, model = 1631638868 },
    { x = 311.05, y = -582.91, z = 44.2, h = 158.8, taken = false, model = 1631638868 },
    { x = 307.82, y = -581.75, z = 44.2, h = 158.8, taken = false, model = 1631638868 },
}

local bedsTaken = {}
local injuryBasePrice = 50

AddEventHandler('playerDropped', function()
    if bedsTaken[source] ~= nil then
        beds[bedsTaken[source]].taken = false
    end
end)

RegisterServerEvent('NRP-hospital:server:RequestBed')
AddEventHandler('NRP-hospital:server:RequestBed', function()
    for k, v in pairs(beds) do
        if not v.taken then
            v.taken = true
            bedsTaken[source] = k
            TriggerClientEvent('NRP-hospital:client:SendToBed', source, k, v)
            return
        end
    end

    TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = 'No Beds Available' })
end)

RegisterServerEvent('NRP-hospital:server:RPRequestBed')
AddEventHandler('NRP-hospital:server:RPRequestBed', function(plyCoords)
    local foundbed = false
    for k, v in pairs(beds) do
        local distance = #(vector3(v.x, v.y, v.z) - plyCoords)
        if distance < 3.0 then
            if not v.taken then
                v.taken = true
                foundbed = true
                TriggerClientEvent('NRP-hospital:client:RPSendToBed', source, k, v)
                return
            else
                TriggerEvent('NRP-chat:server:System', source, 'That Bed Is Taken')
            end
        end
    end

    if not foundbed then
        TriggerEvent('NRP-chat:server:System', source, 'Not Near A Hospital Bed')
    end
end)

RegisterServerEvent('NRP-hospital:server:EnteredBed')
AddEventHandler('NRP-hospital:server:EnteredBed', function()
    local src = source
    local injuries = GetCharsInjuries(src)
    
    local totalBill = injuryBasePrice

    if injuries ~= nil then
        for k, v in pairs(injuries.limbs) do
            if v.isDamaged then
                totalBill = totalBill + (injuryBasePrice * v.severity)
            end
        end

        if injuries.isBleeding > 0 then
            totalBill = totalBill + (injuryBasePrice * injuries.isBleeding)
        end
    end
     TriggerClientEvent('NRP-hospital:client:FinishServices', src)
     TriggerEvent('core:getPlayerFromId', source, function(user)
         user.removeBank(totalBill)
         TriggerEvent('bank:intoSharedBank',source, totalBill, 3)
     TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = 'You\'ve Been Treated & Billed $ '..totalBill})
    end)
end)

RegisterServerEvent('NRP-hospital:server:LeaveBed')
AddEventHandler('NRP-hospital:server:LeaveBed', function(id)
    beds[id].taken = false
end)
