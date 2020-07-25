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

RegisterCommand('tutorial', function(source, args)
    TriggerEvent('core:starttutorial')
end, false)

RegisterNetEvent("core:starttutorial")
AddEventHandler("core:starttutorial", function()
    ClearFocus()
    local playerPed = GetPlayerPed(-1)
    local coords    = GetEntityCoords(playerPed)
    local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    while not DoesCamExist(cam) do
        Citizen.Wait(250)
    end
    if DoesCamExist(cam) then
        SetCamActive(cam, true)
        SetEntityVisible(playerPed, false, 0)
        SetEntityCoordsNoOffset(playerPed, 243.8, -1079.33, 61.58, false, false, false, true)
        FreezeEntityPosition(playerPed, true)
        SetFocusEntity(playerPed)
        SetCamCoord(cam, 243.8, -1079.33, 61.58)
        RenderScriptCams(1, 0, 0, 1, 1)
        SetCamRot(cam, 0.0, 0.0, 23.42)
        exports['NRP-notify']:DoCustomHudText('inform', 'Welcome to Nexus Roleplay! <br><br> Let\'s show you around the city quickly. This won\'t take long, it\'s just to prevent you from getting lost.', 7500, { ['text-align'] = 'center', ['background-color'] = '#2a9946', ['color'] = '#000000' })
        Citizen.Wait(7500)
        Citizen.Wait(1000)
        exports['NRP-notify']:DoCustomHudText('inform', 'This is Legion Square, the social hub of the city where you can come and chill with other civilians.', 5000, { ['text-align'] = 'center', ['background-color'] = '#2a9946', ['color'] = '#000000' })
        Citizen.Wait(5000)
        Citizen.Wait(1000)
        DoScreenFadeOut(800)
        Citizen.Wait(3000)

        SetEntityCoordsNoOffset(playerPed, -225.65, -1027.7, 38.15, false, false, false, true)
        FreezeEntityPosition(playerPed, true)
        SetFocusEntity(playerPed)
        Citizen.Wait(800)
        SetCamCoord(cam, -225.65, -1027.7, 38.15)
        RenderScriptCams(1, 0, 0, 1, 1)
        SetCamRot(cam, 0.0, 0.0, 31.59)
        DoScreenFadeIn(800)
        Citizen.Wait(1000)
        exports['NRP-notify']:DoCustomHudText('inform', 'The Job Center <br><br> Here you can find most legal jobs in the city. Not all are listed here, and some are whitelist so look out for those!', 8000, { ['text-align'] = 'center', ['background-color'] = '#2a9946', ['color'] = '#000000' })
        Citizen.Wait(8000)
        Citizen.Wait(1000)
        DoScreenFadeOut(800)
        Citizen.Wait(3000)

        SetEntityCoordsNoOffset(playerPed, -87.14, -1100.44, 27.75, false, false, false, true)
        FreezeEntityPosition(playerPed, true)
        SetFocusEntity(playerPed)
        Citizen.Wait(800)
        SetCamCoord(cam, -87.14, -1100.44, 27.75)
        RenderScriptCams(1, 0, 0, 1, 1)
        SetCamRot(cam, 0.0, 0.0, 264.54)
        DoScreenFadeIn(800)
        Citizen.Wait(1000)
        exports['NRP-notify']:DoCustomHudText('inform', 'Premium Deluxe Motorsport (PDM) <br><br> This is the place to come if you need a new whip! We have bi-weekly custom car imports from abroad that you can test drive before you buy.', 9000, { ['text-align'] = 'center', ['background-color'] = '#2a9946', ['color'] = '#000000' })
        Citizen.Wait(9000)
        Citizen.Wait(1000)
        DoScreenFadeOut(800)
        Citizen.Wait(3000)

        SetEntityCoordsNoOffset(playerPed, -43.30, -1113.57, 27.13, false, false, false, true)
        FreezeEntityPosition(playerPed, true)
        SetFocusEntity(playerPed)
        Citizen.Wait(800)
        SetCamCoord(cam, -43.30, -1113.57, 27.13)
        RenderScriptCams(1, 0, 0, 1, 1)
        SetCamRot(cam, 0.0, 0.0, 283.53)
        DoScreenFadeIn(800)
        Citizen.Wait(1000)
        exports['NRP-notify']:DoCustomHudText('inform', 'Driving License <br><br> Before you get yourself a car, be sure to visit Simeon in his office to register yourself to drive.', 6000, { ['text-align'] = 'center', ['background-color'] = '#2a9946', ['color'] = '#000000' })
        Citizen.Wait(6000)
        Citizen.Wait(1000)
        DoScreenFadeOut(800)
        Citizen.Wait(3000)

        SetEntityCoordsNoOffset(playerPed, 212.13, -833.09, 38.15, false, false, false, true)
        FreezeEntityPosition(playerPed, true)
        SetFocusEntity(playerPed)
        Citizen.Wait(800)
        SetCamCoord(cam, 212.13, -833.09, 38.15)
        RenderScriptCams(1, 0, 0, 1, 1)
        SetCamRot(cam, 0.0, 0.0, 351.49)
        DoScreenFadeIn(800)
        Citizen.Wait(1000)
        exports['NRP-notify']:DoCustomHudText('inform', 'Garages <br><br> Once you have purchased a car, you can store them at specific garages around the city. Here\'s Legion Garage!', 6000, { ['text-align'] = 'center', ['background-color'] = '#2a9946', ['color'] = '#000000' })
        Citizen.Wait(6000)
        Citizen.Wait(1000)
        exports['NRP-notify']:DoCustomHudText('inform', 'Each garage around the city has it\'s own storage. Meaning, if you leave your car in a garage in Sandy Shores, you won\'t be able to retreive it here.', 8000, { ['text-align'] = 'center', ['background-color'] = '#2a9946', ['color'] = '#000000' })
        Citizen.Wait(8000)
        Citizen.Wait(1000)
        exports['NRP-notify']:DoCustomHudText('inform', 'By default, you can only store 1 vehicle per garage. You can upgrade this at a later date.', 5000, { ['text-align'] = 'center', ['background-color'] = '#2a9946', ['color'] = '#000000' })
        Citizen.Wait(5000)
        Citizen.Wait(1000)
        DoScreenFadeOut(800)
        Citizen.Wait(3000)
        
        SetEntityCoordsNoOffset(playerPed, -54.45, -1094.97, 27.56, false, false, false, true)
        FreezeEntityPosition(playerPed, true)
        SetFocusEntity(playerPed)
        Citizen.Wait(800)
        SetCamCoord(cam, -54.45, -1094.97, 27.56)
        RenderScriptCams(1, 0, 0, 1, 1)
        SetCamRot(cam, 0.0, 0.0, 11.58)
        DoScreenFadeIn(800)
        Citizen.Wait(1000)
        exports['NRP-notify']:DoCustomHudText('inform', 'Garage Upgrades & Transfers <br><br> When you have stored your first car, you can come back to PDM to transfer it to another garage or upgrade the garage capacity!', 8000, { ['text-align'] = 'center', ['background-color'] = '#2a9946', ['color'] = '#000000' })
        Citizen.Wait(8000)
        Citizen.Wait(1000)
        exports['NRP-notify']:DoCustomHudText('inform', 'If you wish to transfer a vehicle to another garage, you simply select the garage you wish to move to and then the vehicle.', 7000, { ['text-align'] = 'center', ['background-color'] = '#2a9946', ['color'] = '#000000' })
        Citizen.Wait(7000)
        Citizen.Wait(1000)
        exports['NRP-notify']:DoCustomHudText('inform', 'Wanting to upgrade your garage capacity? No worries! You can do this at $500 per slot.', 5000, { ['text-align'] = 'center', ['background-color'] = '#2a9946', ['color'] = '#000000' })
        Citizen.Wait(5000)
        Citizen.Wait(1000)
        DoScreenFadeOut(800)
        Citizen.Wait(3000)

        SetEntityCoordsNoOffset(playerPed, -471.31, -285.89, 49.18, false, false, false, true)
        FreezeEntityPosition(playerPed, true)
        SetFocusEntity(playerPed)
        Citizen.Wait(800)
        SetCamCoord(cam, -471.31, -285.89, 49.18)
        RenderScriptCams(1, 0, 0, 1, 1)
        SetCamRot(cam, 0.0, 0.0, 53.58)
        DoScreenFadeIn(800)
        Citizen.Wait(1000)
        exports['NRP-notify']:DoCustomHudText('inform', 'City Hall <br><br> Here is the home of the Lawyers and D8 Agents. You can visit for a gun license, legal battles and house viewings.', 7000, { ['text-align'] = 'center', ['background-color'] = '#2a9946', ['color'] = '#000000' })
        Citizen.Wait(7000)
        Citizen.Wait(1000)
        exports['NRP-notify']:DoCustomHudText('inform', 'If you want a gun license, you can obtain one for $2500. If you commit a crime and go to jail, you will need to re-purchase one again.', 8000, { ['text-align'] = 'center', ['background-color'] = '#2a9946', ['color'] = '#000000' })
        Citizen.Wait(8000)
        Citizen.Wait(1000)
        exports['NRP-notify']:DoCustomHudText('inform', 'Have you been wrongfully prosecuted? Suffered from police brutality? You can also pick yourself up a lawyer from here too!', 6000, { ['text-align'] = 'center', ['background-color'] = '#2a9946', ['color'] = '#000000' })
        Citizen.Wait(6000)
        Citizen.Wait(1000)
        exports['NRP-notify']:DoCustomHudText('inform', 'You can also contact a D8 Agent about taking a look at a show-room if you want to get on the property market in Los Santos.', 7000, { ['text-align'] = 'center', ['background-color'] = '#2a9946', ['color'] = '#000000' })
        Citizen.Wait(7000)
        Citizen.Wait(1000)
        DoScreenFadeOut(800)
        Citizen.Wait(3000)

        SetEntityCoordsNoOffset(playerPed, 305.7, -265.51, 66.35, false, false, false, true)
        FreezeEntityPosition(playerPed, true)
        SetFocusEntity(playerPed)
        Citizen.Wait(800)
        SetCamCoord(cam, 305.7, -265.51, 66.35)
        RenderScriptCams(1, 0, 0, 1, 1)
        SetCamRot(cam, 0.0, 0.0, 339.23)
        DoScreenFadeIn(800)
        Citizen.Wait(1000)
        exports['NRP-notify']:DoCustomHudText('inform', 'City Motels <br><br> Don\'t have enough money for that dream house? No worries, you can rent a motel all over the city!', 6000, { ['text-align'] = 'center', ['background-color'] = '#2a9946', ['color'] = '#000000' })
        Citizen.Wait(6000)
        Citizen.Wait(1000)
        exports['NRP-notify']:DoCustomHudText('inform', 'You can only rent one at a time but they are handy for temporary storage and a place to stay at night.', 6000, { ['text-align'] = 'center', ['background-color'] = '#2a9946', ['color'] = '#000000' })
        Citizen.Wait(6000)
        Citizen.Wait(1000)
        exports['NRP-notify']:DoCustomHudText('inform', 'Make sure to top up your rent if you plan on staying long term, you can do this at the yellow circle management blip.', 7000, { ['text-align'] = 'center', ['background-color'] = '#2a9946', ['color'] = '#000000' })
        Citizen.Wait(7000)
        Citizen.Wait(1000)
        exports['NRP-notify']:DoCustomHudText('inform', 'You can find other motels dotted around your map as a orange house icon. All motels charge the same rate so don\'t worry!', 6000, { ['text-align'] = 'center', ['background-color'] = '#2a9946', ['color'] = '#000000' })
        Citizen.Wait(6000)
        Citizen.Wait(1000)
        DoScreenFadeOut(800)
        Citizen.Wait(3000)

        SetEntityCoordsNoOffset(playerPed, 419.40, -810.44, 30.56, false, false, false, true)
        FreezeEntityPosition(playerPed, true)
        SetFocusEntity(playerPed)
        Citizen.Wait(800)
        SetCamCoord(cam, 419.40, -810.44, 30.56)
        RenderScriptCams(1, 0, 0, 1, 1)
        SetCamRot(cam, 0.0, 0.0, 305.50)
        DoScreenFadeIn(800)
        Citizen.Wait(1000)
        exports['NRP-notify']:DoCustomHudText('inform', 'Clothing Stores <br><br> You must customise your outfit as one of your priorities. Otherwise, people will refuse to talk to you because of your generic outfit.', 7000, { ['text-align'] = 'center', ['background-color'] = '#2a9946', ['color'] = '#000000' })
        Citizen.Wait(7000)
        Citizen.Wait(1000)
        exports['NRP-notify']:DoCustomHudText('inform', 'The yellow arrow at the back is where you can customise your outfit. The top bar of the customiser is to set what item of clothing you would like to customise, then you use the bars below to set the variant.', 12000, { ['text-align'] = 'center', ['background-color'] = '#2a9946', ['color'] = '#000000' })
        Citizen.Wait(12000)
        Citizen.Wait(1000)
        exports['NRP-notify']:DoCustomHudText('inform', 'The green circle is where you can create a save of the outfit you currently have. There is no limit to how many outfits you can save so go wild!', 9000, { ['text-align'] = 'center', ['background-color'] = '#2a9946', ['color'] = '#000000' })
        Citizen.Wait(9000)
        Citizen.Wait(1000)
        exports['NRP-notify']:DoCustomHudText('inform', 'If you would like to go back to the home screen, make your way into the back room and find the changing room. You can use this to switch character or make a new one.', 10000, { ['text-align'] = 'center', ['background-color'] = '#2a9946', ['color'] = '#000000' })
        Citizen.Wait(10000)
        Citizen.Wait(1000)
        DoScreenFadeOut(800)
        Citizen.Wait(3000)

        SetEntityCoordsNoOffset(playerPed, 137.27, -1443.60, 31.56, false, false, false, true)
        FreezeEntityPosition(playerPed, true)
        SetFocusEntity(playerPed)
        Citizen.Wait(800)
        SetCamCoord(cam, 137.27, -1443.60, 31.56)
        RenderScriptCams(1, 0, 0, 1, 1)
        SetCamRot(cam, 0.0, 0.0, 192.66)
        DoScreenFadeIn(800)
        Citizen.Wait(1000)
        exports['NRP-notify']:DoCustomHudText('inform', 'Fast Food Restaurants <br><br> These will be your favorite place to visit in the city. If you don\'t, you will die.', 6000, { ['text-align'] = 'center', ['background-color'] = '#2a9946', ['color'] = '#000000' })
        Citizen.Wait(6000)
        Citizen.Wait(1000)
        exports['NRP-notify']:DoCustomHudText('inform', 'You will need to make sure you are topped up with food and water otherwise you may feel yourself fading out from reality.', 6000, { ['text-align'] = 'center', ['background-color'] = '#2a9946', ['color'] = '#000000' })
        Citizen.Wait(6000)
        Citizen.Wait(1000)
        exports['NRP-notify']:DoCustomHudText('inform', 'To purchase food, simply go through the drive-thru and put your order in or you can purchase food and water at 24/7 stores for a higher price.', 8000, { ['text-align'] = 'center', ['background-color'] = '#2a9946', ['color'] = '#000000' })
        Citizen.Wait(8000)
        Citizen.Wait(1000)
        DoScreenFadeOut(800)
        Citizen.Wait(3000)

        SetEntityCoordsNoOffset(playerPed, 313.67, -593.17, 44.79, false, false, false, true)
        FreezeEntityPosition(playerPed, true)
        SetFocusEntity(playerPed)
        Citizen.Wait(800)
        SetCamCoord(cam, 313.67, -593.17, 44.79)
        RenderScriptCams(1, 0, 0, 1, 1)
        SetCamRot(cam, 0.0, 0.0, 89.29)
        DoScreenFadeIn(800)
        Citizen.Wait(1000)
        exports['NRP-notify']:DoCustomHudText('inform', 'The Hospital <br><br> If you are not feeling your best, taking a trip down to the hospital will be in your best interest.', 6000, { ['text-align'] = 'center', ['background-color'] = '#2a9946', ['color'] = '#000000' })
        Citizen.Wait(6000)
        Citizen.Wait(1000)
        exports['NRP-notify']:DoCustomHudText('inform', 'If you have any injuries or you are completely blacked out, you can come and check in at the desk or get a friend to bring you here in their trunk.', 9000, { ['text-align'] = 'center', ['background-color'] = '#2a9946', ['color'] = '#000000' })
        Citizen.Wait(9000)
        Citizen.Wait(1000)
        exports['NRP-notify']:DoCustomHudText('inform', 'If you are completely stranded and find yourself blacking out, look in your phones favorites for the Ambulance service.', 5000, { ['text-align'] = 'center', ['background-color'] = '#2a9946', ['color'] = '#000000' })
        Citizen.Wait(5000)
        Citizen.Wait(1000)
        DoScreenFadeOut(800)
        Citizen.Wait(3000)

        SetEntityCoordsNoOffset(playerPed, 321.31, -575.96, 44.09, false, false, false, true)
        FreezeEntityPosition(playerPed, true)
        SetFocusEntity(playerPed)
        Citizen.Wait(800)
        SetCamCoord(cam, 321.31, -575.96, 44.09)
        RenderScriptCams(1, 0, 0, 1, 1)
        SetCamRot(cam, 0.0, 0.0, 217.22)
        DoScreenFadeIn(800)
        Citizen.Wait(1000)
        exports['NRP-notify']:DoCustomHudText('inform', 'The Pharmacies <br><br> Make sure you stock up on medical supplies to keep yourself safe out there.', 5000, { ['text-align'] = 'center', ['background-color'] = '#2a9946', ['color'] = '#000000' })
        Citizen.Wait(5000)
        Citizen.Wait(1000)
        exports['NRP-notify']:DoCustomHudText('inform', 'Here is the cheapest pharmacy in the city which is inside the hospital. You can find others dotted around your map as a red pill icon.', 7000, { ['text-align'] = 'center', ['background-color'] = '#2a9946', ['color'] = '#000000' })
        Citizen.Wait(7000)
        Citizen.Wait(1000)
        exports['NRP-notify']:DoCustomHudText('inform', 'A Human Fixkit will completely remove all bleeding and wounds so be sure to carry multiple of these.', 5000, { ['text-align'] = 'center', ['background-color'] = '#2a9946', ['color'] = '#000000' })
        Citizen.Wait(5000)
        Citizen.Wait(1000)
        exports['NRP-notify']:DoCustomHudText('inform', 'Is your friend down and you\'re feeling lucky? Emergency Medkits will give you a 50/50 chance at getting your buddy up!', 6000, { ['text-align'] = 'center', ['background-color'] = '#2a9946', ['color'] = '#000000' })
        Citizen.Wait(6000)
        Citizen.Wait(1000)
        DoScreenFadeOut(800)
        Citizen.Wait(3000)

        SetEntityCoordsNoOffset(playerPed, 2808.49, 3450.7, 66.69, false, false, false, true)
        FreezeEntityPosition(playerPed, true)
        SetFocusEntity(playerPed)
        Citizen.Wait(800)
        SetCamCoord(cam, 2808.49, 3450.7, 66.69)
        RenderScriptCams(1, 0, 0, 1, 1)
        SetCamRot(cam, 0.0, 0.0, 67.55)
        DoScreenFadeIn(800)
        Citizen.Wait(1000)
        exports['NRP-notify']:DoCustomHudText('inform', 'The Tool Store <br><br> Need any job related items or maybe you\'re missing something for a "recipe"? Here\'s your store.', 6000, { ['text-align'] = 'center', ['background-color'] = '#2a9946', ['color'] = '#000000' })
        Citizen.Wait(6000)
        Citizen.Wait(1000)
        exports['NRP-notify']:DoCustomHudText('inform', 'You can get anything from storage boxes all the way to fishing rod and some bait. It seems like they have some questionable items too.', 7000, { ['text-align'] = 'center', ['background-color'] = '#2a9946', ['color'] = '#000000' })
        Citizen.Wait(7000)
        Citizen.Wait(1000)
        DoScreenFadeOut(800)
        Citizen.Wait(3000)

        SetEntityCoordsNoOffset(playerPed, 513.07, -1284.81, 240.27, false, false, false, true)
        FreezeEntityPosition(playerPed, true)
        SetFocusEntity(playerPed)
        Citizen.Wait(800)
        SetCamCoord(cam, 513.07, -1284.81, 240.27)
        RenderScriptCams(1, 0, 0, 1, 1)
        SetCamRot(cam, 0.0, 0.0, 40.64)
        DoScreenFadeIn(800)
        Citizen.Wait(1000)
        exports['NRP-notify']:DoCustomHudText('inform', 'End of the Tour <br><br> Thank you for your patience whilst we went over the basics. I am sure you will get on just fine!', 7000, { ['text-align'] = 'center', ['background-color'] = '#2a9946', ['color'] = '#000000' })
        Citizen.Wait(7000)
        Citizen.Wait(1000)
        exports['NRP-notify']:DoCustomHudText('inform', 'Just remember, the city hides some of the greatest secrets such as money washes, drug locations, gun shipments and more.', 6000, { ['text-align'] = 'center', ['background-color'] = '#2a9946', ['color'] = '#000000' })
        Citizen.Wait(6000)
        Citizen.Wait(1000)
        exports['NRP-notify']:DoCustomHudText('inform', 'We hope you enjoy your stay here, any questions just ask over Twitter but make sure you stay in character and keep it legal!', 7000, { ['text-align'] = 'center', ['background-color'] = '#2a9946', ['color'] = '#000000' })
        Citizen.Wait(7000)
        Citizen.Wait(1000)
        DoScreenFadeOut(800)
        Citizen.Wait(3000)

        --SetEntityCoordsNoOffset(playerPed, -195.14, -830.31, 31.08, false, false, false, true)
        SetEntityCoordsNoOffset(playerPed, coords.x, coords.y, coords.z, false, false, false, true)
        FreezeEntityPosition(playerPed, true)
        SetEntityVisible(playerPed, true, 0)
        FreezeEntityPosition(playerPed, false)
        SetFocusEntity(playerPed)
        ClearFocus()
        RenderScriptCams(false, false, 0, true, false)
        DoScreenFadeIn(800)
        Citizen.Wait(1000)
        DestroyCam(cam, true)
        cam = nil
        exports['NRP-notify']:DoCustomHudText('inform', 'You can always view the tutorial again by using the "/tutorial" command.', 5000, { ['text-align'] = 'center', ['background-color'] = '#2a9946', ['color'] = '#000000' })
    end
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

secondsUntilKick = 900
kickWarning = true

Citizen.CreateThread(function()
	while true do
		Wait(1000)

		playerPed = GetPlayerPed(-1)
		if playerPed then
			currentPos = GetEntityCoords(playerPed, true)

			if currentPos == prevPos and not IsPedDeadOrDying(playerPed) then
				if time > 0 then
					if kickWarning and time == math.ceil(secondsUntilKick / 4) then
						TriggerEvent("chatMessage", "WARNING", {255, 0, 0}, "^1 You'll be kicked in " .. time .. " second(s) for being AFK!")
					end

					time = time - 1
				else
					TriggerServerEvent("core:afkkick")
				end
			else
				time = secondsUntilKick
			end

			prevPos = currentPos
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
    if id == 6 then
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