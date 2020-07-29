outfits = {}
local clothing_shops = {
	{x=1932.76989746094, y=3727.73510742188, z=32.8444557189941},
	{x=1693.26, y=4822.27, z=42.06},
	{x=125.83, y=-223.16, z=54.55},
	{x=-710.16, y=-153.26, z=37.41},
	{x=-821.69, y=-1073.90, z=11.32},
	{x=-1192.81, y=-768.24, z=17.31},
	{x=4.25, y=6512.88, z=31.87},
	{x=425.471, y=-806.164, z=29.4911},
	{x=1117.0151, y=-3162.772, z=-36.870},
	{x=8.6996431350708, y=528.50665283203, z=170.63502502441},
	{x=334.0302734375, y=428.37963867188, z=145.57084655762},
	{x=1269.0017089844, y=-1710.4593505859, z=54.771446228027},
	{x=259.89224243164, y=-1003.932434082, z=-99.008613586426, hidden= true}, -- Low End Apartment
	{x=351.310577392, y=-993.736145019, z=-99.1961746215, hidden= true},  -- Med End Apartment
	{x = -899.36334228516, y = -433.00628662109, z = 89.264610290527, hidden= true},  -- High End Apartment
	{x = 305.778, y = -597.380, z = 43.284}, -- Hospital
	{x = 150.950, y = -1000.679, z = -99.000, hidden= true}, -- Motel
  {x = 105.045, y = -1303.050, z = 28.769}, -- Stripclub
  {x = -797.923, y = 328.089, z = 219.439, hidden= true}, -- Apartments
  {x = 374.228, y = 411.527, z = 142.100, hidden= true}, -- Red Interior Apartment
  {x = -167.580, y = 488.183, z = 133.843, hidden= true}, -- ipl4
  {x = -797.602, y = 328.921, z = 220.438, hidden= true}, -- iplapart1
  {x = 473.877, y = -1313.496, z = 29.207},
  {x = 450.718, y = -992.539, z = 30.690},
  {x = 983.942, y = -92.143, z = 74.851},
  {x = -127.354, y = -633.277, z = 168.821},
  {x = -1195.640, y = -1577.690, z = 4.609}, -- Gym Clothing Station
  {x = -1619.689, y = -3020.379, z = -75.205}, -- The Palace
  {x = -207.208, y = -1337.971, z = 34.894, hidden= true}, --bennys
  {x = 264.063, y = -1800.656, z = 26.914, hidden= true}, --bennys
  {x = -163.028, y = -303.305, z = 39.733},
  {x = 75.884, y = -1392.938, z = 29.376},
  {x = -1450.806, y = -236.949, z = 49.809}
}

Citizen.CreateThread(function()
 while true do
  Wait(0)
  local coords = GetEntityCoords(GetPlayerPed(-1))
  -- Outfit Saving
  for k,v in pairs(clothing_shops) do
   if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z-0.95, true) < 50) then
    if not v.hidden then
     DrawMarker(27, v.x, v.y, v.z-0.95, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 0, 255, 123, 200, 0, 0, 2, 0, 0, 0, 0)
    end
    if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z-0.95, true) < 1.5) then
      DrawText3Ds(v.x, v.y, v.z,'~g~[E]~w~ Outfits')
     if IsControlJustPressed(0, 38) then
      WarMenu.OpenMenu('outfits')
      TriggerServerEvent('outfits:getoutfits')
     end
    end
   end
  end
 end
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
 -- local factor = (string.len(text)) / 370
--DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end


Citizen.CreateThread(function()
 WarMenu.CreateMenu('outfits', 'Dressing Room')
 WarMenu.CreateMenu('change_outfit', 'Dressing Room')
 WarMenu.CreateMenu('share_outfit', 'Dressing Room')
 while true do
  Citizen.Wait(0)
  if WarMenu.IsMenuOpened('outfits') then
   if WarMenu.Button('Create Outfit') then
    SaveOutfit()
    WarMenu.CloseMenu('outfits')
   elseif WarMenu.Button('Delete Outfit') then
   	DeleteOutfit()
   	WarMenu.CloseMenu('outfits')
   elseif WarMenu.Button('Change Outfit') then
   	WarMenu.OpenMenu('change_outfit')
   elseif WarMenu.Button('Share Outfit') then 
    WarMenu.OpenMenu('share_outfit')
   end
   WarMenu.Display()
  elseif WarMenu.IsMenuOpened('change_outfit') then
   for _,v in pairs(outfits) do
    if WarMenu.Button(v.name) then
     TriggerEvent('clothes:load', json.decode(v.skin))
    end
   end
   WarMenu.Display()
  elseif WarMenu.IsMenuOpened('share_outfit') then
   for _,v in pairs(outfits) do
    if WarMenu.Button(v.name) then
     local id = GetResult()
     TriggerServerEvent('outfits:share', id, v.name, v.skin)
    end
   end
   WarMenu.Display()
  end
 end
end) 

function SaveOutfit()
  DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP9", "", "", "", "", "", 32)
  while (UpdateOnscreenKeyboard() == 0) do
    DisableAllControlActions(0);
    Wait(0);
  end
  if (GetOnscreenKeyboardResult()) then
   local result = GetOnscreenKeyboardResult()
   local clothing = exports['core']:GetClothes()
   TriggerServerEvent('outfits:saveskin', clothing, result)
  end
end

function DeleteOutfit()
  DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP9", "", "", "", "", "", 32)
  while (UpdateOnscreenKeyboard() == 0) do
    DisableAllControlActions(0);
    Wait(0);
  end
  if (GetOnscreenKeyboardResult()) then
   local result = GetOnscreenKeyboardResult()
   TriggerServerEvent('outfits:deleteoutfit', result)
  end
end

RegisterNetEvent('outfits:outfitlist')
AddEventHandler('outfits:outfitlist', function(listoutfits)
 outfits = {}
 outfits = listoutfits
end)

function GetResult()
 local amount = "xxsdrtghyuujhdjsjenenfjfjtjtjtj"
 showLoadingPrompt("Enter Player's ID", 3)
 DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 6)
  while (UpdateOnscreenKeyboard() == 0) do
    DisableAllControlActions(0);
    Wait(0);
  end
  if (GetOnscreenKeyboardResult()) then
    local option = GetOnscreenKeyboardResult()
    stopLoadingPrompt()
    if(option ~= nil and option ~= 0) then
     amount = ""..option
     if (amount ~= "xxsdrtghyuujhdjsjenenfjfjtjtjtj" and tonumber(amount) > 0) then
      return tonumber(amount)
     end
    end
  end
end

function showLoadingPrompt(showText, showType)
    Citizen.CreateThread(function()
        Citizen.Wait(0)
        N_0xaba17d7ce615adbf("STRING") -- set type
        AddTextComponentString(showText) -- sets the text
        N_0xbd12f8228410d9b4(showType) -- show promt (types = 3)
    end)
end

function stopLoadingPrompt()
    Citizen.CreateThread(function()
        Citizen.Wait(0)
        N_0x10d373323e5b9c0d()
    end)
end

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

RegisterNetEvent('outfit:set')
AddEventHandler('outfit:set', function(data)
	if data.model == 1885233650 or data.model == -1667301416 then
	 for i = 0, 11 do
	  if i ~= 0 and i ~= 2 then
	   SetPedComponentVariation(GetPlayerPed(-1), i, data.clothing.drawables[i+1], data.clothing.textures[i+1], data.clothing.palette[i+1])
	  end
	 end
	 for i = 0, 7 do
	  SetPedPropIndex(GetPlayerPed(-1), i, data.props.drawables[i+1], data.props.textures[i+1], false)
	 end
	else
	    setModel(data.model)
	    for i = 0, 11 do
	        SetPedComponentVariation(GetPlayerPed(-1), i, player_data.clothing.drawables[i+1], player_data.clothing.textures[i+1], player_data.clothing.palette[i+1])
	    end
	    for i = 0, 7 do
	        SetPedPropIndex(GetPlayerPed(-1), i, player_data.props.drawables[i+1], player_data.props.textures[i+1], false)
	    end
	end
end)