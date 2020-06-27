local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
RegisterNetEvent('NRP-holdupbank:currentlyhacking')
AddEventHandler('NRP-holdupbank:currentlyhacking', function(mycb)
 mycb = true
 TriggerEvent("mhacking:show") 
 TriggerEvent("mhacking:start",4,15,mycb1)
end)
RegisterNetEvent('NRP-holdupbank:robberyover')
AddEventHandler('NRP-holdupbank:robberyover', function(mycb)
 mycb = true
 mycb2() 
end)

Citizen.CreateThread(function()
	while true do
		for _,doorID in ipairs(Config.DoorList) do
			if doorID.doors then
				for k,v in ipairs(doorID.doors) do
					if not v.object or not DoesEntityExist(v.object) then
						v.object = GetClosestObjectOfType(v.objCoords, 1.5, GetHashKey(v.objName), false, false, false)
					end
				end
			else
				if not doorID.object or not DoesEntityExist(doorID.object) then
					doorID.object = GetClosestObjectOfType(doorID.objCoords, 1.5, GetHashKey(doorID.objName), false, false, false)
				end
			end
		end
		Citizen.Wait(1000)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerCoords = GetEntityCoords(GetPlayerPed(-1))
		for k,doorID in ipairs(Config.DoorList) do
			local distance
			if doorID.doors then
			 distance = #(playerCoords - doorID.doors[1].objCoords)
			else
			 distance = #(playerCoords - doorID.objCoords)
			end	
			if doorID.distance then
			 maxDistance = doorID.distance
			end
			if distance < 50 then
				if doorID.doors then
					for _,v in ipairs(doorID.doors) do
						FreezeEntityPosition(v.object, doorID.locked)
						if doorID.locked and v.objYaw and GetEntityRotation(v.object).z ~= v.objYaw then
							SetEntityRotation(v.object, 0.0, 0.0, v.objYaw, 2, true)
						end
					end
				else
					FreezeEntityPosition(doorID.object, doorID.locked)
					if doorID.locked and doorID.objYaw and GetEntityRotation(doorID.object).z ~= doorID.objYaw then
						SetEntityRotation(doorID.object, 0.0, 0.0, doorID.objYaw, 2, true)
					end
				end
			end
			if distance < maxDistance then
				if doorID.size then
					size = doorID.size
				end
				if doorID.locked then
					
				end
            function mycb1(success, timeremaining)
                if success then
                 doorID.locked = not doorID.locked
                 TriggerServerEvent('doorlock:updateState', i, doorID.locked)
				 TriggerEvent('mhacking:hide')
				 TriggerEvent('NRP-holdupbank:success')	
			    else
				 TriggerEvent('mhacking:hide')
				 TriggerEvent('NRP-holdupbank:fail')
                end
			end	
			function mycb2()
			 doorID.locked = not doorID.locked
			 TriggerServerEvent('doorlock:updateState', i, doorID.locked)			 				
			end
		   end	
		end
	end
end)

RegisterNetEvent('doorlock:setState')
AddEventHandler('doorlock:setState', function(doorID, state)
	Config.DoorList[doorID].locked = state
end)