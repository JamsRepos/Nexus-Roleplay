local player_weapons = {}

local weapons = {
 [453432689] = true, -- PISTOL
 [3219281620] = false, -- PISTOL MK2
 [1593441988] = true, -- COMBAT PISTOL
 [584646201] = false, -- AP PISTOL
 [2578377531] = false, -- PISTOL .50
 [324215364] = false, -- MICRO SMG
 [736523883] = false, -- SMG
 [2024373456] = false, -- SMG MK2
 [4024951519] = false, -- ASSAULT SMG
 [3220176749] = false, -- ASSAULT RIFLE
 [961495388] = false, -- ASSAULT RIFLE MK2
 [2210333304] = false, -- CARBINE RIFLE
 [4208062921] = false, -- CARBINE RIFLE MK2
 [2937143193] = false, -- ADVANCED RIFLE
 [2634544996] = false, -- MG
 [2144741730] = false, -- COMBAT MG
 [3686625920] = false, -- COMBAT MG MK2
 [487013001] = false, -- PUMP SHOTGUN
 [1432025498] = false, -- PUMP SHOTGUN MK2
 [2017895192] = false, -- SAWNOFF SHOTGUN
 [3800352039] = false, -- ASSAULT SHOTGUN
 [2640438543] = false, -- BULLPUP SHOTGUN
 [100416529] = false, -- SNIPER RIFLE
 [205991906] = false, -- HEAVY SNIPER
 [177293209] = false, -- HEAVY SNIPER MK2
 [856002082] = false, -- REMOTE SNIPER
 [2726580491] = false, -- GRENADE LAUNCHER
 [1305664598] = false, -- GRENADE LAUNCHER SMOKE
 [2982836145] = false, -- RPG
 [1752584910] = false, -- STINGER
 [1119849093] = false, -- MINIGUN
 [3218215474] = true, -- SNS PISTOL
 [2009644972] = false, -- SNS PISTOL MK2
 [1627465347] = false, -- GUSENBERG
 [3231910285] = false, -- SPECIAL CARBINE
 [-1768145561] = false, -- SPECIAL CARBINE MK2
 [3523564046] = false, -- HEAVY PISTOL
 [2132975508] = false, -- BULLPUP RIFLE
 [-2066285827] = false, -- BULLPUP RIFLE MK2
 [137902532] = false, -- VINTAGE PISTOL
 [-1746263880] = false, -- DOUBLE ACTION REVOLVER
 [2828843422] = false, -- MUSKET
 [984333226] = false, -- HEAVY SHOTGUN
 [3342088282] = false, -- MARKSMAN RIFLE
 [1785463520] = false, -- MARKSMAN RIFLE MK2
 [1198879012] = false, -- FLARE GUN
 [171789620] = false, -- COMBAT PDW
 [3696079510] = false, -- MARKSMAN PISTOL
 [1834241177] = false, -- RAILGUN
 [3675956304] = false, -- MACHINE PISTOL
 [3249783761] = false, -- REVOLVER
 [-879347409] = false, -- REVOLVER MK2
 [4019527611] = false, -- DOUBLE BARREL SHOTGUN
 [1649403952] = false, -- COMPACT RIFLE
 [317205821] = false, -- AUTO SHOTGUN
 [125959754] = false, -- COMPACT LAUNCHER
 [3173288789] = false, -- MINI SMG     
}

RegisterNetEvent("weapon:updateitems")
AddEventHandler("weapon:updateitems", function(inv)
    player_weapons = {}
    player_weapons = inv
end)


Citizen.CreateThread(function()
 while true do
  Citizen.Wait(100)
  if IsPedShooting(GetPlayerPed(-1)) and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
   local _, weapon = GetCurrentPedWeapon(PlayerPedId())
   if weapons[weapon] == true then
    if getSerialNumber() then 
     local pos = GetEntityCoords(GetPlayerPed(-1), false)    
     TriggerServerEvent('weapons:dropShell', getSerialNumber(), {x = pos.x, y = pos.y, z = pos.z})
     Wait(50)
    end
   end
  end
 end
end)

function getSerialNumber()
 local q, weapon = GetCurrentPedWeapon(PlayerPedId())
 for _,v in pairs(player_weapons) do 
  if GetHashKey(v.name) == weapon then 
   return {serial = tostring('WSN'..v.id), name = v.label, noserial = v.blackmarket}
  end
 end
end

local droppedShells = {}

RegisterNetEvent("weapons:updateShells")
AddEventHandler("weapons:updateShells", function(shells)
 droppedShells = shells
end)

Citizen.CreateThread(function()
 while true do
  Wait(5)
  local coords = GetEntityCoords(GetPlayerPed(-1))
  for k,v in pairs(droppedShells) do
   if(GetDistanceBetweenCoords(coords, v.pos.x, v.pos.y, v.pos.z, true) < 10.0) and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
    if(GetDistanceBetweenCoords(coords, v.pos.x, v.pos.y, v.pos.z, true) < 0.8) and not DecorGetBool(GetPlayerPed(-1), "isOfficer") then
     drawTxt('~g~[E]~w~ Pick-Up Bullet Casing')
     if IsControlJustPressed(0, 38) then
      TaskPlayAnim(GetPlayerPed(-1), "anim@mp_snowball", "pickup_snowball", 8.0, -1, -1, false, 1, 0, 0, 0)
      TriggerServerEvent("weapons:removeShell", k)
     end
    elseif(GetDistanceBetweenCoords(coords, v.pos.x, v.pos.y, v.pos.z, true) < 0.8) and DecorGetBool(GetPlayerPed(-1), "isOfficer") and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
     drawTxt('~g~[E]~w~ Collect Evidence')
     if IsControlJustPressed(0, 38) then
      TaskPlayAnim(GetPlayerPed(-1), "anim@mp_snowball", "pickup_snowball", 8.0, -1, -1, false, 1, 0, 0, 0)	
      TriggerServerEvent("weapons:collectShell", k)
     end
    end
   end
  end
 end
end)

local scopedWeapons = 
{
    100416529,  -- WEAPON_SNIPERRIFLE
    205991906,  -- WEAPON_HEAVYSNIPER
    3342088282, -- WEAPON_MARKSMANRIFLE
	177293209,   -- WEAPON_HEAVYSNIPER MKII
	1785463520  -- WEAPON_MARKSMANRIFLE_MK2
}


local nearObject = false 
local isNearObject = false
local objectLoc = {}
local clostestProp = nil
local label = "Sprunk"
local models = {
  [1] = 1114264700,
  
  
}

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(1500)
  nearObject = false
  isNearObject = false
  local myCoords = GetEntityCoords(GetPlayerPed(-1))
   
  for i = 1, #models do
   clostestProp = GetClosestObjectOfType(myCoords.x, myCoords.y, myCoords.z, 2.5, models[i], false, false)
   if clostestProp ~= nil and clostestProp ~= 0 then
    local coords = GetEntityCoords(clostestProp)
    isNearObject = true
    objectLoc = {['x'] = coords.x, ['y'] = coords.y, ['z'] = coords.z + 1.2}
    break
   end
  end
 end
end)

Citizen.CreateThread(function()
 while true do
  Wait(5)
  if isNearObject then 
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), objectLoc.x, objectLoc.y, objectLoc.z-0.5, true) < 1.3) then
    DrawText3Ds(objectLoc.x, objectLoc.y, objectLoc.z,'~g~[E]~w~ Buy Sprunk ~g~$5') 
	if IsControlJustPressed(0, 38) then
		TaskStartScenarioInPlace(GetPlayerPed(-1), 'PROP_HUMAN_ATM', false, true) Wait(3000) ClearPedTasksImmediately(GetPlayerPed(-1))
		TriggerServerEvent('shops:purchase', label, 5, 1, 259)
    end
   end ---- add shared banking to vending machines then somecan buy them
   end
 end
end)


function HashInTable( hash )
    for k, v in pairs( scopedWeapons ) do 
        if ( hash == v ) then 
            return true 
        end 
    end 

    return false 
end 

function ManageReticle()
    local ped = GetPlayerPed( -1 )
    local _, hash = GetCurrentPedWeapon( ped, true )
        if not HashInTable( hash ) then 
            HideHudComponentThisFrame( 14 )
		end 
end 


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local ped = GetPlayerPed( -1 )
		local weapon = GetSelectedPedWeapon(ped)
        -- Disable reticle
		
		ManageReticle()
		
		-- Disable ammo HUD
		
        DisplayAmmoThisFrame(false)
    
        -- Shakycam
		--[[
		-- Pistol
		if weapon == GetHashKey("WEAPON_STUNGUN") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.01)
			end
		end
		
		if weapon == GetHashKey("WEAPON_FLAREGUN") then	
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.01)
			end
		end
		
		if weapon == GetHashKey("WEAPON_SNSPISTOL") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.02)
			end
		end
		
		if weapon == GetHashKey("WEAPON_SNSPISTOL_MK2") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.025)
			end
		end
		
		if weapon == GetHashKey("WEAPON_PISTOL") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.025)
			end
		end
		
		if weapon == GetHashKey("WEAPON_PISTOL_MK2") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.03)
			end
		end
		
		if weapon == GetHashKey("WEAPON_APPISTOL") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05)
			end
		end
		
		if weapon == GetHashKey("WEAPON_COMBATPISTOL") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.03)
			end
		end
		
		if weapon == GetHashKey("WEAPON_PISTOL50") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05)
			end
		end
		
		if weapon == GetHashKey("WEAPON_HEAVYPISTOL") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.03)
			end
		end
		
		if weapon == GetHashKey("WEAPON_VINTAGEPISTOL") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.025)
			end
		end
		
		if weapon == GetHashKey("WEAPON_MARKSMANPISTOL") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.03)
			end
		end
		
		if weapon == GetHashKey("WEAPON_REVOLVER") then	
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.045)
			end
		end
		
		if weapon == GetHashKey("WEAPON_REVOLVER_MK2") then	
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.055)
			end
		end
		
		if weapon == GetHashKey("WEAPON_DOUBLEACTION") then	
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.025)
			end
		end
		-- SMG
		
		if weapon == GetHashKey("WEAPON_MICROSMG") then	
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.035)
			end
		end
		
		if weapon == GetHashKey("WEAPON_COMBATPDW") then			
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.045)
			end
		end
		
		if weapon == GetHashKey("WEAPON_SMG") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.045)
			end
		end
		
		if weapon == GetHashKey("WEAPON_SMG_MK2") then	
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.055)
			end
		end
		
		if weapon == GetHashKey("WEAPON_ASSAULTSMG") then	
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.050)
			end
		end
		
		if weapon == GetHashKey("WEAPON_MACHINEPISTOL") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.035)
			end
		end
		
		if weapon == GetHashKey("WEAPON_MINISMG") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.035)
			end
		end
		
		if weapon == GetHashKey("WEAPON_MG") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.07)
			end
		end
		
		if weapon == GetHashKey("WEAPON_COMBATMG") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)
			end
		end
		
		if weapon == GetHashKey("WEAPON_COMBATMG_MK2") then			
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.085)
			end
		end
		
		-- Rifles
		
		if weapon == GetHashKey("WEAPON_ASSAULTRIFLE") then			
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.07)
			end
		end
		
		if weapon == GetHashKey("WEAPON_ASSAULTRIFLE_MK2") then			
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.075)
			end
		end
		
		if weapon == GetHashKey("WEAPON_CARBINERIFLE") then	
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.06)
			end
		end
		
		if weapon == GetHashKey("WEAPON_CARBINERIFLE_MK2") then			
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.065)
			end
		end
		
		if weapon == GetHashKey("WEAPON_ADVANCEDRIFLE") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.06)
			end
		end
		
		if weapon == GetHashKey("WEAPON_GUSENBERG") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05)
			end
		end
		
		if weapon == GetHashKey("WEAPON_SPECIALCARBINE") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.06)
			end
		end
		
		if weapon == GetHashKey("WEAPON_SPECIALCARBINE_MK2") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.075)
			end
		end
		
		if weapon == GetHashKey("WEAPON_BULLPUPRIFLE") then			
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05)
			end
		end
		
		if weapon == GetHashKey("WEAPON_BULLPUPRIFLE_MK2") then			
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.065)
			end
		end
		
		if weapon == GetHashKey("WEAPON_COMPACTRIFLE") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05)
			end
		end
		
		-- Shotgun
		
		if weapon == GetHashKey("WEAPON_PUMPSHOTGUN") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.07)
			end
		end
		
		if weapon == GetHashKey("WEAPON_PUMPSHOTGUN_MK2") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.085)
			end
		end
		
		if weapon == GetHashKey("WEAPON_SAWNOFFSHOTGUN") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.06)
			end
		end
		
		if weapon == GetHashKey("WEAPON_ASSAULTSHOTGUN") then	
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.12)
			end
		end
		
		if weapon == GetHashKey("WEAPON_BULLPUPSHOTGUN") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)
			end
		end
		
		if weapon == GetHashKey("WEAPON_DBSHOTGUN") then	
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.05)
			end
		end
		
		if weapon == GetHashKey("WEAPON_AUTOSHOTGUN") then	
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)
			end
		end
		
		if weapon == GetHashKey("WEAPON_MUSKET") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.04)
			end
		end
		
		if weapon == GetHashKey("WEAPON_HEAVYSHOTGUN") then	
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.13)
			end
		end
		
		-- Sniper
		
		if weapon == GetHashKey("WEAPON_SNIPERRIFLE") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.2)
			end
		end
		
		if weapon == GetHashKey("WEAPON_HEAVYSNIPER") then	
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.3)
			end
		end
		
		if weapon == GetHashKey("WEAPON_HEAVYSNIPER_MK2") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.35)
			end
		end
		
		if weapon == GetHashKey("WEAPON_MARKSMANRIFLE") then			
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.1)
			end
		end
		
		if weapon == GetHashKey("WEAPON_MARKSMANRIFLE_MK2") then			
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.1)
			end
		end
		
		-- Launcher
		
		if weapon == GetHashKey("WEAPON_GRENADELAUNCHER") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)
			end
		end
		
		if weapon == GetHashKey("WEAPON_RPG") then
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.9)
			end
		end
		
		if weapon == GetHashKey("WEAPON_HOMINGLAUNCHER") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.9)
			end
		end
		
		if weapon == GetHashKey("WEAPON_MINIGUN") then	
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.20)
			end
		end
		
		if weapon == GetHashKey("WEAPON_RAILGUN") then	
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 1.0)
				
			end
		end
		
		if weapon == GetHashKey("WEAPON_COMPACTLAUNCHER") then		
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)
			end
		end
		
		if weapon == GetHashKey("WEAPON_FIREWORK") then	
			if IsPedShooting(ped) then
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.5)
			end
		end
		]]--
		
		-- Infinite FireExtinguisher
		
		if weapon == GetHashKey("WEAPON_FIREEXTINGUISHER") then		
			if IsPedShooting(ped) then
				SetPedInfiniteAmmo(ped, true, GetHashKey("WEAPON_FIREEXTINGUISHER"))
			end
		end
	end
end)

