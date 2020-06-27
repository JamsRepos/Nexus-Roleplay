local myDecorators = {}
local jobs = {}
local scopedWeapons = {
 100416529,  -- WEAPON_SNIPERRIFLE
 205991906,  -- WEAPON_HEAVYSNIPER
 3342088282, -- WEAPON_MARKSMANRIFLE
 317205821   -- WEAPON_AUTOSHOTGUN
}
RegisterNetEvent('xz:getpoints')
AddEventHandler('xz:getpoints',function(name,value)
  job = name
  points = value 
end)


RegisterNetEvent("core:setPlayerDecorator")
AddEventHandler("core:setPlayerDecorator", function(key, value, doNow)
	myDecorators[key] = value
	DecorRegister(key, 3)

	if(doNow)then
		DecorSetInt(GetPlayerPed(-1), key, value)
	end
end)

AddEventHandler('playerSpawned', function(spawn)
    TriggerServerEvent('core:checkuser')
    for k,v in pairs(myDecorators)do
        DecorSetInt(GetPlayerPed(-1), k, v)
    end
end)

RegisterNetEvent("core:setjob")
AddEventHandler("core:setjob", function(jobid, jobbs)
    local jobid = tonumber(jobid)
    jobs = jobbs
    DecorRegister('Job', 3)
    DecorRegister('isParamedic', 2)
    DecorRegister('isOfficer', 2)

    if jobid == 1 or jobid == 31 or jobid == 32 or jobid == 33 or jobid == 34 or jobid == 35 or jobid == 36 or jobid == 37 or jobid == 90 or jobid == 91 then
     DecorSetBool(GetPlayerPed(-1), "isParamedic", false)   
     DecorSetBool(GetPlayerPed(-1), "isOfficer", true)
    elseif jobid == 2 or jobid == 50 or jobid == 51 or jobid == 52 or jobid == 53 or jobid == 54 or jobid == 55 or jobid == 56 or jobid == 57 then
     DecorSetBool(GetPlayerPed(-1), "isParamedic", true)   
     DecorSetBool(GetPlayerPed(-1), "isOfficer", false)
    else
     DecorSetBool(GetPlayerPed(-1), "isParamedic", false)   
     DecorSetBool(GetPlayerPed(-1), "isOfficer", false)
     TriggerEvent("blips:remove")
    end
    DecorSetInt(GetPlayerPed(-1), 'Job', jobid)
    SetJobBlips(jobid)
end)

RegisterNetEvent("core:setfac")
AddEventHandler("core:setfac", function(facid)
    local facid = tonumber(facid)
    DecorRegister('Faction', 3)
    DecorSetInt(GetPlayerPed(-1), 'Faction', facid)
end)

---------------------------------------------------------------------------
-- Removes features that need to be called every tick
---------------------------------------------------------------------------
Citizen.CreateThread(function()
  while true do
    DisableHealthRegen()
    EnablePVP()
    RemoveWantedLevel()
    RemoveWeaponDrops()
    --RemoveSeatShuffle()
    DisableCrossHair()
    DisableVehicleRewards()
    DisablePistolWhipping()
    Citizen.Wait(0)
  end
end)

-- Combat Log Prevention

Citizen.CreateThread(function()
	alreadyDead = false
    while true do
        Citizen.Wait(50)
		local playerPed = GetPlayerPed(-1)
        if IsEntityDead(playerPed) and not alreadyDead then
            TriggerServerEvent('core:playerDied')
			alreadyDead = true
		end
		if not IsEntityDead(playerPed) then
			alreadyDead = false
		end
	end
end)

function RemoveWantedLevel()
    if GetPlayerWantedLevel(PlayerId()) >= 1 then
        SetPlayerWantedLevel(PlayerId(), 0, false)
        SetPlayerWantedLevelNow(PlayerId(), false)
    end
end

function RemoveWeaponDrops()
    local pickupList = {"PICKUP_AMMO_BULLET_MP","PICKUP_AMMO_FIREWORK","PICKUP_AMMO_FLAREGUN","PICKUP_AMMO_GRENADELAUNCHER","PICKUP_AMMO_GRENADELAUNCHER_MP","PICKUP_AMMO_HOMINGLAUNCHER","PICKUP_AMMO_MG","PICKUP_AMMO_MINIGUN","PICKUP_AMMO_MISSILE_MP","PICKUP_AMMO_PISTOL","PICKUP_AMMO_RIFLE","PICKUP_AMMO_RPG","PICKUP_AMMO_SHOTGUN","PICKUP_AMMO_SMG","PICKUP_AMMO_SNIPER","PICKUP_ARMOUR_STANDARD","PICKUP_CAMERA","PICKUP_CUSTOM_SCRIPT","PICKUP_GANG_ATTACK_MONEY","PICKUP_HEALTH_SNACK","PICKUP_HEALTH_STANDARD","PICKUP_MONEY_CASE","PICKUP_MONEY_DEP_BAG","PICKUP_MONEY_MED_BAG","PICKUP_MONEY_PAPER_BAG","PICKUP_MONEY_PURSE","PICKUP_MONEY_SECURITY_CASE","PICKUP_MONEY_VARIABLE","PICKUP_MONEY_WALLET","PICKUP_PARACHUTE","PICKUP_PORTABLE_CRATE_FIXED_INCAR","PICKUP_PORTABLE_CRATE_UNFIXED","PICKUP_PORTABLE_CRATE_UNFIXED_INCAR","PICKUP_PORTABLE_CRATE_UNFIXED_INCAR_SMALL","PICKUP_PORTABLE_CRATE_UNFIXED_LOW_GLOW","PICKUP_PORTABLE_DLC_VEHICLE_PACKAGE","PICKUP_PORTABLE_PACKAGE","PICKUP_SUBMARINE","PICKUP_VEHICLE_ARMOUR_STANDARD","PICKUP_VEHICLE_CUSTOM_SCRIPT","PICKUP_VEHICLE_CUSTOM_SCRIPT_LOW_GLOW","PICKUP_VEHICLE_HEALTH_STANDARD","PICKUP_VEHICLE_HEALTH_STANDARD_LOW_GLOW","PICKUP_VEHICLE_MONEY_VARIABLE","PICKUP_VEHICLE_WEAPON_APPISTOL","PICKUP_VEHICLE_WEAPON_ASSAULTSMG","PICKUP_VEHICLE_WEAPON_COMBATPISTOL","PICKUP_VEHICLE_WEAPON_GRENADE","PICKUP_VEHICLE_WEAPON_MICROSMG","PICKUP_VEHICLE_WEAPON_MOLOTOV","PICKUP_VEHICLE_WEAPON_PISTOL","PICKUP_VEHICLE_WEAPON_PISTOL50","PICKUP_VEHICLE_WEAPON_SAWNOFF","PICKUP_VEHICLE_WEAPON_SMG","PICKUP_VEHICLE_WEAPON_SMOKEGRENADE","PICKUP_VEHICLE_WEAPON_STICKYBOMB","PICKUP_WEAPON_ADVANCEDRIFLE","PICKUP_WEAPON_APPISTOL","PICKUP_WEAPON_ASSAULTRIFLE","PICKUP_WEAPON_ASSAULTSHOTGUN","PICKUP_WEAPON_ASSAULTSMG","PICKUP_WEAPON_AUTOSHOTGUN","PICKUP_WEAPON_BAT","PICKUP_WEAPON_BATTLEAXE","PICKUP_WEAPON_BOTTLE","PICKUP_WEAPON_BULLPUPRIFLE","PICKUP_WEAPON_BULLPUPSHOTGUN","PICKUP_WEAPON_CARBINERIFLE","PICKUP_WEAPON_COMBATMG","PICKUP_WEAPON_COMBATPDW","PICKUP_WEAPON_COMBATPISTOL","PICKUP_WEAPON_COMPACTLAUNCHER","PICKUP_WEAPON_COMPACTRIFLE","PICKUP_WEAPON_CROWBAR","PICKUP_WEAPON_DAGGER","PICKUP_WEAPON_DBSHOTGUN","PICKUP_WEAPON_FIREWORK","PICKUP_WEAPON_FLAREGUN","PICKUP_WEAPON_FLASHLIGHT","PICKUP_WEAPON_GRENADE","PICKUP_WEAPON_GRENADELAUNCHER","PICKUP_WEAPON_GUSENBERG","PICKUP_WEAPON_GOLFCLUB","PICKUP_WEAPON_HAMMER","PICKUP_WEAPON_HATCHET","PICKUP_WEAPON_HEAVYPISTOL","PICKUP_WEAPON_HEAVYSHOTGUN","PICKUP_WEAPON_HEAVYSNIPER","PICKUP_WEAPON_HOMINGLAUNCHER","PICKUP_WEAPON_KNIFE","PICKUP_WEAPON_KNUCKLE","PICKUP_WEAPON_MACHETE","PICKUP_WEAPON_MACHINEPISTOL","PICKUP_WEAPON_MARKSMANPISTOL","PICKUP_WEAPON_MARKSMANRIFLE","PICKUP_WEAPON_MG","PICKUP_WEAPON_MICROSMG","PICKUP_WEAPON_MINIGUN","PICKUP_WEAPON_MINISMG","PICKUP_WEAPON_MOLOTOV","PICKUP_WEAPON_MUSKET","PICKUP_WEAPON_NIGHTSTICK","PICKUP_WEAPON_PETROLCAN","PICKUP_WEAPON_PIPEBOMB","PICKUP_WEAPON_PISTOL","PICKUP_WEAPON_PISTOL50","PICKUP_WEAPON_POOLCUE","PICKUP_WEAPON_PROXMINE","PICKUP_WEAPON_PUMPSHOTGUN","PICKUP_WEAPON_RAILGUN","PICKUP_WEAPON_REVOLVER","PICKUP_WEAPON_RPG","PICKUP_WEAPON_SAWNOFFSHOTGUN","PICKUP_WEAPON_SMG","PICKUP_WEAPON_SMOKEGRENADE","PICKUP_WEAPON_SNIPERRIFLE","PICKUP_WEAPON_SNSPISTOL","PICKUP_WEAPON_SPECIALCARBINE","PICKUP_WEAPON_STICKYBOMB","PICKUP_WEAPON_STUNGUN","PICKUP_WEAPON_SWITCHBLADE","PICKUP_WEAPON_VINTAGEPISTOL","PICKUP_WEAPON_WRENCH"}
    local pedPos = GetEntityCoords(GetPlayerPed(PlayerId()), false)
    for a = 1, #pickupList do
        if IsPickupWithinRadius(GetHashKey(pickupList[a]), pedPos.x, pedPos.y, pedPos.z, 50.0) then
            RemoveAllPickupsOfType(GetHashKey(pickupList[a]))
        end
    end
end

function DisableHealthRegen()
    SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
end

function EnablePVP()
    SetCanAttackFriendly(GetPlayerPed(PlayerId()), true, false)
    NetworkSetFriendlyFireOption(true)
end

function RemoveSeatShuffle()
    if IsPedInAnyVehicle(GetPlayerPed(PlayerId())) then
        if GetIsTaskActive(GetPlayerPed(PlayerId()), 165) then
            local vehicle = GetVehiclePedIsIn(GetPlayerPed(PlayerId()), false)
            local pedSeat = GetPedVehicleSeat(GetPlayerPed(PlayerId()), vehicle)
            SetPedIntoVehicle(GetPlayerPed(PlayerId()), vehicle, pedSeat)
        end
    end 
end

function DisableCrossHair()
    local hash = GetSelectedPedWeapon(GetPlayerPed(-1))
    if not HashInTable(hash) then 
     HideHudComponentThisFrame(14)
    end 
end 

function DisableVehicleRewards()
 DisablePlayerVehicleRewards(PlayerId())
end

function DisablePistolWhipping()
 DisableControlAction(0, 140, true)
end

function GetPedVehicleSeat()
    local seatCount = GetVehicleModelNumberOfSeats(GetHashKey(GetEntityModel(vehicle)))
    for a = -1, seatCount do
        local pedInSeat = GetPedInVehicleSeat(vehicle, a)
        if pedInSeat == ped then
            return a
        end
    end
end

function HashInTable( hash )
    for k, v in pairs( scopedWeapons ) do 
        if ( hash == v ) then 
            return true 
        end 
    end 

    return false 
end 

function globalObject(object)
 SetEntityAsMissionEntity(object, true, true)
end

RegisterNetEvent("core:removeweapon")
AddEventHandler("core:removeweapon", function(weapon, allweapons)
    if allweapons then 
        RemoveAllPedWeapons(GetPlayerPed(-1), true)
    else
        RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey(weapon))
    end
end)

RegisterNetEvent("core:addweapon")
AddEventHandler("core:addweapon", function(weapon)
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey(weapon), 100, false, false)
end)

local passangerDriveBy = true 

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)

  if IsPedInAnyVehicle(GetPlayerPed(-1)) then
   if vehicleClass ~= 15 and 16 then
    local speed = math.floor(GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) * 2.236936)
    if speed > 50 then 
     SetPlayerCanDoDriveBy(PlayerId(), false)
    else
     SetPlayerCanDoDriveBy(PlayerId(), true)
    end
   end
  end
 end
end)

local jobLocations = {
  {x =-265.036, y=-963.630, z=30.223, id= 1},
  {x = -1195.370, y = -900.547, z = 13.995-0.95, id= 2},
  {x = -1170.221, y = -1570.822, z = 4.664-0.95, id= 3},
}

local jobCenter = nil

Citizen.CreateThread(function()
 WarMenu.CreateLongMenu('job_center', "Job Center")
 while true do
  Wait(5)
  if WarMenu.IsMenuOpened('job_center') then
   for ind, v in pairs(jobs) do
    if v.whitelisted == 0 and jobCenter == 1 and WarMenu.Button(v.name, '~g~Salary: ~g~$'..v.pay) then
     WarMenu.CloseMenu('job_center')
     TriggerServerEvent('jobs:setjob', v.id)
    elseif v.whitelisted == 2 and jobCenter == 2 and WarMenu.Button(v.name, '~g~Salary: ~g~$'..v.pay) then
     WarMenu.CloseMenu('job_center')
     TriggerServerEvent('jobs:setjob', v.id)
    elseif v.whitelisted == 3 and jobCenter == 3 and WarMenu.Button(v.name, '~g~Salary: ~g~$'..v.pay) then 
        WarMenu.CloseMenu('job_center')
        TriggerServerEvent('FL_Perks:LevelChecks')
        Wait(100)
        if v.id == 41 then
            if tostring(job) == 'SOTW' then
             if tonumber(points) >= 75 then
              exports['NRP-notify']:DoHudText('inform', "Head To The Grow Room Round Back To Start Work")
              TriggerServerEvent('jobs:setjob', v.id)
             else
               exports['NRP-notify']:DoHudText('inform', "You Need Atleast 75 Points in SOTW To Use the Grow Room")
             end
            end
        elseif v.id == 46 then
            TriggerServerEvent('jobs:setjob', v.id)
            exports['NRP-notify']:DoHudText('inform', "Check The Till For What Stock Is Running Low") 
         
        elseif v.id == 47 then
            if tostring(job) == 'SOTW' then
             if tonumber(points) >= 350 then
              TriggerServerEvent('jobs:setjob', v.id)
              exports['NRP-notify']:DoHudText('inform', "Head to the back of the grow room to pick up weed from storage then go to the laptop to sign on") 
              else
                exports['NRP-notify']:DoHudText('inform', "You Need Atleast 350 Points in SOTW To Deliver Weed For Them")
              end
            end
        end
    end
   end
   WarMenu.Display()
  end
  for ind, v in pairs(jobLocations) do
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 50) then
    DrawMarker(27, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, 1.0,1.0,1.0, 255, 255, 0, 100, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 1.2) then
     if v.id == 1 then
      DrawText3Ds(v.x, v.y, v.z+0.95,'~g~[E]~w~ Job Center')
     elseif v.id == 2 then  
      DrawText3Ds(v.x, v.y, v.z+0.95,'~g~[E]~w~ Fast Food Jobs')
    elseif v.id == 3 then  
        DrawText3Ds(v.x, v.y, v.z+0.95,'~g~[E]~w~ Smoke On The Water Jobs')
     end 
     if IsControlPressed(0, 38) then
      jobCenter = v.id
      TriggerServerEvent('core:checkjob')
      WarMenu.OpenMenu('job_center')
     end
    end
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

function SetJobBlips(id)
 if id == 5 then 
  SetWorkPlace(3866.848, 4464.227, 1.736)
 elseif id == 6 then
  SetWorkPlace(-406.925, 6172.887, 31.497)
 elseif id == 7 then 
  SetWorkPlace(-552.879, 5348.669, 73.743)
 elseif id == 4 then 
  SetWorkPlace(895.376, -179.315, 73.710)
 elseif id == 10 then 
  SetWorkPlace(-354.999, -1513.897, 27.717)
 elseif id == 11 then 
  SetWorkPlace(1200.460, -1276.810, 35.369)
 elseif id == 14 then 
  SetWorkPlace(736.634, 132.274, 80.710)
 elseif id == 42 then 
 SetWorkPlace(-1909.576, 2071.702, 140.389)
 elseif id == 43 then 
 SetWorkPlace(-1927.767, 2060.205, 140.837)
 elseif id == 60 then
  SetWorkPlace(-95.22, 2809.865, 53.337)
 end
end

function SetWorkPlace(x,y,z)
 if DoesBlipExist(blip) then RemoveBlip(blip) end
 blip = AddBlipForCoord(x, y, z)
 SetBlipSprite (blip, 408)
 SetBlipDisplay(blip, 4)
 SetBlipScale  (blip, 1.0)
 SetBlipColour (blip, 18)
 SetBlipAsShortRange(blip, true)
 BeginTextCommandSetBlipName("STRING")
 AddTextComponentString("Work Place")
 EndTextCommandSetBlipName(blip)
end 