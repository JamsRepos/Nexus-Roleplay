-------------------------------
-- Hostages
-------------------------------

local isHostaging = false
local isHostaged = false
local wasDead1 = false

RegisterCommand("hostage", function(source, args, rawCommand)
 loadAnim('missprologueig_4@hold_head_base')
 local t, distance = GetClosestPlayer()
 if(distance ~= -1 and distance < 3) then 
   if isHostaging then 
     ClearPedTasksImmediately(GetPlayerPed(PlayerId()))
     TriggerServerEvent('anims:hostager', GetPlayerServerId(t))
     isHostaging = false
   else
    if DecorGetBool(GetPlayerPed(t), "Handsup") or IsEntityDead(GetPlayerPed(t)) then
     isHostaging = true 
     TriggerServerEvent('anims:hostager', GetPlayerServerId(t))
     TaskPlayAnim(GetPlayerPed(PlayerId()), 'missprologueig_4@hold_head_base', 'hold_head_loop_base_guard', 1.0, -1, -1, 50, 0, 0, 0, 0)
    end
   end
 end
end)

RegisterNetEvent('anims:doHostage')
AddEventHandler('anims:doHostage', function(otherPlayer)
 if IsEntityAttachedToEntity(GetPlayerPed(PlayerId()), GetPlayerPed(GetPlayerFromServerId(otherPlayer))) then
  if wasDead1 then
   SetEntityHealth(GetPlayerPed(-1), 0)
  end
  DetachEntity(GetPlayerPed(PlayerId()), GetPlayerPed(GetPlayerFromServerId(otherPlayer)), true)
  ClearPedTasksImmediately(GetPlayerPed(PlayerId()))
  isHostaged = false
 else
  if IsEntityDead(GetPlayerPed(-1)) then
   wasDead1 = true
   SetEntityHealth(GetPlayerPed(-1), 200)
   Wait(100)
   TriggerEvent('ems:revive')
  end
  isHostaged = true
  loadAnim('missprologueig_4@hold_head_base')
  AttachEntityToEntity(GetPlayerPed(PlayerId()), GetPlayerPed(GetPlayerFromServerId(otherPlayer)), 4103, 11816, 0.48, 0.00, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
  TaskPlayAnim(GetPlayerPed(PlayerId()), 'missprologueig_4@hold_head_base', 'hold_head_loop_base_player0', 8.0, -1, -1, 1, 1, 0, 0, 0)
 end 
end)

RegisterCommand("hostagePed", function(source, args, rawCommand)
 loadAnim('missprologueig_4@hold_head_base')
 loadAnim('missprologueig_4@hold_head_base')
 local closestPed = getNPC()
 if closestPed then
  if IsEntityAttachedToEntity(closestPed, GetPlayerPed(PlayerId())) then 
   DetachEntity(closestPed, GetPlayerPed(PlayerId()), true)
   ClearPedTasksImmediately(closestPed)
   ClearPedTasksImmediately(GetPlayerPed(PlayerId()))
  else 
   local closestPed = getNPC()
   ClearPedTasksImmediately(closestPed)
   TaskPlayAnim(closestPed, 'missprologueig_4@hold_head_base', 'hold_head_loop_base_player0', 8.0, -1, -1, 1, 1, 0, 0, 0)
   AttachEntityToEntity(closestPed, GetPlayerPed(PlayerId()), 4103, 11816, 0.48, 0.00, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
   TaskPlayAnim(GetPlayerPed(PlayerId()), 'missfinale_c2mcs_1', 'hold_head_loop_base_guard', 1.0, -1, -1, 50, 0, 0, 0, 0)
  end
 end
end)

Citizen.CreateThread(function()
 while true do
  Wait(0)
  if isHostaged then
   DisableControlAction(0, 73)
   DisableControlAction(0, 178)
   DisableControlAction(0, 168)
   DisableControlAction(0, 20)
   DisableControlAction(0, 37)
  end
 end
end)

Citizen.CreateThread(function()
 while true do
  Wait(0)
  if isHostaging then
    DisableControlAction(0, 23)
  DisableControlAction(0, 75)
  end
 end
end)

-------------------------------

function loadAnim(anim)
    RequestAnimDict(anim) 
    while not HasAnimDictLoaded(anim) do 
     Citizen.Wait(1) 
    end
   end

function getNPC()
 local playerCoords = GetEntityCoords(GetPlayerPed(-1))
 local handle, ped = FindFirstPed()
 local success
 local rped = nil
 local distanceFrom
 repeat
  local pos = GetEntityCoords(ped)
  local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
  if canPedBeUsed(ped) and distance < 5.0 and (distanceFrom == nil or distance < distanceFrom) then
   distanceFrom = distance
   rped = ped
   SetEntityAsMissionEntity(rped, true, true)
  end
  success, ped = FindNextPed(handle)
  until not success
  EndFindPed(handle)
 return rped
end

function canPedBeUsed(ped)
 if ped == nil then return false end
 if ped == GetPlayerPed(-1) then return false end
 if not DoesEntityExist(ped) then return false end
 if not IsPedOnFoot(ped) then return false end
 if IsEntityDead(ped) then return false end
 if not IsPedHuman(ped) then return false end
 return true
end

-- Nearest Players
function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)
    
    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = Vdist(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"])
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    
    return closestPlayer, closestDistance
end

function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end