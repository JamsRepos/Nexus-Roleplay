local recoils = {
    [453432689] = 1.1, -- PISTOL
    [3219281620] = 1.1, -- PISTOL MK2
    [1593441988] = 1.1, -- COMBAT PISTOL
    [584646201] = 1.1, -- AP PISTOL
    [-1716589765] = 1.3, -- PISTOL .50
    [324215364] = 0.1, -- MICRO SMG
    [736523883] = 0.1, -- SMG
    [2024373456] = 0.1, -- SMG MK2
    [4024951519] = 0.1, -- ASSAULT SMG
    [3220176749] = 1.024, -- ASSAULT RIFLE
    [961495388] = 0.523, -- ASSAULT RIFLE MK2
    [-2084633992] = 0.201, -- CARBINE RIFLE
    [4208062921] = 0.315, -- CARBINE RIFLE MK2
    [2937143193] = 0.111, -- ADVANCED RIFLE
    [2634544996] = 0.716, -- MG
    [2144741730] = 0.817, -- COMBAT MG
    [3686625920] = 0.716, -- COMBAT MG MK2
    [487013001] = 1.2, -- PUMP SHOTGUN
    [2017895192] = 0.7, -- SAWNOFF SHOTGUN
    [3800352039] = 0.4, -- ASSAULT SHOTGUN
    [2640438543] = 0.4, -- BULLPUP SHOTGUN
    [911657153] = 0.0, -- STUN GUN
    [100416529] = 0.5, -- SNIPER RIFLE
    [205991906] = 2.0, -- HEAVY SNIPER
    [177293209] = 0.7, -- HEAVY SNIPER MK2
    [856002082] = 1.2, -- REMOTE SNIPER
    [2726580491] = 1.0, -- GRENADE LAUNCHER
    [1305664598] = 1.0, -- GRENADE LAUNCHER SMOKE
    [2982836145] = 0.0, -- RPG
    [1752584910] = 0.0, -- STINGER
    [1119849093] = 0.01, -- MINIGUN
    [-1076751822] = 1.1, -- SNS PISTOL
    [1627465347] = 0.1, -- GUSENBERG
    [3231910285] = 0.011, -- SPECIAL CARBINE
    [3523564046] = 0.5, -- HEAVY PISTOL
    [2132975508] = 0.2, -- BULLPUP RIFLE
    [137902532] = 1.2, -- VINTAGE PISTOL
    [2828843422] = 0.7, -- MUSKET
    [984333226] = 0.2, -- HEAVY SHOTGUN
    [3342088282] = 0.3, -- MARKSMAN RIFLE
    [1672152130] = 0.3, -- HOMING LAUNCHER
    [1198879012] = 0.9, -- FLARE GUN
    [171789620] = 0.1, -- COMBAT PDW
    [3696079510] = 0.9, -- MARKSMAN PISTOL
    [1834241177] = 2.4, -- RAILGUN
    [3675956304] = 0.31, -- MACHINE PISTOL
    [3249783761] = 1.2, -- REVOLVER
    [4019527611] = 0.7, -- DOUBLE BARREL SHOTGUN
    [1649403952] = 0.453, -- COMPACT RIFLE
    [317205821] = 0.2, -- AUTO SHOTGUN
    [125959754] = 0.5, -- COMPACT LAUNCHER
    [3173288789] = 0.3, -- MINI SMG     
}

local myRecoilFactor = 1.5

Citizen.CreateThread( function()

	
	while true do 
	  
	   if IsPedArmed(GetPlayerPed(-1), 6) then
		   Citizen.Wait(1)
	   else
		   Citizen.Wait(1500)
	   end   
  
		  if IsPedShooting(PlayerPedId()) then
  
			  local _,wep = GetCurrentPedWeapon(PlayerPedId())
			  _,cAmmo = GetAmmoInClip(PlayerPedId(), wep)
			  if recoils[wep] and recoils[wep] ~= 0 then
				  tv = 0
				  if GetFollowPedCamViewMode() == 4 then
					  p = GetGameplayCamRelativePitch()
					  recoiling = 2
					  while recoiling > 0 do
  
						  possiblerecoil = math.random(math.ceil(recoils[wep] * 400))
						  recoilfactor = possiblerecoil/100
						  dicks = math.random(100)
						  recoilfactor = recoilfactor + myRecoilFactor
						  SetGameplayCamRelativePitch(p+recoilfactor,0.5)
  
						  
						  recoiling = recoiling - 1
					  end
				  else
					  p = GetGameplayCamRelativePitch()
					  recoiling = 3
					  while recoiling > 0 do
  
						   possiblerecoil = math.random(math.ceil(recoils[wep] * 450))
						  recoilfactor = possiblerecoil/100
						  dicks = math.random(100)
						  recoilfactor = recoilfactor + myRecoilFactor
						  SetGameplayCamRelativePitch(p+recoilfactor,0.25)                      
						  recoiling = recoiling - 1
					  end
				  end
  
			  end
		  end
	  end
  end)