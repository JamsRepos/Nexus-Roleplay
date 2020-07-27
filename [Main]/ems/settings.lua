-- EMS Vehicles
currentgarage = {}

vehicles = {
 [1] = {name = 'Ambulance', vehicle = 'f750', rank = 'TRE'},
 [2] = {name = 'EMS Explorer', vehicle = 'fd1', rank = 'TRE'},
 [3] = {name = 'EMS Tahoe', vehicle = 'fd2', rank = 'TRE'},
 [4] = {name = 'EMS Crown Vic', vehicle = 'fd3', rank = 'TRE'},
 [5] = {name = 'EMS Taurus', vehicle = 'fd4', rank = 'TRE'},
 [3] = {name = 'EMS Maverick', vehicle = 'polmav', rank = 'ASU'},
 [4] = {name = 'EMS Volito', vehicle = 'supervolito', rank = 'ASU'},
}

-- Locations
hospitals = {
  {id=61, x= 340.278, y= -1396.029, z= 32.509},
  {id=61, x= 338.85, y= -1394.56, z= 31.53},
  {id=61, x= -449.67, y= -340.83, z= 33.52},
  {id=61, x= 360.864, y= -585.171, z= 27.84},
  {id=61, x= 1156.74, y= -1529.11, z= 33.86},
  {id=61, x= -247.01, y= 6331.45, z= 31.44},
  {id=61, x= 1826.98, y= 3693.34, z= 34.24},
  {id=61, x= 298.44, y= -584.28, z= 42.28},
}

duty = {
  {x= 269.636, y= -1363.251, z= 23.55},
  {x = 300.726, y = -597.640, z = 43.285-0.95},
}

garage = {
  {x = 289.69, y = -613.21, z = 43.41-0.95},
}

medicalcabinet = {
  {x = 306.821, y = -601.567, z = 43.283-0.95},
}

-- Spawn Vehicle Function
function SpawnVehicle(vehicle2)
 if vehicle2 ~= 'polmav' and vehicle2 ~= 'supervolito' and vehicle2 ~= 'annihilator' then
   local vehiclehash = GetHashKey(vehicle2)
   RequestModel(vehiclehash)
   while not HasModelLoaded(vehiclehash) do
    Citizen.Wait(0)
   end
   vehicle = CreateVehicle(vehiclehash, currentgarage.x, currentgarage.y, currentgarage.z, 67.83, true, false)
   local id = NetworkGetNetworkIdFromEntity(vehicle)
   SetNetworkIdCanMigrate(id, true)
   SetNetworkIdExistsOnAllMachines(id, true)
   SetVehicleDirtLevel(vehicle, 0)
   TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
   SetVehicleHasBeenOwnedByPlayer(vehicle, true)
   SetEntityAsMissionEntity(vehicle, true, true)
   SetVehicleMod(vehicle,16, 20)
   SetVehicleEngineOn(vehicle, true)
   DecorRegister("_Fuel_Level", 3);
   DecorRegister("_Max_Fuel_Level", 3);
   DecorSetInt(vehicle, "_Max_Fuel_Level", 150000)
   DecorSetInt(vehicle, "_Fuel_Level", 150000)
   SetVehicleColours(vehicle, 131, 131)
   exports["onyxLocksystem"]:givePlayerKeys(GetVehicleNumberPlateText(vehicle))
 else
  vehiclehash = GetHashKey(vehicle2)
  RequestModel(vehiclehash)
  Citizen.CreateThread(function() 
   while not HasModelLoaded(vehiclehash) do  
    Citizen.Wait(0)  
   end
   local spawned = CreateVehicle(vehiclehash, 351.505, -588.230, 74.166, GetEntityHeading(PlayerPedId()), 1, 0)
   TaskWarpPedIntoVehicle(GetPlayerPed(-1), spawned, -1)
   SetVehicleEngineOn(spawned, true, true)  
   SetVehicleIsConsideredByPlayer(spawned, true)
   DecorRegister("_Fuel_Level", 3);
   DecorRegister("_Max_Fuel_Level", 3);
   DecorSetInt(spawned, "_Max_Fuel_Level", 150000)
   DecorSetInt(spawned, "_Fuel_Level", 150000)
   Wait(500)
   SetVehicleColours(spawned, 131, 131)
   exports["onyxLocksystem"]:givePlayerKeys(GetVehicleNumberPlateText(spawned))
  end)
 end
end

RegisterNetEvent('ems:dutystatus')
AddEventHandler('ems:dutystatus', function(stat)
  if stat == 1 then -- On Duty
   OnDuty()
   print('On Duty')
   isInService = true   
  elseif stat == 0 then -- Off Duty
   OffDuty()
   print('Off Duty')
   isInService = false
  end
end)

local backupvehicle = false 

RegisterCommand("dutyveh", function(source, args, rawCommand)
 if DecorGetBool(GetPlayerPed(-1), "isParamedic") and isInService then
  if not backupvehicle then
    local pos = GetEntityCoords(GetPlayerPed(-1), false)
    local vehiclehash = GetHashKey('ambulance2')
    RequestModel(vehiclehash)
    Citizen.CreateThread(function() 
     while not HasModelLoaded(vehiclehash) do  
      Citizen.Wait(0)  
     end
     local spawned = CreateVehicle(vehiclehash, pos.x, pos.y, pos.z, GetEntityHeading(PlayerPedId()), true, false)
     TaskWarpPedIntoVehicle(GetPlayerPed(-1), spawned, -1)
     SetVehicleEngineOn(spawned, true, true)
     SetVehicleIsConsideredByPlayer(spawned, true)
     exports["onyxLocksystem"]:givePlayerKeys(GetVehicleNumberPlateText(spawned))
    end)
    backupvehicle = true
  end
 end
end)

function OnDuty()
--[[  
  if GetEntityModel(GetPlayerPed(-1)) == -1667301416 then
    -- Female
    SetPedComponentVariation(GetPlayerPed(-1), 3, 109, 0, 0)
    SetPedComponentVariation(GetPlayerPed(-1), 4, 6, 2, 0)
    SetPedComponentVariation(GetPlayerPed(-1), 6, 72, 0, 0)
    SetPedComponentVariation(GetPlayerPed(-1), 7, 97, 0, 0)
    SetPedComponentVariation(GetPlayerPed(-1), 8, 159, 0, 0)
    SetPedComponentVariation(GetPlayerPed(-1), 10, 66, 0, 0)
    SetPedComponentVariation(GetPlayerPed(-1), 11, 258, 0, 0)
  else
    -- Male
    SetPedComponentVariation(GetPlayerPed(-1), 3, 85, 0, 2)
    SetPedComponentVariation(GetPlayerPed(-1), 4, 96, 0, 2)
    SetPedComponentVariation(GetPlayerPed(-1), 6, 12, 6, 2)
    SetPedComponentVariation(GetPlayerPed(-1), 10, 58, 0, 2)
    SetPedComponentVariation(GetPlayerPed(-1), 8, 129, 0, 2)
    SetPedComponentVariation(GetPlayerPed(-1), 11, 250, 0, 2)
  end
--]]
  --GiveWeaponToPed(GetPlayerPed(-1), GetHashKey('WEAPON_STUNGUN'), 1000, false, true)
  TriggerEvent("inventory:removeQty", 198, 1)
  TriggerEvent("inventory:addQty", 198, 1)
  TriggerServerEvent('blips:activate', 'ems')
  exports["rp-radio"]:GivePlayerAccessToFrequencies(1, 2, 3)
  exports["mumble-voip"]:SetRadioChannel(1)
  exports["mumble-voip"]:SetMumbleProperty("radioEnabled", true)

  TriggerEvent("NRP-notify:client:SendAlert", { type = "success", text = "Please enter your callsign.", length = 5000})
  DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 32)
  while (UpdateOnscreenKeyboard() == 0) do
    DisableAllControlActions(0);
    Wait(0);
  end
  if (GetOnscreenKeyboardResult()) then
   local result = GetOnscreenKeyboardResult()
   TriggerServerEvent('dispatch:duty', true, result)
   TriggerServerEvent("dutylog:dutyChange", "ems", true)
  end
end

function OffDuty()
  TriggerServerEvent('skin:load')
  SetPedComponentVariation(GetPlayerPed(-1), 10, 0, 0, 2) -- Decals
  SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2) -- Chains
  --RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey('WEAPON_STUNGUN'))
  TriggerEvent("inventory:removeQty", 198, 1)
  TriggerServerEvent('blips:deactivate')
  TriggerServerEvent('dispatch:duty', false)
  TriggerServerEvent("dutylog:dutyChange", "ems", false)
  exports["rp-radio"]:RemovePlayerAccessToFrequencies(1, 2, 3)
  exports["mumble-voip"]:SetRadioChannel(0)
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

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(0)
  if IsDead then
   DisableControlAction(0, 69, true) -- INPUT_VEH_ATTACK
   DisableControlAction(0, 92, true) -- INPUT_VEH_PASSENGER_ATTACK
   DisableControlAction(0, 114, true) -- INPUT_VEH_FLY_ATTACK
   DisableControlAction(0, 140, true) -- INPUT_MELEE_ATTACK_LIGHT
   DisableControlAction(0, 141, true) -- INPUT_MELEE_ATTACK_HEAVY
   DisableControlAction(0, 142, true) -- INPUT_MELEE_ATTACK_ALTERNATE
   DisableControlAction(0, 257, true) -- INPUT_ATTACK2
   DisableControlAction(0, 263, true) -- INPUT_MELEE_ATTACK1
   DisableControlAction(0, 264, true) -- INPUT_MELEE_ATTACK2
   DisableControlAction(0, 24, true) -- INPUT_ATTACK 
   DisableControlAction(0, 25, true) -- INPUT_AIM
   DisableControlAction(0, 23, true) -- INPUT_ENTER
   DisableControlAction(0, 75, true) -- INPUT_VEH_EXIT
  end
 end
end)

local wepdescriptors = {
  {hash = "WEAPON_HEAVYPISTOL", desc = "small caliber gun shot wounds"},
  {hash = "WEAPON_STUNGUN", desc = "electrical burn wounds"},
  {hash = "WEAPON_NIGHTSTICK", desc = "long bruises with blunt force trauma"},
  {hash = "WEAPON_PUMPSHOTGUN", desc = "scattered small caliber gun shot wounds"},
  {hash = "WEAPON_CARBINERIFLE", desc = "large caliber automatic gun shot wounds"},
  {hash = "WEAPON_MICROSMG", desc = "small caliber automatic gun shot wounds"},
  {hash = "WEAPON_COMBATPDW", desc = "small caliber automatic gun shot wounds"},
  {hash = "WEAPON_FLASHLIGHT", desc = "medium bruising with blunt force trauma"},
  {hash = "WEAPON_FIREEXTINGUISHER", desc = "blunt force trauma"},
  {hash = "WEAPON_PETROLCAN", desc = "blunt force trauma with a strong gasoline smell"},
  {hash = "WEAPON_BZGAS", desc = "mild chemical burns"},
  {hash = "WEAPON_FLARE", desc = "moderate burn wounds"},
  {hash = "WEAPON_ASSAULTSMG", desc = "small caliber automatic gun shot wounds"},
  {hash = "WEAPON_SPECIALCARBINE", desc = "small caliber automatic gun shot wounds"},
  {hash = "WEAPON_ASSAULTSHOTGUN", desc = "scattered small caliber gun shot wounds"},
  {hash = "WEAPON_KNIFE", desc = "serrated stab and cut wounds"},
  {hash = "WEAPON_BAT", desc = "long cylindrical bruising with blunt force trauma"},
  {hash = "WEAPON_CROWBAR", desc = "blunt force trauma and long bruising with stab wounds at the end"},
  {hash = "WEAPON_GOLFCLUB", desc = "long thin bruises with blunt force trauma at the end"},
  {hash = "WEAPON_DAGGER", desc = "deep stab wounds"},
  {hash = "WEAPON_KNUCKLE", desc = "knuckle shaped bruising"},
  {hash = "WEAPON_MACHETE", desc = "large stab wound with long slashing wounds"},
  {hash = "WEAPON_WRENCH", desc = "large bruises with blunt force trauma"},
  {hash = "WEAPON_PISTOL", desc = "small caliber gun shot wounds"},
  {hash = "WEAPON_SNSPISTOL", desc = "small caliber gun shot wounds"},
  {hash = "WEAPON_COMBATPISTOL", desc = "small caliber gun shot wounds"},
  {hash = "WEAPON_HEAVYPISTOL", desc = "small caliber gun shot wounds"},
  {hash = "WEAPON_PISTOL50", desc = "small caliber gun shot wounds"},
  {hash = "WEAPON_SWITCHBLADE", desc = "moderately deep stab wounds with slashing wounds"},
  {hash = "WEAPON_REVOLVER", desc = "large caliber gun shot wounds"},
  {hash = "WEAPON_MARKSMANPISTOL", desc = "large caliber gun shot wounds"},
  {hash = "WEAPON_SAWNOFFSHOTGUN", desc = "scattered small caliber gun shot wounds"},
  {hash = "WEAPON_COMPACTRIFLE", desc = "large caliber gun shot wounds"},
  {hash = "WEAPON_SMG", desc = "small caliber automatic gun shot wounds"},
  {hash = "WEAPON_BULLPUPRIFLE", desc = "small caliber automatic gun shot wounds"},
  {hash = "WEAPON_CARBINERIFLE", desc = "large caliber automatic gun shot wounds"},
  {hash = "WEAPON_ASSAULTSMG", desc = "small caliber automatic gun shot wounds"},
  {hash = "WEAPON_MACHINEPISTOL", desc = "small caliber automatic gun shot wounds"},
  {hash = "WEAPON_MINISMG", desc = "small caliber automatic gun shot wounds"},
  {hash = "WEAPON_BATTLEAXE", desc = "long slashing and cutting wounds"},
  {hash = "WEAPON_POOLCUE", desc = "long bruises with traces of a blue chalky substance"},
  {hash = "WEAPON_BALL", desc = "large round bruise"},
  {hash = "WEAPON_DBSHOTGUN", desc = "scattered small caliber gun shot wounds"},
  {hash = "WEAPON_GUSENBERG", desc = "small caliber automatic gun shot wounds"},
  {hash = "WEAPON_ASSAULTRIFLE_MK2", desc = "large caliber automatic gun shot wounds"},
  {hash = "WEAPON_CARBINERIFLE_MK2", desc = "large caliber automatic gun shot wounds"},
  {hash = "WEAPON_COMBATMG_MK2", desc = "large caliber automatic gun shot wounds"},
  {hash = "WEAPON_PISTOL_MK2", desc = "small caliber gun shot wounds"},
  {hash = "WEAPON_SMG_MK2", desc = "small caliber automatic gun shot wounds"},
  {hash = "WEAPON_ASSAULTSHOTGUN", desc = "scattered small caliber gun shot wounds"},
  {hash = "WEAPON_FALL", desc = "brusing and fall damage"},
  {hash = "WEAPON_RUN_OVER_BY_CAR", desc = "signs of a broken leg and vehicle damage"},
  {hash = "WEAPON_FIRE", desc = "charged skins and burn marks"},
  {hash = "WEAPON_COUGAR", desc = "bite marks and teared clothing"},
}

function getWeaponDamageString(ped)
  local ped = ped
  local dmgstr = "You notice "

  for i,v in ipairs(wepdescriptors) do
    if (HasPedBeenDamagedByWeapon(ped, GetHashKey(v.hash), 0)) then
      dmgstr =  dmgstr .. v.desc..", "
    end
  end

  if (dmgstr == "You notice ") then
    dmgstr = "You notice no visible melee or gun shot wounds"
  end

  return dmgstr
end

RegisterNetEvent("ems:damage")
AddEventHandler("ems:damage", function(target)
  local ped = GetPlayerPed(GetPlayerFromServerId(target))
  exports['NRP-notify']:DoHudLongText('inform',  ""..getWeaponDamageString(ped))
end)
--[[
local healpoints = {
  {name="Hospital", id=61, x= -449.67, y= -340.83, z= 33.50, color= 43},
  {name="Hospital", id=61, x= 360.864, y= -585.171, z= 27.8257, color= 43},
  {name="Hospital", id=61, x= 1156.74, y= -1529.11, z= 33.8434, color= 43},
  {name="Hospital", id=61, x= -247.01, y= 6331.45, z= 31.4262, color= 43},
  {name="Hospital", id=61, x= 1826.98, y= 3693.34, z= 34.2243, color= 43},
  {name="Hospital", id=61, x= 340.278, y= -1396.029, z= 32.509-0.95, color= 43},

}

Citizen.CreateThread(function()
 while true do
  Wait(0)
  for _,v in pairs(healpoints) do
   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 25 then
    DrawMarker(27, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 0, 155, 255, 200, 0, 0, 0, 0)
    if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x,v.y,v.z, true) < 1.2 then
     drawTxt("~m~Press ~g~E~m~ To Get Treatment")
     if IsControlJustPressed(1,38) then
      TriggerEvent("mythic_progbar:client:progress", {
        name = "treatment",
        duration = 6000,
        label = "Receiving Treatment",
        useWhileDead = true,
        canCancel = false,
        controlDisables = {
           disableMovement = true,
           disableCarMovement = true,
           disableMouse = false,
           disableCombat = true,
        },
      }, function(status)
      if not status then
        SetEntityHealth(GetPlayerPed(-1), 200)
        TriggerEvent('NRP-hospital:client:RemoveBleed')
        TriggerEvent('NRP-hospital:client:ResetLimbs')
        exports['NRP-notify']:DoHudText('inform', 'You Have Received Treatment From The Doctor')
        ResetPedMovementClipset(GetPlayerPed(-1), 0)
        ClearPedBloodDamage(GetPlayerPed(-1))
      end
     end)
     end
    end
   end 
  end
 end
end)
]]--

----------------------------------------------------------------------------------------------------------
------------------------------------------ EMS  Blips --------------------------------------------------
----------------------------------------------------------------------------------------------------------


RegisterNetEvent('ems:resultAllEMSInService')
AddEventHandler('ems:resultAllEMSInService', function(array)
    allServiceEMS = array
    enableEMSBlips()
end)

local blipsCops = {}

-- Player Blips
function enableEMSBlips()

  for k, existingBlip in pairs(blipsCops) do
        RemoveBlip(existingBlip)
    end
  blipsCops = {}
  
  local localIdCops = {}
  for id = 0, 255 do
    if(NetworkIsPlayerActive(id)) then
      for i,c in pairs(allServiceEMS) do
        if(i == GetPlayerServerId(id)) then
          localIdCops[id] = c
          break
        end
      end
    end
  end
  
  for id, c in pairs(localIdCops) do
    local ped = GetPlayerPed(id)
    local blip = GetBlipFromEntity(ped)
    
    if not DoesBlipExist( blip ) then

      blip = AddBlipForEntity( ped )
      SetBlipSprite( blip, 1 )
      Citizen.InvokeNative( 0x5FBCA48327B914DF, blip, true )
      HideNumberOnBlip(blip)
      
      SetBlipScale(blip,  0.8)
      SetBlipAlpha(blip, 255)
      SetBlipColour(blip, 49)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString('Unit ID: '..GetPlayerServerId(id))
      EndTextCommandSetBlipName(blip)
      
      table.insert(blipsCops, blip)
    else
      
      blipSprite = GetBlipSprite(blip)
      
      HideNumberOnBlip( blip )
      if blipSprite ~= 1 then
        SetBlipSprite( blip, 1 )
        Citizen.InvokeNative( 0x5FBCA48327B914DF, blip, true )
      end

      SetBlipScale(blip,  0.8)
      SetBlipAlpha(blip, 255)
      SetBlipColour(blip, 49)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString('Unit ID: '..GetPlayerServerId(id))
      EndTextCommandSetBlipName(blip)
      
      table.insert(blipsCops, blip)
    end
  end
end