local hasLicense = false
local ownedWeapon = {}
local myCharacterID = 0
local currentStation = {}
local weapon_stores = {
  [1] = {name="Ammu-Nation", x=-662.180, y=-934.961, z=20.829, purchase = {x = -661.866, y = -933.391, z = 21.829}, price = 2500000},
  [2] = {name="Ammu-Nation", x=810.25, y=-2157.60, z=28.62, purchase = {x = 810.224, y = -2159.517, z = 29.619}, price = 2500000},
  [3] = {name="Ammu-Nation", x=1693.44, y=3760.16, z=33.71, purchase = {x = 1692.187, y = 3761.726, z = 34.705}, price = 2500000},
  [4] = {name="Ammu-Nation", x=-330.24, y=6083.88, z=30.45, purchase = {x = -332.033, y = 6085.001, z = 31.455}, price = 2500000},
  [5] = {name="Ammu-Nation", x=252.63, y=-50.00, z=68.94, purchase = {x = 254.242, y = -50.494, z = 69.941}, price = 2500000},
  [6] = {name="Ammu-Nation", x=22.09, y=-1107.28, z=28.80, purchase = {x = 22.980, y = -1105.402, z = 29.797}, price = 3500000}, -- Main Legion (3)
  [7] = {name="Ammu-Nation", x=2567.69, y=294.38, z=107.73, purchase = {x = 2567.809, y = 292.287, z = 108.735}, price = 2500000},
  [8] = {name="Ammu-Nation", x=-1117.58, y=2698.61, z=17.55, purchase = {x = -1118.923, y = 2700.076, z = 18.554}, price = 2500000},
  [9] = {name="Ammu-Nation", x=842.44, y=-1033.42, z=27.19, purchase = {x = 842.327, y = -1035.671, z = 28.195}, price = 2500000},
}

local weapons = {
  [1] = {name = 'Hammer', price = 45, amount = 1, id = 214, license = false}, 
  [3] = {name = 'Baseball Bat', price = 70, amount = 1, id = 215, license = false},
  [4] = {name = 'Fire Extinguisher', price = 110, amount = 1, id = 230, license = false},
  [5] = {name = 'Flashlight', price = 35, amount = 1, id = 197, license = false},
  [6] = {name = 'Brass Knuckles', price = 150, amount = 1, id = 202, license = false},
  [7] = {name = 'Knife', price = 90, amount = 1, id = 212, license = false},
  [8] = {name = 'SNS Pistol', price = 3000, amount = 1, id = 232, license = true},
  [9] = {name = 'Pistol', price = 1250, amount = 1, id = 186, license = true},
  [10] = {name = 'Combat Pistol', price = 1500, amount = 1, id = 187, license = true},
  [11] = {name = 'Binoculars', price = 250, amount = 1, id = 8, license = false},
  [11] = {name = 'Crowbar', price = 125, amount = 1, id = 217, license = false},
  [12] = {name = 'Ammo Box (50)', price = 100, amount = 1, id = 172, license = false},
}

--[[local weapons = {
 --[15] = {label = 'Baseball', name = 'WEAPON_BALL', price = 4.00, attachments = 0, ammo = 0},
 [1] = {label = 'Hammer', name = 'WEAPON_HAMMER', price = 25.00, id = 8, ammo = 0, license = false},
 [2] = {label = 'Crowbar', name = 'WEAPON_CROWBAR', price = 45.00, attachments = 0, ammo = 0, license = false},
 [3] = {label = 'Baseball Bat', name = 'WEAPON_BAT', price = 50.00, attachments = 0, ammo = 0, license = false},
 [4] = {label = 'Fire Extinguisher', name = 'WEAPON_FIREEXTINGUISHER', price = 45.00, attachments = 0, ammo = 5000, license = false},
 [5] = {label = 'Flashlight', name = 'WEAPON_FLASHLIGHT', price = 3.00, attachments = 0, ammo = 0, license = false},
 [6] = {label = 'Brass Knuckles', name = 'WEAPON_KNUCKLE', price = 25.00, attachments = 0, ammo = 0, license = false},
 [7] = {label = 'Knife', name = 'WEAPON_KNIFE', price = 150.00, attachments = 0, ammo = 0, license = false},
 [8] = {label = 'Switchblade', name = 'WEAPON_SWITCHBLADE', price = 125.00, attachments = 0, ammo = 0, license = false},
 [9] = {label = 'SNS Pistol', name = 'WEAPON_SNSPISTOL', price = 1000.0, attachments = 0, ammo = 150, license = true},
 [10] = {label = 'Pistol', name = 'WEAPON_PISTOL', price = 1200.00, attachments = 0, ammo = 150, license = true},
 [11] = {label = 'Combat Pistol', name = 'WEAPON_COMBATPISTOL', price = 1500.0, attachments = 0, ammo = 150, license = false},
 [13] = {label = 'Pipe Wrench', name = 'WEAPON_WRENCH', price = 20.0, attachments = 0, ammo = 0, license = false},
 [12] = {label = 'Tazer', name = 'WEAPON_STUNGUN', price = 500.0, attachments = 0, ammo = 0, license = false},
 --[13] = {label = 'Jerry Can', name = 'WEAPON_PETROLCAN', price = 200.0, attachments = 0, ammo = 0, license = false}
}]]--

--[[local weapons = {
  [1] = {name = 'Binoculars', price = 75, amount = 1, id = 8},

}]]--
local player_weapons = {}
local currentweapon = ''

Citizen.CreateThread(function()
 for k,v in ipairs(weapon_stores)do
  local blip = AddBlipForCoord(v.x, v.y, v.z)
  SetBlipSprite (blip, 110)
  SetBlipDisplay(blip, 4)
  SetBlipScale  (blip, 0.8)
  SetBlipColour (blip, 75)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(v.name)
  EndTextCommandSetBlipName(blip)
 end
 WarMenu.CreateLongMenu('weaponstore','Ammu Nation')
 while true do
  Wait(5)
  local coords = GetEntityCoords(GetPlayerPed(-1))
  for k,v in pairs(weapon_stores) do
   if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 50 then
    DrawMarker(27, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 226,49,49, 200, 0, 0, 2, 0, 0, 0, 0)
    if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.3 then
     drawTxt('~m~Press ~g~E~m~ To Shop For Weapons')
     if IsControlJustPressed(0, 38) then
      TriggerServerEvent('gun:checkLicense')
      WarMenu.OpenMenu('weaponstore')
     end
    else
      if WarMenu.IsMenuOpened('weaponstore') then
        WarMenu.CloseMenu('weaponstore')
      end
    end
   end
  end
  if WarMenu.IsMenuOpened('weaponstore') then
    for ind, v in pairs(weapons) do
     local price = math.floor(v.price*getVat(2))
     if not v.license then
       if WarMenu.Button(v.name, "~g~$"..price) then
        TriggerServerEvent('shops:purchase', v.name, price, v.amount, v.id)
        TriggerServerEvent('bank:intoSharedBank', v.price, 18)
       end
     elseif v.license and hasLicense then      
       if WarMenu.Button(v.name, "~g~$"..price) then
        TriggerServerEvent('shops:purchase', v.name, price, v.amount, v.id)
        TriggerServerEvent('bank:intoSharedBank', v.price, 18)
       end
     end
    end
    WarMenu.Display()
   end
  end
 end)

RegisterNetEvent("weapon:updateitems")
AddEventHandler("weapon:updateitems", function(inv)
    player_weapons = {}
    player_weapons = inv
end)

RegisterNetEvent("law:gunLicense")
AddEventHandler("law:gunLicense", function(status)
  hasLicense = status
end)

function getWeapons()
 return player_weapons
end


RegisterNetEvent('weaponstores:updateStations')
AddEventHandler('weaponstores:updateStations', function(owned, id)
 ownedWeapon = owned
 myCharacterID = id
end)




-- Item Stores 
local stores = {
  {name="Store", id=52, x=373.875, y=325.896, z=102.566},
  {name="Store", id=52, x=2557.458, y=382.282, z=107.622},
  {name="Store", id=52, x=547.431, y=2671.710, z=41.156},
  {name="Store", id=52, x=1961.464, y=3740.672, z=31.343},
  {name="Store", id=52, x=2678.916, y=3280.671, z=54.241},
  {name="Store", id=52, x=1729.216, y=6414.131, z=34.037},
  {name="Store", id=52, x=-1222.915, y=-906.983, z=11.326},
  {name="Store", id=52, x=-1487.553, y=-379.107, z=39.163},
  {name="Store", id=52, x=-2968.243, y=390.910, z=14.043},
  {name="Store", id=52, x=1166.024, y=2708.930, z=37.157},
  {name="Store", id=52, x=-48.519, y=-1757.514, z=28.421},
  {name="Store", id=52, x=1163.373, y=-323.801, z=68.205},
  {name="Store", id=52, x=-707.501, y=-914.260, z=18.215},
  {name="Store", id=52, x=-1820.523, y=792.518, z=137.118},
  {name="Store", id=52, x=1698.388, y=4924.404, z=41.063},
  {name="Store", id=52, x=1135.808, y=-982.281, z=45.415},
  {name="Store", id=52, x=26.251, y=-1347.580, z=28.507}
}

 -- Club Bars
local bars = {
  {name="Bar", id=52, x=-1393.511, y=-606.624, z=30.320-0.95},
  {name="Bar", id=52, x=127.560, y=-1285.102, z=29.281-0.95},
  {name="Bar", id=52, x=-559.658, y=286.457, z=82.176-0.95},
}

local pharshop = {
  {name="Bar", id=52, x=214.535, y=-1834.250, z=27.478-0.95},
  {name="Bar", id=52, x=84.412, y=-809.417, z=31.409-0.95},
  {name="Bar", id=52, x=114.910, y=-6.059, z=67.808-0.95},
  {name="Bar", id=52, x=150.360, y=6647.397, z=31.605-0.95},
  {name="Bar", id=52, x=1815.582, y=3679.365, z=34.276-0.95},
}

local pet = {
  {name="Petshop", id = 52,x=562.266,y=2741.401,z=42.869-0.95},
}

local race = {
  {name="Race Tokens", id = 52,x = -1673.699, y = -224.295, z = 55.100-0.95},
}

local items = {
 [1] = {name = 'Binoculars', price = 75, amount = 1, id = 8},
 [2] = {name = 'Umbrella', price = 45, amount = 1, id = 12},
 [3] = {name = 'Cigarette', price = 2, amount = 2, id = 15},
 [4] = {name = 'Rolling Papers', price = 2, amount = 1, id = 160},
 [5] = {name = 'Jerry Can', price = 500, amount = 1, id = 205},
 [7] = {name = 'Mobile Phone', price = 500, amount = 1, id = 104},
 [8] = {name = 'Radio', price = 250, amount = 1, id = 261},
 [9] = {name = 'GoPro', price = 10000, amount = 1, id = 300},
 [10] = {name = 'Bottle of Water', price = 8, amount = 1, id = 13},
 [11] = {name = 'Cheese Burger', price = 16, amount = 1, id = 14},
}

local toolshop = {
 [1] = {name = 'Storage Box', price = 20000, amount = 1, id = 2},
 [2] = {name = 'Bunson Burner', price = 250, amount = 1, id = 47},
 [3] = {name = 'Chemistry Set', price = 500, amount = 1, id = 48},
 [4] = {name = 'Fertilizer', price = 25, amount = 1, id = 16},
 [5] = {name = 'Digital Scales', price = 300, amount = 1, id = 113},
 [6] = {name = 'Bundle of Baggies', price = 4, amount = 1, id = 119},
 [7] = {name = 'Shrink Wrap', price = 5, amount = 1, id = 136},
 [8] = {name = 'Smelly Proof Baggie', price = 4, amount = 1, id = 137},
 [9] = {name = 'Oxygen Gear', price = 1250, amount = 1, id = 41},
 [10] = {name = 'Tape', price = 10, amount = 1, id = 46},
 [11] = {name = 'Lockpick', price = 450, amount = 1, id = 7},
 [12] = {name = 'Rubber Bands', price = 10, amount = 1, id = 155},
 --[12] = {name = 'Weapon Box', price = 25000, amount = 1, id = 86},
 [13] = {name = 'Large Storage Box', price = 40000, amount = 1, id = 85},
 [14] = {name = 'Box of Matches', price = 5, amount = 1, id = 88},
 [15] = {name = 'Cable Cutters', price = 100, amount = 1, id = 75},
 [16] = {name = 'Fishing Rod', price = 500, amount = 1, id = 288},
 [17] = {name = 'Fishing Bait x30', price = 15, amount = 30, id = 289},
 [18] = {name = 'Electrical Wire', price = 100, amount = 1, id = 55},
 [19] = {name = 'Cleaning Kit x5', price = 400, amount = 5, id = 11},
 }
 
local pharmacy = {
 [1] = {name = 'First Aid Kit', price = 100, amount = 1, id = 144},
 [2] = {name = 'The Human Fixkit', price = 450, amount = 1, id = 73},
 [3] = {name = 'Emergency Medkit', price = 1000, amount = 1, id = 145},
 [4] = {name = 'Painkillers', price = 10, amount = 1, id = 147},
 [5] = {name = 'Strong Painkillers', price = 30, amount = 1, id = 148},
 [6] = {name = 'Morphine', price = 50, amount = 1, id = 149},
 [7] = {name = 'Bandage', price = 25, amount = 1, id = 10},
 [8] = {name = 'Bandage & Gauze', price = 75, amount = 1, id = 150},
 [9] = {name = 'Cough Medicine', price = 15, amount = 1, id = 44},
}

local barshop = {
 [1] = {name = 'Beer', price = 5, amount = 1, id = 22},
 [2] = {name = 'Bourbon', price = 8, amount = 1, id = 23},
 [3] = {name = 'Scotch', price = 8, amount = 1, id = 24},
 [4] = {name = 'Wine', price = 9, amount = 1, id = 25},
 [5] = {name = 'Tequila', price = 5, amount = 1, id = 27},
 [6] = {name = 'Vodka', price = 7, amount = 1, id = 28},
}

local petshop = {
  [1] = {name = 'Pet', price = 10000, amount = 1, id = 278},
}
local raceshop = {
  [1] = {name = 'Timetrials Tokens', price = 1000, amount = 3, id = 281},
}
 
 

local nearObject = false 
local isNearObject = false
local objectLoc = {}
local clostestProp = nil
local models = {
  [1] = 690372739,
  [2] = 1114264700,
  [3] = 992069095,
}

local vendingshop = {
 [2] = {name = 'Redbull', price = 5, amount = 1, id = 26},
}

Citizen.CreateThread(function()
 for k,v in ipairs(stores)do
  local blip = AddBlipForCoord(v.x, v.y, v.z)
  SetBlipSprite (blip, v.id)
  SetBlipDisplay(blip, 4)
  SetBlipScale  (blip, 0.8)
  SetBlipColour (blip, 2)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(v.name)
  EndTextCommandSetBlipName(blip)
 end
 WarMenu.CreateLongMenu('store', 'Store')
 while true do
  Wait(5)
  local coords = GetEntityCoords(GetPlayerPed(-1))
  for k,v in pairs(stores) do
   if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 50 then
    DrawMarker(27, v.x, v.y, v.z+0.10, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 255, 255, 0, 100, 0, 0, 2, 0, 0, 0, 0)
    if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2 then
      DrawText3Ds(v.x, v.y, v.z+0.5,'~g~[E]~w~ Shop For Items')
     if IsControlJustPressed(0, 38) then
      WarMenu.OpenMenu('store')
     end
    else
      if WarMenu.IsMenuOpened('store') then
        WarMenu.CloseMenu('store')
      end
    end
   end
  end
  if WarMenu.IsMenuOpened('store') then
   for ind, v in pairs(items) do
    local price = math.floor(v.price*getVat(2))
    if WarMenu.Button(v.name, "~g~$"..price) then
     TriggerServerEvent('shops:purchase', v.name, price, v.amount, v.id)
     TriggerServerEvent('bank:intoSharedBank', v.price, 12)
    end
   end
   WarMenu.Display()
  end
 end
end)

Citizen.CreateThread(function()
   local blip = AddBlipForCoord(2747.885, 3484.236, 55.671)
   SetBlipSprite (blip, 446)
   SetBlipDisplay(blip, 4)
   SetBlipScale (blip, 0.8)
   SetBlipColour (blip, 64)
   SetBlipAsShortRange(blip, true)
   BeginTextCommandSetBlipName("STRING")
   AddTextComponentString('Tool Store')
   EndTextCommandSetBlipName(blip)
  WarMenu.CreateLongMenu('tools', 'Tool Store')
  while true do
   Wait(5)
   local coords = GetEntityCoords(GetPlayerPed(-1))
   local inveh = IsPedInAnyVehicle(GetPlayerPed(-1), false)

    if GetDistanceBetweenCoords(coords, 2747.885, 3484.236, 55.671, true) < 50 and not inveh then
     DrawMarker(27, 2747.885, 3484.236, 55.671-0.95, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 255, 255, 0, 100, 0, 0, 2, 0, 0, 0, 0)
     if GetDistanceBetweenCoords(coords, 2747.885, 3484.236, 55.671, true) < 1.2 then
      DrawText3Ds(2747.885, 3484.236, 55.671, '~g~[E]~w~ Browse Goods')
      if IsControlJustPressed(0, 38) then
       WarMenu.OpenMenu('tools')
      end
    else
      if WarMenu.IsMenuOpened('tools') then
        WarMenu.CloseMenu('tools')
      end
     end
    end
   if WarMenu.IsMenuOpened('tools') then
    for ind, v in pairs(toolshop) do
     local price = math.floor(v.price*getVat(2))
     if WarMenu.Button(v.name, "~g~$"..price) then
      TriggerServerEvent('shops:purchase', v.name, price, v.amount, v.id)
      TriggerServerEvent('bank:intoSharedBank', v.price, 16)
     end
    end
    WarMenu.Display()
   end
  end
 end)

Citizen.CreateThread(function()
 for k,v in pairs(pharshop) do
  local blip = AddBlipForCoord(v.x, v.y, v.z)
  SetBlipSprite (blip, 51)
  SetBlipDisplay(blip, 4)
  SetBlipScale (blip, 0.8)
  SetBlipColour (blip, 1)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Pharmacy')
  EndTextCommandSetBlipName(blip)
 end
 WarMenu.CreateLongMenu('Pharmacy', 'Pharmacy')
 while true do
  Wait(5)
  local coords = GetEntityCoords(GetPlayerPed(-1))
  for k,v in pairs(pharshop) do
   if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 50 then
    DrawMarker(27, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 255, 255, 0, 100, 0, 0, 2, 0, 0, 0, 0)
    if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2 then
      DrawText3Ds(v.x, v.y, v.z+0.5,'~g~[E]~w~ Pharmacy')
     if IsControlJustPressed(0, 38) then
      WarMenu.OpenMenu('Pharmacy')
     end
    else
      if WarMenu.IsMenuOpened('Pharmacy') then
        WarMenu.CloseMenu('Pharmacy')
      end
    end
   end
  end
  if WarMenu.IsMenuOpened('Pharmacy') then
   for ind, v in pairs(pharmacy) do
    local price = math.floor(v.price*getVat(2))
    if WarMenu.Button(v.name, "~g~$"..price) then
     TriggerServerEvent('shops:purchase', v.name, price, v.amount, v.id)
     TriggerServerEvent('bank:intoSharedBank', v.price, 14)
    end
   end
   WarMenu.Display()
  end
 end
end)

Citizen.CreateThread(function()
 WarMenu.CreateLongMenu('Bar', 'Bar')
 while true do
  Wait(5)
  local coords = GetEntityCoords(GetPlayerPed(-1))
  for k,v in pairs(bars) do
   if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 50 then
    DrawMarker(27, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 255, 255, 0, 100, 0, 0, 2, 0, 0, 0, 0)
    if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2 then
      DrawText3Ds(v.x, v.y, v.z+0.5,'~g~[E]~w~ Bar')
     if IsControlJustPressed(0, 38) then
      WarMenu.OpenMenu('Bar')
     end
    else
      if WarMenu.IsMenuOpened('Bar') then
        WarMenu.CloseMenu('Bar')
      end
    end
   end
  end
  if WarMenu.IsMenuOpened('Bar') then
   for ind, v in pairs(barshop) do
    local price = math.floor(v.price*getVat(2))
    if WarMenu.Button(v.name, "~g~$"..price) then
     TriggerServerEvent('shops:purchase', v.name, price, v.amount, v.id)
     TriggerServerEvent('bank:intoSharedBank', v.price, 15)
    end
   end
   WarMenu.Display()
  end
 end
end)
--[[
Citizen.CreateThread(function()
 WarMenu.CreateLongMenu('Petshop', 'Petshop')
 while true do
  Wait(5)
  local coords = GetEntityCoords(GetPlayerPed(-1))
  for k,v in pairs(pet) do
   if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 50 then
    DrawMarker(27, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 255, 255, 0, 100, 0, 0, 2, 0, 0, 0, 0)
    if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2 then
      DrawText3Ds(v.x, v.y, v.z+0.5,'~g~[E]~w~ Petshop')
     if IsControlJustPressed(0, 38) then
      WarMenu.OpenMenu('Petshop')
     end
    else
      if WarMenu.IsMenuOpened('Petshop') then
        WarMenu.CloseMenu('Petshop')
      end
    end
   end
  end
  if WarMenu.IsMenuOpened('Petshop') then
   for ind, v in pairs(petshop) do
    local price = math.floor(v.price*getVat(2))
    if WarMenu.Button(v.name, "~g~$"..price) then
     TriggerServerEvent('shops:purchase', v.name, price, v.amount, v.id)
     TriggerServerEvent('bank:intoSharedBank', v.price, 19)
    end
   end
   WarMenu.Display()
  end
 end
end)
--]]
Citizen.CreateThread(function()
 WarMenu.CreateLongMenu('Token Seller', 'Token Seller')
 while true do
  Wait(5)
  local coords = GetEntityCoords(GetPlayerPed(-1))
  for k,v in pairs(race) do
   if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 50 then
    DrawMarker(27, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 255, 255, 0, 100, 0, 0, 2, 0, 0, 0, 0)
    if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2 then
      DrawText3Ds(v.x, v.y, v.z+0.8,'~g~[E]~w~ Token Seller')
     if IsControlJustPressed(0, 38) then
      WarMenu.OpenMenu('Token Seller')
     end
    else
      if WarMenu.IsMenuOpened('Token Seller') then
        WarMenu.CloseMenu('Token Seller')
      end
    end
   end
  end
  if WarMenu.IsMenuOpened('Token Seller') then
   for ind, v in pairs(raceshop) do
    local price = math.floor(v.price*getVat(2))
    if WarMenu.Button(v.name, "~g~$"..price) then
     TriggerServerEvent('shops:purchase', v.name, price, v.amount, v.id)
     TriggerServerEvent('bank:intoSharedBank', v.price, 20)
    end
   end
   WarMenu.Display()
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