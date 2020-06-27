onJob = 0
local mission_list = {}
local jobpay = 0
jobs = {peds = {}, flag = {}, blip = {}, cars = {}, coords = {cx={}, cy={}, cz={}}}

function StartJob(jobid)
	if jobid == 1 then -- taxi
		showLoadingPromt("Loading Work: Taxi Driver", 2000, 3)
		exports['NRP-notify']:DoHudText('inform', "Drive Around Slowly And Locals Will Pop Up On Your GPS if They Need a Taxi")
		jobs.coords.cx[1],jobs.coords.cy[1],jobs.coords.cz[1] = 293.476,-590.163,42.7371
		jobs.coords.cx[2],jobs.coords.cy[2],jobs.coords.cz[2] = 253.404,-375.86,44.0819
		jobs.coords.cx[3],jobs.coords.cy[3],jobs.coords.cz[3] = 120.808,-300.416,45.1399
		jobs.coords.cx[4],jobs.coords.cy[4],jobs.coords.cz[4] = -38.4132,-381.576,38.3456
		jobs.coords.cx[5],jobs.coords.cy[5],jobs.coords.cz[5] = -107.442,-614.377,35.6703
		jobs.coords.cx[6],jobs.coords.cy[6],jobs.coords.cz[6] = -252.292,-856.474,30.5626
		jobs.coords.cx[7],jobs.coords.cy[7],jobs.coords.cz[7] = -236.138,-988.382,28.7749
		jobs.coords.cx[8],jobs.coords.cy[8],jobs.coords.cz[8] = -276.989,-1061.18,25.6853
		jobs.coords.cx[9],jobs.coords.cy[9],jobs.coords.cz[9] = -576.451,-998.989,21.785
		jobs.coords.cx[10],jobs.coords.cy[10],jobs.coords.cz[10] = -602.798,-952.63,21.6353
		jobs.coords.cx[11],jobs.coords.cy[11],jobs.coords.cz[11] = -790.653,-961.855,14.8932
		jobs.coords.cx[12],jobs.coords.cy[12],jobs.coords.cz[12] = -912.588,-864.756,15.0057
		jobs.coords.cx[13],jobs.coords.cy[13],jobs.coords.cz[13] = -1069.77,-792.513,18.8075
		jobs.coords.cx[14],jobs.coords.cy[14],jobs.coords.cz[14] = -1306.94,-854.085,15.0959
		jobs.coords.cx[15],jobs.coords.cy[15],jobs.coords.cz[15] = -1468.51,-681.363,26.178
		jobs.coords.cx[16],jobs.coords.cy[16],jobs.coords.cz[16] = -1380.89,-452.7,34.0843
		jobs.coords.cx[17],jobs.coords.cy[17],jobs.coords.cz[17] = -1326.35,-394.81,36.0632
		jobs.coords.cx[18],jobs.coords.cy[18],jobs.coords.cz[18] = -1383.68,-269.985,42.4878
		jobs.coords.cx[19],jobs.coords.cy[19],jobs.coords.cz[19] = -1679.61,-457.339,39.4048
		jobs.coords.cx[20],jobs.coords.cy[20],jobs.coords.cz[20] = -1812.45,-416.917,43.6734
		jobs.coords.cx[21],jobs.coords.cy[21],jobs.coords.cz[21] = -2043.64,-268.291,22.9927
		jobs.coords.cx[22],jobs.coords.cy[22],jobs.coords.cz[22] = -2186.45,-421.595,12.6776
		jobs.coords.cx[23],jobs.coords.cy[23],jobs.coords.cz[23] = -1862.08,-586.528,11.1747
		jobs.coords.cx[24],jobs.coords.cy[24],jobs.coords.cz[24] = -1859.5,-617.563,10.8788
		jobs.coords.cx[25],jobs.coords.cy[25],jobs.coords.cz[25] = -1634.95,-988.302,12.6241
		jobs.coords.cx[26],jobs.coords.cy[26],jobs.coords.cz[26] = -1283.99,-1154.16,5.30998
		jobs.coords.cx[27],jobs.coords.cy[27],jobs.coords.cz[27] = -1126.47,-1338.08,4.63434
		jobs.coords.cx[28],jobs.coords.cy[28],jobs.coords.cz[28] = -867.907,-1159.67,5.00795
		jobs.coords.cx[29],jobs.coords.cy[29],jobs.coords.cz[29] = -847.55,-1141.38,6.27591
		jobs.coords.cx[30],jobs.coords.cy[30],jobs.coords.cz[30] = -722.625,-1144.6,10.2176
		jobs.coords.cx[31],jobs.coords.cy[31],jobs.coords.cz[31] = -575.503,-318.446,34.5273
		jobs.coords.cx[32],jobs.coords.cy[32],jobs.coords.cz[32] = -592.309,-224.853,36.1209
		jobs.coords.cx[33],jobs.coords.cy[33],jobs.coords.cz[33] = -559.594,-162.873,37.7547
		jobs.coords.cx[34],jobs.coords.cy[34],jobs.coords.cz[34] = -534.992,-65.6695,40.634
		jobs.coords.cx[35],jobs.coords.cy[35],jobs.coords.cz[35] = -758.234,-36.6906,37.2911
		jobs.coords.cx[36],jobs.coords.cy[36],jobs.coords.cz[36] = -1375.88,20.9516,53.2255
		jobs.coords.cx[37],jobs.coords.cy[37],jobs.coords.cz[37] = -1320.25,-128.018,48.097
		jobs.coords.cx[38],jobs.coords.cy[38],jobs.coords.cz[38] = -1285.71,294.287,64.4619
		jobs.coords.cx[39],jobs.coords.cy[39],jobs.coords.cz[39] = -1245.67,386.533,75.0908
		jobs.coords.cx[40],jobs.coords.cy[40],jobs.coords.cz[40] = -760.355,285.015,85.0667
		jobs.coords.cx[41],jobs.coords.cy[41],jobs.coords.cz[41] = -626.786,254.146,81.0964
		jobs.coords.cx[42],jobs.coords.cy[42],jobs.coords.cz[42] = -563.609,267.962,82.5116
		jobs.coords.cx[43],jobs.coords.cy[43],jobs.coords.cz[43] = -486.806,271.977,82.8187
		jobs.coords.cx[44],jobs.coords.cy[44],jobs.coords.cz[44] = 88.295,250.867,108.188
		jobs.coords.cx[45],jobs.coords.cy[45],jobs.coords.cz[45] = 234.087,344.678,105.018
		jobs.coords.cx[46],jobs.coords.cy[46],jobs.coords.cz[46] = 434.963,96.707,99.1713
		jobs.coords.cx[47],jobs.coords.cy[47],jobs.coords.cz[47] = 482.617,-142.533,58.1936
		jobs.coords.cx[48],jobs.coords.cy[48],jobs.coords.cz[48] = 762.651,-786.55,25.8915
		jobs.coords.cx[49],jobs.coords.cy[49],jobs.coords.cz[49] = 809.06,-1290.8,25.7946
		jobs.coords.cx[50],jobs.coords.cy[50],jobs.coords.cz[50] = 490.819,-1751.37,28.0987
		jobs.coords.cx[51],jobs.coords.cy[51],jobs.coords.cz[51] = 432.351,-1856.11,27.0352
		jobs.coords.cx[52],jobs.coords.cy[52],jobs.coords.cz[52] = 164.348,-1734.54,28.8982
		jobs.coords.cx[53],jobs.coords.cy[53],jobs.coords.cz[53] = -57.6909,-1501.4,31.1084
		jobs.coords.cx[54],jobs.coords.cy[54],jobs.coords.cz[54] = 52.2241,-1566.65,29.006
		jobs.coords.cx[55],jobs.coords.cy[55],jobs.coords.cz[55] = 310.222,-1376.76,31.4442
		jobs.coords.cx[56],jobs.coords.cy[56],jobs.coords.cz[56] = 181.967,-1332.79,28.8773
		jobs.coords.cx[57],jobs.coords.cy[57],jobs.coords.cz[57] = -74.6091,-1100.64,25.738
		jobs.coords.cx[58],jobs.coords.cy[58],jobs.coords.cz[58] = -887.045,-2187.46,8.13248
		jobs.coords.cx[59],jobs.coords.cy[59],jobs.coords.cz[59] = -749.584,-2296.59,12.4627
		jobs.coords.cx[60],jobs.coords.cy[60],jobs.coords.cz[60] = -1064.83,-2560.66,19.6811
		jobs.coords.cx[61],jobs.coords.cy[61],jobs.coords.cz[61] = -1033.44,-2730.24,19.6868
		jobs.coords.cx[62],jobs.coords.cy[62],jobs.coords.cz[62] = -1018.67,-2732,13.2687
		jobs.cars[1] = GetVehiclePedIsUsing(GetPlayerPed(-1))
		jobs.flag[1] = 0
		jobs.flag[2] = 59+GetRandomIntInRange(1, 61)
		Wait(2000)
		drawTxt("~w~Drive around and look for ~h~~g~passengers~w~.", 10000)
		onJob = jobid
	end
end

function showLoadingPromt(showText, showTime, showType)
	Citizen.CreateThread(function()
		Citizen.Wait(0)
		N_0xaba17d7ce615adbf("STRING") -- set type
		AddTextComponentString(showText) -- sets the text
		N_0xbd12f8228410d9b4(showType) -- show promt (types = 3)
		Citizen.Wait(showTime) -- show time
		N_0x10d373323e5b9c0d() -- remove promt
	end)
end

function StopJob(jobid)
	if jobid == 1 then
		if DoesEntityExist(jobs.peds[1]) then
			local pedb = GetBlipFromEntity(jobs.peds[1])
			if pedb ~= nil and DoesBlipExist(pedb) then
				SetBlipSprite(pedb, 2)
				SetBlipDisplay(pedb, 3)
			end
			ClearPedTasksImmediately(jobs.peds[1])
			if DoesEntityExist(jobs.cars[1]) and IsVehicleDriveable(jobs.cars[1], 0) then
				if IsPedSittingInVehicle(jobs.peds[1], jobs.cars[1]) then
					TaskLeaveVehicle(jobs.peds[1], jobs.cars[1], 0)
				end
			end
			Citizen.InvokeNative(0xB736A491E64A32CF,Citizen.PointerValueIntInitialized(jobs.peds[1]))
		end
		if jobs.blip[1] ~= nil and DoesBlipExist(jobs.blip[1]) then
			Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(jobs.blip[1]))
			jobs.blip[1] = nil
		end
		onJob = 0
		jobs.cars[1] = nil
		jobs.peds[1] = nil
		jobs.flag[1] = nil
		jobs.flag[2] = nil
	end
end

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if onJob == 0 then
			if IsControlJustPressed(1, 214) or IsDisabledControlJustPressed(1, 214) then -- DEL
				if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
					if IsVehicleModel(GetVehiclePedIsUsing(GetPlayerPed(-1)), GetHashKey("taxi", _r)) or GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1))) == 'LS118711' then
						StartJob(1)
					end
				end
			end
		elseif onJob == 1 then
			if DoesEntityExist(jobs.cars[1]) and IsVehicleDriveable(jobs.cars[1], 0) then
				if IsPedSittingInVehicle(GetPlayerPed(-1), jobs.cars[1]) then
					if DoesEntityExist(jobs.peds[1]) then
						if IsPedFatallyInjured(jobs.peds[1]) then
							Citizen.InvokeNative(0xB736A491E64A32CF,Citizen.PointerValueIntInitialized(jobs.peds[1]))
							local pedb = GetBlipFromEntity(jobs.peds[1])
							if pedb ~= nil and DoesBlipExist(pedb) then
								SetBlipSprite(pedb, 2)
								SetBlipDisplay(pedb, 3)
							end
							jobs.peds[1] = nil
							jobs.flag[1] = 0
							jobs.flag[2] = 59+GetRandomIntInRange(1, 61)
							if jobs.blip[1] ~= nil and DoesBlipExist(jobs.blip[1]) then
								Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(jobs.blip[1]))
								jobs.blip[1] = nil
							end
							drawTxt("~w~Your client is ~r~dead~w~. Find another one.", 5000)
						else
							if jobs.flag[1] == 1 and jobs.flag[2] > 0 then
								Wait(1000)
								jobs.flag[2] = jobs.flag[2]-1
								if jobs.flag[2] == 0 then
									local pedb = GetBlipFromEntity(jobs.peds[1])
									if pedb ~= nil and DoesBlipExist(pedb) then
										SetBlipSprite(pedb, 2)
										SetBlipDisplay(pedb, 3)
									end
									ClearPedTasksImmediately(jobs.peds[1])
									Citizen.InvokeNative(0xB736A491E64A32CF,Citizen.PointerValueIntInitialized(jobs.peds[1]))
									jobs.peds[1] = nil
									drawTxt("~w~Client got ~r~tired of waiting~w~. Find another one.", 5000)
									jobs.flag[1] = 0
									jobs.flag[2] = 59+GetRandomIntInRange(1, 61)
								else
									if IsPedSittingInVehicle(GetPlayerPed(-1), jobs.cars[1]) then
										if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), GetEntityCoords(jobs.peds[1]), true) < 25 then
											local offs = GetOffsetFromEntityInWorldCoords(GetVehiclePedIsUsing(GetPlayerPed(-1)), 1.5, 0.0, 0.0)
											local offs2 = GetOffsetFromEntityInWorldCoords(GetVehiclePedIsUsing(GetPlayerPed(-1)), -1.5, 0.0, 0.0)
											if GetDistanceBetweenCoords(offs['x'], offs['y'], offs['z'], GetEntityCoords(jobs.peds[1]), true) < GetDistanceBetweenCoords(offs2['x'], offs2['y'], offs2['z'], GetEntityCoords(jobs.peds[1]), true) then
												TaskEnterVehicle(jobs.peds[1], jobs.cars[1], -1, 2, 2.0001, 1)
											else
												TaskEnterVehicle(jobs.peds[1], jobs.cars[1], -1, 1, 2.0001, 1)
											end
											jobs.flag[1] = 2
											jobs.flag[2] = 30
										end
									end
								end
							end
							if jobs.flag[1] == 2 and jobs.flag[2] > 0 then
								Wait(1000)
								jobs.flag[2] = jobs.flag[2]-1
								if jobs.flag[2] == 0 then
									local pedb = GetBlipFromEntity(jobs.peds[1])
									if pedb ~= nil and DoesBlipExist(pedb) then
										SetBlipSprite(pedb, 2)
										SetBlipDisplay(pedb, 3)
									end
									ClearPedTasksImmediately(jobs.peds[1])
									Citizen.InvokeNative(0xB736A491E64A32CF,Citizen.PointerValueIntInitialized(jobs.peds[1]))
									jobs.peds[1] = nil
									drawTxt("~r~The Client is not going with you~w~.~w~ Find anotherone.", 5000)
									jobs.flag[1] = 0
									jobs.flag[2] = 59+GetRandomIntInRange(1, 61)
								else
									if IsPedSittingInVehicle(jobs.peds[1], jobs.cars[1]) then
										local pedb = GetBlipFromEntity(jobs.peds[1])
										if pedb ~= nil and DoesBlipExist(pedb) then
											SetBlipSprite(pedb, 2)
											SetBlipDisplay(pedb, 3)
										end
										jobs.flag[1] = 3
										jobs.flag[2] = GetRandomIntInRange(1, 62)
										local street = table.pack(GetStreetNameAtCoord(jobs.coords.cx[jobs.flag[2]],jobs.coords.cy[jobs.flag[2]],jobs.coords.cz[jobs.flag[2]]))
										if street[2] ~= 0 and street[2] ~= nil then
											local streetname = string.format("~g~Take me to %s, nearby %s", GetStreetNameFromHashKey(street[1]),GetStreetNameFromHashKey(street[2]))
											drawTxt(streetname, 5000)
										else
											local streetname = string.format("~g~Take me to %s", GetStreetNameFromHashKey(street[1]))
											drawTxt(streetname, 5000)
										end
										jobs.blip[1] = AddBlipForCoord(jobs.coords.cx[jobs.flag[2]],jobs.coords.cy[jobs.flag[2]],jobs.coords.cz[jobs.flag[2]])
										local cx, cy, cz = table.unpack(GetEntityCoords(PlayerPedId(), true))
										jobpay = CalculateTravelDistanceBetweenPoints(cx, cy, cz, jobs.coords.cx[jobs.flag[2]],jobs.coords.cy[jobs.flag[2]],jobs.coords.cz[jobs.flag[2]])/2/4
										AddTextComponentString(GetStreetNameFromHashKey(street[1]))
										N_0x80ead8e2e1d5d52e(jobs.blip[1])
										SetBlipRoute(jobs.blip[1], 1)
									end
								end
							end
							if jobs.flag[1] == 3 then
								local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
								local speed = math.floor(GetEntitySpeed(vehicle) * 2.236936)
								local speeding = false
								if speed > 100 then
								 exports['NRP-notify']:DoHudText('inform',  "You Are Going To Fast!, Slow Down Or The Client Will Not Pay For The Ride")
								 Wait(30000)
								 speeding = true
								end
								if speed > 100 and speeding then
								 exports['NRP-notify']:DoHudText('inform',  "The Client Has Left The Vehicle Because You Where Speeding, Find Another")
								 ClearPedTasksImmediately(jobs.peds[1])
								 Citizen.InvokeNative(0xB736A491E64A32CF,Citizen.PointerValueIntInitialized(jobs.peds[1]))
								 jobs.peds[1] = nil
								 speeding = false
								end
								if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), jobs.coords.cx[jobs.flag[2]],jobs.coords.cy[jobs.flag[2]],jobs.coords.cz[jobs.flag[2]], true) > 4.0001 then
									DrawMarker(3, jobs.coords.cx[jobs.flag[2]],jobs.coords.cy[jobs.flag[2]],jobs.coords.cz[jobs.flag[2]]+1.0001, 0, 0, 0, 0, 0, 0, 4.0, 4.0, 2.0, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
								else
									if jobs.blip[1] ~= nil and DoesBlipExist(jobs.blip[1]) then
										Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(jobs.blip[1]))
										jobs.blip[1] = nil
									end
									ClearPedTasksImmediately(jobs.peds[1])
									TaskLeaveVehicle(jobs.peds[1], jobs.cars[1], 0)
									Citizen.InvokeNative(0xB736A491E64A32CF,Citizen.PointerValueIntInitialized(jobs.peds[1]))
									jobs.peds[1] = nil
									Wait(5000)
									drawTxt("~g~You have delivered the client!", 5000)
									jobpay = math.random(430, 840)
									TriggerServerEvent('jobs:paytheplayer', jobpay, 'Taxi: Local Dropoff')
									speeding = false
									Wait(8000)
									drawTxt("~w~Drive around and look for ~h~~g~passengers~w~.", 10000)
									jobs.flag[1] = 0
									jobs.flag[2] = 59+GetRandomIntInRange(1, 61)
								end
							end
						end
					else
						if jobs.flag[1] > 0 then
							jobs.flag[1] = 0
							jobs.flag[2] = 59+GetRandomIntInRange(1, 61)
							drawTxt("~w~Drive around and look for ~h~~g~passengers~w~.", 10000)
							if jobs.blip[1] ~= nil and DoesBlipExist(jobs.blip[1]) then
								Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(jobs.blip[1]))
								jobs.blip[1] = nil
							end
						end
						if jobs.flag[1] == 0 and jobs.flag[2] > 0 then
							Wait(1000)
							jobs.flag[2] = jobs.flag[2]-1
							if jobs.flag[2] == 0 then
								local pos = GetEntityCoords(GetPlayerPed(-1))
								local rped = GetRandomPedAtCoord(pos['x'], pos['y'], pos['z'], 35.001, 35.001, 35.001, 6, _r)
								if DoesEntityExist(rped) then
									jobs.peds[1] = rped
									jobs.flag[1] = 1
									jobs.flag[2] = 19+GetRandomIntInRange(1, 21)
									ClearPedTasksImmediately(jobs.peds[1])
									SetBlockingOfNonTemporaryEvents(jobs.peds[1], 1)
									TaskStandStill(jobs.peds[1], 1000*jobs.flag[2])
									drawTxt("~g~The client is waiting for you.~w~ Drive nearby", 5000)
									local lblip = AddBlipForEntity(jobs.peds[1])
									SetBlipAsFriendly(lblip, 1)
									SetBlipColour(lblip, 2)
									SetBlipCategory(lblip, 3)
								else
									jobs.flag[1] = 0
									jobs.flag[2] = 59+GetRandomIntInRange(1, 61)
									drawTxt("~w~Drive around and look for ~h~~g~clients~w~.", 10000)
								end
							end
						end
					end
				else
					if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), GetEntityCoords(jobs.cars[1]), true) > 30.0001 then
						StopJob(1)
					else
						drawTxt("~w~Get back in your car to continue. Or go away to stop working.", 1)
						speeding = false
					end
				end
			else
				StopJob(1)
				drawTxt("~w~The taxi is ~h~~r~destroyed~w~.", 5000)
				speeding = false
			end
		end
	end
end)

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(0)
  local coords = GetEntityCoords(GetPlayerPed(-1))
  if(GetDistanceBetweenCoords(coords, 895.376, -179.315, 73.710, true) < 50) and DecorGetInt(GetPlayerPed(-1), "Job") == 4 then
   DrawMarker(27, 895.376, -179.315, 73.710, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 2.0, 252, 252, 58, 200, 0, 0, 2, 0, 0, 0, 0)
   if(GetDistanceBetweenCoords(coords, 895.376, -179.315, 73.710, true) < 1.3) then
   	drawTxt('~m~Press ~g~E~m~ To Get Taxi')
    if IsControlJustReleased(0, 38) then
	 SpawnJobVehicle('taxi', 904.363, -183.962, 73.993)
	 Wait(3000)
	 exports['NRP-notify']:DoHudText('inform', "For Local Taxi Missions Press <font color='yellow'>Delete<font color='white'> To Start")
	 Wait(3000)
	 exports['NRP-notify']:DoHudText('inform', "For Player Taxi Missions Press <font color='yellow'>K<font color='white'> To Start Meter And <font color='yellow'>L<font color='white'> To Reset")
    end
   end
  end
 end
end)

Citizen.CreateThread(function()
 WarMenu.CreateLongMenu('taxi_missions', 'Missions')
 while true do 
  Wait(2)
  if DecorGetInt(GetPlayerPed(-1), "Job") == 4 then
   if IsControlJustPressed(0, 167) or IsDisabledControlPressed(0, 167) then WarMenu.OpenMenu('taxi_missions') end
   if WarMenu.IsMenuOpened('taxi_missions') then
    for i,v in pairs(mission_list) do
     if v.name ~= "Finish the mission" then
      if WarMenu.Button(v.name) then
       v.f(v.mission)
	   exports['NRP-notify']:DoHudText('inform', 'Call Information: '..v.info)
      end
     else
      if WarMenu.Button(v.name) then
       v.f()
      end
     end 
    end
   end
    WarMenu.Display()
  end
 end
end)

----------------------------------------------------------------------------------------------------------
---------------------------- New Mission System ----------------------------------------------------------
----------------------------------------------------------------------------------------------------------
local currentMissionBlip = nil 
local availableMissions = {}
local currentMissions = nil
local MissionInformation = '~g~NO CALLS WAITING'
local TaxiCallStatus = 0
local activeTaxis = 0
local availableTaxis = 0

RegisterNetEvent("taxi:notifyallTaxis")
AddEventHandler("taxi:notifyallTaxis",function(message)
  if DecorGetInt(GetPlayerPed(-1), "Job") == 4 then
    TriggerEvent("pNotify:SendNotification", {text= message})
  end
end)

RegisterNetEvent("taxi:notifyClient")
AddEventHandler("taxi:notifyClient",function(message)
  TriggerEvent("pNotify:SendNotification", {text= message})
end)

function acceptMissiontaxi(data) 
    TriggerServerEvent('taxi:acceptMission', data.id)
end

function finishCurrentMissiontaxi()
    if currentMissions ~= nil then
        TriggerServerEvent('taxi:finishMission', currentMissions.id)
    end
    currentMissions = nil
    if currentMissionBlip ~= nil then
        RemoveBlip(currentMissionBlip)
    end
  WarMenu.OpenMenu('taxi_missions')
end

function updateMissionMenu() 
    local cmissions = {}
    for k,v in pairs(availableMissions) do
        Citizen.Trace('==>' .. k )
    end
    for _,m in pairs(availableMissions) do 
        local data = {
            name = '' .. m.name,
            mission = m,
            info = m.type,
            f = acceptMissiontaxi
        }
        if #m.acceptBy ~= 0 then
            data.name = data.name .. ' (' .. #m.acceptBy ..' Unit)'
        end
        table.insert(cmissions, data)
    end

    if currentMissions ~= nil then
        table.insert(cmissions, {name = 'Finish the mission', f = finishCurrentMissiontaxi})
    end
    mission_list = cmissions
    if curMenu ~= nil then
        if curMenu == "missions_menu" then
            WarMenu.OpenMenu('taxi_missions')
        end
    end
end

function calltaxi(type)
    local callerPos = GetEntityCoords(GetPlayerPed(-1))
    TriggerServerEvent('taxi:Call', callerPos.x, callerPos.y, callerPos.z, type)
end

RegisterNetEvent('taxi:acceptMission')
AddEventHandler('taxi:acceptMission',function(mission)
    currentMissions = mission
    SetNewWaypoint(mission.pos[1], mission.pos[2])
    currentMissionBlip = AddBlipForCoord(mission.pos[1], mission.pos[2], mission.pos[3])
    SetBlipSprite(currentMissionBlip, 58)
    SetBlipColour(currentMissionBlip, 5)
    SetBlipAsShortRange(currentMissionBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Mission in progress')
    EndTextCommandSetBlipName(currentMissionBlip)
    SetBlipAsMissionCreatorBlip(currentMissionBlip, true)
end)

RegisterNetEvent('taxi:cancelMission')
AddEventHandler('taxi:cancelMission', function ()
    currentMissions = nil
    if currentMissionBlip ~= nil then
        RemoveBlip(currentMissionBlip)
    end
    if curMenu ~= nil then
        if curMenu == "missions_menu" then
          WarMenu.OpenMenu('taxi_missions')
        end
    end
end)

RegisterNetEvent('taxi:changeMission')
AddEventHandler('taxi:changeMission', function (missions)
    availableMissions = missions
    local MissionsOnHold = 0
    for _,m in pairs(availableMissions) do
        if #m.acceptBy == 0 then
            MissionsOnHold = MissionsOnHold + 1
        end
    end
    if MissionsOnHold == 0 then 
        MissionInformation = '~g~No Call Waiting'
    else
        MissionInformation = '~g~'..MissionsOnHold..' ~w~Call waiting'
    end  
    updateMissionMenu()
end)

RegisterNetEvent('taxi:calltaxi')
AddEventHandler('taxi:calltaxi',function(data)
    calltaxi(data.type)
end)

RegisterNetEvent('Taxi:callTaxiCustom')
AddEventHandler('Taxi:callTaxiCustom',function()
    local reason = openTextInput()
    if reason ~= nil and reason ~= '' then
        calltaxi(reason)
    end
end)

function openTextInput()
    DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 200)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        return GetOnscreenKeyboardResult()
    end
    return nil
end

RegisterNetEvent('taxi:callStatus')
AddEventHandler('taxi:callStatus',function(status)
    TaxiCallStatus = status
end)

RegisterNetEvent('taxi:updateactiveTaxis')
AddEventHandler('taxi:updateactiveTaxis',function(activeCount, availableCount)
    activeTaxis = activeCount
    availableTaxis = availableCount
end)

RegisterNetEvent('Taxi:cancelCall')
AddEventHandler('Taxi:cancelCall',function(data)
    TriggerServerEvent('taxi:cancelCall')
end)


TriggerServerEvent('taxi:getactiveTaxis') -- Initilized on startup


RegisterNetEvent('Taxi:callTaxiCustom')
AddEventHandler('Taxi:callTaxiCustom',function()
    local reason = openTextInput()
    if reason ~= nil and reason ~= '' then
        calltaxi(reason)
    end
end)
function openTextInput()
    DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 200)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        return GetOnscreenKeyboardResult()
    end
    return nil
end
 
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if DecorGetInt(GetPlayerPed(-1), "Job") == 4 then
            if currentMissions == nil then
                if currentMissionBlip ~= nil then
                    RemoveBlip(currentMissionBlip)
                end
            end
        end
    end
end)
  
  