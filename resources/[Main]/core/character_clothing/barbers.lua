local test = {}

Citizen.CreateThread(function()
 WarMenu.CreateLongMenu('barbershop_menu', 'Barbers')
 local hairID = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,'Bald'}
 local haircolourID = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,35,36,37,38,39,40,41,42,43,44,45}
 local haircolour2ID = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,35,36,37,38,39,40,41,42,43,44,45}
 local eyebrows1 = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,34,'None'}
 local eyebrowscolour = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,34}
 local beard1ID = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,'None'}
 local beard2ID = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,34,35,36,37,38,39,40,41,42,43,44,45}
 local selectedItemIndex4 = 1
 local currentItemIndex4 = 1
 local selectedItemIndex5 = 1
 local currentItemIndex5 = 1
 local selectedItemIndex6 = 1
 local currentItemIndex6 =1
 local selectedItemIndex7 = 1
 local currentItemIndex7 =1
 local selectedItemIndex9 = 1
 local currentItemIndex9 = 1
 local selectedItemIndex10 = 1
 local currentItemIndex10 = 1
 local selectedItemIndex11 = 1
 local currentItemIndex11 =1
 while true do
  Citizen.Wait(0) 
  if WarMenu.IsMenuOpened('barbershop_menu') then
   DisableControlAction(0, 177, true)
   if WarMenu.ComboBox('Hair', hairID, currentItemIndex4, selectedItemIndex4, function(currentIndex4, selectedIndex4)
     currentItemIndex4 = currentIndex4
     selectedItemIndex4 = currentItemIndex4
     if currentItemIndex4 == 46 then SetPedComponentVariation(GetPlayerPed(-1), 2, 0, 0, 1) else SetPedComponentVariation(GetPlayerPed(-1), 2, tonumber(currentItemIndex4), 0, 1) end
    end) then
   elseif WarMenu.ComboBox('Hair Colour', haircolourID, currentItemIndex5, selectedItemIndex5, function(currentIndex5, selectedIndex5)
     currentItemIndex5 = currentIndex5
     selectedItemIndex5 = currentItemIndex5
    end) then
   elseif WarMenu.ComboBox('Hair Colour 2', haircolour2ID, currentItemIndex6, selectedItemIndex6, function(currentIndex6, selectedIndex6)
     currentItemIndex6 = currentIndex6
     selectedItemIndex6 = currentItemIndex6
     SetPedHairColor(GetPlayerPed(-1), tonumber(currentItemIndex5), tonumber(currentItemIndex6))
    end) then
   elseif WarMenu.ComboBox('Eyebrows', eyebrows1, currentItemIndex7, selectedItemIndex7, function(currentIndex7, selectedIndex7)
     currentItemIndex7 = currentIndex7
     selectedItemIndex7 = currentItemIndex7
     if currentItemIndex7 == 35 then SetPedHeadOverlay(GetPlayerPed(-1), 2, currentItemIndex7, 0.0) else SetPedHeadOverlay(GetPlayerPed(-1), 2, currentItemIndex7, 10.0) end
    end) then
   elseif WarMenu.ComboBox('Eyebrow Colour', eyebrowscolour, currentItemIndex9, selectedItemIndex9, function(currentIndex9, selectedIndex9)
     currentItemIndex9 = currentIndex9
     selectedItemIndex9 = currentItemIndex9
     SetPedHeadOverlayColor(GetPlayerPed(-1), 2, 1, currentItemIndex9, currentItemIndex9)
    end) then
   elseif WarMenu.ComboBox('Beard', beard1ID, currentItemIndex10, selectedItemIndex10, function(currentIndex10, selectedIndex10)
     currentItemIndex10 = currentIndex10
     selectedItemIndex10 = currentItemIndex10
     SetPedHeadOverlay(GetPlayerPed(-1), 1, selectedItemIndex10, 10.0)
    end) then
   elseif WarMenu.ComboBox('Beard Colour', beard2ID, currentItemIndex11, selectedItemIndex11, function(currentIndex11, selectedIndex11)
     currentItemIndex11 = currentIndex11
     selectedItemIndex11 = currentItemIndex11
     SetPedHeadOverlayColor(GetPlayerPed(-1), 1, 1, currentItemIndex11, currentItemIndex11)
    end) then
   elseif WarMenu.Button('Save') then
   	test.hair = currentItemIndex4
   	test.haircolour = currentItemIndex5
   	test.haircolour2 = currentItemIndex6
   	test.eyebrow = currentItemIndex7
   	test.eyebrowcolour = currentItemIndex9
   	test.beard = currentItemIndex10
   	test.beardcolour = currentItemIndex11
   	TriggerServerEvent('barber:save', json.encode(test))
   	WarMenu.CloseMenu('barbershop_menu')
   elseif WarMenu.Button('Cancel') then
   	WarMenu.CloseMenu('barbershop_menu')
   	loadskin()
   end
   WarMenu.Display()
  end
 end
end)

Citizen.CreateThread(function()
 WarMenu.CreateLongMenu('beauty_menu', 'Salon')
 local hairID = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45}
 local haircolourID = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,35,36,37,38,39,40,41,42,43,44,45}
 local haircolour2ID = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,35,36,37,38,39,40,41,42,43,44,45}
 local eyebrows1 = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,34,'None'}
 local eyebrowscolour = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,34}
 local lipstickid = {'Yes', 'No'}
 local beard2ID = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55}
 local selectedItemIndex4 = 1
 local currentItemIndex4 = 1
 local selectedItemIndex5 = 1
 local currentItemIndex5 = 1
 local selectedItemIndex6 = 1
 local currentItemIndex6 =1
 local selectedItemIndex7 = 1
 local currentItemIndex7 =1
 local selectedItemIndex9 = 1
 local currentItemIndex9 = 1
 local selectedItemIndex10 = 1
 local currentItemIndex10 = 1
 local selectedItemIndex11 = 1
 local currentItemIndex11 =1
 local selectedItemIndex8 = 1
 local currentItemIndex8 = 1
 local selectedItemIndex12 = 1
 local currentItemIndex12 = 1
 while true do
  Citizen.Wait(0) 
  if WarMenu.IsMenuOpened('beauty_menu') then
   DisableControlAction(0, 177, true)
   if WarMenu.ComboBox('Hair', hairID, currentItemIndex4, selectedItemIndex4, function(currentIndex4, selectedIndex4)
     currentItemIndex4 = currentIndex4
     selectedItemIndex4 = currentItemIndex4
     SetPedComponentVariation(GetPlayerPed(-1), 2, tonumber(currentItemIndex4), 0, 1)
    end) then
   elseif WarMenu.ComboBox('Hair Colour', haircolourID, currentItemIndex5, selectedItemIndex5, function(currentIndex5, selectedIndex5)
     currentItemIndex5 = currentIndex5
     selectedItemIndex5 = currentItemIndex5
    end) then
   elseif WarMenu.ComboBox('Hair Colour 2', haircolour2ID, currentItemIndex6, selectedItemIndex6, function(currentIndex6, selectedIndex6)
     currentItemIndex6 = currentIndex6
     selectedItemIndex6 = currentItemIndex6
     SetPedHairColor(GetPlayerPed(-1), tonumber(currentItemIndex5), tonumber(currentItemIndex6))
    end) then
   elseif WarMenu.ComboBox('Eyebrows', eyebrows1, currentItemIndex7, selectedItemIndex7, function(currentIndex7, selectedIndex7)
     currentItemIndex7 = currentIndex7
     selectedItemIndex7 = currentItemIndex7
     if currentItemIndex7 == 35 then SetPedHeadOverlay(GetPlayerPed(-1), 2, currentItemIndex7, 0.0) else SetPedHeadOverlay(GetPlayerPed(-1), 2, currentItemIndex7, 10.0) end
    end) then
   elseif currentItemIndex7 ~= 34 and WarMenu.ComboBox('Eyebrow Colour', eyebrowscolour, currentItemIndex9, selectedItemIndex9, function(currentIndex9, selectedIndex9)
     currentItemIndex9 = currentIndex9
     selectedItemIndex9 = currentItemIndex9
     SetPedHeadOverlayColor(GetPlayerPed(-1), 2, 1, currentItemIndex9, currentItemIndex9)
    end) then
   elseif WarMenu.ComboBox('Lipstick', lipstickid, currentItemIndex10, selectedItemIndex10, function(currentIndex10, selectedIndex10)
     currentItemIndex10 = currentIndex10
     selectedItemIndex10 = currentItemIndex10
     if currentItemIndex10 == 2 then SetPedHeadOverlay(GetPlayerPed(-1), 8, currentIndex10, 0.0) else SetPedHeadOverlay(GetPlayerPed(-1), 8, currentIndex10, 5.0) end
    end) then
   elseif currentItemIndex10 == 1 and WarMenu.ComboBox('Lipstick Colour', beard2ID, currentItemIndex11, selectedItemIndex11, function(currentIndex11, selectedIndex11)
     currentItemIndex11 = currentIndex11
     selectedItemIndex11 = currentItemIndex11
     SetPedHeadOverlayColor(GetPlayerPed(-1), 8, 1, currentItemIndex11, currentItemIndex11)
    end) then
   elseif WarMenu.Button('Save') then
    test.hair = currentItemIndex4
    test.haircolour = currentItemIndex5
    test.haircolour2 = currentItemIndex6
    test.eyebrow = currentItemIndex7
    test.eyebrowcolour = currentItemIndex9
    test.lipstick = currentItemIndex10
    test.lipstickcolour = currentItemIndex11
    TriggerServerEvent('barber:save', json.encode(test))
    WarMenu.CloseMenu('barbershop_menu')
   elseif WarMenu.Button('Cancel') then
    WarMenu.CloseMenu('barbershop_menu')
    loadskin()
   end
   WarMenu.Display()
  end
 end
end)

-- End Of Barber Stuff
RegisterNetEvent('barbers:getcharvairibles')
AddEventHandler('barbers:getcharvairibles', function(skins)
 test = skins
end)


local barbershops = {
  {x = -814.308,  y = -183.823,  z = 36.568},
  {x = 136.826,   y = -1708.373, z = 28.291},
  {x = -1282.604, y = -1116.757, z = 5.990},
  {x = 1931.513,  y = 3729.671,  z = 31.844},
  {x = 1212.840,  y = -472.921,  z = 65.208},
  {x = -32.885,   y = -152.319,  z = 56.076},
  {x = -278.077,  y = 6228.463,  z = 30.695}
}

local beauty = {
  {x = -814.308,  y = -183.823,  z = 36.568},
  {x = 136.826,   y = -1708.373, z = 28.291},
  {x = -1282.604, y = -1116.757, z = 5.990},
  {x = 1931.513,  y = 3729.671,  z = 31.844},
  {x = 1212.840,  y = -472.921,  z = 65.208},
  {x = -32.885,   y = -152.319,  z = 56.076},
  {x = -278.077,  y = 6228.463,  z = 30.695}
}

Citizen.CreateThread(function()
 while true do
  Wait(0)
  local coords = GetEntityCoords(GetPlayerPed(-1))
  if not(GetEntityModel(GetPlayerPed(-1)) == -1667301416) then
   for k,v in pairs(barbershops) do
    if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 50) then
     DrawMarker(27, v.x, v.y, v.z+0.05, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 66, 255, 255, 10, 0, 0, 2, 0, 0, 0, 0)
 	 if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 2) then 
	  drawTxt('~m~Press ~g~E~m~ To Access The Barbers')
	  if IsControlJustPressed(0, 38) then
 	   WarMenu.OpenMenu('barbershop_menu')
	  end
	 end
    end
   end
  else
   for k,v in pairs(beauty) do
    if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 50) then
     DrawMarker(27, v.x, v.y, v.z+0.05, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 255, 0, 250, 200, 0, 0, 2, 0, 0, 0, 0)
     if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 2) then 
      drawTxt('~m~Press ~g~E~m~ To Access The Beauty Salon')
      if IsControlJustPressed(0, 38) then
       WarMenu.OpenMenu('beauty_menu')
      end
     end
    end
   end
  end
 end
end)

Citizen.CreateThread(function()
	for k,v in ipairs(barbershops)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite (blip, 71)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.8)
		SetBlipColour (blip, 51)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Barber Shop")
		EndTextCommandSetBlipName(blip)
	end
end)

function loadskin()
 if test.sex == 1 then
  if test.hair ~= 46 then SetPedComponentVariation(GetPlayerPed(-1), 2, tonumber(test.hair), 0, 1) else SetPedComponentVariation(GetPlayerPed(-1), 2, 0, 0, 1) end
  SetPedHairColor(GetPlayerPed(-1), tonumber(test.haircolour), tonumber(test.haircolour2))
  if test.eyebrow == 35 then SetPedHeadOverlay(GetPlayerPed(-1), 2, test.eyebrow, 0.0) else SetPedHeadOverlay(GetPlayerPed(-1), 2, test.eyebrow, 10.0) end
  SetPedHeadOverlayColor(GetPlayerPed(-1), 2, 1, test.eyebrowcolour, test.eyebrowcolour)
  SetPedHeadOverlay(GetPlayerPed(-1), 1, test.beard, 10.0)
  SetPedHeadOverlayColor(GetPlayerPed(-1), 1, 1, test.beardcolour, test.beardcolour)
 else
  SetPedComponentVariation(GetPlayerPed(-1), 2, tonumber(test.hair), 0, 1)
  SetPedHairColor(GetPlayerPed(-1), tonumber(test.haircolour), tonumber(test.haircolour2))
  if test.eyebrow == 35 then SetPedHeadOverlay(GetPlayerPed(-1), 2, test.eyebrow, 0.0) else SetPedHeadOverlay(GetPlayerPed(-1), 2, test.eyebrow, 10.0) end
  SetPedHeadOverlayColor(GetPlayerPed(-1), 2, 1, test.eyebrowcolour, test.eyebrowcolour)
  if test.lipstick == 2 then SetPedHeadOverlay(GetPlayerPed(-1), 8, currentIndex10, 0.0) else SetPedHeadOverlay(GetPlayerPed(-1), 8, currentIndex10, 5.0) end
  SetPedHeadOverlayColor(GetPlayerPed(-1), 8, 1, test.lipstickcolour, test.lipstickcolour)
 end
end