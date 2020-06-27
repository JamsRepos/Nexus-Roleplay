local guiEnabled = false
local myIdentity = {}

-- Lock NPC Cars
--[[
Citizen.CreateThread(function() 
    while true do
        if DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId())) then
            local veh = GetVehiclePedIsTryingToEnter(PlayerPedId())
            local lock = GetVehicleDoorLockStatus(veh)

            if lock == 7 then
                SetVehicleDoorsLocked(veh, 2)
            end
                 
            local pedd = GetPedInVehicleSeat(veh, -1)

            if pedd then                   
                SetPedCanBeDraggedOut(pedd, false)
            end             
        end
        Citizen.Wait(0)		
    end
end)
--]]
-- Remove Police Vehicles
--[[
local messagesent = false

Citizen.CreateThread(function()
  while true do
  Citizen.Wait(0)
      if IsPedInAnyPoliceVehicle(GetPlayerPed(PlayerId())) then
          local veh = GetVehiclePedIsUsing(GetPlayerPed(PlayerId()), false)
          if (GetPedInVehicleSeat(veh, -1) == GetPlayerPed(PlayerId())) then
              if not DecorGetBool(GetPlayerPed(-1), "isOfficer") and not DecorGetBool(GetPlayerPed(-1), "isParamedic") then
                if not messagesent then
                  exports['NRP-notify']:DoHudText('error', 'This vehicle is for Emergency Services only.')
                  messagesent = true
                end
                SetVehicleUndriveable(veh, true)
              end
          end
      end
  end
end)
--]]
Citizen.CreateThread(function()
  while true do
  Citizen.Wait(0)
  local playerPed = GetPlayerPed(-1)
  local playerLocalisation = GetEntityCoords(playerPed)
  ClearAreaOfCops(playerLocalisation.x, playerLocalisation.y, playerLocalisation.z, 1000.0)
  end
end)

-- Remove Vehicle Spawns

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    RemoveVehiclesFromGeneratorsInArea(-45.121 - 10.0, -1098.38 - 10.0, 26.422 - 10.0, -45.121 + 10.0, -1098.38 + 10.0, -45.121 + 10.0); -- PDM
  end
end)

function loadAnimDict( dict )
  while ( not HasAnimDictLoaded( dict ) ) do
      RequestAnimDict( dict )
      Citizen.Wait( 5 )
  end
end

-- Disable Weapon Bashing

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		DisableControlAction(0, 140, true)
	end
end)

-- Disable Combat Rolling

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if IsPlayerFreeAiming(PlayerId()) then
      DisableControlAction(0, 22, true)
    end
  end
end)

RegisterCommand('k', function(source, args, rawCommand)
  local player = GetPlayerPed( -1 )
  if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
   loadAnimDict( "random@arrests" )
   loadAnimDict( "random@arrests@busted" )
   if ( IsEntityPlayingAnim( player, "random@arrests@busted", "idle_a", 3 ) ) then 
    TaskPlayAnim( player, "random@arrests@busted", "exit", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
    Wait (3000)
    TaskPlayAnim( player, "random@arrests", "kneeling_arrest_get_up", 8.0, 1.0, -1, 128, 0, 0, 0, 0 )
   else
    TaskPlayAnim( player, "random@arrests", "idle_2_hands_up", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
    Wait (4000)
    TaskPlayAnim( player, "random@arrests", "kneeling_arrest_idle", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
    Wait (500)
    TaskPlayAnim( player, "random@arrests@busted", "enter", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
    Wait (1000)
    TaskPlayAnim( player, "random@arrests@busted", "idle_a", 8.0, 1.0, -1, 9, 0, 0, 0, 0 )
   end     
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "random@arrests@busted", "idle_a", 3) then
      DisableControlAction(1, 140, true)
      DisableControlAction(1, 141, true)
      DisableControlAction(1, 142, true)
      DisableControlAction(0,21,true)
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    --This is the Application ID (Replace this with you own)
    SetDiscordAppId(699711717948653670)
    --Here you will have to put the image name for the "large" icon.
    SetDiscordRichPresenceAsset('logo')
    --Here you can add hover text for the "large" icon.
    SetDiscordRichPresenceAssetText('Nexus Roleplay')
    --Here you will have to put the image name for the "small" icon.
    SetDiscordRichPresenceAssetSmall('')
    --Here you can add hover text for the "small" icon.
    SetDiscordRichPresenceAssetSmallText('')
    --It updates every one minute just in case.
	Citizen.Wait(60000)
  end
end)