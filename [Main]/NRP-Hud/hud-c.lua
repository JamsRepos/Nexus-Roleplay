local x = 1.000
local y = 1.000

local hunger = 50
local thirst = 50
local showUi = false
local showVehicle = false

local isTokovoip = false

--General UI Updates
Citizen.CreateThread(function()

    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(x, y, z, currentStreetHash, intersectStreetHash)
    currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
    intersectStreetName = GetStreetNameFromHashKey(intersectStreetHash)
    zone = tostring(GetNameOfZone(x, y, z))
    local area = GetLabelText(zone)
    playerStreetsLocation = area

    if not zone then
        zone = "UNKNOWN"
    end

    if intersectStreetName ~= nil and intersectStreetName ~= "" then
        playerStreetsLocation = currentStreetName .. " | " .. intersectStreetName .. " | [" .. area .. "]"
    elseif currentStreetName ~= nil and currentStreetName ~= "" then
        playerStreetsLocation = currentStreetName .. " | [" .. area .. "]"
    else
        playerStreetsLocation = "[" .. area .. "]"
    end

    while true do
        local player = PlayerPedId()

        local x, y, z = table.unpack(GetEntityCoords(player, true))
        local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(x, y, z, currentStreetHash, intersectStreetHash)
        currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
        intersectStreetName = GetStreetNameFromHashKey(intersectStreetHash)
        zone = tostring(GetNameOfZone(x, y, z))
        local area = GetLabelText(zone)
        playerStreetsLocation = area

        if not zone then
            zone = "UNKNOWN"
        end

        if intersectStreetName ~= nil and intersectStreetName ~= "" then
            playerStreetsLocation = currentStreetName .. " | " .. intersectStreetName .. " | [" .. area .. "]"
        elseif currentStreetName ~= nil and currentStreetName ~= "" then
            playerStreetsLocation = currentStreetName .. " | [" .. area .. "]"
        else
            playerStreetsLocation = "[".. area .. "]"
        end

        if not showVehicle and IsVehicleEngineOn(GetVehiclePedIsIn(player, false)) then
            showVehicle = true
            SendNUIMessage({
                action = 'vehicle-hud-on'
            })
        else 
            showVehicle = false
        end

        SendNUIMessage({
            action = 'vehicle-hud-update',
            direction = math.floor(calcHeading(-GetEntityHeading(player) % 360)),
            street = playerStreetsLocation,
        })

        SendNUIMessage({
            action = 'tick',
            show = IsPauseMenuActive(),
            health = (GetEntityHealth(player) - 100),
            armor = GetPedArmour(player),
            stamina = 100 - GetPlayerSprintStaminaRemaining(PlayerId()),
            --stamina = 25 + GetPlayerUnderwaterTimeRemaining(PlayerId()),
        })
        Citizen.Wait(10)
    end
end)

--Network Talking Updates
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(50)
        if isTokovoip then
            SendNUIMessage({
                action = 'voice-color',
                isTalking = exports.tokovoip_script:getPlayerData(GetPlayerServerId(PlayerId()), 'voip:talking')
            })
        else
            SendNUIMessage({
                action = 'voice-color',
                isTalking = NetworkIsPlayerTalking(PlayerId())
            })
        end
    end
end)

Citizen.CreateThread(function()
    local currLevel = 1
    while true do
        Citizen.Wait(0)
        if IsControlJustReleased(1, 74) then
            if isTokovoip == true then
                currLevel =  exports.tokovoip_script:getPlayerData(GetPlayerServerId(PlayerId()), 'voip:mode')
                if currLevel == 1 then
                    SendNUIMessage({
                        action = 'set-voice',
                        value = 100
                    })
                elseif currLevel == 2 then
                    SendNUIMessage({
                        action = 'set-voice',
                        value = 100
                    })
                elseif currLevel == 3 then
                    SendNUIMessage({
                        action = 'set-voice',
                        value = 100
                    })
                end
            else
                currLevel = (currLevel + 1) % 3
                if currLevel == 0 then
                    SendNUIMessage({
                        action = 'set-voice',
                        value = 50
                    })
                elseif currLevel == 1 then
                    SendNUIMessage({
                        action = 'set-voice',
                        value = 100
                    })
                elseif currLevel == 2 then
                    SendNUIMessage({
                        action = 'set-voice',
                        value = 25
                    })
                end
            end
        end
    end
end)

function UIStuff()  
    Citizen.CreateThread(function()
        while showUi do
            Wait(10)
            HideHudComponentThisFrame( 7 ) -- Area Name
            HideHudComponentThisFrame( 9 ) --    Name
            HideHudComponentThisFrame( 3 ) -- SP Cash display 
            HideHudComponentThisFrame( 4 )  -- MP Cash display
            HideHudComponentThisFrame( 13 ) -- Cash 
            --changesSetPedHelmet(GetPlayerPed(-1), false)
            SetPedHelmet(GetPlayerPed(-1), false)
        end
    end)
    
    Citizen.CreateThread(function()
       --while true do 
        while showUi do
        Citizen.Wait(100)
         updateStatus(hunger, thirst)
        end
    end)
end

RegisterNetEvent('NRP-Hud:UpdateStatus')
AddEventHandler('NRP-Hud:UpdateStatus', function(hunger, thirst)
    updateStatus(hunger, thirst)
end)


function updateStatus(hunger, thirst)
    SendNUIMessage({
        action = "updateStatus",
        hunger = hunger,
        thirst = thirst
    })
end


Citizen.CreateThread(function()
    while true do 
     Citizen.Wait(60000)
       if thirst > 0 then   
        thirst = thirst - 1.0
       end
       if hunger > 0 then    
        hunger = hunger - 0.75
        --updateStatus()
      else
         Citizen.Wait(45000) 
       end
     end
end)


Citizen.CreateThread(function()
    while true do
    Wait(100)
      if hunger < 20 or thirst < 20 then
        SetEntityMaxSpeed(GetPlayerPed(-1), 5.00)
        Wait(10000)
        DoScreenFadeOut(1500)
        Wait(1200)
        DoScreenFadeIn(1500)
        if hunger < 5 or thirst < 5 then
            ApplyDamageToPed(GetPlayerPed(-1), 5, false)
        end
     else
       SetEntityMaxSpeed(GetPlayerPed(-1), 100.00)
     end
    end
end) 

RegisterNetEvent('NRP-Hud:CharacterSpawned')
AddEventHandler('NRP-Hud:CharacterSpawned', function()
    TriggerServerEvent('NRP-Hud:GetMoneyStuff')
end)

RegisterNetEvent('NRP-Hud:DisplayMoneyStuff')
AddEventHandler('NRP-Hud:DisplayMoneyStuff', function()
    SendNUIMessage({
        action = 'showui'
    })
    UIStuff()
    showUi = true
end)

RegisterNetEvent('NRP-Hud:Logout') ---- addd this in cc
AddEventHandler('NRP-Hud:Logout', function()
    SendNUIMessage({
        action = 'hideui'
    })
    showUi = false 
end)

local imageWidth = 100
local containerWidth = 100

local width =  0;
local south = (-imageWidth) + width
local west = (-imageWidth * 2) + width
local north = (-imageWidth * 3) + width
local east = (-imageWidth * 4) + width
local south2 = (-imageWidth * 5) + width
 
function calcHeading(direction)
    if (direction < 90) then
        return lerp(north, east, direction / 90)
    elseif (direction < 180) then
        return lerp(east, south2, rangePercent(90, 180, direction))
    elseif (direction < 270) then
        return lerp(south, west, rangePercent(180, 270, direction))
    elseif (direction <= 360) then
        return lerp(west, north, rangePercent(270, 360, direction))
    end
end

function rangePercent(min, max, amt)
    return (((amt - min) * 100) / (max - min)) / 100
end

function lerp(min, max, amt)
    return (1 - amt) * min + amt * max
end















RegisterNetEvent('food:coffee')
AddEventHandler('food:coffee', function()
 local ped = PlayerPedId()
 Citizen.CreateThread(function()
  local x,y,z = table.unpack(GetEntityCoords(ped))
  prop = CreateObject(GetHashKey('p_ing_coffeecup_01'), x, y, z+0.2,  true,  true, true)
  AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 18905), 0.13, 0.003, 0.019, 301.0, 112.0, 0.0, true, true, false, true, 1, true)
  RequestAnimDict('mp_player_intdrink')
  while not HasAnimDictLoaded('mp_player_intdrink') do
   Wait(0)
  end
  TriggerEvent("InteractSound_CL:PlayOnOne", "drinking", 0.5)
  TaskPlayAnim(ped, 'mp_player_intdrink', 'loop_bottle', 8.0, -8, -1, 49, 0, 0, 0, 0)
  Wait(2000)
  TriggerEvent("InteractSound_CL:PlayOnOne", "drinking", 0.5)
  Wait(2000)
  thirst = 100
  ClearPedSecondaryTask(ped)
  DeleteObject(prop)
  updateStatus(hunger, thirst)
 end)
end)

RegisterNetEvent('food:eCola')
AddEventHandler('food:eCola', function()
 local ped = PlayerPedId()
 Citizen.CreateThread(function()
  local x,y,z = table.unpack(GetEntityCoords(ped))
  prop = CreateObject(GetHashKey('ng_proc_sodacan_01a'), x, y, z+0.2,  true,  true, true)
  AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 18905), 0.08, -0.070, 0.040, 301.0, 112.0, 0.0, true, true, false, true, 1, true)
  RequestAnimDict('mp_player_intdrink')
  while not HasAnimDictLoaded('mp_player_intdrink') do
   Wait(0)
  end
  TriggerEvent("InteractSound_CL:PlayOnOne", "drinking", 0.5)
  TaskPlayAnim(ped, 'mp_player_intdrink', 'loop_bottle', 8.0, -8, -1, 49, 0, 0, 0, 0)
  Wait(2000)
  TriggerEvent("InteractSound_CL:PlayOnOne", "drinking", 0.5)
  Wait(2000)
  thirst = 100
  ClearPedSecondaryTask(ped)
  DeleteObject(prop)
  updateStatus(hunger, thirst)
 end)
end)

RegisterNetEvent('food:sprunk')
AddEventHandler('food:sprunk', function()
 local ped = PlayerPedId()
 Citizen.CreateThread(function()
  local x,y,z = table.unpack(GetEntityCoords(ped))
  prop = CreateObject(GetHashKey('ng_proc_sodacan_01b'), x, y, z+0.2,  true,  true, true)
  AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 18905), 0.08, -0.070, 0.040, 301.0, 112.0, 0.0, true, true, false, true, 1, true)
  RequestAnimDict('mp_player_intdrink')
  while not HasAnimDictLoaded('mp_player_intdrink') do
   Wait(0)
  end
  TriggerEvent("InteractSound_CL:PlayOnOne", "drinking", 0.5)
  TaskPlayAnim(ped, 'mp_player_intdrink', 'loop_bottle', 8.0, -8, -1, 49, 0, 0, 0, 0)
  Wait(2000)
  TriggerEvent("InteractSound_CL:PlayOnOne", "drinking", 0.5)
  Wait(2000)
  thirst = 100
  ClearPedSecondaryTask(ped)
  DeleteObject(prop)
  updateStatus(hunger, thirst)
 end)
end)

RegisterNetEvent('food:donut')
AddEventHandler('food:donut', function()
 local donutprop = nil
 local donutrnd = math.random(1,2)
 if donutrnd == 1 then
  donutprop = 'prop_donut_01'
 elseif donutrnd == 2 then
  donutprop = 'prop_donut_02'
 end

 local ped = PlayerPedId()
 Citizen.CreateThread(function()
  local x,y,z = table.unpack(GetEntityCoords(ped))
  local prop = CreateObject(GetHashKey(donutprop), x, y, z+0.2,  true,  true, true)
  AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 18905), 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
  RequestAnimDict('mp_player_inteat@burger')
  while not HasAnimDictLoaded('mp_player_inteat@burger') do
   Wait(0)
  end
  TriggerEvent("InteractSound_CL:PlayOnOne", "eating", 0.5)
  TaskPlayAnim(ped, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)
  Wait(2000)
  TriggerEvent("InteractSound_CL:PlayOnOne", "eating", 0.5)
  Wait(2500)
  local newHunger = 0
  Wait(10)
  if hunger+70 >= 100 then
    newHunger = 100
  else
    newHunger = hunger+20
  end
  hunger = newHunger
  ClearPedSecondaryTask(ped)
  DeleteObject(prop)
  updateStatus(hunger, thirst)
  end)
end)

RegisterNetEvent('food:cheeseburger')
AddEventHandler('food:cheeseburger', function()
 local ped = PlayerPedId()
 Citizen.CreateThread(function()
  local x,y,z = table.unpack(GetEntityCoords(ped))
  local prop = CreateObject(GetHashKey('prop_cs_burger_01'), x, y, z+0.2,  true,  true, true)
  AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 18905), 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
  RequestAnimDict('mp_player_inteat@burger')
  while not HasAnimDictLoaded('mp_player_inteat@burger') do
   Wait(0)
  end
  TriggerEvent("InteractSound_CL:PlayOnOne", "eating", 0.5)
  TaskPlayAnim(ped, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)
  Wait(2000)
  TriggerEvent("InteractSound_CL:PlayOnOne", "eating", 0.5)
  Wait(2500)
  if hunger+80 >= 100 then
    newHunger = 100
  else
    newHunger = hunger+80
  end
  hunger = newHunger
  ClearPedSecondaryTask(ped)
  DeleteObject(prop)
  updateStatus(hunger, thirst) 
  end)
end)

RegisterNetEvent('food:burger')
AddEventHandler('food:burger', function()
 local ped = PlayerPedId()
 Citizen.CreateThread(function()
  local x,y,z = table.unpack(GetEntityCoords(ped))
  local prop = CreateObject(GetHashKey('prop_cs_burger_01'), x, y, z+0.2,  true,  true, true)
  AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 18905), 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
  RequestAnimDict('mp_player_inteat@burger')
  while not HasAnimDictLoaded('mp_player_inteat@burger') do
   Wait(0)
  end
  TriggerEvent("InteractSound_CL:PlayOnOne", "eating", 0.5)
  TaskPlayAnim(ped, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)
  Wait(2000)
  TriggerEvent("InteractSound_CL:PlayOnOne", "eating", 0.5)
  Wait(2500)
  local newHunger = 0
  Wait(10)
  if hunger+50 >= 100 then
    newHunger = 100
  else
    newHunger = hunger+50
  end
  hunger = newHunger
  ClearPedSecondaryTask(ped)
  DeleteObject(prop)
  updateStatus(hunger, thirst)
  end)
end)

RegisterNetEvent('food:hotdog')
AddEventHandler('food:hotdog', function()
 local ped = PlayerPedId()
 Citizen.CreateThread(function()
  local x,y,z = table.unpack(GetEntityCoords(ped))
  local prop = CreateObject(GetHashKey('prop_cs_hotdog_01'), x, y, z+0.2,  true,  true, true)
  AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 18905), 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
  RequestAnimDict('mp_player_inteat@burger')
  while not HasAnimDictLoaded('mp_player_inteat@burger') do
   Wait(0)
  end
  TriggerEvent("InteractSound_CL:PlayOnOne", "eating", 0.5)
  TaskPlayAnim(ped, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)
  Wait(2000)
  TriggerEvent("InteractSound_CL:PlayOnOne", "eating", 0.5)
  Wait(2500)
  local newHunger = 0
  Wait(10)
  if hunger+30 >= 100 then
    newHunger = 100
  else
    newHunger = hunger+30
  end
  hunger = newHunger
  ClearPedSecondaryTask(ped)
  DeleteObject(prop)
  updateStatus(hunger, thirst) 
  end)
end)

RegisterNetEvent('food:sandwich')
AddEventHandler('food:sandwich', function()
 local ped = PlayerPedId()
 Citizen.CreateThread(function()
  local x,y,z = table.unpack(GetEntityCoords(ped))
  local prop = CreateObject(GetHashKey('prop_sandwich_01'), x, y, z+0.2,  true,  true, true)
  AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 18905), 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
  RequestAnimDict('mp_player_inteat@burger')
  while not HasAnimDictLoaded('mp_player_inteat@burger') do
   Wait(0)
  end
  TriggerEvent("InteractSound_CL:PlayOnOne", "eating", 0.5)
  TaskPlayAnim(ped, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)
  Wait(2000)
  TriggerEvent("InteractSound_CL:PlayOnOne", "eating", 0.5)
  Wait(2500)
  local newHunger = 0
  Wait(10)
  hunger = 100
  ClearPedSecondaryTask(ped)
  DeleteObject(prop)
  updateStatus(hunger, thirst) 
  end)
end)

RegisterNetEvent('food:drink')
AddEventHandler('food:drink', function()
 local ped = PlayerPedId()
 Citizen.CreateThread(function()
  local x,y,z = table.unpack(GetEntityCoords(ped))
  prop = CreateObject(GetHashKey('prop_ld_flow_bottle'), x, y, z+0.2,  true,  true, true)     
  AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 18905), 0.13, 0.003, 0.019, 301.0, 112.0, 0.0, true, true, false, true, 1, true)
  RequestAnimDict('mp_player_intdrink')  
  while not HasAnimDictLoaded('mp_player_intdrink') do
   Wait(0)
  end
  TriggerEvent("InteractSound_CL:PlayOnOne", "drinking", 0.5)
  TaskPlayAnim(ped, 'mp_player_intdrink', 'loop_bottle', 8.0, -8, -1, 49, 0, 0, 0, 0)
  Wait(2000)
  TriggerEvent("InteractSound_CL:PlayOnOne", "drinking", 0.5)
  thirst = 100
  ClearPedSecondaryTask(ped)
  DeleteObject(prop)
  updateStatus(hunger, thirst) 
 end)
end)

