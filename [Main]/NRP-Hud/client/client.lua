local x = 1.000
local y = 1.000

local hunger = 50
local thirst = 50
local inCar = false
local showUi = false
local prevVelocity = {x = 0.0, y = 0.0, z = 0.0}
local voice = {default = 7.0, shout = 14.0, whisper = 1.0, current = 0, level = nil}

--[[ =========================================================================================================================== ]]--
--[[ =========================================================================================================================== ]]--
--[[ =========================================================================================================================== ]]--
--[[ =========================================================================================================================== ]]--
--[[ =========================================================================================================================== ]]--

function CalculateTimeToDisplay()
	hour = GetClockHours()
    minute = GetClockMinutes()
    
    local obj = {}

    if hour <= 12 then
        obj.ampm = 'AM'
    elseif hour >= 13 then
        obj.ampm = 'PM'
        hour = hour - 12
    end
    
	if minute <= 9 then
		minute = "0" .. minute
    end
    
    obj.hour = hour
    obj.minute = minute

    return obj
end

function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

function getCardinalDirectionFromHeading(heading)
    if ((heading >= 0 and heading < 45) or (heading >= 315 and heading < 360)) then
        return "Northbound" -- North
    elseif (heading >= 45 and heading < 135) then
        return "Eastbound" -- East
    elseif (heading >=135 and heading < 225) then
        return "Southbound" -- South
    elseif (heading >= 225 and heading < 315) then
        return "Westbound" -- West
    end
end

AddEventHandler('onClientMapStart', function()
    if voice.current == 0 then
      NetworkSetTalkerProximity(voice.default)
    elseif voice.current == 1 then
      NetworkSetTalkerProximity(voice.shout)
    elseif voice.current == 2 then
      NetworkSetTalkerProximity(voice.whisper)
    end   
end)

function UIStuff()
    Citizen.CreateThread(function()
        while showUi do
            SendNUIMessage({
                action = 'tick',
                show = IsPauseMenuActive(),
                health = (GetEntityHealth(GetPlayerPed(-1))-100),
                armor = (GetPedArmour(GetPlayerPed(-1))),
                stamina = 100 - GetPlayerSprintStaminaRemaining(PlayerId()),
            })
          
            local time = CalculateTimeToDisplay()

            SendNUIMessage({
                action = 'update-clock',
                time = time.hour .. ':' .. time.minute,
                ampm = time.ampm
            })

            if NetworkIsPlayerTalking(PlayerId(-1)) then
                SendNUIMessage({
                    action = 'voice-color',
                    isTalking = true
                })
            else
                SendNUIMessage({
                    action = 'voice-color',
                    isTalking = false
                })
            end

            local heading = getCardinalDirectionFromHeading(GetEntityHeading(GetPlayerPed(-1)))
            local pos = GetEntityCoords(PlayerPedId())
            local var1, var2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
            local current_zone = GetLabelText(GetNameOfZone(pos.x, pos.y, pos.z))

            SendNUIMessage({
                action = 'update-position',
                direction = heading,
                street1 = GetStreetNameFromHashKey(var1),
                street2 = GetStreetNameFromHashKey(var2),
                area = current_zone
            })

            Citizen.Wait(200)
        end
    end)
    
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

            
            if IsControlJustPressed(1, 74) and IsControlPressed(1, 21) then
                voice.current = (voice.current + 1) % 3
                if voice.current == 0 then
                    NetworkSetTalkerProximity(voice.default)
                    SendNUIMessage({
                        action = 'set-voice',
                        value = 66
                    })
                elseif voice.current == 1 then
                    NetworkSetTalkerProximity(voice.shout)
                    SendNUIMessage({
                        action = 'set-voice',
                        value = 100
                    })
                elseif voice.current == 2 then
                    NetworkSetTalkerProximity(voice.whisper)
                    SendNUIMessage({
                        action = 'set-voice',
                        value = 33
                    })
                end
            end
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

RegisterNetEvent('NRP-Hud:DisplayMoneyChange')
AddEventHandler('NRP-Hud:DisplayMoneyChange', function(accounts, amount)
    local type = nil

    if amount < 0 then
        type = 'negative'
    else
        type = 'positive'
    end

    SendNUIMessage({
        action = 'change',
        type = type,
        accounts = data.accounts,
        amount = amount
    })
end)

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
      RequestAnimDict( dict )
      Citizen.Wait( 0 )
    end
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

