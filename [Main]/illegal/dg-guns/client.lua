----------------------------------------------
--                                          --
-- ITEM IDS:                                --
--                                          --
-- * PipeBomb:                185           --
-- * Pistol:                  186           --
-- * Combat Pistol:           187           --
-- * Pistol Mk2:              188           --
-- * Service Pistol:          189           --
-- * Micro SMG:               190           --
-- * Baseball:                191           --
-- * Pipe Wrench:             192           --
-- * Carbine Rifle Mk2:       193           --
-- * Service Rifle:           194           --
-- * Combat PDW:              195           --
-- * Service PDW:             196           --
-- * Flashlight:              197           --
-- * Taser:                   198           --
-- * Pump Shotgun:            199           --
-- * Service Shotgun:         200           --
-- * Switchblade:             201           --
-- * Knuckle Dusters:         202           --
-- * Hatchet:                 203           --
-- * Molotov:                 204           --
-- * Gas Can:                 205           --
-- * Assault Rifle:           206           --
-- * Sawn-Off Shotgun:        207           --
-- * Double Barrel Shotgun:   208           --
-- * Gusenberg Sweeper:       209           --
-- * Machette:                210           --
-- * Poolcue:                 211           --
-- * Knife:                   212           --
-- * Nightstick:              213           --
-- * Hammer:                  214           --
-- * Bat:                     215           --
-- * Golf Club:               216           --
-- * Crowbar:                 217           --
-- * AP Pistol:               218           --
-- * Pistol .50:              219           --
-- * SMG:                     220           --
-- * Assault SMG:             221           --
-- * Carbine Rifle:           222           --
-- * Assault Rifle:           223           --
-- * MG:                      224           --
-- * Combat MG:               225           --
-- * Assault Shotgun:         226           --
-- * Bullpup Shotgun:         227           --
-- * Sniper Rifle:            228           --
-- * Heavy Sniper:            229          --
-- * Fire Extinguisher:       230           --
-- * Flare:                   231           --
-- * SNS Pistol:              232           --
-- * Special Carbine:         233           --
-- * Heavy Pistol:            234           --
-- * Bullpup Rifle:           235           --
-- * Vintage Pistol:          236           --
-- * Antique Dagger:          237           --
-- * Musket:                  238           --
-- * Marksman Rifle:          239           --
-- * Heavy Shotgun:           240           --
-- * Marksman Pistol:         241           --
-- * Machine Pistol:          242           --
-- * Revolver:                243           --
-- * Compact Rifle:           244           --
-- * Flaregun:                245           --
-- * Battle Axe:              246           --
-- * Mini SMG:                247           --
-- * Auto Shotgun:            248           --
-- * Double Action:           249           --
-- * Tear Gas:                301           --
----------------------------------------------

Citizen.CreateThread(function()
  while true do
    Wait(0)
    --Pipebombs (185)
    local haspipebombitem = exports['core']:GetItemQuantity(185) >= 1
    local haspipebomb = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_PIPEBOMB"), false)
    if haspipebombitem and not haspipebomb then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PIPEBOMB"), 1, false, false)
    end
    if not haspipebombitem and haspipebomb then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_PIPEBOMB"))
      TriggerEvent('weapons:updateback')
    end
    Wait(1500)
    if GetAmmoInPedWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_PIPEBOMB")) < 1 then
      TriggerEvent("inventory:removeQty", 185, 1)
    end
    ---------------

    --Molotov (204)
    local hasmolotovitem = exports['core']:GetItemQuantity(204) >= 1
    local hasmolotov = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_MOLOTOV"), false)
    if hasmolotovitem and not hasmolotov then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MOLOTOV"), 1, false, false)
    end
    if not hasmolotovitem and hasmolotov then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_MOLOTOV"))
      TriggerEvent('weapons:updateback')
    end
    Wait(1500)
    if GetAmmoInPedWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_MOLOTOV")) < 1 then
      TriggerEvent("inventory:removeQty", 204, 1)
    end
    ---------------

    --Flare (231)
    local hasFlareitem = exports['core']:GetItemQuantity(231) >= 1
    local hasFlare = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_FLARE"), false)
    if hasFlareitem and not hasFlare then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_FLARE"), 1, false, false)
    end
    if not hasFlareitem and hasFlare then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_FLARE"))
      TriggerEvent('weapons:updateback')
    end
    Wait(1500)
    if GetAmmoInPedWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_FLARE")) < 1 then
      TriggerEvent("inventory:removeQty", 231, 1)
    end
    ---------------

    --Pistol (186)
    local haspistolitem = exports['core']:GetItemQuantity(186) >= 1
    local haspistol = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL"), false)
    if haspistolitem and not haspistol then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL"), 120, false, false)
    end
    if not haspistolitem and haspistol then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Combat Pistol (187) & Service Glock (252)
    local hascombatpistolitem = exports['core']:GetItemQuantity(187) >= 1
    local hasserviceglockitem = exports['core']:GetItemQuantity(252) >= 1
    local hascombatpistol = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPISTOL"), false)
    if hascombatpistolitem and not hascombatpistol then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPISTOL"), 120, false, false)
    end
    if hasserviceglockitem and not hascombatpistol then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPISTOL"), 120, false, false)
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH"))
    end
    if not (hascombatpistolitem or hasserviceglockitem) and hascombatpistol then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPISTOL"))
      RemoveWeaponComponentFromPed(GetHashKey("WEAPON_COMBATPISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Pistol Mk2 (188) & Service Pistol (189)
    local haspistolmk2item = exports['core']:GetItemQuantity(188) >= 1 
    local hasservicepistolitem = exports['core']:GetItemQuantity(189) >= 1
    local hasCRTpistolitem = exports['core']:GetItemQuantity(303) >= 1
    local haspistolmk2 = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL_MK2"), false)
    if haspistolmk2item and not haspistolmk2 then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL_MK2"), 120, false, false)
    end
    if hasservicepistolitem and not haspistolmk2 then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL_MK2"), 200, false, false)
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL_MK2"), GetHashKey("COMPONENT_AT_PI_FLSH_02"))
    end
    if hasCRTpistolitem and not haspistolmk2 and not hasservicepistolitem then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL_MK2"), 200, false, false)
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL_MK2"), GetHashKey("COMPONENT_PISTOL_MK2_CLIP_02"))
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL_MK2"), GetHashKey("COMPONENT_AT_PI_FLSH_02"))
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL_MK2"), GetHashKey("COMPONENT_AT_PI_SUPP_02"))
    end
    if not (haspistolmk2item or hasservicepistolitem or hasCRTpistolitem) and haspistolmk2 then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL_MK2"))
      RemoveWeaponComponentFromPed(GetHashKey("WEAPON_PISTOL_MK2"), GetHashKey("COMPONENT_AT_PI_FLSH_02"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Micro SMG (190)
    local hasmicrosmgitem = exports['core']:GetItemQuantity(190) >= 1
    local hasmicrosmg = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_MICROSMG"), false)
    if hasmicrosmgitem and not hasmicrosmg then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MICROSMG"), 120, false, false)
    end
    if not hasmicrosmgitem and hasmicrosmg then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_MICROSMG"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Baseball (191)
    local hasballitem = exports['core']:GetItemQuantity(191) >= 1
    local hasball = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_BALL"), false)
    if hasballitem and not hasball then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_BALL"), 1, false, false)
    end
    if not hasballitem and hasball then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_BALL"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Pipe Wrench (192)
    local haswrenchitem = exports['core']:GetItemQuantity(192) >= 1
    local haswrench = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_WRENCH"), false)
    if haswrenchitem and not haswrench then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_WRENCH"), 1, false, false)
    end
    if not haswrenchitem and haswrench then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_WRENCH"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Carbine Rifle Mk2 (193) & Service Rifle (194)
    local HasCarbineRifleMk2Item = exports['core']:GetItemQuantity(193) >= 1
    local HasServiceRifleItem = exports['core']:GetItemQuantity(194) >= 1
    local HasCarbineRifleMk2 = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE_MK2"), false)
    if HasCarbineRifleMk2Item and not HasCarbineRifleMk2 then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE_MK2"), 120, false, false)
    end
    if HasServiceRifleItem and not HasCarbineRifleMk2 then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE_MK2"), 120, false, false)
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE_MK2"), GetHashKey("COMPONENT_AT_AR_AFGRIP_02"))
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE_MK2"), GetHashKey("COMPONENT_AT_AR_FLSH"))
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE_MK2"), GetHashKey("COMPONENT_AT_SIGHTS"))
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE_MK2"), GetHashKey("COMPONENT_AT_MUZZLE_04"))
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE_MK2"), GetHashKey("COMPONENT_AT_MUZZLE_04"))
    end
    if not (HasCarbineRifleMk2Item or HasServiceRifleItem) and HasCarbineRifleMk2 then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE_MK2"))
      RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE_MK2"), GetHashKey("COMPONENT_AT_AR_AFGRIP_02"))
      RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE_MK2"), GetHashKey("COMPONENT_AT_AR_FLSH"))
      RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE_MK2"), GetHashKey("COMPONENT_AT_SIGHTS"))
      RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE_MK2"), GetHashKey("COMPONENT_AT_MUZZLE_04"))
      RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE_MK2"), GetHashKey("COMPONENT_AT_MUZZLE_04"))
      TriggerEvent('weapons:updateback')   
    end
    ---------------

    --Combat PDW (195) & Service PDW (196)
    local HasCombatPDWItem = exports['core']:GetItemQuantity(195) >= 1
    local HasServicePDWItem = exports['core']:GetItemQuantity(196) >= 1
    local HasCombatPDW = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPDW"), false)
    if HasCombatPDWItem and not HasCombatPDW then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPDW"), 120, false, false)
    end
    if HasServicePDWItem and not HasCombatPDW then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPDW"), 120, false, false)
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPDW"), GetHashKey("COMPONENT_AT_AR_FLSH"))
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPDW"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPDW"), GetHashKey("COMPONENT_AT_SCOPE_SMALL"))
    end
    if not (HasCombatPDWItem or HasServicePDWItem) and HasCombatPDW then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPDW"))
      RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPDW"), GetHashKey("COMPONENT_AT_AR_FLSH"))
      RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPDW"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))
      RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPDW"), GetHashKey("COMPONENT_AT_SCOPE_SMALL"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Flashlight (197)
    local hasflashlightitem = exports['core']:GetItemQuantity(197) >= 1
    local hasflashlight = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_FLASHLIGHT"), false)
    if hasflashlightitem and not hasflashlight then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_FLASHLIGHT"), 1, false, false)
    end
    if not hasflashlightitem and hasflashlight then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_FLASHLIGHT"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Taser (198)
    local hastaseritem = exports['core']:GetItemQuantity(198) >= 1
    local hastaser = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_STUNGUN"), false)
    if hastaseritem and not hastaser then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_STUNGUN"), 1, false, false)
    end
    if not hastaseritem and hastaser then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_STUNGUN"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Pump Shotgun (199) & Service Shotgun (200)
    local HasPumpShotgunItem = exports['core']:GetItemQuantity(199) >= 1
    local HasServiceShotgunItem = exports['core']:GetItemQuantity(200) >= 1
    local HasPumpShotgun = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN"), false)
    local HasServiceShotgun = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN_MK2"), false)
    if HasPumpShotgunItem and not HasPumpShotgun then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN"), 120, false, false)
    end
    if HasServiceShotgunItem and not HasServiceShotgun then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN_MK2"), 120, false, false)
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN_MK2"), GetHashKey("COMPONENT_AT_SIGHTS"))
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN_MK2"), GetHashKey("COMPONENT_AT_AR_FLSH"))
    end
    if not HasPumpShotgunItem and HasPumpShotgun then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN"))
      TriggerEvent('weapons:updateback')
    end
    if not HasServiceShotgunItem and HasServiceShotgun then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN_MK2"))
      RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN_MK2"), GetHashKey("COMPONENT_AT_SIGHTS"))
      RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN_MK2"), GetHashKey("COMPONENT_AT_AR_FLSH"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Switchblade (201)
    local hasswitchbaldeitem = exports['core']:GetItemQuantity(201) >= 1
    local hasswitchblade = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_SWITCHBLADE"), false)
    if hasswitchbaldeitem and not hasswitchblade then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SWITCHBLADE"), 1, false, false)
    end
    if not hasswitchbaldeitem and hasswitchblade then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_SWITCHBLADE"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Knuckle Dusters (202)
    local hasknuckledustersitem = exports['core']:GetItemQuantity(202) >= 1
    local hasknuckledusters = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_KNUCKLE"), false)
    if hasknuckledustersitem and not hasknuckledusters then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_KNUCKLE"), 1, false, false)
    end
    if not hasknuckledustersitem and hasknuckledusters then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_KNUCKLE"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Hatchet (203)
    local hashatchetknuckledustersitem = exports['core']:GetItemQuantity(203) >= 1
    local hashatchet = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_HATCHET"), false)
    if hashatchetknuckledustersitem and not hashatchet then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HATCHET"), 1, false, false)
    end
    if not hashatchetknuckledustersitem and hashatchet then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_HATCHET"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Gas Can (205)
    local hasgascanitem = exports['core']:GetItemQuantity(205) >= 1
    local hasgascan = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_PETROLCAN"), false)
    if hasgascanitem and not hasgascan then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PETROLCAN"), 120, false, false)
    end
    if not hasgascanitem and hasgascan then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_PETROLCAN"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Assault Rifle (206)
    local hasassaultrifleitem = exports['core']:GetItemQuantity(206) >= 1
    local hasassaultrifle = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE"), false)
    if hasassaultrifleitem and not hasassaultrifle then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE"), 120, false, false)
    end
    if not hasassaultrifleitem and hasassaultrifle then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Sawn-Off Shotgun (207)
    local hassawnoffshotgunitem = exports['core']:GetItemQuantity(207) >= 1
    local hassawnoffshotgun = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_SAWNOFFSHOTGUN"), false)
    if hassawnoffshotgunitem and not hassawnoffshotgun then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SAWNOFFSHOTGUN"), 120, false, false)
    end
    if not hassawnoffshotgunitem and hassawnoffshotgun then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_SAWNOFFSHOTGUN"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Double Barrel Shotgun (208)
    local hasdoublebarrelshotgunitem = exports['core']:GetItemQuantity(208) >= 1
    local hasdoublebarrelshotgun = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_DBSHOTGUN"), false)
    if hasdoublebarrelshotgunitem and not hasdoublebarrelshotgun then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_DBSHOTGUN"), 120, false, false)
    end
    if not hasdoublebarrelshotgunitem and hasdoublebarrelshotgun then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_DBSHOTGUN"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Gusenberg Sweeper (209)
    local hasgusenbergitem = exports['core']:GetItemQuantity(209) >= 1
    local hasgusenberg = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_GUSENBERG"), false)
    if hasgusenbergitem and not hasgusenberg then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_GUSENBERG"), 120, false, false)
    end
    if not hasgusenbergitem and hasgusenberg then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_GUSENBERG"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Machette (210)
    local hasmachetteitem = exports['core']:GetItemQuantity(210) >= 1
    local hasmachette = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_MACHETE"), false)
    if hasmachetteitem and not hasmachette then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MACHETE"), 1, false, false)
    end
    if not hasmachetteitem and hasmachette then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_MACHETE"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Poolcue (211)
    local haspoolcueitem = exports['core']:GetItemQuantity(211) >= 1
    local haspoolcue = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_POOLCUE"), false)
    if haspoolcueitem and not haspoolcue then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_POOLCUE"), 1, false, false)
    end
    if not haspoolcueitem and haspoolcue then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_POOLCUE"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Knife (212)
    local hasknifeitem = exports['core']:GetItemQuantity(212) >= 1
    local hasknife = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_KNIFE"), false)
    if hasknifeitem and not hasknife then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_KNIFE"), 1, false, false)
    end
    if not hasknifeitem and hasknife then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_KNIFE"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Nightstick (213)
    local hasnightstickitem = exports['core']:GetItemQuantity(213) >= 1
    local hasnightstick = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_NIGHTSTICK"), false)
    if hasnightstickitem and not hasnightstick then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_NIGHTSTICK"), 1, false, false)
    end
    if not hasnightstickitem and hasnightstick then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_NIGHTSTICK"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Hammer (214)
    local hashammeritem = exports['core']:GetItemQuantity(214) >= 1
    local hashammer = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_HAMMER"), false)
    if hashammeritem and not hashammer then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HAMMER"), 1, false, false)
    end
    if not hashammeritem and hashammer then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_HAMMER"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Bat (215)
    local hasbatitem = exports['core']:GetItemQuantity(215) >= 1
    local hasbat = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_BAT"), false)
    if hasbatitem and not hasbat then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_BAT"), 1, false, false)
    end
    if not hasbatitem and hasbat then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_BAT"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Golf Club (216)
    local hasgolfclubitem = exports['core']:GetItemQuantity(216) >= 1
    local hasgolfclub = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_GOLFCLUB"), false)
    if hasgolfclubitem and not hasgolfclub then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_GOLFCLUB"), 1, false, false)
    end
    if not hasgolfclubitem and hasgolfclub then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_GOLFCLUB"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Crowbar (217)
    local hascrowbaritem = exports['core']:GetItemQuantity(217) >= 1
    local hascrowbar = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_CROWBAR"), false)
    if hascrowbaritem and not hascrowbar then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CROWBAR"), 1, false, false)
    end
    if not hascrowbaritem and hascrowbar then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_CROWBAR"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --AP Pistol (218)
    local hasappistolitem = exports['core']:GetItemQuantity(218) >= 1
    local hasappistol = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_APPISTOL"), false)
    if hasappistolitem and not hasappistol then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_APPISTOL"), 120, false, false)
    end
    if not hasappistolitem and hasappistol then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_APPISTOL"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Pistol .50 (219)
    local haspistol50item = exports['core']:GetItemQuantity(219) >= 1
    local haspistol50 = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL50"), false)
    if haspistol50item and not haspistol50 then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL50"), 120, false, false)
    end
    if not haspistol50item and haspistol50 then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL50"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --SMG (220)
    local hasSMGitem = exports['core']:GetItemQuantity(220) >= 1
    local hasSMG = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_SMG"), false)
    if hasSMGitem and not hasSMG then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SMG"), 120, false, false)
    end
    if not hasSMGitem and hasSMG then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_SMG"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Assault SMG (221)
    local hasAssaultSMGitem = exports['core']:GetItemQuantity(221) >= 1
    local hasAssaultSMG = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTSMG"), false)
    if hasAssaultSMGitem and not hasAssaultSMG then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTSMG"), 120, false, false)
    end
    if not hasAssaultSMGitem and hasAssaultSMG then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTSMG"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Carbine Rifle (222)
    local hasCarbineRifleitem = exports['core']:GetItemQuantity(222) >= 1
    local hasCarbineRifle = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), false)
    if hasCarbineRifleitem and not hasCarbineRifle then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), 120, false, false)
    end
    if not hasCarbineRifleitem and hasCarbineRifle then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Advanced Rifle (223)
    local hasAdvancedRifleitem = exports['core']:GetItemQuantity(223) >= 1
    local hasAdvancedRifle = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_ADVANCEDRIFLE"), false)
    if hasAdvancedRifleitem and not hasAdvancedRifle then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ADVANCEDRIFLE"), 120, false, false)
    end
    if not hasAdvancedRifleitem and hasAdvancedRifle then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_ADVANCEDRIFLE"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --MG (224)
    local hasMGitem = exports['core']:GetItemQuantity(224) >= 1
    local hasMG = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_MG"), false)
    if hasMGitem and not hasMG then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MG"), 120, false, false)
    end
    if not hasMGitem and hasMG then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_MG"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Combat MG (225)
    local hasCombatMGitem = exports['core']:GetItemQuantity(225) >= 1
    local hasCombatMG = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATMG"), false)
    if hasCombatMGitem and not hasCombatMG then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATMG"), 120, false, false)
    end
    if not hasCombatMGitem and hasCombatMG then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATMG"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Assault Shotgun (226)
    local hasAssaultShotgunitem = exports['core']:GetItemQuantity(226) >= 1
    local hasAssaultShotgun = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTSHOTGUN"), false)
    if hasAssaultShotgunitem and not hasAssaultShotgun then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTSHOTGUN"), 120, false, false)
    end
    if not hasAssaultShotgunitem and hasAssaultShotgun then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTSHOTGUN"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Bullpup Shotgun (227)
    local hasBullpupShotgunitem = exports['core']:GetItemQuantity(227) >= 1
    local hasBullpupShotgun = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_BULLPUPSHOTGUN"), false)
    if hasBullpupShotgunitem and not hasBullpupShotgun then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_BULLPUPSHOTGUN"), 120, false, false)
    end
    if not hasBullpupShotgunitem and hasBullpupShotgun then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_BULLPUPSHOTGUN"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Sniper Rifle (228)
    local hasSniperRifleitem = exports['core']:GetItemQuantity(228) >= 1
    local hasSniperRifle = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_SNIPERRIFLE"), false)
    if hasSniperRifleitem and not hasSniperRifle then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SNIPERRIFLE"), 120, false, false)
    end
    if not hasSniperRifleitem and hasSniperRifle then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_SNIPERRIFLE"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Heavy Sniper (229)
    local hasHeavySniperitem = exports['core']:GetItemQuantity(229) >= 1
    local hasHeavySniper = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYSNIPER"), false)
    if hasHeavySniperitem and not hasHeavySniper then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYSNIPER"), 120, false, false)
    end
    if not hasHeavySniperitem and hasHeavySniper then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYSNIPER"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Fire Extinguisher (230)
    local hasFireExtinguisheritem = exports['core']:GetItemQuantity(230) >= 1
    local hasFireExtinguisher = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_FIREEXTINGUISHER"), false)
    if hasFireExtinguisheritem and not hasFireExtinguisher then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_FIREEXTINGUISHER"), 120, false, false)
    end
    if not hasFireExtinguisheritem and hasFireExtinguisher then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_FIREEXTINGUISHER"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --SNS Pistol (232)
    local hasSNSPistolitem = exports['core']:GetItemQuantity(232) >= 1
    local hasSNSPistol = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_SNSPISTOL"), false)
    if hasSNSPistolitem and not hasSNSPistol then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SNSPISTOL"), 120, false, false)
    end
    if not hasSNSPistolitem and hasSNSPistol then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_SNSPISTOL"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Special Carbine (233)
    local hasSpecialCarbineitem = exports['core']:GetItemQuantity(233) >= 1
    local hasSpecialCarbine = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE"), false)
    if hasSpecialCarbineitem and not hasSpecialCarbine then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE"), 120, false, false)
    end
    if not hasSpecialCarbineitem and hasSpecialCarbine then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Heavy Pistol (234)
    local hasHeavyPistolitem = exports['core']:GetItemQuantity(234) >= 1
    local hasHeavyPistol = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYPISTOL"), false)
    if hasHeavyPistolitem and not hasHeavyPistol then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYPISTOL"), 120, false, false)
    end
    if not hasHeavyPistolitem and hasHeavyPistol then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYPISTOL"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Bullpup Rifle (235)
    local hasBullpupRifleitem = exports['core']:GetItemQuantity(235) >= 1
    local hasBullpupRifle = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_BULLPUPRIFLE"), false)
    if hasBullpupRifleitem and not hasBullpupRifle then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_BULLPUPRIFLE"), 120, false, false)
    end
    if not hasBullpupRifleitem and hasBullpupRifle then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_BULLPUPRIFLE"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Vintage Pistol (236)
    local hasVintagePistolitem = exports['core']:GetItemQuantity(236) >= 1
    local hasVintagePistol = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_VINTAGEPISTOL"), false)
    if hasVintagePistolitem and not hasVintagePistol then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_VINTAGEPISTOL"), 120, false, false)
    end
    if not hasVintagePistolitem and hasVintagePistol then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_VINTAGEPISTOL"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Antique Dagger (237)
    local hasDaggeritem = exports['core']:GetItemQuantity(237) >= 1
    local hasDagger = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_DAGGER"), false)
    if hasDaggeritem and not hasDagger then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_DAGGER"), 1, false, false)
    end
    if not hasDaggeritem and hasDagger then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_DAGGER"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Musket (238)
    local hasMusketitem = exports['core']:GetItemQuantity(238) >= 1
    local hasMusket = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_MUSKET"), false)
    if hasMusketitem and not hasMusket then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MUSKET"), 120, false, false)
    end
    if not hasMusketitem and hasMusket then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_MUSKET"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Marksman Rifle (239)
    local hasMarksmanRifleitem = exports['core']:GetItemQuantity(239) >= 1
    local hasMarksmanRifle = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_MARKSMANRIFLE"), false)
    if hasMarksmanRifleitem and not hasMarksmanRifle then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MARKSMANRIFLE"), 120, false, false)
    end
    if not hasMarksmanRifleitem and hasMarksmanRifle then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_MARKSMANRIFLE"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Heavy Shotgun (240)
    local hasHeavyShotgunitem = exports['core']:GetItemQuantity(240) >= 1
    local hasHeavyShotgun = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYSHOTGUN"), false)
    if hasHeavyShotgunitem and not hasHeavyShotgun then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYSHOTGUN"), 120, false, false)
    end
    if not hasHeavyShotgunitem and hasHeavyShotgun then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYSHOTGUN"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Marksman Pistol (241)
    local hasMarksmanPistolitem = exports['core']:GetItemQuantity(241) >= 1
    local hasMarksmanPistol = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_MARKSMANPISTOL"), false)
    if hasMarksmanPistolitem and not hasMarksmanPistol then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MARKSMANPISTOL"), 120, false, false)
    end
    if not hasMarksmanPistolitem and hasMarksmanPistol then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_MARKSMANPISTOL"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Machine Pistol (242)
    local hasMachinePistolitem = exports['core']:GetItemQuantity(242) >= 1
    local hasMachinePistol = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_MACHINEPISTOL"), false)
    if hasMachinePistolitem and not hasMachinePistol then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MACHINEPISTOL"), 120, false, false)
    end
    if not hasMachinePistolitem and hasMachinePistol then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_MACHINEPISTOL"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Revolver (243)
    local hasRevolveritem = exports['core']:GetItemQuantity(243) >= 1
    local hasRevolver = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_REVOLVER"), false)
    if hasRevolveritem and not hasRevolver then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_REVOLVER"), 120, false, false)
    end
    if not hasRevolveritem and hasRevolver then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_REVOLVER"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Compact Rifle (244)
    local hasCompactRifleitem = exports['core']:GetItemQuantity(244) >= 1
    local hasCompactRifle = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_COMPACTRIFLE"), false)
    if hasCompactRifleitem and not hasCompactRifle then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMPACTRIFLE"), 120, false, false)
    end
    if not hasCompactRifleitem and hasCompactRifle then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMPACTRIFLE"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Flaregun (245)
    local hasFlareGunitem = exports['core']:GetItemQuantity(245) >= 1
    local hasFlareGun = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_FLAREGUN"), false)
    if hasFlareGunitem and not hasFlareGun then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_FLAREGUN"), 120, false, false)
    end
    if not hasFlareGunitem and hasFlareGun then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_FLAREGUN"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Battleaxe (246)
    local hasBattleAxeitem = exports['core']:GetItemQuantity(246) >= 1
    local hasBattleAxe = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_BATTLEAXE"), false)
    if hasBattleAxeitem and not hasBattleAxe then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_BATTLEAXE"), 120, false, false)
    end
    if not hasBattleAxeitem and hasBattleAxe then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_BATTLEAXE"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Mini SMG (247)
    local hasMiniSMGitem = exports['core']:GetItemQuantity(247) >= 1
    local hasMiniSMG = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_MINISMG"), false)
    if hasMiniSMGitem and not hasMiniSMG then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MINISMG"), 120, false, false)
    end
    if not hasMiniSMGitem and hasMiniSMG then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_MINISMG"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Double Action (249)
    local hasDoubleActionitem = exports['core']:GetItemQuantity(249) >= 1
    local hasDoubleAction = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_DOUBLEACTION"), false)
    if hasDoubleActionitem and not hasDoubleAction then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_DOUBLEACTION"), 120, false, false)
    end
    if not hasDoubleActionitem and hasDoubleAction then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_DOUBLEACTION"))
      TriggerEvent('weapons:updateback')
    end
    ---------------

    --Tear Gas (301)
    local hasTearGasitem = exports['core']:GetItemQuantity(301) >= 1
    local hasTearGas = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_SMOKEGRENADE"), false)
    if hasTearGasitem and not hasTearGas then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SMOKEGRENADE"), 120, false, false)
    end
    if not hasTearGasitem and hasTearGas then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_SMOKEGRENADE"))
      TriggerEvent('weapons:updateback')
    end


    --CRT RIFLE (302)
    local hasCRTRifleitem = exports['core']:GetItemQuantity(302) >= 1
    local hasCRTRifle = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE_MK2"), false)
    if hasCRTRifleitem and not hasCRTRifle then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE_MK2"), 120, false, false)
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE_MK2"), GetHashKey("COMPONENT_SPECIALCARBINE_MK2_CLIP_02"))
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE_MK2"), GetHashKey("COMPONENT_AT_AR_FLSH"))
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE_MK2"), GetHashKey("COMPONENT_AT_SCOPE_MEDIUM_MK2"))
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE_MK2"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE_MK2"), GetHashKey("COMPONENT_AT_AR_AFGRIP_02"))
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE_MK2"), GetHashKey("COMPONENT_AT_SC_BARREL_02"))
    end
    if not hasCRTRifleitem and hasCRTRifle then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE_MK2"))
      TriggerEvent('weapons:updateback')
    end

    --CRT Sniper (304)
    local hasCRTSniperitem = exports['core']:GetItemQuantity(304) >= 1
    local hasCRTSniper = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYSNIPER_MK2"), false)
    if hasCRTSniperitem and not hasCRTSniper then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYSNIPER_MK2"), 120, false, false)
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYSNIPER_MK2"), GetHashKey("COMPONENT_HEAVYSNIPER_MK2_CLIP_FMJ"))
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYSNIPER_MK2"), GetHashKey("COMPONENT_AT_SCOPE_MAX"))
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYSNIPER_MK2"), GetHashKey("COMPONENT_AT_SR_SUPP_03"))
      GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYSNIPER_MK2"), GetHashKey("COMPONENT_AT_SR_BARREL_02"))
    end
    if not hasCRTSniperitem and hasCRTSniper then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYSNIPER_MK2"))
      TriggerEvent('weapons:updateback')
    end

    ---------------
    --[[local hasSnowBallitem = exports['core']:GetItemQuantity(285) >= 1
    local hasSnowBallAction = HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_SNOWBALL"), false)
    if hasSnowBallitem and not hasSnowBallAction then
      GiveDelayedWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SNOWBALL"), 5, false, false)
    end
    Wait(1500)
    if GetAmmoInPedWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_SNOWBALL")) < 1 then
      TriggerEvent("inventory:removeQty", 285, 1)
    end 
    if not hasSnowBallitem and hasSnowBallAction then
      RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey("WEAPON_SNOWBALL"))
      TriggerEvent('weapons:updateback')
    end]]
  end
end)