local robberyInProgress = false 
local isNearStore = false
local storeLoc = {}
local cashRegister = nil
local storeRobberies = {[1] = 534367705, [2] = 303280717}
local robberyBlip = nil
local currentPolice = 0
local storeRobberyInProgress = false
Citizen.CreateThread(function()
 while true do
  Citizen.Wait(1250)
  isNearStore = false
  local pos = GetEntityCoords(GetPlayerPed(-1))
  for i = 1, #storeRobberies do
   cashRegister = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.5, storeRobberies[i], false, false)
   if cashRegister ~= nil and cashRegister ~= 0 and not robberyInProgress then
    local coords = GetEntityCoords(cashRegister)
    isNearStore = true
    storeLoc = {['x'] = coords.x, ['y'] = coords.y, ['z'] = coords.z + 0.2}
    break
   end
  end
 end
end)

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
  if not storeRobberyInProgress and currentPolice >= 3 then
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), storeLoc.x, storeLoc.y, storeLoc.z, true) < 0.8) then
    DrawText3Ds(storeLoc.x, storeLoc.y, storeLoc.z,'~g~[E]~w~ Break Open Cash Register')
    if IsControlJustPressed(0, 38) and IsPedArmed(GetPlayerPed(-1), 7) then
      local result = exports["NRP-Safe"]:createSafe({math.random(0,99),math.random(0,99),math.random(0,99)})
      if result then
        TriggerServerEvent('robberies:start', 'Store', storeLoc)
      end
    end 
   end
  end
 end
end)
 
RegisterNetEvent('xzurvRobbery:started')
AddEventHandler('xzurvRobbery:started', function()
  storeRobberyInProgress = true
  TaskStartScenarioInPlace(GetPlayerPed(-1), 'PROP_HUMAN_PARKING_METER', false, true)

  TriggerEvent("mythic_progbar:client:progress", {
    name = "robbing_store",
    duration = 240000,
    label = "Taking Money",
    useWhileDead = false,
    canCancel = true,
    controlDisables = {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = false,
    },
  }, function(status)
      if not status then
        if storeRobberyInProgress then
          ClearPedTasksImmediately(GetPlayerPed(-1))
          if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), storeLoc.x, storeLoc.y, storeLoc.z, true) < 6.0) then
          TriggerServerEvent('robberies:end', 'Store', storeLoc, math.random(18000,23000))
          Wait(25000)
          end
        end
      end
  end)
end) 

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
  if storeRobberyInProgress then
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), storeLoc.x, storeLoc.y, storeLoc.z, true) > 7.0) then
    TriggerServerEvent('robberies:cancel', 'Store', storeLoc)
    TriggerEvent("mythic_progbar:client:cancel")
    storeRobberyInProgress = false 
    Wait(25000)
   end
  end
 end
end)


function DrawText3Ds(x,y,z, text)
  local onScreen,_x,_y=World3dToScreen2d(x,y,z)
  local px,py,pz=table.unpack(GetGameplayCamCoords())
  SetTextScale(0.35, 0.35)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextColour(255, 255, 255, 215)
  SetTextEntry("STRING")
  SetTextCentre(1)
  AddTextComponentString(text)
  DrawText(_x,_y)
end

RegisterNetEvent('robberies:killBlip')
AddEventHandler('robberies:killBlip', function()
 if DoesBlipExist(robberyBlip) then 
  RemoveBlip(robberyBlip)
 end
end)

RegisterNetEvent('robberies:addBlip')
AddEventHandler('robberies:addBlip', function(blip)
 if DecorGetBool(GetPlayerPed(-1), "isOfficer") then
  if not DoesBlipExist(robberyBlip) then 
   robberyBlip = AddBlipForCoord(blip.x, blip.y, blip.z) 
   SetBlipSprite(robberyBlip, 161)
   SetBlipScale(robberyBlip, 1.2)
   SetBlipColour(robberyBlip, 3)
   PulseBlip(robberyBlip)
   PlaySoundFrontend(-1, "CHECKPOINT_MISSED", 'HUD_MINI_GAME_SOUNDSET', 1)
   Wait(600)
   PlaySoundFrontend(-1, "CHECKPOINT_MISSED", 'HUD_MINI_GAME_SOUNDSET', 1)
   Wait(600)  
   PlaySoundFrontend(-1, "CHECKPOINT_MISSED", 'HUD_MINI_GAME_SOUNDSET', 1)
  end
 end
end)

RegisterNetEvent('hud:updatepresence')
AddEventHandler('hud:updatepresence', function(copss)
 currentPolice = copss
end)

--- NPC ROBBING

local robbedRecently = false
local robbingNPC = false

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
  local aiming, targetPed = GetEntityPlayerIsFreeAimingAt(PlayerId(-1))
  if aiming and not robbingNPC and not IsPedInAnyVehicle(GetPlayerPed(-1), false) and not IsPedInAnyVehicle(targetPed, false) and IsPedArmed(GetPlayerPed(-1), 4) and not DecorGetBool(GetPlayerPed(-1), "isOfficer") and not DecorGetBool(GetPlayerPed(-1), "isParamedic") then
   local coords = GetEntityCoords(GetPlayerPed(-1), true)
   local npcCoords = GetEntityCoords(targetPed, true)

   if DoesEntityExist(targetPed) and IsEntityAPed(targetPed) and not IsPedAPlayer(targetPed) and IsPedHuman(targetPed) then
    if not robbedRecently and not IsEntityDead(targetPed) and GetDistanceBetweenCoords(coords.x, coords.y, coords.z, npcCoords.x, npcCoords.y, npcCoords.z, true) < 5 then
     robNpc(targetPed)
    end
   end
  end
 end
end)




function robNpc(targetPed)
  robbedRecently = true
  robbingNPC = true
  TaskPlayAnim(targetPed, "random@mugging3", "handsup_standing_base", 8.0, -8, -1, 12, 1, 0, 0, 0)

  exports['pogressBar']:drawBar(10000, 'Holding Up Civilian', function()
        local random = math.random(1,8) 
        if random == 1 then    
         exports['NRP-notify']:DoHudText('inform', 'You Got Nothing')
        elseif random == 2 then
         exports['NRP-notify']:DoHudText('inform', 'You Stole Some Cigarettes & A Lighter')
         TriggerEvent("inventory:addQty", 15, 5)
         TriggerEvent("inventory:addQty", 146, 1)
        elseif random == 3 then    
         local cunt = math.random(30,120)
         exports['NRP-notify']:DoHudText('inform', "You Found $"..cunt.." In Their Pockets")
         TriggerServerEvent('jobs:paytheplayer', cunt, 'Robbery: Civillian Pockets')
        elseif random == 4 then
         exports['NRP-notify']:DoHudText('inform', 'You Got An Empty Wallet')
        elseif random == 5 then
         exports['NRP-notify']:DoHudText('inform', 'You Suck At This, Empty Handed')
        elseif random == 6 then
         exports['NRP-notify']:DoHudText('inform', 'You Stole 2 Cans Of Redbull')
         TriggerEvent("inventory:addQty", 26, 2)
        elseif random == 7 then
         exports['NRP-notify']:DoHudText('inform', 'You Stole A Lighter')
         TriggerEvent("inventory:addQty", 146, 1)
         elseif random == 8 then
         exports['NRP-notify']:DoHudText('inform', 'You Stole A Phone')
         TriggerEvent("inventory:addQty", 271, 1)
        end
       Citizen.CreateThread(function()
         RequestAnimDict('random@mugging3')
         while not HasAnimDictLoaded('random@mugging3') do
          Citizen.Wait(100)
         end
     
        if math.random(1,10) > 5 then TriggerEvent("dispatch:robbery") end
         SetPedFleeAttributes(targetPed, 0, 0)
         ClearPedTasks(targetPed)
         --TriggerServerEvent('addReputation', 2)
         Wait(120000)
         robbedRecently = false
         robbingNPC = false
      end)
  end)
end


-----------------------------------------------------------------
-- Robbing Jewlery Store
-----------------------------------------------------------------
local vangelicoRobbery = false 
local cabinits = {
  [1] = {x = -626.700, y = -238.604, z = 38.057, brokenOpen = false},
  [2] = {x = -625.664, y = -237.858, z = 38.057, brokenOpen = false},
  [3] = {x = -626.890, y = -235.493, z = 38.057, brokenOpen = false},
  [4] = {x = -627.905, y = -233.826, z = 38.057, brokenOpen = false},
  [5] = {x = -624.865, y = -227.906, z = 38.057, brokenOpen = false},
  [6] = {x = -623.891, y = -227.214, z = 38.057, brokenOpen = false},
  [7] = {x = -623.932, y = -228.120, z = 38.057, brokenOpen = false},
  [8] = {x = -620.535, y = -226.665, z = 38.057, brokenOpen = false},
  [9] = {x = -619.717, y = -227.605, z = 38.057, brokenOpen = false},
  [10] = {x = -618.314, y = -229.464, z = 38.057, brokenOpen = false},     
  [11] = {x = -617.627, y = -230.462, z = 38.057, brokenOpen = false}, 
  [12] = {x = -619.647, y = -230.382, z = 38.057, brokenOpen = false}, 
  [13] = {x = -621.046, y = -228.438, z = 38.057, brokenOpen = false}, 
  [14] = {x = -619.207, y = -233.606, z = 38.057, brokenOpen = false}, 
  [15] = {x = -620.205, y = -234.331, z = 38.057, brokenOpen = false}, 
  [16] = {x = -620.069, y = -233.466, z = 38.057, brokenOpen = false}, 
  [17] = {x = -623.144, y = -233.004, z = 38.057, brokenOpen = false}, 
  [18] = {x = -624.371, y = -231.135, z = 38.057, brokenOpen = false}, 
  [19] = {x = -625.810, y = -234.709, z = 38.057, brokenOpen = false}, 
  [20] = {x = -626.884, y = -233.117, z = 38.057, brokenOpen = false}, 
}

Citizen.CreateThread(function()
 while true do
  local coords = GetEntityCoords(GetPlayerPed(-1), false)
  Citizen.Wait(5)
  if not vangelicoRobbery and currentPolice >= 4 and not DecorGetBool(GetPlayerPed(-1), "isOfficer") and not DecorGetBool(GetPlayerPed(-1), "isParamedic") then
    if(GetDistanceBetweenCoords(coords, -621.297, -231.683, 38.057, true) < 1.5) then
     DrawText3Ds(-621.297, -231.683, 38.057,"~g~[E]~w~ Rob Vangelicos")
     if IsControlJustPressed(0, 38) and IsPedArmed(GetPlayerPed(-1), 4) then
      TriggerServerEvent('vangelicoRobbery:start', {x = coords.x, y = coords.y, z = coords.z})
     end 
    end
  end
  if vangelicoRobbery and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -621.297, -231.683, 38.057, true) > 20.0 then
   for i=1, 20 do cabinits[i].brokenOpen = false end
   TriggerServerEvent('vangelicoRobbery:cancel')
   vangelicoRobbery = false 
   Wait(300000)
  end
 end
end)

Citizen.CreateThread(function()
 while true do
  local coords = GetEntityCoords(GetPlayerPed(-1), false)
  Citizen.Wait(5)
  if vangelicoRobbery then 
    for i,v in pairs(cabinits) do
     if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.0) and not v.brokenOpen then
      DrawText3Ds(v.x, v.y, v.z,"~g~[E]~w~ Break Open")
      if IsControlJustPressed(0, 38) then
       v.brokenOpen = true
       loadAnimDict("missheist_jewel") 
       TaskPlayAnim(GetPlayerPed(-1), "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
       Citizen.Wait(6000)
       ClearPedTasksImmediately(GetPlayerPed(-1))
       PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
       xzprize()
      end 
     end
    end
  end
 end
end)


function xzprize()
	local easywin = math.random(1,11) 
	local watch = math.random(3,10)
	local silver = math.random(3,10)
	local gold = math.random(3,10)
	local rolex = math.random(3,10)
  local diamond = math.random(3,10)
	if easywin == 1 then    
    exports['NRP-notify']:DoHudText('success', "You Stole "..silver.." Silver Rings!")
    TriggerEvent("inventory:addQty", 66, silver )
	 elseif easywin == 2 then
	  exports['NRP-notify']:DoHudText('success', "You Stole "..rolex.." Rolexs!")
	  TriggerEvent("inventory:addQty", 67, rolex )
	 elseif easywin == 3 then    
	 exports['NRP-notify']:DoHudText('error', 'The Jewellery is Secured To Well Try Another Cabinet!')
	 elseif easywin == 4 then
    exports['NRP-notify']:DoHudText('success', "You Stole "..gold.." Rings!")
    TriggerEvent("inventory:addQty", 128 , gold )
	 elseif easywin == 5 then
	  exports['NRP-notify']:DoHudText('success', 'You Stole '..watch..' Watches!')
	  TriggerEvent("inventory:addQty", 129, watch )
	 elseif easywin == 6 then
    exports['NRP-notify']:DoHudText('error', 'The Jewellery is Secured To Well Try Another Cabinet!')
	 elseif easywin == 7 then    
    exports['NRP-notify']:DoHudText('success', "You Stole "..diamond.." Diamond Necklaces!")
    TriggerEvent("inventory:addQty", 127, diamond )
	 elseif easywin == 8 then
	  exports['NRP-notify']:DoHudText('success', "You Stole "..silver.." Silver Rings!")
	  TriggerEvent("inventory:addQty", 66, silver )
	 elseif easywin == 9 then    
    exports['NRP-notify']:DoHudText('success', 'You Stole '..watch..' Watches!')
	  TriggerEvent("inventory:addQty", 129, watch )
	 elseif easywin == 10 then  
    exports['NRP-notify']:DoHudText('error', 'The Jewellery is Secured To Well Try Another Cabinet!')
	 else   
    exports['NRP-notify']:DoHudText('success', "You Stole "..gold.." Rings!")
    TriggerEvent("inventory:addQty", 128 , gold )
  end	
end


RegisterNetEvent('vangelicoRobbery:started')
AddEventHandler('vangelicoRobbery:started', function()
 vangelicoRobbery = true
 TriggerServerEvent('addReputation', 10)
 spawnGuards()
end)  

RegisterNetEvent('vangelicoRobbery:ended')
AddEventHandler('vangelicoRobbery:ended', function()
 vangelicoRobbery = false
end)  

function loadAnimDict( dict )  
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

local guardLocations = {
 {x = -631.406, y = -229.196, z = 38.057, heading = 14.867}, 
 {x = -626.708, y = -224.322, z = 38.057, heading = 216.267}, 
}

function loadModel(model)
 RequestModel(GetHashKey(model))
 while not HasModelLoaded(GetHashKey(model)) do
  Wait(0)
 end
end

function spawnGuards()
 local randomSpawns = ran
 for i,v in pairs(guardLocations) do 
   loadModel('s_m_m_highsec_01')
   local ped = CreatePed(4, GetHashKey('s_m_m_highsec_01'), v.x, v.y, v.z, v.heading, true, true)
   SetPedShootRate(ped, 900)
   SetPedAlertness(ped, 3)
   SetPedAccuracy(ped, 100)
   SetEntityMaxHealth(ped, 650)
   SetEntityHealth(ped, 650)
   SetPedArmour(ped, 350)
   SetPedFleeAttributes(ped, 0, 0)
   SetPedCombatAttributes(ped, 46, true)
   SetPedCombatAbility(ped, 2)
   SetPedCombatRange(ped, 2)
   SetPedPathAvoidFire(ped, 1)
   SetPedGeneratesDeadBodyEvents(ped, 1)
   GiveWeaponToPed(ped, GetHashKey("WEAPON_COMBATPISTOL"), 5000, true, true)
   SetPedRelationshipGroupHash(ped, GetHashKey("COP"))
   SetPedRelationshipGroupHash(ped, "COP")
   SetModelAsNoLongerNeeded(GetHashKey('s_m_m_highsec_01')) 
   TaskShootAtEntity(ped, GetPlayerPed(-1), 25000, GetHashKey("FIRING_PATTERN_FULL_AUTO"))
 end
end


