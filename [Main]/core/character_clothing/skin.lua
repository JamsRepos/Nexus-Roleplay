local test = {}

Citizen.CreateThread(function()
 local sexID = {"Male","Female"}
 local skinID = {1,2,3,4,5,6,7,8,9}
 local hairID = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45}
 local haircolourID = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,35,36,37,38,39,40,41,42,43,44,45}
 local haircolour2ID = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,35,36,37,38,39,40,41,42,43,44,45}
 local eyebrows1 = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,34,'None'}
 local eyebrowscolour = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,34}
 local beard1ID = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,'None'}
 local beard2ID = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,34,35,36,37,38,39,40,41,42,43,44,45}
 local Age = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,'None'}
 local eyecolour = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}
 local chesthairid = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}
 local currentsex = 1
 local selectedsex = 1
 local currentface = 1
 local selectedface = 1
 local currentface2 = 1
 local selectedface2 = 1
 local currentItemIndex2 = 1
 local selectedItemIndex2 = 1
 local selectedItemIndex4 = 1
 local currentItemIndex4 = 1
 local selectedItemIndex5 = 1
 local currentItemIndex5 = 1
 local selectedItemIndex6 = 1
 local currentItemIndex6 = 1
 local selectedItemIndex7 = 1
 local currentItemIndex7 = 1
 local selectedItemIndex9 = 1
 local currentItemIndex9 = 1
 local selectedItemIndex10 = 1
 local currentItemIndex10 = 1
 local selectedItemIndex11 = 1
 local currentItemIndex11 = 1
 local selectedItemIndex12 = 1
 local currentItemIndex12 = 1
 local selectedItemIndex13 = 1
 local currentItemIndex13 = 1
 WarMenu.CreateLongMenu('first_customization', "Skin Creator")
 while true do
  Wait(5)
  if WarMenu.IsMenuOpened('first_customization') then
   DisableControlAction(0, 177, true)
   local ped = GetPlayerPed(-1)
   for i=0, 255, 1 do
    if i ~= PlayerId() then
     local otherPlayerPed = GetPlayerPed(i)
     SetEntityLocallyInvisible(otherPlayerPed)
     SetEntityNoCollisionEntity(ped, otherPlayerPed, true)
    end
   end
   if WarMenu.ComboBox('Sex', sexID, currentsex, selectedsex, function(currentsex1, selectedsex1)
     currentsex = currentsex1
     selectedsex = selectedsex1
     test.sex = selectedsex
    end) then
     if test.sex == 1 then male() else female() end
   elseif WarMenu.ComboBox('Mother', {"Hannah", "Izzy", "Jasmine", "Gisele", "Amelia", "Isabella", "Zoe", "Ava", "Camila", "Violet", "Sophia", "Evelyn", "Nicole", "Ashley", "Gracie", "Brianna", "Natalie", "Olivia", "Elizabeth", "Charlotte", "Emma", "Misty"}, motherface, selectedface, function(currentface1)
     motherface = currentface1
     selectedface =  currentface1
     if currentface1 == 1 then test.mother = 21 elseif currentface1 == 2 then test.mother = 22 elseif currentface1 == 3 then test.mother = 23 elseif currentface1 == 4 then test.mother = 24 elseif currentface1 == 5 then test.mother = 25 elseif currentface1 == 6 then test.mother = 26 elseif currentface1 == 7 then test.mother = 27 elseif currentface1 == 8 then test.mother = 28 elseif currentface1 == 9 then test.mother = 29 elseif currentface1 == 10 then test.mother = 30 elseif currentface1 == 11 then test.mother = 31 elseif currentface1 == 12 then test.mother = 32 elseif currentface1 == 13 then test.mother = 33 elseif currentface1 == 14 then test.mother = 34 elseif currentface1 == 15 then test.mother = 35 elseif currentface1 == 16 then test.mother = 36 elseif currentface1 == 17 then test.mother = 37 elseif currentface1 == 18 then test.mother = 38 elseif currentface1 == 19 then test.mother = 39 elseif currentface1 == 20 then test.mother = 40 elseif currentface1 == 21 then test.mother = 41 elseif currentface1 == 22 then test.mother = 45 end
    end) then
   elseif WarMenu.ComboBox('Father', {"William", "Daniel", "Joshua", "Noah", "Andrew", "Juan", "Alex", "Isaac", "Evan", "Ethan", "Vincent", "Angel", "Diego", "Adrian", "Keiran", "Michael", "Santiago", "Kevin", "Louis", "Samuel", "Anthony", "Claude", "Niko", "John"}, currentface2, selectedface2, function(currentface22)
     currentface2 = currentface22
     selectedface2 = currentface22
     if currentface2 == 1 then test.father = 4 elseif currentface2 == 2 then test.father = 1 elseif currentface2 == 3 then test.father = 2 elseif currentface2 == 4 then test.father = 3 elseif currentface2 == 5 then test.father = 0 elseif currentface2 == 6 then test.father = 5 elseif currentface2 == 7 then test.father = 6 elseif currentface2 == 8 then test.father = 7 elseif currentface2 == 9 then test.father = 8 elseif currentface2 == 10 then test.father = 9 elseif currentface2 == 11 then test.father = 10 elseif currentface2 == 12 then test.father = 11 elseif currentface2 == 13 then test.father = 12 elseif currentface2 == 14 then test.father = 13 elseif currentface2 == 15 then test.father = 14 elseif currentface2 == 16 then test.father = 15 elseif currentface2 == 17 then test.father = 16 elseif currentface2 == 18 then test.father = 17 elseif currentface2 == 19 then test.father = 18 elseif currentface2 == 20 then test.father = 19 elseif currentface2 == 21 then test.father = 20 elseif currentface2 == 22 then test.father = 42 elseif currentface2 == 23 then test.father = 43 elseif currentface2 == 24 then test.father = 44 end
    end) then
   elseif WarMenu.ComboBox('Skin Tone', skinID, currentItemIndex2, selectedItemIndex2, function(currentIndex2, selectedIndex2)
     currentItemIndex2 = currentIndex2
     selectedItemIndex2 = currentItemIndex2
     test.skin = currentIndex2
     SetPedHeadBlendData(GetPlayerPed(-1), test.mother,test.father,0, test.skin,test.skin, 0, 0.5, 0.5, 0.0, false)
    end) then
   elseif WarMenu.ComboBox('Hair', hairID, currentItemIndex4, selectedItemIndex4, function(currentIndex4, selectedIndex4)
     currentItemIndex4 = currentIndex4
     selectedItemIndex4 = currentItemIndex4
     test.hair = currentIndex4
     SetPedComponentVariation(GetPlayerPed(-1), 2, tonumber(test.hair), 0, 1)
    end) then
   elseif WarMenu.ComboBox('Hair Colour', haircolourID, currentItemIndex5, selectedItemIndex5, function(currentIndex5, selectedIndex5)
     currentItemIndex5 = currentIndex5
     selectedItemIndex5 = currentItemIndex5
     test.haircolour = currentIndex5
     SetPedHairColor(GetPlayerPed(-1), tonumber(test.haircolour), tonumber(test.haircolour2))
    end) then
   elseif WarMenu.ComboBox('Hair Colour 2', haircolour2ID, currentItemIndex6, selectedItemIndex6, function(currentIndex6, selectedIndex6)
     currentItemIndex6 = currentIndex6
     selectedItemIndex6 = currentItemIndex6
     test.haircolour2 = currentIndex6
     SetPedHairColor(GetPlayerPed(-1), tonumber(test.haircolour), tonumber(test.haircolour2))
    end) then
   elseif WarMenu.ComboBox('Eyebrows', eyebrows1, currentItemIndex7, selectedItemIndex7, function(currentIndex7, selectedIndex7)
     currentItemIndex7 = currentIndex7
     selectedItemIndex7 = currentItemIndex7
     test.eyebrow = currentIndex7
     if test.eyebrow == 35 then SetPedHeadOverlay(GetPlayerPed(-1), 2, test.eyebrow, 0.0) else SetPedHeadOverlay(GetPlayerPed(-1), 2, test.eyebrow, 10.0) end
    end) then
   elseif WarMenu.ComboBox('Eyebrow Colour', eyebrowscolour, currentItemIndex9, selectedItemIndex9, function(currentIndex9, selectedIndex9)
     currentItemIndex9 = currentIndex9
     selectedItemIndex9 = currentItemIndex9
     test.eyebrowcolour = currentIndex9
     SetPedHeadOverlayColor(GetPlayerPed(-1), 2, 1, test.eyebrowcolour, test.eyebrowcolour)
    end) then
   elseif test.sex == 1 and WarMenu.ComboBox('Beard', beard1ID, currentItemIndex10, selectedItemIndex10, function(currentIndex10, selectedIndex10)
     currentItemIndex10 = currentIndex10
     selectedItemIndex10 = currentItemIndex10
     test.beard = currentIndex10
     SetPedHeadOverlay(GetPlayerPed(-1), 1, test.beard, 10.0)
    end) then
   elseif test.sex == 1 and WarMenu.ComboBox('Beard Colour', beard2ID, currentItemIndex11, selectedItemIndex11, function(currentIndex11, selectedIndex11)
     currentItemIndex11 = currentIndex11
     selectedItemIndex11 = currentItemIndex11
     test.beardcolour = currentIndex11
     SetPedHeadOverlayColor(GetPlayerPed(-1), 1, 1, test.beardcolour, test.beardcolour)
    end) then
   elseif WarMenu.ComboBox('Ageing', Age, currentItemIndex12, selectedItemIndex12, function(currentIndex12, selectedIndex12)
     currentItemIndex12 = currentIndex12
     selectedItemIndex12 = currentItemIndex12
     test.ageing = currentIndex12
     if test.ageing > 14 then
      SetPedHeadOverlay(GetPlayerPed(-1), 3, 0, -0.0)
     else
      SetPedHeadOverlay(GetPlayerPed(-1), 3, test.ageing, 10.0)
     end
    end) then
   elseif WarMenu.ComboBox('Eye Colour', eyecolour, currentItemIndex13, selectedItemIndex13, function(currentIndex13, selectedIndex13)
     currentItemIndex13 = currentIndex13
     selectedItemIndex13 = currentItemIndex13
     test.contacts = currentIndex13
     SetPedEyeColor(GetPlayerPed(-1), test.contacts)
    end) then
   elseif WarMenu.Button('Confirm') then
    WarMenu.CloseMenu('first_customization')
    TriggerServerEvent('skin:save', test)
    FirstSpawn()
   end
   WarMenu.Display()
  end
 end 
end)


function male()
 sex = 1  
 local model = GetHashKey("mp_m_freemode_01")

 RequestModel(model)
  while not HasModelLoaded(model) do
  RequestModel(model)
 Citizen.Wait(0)
 end
 SetPlayerModel(PlayerId(), model)
 SetPedDefaultComponentVariation(GetPlayerPed(-1))
 SetPedComponentVariation(GetPlayerPed(-1),3,15,0,0)
 SetPedComponentVariation(GetPlayerPed(-1),4,21,0,0)
 SetPedComponentVariation(GetPlayerPed(-1),6,34,0,0)
 SetPedComponentVariation(GetPlayerPed(-1),8,15,0,0)
 SetPedComponentVariation(GetPlayerPed(-1),11,15,0,0)
end

function female()
 sex = 2
 local model = GetHashKey("mp_f_freemode_01")

 RequestModel(model)
  while not HasModelLoaded(model) do
  RequestModel(model)
 Citizen.Wait(0)
 end
 SetPlayerModel(PlayerId(), model)
 SetPedDefaultComponentVariation(GetPlayerPed(-1))
 SetPedComponentVariation(GetPlayerPed(-1),3,15,0,0)
 SetPedComponentVariation(GetPlayerPed(-1),4,15,0,0)
 SetPedComponentVariation(GetPlayerPed(-1),6,35,0,0)
 SetPedComponentVariation(GetPlayerPed(-1),8,2,0,0)
 SetPedComponentVariation(GetPlayerPed(-1),11,15,0,0)
end

-- Coords For Skin Creation 


RegisterNetEvent('skin:load')
AddEventHandler('skin:load', function(skin)
 if skin.sex == 1 then
  male()
  SetPedHeadBlendData(GetPlayerPed(-1), skin.mother,skin.father,0, skin.skin,skin.skin, 0, 0.5, 0.5, 0.0, false)
  SetPedComponentVariation(GetPlayerPed(-1), 2, tonumber(skin.hair), 0, 1)
  SetPedHairColor(GetPlayerPed(-1), tonumber(skin.haircolour), tonumber(skin.haircolour2))
  if skin.eyebrow == 35 then SetPedHeadOverlay(GetPlayerPed(-1), 2, skin.eyebrow, 0.0) else SetPedHeadOverlay(GetPlayerPed(-1), 2, skin.eyebrow, 10.0) end
  SetPedHeadOverlayColor(GetPlayerPed(-1), 2, 1, skin.eyebrowcolour, skin.eyebrowcolour)
  SetPedHeadOverlay(GetPlayerPed(-1), 1, skin.beard, 10.0)
  SetPedHeadOverlayColor(GetPlayerPed(-1), 1, 1, skin.beardcolour, skin.beardcolour)
  if skin.ageing > 14 then SetPedHeadOverlay(GetPlayerPed(-1), 3, skin.ageing, 0.0) else SetPedHeadOverlay(GetPlayerPed(-1), 3, skin.ageing, 10.0) end
  SetPedEyeColor(GetPlayerPed(-1), skin.contacts)
 else
  female()
  SetPedHeadBlendData(GetPlayerPed(-1), skin.mother,skin.father,0, skin.skin,skin.skin, 0, 0.5, 0.5, 0.0, false)
  SetPedComponentVariation(GetPlayerPed(-1), 2, tonumber(skin.hair), 0, 1)
  SetPedHairColor(GetPlayerPed(-1), tonumber(skin.haircolour), tonumber(skin.haircolour2))
  if skin.eyebrow == 35 then SetPedHeadOverlay(GetPlayerPed(-1), 2, skin.eyebrow, 0.0) else SetPedHeadOverlay(GetPlayerPed(-1), 2, skin.eyebrow, 10.0) end
  SetPedHeadOverlayColor(GetPlayerPed(-1), 2, 1, skin.eyebrowcolour, skin.eyebrowcolour)
  if skin.ageing > 14 then SetPedHeadOverlay(GetPlayerPed(-1), 3, skin.ageing, 0.0) else SetPedHeadOverlay(GetPlayerPed(-1), 3, skin.ageing, 10.0) end
  SetPedEyeColor(GetPlayerPed(-1), skin.contacts)
  if skin.lipstick == 2 then SetPedHeadOverlay(GetPlayerPed(-1), 8, skin.lipstick, 0.0) else SetPedHeadOverlay(GetPlayerPed(-1), 8, skin.lipstick, 5.0) end
  SetPedHeadOverlayColor(GetPlayerPed(-1), 8, 1, skin.lipstickcolour, skin.lipstickcolour)
 end
 test = skin
 Wait(100)
 TriggerServerEvent('clothes:firstload') -- -will need to add
 TriggerServerEvent('core:checkjob') -- -will need to add
end)

RegisterNetEvent('skin:noskin')
AddEventHandler('skin:noskin', function()
 male()
 Wait(100)
 local ped = GetPlayerPed(-1)
 TriggerEvent("core:stopSkyCamera")
 SetEntityCoords(ped, 402.65, -996.281, -100.100)
 SetEntityHeading(ped, 180.0)
 FreezeEntityPosition(ped, true)
 WarMenu.OpenMenu('first_customization')
 SwitchInPlayer(PlayerPedId()) 
end)

function FirstSpawn()
 FreezeEntityPosition(GetPlayerPed(-1), false)
 TriggerEvent("inventory:addQty", 104, 1)
 TriggerEvent("inventory:addQty", 13, 5)
 TriggerEvent("inventory:addQty", 14, 5)
 SetEntityCoords(GetPlayerPed(-1), -220.744, -1053.473, 29.540)
 if(GetEntityModel(GetPlayerPed(-1)) == -1667301416) then  -- GIRL SKIN
  SetPedComponentVariation(GetPlayerPed(-1), 8, 0, 240, 2)
  SetPedComponentVariation(GetPlayerPed(-1), 3, 14, 0, 2)
  SetPedComponentVariation(GetPlayerPed(-1), 11, 14, math.random(1,15), 2)
  SetPedComponentVariation(GetPlayerPed(-1), 4, 23, 8, 2)
  SetPedComponentVariation(GetPlayerPed(-1), 6, 1, 0, 2)
 else                             -- BOY SKIN
  SetPedComponentVariation(GetPlayerPed(-1), 8, 1,0, 2)
  SetPedComponentVariation(GetPlayerPed(-1), 3, 0,0, 2)
  SetPedComponentVariation(GetPlayerPed(-1), 11, 1, math.random(3,8), 2)
  SetPedComponentVariation(GetPlayerPed(-1), 4, 1, 1, 2)
  SetPedComponentVariation(GetPlayerPed(-1), 6, 1, 1, 2)
 end
 save()
end

