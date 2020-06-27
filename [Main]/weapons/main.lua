local Weapons = {}
local all = {}
local Loaded = false
local currentlyHoldingHandgun = false
-----------------------------------------------------------
-----------------------------------------------------------
Citizen.CreateThread(function()
 while not Loaded do
  Wait(250)
 end
 while true do
  for i=1, #Config.RealWeapons, 1 do
   local weaponHash = GetHashKey(Config.RealWeapons[i].name)
   if HasPedGotWeapon(GetPlayerPed(-1), weaponHash, false) then
    local onPlayer = false
    for weaponName, entity in pairs(Weapons) do
     if weaponName == Config.RealWeapons[i].name then
      onPlayer = true
      break
     end
    end
	   
    if not onPlayer and weaponHash ~= GetSelectedPedWeapon(GetPlayerPed(-1)) then
	 SetGear(Config.RealWeapons[i].name)
    elseif onPlayer and weaponHash == GetSelectedPedWeapon(GetPlayerPed(-1)) then
	 RemoveGear(Config.RealWeapons[i].name)
    end
   end
  end
  Wait(500)
 end
end)

RegisterNetEvent('weapons:updateback')
AddEventHandler('weapons:updateback', function()
	RemoveAllGears()
	local weapons = exports.core:getWeapons()
	for ind, v in pairs(weapons) do
		SetGear(v.name)
	end
	Loaded = true
end)

RegisterNetEvent('weapons:addmodel')
AddEventHandler('weapons:addmodel', function(weaponName)
 SetGear(weaponName)
end)

RegisterNetEvent('weapons:removemodel')
AddEventHandler('weapons:removemodel', function(weaponName)
	RemoveGear(weaponName)
end)

RegisterNetEvent('weapons:removeallmodels')
AddEventHandler('weapons:removeallmodels', function()
	RemoveAllGears()
end)

function RemoveGear(weapon)
	local _Weapons = {}

	for weaponName, entity in pairs(Weapons) do
		if weaponName ~= weapon then
			_Weapons[weaponName] = entity
		else
			print('Removing: '..weapon)
			SetEntityAsMissionEntity(entity,  false,  true)
			DeleteObject(entity)
		end
	end

	Weapons = _Weapons
end

function RemoveAllGears()
	for _,v in pairs(all) do
		SetEntityAsMissionEntity(v.obj,  false,  true)
		DeleteObject(v.obj)
	end
	all = {}
end

function SetGear(weapon)
	local bone       = nil
	local boneX      = 0.0
	local boneY      = 0.0
	local boneZ      = 0.0
	local boneXRot   = 0.0
	local boneYRot   = 0.0
	local boneZRot   = 0.0
	local playerPed  = GetPlayerPed(-1)
	local x, y, z    = table.unpack(GetEntityCoords(playerPed, true))
	local model      = nil
	local cat        = nil
		
	for i=1, #Config.RealWeapons, 1 do
		if Config.RealWeapons[i].name == weapon then
			bone     = Config.RealWeapons[i].bone
			boneX    = Config.RealWeapons[i].x
			boneY    = Config.RealWeapons[i].y
			boneZ    = Config.RealWeapons[i].z
			boneXRot = Config.RealWeapons[i].xRot
			boneYRot = Config.RealWeapons[i].yRot
			boneZRot = Config.RealWeapons[i].zRot
			model    = Config.RealWeapons[i].model
			cat      = Config.RealWeapons[i].category
			break
		end
	end

	if boneX ~= 65536.0 and cat ~= "melee" and cat ~= "handguns" and cat ~= "none" and cat ~= "trown" and cat ~= "others" then
		Citizen.CreateThread(function()

			--print("Trying to spawn model: "..model)
			RequestModel(model)

			while not HasModelLoaded(model) do
				Citizen.Wait(1)
			end

			--print("HasModelLoaded: "..model)
			local obj = CreateObject(model, x, y, z, true, true, true)

			local boneIndex = GetPedBoneIndex(playerPed, bone)
			local bonePos 	= GetWorldPositionOfEntityBone(playerPed, boneIndex)
			AttachEntityToEntity(obj, playerPed, boneIndex, boneX, boneY, boneZ, boneXRot, boneYRot, boneZRot, false, false, false, false, 2, true)
			
			--print("AttachEntityToEntity: "..model)
			Weapons[weapon] = obj
			table.insert(all, {obj = obj})
		end)
	end
end
