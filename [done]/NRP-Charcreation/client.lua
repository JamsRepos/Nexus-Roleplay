local _charPool = nil
local isCreatingCharacter = false
skinData = {['Mother'] = 0, ['Father'] = 0, ['skinTone'] = 0, ['Resembalance'] = 0, ['Eye Colour'] = 0, ['Aging'] = 0, ['Aging Opacity'] = 0.0, ['Hair'] = 1, ['Hair Colour 1'] = 0, ['Hair Colour 2'] = 0, ['Eyebrows'] = 0, ['Eyebrow Colour'] = 0, ['Beard'] = 0, ['Beard Colour'] = 0, ['Beard Opacity'] = 0.5, ['Skin Blemishes'] = 0, ['Skin Blemishes Opacity'] = 0.5, ['Freckles'] = 0, ['Freckles Opacity'] = 0.5, ['Eye Makeup'] = 0, ['EyeMakeup Colour'] = 0, ['Eye Makeup Opacity'] = 0.5, ['Lipstick'] = 0, ['Lipstick Color'] = 0, ['Lipstick Opacity'] = 0.5, ['Chest Hair'] = 0, ['Chest Hair Colour'] = 0, ['Chest Hair Opacity'] = 0.5, ['Blusher'] = 0, ['Blusher Opacity'] = 0, ['Blusher Colour'] = 0.5, ['Nose Width'] = 100, ['Nose Bottom Height'] = 100, ['Nose Tip Length'] = 100, ['Nose Bridge Depth'] = 100, ['Nose Tip Height'] = 100, ['Nose Broken'] = 100, ['Brow Height'] = 100, ['Brow Depth'] = 100, ['Cheekbone Height'] = 100, ['Cheekbone Width'] = 100, ['Cheek Width'] = 100, ['Eyes Opening'] = 100, ['Lips Thickness'] = 100, ['Jaw Width'] = 100, ['Jaw Shape'] = 100, ['Chin Height'] = 100, ['Chin Width'] = 100, ['Chin Indent'] = 100, ['Neck Width'] = 100}

local surgeons = {
  [1] = {x = 314.727, y = -568.193, z = 43.284},
  [2] = {x = 320.36, y = -570.32, z = 43.284},
  [3] = {x = 325.97, y = -573.13, z = 43.284},
}

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(5)
    for k,v in pairs(surgeons) do
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 1.2) then
        DrawText3Ds(v.x, v.y, v.z,'~g~[E]~w~ to perform plastic surgery')
        if IsControlPressed(0, 38) then
          TriggerServerEvent('skinCreation:surgery')
        end
      end
    end
  end
end)

Citizen.CreateThread(function()
 while true do
  Wait(5)
  if NetworkIsGameInProgress() and IsPlayerPlaying(PlayerId()) then
   if isCreatingCharacter then
   local ped = GetPlayerPed(-1)
   for i=0, 255, 1 do
    if i ~= PlayerId() then
     local otherPlayerPed = GetPlayerPed(i)
     SetEntityLocallyInvisible(otherPlayerPed)
     SetEntityNoCollisionEntity(ped, otherPlayerPed, true)
    end
   end
    if _charPool:IsAnyMenuOpen() then
     _charPool:ProcessMenus()
    end

    if DoesCamExist(cam) and not IsPlayerSwitchInProgress() then
     if not _charPool:IsAnyMenuOpen() then
      charMenu:Visible(not charMenu:Visible())
     end
    end
   end
  end
 end
end)


function EnterCharacterCreator(gender, firstTime)
 cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
 while not DoesCamExist(cam) do
  Citizen.Wait(250)
 end

 if DoesCamExist(cam) then
  SetCamCoord(cam, 402.65, -997.581, -98.50)
  SetCamRot(cam, -1.089798, 0.0, 0.276381, 0)
  SetCamFov(cam, 60.0)
  RenderScriptCams(true, false, 3000, 1, 0, 0)
 end

 if gender == 'Male' then 
  RequestAnimDict('mp_character_creation@customise@male_a')
  while (not HasAnimDictLoaded('mp_character_creation@customise@male_a')) do
    Citizen.Wait(100)
  end

  skinData['Gender'] = 'mp_m_freemode_01' 
  GetRandomMultiPlayerModel(skinData['Gender'])
  TaskPlayAnim(PlayerPedId(), 'mp_character_creation@customise@male_a', 'intro', 1.0, -1.0, 4800, 0, 1, true, true, true)
 else 
  RequestAnimDict('mp_character_creation@customise@female_a')
  while (not HasAnimDictLoaded('mp_character_creation@customise@female_a')) do
    Citizen.Wait(100)
  end

  skinData['Gender'] = 'mp_f_freemode_01' 
  GetRandomMultiPlayerModel(skinData['Gender'])
  TaskPlayAnim(PlayerPedId(), 'mp_character_creation@customise@female_a', 'intro', 1.0, -1.0, 4800, 0, 1, true, true, true)
 end
 Wait(3000)
 SetCamFov(cam, 35.0)
--FreezeEntityPosition(PlayerPedId(), true)
-- SetEntityCoordsNoOffset(PlayerPedId(), 402.65, -996.281, -101.100)
 --SetEntityHeading(PlayerPedId(), 180.0)

 _charPool = NativeUI.CreatePool()
 local title = nil
 if firstTime then title = "Character Creation" else title = "Plastic Surgeon" end
 charMenu = NativeUI.CreateMenu(title)
 _charPool:Add(charMenu)
 DisplayCharacterCreatorMenu(charMenu, firstTime)
 _charPool:RefreshIndex()
 isCreatingCharacter = true
end

function DisplayCharacterCreatorMenu(menu, firstTime)
 AddHeritageSelection(menu)
 AddAppearanceSelection(menu)
 AddFeaturesSelection(menu)
 local saveItem = NativeUI.CreateItem('Save & Confirm', '')
 menu:AddItem(saveItem)
 menu.OnItemSelect = function(sender, item, index)
  if item == saveItem then
   DoScreenFadeOut(0)
   TriggerServerEvent('skinCreation:save', json.encode(skinData))
   if firstTime then
    if(GetEntityModel(GetPlayerPed(-1)) == -1667301416) then
      SetPedComponentVariation(GetPlayerPed(-1), 8, 0, 240, 2)
      SetPedComponentVariation(GetPlayerPed(-1), 3, 14, 0, 2)
      SetPedComponentVariation(GetPlayerPed(-1), 11, 14, math.random(1,15), 2)
      SetPedComponentVariation(GetPlayerPed(-1), 4, 23, 8, 2)
      SetPedComponentVariation(GetPlayerPed(-1), 6, 1, 0, 2)
    else
      SetPedComponentVariation(GetPlayerPed(-1), 8, 1,0, 2)
      SetPedComponentVariation(GetPlayerPed(-1), 3, 0,0, 2)
      SetPedComponentVariation(GetPlayerPed(-1), 11, 1, math.random(3,8), 2)
      SetPedComponentVariation(GetPlayerPed(-1), 4, 1, 1, 2)
      SetPedComponentVariation(GetPlayerPed(-1), 6, 1, 1, 2)
    end
  else
    if(GetEntityModel(GetPlayerPed(-1)) == -1667301416) then
      SetPedComponentVariation(GetPlayerPed(-1), 4, 112, 5, 2)
      SetPedComponentVariation(GetPlayerPed(-1), 11, 286, 20, 2)
      SetPedComponentVariation(GetPlayerPed(-1), 5, 14, 0, 2)
      SetPedComponentVariation(GetPlayerPed(-1), 6, 35, 0, 2)
    else
      SetPedComponentVariation(GetPlayerPed(-1), 4, 3, 3, 2)
      SetPedComponentVariation(GetPlayerPed(-1), 11, 47, 0, 2)
      SetPedComponentVariation(GetPlayerPed(-1), 5, 0, 0, 2)
      SetPedComponentVariation(GetPlayerPed(-1), 6, 6, 0, 2)
    end
  end
   if DoesCamExist(cam) then
    RenderScriptCams(false, false, 3000, 1, 0, 0)
    FreezeEntityPosition(PlayerPedId(), false)
    menu:Visible(not menu:Visible())
    DestroyCam(cam, true)
   end
    if firstTime then
      SetEntityCoords(PlayerPedId(), -220.744, -1053.473, 29.540-1.0)
      SetEntityHeading(PlayerPedId(), 328.147)
    else
      SetEntityCoords(PlayerPedId(), 323.60, -585.05, 43.28-1.0)
      SetEntityHeading(PlayerPedId(), 69.39)   
    end                  
    while not HasCollisionLoadedAroundEntity(PlayerPedId()) do
     Wait(1)
    end
    Wait(750)
    DoScreenFadeIn(500)
    _charPool:Remove()
    if firstTime then
      Wait(1000)
      TriggerEvent('clothing:save')
      Wait(500)
      ExecuteCommand('clothes')
      Wait(500)
      TriggerEvent('core:starttutorial', false)
    end
    isCreatingCharacter = false
  end
 end
end

-- 
-- Features Selection
function AddFeaturesSelection(menu)
 local FeaturesOptions = {} for i = 0, 200 do FeaturesOptions[i] = i/100 + 0.00 - 1.00 end

 local submenu = _charPool:AddSubMenu(menu, 'Features')
 local noseWidth = NativeUI.CreateListItem('Nose Width', FeaturesOptions, 1)
 local noseBottomHeight = NativeUI.CreateListItem('Nose Bottom Height', FeaturesOptions, 1)
 local noseTipLength = NativeUI.CreateListItem('Nose Tip Length', FeaturesOptions, 1)
 local noseBridgeDepth = NativeUI.CreateListItem('Nose Bridge Depth', FeaturesOptions, 1)
 local noseTipHeight = NativeUI.CreateListItem('Nose Tip Height', FeaturesOptions, 1)
 local noseBroken = NativeUI.CreateListItem('Nose Broken', FeaturesOptions, 1)
 local browHeight = NativeUI.CreateListItem('Brow Height', FeaturesOptions, 1)
 local browDepth = NativeUI.CreateListItem('Brow Depth', FeaturesOptions, 1)
 local cheekboneHeight = NativeUI.CreateListItem('Cheekbone Height', FeaturesOptions, 1)
 local cheekboneWidth = NativeUI.CreateListItem('Cheekbone Width', FeaturesOptions, 1)
 local cheekWidth = NativeUI.CreateListItem('Cheek Width', FeaturesOptions, 1)
 local eyesOpening = NativeUI.CreateListItem('Eyes Opening', FeaturesOptions, 1)
 local lipsThickness = NativeUI.CreateListItem('Lips Thickness', FeaturesOptions, 1)
 local jawWidth = NativeUI.CreateListItem('Jaw Width', FeaturesOptions, 1)
 local jawShape = NativeUI.CreateListItem('Jaw Shape', FeaturesOptions, 1)
 local chinHeight = NativeUI.CreateListItem('Chin Height', FeaturesOptions, 1)
 local chinWidth = NativeUI.CreateListItem('Chin Width', FeaturesOptions, 1)
 local chinIndent = NativeUI.CreateListItem('Chin Indent', FeaturesOptions, 1)
 local neckWidth = NativeUI.CreateListItem('Neck Width', FeaturesOptions, 1)
 local randomButton = NativeUI.CreateItem('Randomize', '')

 submenu:AddItem(noseWidth)
 submenu:AddItem(noseBottomHeight)
 submenu:AddItem(noseTipLength)
 submenu:AddItem(noseBridgeDepth)
 submenu:AddItem(noseTipHeight)
 submenu:AddItem(noseBroken)
 submenu:AddItem(browHeight)
 submenu:AddItem(browDepth)
 submenu:AddItem(cheekboneHeight)
 submenu:AddItem(cheekboneWidth)
 submenu:AddItem(cheekWidth)
 submenu:AddItem(eyesOpening)
 submenu:AddItem(lipsThickness)
 submenu:AddItem(jawWidth)
 submenu:AddItem(jawShape)
 submenu:AddItem(chinHeight)
 submenu:AddItem(chinWidth)
 submenu:AddItem(chinIndent)
 submenu:AddItem(neckWidth)
 submenu:AddItem(randomButton)

 submenu.OnListChange = function(sender, item, index)
  if item == noseWidth then
   skinData['Nose Width'] = index
   SetPedFaceFeature(GetPlayerPed(-1), 0, skinData['Nose Width']/100 + 0.00 - 1.00)
  elseif item == noseBottomHeight then
   skinData['Nose Bottom Height'] = index
   SetPedFaceFeature(GetPlayerPed(-1), 1, skinData['Nose Bottom Height']/100 + 0.00 - 1.00)
  elseif item == noseTipLength then
   skinData['Nose Tip Length'] = index
   SetPedFaceFeature(GetPlayerPed(-1), 2, skinData['Nose Tip Length']/100 + 0.00 - 1.00)
  elseif item == noseBridgeDepth then
   skinData['Nose Bridge Depth'] = index
   SetPedFaceFeature(GetPlayerPed(-1), 3, skinData['Nose Bridge Depth']/100 + 0.00 - 1.00)
  elseif item == noseTipHeight then
   skinData['Nose Tip Height'] = index
   SetPedFaceFeature(GetPlayerPed(-1), 4, skinData['Nose Tip Height']/100 + 0.00 - 1.00)
  elseif item == noseBroken then
   skinData['Nose Broken'] = index
   SetPedFaceFeature(GetPlayerPed(-1), 5, skinData['Nose Broken']/100 + 0.00 - 1.00)
  elseif item == browHeight then
   skinData['Brow Height'] = index
   SetPedFaceFeature(GetPlayerPed(-1), 6, skinData['Brow Height']/100 + 0.00 - 1.00)
  elseif item == browDepth then
   skinData['Brow Depth'] = index
   SetPedFaceFeature(GetPlayerPed(-1), 7, skinData['Brow Depth']/100 + 0.00 - 1.00)
  elseif item == cheekboneHeight then
   skinData['Cheekbone Height'] = index
   SetPedFaceFeature(GetPlayerPed(-1), 8, skinData['Cheekbone Height']/100 + 0.00 - 1.00)
  elseif item == cheekboneWidth then
   skinData['Cheekbone Width'] = index
   SetPedFaceFeature(GetPlayerPed(-1), 9, skinData['Cheekbone Width']/100 + 0.00 - 1.00)
  elseif item == cheekWidth then
   skinData['Cheek Width'] = index
   SetPedFaceFeature(GetPlayerPed(-1), 10, skinData['Cheek Width']/100 + 0.00 - 1.00)
  elseif item == eyesOpening then
   skinData['Eyes Opening'] = index
   SetPedFaceFeature(GetPlayerPed(-1), 11, skinData['Eyes Opening']/100 + 0.00 - 1.00)
  elseif item == lipsThickness then
   skinData['Lips Thickness'] = index
   SetPedFaceFeature(GetPlayerPed(-1), 12, skinData['Lips Thickness']/100 + 0.00 - 1.00)
  elseif item == jawWidth then
   skinData['Jaw Width'] = index
   SetPedFaceFeature(GetPlayerPed(-1), 13, skinData['Jaw Width']/100 + 0.00 - 1.00)
  elseif item == jawShape then
   skinData['Jaw Shape'] = index
   SetPedFaceFeature(GetPlayerPed(-1), 14, skinData['Jaw Shape']/100 + 0.00 - 1.00)
  elseif item == chinHeight then
   skinData['Chin Height'] = index
   SetPedFaceFeature(GetPlayerPed(-1), 15, skinData['Chin Height']/100 + 0.00 - 1.00)
  elseif item == chinWidth then
   skinData['Chin Width'] = index
   SetPedFaceFeature(GetPlayerPed(-1), 16, skinData['Chin Width']/100 + 0.00 - 1.00)
  elseif item == chinIndent then
   skinData['Chin Indent'] = index
   SetPedFaceFeature(GetPlayerPed(-1), 17, skinData['Chin Indent']/100 + 0.00 - 1.00)
  elseif item == neckWidth then
   skinData['Neck Width'] = index
   SetPedFaceFeature(GetPlayerPed(-1), 18, skinData['Neck Width']/100 + 0.00 - 1.00)
  end
 end

 submenu.OnItemSelect = function(sender, item, index)
  if item == randomButton then
   print('Randomizing')
   skinData['Nose Width'] = math.random(0, 200)
   skinData['Nose Bottom Height'] = math.random(0, 200)
   skinData['Nose Tip Length'] = math.random(0, 200)
   skinData['Nose Bridge Depth'] = math.random(0, 200)
   skinData['Nose Tip Height'] = math.random(0, 200)
   skinData['Nose Broken'] = math.random(0, 200)
   skinData['Brow Height'] = math.random(0, 200)
   skinData['Brow Depth'] = math.random(0, 200)
   skinData['Cheekbone Height'] = math.random(0, 200)
   skinData['Cheekbone Width'] = math.random(0, 200)
   skinData['Cheek Width'] = math.random(0, 200)
   skinData['Eyes Opening'] = math.random(0, 200)
   skinData['Lips Thickness'] = math.random(0, 200)
   skinData['Jaw Width'] = math.random(0, 200)
   skinData['Jaw Shape'] = math.random(0, 200)
   skinData['Chin Height'] = math.random(0, 200)
   skinData['Chin Width'] = math.random(0, 200)
   skinData['Chin Indent'] = math.random(0, 200)
   skinData['Neck Width'] = math.random(0, 200)

   SetPedFaceFeature(GetPlayerPed(-1), 0, skinData['Nose Width']/100 + 0.00 - 1.00)
   SetPedFaceFeature(GetPlayerPed(-1), 1, skinData['Nose Bottom Height']/100 + 0.00 - 1.00)
   SetPedFaceFeature(GetPlayerPed(-1), 2, skinData['Nose Tip Length']/100 + 0.00 - 1.00)
   SetPedFaceFeature(GetPlayerPed(-1), 3, skinData['Nose Bridge Depth']/100 + 0.00 - 1.00)
   SetPedFaceFeature(GetPlayerPed(-1), 4, skinData['Nose Tip Height']/100 + 0.00 - 1.00)
   SetPedFaceFeature(GetPlayerPed(-1), 5, skinData['Nose Broken']/100 + 0.00 - 1.00)
   SetPedFaceFeature(GetPlayerPed(-1), 6, skinData['Brow Height']/100 + 0.00 - 1.00)
   SetPedFaceFeature(GetPlayerPed(-1), 7, skinData['Brow Depth']/100 + 0.00 - 1.00)
   SetPedFaceFeature(GetPlayerPed(-1), 8, skinData['Cheekbone Height']/100 + 0.00 - 1.00)
   SetPedFaceFeature(GetPlayerPed(-1), 9, skinData['Cheekbone Width']/100 + 0.00 - 1.00)
   SetPedFaceFeature(GetPlayerPed(-1), 10, skinData['Cheek Width']/100 + 0.00 - 1.00)
   SetPedFaceFeature(GetPlayerPed(-1), 11, skinData['Eyes Opening']/100 + 0.00 - 1.00)
   SetPedFaceFeature(GetPlayerPed(-1), 12, skinData['Lips Thickness']/100 + 0.00 - 1.00)
   SetPedFaceFeature(GetPlayerPed(-1), 13, skinData['Jaw Width']/100 + 0.00 - 1.00)
   SetPedFaceFeature(GetPlayerPed(-1), 14, skinData['Jaw Shape']/100 + 0.00 - 1.00)
   SetPedFaceFeature(GetPlayerPed(-1), 15, skinData['Chin Height']/100 + 0.00 - 1.00)
   SetPedFaceFeature(GetPlayerPed(-1), 16, skinData['Chin Width']/100 + 0.00 - 1.00)
   SetPedFaceFeature(GetPlayerPed(-1), 17, skinData['Chin Indent']/100 + 0.00 - 1.00)
   SetPedFaceFeature(GetPlayerPed(-1), 18, skinData['Neck Width']/100 + 0.00 - 1.00)
  end
 end
end

-- Appearance Selection
function AddAppearanceSelection(menu)
 local hairstyles = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45}
 local eyebrowstyles = {} for i = 0, 33 do eyebrowstyles[i] = GetLabelText("CC_EYEBRW_"..i) end
 local brusherstyles = {} for i = 0, 6 do brusherstyles[i] = GetLabelText("CC_BLUSH_"..i) end
 local hairColors = {{15,15,15},{55,47,40},{93,70,56},{116,69,46},{114,53,28},{148,71,36},{161,85,48},{157,93,57},{169,112,74},{172,120,81},{184,135,89},{195,152,101},{231,190,115},{235,195,129},{245,214,155},{168,115,73},{166,92,61},{156,55,36},{126,21,17},{141,26,20},{169,29,20},{204,56,31},{234,92,36},{213,105,57},{213,76,35},{125,100,82},{164,138,118},{222,199,179},{235,214,195},{124,85,103},{141,89,115},{172,74,105},{254,85,218},{254,95,159},{246,153,162},{9,160,146},{8,136,148},{8,87,139},{106,176,98},{44,135,88},{42,124,101},{185,189,44},{158,183,19},{99,173,35},{229,184,83},{241,192,14},{249,170,20},{251,143,27},{247,116,39},{257,102,20},{246,101,47},{243,49,15},{190,11,14},{166,9,13},{30,19,17},{69,41,31},{89,48,33},{74,40,30},{75,41,28},{57,35,28},{31,27,24},{223,179,122},{194,152,111}}

 local submenu = _charPool:AddSubMenu(menu, 'Appearance')
 local HairItem = NativeUI.CreateListItem('Hair', hairstyles, 1)
 local ChestHairItem = NativeUI.CreateListItem('Chest Hair', {'None', 'Natural', 'The Strip', 'The Tree','The Tree 2', 'Hairy', 'Grisly', 'Ape', 'Groomed Ape', 'Bikini', 'Lightning Bolt', 'Reverse Lightning', 'Love Heart', 'Chestache', 'Happy Face', 'Skull', 'Snail Trail', 'Slug and Nips', 'Hairy Arms'}, 1)
 local EyebrowsItem = NativeUI.CreateListItem('Eyebrows', eyebrowstyles, 1)
 local BeardItem = NativeUI.CreateListItem('Beard', {'Clean Shaven','Light Stubble','Mustache','Trimmed Beard','Stubble','Thin Circle Beard','Horseshoe','Pencil & Chops','Chin Strap Beard','Balbo & Sideburns','Mutton Chops','Scruffy Beard','Balbo','Circle Beard','Goatee','Chin','Chin Fuzz','Pencil Chin Strap','Scruffy','Musketeer','1','2','3','4','5','6'}, 1)
 local BlemishesItem = NativeUI.CreateListItem('Skin Blemishes', {'Measles', 'Pimples', 'Spots', 'Break Out', 'Blackheads', 'Build Up', 'Pustules', 'Zits', 'Full Acne', 'Acne', 'Cheek Rash', 'Face Rash', 'Picker', 'Puberty', 'Eyesore', 'Chin Rash', 'Two Face', 'T Zone', 'Greasy', 'Marked', 'Acne Scarring', 'Full Acne Scarring', 'Cold Sores', 'Impetigo'}, 1)
 local FrecklesItem = NativeUI.CreateListItem('Moles & Freckles', {'Cherub', 'All Over', 'Irregular', 'Dot Dash', 'Over the Bridge', 'Baby Doll', 'Pixie', 'Sun Kissed', 'Beauty Marks', 'Line Up', 'Modelesque', 'Occasional', 'Speckled', 'Rain Drops', 'Double Dip', 'One Sided', 'Pairs', 'Growth'}, 1)
 local EyeMakeupItem = NativeUI.CreateListItem('Eye Makeup', {'Smoky Black', 'Bronze', 'Soft Gray', 'Retro Glam', 'Natural Look', 'Cat Eyes', 'Chola', 'Vamp', 'Vinewood Glamour', 'Bubblegum', 'Aqua Dream', 'Pin Up', 'Purple Passion', 'Smoky Cat Eye', 'Smoldering Ruby', 'Pop Princess'}, 1)
 local LipstickItem = NativeUI.CreateListItem('Lipstick', {'Color Matte', 'Color Gloss', 'Lined Matte', 'Lined Gloss', 'Heavy Lined Matte', 'Heavy Lined Gloss', 'Lined Nude Matte', 'Liner Nude Gloss', 'Smudged', 'Geisha'}, 1)
 local BlusherItem = NativeUI.CreateListItem('Blusher', brusherstyles, 1)

 submenu:AddItem(HairItem)
 submenu:AddItem(ChestHairItem)
 submenu:AddItem(EyebrowsItem)
 submenu:AddItem(BeardItem)
 submenu:AddItem(BlemishesItem)
 submenu:AddItem(FrecklesItem)
 submenu:AddItem(EyeMakeupItem)
 submenu:AddItem(LipstickItem)
 submenu:AddItem(BlusherItem)

 submenu.OnListChange = function(sender, item, index)
  if item == HairItem then
   if index == 1 then skinData['Hair'] = 0 else skinData['Hair'] = index end
   SetPedComponentVariation(GetPlayerPed(-1), 2, skinData['Hair'], 0, 1)
  elseif item == EyebrowsItem then 
   skinData['Eyebrows'] = index 
   SetPedHeadOverlay(GetPlayerPed(-1), 2, skinData['Eyebrows'], 10.0)
  elseif item == BeardItem then 
   if index == 1 then skinData['Beard'] = 0 else skinData['Beard'] = index end
   SetPedHeadOverlay(GetPlayerPed(-1), 1, skinData['Beard'], skinData['Beard Opacity'])
  elseif item == BlemishesItem then 
   skinData['Skin Blemishes'] = index
   SetPedHeadOverlay(GetPlayerPed(-1), 0, skinData['Skin Blemishes'], skinData['Skin Blemishes Opacity'])
  elseif item == FrecklesItem then
   skinData['Freckles'] = index-1
   SetPedHeadOverlay(GetPlayerPed(-1), 9, skinData['Freckles'], skinData['Freckles Opacity'])
  elseif item == EyeMakeupItem then
   skinData['Eye Makeup'] = index
   SetPedHeadOverlay(GetPlayerPed(-1), 4, skinData['Eye Makeup'], skinData['Eye Makeup Opacity'])
  elseif item == LipstickItem then
   skinData['Lipstick'] = index
   SetPedHeadOverlay(GetPlayerPed(-1), 8, skinData['Lipstick'], skinData['Lipstick Opacity'])
  elseif item == ChestHairItem then
   skinData['Chest Hair'] = index-3
   SetPedHeadOverlay(GetPlayerPed(-1), 10, skinData['Chest Hair'], skinData['Chest Hair Opacity'])
  elseif item == BlusherItem then
   skinData['Blusher'] = index
   SetPedHeadOverlay(GetPlayerPed(-1), 5, skinData['Blusher'], skinData['Blusher Opacity'])
  end
 end

 local HairPanel = NativeUI.CreateColourPanel('Primary Hair Color', hairColors)
 HairItem:AddPanel(HairPanel)
 HairPanel.UpdateParent = function(sender, item, index)
  skinData['Hair Colour 1'] = HairPanel:CurrentSelection()
  SetPedHairColor(GetPlayerPed(-1), skinData['Hair Colour 1'], skinData['Hair Colour 2'])
 end

 local HairPanel2 = NativeUI.CreateColourPanel('Secondary Hair Color', hairColors)
 HairItem:AddPanel(HairPanel2)
 HairPanel2.UpdateParent = function(sender, item, index)
  skinData['Hair Colour 2'] = HairPanel2:CurrentSelection()
  SetPedHairColor(GetPlayerPed(-1), skinData['Hair Colour 1'], skinData['Hair Colour 2'])
 end

 local ChestHairPanel = NativeUI.CreateColourPanel('Chest Hair Color', hairColors)
 ChestHairItem:AddPanel(ChestHairPanel)
 ChestHairPanel.UpdateParent = function(sender, item, index)
  skinData['Chest Hair Colour'] = ChestHairPanel:CurrentSelection()
  SetPedHeadOverlayColor(GetPlayerPed(-1), 10, 1, skinData['Chest Hair Colour'], 1)
 end

 local ChestHairPanel2 = NativeUI.CreatePercentagePanel('','')
 ChestHairItem:AddPanel(ChestHairPanel2)
 ChestHairPanel2.UpdateParent = function()
  skinData['Chest Hair Opacity'] = ChestHairPanel2:Percentage()
  SetPedHeadOverlay(GetPlayerPed(-1), 10, skinData['Chest Hair'], skinData['Chest Hair Opacity'])
 end

 local EyebrowPanel = NativeUI.CreateColourPanel('Primary Eyebrow Color', hairColors)
 EyebrowsItem:AddPanel(EyebrowPanel)
 EyebrowPanel.UpdateParent = function(sender, item, index)
  skinData['Eyebrow Colour'] = EyebrowPanel:CurrentSelection()
  SetPedHeadOverlayColor(GetPlayerPed(-1), 2, 1, skinData['Eyebrow Colour'], skinData['Eyebrow Colour'])
 end

 local BeardPanel = NativeUI.CreateColourPanel('Primary Beard Color', hairColors)
 BeardItem:AddPanel(BeardPanel)
 BeardPanel.UpdateParent = function(sender, item, index)
  skinData['Beard Colour'] = BeardPanel:CurrentSelection()
  SetPedHeadOverlayColor(GetPlayerPed(-1), 1, 1, skinData['Beard Colour'], skinData['Beard Colour'])
 end

 local BeardPanel2 = NativeUI.CreatePercentagePanel('','')
 BeardItem:AddPanel(BeardPanel2)
 BeardPanel2.UpdateParent = function()
  skinData['Beard Opacity'] = BeardPanel2:Percentage()
  SetPedHeadOverlay(GetPlayerPed(-1), 1, skinData['Beard'], skinData['Beard Opacity'])
 end

 local BlemishesPanel = NativeUI.CreatePercentagePanel('','')
 BlemishesItem:AddPanel(BlemishesPanel)
 BlemishesPanel.UpdateParent = function()
  skinData['Skin Blemishes Opacity'] = BlemishesPanel:Percentage()
  SetPedHeadOverlay(GetPlayerPed(-1), 0, skinData['Skin Blemishes'], skinData['Skin Blemishes Opacity'])
 end

 local FrecklesPanel = NativeUI.CreatePercentagePanel('','')
 FrecklesItem:AddPanel(FrecklesPanel)
 FrecklesPanel.UpdateParent = function()
  skinData['Freckles Opacity'] = FrecklesPanel:Percentage()
  SetPedHeadOverlay(GetPlayerPed(-1), 9, skinData['Freckles'], skinData['Freckles Opacity'])
 end

 local EyeMakeupPanel = NativeUI.CreatePercentagePanel('','')
 EyeMakeupItem:AddPanel(EyeMakeupPanel)
 EyeMakeupPanel.UpdateParent = function()
  skinData['Eye Makeup Opacity'] = EyeMakeupPanel:Percentage()
  SetPedHeadOverlay(GetPlayerPed(-1), 4, skinData['Eye Makeup'], skinData['Eye Makeup Opacity'])
 end

 local EyeMakeupColourPanel = NativeUI.CreateColourPanel('Eye Makeup Color', hairColors)
 EyeMakeupItem:AddPanel(EyeMakeupColourPanel)
 EyeMakeupColourPanel.UpdateParent = function()
  skinData['EyeMakeup Colour'] = EyeMakeupColourPanel:CurrentSelection()
  SetPedHeadOverlayColor(GetPlayerPed(-1), 4, 1, skinData['Eye Makeup Colour'], skinData['EyeMakeup Colour']) 
 end

 local LipstickColourPanel = NativeUI.CreateColourPanel('Lipstick Color', hairColors)
 LipstickItem:AddPanel(LipstickColourPanel)
 LipstickColourPanel.UpdateParent = function()
  skinData['Lipstick Colour'] = LipstickColourPanel:CurrentSelection()
  SetPedHeadOverlayColor(GetPlayerPed(-1), 8, 1, skinData['Lipstick Colour'], skinData['Lipstick Colour'])
 end

 local LipstickPanel = NativeUI.CreatePercentagePanel('0%', '100%')
 LipstickItem:AddPanel(LipstickPanel)
 LipstickPanel.UpdateParent = function()
  skinData['Lipstick Opacity'] = LipstickPanel:Percentage()
  SetPedHeadOverlay(GetPlayerPed(-1), 8, skinData['Lipstick'], skinData['Lipstick Opacity'])
 end

 local BlusherPanel = NativeUI.CreatePercentagePanel('','')
 BlusherItem:AddPanel(BlusherPanel)
 BlusherPanel.UpdateParent = function()
  skinData['Blusher Opacity'] = BlusherPanel:Percentage()
  SetPedHeadOverlay(GetPlayerPed(-1), 5, skinData['Blusher'], skinData['Blusher Opacity'])
 end

 local BlusherColourPanel = NativeUI.CreateColourPanel('Blusher Color', hairColors)
 BlusherItem:AddPanel(BlusherColourPanel)
 BlusherColourPanel.UpdateParent = function()
  skinData['Blusher Colour'] = BlusherColourPanel:CurrentSelection()
  SetPedHeadOverlayColor(GetPlayerPed(-1), 5, 1, skinData['Blusher Colour'], skinData['Blusher Colour'])          -- Lipstick Color
 end
end

-- Heritage Selection
function AddHeritageSelection(menu)
 local submenu = _charPool:AddSubMenu(menu, 'Heritage')
 local Heritage = NativeUI.CreateHeritageWindow(10, 8)
 local momList = NativeUI.CreateListItem('Mother', {"Amelia", "Isabella", "Zoe", "Ava", "Camila", "Violet", "Sophia", "Evelyn", "Nicole","Ashley", "Tina", "Liz", "Roxy", "Jody", "Jemma", "Jazmine", "Lisa", "Marge", "Dorothy", "Angie", "Rita", "Jade", "Danielle", "Joanne", "Mary", "Vicky", "Pauline"}, 1)
 local dadList = NativeUI.CreateListItem('Father', {"Benjamin", "Daniel", "Joshua", "Noah", "Andrew", "Juan", "Alex", "Isaac", "Evan", "Ethan", "Vincent", "Angel", "Diego", "Adrian", "Gabriel", "Michael", "Santiago", "Kevin", "Louis", "Samuel", "Anthony", "Angel", "Diego", "Adrian", "Gabriel"}, 1)
 local eyeMenu = NativeUI.CreateListItem('Eye Color', {'Green', 'Emerald', 'Light Blue', 'Ocean Blue', 'Light Brown', 'Dark Brown', 'Hazel', 'Dark Gray', 'Light Gray', 'Pink', 'Yellow', 'Purple', 'Blackout', 'Shades of Gray', 'Tequila Sunrise', 'Atomic', 'Warp', 'ECola', 'Space Ranger', 'Ying Yang', 'Bullseye', 'Lizard', 'Dragon', 'Extra Terrestrial', 'Goat', 'Smiley', 'Possessed', 'Demon', 'Infected', 'Alien', 'Undead', 'Zombie'}, 1)
 local skinMenu = NativeUI.CreateListItem('Skin Aging', {'None', 'Crows Feet', 'First Signs', 'Middle Aged', 'Worry Lines', 'Depression', 'Distinguished', 'Aged', 'Weathered', 'Wrinkled', 'Sagging', 'Tough Life', 'Vintage', 'Retired'}, 1)
 local randomButton = NativeUI.CreateItem('Randomize', '')

 submenu:AddWindow(Heritage)
 submenu:AddItem(momList)
 submenu:AddItem(dadList)

 submenu.OnListChange = function(sender, item, index)
  if item == momList then
   skinData['Mother'] = index
  elseif item == dadList then
   skinData['Father'] = index
  elseif item == eyeMenu then
   skinData['Eye Colour'] = index-1
   SetPedEyeColor(GetPlayerPed(-1), skinData['Eye Colour'])
  elseif item == skinMenu then
   if index == 1 then
    skinData['Aging'] = 0
    skinData['Aging Opacity'] = 0.0
   else 
   skinData['Aging'] = index
   skinData['Aging Opacity'] = 1.0
   end
   SetPedHeadOverlay(GetPlayerPed(-1), 3, skinData['Aging'], skinData['Aging Opacity'])
  end
  Heritage:Index(skinData['Mother'], skinData['Father'])
  SetPedHeadBlendData(GetPlayerPed(-1), skinData['Mother'], skinData['Father'], 0, 0, skinData['Mother'], skinData['Father'], 0, skinData['Resembalance'], skinData['skinTone'], 0.0, false)
  while not HasPedHeadBlendFinished(PlayerPedId()) do
   Wait(100)
  end
 end

 -- Skin Tone
 local amount = {} for i = 1, 11 do amount[i] = i end
 local skinToneMenu = NativeUI.CreateSliderItem('Skin Tone', amount, 1, nil, true)
 local resemMenu = NativeUI.CreateSliderItem('Resembalance', amount, 1, nil, true)
 
 submenu:AddItem(skinToneMenu)
 submenu:AddItem(resemMenu)
 submenu:AddItem(eyeMenu)
 submenu:AddItem(skinMenu)

 submenu.OnSliderChange = function(sender, item, index)
  if item == skinToneMenu then
   skinData['skinTone'] = item:IndexToItem(index)/10 + 0.0 - 0.1
  elseif item == resemMenu then
   skinData['Resembalance'] = item:IndexToItem(index)/10 + 0.0 - 0.1
  end 
  SetPedHeadBlendData(GetPlayerPed(-1), skinData['Mother'], skinData['Father'], 0, 0, skinData['Mother'], skinData['Father'], 0, skinData['skinTone'], skinData['Resembalance'], 0.0, false)
  while not HasPedHeadBlendFinished(PlayerPedId()) do
   Wait(100)
  end
 end

 -- Randomize Character 
 submenu:AddItem(randomButton)
 submenu.OnItemSelect = function(sender, item, index)
  if item == randomButton then
   print('Randomizing')
   skinData['Mother'] = math.random(1,45)
   skinData['Father'] = math.random(1, 5)
   skinData['Aging Opacity'] = 0.0
   skinData['skinTone'] = math.random(1,10)/10 + 0.0 - 0.1
   skinData['Resembalance'] = math.random(1,10)/10 + 0.0 - 0.1

   SetPedHeadBlendData(GetPlayerPed(-1), skinData['Mother'], skinData['Father'], 0, 0, skinData['Mother'], skinData['Father'], 0, skinData['skinTone'], skinData['Resembalance'], 0.0, false)
   while not HasPedHeadBlendFinished(PlayerPedId()) do
    Wait(100)
   end
  end
 end
end

-- Gender Selection
function GetRandomMultiPlayerModel(modelhash)
 if IsModelValid(modelhash) then
  if not IsPedModel(PlayerPedId(), modelHash) then
   RequestModel(modelhash)
   while not HasModelLoaded(modelhash) do
    Wait(500)
   end
   SetPlayerModel(PlayerId(), modelhash)
  end
  if skinData['Gender'] == 'mp_m_freemode_01' then
   SetPedDefaultComponentVariation(GetPlayerPed(-1))
   SetPedComponentVariation(GetPlayerPed(-1), 2, 2, 1, 1)
   SetPedHairColor(GetPlayerPed(-1), 1, 1)
   SetPedComponentVariation(GetPlayerPed(-1),3,15,0,0)
   SetPedComponentVariation(GetPlayerPed(-1),4,21,0,0)
   SetPedComponentVariation(GetPlayerPed(-1),6,34,0,0)
   SetPedComponentVariation(GetPlayerPed(-1),8,15,0,0)
   SetPedComponentVariation(GetPlayerPed(-1),11,15,0,0)
  else
   SetPedDefaultComponentVariation(GetPlayerPed(-1))
   SetPedComponentVariation(GetPlayerPed(-1), 2, 2, 0, 1)
   SetPedHairColor(GetPlayerPed(-1), 1, 1)
   SetPedComponentVariation(GetPlayerPed(-1),3,15,0,0)
   SetPedComponentVariation(GetPlayerPed(-1),4,15,0,0)
   SetPedComponentVariation(GetPlayerPed(-1),6,35,0,0)
   SetPedComponentVariation(GetPlayerPed(-1),8,15,0,0)
   SetPedComponentVariation(GetPlayerPed(-1),11,15,0,0)
  end
  SetModelAsNoLongerNeeded(modelhash)
 end
end

function RestoreCharacterAppearance()
 -- Fix To Opacity
 if skinData['Aging Opacity'] == 1 then skinData['Aging Opacity'] = 1.0 elseif skinData['Aging Opacity'] == 0 then skinData['Aging Opacity'] = 0.0 end
 if skinData['Beard Opacity'] == 1 then skinData['Beard Opacity'] = 1.0 elseif skinData['Beard Opacity'] == 0 then skinData['Beard Opacity'] = 0.0 end 
 if skinData['Chest Hair Opacity'] == 1 then skinData['Chest Hair Opacity'] = 1.0 elseif skinData['Chest Hair Opacity'] == 0 then skinData['Chest Hair Opacity'] = 0.0 end
 if skinData['Skin Blemishes Opacity'] == 1 then skinData['Skin Blemishes Opacity'] = 1.0 elseif skinData['Skin Blemishes Opacity'] == 0 then skinData['Skin Blemishes Opacity'] = 0.0 end
 if skinData['Eye Makeup Opacity'] == 1 then skinData['Eye Makeup Opacity'] = 1.0 elseif skinData['Eye Makeup Opacity'] == 0 then skinData['Eye Makeup Opacity'] = 0.0 end
 if skinData['Lipstick Opacity'] == 1 then skinData['Lipstick Opacity'] = 1.0 elseif skinData['Lipstick Opacity'] == 0 then skinData['Lipstick Opacity'] = 0.0 end 
 if skinData['Blusher Opacity'] == 1 then skinData['Blusher Opacity'] = 1.0 elseif skinData['Blusher Opacity'] == 0 then skinData['Blusher Opacity'] = 0.0 end 
 if skinData['skinTone'] == 1 then skinData['skinTone'] = 1.0 elseif skinData['skinTone'] == 0 then skinData['skinTone'] = 0.0 end 
 if skinData['Resembalance'] == 1 then skinData['Resembalance'] = 1.0 elseif skinData['Resembalance'] == 0 then skinData['Resembalance'] = 0.0 end  

 -- Face & Model
 if not IsPedModel(PlayerPedId(), skinData['Gender']) then
  RequestModel(skinData['Gender'])
  while not HasModelLoaded(skinData['Gender']) do
   Wait(500)
  end
  SetPlayerModel(PlayerId(), skinData['Gender'])
  while not IsPedModel(PlayerPedId(), skinData['Gender']) do
   Wait(250)
   SetPlayerModel(PlayerId(), skinData['Gender'])
  end
 end
 SetPedHeadBlendData(GetPlayerPed(-1), skinData['Mother'], skinData['Father'], 0, 0, skinData['Mother'], skinData['Father'], 0, skinData['skinTone'], skinData['Resembalance'], 0.0, false)
 while not HasPedHeadBlendFinished(PlayerPedId()) do
  Wait(100)
 end

 -- Eye Colour & Aging 
 SetPedEyeColor(GetPlayerPed(-1), skinData['Eye Colour'])
 SetPedHeadOverlay(GetPlayerPed(-1), 3, skinData['Aging'], skinData['Aging Opacity'])

 -- Hair
 SetPedComponentVariation(GetPlayerPed(-1), 2, skinData['Hair'], 0, 1)
 SetPedHairColor(GetPlayerPed(-1), skinData['Hair Colour 1'], skinData['Hair Colour 2'])

 -- Eyebrows
 SetPedHeadOverlay(GetPlayerPed(-1), 2, skinData['Eyebrows'], 10.0)
 SetPedHeadOverlayColor(GetPlayerPed(-1), 2, 1, skinData['Eyebrow Colour'], skinData['Eyebrow Colour'])

 -- Beard
 SetPedHeadOverlay(GetPlayerPed(-1), 1, skinData['Beard'], skinData['Beard Opacity'])
 SetPedHeadOverlayColor(GetPlayerPed(-1), 1, 1, skinData['Beard Colour'], skinData['Beard Colour'])
 
 -- Chest Hair
 SetPedHeadOverlay(GetPlayerPed(-1), 10, skinData['Chest Hair'], skinData['Chest Hair Opacity'])
 SetPedHeadOverlayColor(GetPlayerPed(-1), 10, 1, skinData['Chest Hair Colour'], 1)

 -- Skin Blemishes & Freckles
 SetPedHeadOverlay(GetPlayerPed(-1), 0, skinData['Skin Blemishes'], skinData['Skin Blemishes Opacity'])
 SetPedHeadOverlay(GetPlayerPed(-1), 9, skinData['Freckles'], skinData['Freckles Opacity'])

 -- Eye Makeup
 SetPedHeadOverlay(GetPlayerPed(-1), 4, skinData['Eye Makeup'], skinData['Eye Makeup Opacity'])
 SetPedHeadOverlayColor(GetPlayerPed(-1), 4, 1, skinData['Eye Makeup Colour'], skinData['EyeMakeup Colour']) 

 -- Lipstick
 SetPedHeadOverlay(GetPlayerPed(-1), 8, skinData['Lipstick'], skinData['Lipstick Opacity'])
 SetPedHeadOverlayColor(GetPlayerPed(-1), 8, 1, skinData['Lipstick Colour'], skinData['Lipstick Colour'])

 -- Blusher
 SetPedHeadOverlay(GetPlayerPed(-1), 5, skinData['Blusher'], skinData['Blusher Opacity'])
 SetPedHeadOverlayColor(GetPlayerPed(-1), 5, 1, skinData['Blusher Colour'], skinData['Blusher Colour'])

 -- Features
 if skinData['Nose Width'] ~= nil then 
  SetPedFaceFeature(GetPlayerPed(-1), 0, skinData['Nose Width']/100 + 0.00 - 1.00)
  SetPedFaceFeature(GetPlayerPed(-1), 1, skinData['Nose Bottom Height']/100 + 0.00 - 1.00)
  SetPedFaceFeature(GetPlayerPed(-1), 2, skinData['Nose Tip Length']/100 + 0.00 - 1.00)
  SetPedFaceFeature(GetPlayerPed(-1), 3, skinData['Nose Bridge Depth']/100 + 0.00 - 1.00)
  SetPedFaceFeature(GetPlayerPed(-1), 4, skinData['Nose Tip Height']/100 + 0.00 - 1.00)
  SetPedFaceFeature(GetPlayerPed(-1), 5, skinData['Nose Broken']/100 + 0.00 - 1.00)
  SetPedFaceFeature(GetPlayerPed(-1), 6, skinData['Brow Height']/100 + 0.00 - 1.00)
  SetPedFaceFeature(GetPlayerPed(-1), 7, skinData['Brow Depth']/100 + 0.00 - 1.00)
  SetPedFaceFeature(GetPlayerPed(-1), 8, skinData['Cheekbone Height']/100 + 0.00 - 1.00)
  SetPedFaceFeature(GetPlayerPed(-1), 9, skinData['Cheekbone Width']/100 + 0.00 - 1.00)
  SetPedFaceFeature(GetPlayerPed(-1), 10, skinData['Cheek Width']/100 + 0.00 - 1.00)
  SetPedFaceFeature(GetPlayerPed(-1), 11, skinData['Eyes Opening']/100 + 0.00 - 1.00)
  SetPedFaceFeature(GetPlayerPed(-1), 12, skinData['Lips Thickness']/100 + 0.00 - 1.00)
  SetPedFaceFeature(GetPlayerPed(-1), 13, skinData['Jaw Width']/100 + 0.00 - 1.00)
  SetPedFaceFeature(GetPlayerPed(-1), 14, skinData['Jaw Shape']/100 + 0.00 - 1.00)
  SetPedFaceFeature(GetPlayerPed(-1), 15, skinData['Chin Height']/100 + 0.00 - 1.00)
  SetPedFaceFeature(GetPlayerPed(-1), 16, skinData['Chin Width']/100 + 0.00 - 1.00)
  SetPedFaceFeature(GetPlayerPed(-1), 17, skinData['Chin Indent']/100 + 0.00 - 1.00)
  SetPedFaceFeature(GetPlayerPed(-1), 18, skinData['Neck Width']/100 + 0.00 - 1.00) 
 end
end

RegisterNetEvent('skinCreation:load')
AddEventHandler('skinCreation:load', function(skin)
 skinData = skin
 RestoreCharacterAppearance()
 Wait(1000)
 RestoreCharacterAppearance()
 TriggerServerEvent('clothes:firstload')
 TriggerServerEvent('core:checkjob')
end)

RegisterNetEvent('skin:surgery')
AddEventHandler('skin:surgery', function(gender)
  while IsPlayerSwitchInProgress() do 
    Wait(100)
   end
   local ped = GetPlayerPed(-1)
   TriggerEvent("core:stopSkyCamera")
   SetEntityCoords(ped, 402.65, -996.281, -100.100)
   SetEntityHeading(ped, 180.0)
   FreezeEntityPosition(ped, true)
   while (IsPlayerTeleportActive()) do
    Citizen.Wait(5)
   end
  EnterCharacterCreator(gender, false) 
end)

RegisterNetEvent('skin:noskin')
AddEventHandler('skin:noskin', function(gender)
  while IsPlayerSwitchInProgress() do 
    Wait(100)
   end
   local ped = GetPlayerPed(-1)
   TriggerEvent("core:stopSkyCamera")
   SetEntityCoords(ped, 402.65, -996.281, -100.100)
   SetEntityHeading(ped, 180.0)
   FreezeEntityPosition(ped, true)
   while (IsPlayerTeleportActive()) do
    Citizen.Wait(5)
   end
   EnterCharacterCreator(gender, true) 
end)

RegisterNetEvent('skinCreation:new')
AddEventHandler('skinCreation:new', function(gender)
 while IsPlayerSwitchInProgress() do 
  Wait(100)
 end
 local ped = GetPlayerPed(-1)
 TriggerEvent("core:stopSkyCamera")
 SetEntityCoords(ped, 402.65, -996.281, -100.100)
 SetEntityHeading(ped, 180.0)
 FreezeEntityPosition(ped, true)
 TriggerEvent("inventory:addQty", 104, 1)
 TriggerEvent("inventory:addQty", 13, 5)
 TriggerEvent("inventory:addQty", 14, 5)
 while (IsPlayerTeleportActive()) do
  Citizen.Wait(5)
 end
 EnterCharacterCreator(gender, true)
end)

function DrawText3Ds(x,y,z, text)
  local onScreen,_x,_y=World3dToScreen2d(x,y,z)
  local px,py,pz=table.unpack(GetGameplayCamCoords())
  
  SetTextScale(0.35, 0.35)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextColour(255, 255, 255, 215)
  SetTextEntry("STRING")
  SetTextCentre(1)
  AddTextComponentString(text)
  DrawText(_x,_y)
end