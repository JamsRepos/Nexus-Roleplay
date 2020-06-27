handsup = false
local canHandsUp = true
DecorRegister("Handsup", 2)
DecorSetBool(GetPlayerPed(-1), "Handsup", false)

function getSurrenderStatus()
	return handsup
end

RegisterNetEvent('vk_handsup:getSurrenderStatusPlayer')
AddEventHandler('vk_handsup:getSurrenderStatusPlayer',function(event,source)
		if handsup then
			TriggerServerEvent("vk_handsup:reSendSurrenderStatus",event,source,true)
		else
			TriggerServerEvent("vk_handsup:reSendSurrenderStatus",event,source,false)
		end
end)

AddEventHandler("handsup:toggle", function(param)
	canHandsUp = param
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local lPed = GetPlayerPed(-1)
		RequestAnimDict("random@mugging3")
		if not IsPedInAnyVehicle(lPed, false) and not IsPedSwimming(lPed) and not IsPedShooting(lPed) and not IsPedClimbing(lPed) and not IsPedCuffed(lPed) and not IsPedDiving(lPed) and not IsPedFalling(lPed) and not IsPedJumping(lPed) and not IsPedJumpingOutOfVehicle(lPed) and IsPedOnFoot(lPed) and not IsPedRunning(lPed) and not IsPedUsingAnyScenario(lPed) and not IsPedInParachuteFreeFall(lPed) then
			if IsControlPressed(1, 73) then
			  if IsControlPressed(1, 21) and IsControlPressed(1, 120) then
			  else	
				if DoesEntityExist(lPed) then
					--SetCurrentPedWeapon(lPed, 0xA2719263, true)
					Citizen.CreateThread(function()
						RequestAnimDict("random@mugging3")
						while not HasAnimDictLoaded("random@mugging3") do
							Citizen.Wait(100)
						end

						if not handsup then
							handsup = true
							TaskPlayAnim(lPed, "random@mugging3", "handsup_standing_base", 3.0, 2.5, -1, 49, 0, 0, 0, 0)
              DecorSetBool(GetPlayerPed(-1), "Handsup", true)
						end   
					end)
				end
		      end	
			end
		end
		if IsControlReleased(1, 73) then	
			if DoesEntityExist(lPed) then
				Citizen.CreateThread(function()
					RequestAnimDict("random@mugging3")
					while not HasAnimDictLoaded("random@mugging3") do
						Citizen.Wait(100)
					end

					if handsup then
						handsup = false
						ClearPedSecondaryTask(lPed)
            DecorSetBool(GetPlayerPed(-1), "Handsup", false)
					end
				end)
			end
		end
	end
end)