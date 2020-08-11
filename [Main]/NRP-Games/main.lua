local RCCar = {}
local suppressor = false
RegisterCommand("rc", function()
	RCCar.Start()
end)


--[[RegisterCommand("ak", function()
  local xzurv = exports['core']:GetItemQuantity(171)
    if xzurv > 0 then
	 GiveWeaponToPed(GetPlayerPed(-1), GetHashKey('WEAPON_ASSAULTRIFLE'))
	 TriggerEvent("inventory:removeQty", 171, 1)
	end
	if GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("WEAPON_ASSAULTRIFLE") then	
	 RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey('WEAPON_ASSAULTRIFLE'))
	 TriggerEvent('weapons:updateback')
	 TriggerEvent("inventory:addQty", 171, 1)
	end 	 	
end)]]--

RegisterCommand("suppressor", function()
	local suppressoritem = exports['core']:GetItemQuantity(170)
		if GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("WEAPON_PISTOL_MK2") and HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey('WEAPON_PISTOL_MK2'), GetHashKey('COMPONENT_AT_PI_SUPP_02')) then
			if suppressoritem == 0 or suppressoritem > 0 then 
	        	RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey('WEAPON_PISTOL_MK2'), GetHashKey('COMPONENT_AT_PI_SUPP_02'))
      		end
	    elseif GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("WEAPON_PISTOL_MK2")  and not HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey('WEAPON_PISTOL_MK2'), GetHashKey('COMPONENT_AT_PI_SUPP_02')) then
			if suppressoritem > 0 then 
		        GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('WEAPON_PISTOL_MK2'), GetHashKey('COMPONENT_AT_PI_SUPP_02'))
				suppressor = true
			end
	    end
	   --[[if GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("WEAPON_SNIPERRIFLE")  and HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey('WEAPON_SNIPERRIFLE'), GetHashKey('COMPONENT_AT_AR_SUPP_02')) then
			if suppressoritem == 0 or suppressoritem > 0 then 
		        RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey('WEAPON_SNIPERRIFLE'), GetHashKey('COMPONENT_AT_AR_SUPP_02'))
	      		suppressor = false
      		end]]--
	    --[[elseif GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("WEAPON_SNIPERRIFLE") and not HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey('WEAPON_SNIPERRIFLE'), GetHashKey('COMPONENT_AT_AR_SUPP_02')) then
			if suppressoritem > 0 then 
		        GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('WEAPON_SNIPERRIFLE'), GetHashKey('COMPONENT_AT_AR_SUPP_02'))
				TriggerEvent("inventory:removeQty", 170, 1)
			end
	    end]]
		if GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("WEAPON_PISTOL")  and HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey('WEAPON_PISTOL'), GetHashKey('COMPONENT_AT_PI_SUPP_02')) then
			if suppressoritem == 0 or suppressoritem > 0 then 
		        RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey('WEAPON_PISTOL'), GetHashKey('COMPONENT_AT_PI_SUPP_02'))
	      	end
	    elseif GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("WEAPON_PISTOL")  and not HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey('WEAPON_PISTOL'), GetHashKey('COMPONENT_AT_PI_SUPP_02')) then
			if suppressoritem > 0 then 
		        GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('WEAPON_PISTOL'), GetHashKey('COMPONENT_AT_PI_SUPP_02'))
				suppressor = true
			end
	    end
		if GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("WEAPON_COMBATPISTOL")  and HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey('WEAPON_COMBATPISTOL'), GetHashKey('COMPONENT_AT_PI_SUPP')) then
			if suppressoritem == 0 or suppressoritem > 0 then 
		        RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey('WEAPON_COMBATPISTOL'), GetHashKey('COMPONENT_AT_PI_SUPP'))
	      	end
	    elseif GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("WEAPON_COMBATPISTOL")  and not HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey('WEAPON_COMBATPISTOL'), GetHashKey('COMPONENT_AT_PI_SUPP')) then
			if suppressoritem > 0 then 
		        GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('WEAPON_COMBATPISTOL'), GetHashKey('COMPONENT_AT_PI_SUPP'))
				suppressor = true
			end
		end
		if GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("WEAPON_APPISTOL")  and HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey('WEAPON_APPISTOL'), GetHashKey('COMPONENT_AT_PI_SUPP')) then
			if suppressoritem == 0 or suppressoritem > 0 then 
		        RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey('WEAPON_APPISTOL'), GetHashKey('COMPONENT_AT_PI_SUPP'))
	      	end
	    elseif GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("WEAPON_APPISTOL")  and not HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey('WEAPON_APPISTOL'), GetHashKey('COMPONENT_AT_PI_SUPP')) then
			if suppressoritem > 0 then 
		        GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('WEAPON_APPISTOL'), GetHashKey('COMPONENT_AT_PI_SUPP'))
				suppressor = true
			end
		end
		
		if GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("WEAPON_PISTOL50")  and HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey('WEAPON_PISTOL50'), GetHashKey('COMPONENT_AT_AR_SUPP_02')) then
			if suppressoritem == 0 or suppressoritem > 0 then 
		        RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey('WEAPON_PISTOL50'), GetHashKey('COMPONENT_AT_AR_SUPP_02'))
	      	end
	    elseif GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("WEAPON_PISTOL50")  and not HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey('WEAPON_PISTOL50'), GetHashKey('COMPONENT_AT_AR_SUPP_02')) then
			if suppressoritem > 0 then 
		        GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('WEAPON_PISTOL50'), GetHashKey('COMPONENT_AT_AR_SUPP_02'))
				suppressor = true
			end
		end

		if GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("WEAPON_HEAVYPISTOL")  and HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey('WEAPON_HEAVYPISTOL'), GetHashKey('COMPONENT_AT_PI_SUPP')) then
			if suppressoritem == 0 or suppressoritem > 0 then 
		        RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey('WEAPON_HEAVYPISTOL'), GetHashKey('COMPONENT_AT_PI_SUPP'))
	      	end
	    elseif GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("WEAPON_HEAVYPISTOL")  and not HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey('WEAPON_HEAVYPISTOL'), GetHashKey('COMPONENT_AT_PI_SUPP')) then
			if suppressoritem > 0 then 
		        GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('WEAPON_HEAVYPISTOL'), GetHashKey('COMPONENT_AT_PI_SUPP'))
				suppressor = true
			end
		end

		if GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("WEAPON_VINTAGEPISTOL")  and HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey('WEAPON_VINTAGEPISTOL'), GetHashKey('COMPONENT_AT_PI_SUPP')) then
			if suppressoritem == 0 or suppressoritem > 0 then 
		        RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey('WEAPON_VINTAGEPISTOL'), GetHashKey('COMPONENT_AT_PI_SUPP'))
	      	end
	    elseif GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("WEAPON_VINTAGEPISTOL")  and not HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey('WEAPON_VINTAGEPISTOL'), GetHashKey('COMPONENT_AT_PI_SUPP')) then
			if suppressoritem > 0 then 
		        GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('WEAPON_VINTAGEPISTOL'), GetHashKey('COMPONENT_AT_PI_SUPP'))
				suppressor = true
			end
		end

		if GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("WEAPON_MICROSMG")  and HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey('WEAPON_MICROSMG'), GetHashKey('COMPONENT_AT_AR_SUPP_02')) then
			if suppressoritem == 0 or suppressoritem > 0 then 
		        RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey('WEAPON_MICROSMG'), GetHashKey('COMPONENT_AT_AR_SUPP_02'))
	      	end
	    elseif GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("WEAPON_MICROSMG")  and not HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey('WEAPON_MICROSMG'), GetHashKey('COMPONENT_AT_AR_SUPP_02')) then
			if suppressoritem > 0 then 
		        GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('WEAPON_MICROSMG'), GetHashKey('COMPONENT_AT_AR_SUPP_02'))
				suppressor = true
			end
		end

		if GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("WEAPON_SMG")  and HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey('WEAPON_SMG'), GetHashKey('COMPONENT_AT_PI_SUPP')) then
			if suppressoritem == 0 or suppressoritem > 0 then 
		        RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey('WEAPON_SMG'), GetHashKey('COMPONENT_AT_PI_SUPP'))
	      	end
	    elseif GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("WEAPON_SMG")  and not HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey('WEAPON_SMG'), GetHashKey('COMPONENT_AT_PI_SUPP')) then
			if suppressoritem > 0 then 
		        GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('WEAPON_SMG'), GetHashKey('COMPONENT_AT_PI_SUPP'))
				suppressor = true
			end
		end

		if GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("WEAPON_ASSAULTSMG")  and HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey('WEAPON_ASSAULTSMG'), GetHashKey('COMPONENT_AT_AR_SUPP_02')) then
			if suppressoritem == 0 or suppressoritem > 0 then 
		        RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey('WEAPON_ASSAULTSMG'), GetHashKey('COMPONENT_AT_AR_SUPP_02'))
	      	end
	    elseif GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("WEAPON_ASSAULTSMG")  and not HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey('WEAPON_ASSAULTSMG'), GetHashKey('COMPONENT_AT_AR_SUPP_02')) then
			if suppressoritem > 0 then 
		        GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('WEAPON_ASSAULTSMG'), GetHashKey('COMPONENT_AT_AR_SUPP_02'))
				suppressor = true
			end
		end

		if GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("WEAPON_ASSAULTSMG")  and HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey('WEAPON_ASSAULTSMG'), GetHashKey('COMPONENT_AT_AR_SUPP_02')) then
			if suppressoritem == 0 or suppressoritem > 0 then 
		        RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey('WEAPON_ASSAULTSMG'), GetHashKey('COMPONENT_AT_AR_SUPP_02'))
	      	end
	    elseif GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("WEAPON_ASSAULTSMG")  and not HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey('WEAPON_ASSAULTSMG'), GetHashKey('COMPONENT_AT_AR_SUPP_02')) then
			if suppressoritem > 0 then 
		        GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('WEAPON_ASSAULTSMG'), GetHashKey('COMPONENT_AT_AR_SUPP_02'))
				suppressor = true
			end
		end
		
		if GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("WEAPON_MACHINEPISTOL")  and HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey('WEAPON_MACHINEPISTOL'), GetHashKey('COMPONENT_AT_PI_SUPP')) then
			if suppressoritem == 0 or suppressoritem > 0 then 
		        RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey('WEAPON_MACHINEPISTOL'), GetHashKey('COMPONENT_AT_PI_SUPP'))
	      	end
	    elseif GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("WEAPON_MACHINEPISTOL")  and not HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey('WEAPON_MACHINEPISTOL'), GetHashKey('COMPONENT_AT_PI_SUPP')) then
			if suppressoritem > 0 then 
		        GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('WEAPON_MACHINEPISTOL'), GetHashKey('COMPONENT_AT_PI_SUPP'))
				suppressor = true
			end
		end

		if GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("WEAPON_ASSAULTRIFLE")  and HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey('WEAPON_ASSAULTRIFLE'), GetHashKey('COMPONENT_AT_AR_SUPP_02')) then
			if suppressoritem == 0 or suppressoritem > 0 then 
		        RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey('WEAPON_ASSAULTRIFLE'), GetHashKey('COMPONENT_AT_AR_SUPP_02'))
	      	end
	    elseif GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("WEAPON_ASSAULTRIFLE")  and not HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey('WEAPON_ASSAULTRIFLE'), GetHashKey('COMPONENT_AT_AR_SUPP_02')) then
			if suppressoritem > 0 then 
		        GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('WEAPON_ASSAULTRIFLE'), GetHashKey('COMPONENT_AT_AR_SUPP_02'))
				suppressor = true
			end
		end

		if GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("weapon_carbinerifle")  and HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey('weapon_carbinerifle'), GetHashKey('COMPONENT_AT_AR_SUPP')) then
			if suppressoritem == 0 or suppressoritem > 0 then 
		        RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey('weapon_carbinerifle'), GetHashKey('COMPONENT_AT_AR_SUPP'))
	      	end
	    elseif GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("weapon_carbinerifle")  and not HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey('weapon_carbinerifle'), GetHashKey('COMPONENT_AT_AR_SUPP')) then
			if suppressoritem > 0 then 
		        GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('weapon_carbinerifle'), GetHashKey('COMPONENT_AT_AR_SUPP'))
				suppressor = true
			end
		end

		if GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("weapon_advancedrifle")  and HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey('weapon_advancedrifle'), GetHashKey('COMPONENT_AT_AR_SUPP')) then
			if suppressoritem == 0 or suppressoritem > 0 then 
		        RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey('weapon_advancedrifle'), GetHashKey('COMPONENT_AT_AR_SUPP'))
	      	end
	    elseif GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("weapon_advancedrifle")  and not HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey('weapon_advancedrifle'), GetHashKey('COMPONENT_AT_AR_SUPP')) then
			if suppressoritem > 0 then 
		        GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('weapon_advancedrifle'), GetHashKey('COMPONENT_AT_AR_SUPP'))
				suppressor = true
			end
		end

		if GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("weapon_specialcarbine")  and HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey('weapon_specialcarbine'), GetHashKey('COMPONENT_AT_AR_SUPP_02')) then
			if suppressoritem == 0 or suppressoritem > 0 then 
		        RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey('weapon_specialcarbine'), GetHashKey('COMPONENT_AT_AR_SUPP_02'))
	      	end
	    elseif GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("weapon_specialcarbine")  and not HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey('weapon_specialcarbine'), GetHashKey('COMPONENT_AT_AR_SUPP_02')) then
			if suppressoritem > 0 then 
		        GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('weapon_specialcarbine'), GetHashKey('COMPONENT_AT_AR_SUPP_02'))
				suppressor = true
			end
		end

		if GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("weapon_bullpuprifle")  and HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey('weapon_bullpuprifle'), GetHashKey('COMPONENT_AT_AR_SUPP')) then
			if suppressoritem == 0 or suppressoritem > 0 then 
		        RemoveWeaponComponentFromPed(GetPlayerPed(-1), GetHashKey('weapon_bullpuprifle'), GetHashKey('COMPONENT_AT_AR_SUPP'))
	      	end
	    elseif GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("weapon_bullpuprifle")  and not HasPedGotWeaponComponent(GetPlayerPed(-1), GetHashKey('weapon_bullpuprifle'), GetHashKey('COMPONENT_AT_AR_SUPP')) then
			if suppressoritem > 0 then 
		        GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('weapon_bullpuprifle'), GetHashKey('COMPONENT_AT_AR_SUPP'))
				suppressor = true
			end
		end
end)

Citizen.CreateThread(function()
	while true do
		Wait(10000)
		if suppressor then
			local suppressoritema = exports['core']:GetItemQuantity(170)
			if suppressoritema < 1 then
				ExecuteCommand("suppressor")
			end
		end
	end
end)

RegisterCommand("strap", function()
	local guntriminventory = exports['core']:GetItemQuantity(135)
  	if guntriminventory > 0 then 
		GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('WEAPON_PISTOL'), GetHashKey('COMPONENT_PISTOL_VARMOD_LUXE'))
		GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('WEAPON_COMBATPISTOL'), GetHashKey('COMPONENT_COMBATPISTOL_VARMOD_LOWRIDER'))
		GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('WEAPON_APPISTOL'), GetHashKey('COMPONENT_APPISTOL_VARMOD_LUXE'))
		GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('WEAPON_PISTOL50'), GetHashKey('COMPONENT_PISTOL50_VARMOD_LUXE'))
		GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('WEAPON_SNSPISTOL'), GetHashKey('COMPONENT_SNSPISTOL_VARMOD_LOWRIDER'))
		GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('WEAPON_HEAVYPISTOL'), GetHashKey('COMPONENT_HEAVYPISTOL_VARMOD_LUXE'))
		GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('WEAPON_MICROSMG'), GetHashKey('COMPONENT_MICROSMG_VARMOD_LUXE'))
		GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('WEAPON_SMG'), GetHashKey('COMPONENT_SMG_VARMOD_LUXE'))
		GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('WEAPON_ASSAULTSMG'), GetHashKey('COMPONENT_ASSAULTSMG_VARMOD_LOWRIDER'))
		GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('WEAPON_PUMPSHOTGUN'), GetHashKey('COMPONENT_PUMPSHOTGUN_VARMOD_LOWRIDER'))
		GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('WEAPON_SAWNOFFSHOTGUN'), GetHashKey('COMPONENT_SAWNOFFSHOTGUN_VARMOD_LUXE'))
		GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('WEAPON_ASSAULTRIFLE'), GetHashKey('COMPONENT_ASSAULTRIFLE_VARMOD_LUXE'))
		GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('WEAPON_CARBINERIFLE'), GetHashKey('COMPONENT_CARBINERIFLE_VARMOD_LUXE'))
		GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('WEAPON_ADVANCEDRIFLE'), GetHashKey('COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE'))
		GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('WEAPON_SPECIALCARBINE'), GetHashKey('COMPONENT_SPECIALCARBINE_VARMOD_LOWRIDER'))
		GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('WEAPON_BULLPUPRIFLE'), GetHashKey('COMPONENT_BULLPUPRIFLE_VARMOD_LOW'))
		GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('WEAPON_MG'), GetHashKey('COMPONENT_MG_VARMOD_LOWRIDER'))
		GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('WEAPON_COMBATMG'), GetHashKey('COMPONENT_COMBATMG_VARMOD_LOWRIDER'))
		GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('WEAPON_SNIPERRIFLE'), GetHashKey('COMPONENT_SNIPERRIFLE_VARMOD_LUXE'))
		GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('WEAPON_MARKSMANRIFLE'), GetHashKey('COMPONENT_MARKSMANRIFLE_VARMOD_LUXE'))

		GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey('WEAPON_HEAVYREVOLVER'), GetHashKey('COMPONENT_REVOLVER_VARMOD_BOSS'))
		
		exports['NRP-notify']:DoHudText('inform',  "You have Pimped your strap.")
	else
		exports['NRP-notify']:DoHudText('inform',  "You don't have a Trim Kit.")
	end
end)

RCCar.Start = function()
	if DoesEntityExist(RCCar.Entity) then return end
  	local rccarinventory = exports['core']:GetItemQuantity(134)
  	if rccarinventory > 0 then 
		RCCar.Spawn()

		RCCar.Tablet(true)

		while DoesEntityExist(RCCar.Entity) and DoesEntityExist(RCCar.Driver) do
			Citizen.Wait(5)

			local distanceCheck = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),  GetEntityCoords(RCCar.Entity), true)

			RCCar.DrawInstructions(distanceCheck)
			RCCar.HandleKeys(distanceCheck)

			if distanceCheck <= Config.LoseConnectionDistance then
				if not NetworkHasControlOfEntity(RCCar.Driver) then
					NetworkRequestControlOfEntity(RCCar.Driver)
				elseif not NetworkHasControlOfEntity(RCCar.Entity) then
					NetworkRequestControlOfEntity(RCCar.Entity)
				end
			else
				TaskVehicleTempAction(RCCar.Driver, RCCar.Entity, 6, 2500)
			end
		end
	else
		exports['NRP-notify']:DoHudText('inform',  "You don't have an RC Car.")
	end
end

RCCar.HandleKeys = function(distanceCheck)
	if IsControlJustReleased(0, 47) then
		if IsCamRendering(RCCar.Camera) then
			RCCar.ToggleCamera(false)
		else
			RCCar.ToggleCamera(true)
		end
	end

	if distanceCheck <= 1.5 then
		if IsControlJustPressed(0, 38) then
			RCCar.Attach("pick")
		end
	end

	if distanceCheck < Config.LoseConnectionDistance then
		if IsControlPressed(0, 172) and not IsControlPressed(0, 173) then
			TaskVehicleTempAction(RCCar.Driver, RCCar.Entity, 9, 1)
		end
		
		if IsControlJustReleased(0, 172) or IsControlJustReleased(0, 173) then
			TaskVehicleTempAction(RCCar.Driver, RCCar.Entity, 6, 2500)
		end

		if IsControlPressed(0, 173) and not IsControlPressed(0, 172) then
			TaskVehicleTempAction(RCCar.Driver, RCCar.Entity, 22, 1)
		end

		if IsControlPressed(0, 174) and IsControlPressed(0, 173) then
			TaskVehicleTempAction(RCCar.Driver, RCCar.Entity, 13, 1)
		end

		if IsControlPressed(0, 175) and IsControlPressed(0, 173) then
			TaskVehicleTempAction(RCCar.Driver, RCCar.Entity, 14, 1)
		end

		if IsControlPressed(0, 172) and IsControlPressed(0, 173) then
			TaskVehicleTempAction(RCCar.Driver, RCCar.Entity, 30, 100)
		end

		if IsControlPressed(0, 174) and IsControlPressed(0, 172) then
			TaskVehicleTempAction(RCCar.Driver, RCCar.Entity, 7, 1)
		end

		if IsControlPressed(0, 175) and IsControlPressed(0, 172) then
			TaskVehicleTempAction(RCCar.Driver, RCCar.Entity, 8, 1)
		end

		if IsControlPressed(0, 174) and not IsControlPressed(0, 172) and not IsControlPressed(0, 173) then
			TaskVehicleTempAction(RCCar.Driver, RCCar.Entity, 4, 1)
		end

		if IsControlPressed(0, 175) and not IsControlPressed(0, 172) and not IsControlPressed(0, 173) then
			TaskVehicleTempAction(RCCar.Driver, RCCar.Entity, 5, 1)
		end
	end
end

RCCar.DrawInstructions = function(distanceCheck)
	local steeringButtons = {
		{
			["label"] = "Right",
			["button"] = "~INPUT_CELLPHONE_RIGHT~"
		},
		{
			["label"] = "Forward",
			["button"] = "~INPUT_CELLPHONE_UP~"
		},
		{
			["label"] = "Reverse",
			["button"] = "~INPUT_CELLPHONE_DOWN~"
		},
		{
			["label"] = "Left",
			["button"] = "~INPUT_CELLPHONE_LEFT~"
		}
	}

	local pickupButton = {
		["label"] = "Pick Up",
		["button"] = "~INPUT_CONTEXT~"
	}

	local buttonsToDraw = {
		{
			["label"] = "Toggle Camera",
			["button"] = "~INPUT_DETONATE~"
		}
	}

	if distanceCheck <= Config.LoseConnectionDistance then
		for buttonIndex = 1, #steeringButtons do
			local steeringButton = steeringButtons[buttonIndex]

			table.insert(buttonsToDraw, steeringButton)
		end

		if distanceCheck <= 1.5 then
			table.insert(buttonsToDraw, pickupButton)
		end
	end

    Citizen.CreateThread(function()
        local instructionScaleform = RequestScaleformMovie("instructional_buttons")

        while not HasScaleformMovieLoaded(instructionScaleform) do
            Wait(0)
        end

        PushScaleformMovieFunction(instructionScaleform, "CLEAR_ALL")
        PushScaleformMovieFunction(instructionScaleform, "TOGGLE_MOUSE_BUTTONS")
        PushScaleformMovieFunctionParameterBool(0)
        PopScaleformMovieFunctionVoid()

        for buttonIndex, buttonValues in ipairs(buttonsToDraw) do
            PushScaleformMovieFunction(instructionScaleform, "SET_DATA_SLOT")
            PushScaleformMovieFunctionParameterInt(buttonIndex - 1)

            PushScaleformMovieMethodParameterButtonName(buttonValues["button"])
            PushScaleformMovieFunctionParameterString(buttonValues["label"])
            PopScaleformMovieFunctionVoid()
        end

        PushScaleformMovieFunction(instructionScaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
        PushScaleformMovieFunctionParameterInt(-1)
        PopScaleformMovieFunctionVoid()
        DrawScaleformMovieFullscreen(instructionScaleform, 255, 255, 255, 255)
    end)
end

RCCar.Spawn = function()
	RCCar.LoadModels({ GetHashKey("rcbandito"), 68070371 })

	local spawnCoords, spawnHeading = GetEntityCoords(PlayerPedId()) + GetEntityForwardVector(PlayerPedId()) * 2.0, GetEntityHeading(PlayerPedId())

	RCCar.Entity = CreateVehicle(GetHashKey("rcbandito"), spawnCoords, spawnHeading, true)

	while not DoesEntityExist(RCCar.Entity) do
		Citizen.Wait(5)
	end

	RCCar.Driver = CreatePed(5, 68070371, spawnCoords, spawnHeading, true)

	SetEntityInvincible(RCCar.Driver, true)
	SetEntityVisible(RCCar.Driver, false)
	FreezeEntityPosition(RCCar.Driver, true)
	SetPedAlertness(RCCar.Driver, 0.0)

	TaskWarpPedIntoVehicle(RCCar.Driver, RCCar.Entity, -1)

	while not IsPedInVehicle(RCCar.Driver, RCCar.Entity) do
		Citizen.Wait(0)
	end

	RCCar.Attach("place")
	TriggerEvent("inventory:removeQty", 134, 1)
end

RCCar.Attach = function(param)
	if not DoesEntityExist(RCCar.Entity) then
		return
	end
	
	RCCar.LoadModels({ "pickup_object" })

	if param == "place" then
		AttachEntityToEntity(RCCar.Entity, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), -0.1, 0.0, -0.2, 70.0, 0.0, 270.0, 1, 1, 0, 0, 2, 1)

		TaskPlayAnim(PlayerPedId(), "pickup_object", "pickup_low", 8.0, -8.0, -1, 0, 0, false, false, false)

		Citizen.Wait(800)

		DetachEntity(RCCar.Entity, false, true)

		PlaceObjectOnGroundProperly(RCCar.Entity)
	elseif param == "pick" then
		if DoesCamExist(RCCar.Camera) then
			RCCar.ToggleCamera(false)
		end

		RCCar.Tablet(false)

		Citizen.Wait(100)

		TaskPlayAnim(PlayerPedId(), "pickup_object", "pickup_low", 8.0, -8.0, -1, 0, 0, false, false, false)

		Citizen.Wait(600)
	
		AttachEntityToEntity(RCCar.Entity, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), -0.1, 0.0, -0.2, 70.0, 0.0, 270.0, 1, 1, 0, 0, 2, 1)

		Citizen.Wait(900)
	
		DetachEntity(RCCar.Entity)

		DeleteVehicle(RCCar.Entity)
		DeleteEntity(RCCar.Driver)

		RCCar.UnloadModels()

      	TriggerEvent("inventory:addQty", 134, 1)
	end
end

RCCar.Tablet = function(boolean)
	if boolean then
		RCCar.LoadModels({ GetHashKey("prop_cs_tablet") })

		RCCar.TabletEntity = CreateObject(GetHashKey("prop_cs_tablet"), GetEntityCoords(PlayerPedId()), true)

		AttachEntityToEntity(RCCar.TabletEntity, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), -0.03, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
	
		RCCar.LoadModels({ "amb@code_human_in_bus_passenger_idles@female@tablet@idle_a" })
	
		TaskPlayAnim(PlayerPedId(), "amb@code_human_in_bus_passenger_idles@female@tablet@idle_a", "idle_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
	
		Citizen.CreateThread(function()
			while DoesEntityExist(RCCar.TabletEntity) do
				Citizen.Wait(5)
	
				if not IsEntityPlayingAnim(PlayerPedId(), "amb@code_human_in_bus_passenger_idles@female@tablet@idle_a", "idle_a", 3) then
					TaskPlayAnim(PlayerPedId(), "amb@code_human_in_bus_passenger_idles@female@tablet@idle_a", "idle_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
				end
			end

			ClearPedTasks(PlayerPedId())
		end)
	else
		DeleteEntity(RCCar.TabletEntity)
	end
end

RCCar.ToggleCamera = function(boolean)
	if not Config.Camera then return end

	if boolean then
		if not DoesEntityExist(RCCar.Entity) then return end 
		if DoesCamExist(RCCar.Camera) then DestroyCam(RCCar.Camera) end

		RCCar.Camera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)

		AttachCamToEntity(RCCar.Camera, RCCar.Entity, 0.0, 0.0, 0.4, true)

		Citizen.CreateThread(function()
			while DoesCamExist(RCCar.Camera) do
				Citizen.Wait(5)

				SetCamRot(RCCar.Camera, GetEntityRotation(RCCar.Entity))
			end
		end)

		local easeTime = 500 * math.ceil(GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(RCCar.Entity), true) / 10)

		RenderScriptCams(1, 1, easeTime, 1, 1)

		Citizen.Wait(easeTime)

		SetTimecycleModifier("scanline_cam_cheap")
		SetTimecycleModifierStrength(2.0)
	else
		local easeTime = 500 * math.ceil(GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(RCCar.Entity), true) / 10)

		RenderScriptCams(0, 1, easeTime, 1, 0)

		Citizen.Wait(easeTime)

		ClearTimecycleModifier()

		DestroyCam(RCCar.Camera)
	end
end

RCCar.LoadModels = function(models)
	for modelIndex = 1, #models do
		local model = models[modelIndex]

		if not RCCar.CachedModels then
			RCCar.CachedModels = {}
		end

		table.insert(RCCar.CachedModels, model)

		if IsModelValid(model) then
			while not HasModelLoaded(model) do
				RequestModel(model)
	
				Citizen.Wait(10)
			end
		else
			while not HasAnimDictLoaded(model) do
				RequestAnimDict(model)
	
				Citizen.Wait(10)
			end    
		end
	end
end

RCCar.UnloadModels = function()
	for modelIndex = 1, #RCCar.CachedModels do
		local model = RCCar.CachedModels[modelIndex]

		if IsModelValid(model) then
			SetModelAsNoLongerNeeded(model)
		else
			RemoveAnimDict(model)   
		end
	end
end

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

RegisterNetEvent('NRP-Games:roll')
AddEventHandler('NRP-Games:roll', function ()
    loadAnimDict("anim@mp_player_intcelebrationmale@wank")
    TaskPlayAnim(GetPlayerPed(-1), "anim@mp_player_intcelebrationmale@wank", "wank", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
    Citizen.Wait(1500)
    ClearPedTasks(GetPlayerPed(-1))
end)

function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict( dict )
        Citizen.Wait(5)
    end
end

--[[local isIntrunk = false

RegisterCommand('trunkgetin', function(source, args, rawCommand)
 local pos = GetEntityCoords(GetPlayerPed(-1), false)
 local vehicle = GetClosestVehicle(pos.x, pos.y, pos.z, 5.0, 0, 71)
 if DoesEntityExist(vehicle) and GetVehicleDoorLockStatus(vehicle) == 1 and not kidnapped then
  if not isIntrunk then
   AttachEntityToEntity(GetPlayerPed(-1), vehicle, -1, 0.0, -2.2, 0.5, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
   RaiseConvertibleRoof(vehicle, false)
   if IsEntityAttached(GetPlayerPed(-1)) then
    RequestAnimDict('timetable@floyd@cryingonbed@base')
    while not HasAnimDictLoaded('timetable@floyd@cryingonbed@base') do
     Citizen.Wait(1)
    end
    TaskPlayAnim(GetPlayerPed(-1), 'timetable@floyd@cryingonbed@base', 'base', 1.0, -1, -1, 1, 0, 0, 0, 0)
   end
  end
  isIntrunk = true
 end
end)

RegisterCommand('trunkgetout', function(source, args, rawCommand)
 local pos = GetEntityCoords(GetPlayerPed(-1), false)
 local vehicle = GetClosestVehicle(pos.x, pos.y, pos.z, 5.0, 0, 71)
 if DoesEntityExist(vehicle) and GetVehicleDoorLockStatus(vehicle) == 1 then
  if isIntrunk then
   DetachEntity(GetPlayerPed(-1), 0, true)
   SetEntityVisible(GetPlayerPed(-1), true)
   ClearPedTasksImmediately(GetPlayerPed(-1))
  end
  isInTrunk = false
 end
end)
]]--