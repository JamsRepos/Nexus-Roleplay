local cinemaLocations = {
  { ['name'] = "Downtown", ['x'] = 394.108, ['y'] = -711.677, ['z'] = 28.294},
  { ['name'] = "Morningwood", ['x'] = -1423.954, ['y'] = -213.62, ['z'] = 46.5},
  { ['name'] = "Vinewood",  ['x'] = 284.485, ['y'] = 200.504, ['z'] = 103.382}
}

local entrance = {}
local MovieState = false

Citizen.CreateThread(function()
 while true do
  Wait(5)
  for k,v in ipairs(cinemaLocations) do
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 50) then
    DrawMarker(27, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, 1.0,1.0,1.0, 100,120,255, 200, 0, 0, 2, 0, 0, 0, 0)
  	if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 1.2) then
     drawTxt('~m~Press ~g~E~m~ To Buy A Ticket\n~w~[~g~$10~w~]')
   	 if IsControlJustPressed(0, 38) then
  	  TriggerServerEvent("cinema:pay", 10)
  	  entrance = {x = v.x, y = v.y, z = v.z}
     end
    end
   end
  end 

  if MovieState and IsControlJustPressed(0, 202) then
   DoScreenFadeOut(1000)
   Citizen.Wait(500)
   SetEntityCoords(PlayerPedId(), entrance.x, entrance.y, entrance.z)
   FreezeEntityPosition(PlayerPedId(), false)
   SetEntityVisible(GetPlayerPed(-1), true)
   SetFollowPedCamViewMode(GetRandomIntInRange(1, 3))
   DoScreenFadeIn(800)
   DeconstructMovie()
   MovieState = false
  end
 end
end)

RegisterNetEvent("cinema:cinemaPayed")
AddEventHandler("cinema:cinemaPayed", function()
	DoScreenFadeOut(1000)
	Citizen.Wait(500)
	local playerPed = PlayerPedId()
	SetEntityCoords(playerPed, 320.217, 263.81, 81.974, true, true, true, true)
	SetEntityHeading(playerPed, 180.475)
	TaskLookAtCoord(playerPed, 319.259, 251.827, 85.648, -1, 2048, 3)
	SetPedKeepTask(playerPed, true)
	FreezeEntityPosition(playerPed, true)
	SetEntityVisible(playerPed, false)
	DoScreenFadeIn(800)
	SetupMovie()
end)

function SetupMovie()
	cinema = GetInteriorAtCoords(320.217, 263.81, 82.974)
	LoadInterior(cinema)	
	cin_screen = GetHashKey("v_ilev_cin_screen")

	if not DoesEntityExist(tv) then
		tv = CreateObjectNoOffset(cin_screen, 320.1257, 248.6608, 86.56934, 1, true, false)
		SetEntityHeading(tv, 179.99998474121)
	else 
		tv = GetClosestObjectOfType(319.884, 262.103, 82.917, 20.475, cin_screen, 0, 0, 0)
	end

	RegisterNamedRendertarget("cinscreen", 0)	
	while not IsNamedRendertargetRegistered("cinscreen") do
	    Wait(0)    
	end

	LinkNamedRendertarget(cin_screen)
	while not IsNamedRendertargetLinked(cin_screen) do	    
	    Wait(0)
	end

	rendertargetid = GetNamedRendertargetRenderId("cinscreen")
	if IsNamedRendertargetLinked(cin_screen) and IsNamedRendertargetRegistered("cinscreen") then
	    Citizen.InvokeNative(0x9DD5A62390C3B735, 2, "PL_STD_CNT", 0)
	    SetTvVolume(100)
	    SetTvChannel(2)
	    
	    EnableMovieSubtitles(true)
	end

	CinemaTip = GetGameTimer()

	if MovieState == false then
		MovieState = true
		TriggerEvent("cinema:StartCinemaMovie")
	end
end

function DeconstructMovie()
	local obj = GetClosestObjectOfType(319.884, 262.103, 82.917, 20.475, cin_screen, 0, 0, 0)
	cin_screen = GetHashKey("v_ilev_cin_screen")	
	SetTvChannel(-1)  
	ReleaseNamedRendertarget(GetHashKey("cinscreen"))
	SetTextRenderId(GetDefaultScriptRendertargetRenderId())
	SetEntityAsMissionEntity(obj,true,false)
	DeleteObject(obj)
end

local function StartMovie()
	SetTextRenderId(rendertargetid)
	SetScreenDrawPosition(0, 0)
	Citizen.InvokeNative(0x67A346B3CDB15CA5, 100.0)
	Citizen.InvokeNative(0x61BB1D9B3A95D802, 4)
	Citizen.InvokeNative(0xC6372ECD45D73BCD, true)
	DrawTvChannel(0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
	ScreenDrawPositionEnd()
	SetTextRenderId(GetDefaultScriptRendertargetRenderId())
end

RegisterNetEvent("cinema:StartCinemaMovie")
AddEventHandler("cinema:StartCinemaMovie", function()
	Citizen.CreateThread(function()
		while(true) do
			Wait(0)
			if MovieState then
				StartMovie()

				DisableControlAction(0, 29, true)
				DisableControlAction(0, 32, true)
				DisableControlAction(0, 33, true)

				DisableControlAction(0, 34, true)
				DisableControlAction(0, 35, true)

				SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)
				HideHudAndRadarThisFrame()				
			end
		end
	end)
 end)

function drawTxt(text)
  SetTextFont(0)
  SetTextProportional(0)
  SetTextScale(0.32, 0.32)
  SetTextColour(0, 255, 255, 255)
  SetTextDropShadow(0, 0, 0, 0, 255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextCentre(1)
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(0.5, 0.93)
end
