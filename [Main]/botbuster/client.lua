local isAdmin = false 
local banned = false
local AlreadyTriggered = false
local BannedVehicles = {
  "baller",
  "rhino",
  "apc",
  "oppressor",
  "tampa3",
  "insurgent3",
  "technical3",
  "halftrack",
  "nightshark",
  "dune4",
  "dune5",
  "phantom2",
  "ruiner2",
  "technical2",
  "voltic2",
  "hydra",
  "jet",
  "blimp",
  "cargoplane",
  "titan",
  "buzzard",
  "valkyrie",
  "savage",
  "dune3",
  "khanjali",
  "avenger",
  "insurgent",
  "insurgent2"
}

local BannedWeapons = {
	"WEAPON_RAILGUN",
	"WEAPON_GRENADELAUNCHER",
	"WEAPON_RPG",
	"WEAPON_PASSENGER_ROCKET",
	"WEAPON_AIRSTRIKE_ROCKET",
	"WEAPON_STINGER",
	"WEAPON_MINIGUN",
	"WEAPON_BALL",
	"WEAPON_GARBAGEBAG",
	"WEAPON_VEHICLE_ROCKET"
}

-- Client side events that are abused with TriggerEvent
--[[
local ForbiddenClientEvents = {
    "ambulancier:selfRespawn",
    "bank:transfer",
    "esx_ambulancejob:revive",
    "esx-qalle-jail:openJailMenu",
    "esx_jailer:wysylandoo",
    "esx_policejob:getarrested",
    "esx_society:openBossMenu",
    "esx:spawnVehicle",
    "esx_status:set",
    "HCheat:TempDisableDetection",
    "UnJP"
}
--]]

local CageObjs = {
	"prop_gold_cont_01",
	"p_cablecar_s",
	"stt_prop_stunt_tube_l",
	"stt_prop_stunt_track_dwuturn",
}

DecorRegister("isAdmin", 2)
DecorSetBool(GetPlayerPed(-1), "isAdmin", false)

RegisterNetEvent('es_admin:setGroup')
AddEventHandler('es_admin:setGroup', function(g)
 if g ~= 'user' then
  isAdmin = true
  print('You Are A Staff Member :)')
  DecorSetBool(GetPlayerPed(-1), "isAdmin", true)
 end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        if not isAdmin then
            if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                local veh = GetVehiclePedIsUsing(GetPlayerPed(-1), false)
                for i = 1, #BannedVehicles do
                    local vehicle_name = BannedVehicles[i]
                    local vehicle = GetHashKey(vehicle_name)
                    if GetEntityModel(veh) == vehicle then
                        if not banned then
                            SetEntityAsMissionEntity(veh, true, true)
                            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
                            if not vehicle == 'baller' then
                                banned = true
                                TriggerServerEvent('anticheat:ban')
                            end
                        end
                    end
                end

                if IsPedInAnyPlane(GetPlayerPed(-1)) or IsPedInAnyHeli(GetPlayerPed(-1)) and not DecorGetBool(GetPlayerPed(-1), "isOfficer") and not DecorGetBool(GetPlayerPed(-1), "isParamedic") then
                    SetEntityAsMissionEntity(veh, true, true)
                    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))     
                end

                if GetVehicleNumberPlateText(veh) == 'FIVE M' or GetVehicleNumberPlateText(veh) == 'FiveM' then 
                	SetEntityAsMissionEntity(veh, true, true)
               		Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
                	TriggerServerEvent('anticheat:ban')
                end
            end 
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        if not isAdmin then
            for i = 1, #BannedWeapons do
                local weapon_t = BannedWeapons[i]
                local weapon = GetHashKey(weapon_t)
                if HasPedGotWeapon(GetPlayerPed(-1), weapon, false) then
                    if not banned then
                        banned = true
                        TriggerServerEvent('anticheat:warn')
                    end
                end
            end
        end
    end
end)

function ReqAndDelete(object, detach)
	if DoesEntityExist(object) then
		NetworkRequestControlOfEntity(object)
		while not NetworkHasControlOfEntity(object) do
			Citizen.Wait(1)
		end
		if detach then
			DetachEntity(object, 0, false)
		end
		SetEntityCollision(object, false, false)
		SetEntityAlpha(object, 0.0, true)
		SetEntityAsMissionEntity(object, true, true)
		SetEntityAsNoLongerNeeded(object)
		DeleteEntity(object)
	end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        SetVehicleModelIsSuppressed(GetHashKey("blimp"), true) 
        SetVehicleModelIsSuppressed(GetHashKey("rubble"), true)
        SetVehicleModelIsSuppressed(GetHashKey("taco"), true)
        SetVehicleModelIsSuppressed(GetHashKey("biff"), true)
        end
    end
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(5000)
        local handle, object = FindFirstObject()
        local finished = false
        repeat
        if not isAdmin then
            Wait(1)
			if IsEntityAttached(object) and DoesEntityExist(object) then
				if GetEntityModel(object) == GetHashKey("prop_acc_guitar_01") then
					ReqAndDelete(object, true)
				end
			end
            for i = 1, #CageObjs do
                if GetEntityModel(object) == GetHashKey(CageObjs[i]) then
                    if not banned then
                        banned = true
                        ReqAndDelete(object, false)
                    end
                end
            end
            finished, object = FindNextObject(handle)
        end
    until not finished
    EndFindObject(handle)
    end
end)
--[[
for i, eventName in ipairs(ForbiddenClientEvents) do
    AddEventHandler(
        eventName,
        function()
            if AlreadyTriggered == true then
                CancelEvent()
                return
            end
            TriggerServerEvent('anticheat:ban')
            AlreadyTriggered = true
        end
    )
end
--]]
AddEventHandler(
    "esx:getSharedObject",
    function(cb)
        if AlreadyTriggered == true then
            CancelEvent()
            cb(nil)
            return
        end
        TriggerServerEvent('anticheat:ban')
        AlreadyTriggered = true
        cb(nil)
    end
)

CreateThread(function()
	while true do
		TriggerServerEvent("checkMyCommandList", GetRegisteredCommands())
		Wait(15000)
	end
end)