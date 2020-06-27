local TOGGLE_KEY = 70



local pets = {
	["Cat"]  		= 1462895032,
	["Husky"] 		= 1318032802,
	["Pug"] 		= 1832265812,
	["Poodle"] 		= 1125994524,
	["Rottweiler"] 	= -1788665315,
	["Retriever"] 	= 882848737,
	["Shepherd"] 	= 1126154828,
	["Westy"] 		= -1384627013,
}

local my_pet ={
	handle = nil,
	hash = pets["Husky"],
	name = "RenameMe",
	showName = true,
}


RegisterCommand('pet', function(source, args, rawCommand) 
	if exports['core']:GetItemQuantity(278) >= 1 then
		WarMenu.OpenMenu('PET_MENU')
	else
	 exports['NRP-notify']:DoHudText('error', 'You dont have a pet with you')		
	end
end)
  
--+++++++
-- MENU +
--+++++++
Citizen.CreateThread(function()
	CreateWarMenu('PET_MENU', 'PET MENU', 'all pet options', {0.8, 0.1}, 1.0, {1,1,1,255})
	CreateWarSubMenu('PET_SPAWN', 'PET_MENU', 'PET LIST', tablelength(pets).." PETS AVAILABLE", {0.8, 0.1}, 1.0, {1,1,1,255})
	while true do 
		Wait(0)
		local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 0.5, 0))

	 
		--- add here for if have item then -- U
		if IsControlPressed(1, 21) and IsControlJustPressed(1, 213) then	
		  if exports['core']:GetItemQuantity(278) >= 1 then
			WarMenu.OpenMenu('PET_MENU')
		  else
			exports['NRP-notify']:DoHudText('error', 'You dont have a pet with you')	
		  end	
		end
		if WarMenu.IsMenuOpened('PET_MENU') then
			if WarMenu.MenuButton('GET PET OUT', 'PET_SPAWN') then
			--[[elseif WarMenu.Button('RENAME', my_pet.name) then
				local name = Input(my_pet.name)
				if name ~= nil or name ~= '' then
					my_pet.name = name
				else
					my_pet.name = '~r~INVALID NAME'
				end
			elseif WarMenu.Button('TOGGLE NAME') then
				my_pet.showName = not my_pet.showName]]--
			elseif WarMenu.Button('PUT IN VEHICLE') then
				if IsPedInAnyVehicle(GetPlayerPed(-1), true) then
					local car = GetVehiclePedIsUsing(GetPlayerPed(-1))
					if my_pet.handle ~= nil then
						if not IsPedInAnyVehicle(my_pet.handle, true) then
							for i = 1, GetVehicleMaxNumberOfPassengers(car) do
								if IsVehicleSeatFree(car, i) then
									TaskWarpPedIntoVehicle(my_pet.handle, car, i)
								end
							end
						end
					end
				end
			elseif WarMenu.Button('BRING') then
				if DoesEntityExist(my_pet.handle) then
					SetEntityCoordsNoOffset(my_pet.handle, x, y, z)
				end
			elseif WarMenu.Button('~r~PUT AWAY') then
				DeletePed(my_pet.handle)
			end
			WarMenu.Display()
		elseif WarMenu.IsMenuOpened('PET_SPAWN') then
			for key,value in pairs(pets) do
				if WarMenu.Button(key) then
					if my_pet.handle == nil then
						my_pet.handle = CreateAPed(tonumber(value),{x = x, y = y, z = z, rot = 0})
					else
						Notify("~r~Delete your pet!")
					end
				end
			end
			WarMenu.Display()
		end
		--[[if my_pet.handle ~= nil and my_pet.showName then
        	aPos = GetEntityCoords(my_pet.handle)
        	DrawText3d(aPos.x, aPos.y, aPos.z + 0.7, 0.5, 0, "~g~[PERSONAL PET]", 255, 255, 255, false)
        	DrawText3d(aPos.x, aPos.y, aPos.z + 0.6, 0.5, 0, my_pet.name, 255, 255, 255, false)
		end]]--	  
	 
	end
end)

--+++++++++++++++++++++++++++++
-- F O L L O W      O W N E R +
--+++++++++++++++++++++++++++++
Citizen.CreateThread(function()
	while true do Wait(100)
		if my_pet.handle ~= nil then
			local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, -0.5, 0))
			local a,b,c = table.unpack(GetEntityCoords(my_pet.handle))
			local dist = Vdist(x, y, z, a, b, c)
			if dist > 2.5 then
				TaskGoToCoordAnyMeans(my_pet.handle, x, y, z, 10.0, 0, 0, 0, 0)
				while dist > 2.5 do Wait(0)
					if my_pet.handle == nil then break end
					a,b,c = table.unpack(GetEntityCoords(my_pet.handle))
					dist = Vdist(x, y, z, a, b, c)
				end
			end
		end
	end
end)
function GetLocalPed()
    return GetPlayerPed(PlayerId())
end
--++++++++++++
-- F U N C S +
--++++++++++++
function Notify(text)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(text)
	DrawNotification(true, false)
end
function Input(help)
	local var = ''
	DisplayOnscreenKeyboard(6, "FMMC_KEY_TIP8", "", help, "", "", "", 60)
	while UpdateOnscreenKeyboard() == 0 do
		DisableAllControlActions(0)
		Citizen.Wait(0)
	end
	if GetOnscreenKeyboardResult() then
		var = GetOnscreenKeyboardResult()
	end
	return var
end

function RequestNetworkControl(callback)
    local netId = NetworkGetNetworkIdFromEntity(spawned_ped)
    local timer = 0
    NetworkRequestControlOfNetworkId(netId)
    while not NetworkHasControlOfNetworkId(netId) do
        Citizen.Wait(1)
        NetworkRequestControlOfNetworkId(netId)
        timer = timer + 1
        if timer == 5000 then
            Citizen.Trace("Control failed")
            callback(false)
            break
        end
    end
    callback(true)
end

function DeletePed(handle)
	if DoesEntityExist(handle) then
		SetEntityAsMissionEntity(handle, true, true)
		DeleteEntity(handle)
	end
	my_pet.handle = nil
end
function CreateAPed(hash, pos)
	local handle = nil
	RequestModel(hash)
	while not HasModelLoaded(hash) do
		Citizen.Wait(1)
	end

	handle = CreatePed(5, hash, pos.x, pos.y, pos.z, rot, GetEntityHeading(GetLocalPed()), 0, 1)

	SetEntityInvincible(handle, true)
	SetBlockingOfNonTemporaryEvents(handle, true)
	SetPedFleeAttributes(handle, 0, 0)
	SetModelAsNoLongerNeeded(hash)
	return handle
end
function CreateWarMenu(id, title, subtitle, pos, width, rgba)
	local x,y = table.unpack(pos)
	local r,g,b,a = table.unpack(rgba)
	WarMenu.CreateMenu(id, title)
	WarMenu.SetSubTitle(id, subtitle)
	WarMenu.SetMenuX(id, x)
	WarMenu.SetMenuY(id, y)
	WarMenu.SetMenuWidth(id, width)
	WarMenu.SetTitleBackgroundColor(id, r, g, b, a)
	WarMenu.SetTitleColor(id, 255, 255, 0, a)
end
function CreateWarSubMenu(id, base, title, subtitle)
	WarMenu.CreateSubMenu(id, base, title)
	WarMenu.SetSubTitle(id, subtitle)
end
function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end
function DrawText3d(x,y,z, size, font, text, r, g, b, outline)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
	
	if onScreen then
		SetTextScale(size*scale, size*scale)
		SetTextFont(font)
		SetTextProportional(1)
		SetTextColour(r, g, b, 255)
		if not outline then
			SetTextDropshadow(0, 0, 0, 0, 55)
			SetTextEdge(2, 0, 0, 0, 150)
			SetTextDropShadow()
			SetTextOutline()
		end
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		SetDrawOrigin(x,y,z, 0)
		DrawText(0.0, 0.0)
		ClearDrawOrigin()
	end
end