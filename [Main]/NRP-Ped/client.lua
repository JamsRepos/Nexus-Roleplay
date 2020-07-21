-- Blips 
local blips = {
	{title="Court House", colour=38, id=181, x=233.205, y=-410.576, z=48.117},
	{title="City Hall", colour=38, id=181, x=-549.870, y=-195.710, z=38.223},
	{title="Job Center", colour=18, id=408, x=-265.036, y=-963.630, z=30.223},
  {title="Hospital", colour=69, id=80, x=296.674, y=-583.476, z=43.137},
  {title="Gym", colour=39, id=311,  x= -1201.973, y= -1567.054, z= 4.611},
  {title="Train Station", colour=47, id=280, x = -216.964, y = -1038.245, z = 30.144},
  {title="Train Station", colour=47, id=280, x = -487.521, y = 5260.139, z = 87.011},
  {title="Train Station", colour=47, id=280, x = 2620.431, y = 2930.545, z = 40.423},
  --{title="Burger Shot", colour=49, id=106, x=-1193.290, y = -892.294, z = 13.995},
  {title="Hotel Block", colour=17, id=350, x = -91.151, y = 6327.072, z = 31.490},
  {title="Hotel Block", colour=17, id=350, x = 325.925, y = -212.534, z = 54.081},
  {title="Hotel Block", colour=17, id=350, x = 566.496, y = -1762.757, z = 29.169},
  {title="Hotel Block", colour=17, id=350, x = -122.595, y = -1468.578, z = 34.213},
  {title="Hotel Block", colour=17, id=350, x = 360.585, y = 2636.218, z = 44.495},
  --{title="Repairs R Us", colour=39, id=446, x = 542.170, y = -183.313, z = 54.496},
  {title="Car Detailer", colour=77, id=100, x = 25.170, y = -1392.031, z = 29.334},
  {title="Car Detailer", colour=77, id=100, x = 171.670, y = -1717.579, z = 29.292},
  {title="Car Detailer", colour=77, id=100, x = 1780.510, y = 3328.615, z = 41.253},
  {title="Drive-Thru", colour=81, id=206, x = 152.607, y = 6504.867, z = 31.669},
  {title="Drive-Thru", colour=81, id=206, x = 97.758, y = 283.796, z = 109.300},
  {title="Drive-Thru", colour=81, id=206, x = 144.499, y = -1461.527, z = 29.142},
  --{title="Drive-Thru", colour=81, id=206, x = 145.572, y = -1460.359, z = 29.142}},
  {title="Vanilla Unicorn", colour=64, id=93, x = 130.070, y = -1300.662, z = 29.233},
  {title="Vangellico", colour=26, id=178, x = -621.978, y = -230.748, z = 38.057},
  {title="Time Trial", colour=46, id=127, x = -1659.968, y =-228.013, z = 54.972},
  {title="Mission Row", colour=77, id=60, x = 443.106, y = -997.062, z = 43.591},
  {title="Sandy Shores", colour=77, id=60, x = 1853.040, y = 3686.867, z = 34.267},
  {title="Paleto Bay", colour=77, id=60, x = -446.265, y = 6012.102, z = 31.716},
  {title="Weed Farm", colour=2, id=140, x = 2224.324, y = 5577.014, z = 53.852},
  {title="Growery", colour=47, id=140, x = 346.615, y = 3405.761, z = 36.656},
}

Citizen.CreateThread(function()
    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.8)
      if info.id == 60 or info.id == 181 then 
        SetBlipScale(info.blip, 1.0)
      end
      if info.colour ~= 0 then SetBlipColour(info.blip, info.colour) end
      SetBlipAsShortRange(info.blip, true)
	    BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)

------------------------------------------------------
---------------------- Shuffling -------------------
------------------------------------------------------

-- optimizations
local tonumber            = tonumber
local unpack              = table.unpack
local CreateThread        = Citizen.CreateThread
local Wait                = Citizen.Wait
local TriggerEvent        = TriggerEvent
local RegisterCommand     = RegisterCommand
local PlayerPedId         = PlayerPedId
local IsPedInAnyVehicle   = IsPedInAnyVehicle
local GetPedInVehicleSeat = GetPedInVehicleSeat
local GetVehiclePedIsIn   = GetVehiclePedIsIn
local GetIsTaskActive     = GetIsTaskActive
local SetPedIntoVehicle   = SetPedIntoVehicle
local disabled            = false

CreateThread(function()
    while true do
        Wait(0)
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped, false) and not disabled then
            local veh = GetVehiclePedIsIn(ped, false)
            if GetPedInVehicleSeat(veh, 0) == ped then
                if not GetIsTaskActive(ped, 164) and GetIsTaskActive(ped, 165) then
                    SetPedIntoVehicle(PlayerPedId(), veh, 0)
                end
            end
        end
    end
end)

RegisterCommand("seat", function(_, args)
    local seatIndex = unpack(args)
    seatIndex       = tonumber(seatIndex) - 2

    if seatIndex < -2 or seatIndex >= 3 then
        SetNotificationTextEntry('STRING')
        AddTextComponentString("~r~Seat ~b~" .. (seatIndex + 2) .. "~r~ is not recognized")
        DrawNotification(true, true)
    else
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, false)

        if veh ~= nil and veh > 0 then
            CreateThread(function()
                disabled = true
                SetPedIntoVehicle(PlayerPedId(), veh, seatIndex)
                Wait(50)
                disabled = false
            end)
        end
    end
end)

RegisterCommand("shuff", function()
    CreateThread(function()
        disabled = true
        Wait(3000)
        disabled = false
    end)
end)

TriggerEvent('chat:addSuggestion', '/shuff', 'Switch seats in the current vehicle')
TriggerEvent('chat:addSuggestion', '/seat', 'Switch seats in the current vehicle',
             { { name = 'seat', help = "Switch seats in the current vehicle. 1 = driver, 2 = passenger, 3-4 = back seats" } })


------------------------------------------------------
---------------------- Tackling -------------------
------------------------------------------------------

local isTackling = false
local isGettingTackled = false
local lastTackleTime = 0
local isRagdoll = false
local tackleLib = 'missmic2ig_11'
local tackleAnim = 'mic_2_ig_11_intro_goon'
local tackleVictimAnim = 'mic_2_ig_11_intro_p_one'


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		if isRagdoll then
			SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
		end
	end
end)

RegisterNetEvent('tackle:getTackled')
AddEventHandler('tackle:getTackled', function(target)
	isGettingTackled = true

	local playerPed = GetPlayerPed(-1)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))

	RequestAnimDict(tackleLib)

	while not HasAnimDictLoaded(tackleLib) do
		Citizen.Wait(10)
	end

	AttachEntityToEntity(GetPlayerPed(-1), targetPed, 11816, 0.25, 0.5, 0.0, 0.5, 0.5, 180.0, false, false, false, false, 2, false)
	TaskPlayAnim(playerPed, tackleLib, tackleVictimAnim, 8.0, -8.0, 3000, 0, 0, false, false, false)

	Citizen.Wait(3000)
	DetachEntity(GetPlayerPed(-1), true, false)

	isRagdoll = true
	Citizen.Wait(3000)
	isRagdoll = false

	isGettingTackled = false
end)

RegisterNetEvent('tackle:playTackle')
AddEventHandler('tackle:playTackle', function()
	local playerPed = GetPlayerPed(-1)

	RequestAnimDict(tackleLib)

	while not HasAnimDictLoaded(tackleLib) do
		Citizen.Wait(10)
	end

	TaskPlayAnim(playerPed, tackleLib, tackleAnim, 8.0, -8.0, 3000, 0, 0, false, false, false)

	Citizen.Wait(3000)

	isTackling = false

end)

Citizen.CreateThread(function()
	while true do
		Wait(0)

		if IsPedRunning(GetPlayerPed(-1)) and IsControlPressed(0, 45) and not isTackling and GetGameTimer() - lastTackleTime > 10 * 1000 then
			Citizen.Wait(10)
			local closestPlayer, distance = GetClosestPlayer();

			if distance ~= -1 and distance <= 3.0 and not isTackling and not isGettingTackled and not IsPedInAnyVehicle(GetPlayerPed(-1)) and not IsPedInAnyVehicle(GetPlayerPed(closestPlayer)) then
				isTackling = true
				lastTackleTime = GetGameTimer()

				TriggerServerEvent('tackle:tryTackle', GetPlayerServerId(closestPlayer))
			end
		end
	end
end)

RegisterNetEvent('power:toggletackle')
AddEventHandler('power:toggletackle', function(target)
  if not IsPedInAnyVehicle(GetPlayerPed(-1)) then
    SetPedToRagdoll(GetPlayerPed(-1), 2000, 2000, 0, 0, 0, 0)
  end
end)
 
function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)
    
    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = Vdist(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"])
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    
    return closestPlayer, closestDistance
end

function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end


------------------------------------------------------
---------------------- Searching Cars ----------------
------------------------------------------------------
local searched = {}
local lockpicked = false

Citizen.CreateThread(function()
 while true do
  local ped = GetPlayerPed(-1)
  local vehicle = GetVehiclePedIsIn(ped, false)
  Citizen.Wait(5)
  if IsPedInAnyVehicle(ped, false) then
   local plate = GetVehicleNumberPlateText(vehicle)
   if IsControlJustPressed(0, 246) and not Searched(plate) and not exports["onyxLocksystem"]:hasKeys(plate) then 
      TriggerEvent("mythic_progbar:client:progress", {
        name = "searching_vehicle3",
        duration = 3750,
        label = "Searching Vehicle",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
    }, function(status)
        if not status then
          getRandomReward(plate)
        end
    end)
   end
  end
 end
end)

function Searched(plate)
 for _,v in pairs(searched) do 
  if v.plate == plate then 
   return true
  end
 end
end

function getRandomReward(plate)
 local random = math.random(1,7)
 if random == 1 then  
  exports['NRP-notify']:DoHudText('inform', 'You Found Nothing')
 elseif random == 2 then 
  exports['NRP-notify']:DoHudText('inform', 'You Found 2 Cheese Burgers & 2 Bottles Of Water')
  TriggerEvent("inventory:addQty", 14, 2)
  TriggerEvent("inventory:addQty", 13, 2)
 elseif random == 3 then 
  local money = math.random(10,25)
  exports['NRP-notify']:DoHudText('inform', 'You Found $'..money..' In The Glove Box')
  TriggerServerEvent('jobs:paytheplayer', money, 'Vehicle Theft: Glovebox')
 elseif random == 4 then
  exports['NRP-notify']:DoHudText('inform', 'You Found A Mouldy Cheeseburger')
 elseif random == 5 then
  exports['NRP-notify']:DoHudText('inform', 'You Found A Calculator')
  TriggerEvent("inventory:addQty", 275, 1)
 elseif random == 6 then 
  exports['NRP-notify']:DoHudText('inform', 'You Found 2 Cans Of Redbull')
  TriggerEvent("inventory:addQty", 26, 2)
 elseif random == 7 then
  exports['NRP-notify']:DoHudText('inform', 'You Found An Umbrella')
  TriggerEvent("inventory:addQty", 12, 1)
 end
 table.insert(searched, {plate = plate, player = PlayerId()})
end

--========================================================================================--
--================================== No Car Spawns ========================================--
--========================================================================================--
local rempoints = {
  {x = -326.891, y = -137.737, z = 39.010, radius = 50.0}, -- legion
  {x = 405.144, y = -852.109, z = 29.341, radius = 50.0}, -- legion
  {x = 981.376, y = -3169.650, z = 5.901, radius = 200.0}, -- Go Karting
  {x = 152.846, y = -1004.446, z = -99.000, radius = 10.0, peds = true}, -- Motel Interior
  {x = -34.419, y = -1101.921, z = 26.422, radius = 5.0}, -- PDM
}

Citizen.CreateThread(function()
  while true do
    Wait(1000)
    for _,v in pairs(rempoints) do
     if not v.peds then
      ClearAreaOfVehicles(v.x, v.y, v.z, v.radius, 0, 0, 0, 0, 0)
     end
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    Wait(10)
    for _,v in pairs(rempoints) do
     if v.peds then
      ClearAreaOfPeds(v.x, v.y, v.z, v.radius, 0, 0, 0, 0, 0)
     end
    end
  end
end)


local nearObject = false 
local isNearObject = false
local objectLoc1 = {}
local clostestProp = nil
local searchedTrash = {}
local models = {
  [1] = 1437508529,
  [2] = 1329570871,
  [3] = 1143474856,
  [4] = -468629664,
  [5] = -130812911,
  [6] = -93819890,
  [7] = -1426008804,
  [8] = -1830793175
}

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(1500)
  nearObject = false
  isNearObject = false
  local myCoords = GetEntityCoords(GetPlayerPed(-1))
   
  for i = 1, #models do
   clostestProp = GetClosestObjectOfType(myCoords.x, myCoords.y, myCoords.z, 2.5, models[i], false, false)
   if clostestProp ~= nil and clostestProp ~= 0 then
    local coords = GetEntityCoords(clostestProp)
    isNearObject = true
    objectLoc1 = {['x'] = coords.x, ['y'] = coords.y, ['z'] = coords.z + 1.2}
    break
   end
  end
 end
end)

Citizen.CreateThread(function()
 --WarMenu.CreateMenu('trash', 'Trash Can')
 while true do
  Wait(5)
  if isNearObject then 
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), objectLoc1.x, objectLoc1.y, objectLoc1.z, true) < 1.2) then
    DrawText3Ds(objectLoc1.x, objectLoc1.y, objectLoc1.z,'~g~[E] ~w~Trash Can')
    if IsControlJustPressed(0, 38) then
      TriggerEvent("inventory:openTrash")
      -- WarMenu.OpenMenu('trash')
    elseif IsControlJustPressed(0, 246) and not SearchedTrash(clostestProp) then
      TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_BUM_BIN", 0, true)
      TriggerEvent("mythic_progbar:client:progress", {
        name = "searching_vehicle3",
        duration = 3750,
        label = "Searching Vehicle",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
    }, function(status)
        if not status then
          ClearPedTasksImmediately(GetPlayerPed(-1))
          getRandomTrashReward(clostestProp)
        end
    end)
    end
   end
  end
  if WarMenu.IsMenuOpened('trash') then
   local inventory = exports['core']:getInventory()
   for i = 1,#inventory do
    if (inventory[i].q > 0) then
     if WarMenu.Button(tostring(inventory[i].name), tonumber(inventory[i].q)) then
      TrashItem(inventory[i].id, inventory[i].name, inventory[i].q) 
     end
    end
   end
   WarMenu.Display()
  end
 end
end)

function TrashItem(item, name, quantity)
 local amount = "xxsdrtghyuujhdjsjenenfjfjtjtjtj"
 if(amount == "xxsdrtghyuujhdjsjenenfjfjtjtjtj") then
  showLoadingPrompt("Enter Quantity", 3)
  DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8S", "", "", "", "", "", 20)
  while (UpdateOnscreenKeyboard() == 0) do
   DisableAllControlActions(0);
   Wait(0);
  end
  if (GetOnscreenKeyboardResult()) then
   local option = tonumber(GetOnscreenKeyboardResult())
   if(option ~= nil and option ~= 0) then
    amount = ""..option
   end
  end
 end
 stopLoadingPrompt()
 if (amount ~= "xxsdrtghyuujhdjsjenenfjfjtjtjtj" and tonumber(amount) > 0) then
  TriggerServerEvent('trash:additems', item, amount)
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

function getRandomTrashReward(id)
 local random = math.random(1,8)
 if random == 1 then 
  exports['NRP-notify']:DoHudText('inform', 'You Found Nothing')
 elseif random == 2 then 
  exports['NRP-notify']:DoHudText('inform', 'You Found A Mouldy Cheese Burger')
  TriggerEvent("inventory:addQty", 13, 1)
 elseif random == 3 then 
  local money = math.random(1,12)
  exports['NRP-notify']:DoHudText('inform', 'You Found $ '..money..' In A Burgershot Bag')
  TriggerServerEvent('jobs:paytheplayer', money, 'Trash: Burgershot Bag')
 elseif random == 4 then
  exports['NRP-notify']:DoHudText('inform', 'You Found A Stale Garlic Bread')
 elseif random == 5 then
  exports['NRP-notify']:DoHudText('inform', 'You Found A Moldy Kebab')
 elseif random == 6 then 
  exports['NRP-notify']:DoHudText('inform', 'You Found 2 Cans Of Redbull')
  TriggerEvent("inventory:addQty", 26, 2)
 elseif random == 7 then
  exports['NRP-notify']:DoHudText('inform', 'You Found An Umbrella')
  TriggerEvent("inventory:addQty", 12, 1)
 elseif random == 8 then
  exports['NRP-notify']:DoHudText('inform', 'You Found 2 Water Bottles With Slightly Greasy Caps')
  TriggerEvent("inventory:addQty", 14, 2)
 elseif random == 9 then
  if math.random(1,2) == 2 then
    exports['NRP-notify']:DoHudText('inform', 'You Found An Illegal Pistol Casing')
    TriggerEvent("inventory:addQty", 115, 1)
  else
    exports['NRP-notify']:DoHudText('inform', 'You Found Nothing')
  end
 end
 if math.random(1,3) > 2 then 
  exports['NRP-notify']:DoHudText('inform', 'You Found A Plastic Bottle')
  TriggerEvent("inventory:addQty", 81, 1)
 else
  exports['NRP-notify']:DoHudText('inform', 'You Found A Metal Can')
  TriggerEvent("inventory:addQty", 82, 1)
 end
 table.insert(searchedTrash, {id = id, player = PlayerId()})
end

function SearchedTrash(id)
 for _,v in pairs(searchedTrash) do 
  if v.id == id then 
   return true
  end
 end
end

---------Vending Machines-----------

local nearObject = false 
local isNearObject = false
local objectLo = {}
local clostestProp = nil
local label = "Coffee"
local models = {
  [1] = 690372739,  
}

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(1500)
  nearObject = false
  isNearObject = false
  local myCoords = GetEntityCoords(GetPlayerPed(-1))
   
  for i = 1, #models do
   clostestProp = GetClosestObjectOfType(myCoords.x, myCoords.y, myCoords.z, 2.5, models[i], false, false)
   if clostestProp ~= nil and clostestProp ~= 0 then
    local coords = GetEntityCoords(clostestProp)
    isNearObject = true
    objectLo = {['x'] = coords.x, ['y'] = coords.y, ['z'] = coords.z + 1.2}
    break
   end
  end
 end
end)

Citizen.CreateThread(function()
 while true do
  Wait(5)
  if isNearObject then 
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), objectLo.x, objectLo.y, objectLo.z-0.5, true) < 1.3) then
    DrawText3Ds(objectLo.x, objectLo.y, objectLo.z-0.20,'~g~[E]~w~ Buy Coffee ~g~$6') 
	if IsControlJustPressed(0, 38) then
	  TaskStartScenarioInPlace(GetPlayerPed(-1), 'PROP_HUMAN_ATM', false, true) Wait(3000) ClearPedTasksImmediately(GetPlayerPed(-1))
      TriggerServerEvent('shops:purchase', label, 6, 1, 257)
    end
   end ---- add shared banking to vending machines then somecan buy them
   end
 end
end)

--========================================================================================--
--================================== Progress Bar ========================================--
--========================================================================================--
-- Default Progress Duration = 20, During Trigging Progress Bar, Wait 3750 Then Trigger The Event
local progress_time = 0.20
local progress_bar = false
local progress_bar_duration = 20
local progress_bar_text = ''

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(progress_bar_duration)
  if(progress_time > 0)then
   progress_time = progress_time - 0.002
  end
 end
end)

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(1)
  if progress_bar then 
   DrawRect(0.50, 0.90, 0.20, 0.05, 0, 0, 0, 100)
   drawUI(0.910, 1.375, 1.0, 1.0, 0.55, progress_bar_text,135, 135, 135, 255, false)
   if progress_time > 0 then
    DrawRect(0.50, 0.90, 0.20-progress_time, 0.05, 255, 255, 0, 225)
   elseif progress_time < 1 and progress_bar then 
    progress_bar = false
   end
  end
 end
end)

local inTrain = false
local trainstations = {
  ['Innocence Blvd | LS'] = {x = -540.505, y = -1278.430, z = 26.901, price = 23, name = 'Innocence Blvd'},
  ['Strawberry Ave | LS'] = {x = 278.274, y = -1201.312, z = 38.899, price = 25, name = 'Strawberry Ave'},
  ['Alta Street | LS'] = {x = -216.964, y = -1038.245, z = 30.144, price = 23, name = 'Alta Street'},
  ['Davis Quartz | Sandy'] = {x = 2620.431, y = 2930.545, z = 40.423, price = 27, name = 'Davis Quartz'},
  ['LSIA | LS'] = {x = -1083.957, y = -2709.498, z = -7.410, price = 24, name = 'LSIA'},
  ['LSIA 2 | LS'] = {x = -884.825, y = -2313.427, z = -11.733, price = 22, name = 'LSIA 2'},
  ['San Vitus Blvd | LS'] = {x = -819.573, y = -134.744, z = 19.950, price = 26, name = 'San Vitus Blvd'},
  ['South Boulevard | LS'] = {x = -1356.867, y = -463.774, z = 15.045, price = 20, name = 'South Boulevard'},
  ['San Andreas Ave | LS'] = {x = -500.879, y = -668.453, z = 11.809, price = 22, name = 'San Andreas Ave'},
  ['Lumber Yard | Paleto'] = {x = -487.521, y = 5260.139, z = 87.011, price = 23, name = 'Lumber Yard'},
 }

Citizen.CreateThread(function()
  WarMenu.CreateMenu('trainmenu', 'Train Stations')
 while true do
  Wait(1)
 for k,v in pairs(trainstations) do
  if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 30) then
   DrawMarker(27, v.x, v.y, v.z-0.99, 0, 0, 0, 0, 0, 0, 1.2,1.2,1.0, 255,100,1, 200, 0, 0, 2, 0, 0, 0, 0)
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 1.2) and not inTrain then
    DrawText3Ds(v.x, v.y, v.z,"~g~[E]~w~ View Trains")
    if IsControlPressed(0, 38) then
     WarMenu.OpenMenu('trainmenu')
    end
   end 
   if WarMenu.IsMenuOpened('trainmenu') then
    for ind,v in pairs(trainstations) do 
     if WarMenu.Button(''..ind, "~g~$"..v.price) then
      inTrain = true
      ClearPedTasksImmediately(GetPlayerPed(-1))
      TriggerServerEvent("train:removemoney", v.price)
      ExecuteCommand('me purchases ticket to '..v.name..' station.')
      WarMenu.CloseMenu('trainmenu')
      FreezeEntityPosition(GetPlayerPed(-1), true)
      SwitchOutPlayer(PlayerPedId(), 0, 1)
      exports['NRP-notify']:DoHudText('inform', 'Boarding Your Train')
      Citizen.Wait(4000)
      SetEntityCoords(GetPlayerPed(-1), v.x, v.y, v.z+0.75)
      Wait(4500)
      exports['NRP-notify']:DoHudText('success', 'You Have Arrived At Your Destination')
      SwitchInPlayer(PlayerPedId())
      Citizen.Wait(4550)
      FreezeEntityPosition(GetPlayerPed(-1), false)
      inTrain = false
     end
    end
     WarMenu.Display()
    end
   end
  end
 end
end)

---------Gass-----------

--[[local nearObject = false 
local isNearObject = false
local objectLoca = {}
local clostestProp = nil
local label = "Jerry Can"
local models = {
  [1] = 1339433404,
  [2] = 1694452750,
  [3] = 1933174915,
  [4] = 2287735495,
}

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(1500)
  nearObject = false
  isNearObject = false
  local myCoords = GetEntityCoords(GetPlayerPed(-1))
   
  for i = 1, #models do
   clostestProp = GetClosestObjectOfType(myCoords.x, myCoords.y, myCoords.z, 2.5, models[i], false, false)
   if clostestProp ~= nil and clostestProp ~= 0 then
    local coords = GetEntityCoords(clostestProp)
    isNearObject = true
    objectLoca = {['x'] = coords.x, ['y'] = coords.y, ['z'] = coords.z + 1.2}
    break
   end
  end
 end
end)

Citizen.CreateThread(function()
 while true do
  Wait(5)
  if isNearObject then 
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), objectLoca.x, objectLoca.y, objectLoca.z-0.5, true) < 1.3) then
    DrawText3Ds(objectLoca.x, objectLoca.y, objectLoca.z,'~g~[E]~w~ Buy Jerry Can ~g~$500') 
	if IsControlJustPressed(0, 38) then
		TaskStartScenarioInPlace(GetPlayerPed(-1), 'PROP_HUMAN_ATM', false, true) Wait(3000) ClearPedTasksImmediately(GetPlayerPed(-1))
    TriggerServerEvent('shops:purchase', label, 500, 1, 205)
    end
   end ---- add shared banking to vending machines then somecan buy them
   end
 end
end)
]]--
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

function ProgressBar(text, time)
 progress_bar_text = text
 progress_bar_duration = time
 progress_time = 0.20
 progress_bar = true
end

RegisterNetEvent('hud:progressbar')
AddEventHandler('hud:progressbar', function(text, time)
 ProgressBar(text, time)
end)

function drawUI(x,y ,width,height,scale, text, r,g,b,a, center)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextCentre(center)
    --SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

RegisterCommand('phone', function(source, args, rawCommand) 
  if exports['core']:GetItemQuantity(104) >= 1 then 
   TriggerEvent("phone:toggle")
  else
    exports['NRP-notify']:DoHudText('error', 'You Don\'t Have a Phone On You')
  end 
end)

---MP3
--[[
RegisterCommand('radio', function(source, args, rawCommand)
  if exports['core']:GetItemQuantity(143) >= 1 then
   if IsMobilePhoneRadioActive() then
    SetMobilePhoneRadioState(0)
    SetAudioFlag("MobileRadioInGame", 0)
    SetAudioFlag("AllowRadioDuringSwitch", 0)
   else
    SetMobilePhoneRadioState(1)
    SetAudioFlag("MobileRadioInGame", 1)
    SetAudioFlag("AllowRadioDuringSwitch", 1)
   end
  else
    exports['NRP-notify']:DoHudText('error', 'You Don\'t Have a Portable DAB Radio On You')
  end
end)]]--

--- Radio
--[[
Citizen.CreateThread(function()
  while true do
    Wait(1000)
    if exports['core']:GetItemQuantity(261) >= 1 then
      exports:["rp-radio"]:SetRadio(true)
    else
      exports:["rp-radio"]:SetRadio(false)
    end
  end
end)
]]--
--------CarWashes
local Carwashesloc = {
  [1] = {x = 25.170, y = -1392.031, z = 29.334},
  [2] ={x = 171.670, y = -1717.579, z = 29.292},
  [3] ={x = 1780.510, y = 3328.615, z = 41.253},
 }

 local vehicle = GetVehiclePedIsUsing(GetPlayerPed(-1))
 
Citizen.CreateThread(function()
 while true do
  Wait(1)
 for k,v in pairs(Carwashesloc) do
  if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 30) and IsPedInAnyVehicle(GetPlayerPed(-1), false) then
   DrawMarker(27, v.x, v.y, v.z-0.99, 0, 0, 0, 0, 0, 0, 2.0,2.0,1.0, 255,0,100, 200, 0, 0, 2, 0, 0, 0, 0)
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < 4.0) then
    DrawText3Ds(v.x, v.y, v.z,"~g~[E]~w~ Detail Vehicle [~g~$50~m~]")
    if IsControlJustPressed(0, 38) then
       TriggerServerEvent('carwash:removemoney', v.name, true)
    end
   end 
 end
 end
 end
end)

RegisterNetEvent('carwash:washing')
AddEventHandler('carwash:washing', function()
   local vehicle = GetVehiclePedIsUsing(GetPlayerPed(-1))
  FreezeEntityPosition(vehicle, true)
    ProgressBar('Starting Car Wash', 15)
    Wait(1750)
    ProgressBar('Washing Car 1/2', 25)
    Wait(3750)
    ProgressBar('Washing Car 2/2', 25)
    Wait(3750)
    FreezeEntityPosition(vehicle, false)
    SetVehicleDirtLevel(vehicle, 0.0)
    WashDecalsFromVehicle(vehicle, 10.0)
    exports['NRP-notify']:DoHudText('success', 'CarDetailer: Car All Polished Up Have a Nice Day!')
end)
--------Commands
local autodrive = false
RegisterCommand("autodrive", function(source, args, rawCommand)
 autodrive = not autodrive
 if autodrive then
  dx, dy, dz = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09, GetFirstBlipInfoId(8), Citizen.ResultAsVector()))
  TaskVehicleDriveToCoordLongrange(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), dx, dy, z, 25.0, 411, 30.0)
  exports['NRP-notify']:DoHudText('success', 'AutoDrive')
 else
  ClearPedTasks(GetPlayerPed(-1))
  exports['NRP-notify']:DoHudText('error', 'AutoDrive: OFF!')
 end
end, false) 

RegisterCommand("helmet2", function(source, args, raw)                         
  if args[1] == '1' then
        RemovePedHelmet(GetPlayerPed(-1), true)
        SetPedHelmet(GetPlayerPed(-1), false)
  elseif args[1] == '2' then
        SetPedHelmet(GetPlayerPed(-1), true)
 end
end, false)
--=======================================================================================================--

-- Remove AFK Camera

Citizen.CreateThread(function() 
  while true do
    N_0xf4f2c0d4ee209e20() 
    Wait(1000)
  end 
end)