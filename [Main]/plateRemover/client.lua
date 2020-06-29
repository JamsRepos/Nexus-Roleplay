-- Made by B1G (Carlos V.), edited by Inferno (Christopher M.)
local LastVehicle = nil
local LicencePlate = {}
LicencePlate.Index = false
LicencePlate.Number = false



-- Command to remove plate
RegisterCommand("removeplate", function()
 local rep = DecorGetInt(GetPlayerPed(-1), "Reputation")
  if rep > 500 then
   if exports['core']:GetItemQuantity >= 1 then   
    -- Check if the player has plates stored
    if not LicencePlate.Index and not LicencePlate.Number then
        -- Client's ped
        local PlayerPed = PlayerPedId()
        -- Client's coords
        local Coords = GetEntityCoords(PlayerPed)
        -- Closest vehicle
        local Vehicle = GetClosestVehicle(Coords.x, Coords.y, Coords.z, 3.5, 0, 70)
        -- Client's coords
        local VehicleCoords = GetEntityCoords(Vehicle)
        -- Distance between client's ped and closest vehicle
        local Distance = Vdist(VehicleCoords.x, VehicleCoords.y, VehicleCoords.z, Coords.x, Coords.y, Coords.z)
        -- If within range and Ped is in a vehicle
        if Distance < 3.5 and not IsPedInAnyVehicle(PlayerPed, false) then
            --Saves the last vehicle
			LastVehicle = Vehicle
            -- Notification and animation
            Animation()
            TriggerEvent("mythic_progbar:client:progress", {
                name = "rplate",
                duration = 6000,
                label = "Removing Plate adding Blank Plate",
                useWhileDead = false,
                canCancel = false,
                controlDisables = {
                   disableMovement = true,
                   disableCarMovement = false,
                   disableMouse = false,
                   disableCombat = true,
                },
              }, function(status)
               if not status then             
                 StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
                 TriggerEvent("inventory:removeQty", 262, 1)
                 TriggerEvent("inventory:addQty", 263, 1)
                end
             end) 
            -- Store plate index
            LicencePlate.Index = GetVehicleNumberPlateTextIndex(Vehicle)
            -- Store plate number
            LicencePlate.Number = GetVehicleNumberPlateText(Vehicle)
            -- Set the plate to nothing
            SetVehicleNumberPlateText(Vehicle, " ")
        else
            -- Notification
			exports["NRP-notify"]:DoHudText("error", "No vehicle nearby.")

        end
    else
        -- Notification
		exports["NRP-notify"]:DoHudText("error", "You already have a licence plate on you.")
    end
   else
    exports["NRP-notify"]:DoHudText("error", "You Dont Have Blank Plate On You")  
   end
  else  
   exports["NRP-notify"]:DoHudText("error", "You Dont Have Enough Reputation")  
  end 
end)

-- Command to put plate back
RegisterCommand("putplate", function()
  if exports['core']:GetItemQuantity(263) >= 1 then  
    -- Check if the player has plates stored
    if LicencePlate.Index and LicencePlate.Number then
        -- Client's ped
        local PlayerPed = PlayerPedId()
        -- Client's coords
        local Coords = GetEntityCoords(PlayerPed)
        -- Closest vehicle
        local Vehicle = GetClosestVehicle(Coords.x, Coords.y, Coords.z, 3.5, 0, 70)
        -- Client's coords
        local VehicleCoords = GetEntityCoords(Vehicle)
        -- Distance between client's ped and closest vehicle
        local Distance = Vdist(VehicleCoords.x, VehicleCoords.y, VehicleCoords.z, Coords.x, Coords.y, Coords.z)
        -- If within range and Ped is in a vehicle
        if ( (Distance < 3.5) and not IsPedInAnyVehicle(PlayerPed, false) ) then
		if (Vehicle == LastVehicle) then
			--Cleans variable
				LastVehicle = nil
                -- Notification and animation
                Animation()
                TriggerEvent("mythic_progbar:client:progress", {
                    name = "aplate",
                    duration = 6000,
                    label = "Removing Blank Plate and Putting Plate Back",
                    useWhileDead = false,
                    canCancel = false,
                    controlDisables = {
                       disableMovement = true,
                       disableCarMovement = false,
                       disableMouse = false,
                       disableCombat = true,
                    },
                  }, function(status)
                   if not status then             
                     StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
                     TriggerEvent("inventory:removeQty", 263, 1)
                     TriggerEvent("inventory:addQty", 262, 1)
                    end
                 end)     
			-- Set plate index to stored index
			SetVehicleNumberPlateTextIndex(Vehicle, LicencePlate.Index)
			-- Set plate number to stored number
			SetVehicleNumberPlateText(Vehicle, LicencePlate.Number)
			-- Reset stored values
			LicencePlate.Index = false
            LicencePlate.Number = false
		else
			-- Notification
			exports["NRP-notify"]:DoHudText("error", "This plate does not belong here")
		end
        else
            -- Notification
			exports["NRP-notify"]:DoHudText("error", "No vehicle nearby.") 
        end
    else
        -- Notification
		exports["NRP-notify"]:DoHudText("error", "You already have a licence plate on you.")
    end
  else
    exports["NRP-notify"]:DoHudText("error", "You Dont Have a Plate On You")  
  end  
end)

--ANIMATION
function Animation()
    local pid = PlayerPedId()
    RequestAnimDict("mini")
    RequestAnimDict("mini@repair")
    while (not HasAnimDictLoaded("mini@repair")) do 
		Citizen.Wait(10) 
	end
    TaskPlayAnim(pid,"mini@repair","fixing_a_player",1.0,-1.0, 5000, 0, 1, true, true, true)
end
