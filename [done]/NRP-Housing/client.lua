currentHouse = {}
allHouses = {}
inhouse = false
local garages = {}
local user_vehicles = {}
local user_garages = {}
local garage = {} 
local slotprice = 500 
local togglehomes = false
local ownedHouses = {}
local instance = {}
local ipllist = {
  ["ipl1"] = {
      position = {x = 151.428, y = -1007.758, z = -99.000}, -- motel shitty thing
      telepos = {x = 151.428, y = -1007.758, z = -99.000},
      item_storage = {x = 151.268, y = -1003.089, z = -99.000},
      weapon_storage = {x = 351.616, y = -998.791, z = -99.196},
      storage = 100,
    },
  ["ipl2"] = {
      position = {x = 343.85, y = -999.08, z = -99.000}, -- nice house
      telepos = {x = 346.535, y = -1011.702, z = -99.196},
      item_storage = {x = 351.958, y = -998.716, z = -99.196},
      weapon_storage = {x = 351.616, y = -998.791, z = -99.196},
      storage = 250,
    },
  ["ipl3"] = {
      position = {x = 263.86999, y = -998.78002, z = -99.010002},   -- low end apartment
      telepos = {x = 265.968, y = -1006.969, z = -100.884},
      item_storage = {x = 263.739, y = -995.882, z = -99.009},
      weapon_storage = {x = 262.552, y = -1002.781, z = -99.009},
      storage = 150,
    },
  ["ipl4"] = {
      position = {x = -169.852, y = 487.648, z = 137.443},   -- White interior good view
      telepos = {x = -174.2545, y = 497.3608, z = 137.666},
      item_storage = {x = -176.295, y = 492.351, z = 130.044},
      weapon_storage = {x = -168.360, y = 493.855, z = 137.654},
      storage = 400,
    },
  ["ipl5"] = {
      position = {x = 334.588, y = 431.330, z = 149.171},   -- White interior
      telepos = {x = 341.601, y = 437.529, z = 149.394},
      item_storage = {x = 340.018, y = 431.200, z = 149.381},
      weapon_storage = {x = 337.739, y = 437.002, z = 141.771},
      storage = 100,
    },
  ["ipl6"] = {
      position = {x = 372.207, y = 411.395, z = 145.700},   -- Red interior
      telepos = {x = 373.561, y = 423.298, z = 145.908},
      item_storage = {x = 379.267, y = 429.895, z = 138.300},
      weapon_storage = {x = 377.414, y = 428.991, z = 138.300},
      storage = 500
    },
  --[[["ipl7"] = {
      storage = 100,
      position = {x = 335.0171, y = -1026.022,, z = -84.82715},   -- GrowHouse
      telepos = {x = 335.0171, y = -1026.022, z = -84.82715},
      item_storage = {x = 337.829, y = -1021.832, z = -84.85741},
      weapon_storage = {x = 336.829, y = -1020.832, z = -84.85741}
    },]]--
  ["iplapart1"] = {
      position = {x = -786.8663, y = 315.7642, z = 217.6385},   -- Apartment 1
      telepos = {x = -786.8663, y = 315.7642, z = 217.6385},
      item_storage = {x = -796.568, y = 328.423, z = 217.038},
      weapon_storage = {x = -795.93, y = 327.25, z = 217.04}, 
      storage = 750,
      ipl = 'apa_v_mp_h_06_a'
    },
}

--[[RegisterCommand('togglehomes', function(source, args, rawCommand)
  if togglehomes then 
   for i, blip in pairs(requestBlips) do
    RemoveBlip(blip)
    end
    requestBlips = {}
    togglehomes = false
  else 
   for _, info in pairs(allHouses) do
    if not ownedHouses[info.id] then
     info.blip = AddBlipForCoord(info.pos.x, info.pos.y, info.pos.z)
     SetBlipSprite(info.blip, 40)
     SetBlipDisplay(info.blip, 4)
     SetBlipScale(info.blip, 0.6)
     SetBlipColour(info.blip, 4)
     SetBlipAsShortRange(info.blip, true)
     BeginTextCommandSetBlipName("STRING")
     AddTextComponentString(" ")
     EndTextCommandSetBlipName(info.blip)
     table.insert(requestBlips, info.blip)
    elseif ownedHouses[info.id] then
     info.blip = AddBlipForCoord(info.pos.x, info.pos.y, info.pos.z)
     SetBlipSprite(info.blip, 40)
     SetBlipDisplay(info.blip, 4)
     SetBlipScale(info.blip, 0.6)
     SetBlipColour(info.blip, 3)
     SetBlipAsShortRange(info.blip, true)
     BeginTextCommandSetBlipName("STRING")
     AddTextComponentString(" ")
     EndTextCommandSetBlipName(info.blip)
     table.insert(requestBlips, info.blip)
    end
   end
   togglehomes = true
  end
end)
]]--

local exit_locations = {
 {x = 346.541, y = -1013.085, z = -99.196},
 {x = 265.968, y = -1006.969, z = -100.884},
 {x = -174.2545, y = 497.3608, z = 137.666},
 {x = 341.601, y = 437.529, z = 149.394},
 {x = 373.561, y = 423.298, z = 145.908},
 {x = 151.428, y = -1007.758, z = -99.00},
 {x = -787.048, y = 315.803, z = 217.638},
}

--[[RegisterNetEvent('housing:update')
AddEventHandler('housing:update', function(all, owned, id)
 allHouses = all
 ownedHouses = owned
 myCharacterID = id 
 TriggerEvent('phone:houses', all, owned)
end)]]
RegisterNetEvent('housing:update')
AddEventHandler('housing:update', function(all, owned, id)
 allHouses = all
 ownedHouses = owned
 myCharacterID = id
 TriggerEvent('phone:houses', all, owned)
  
 for _, info in pairs(ownedHouses) do
  if info.char_id == myCharacterID then
   info.blip = AddBlipForCoord(allHouses[info.id].pos.x, allHouses[info.id].pos.y, allHouses[info.id].pos.z)
   SetBlipSprite(info.blip, 40)
   SetBlipDisplay(info.blip, 4)
   SetBlipScale(info.blip, 0.8)
   SetBlipColour(info.blip, 11)
   SetBlipAsShortRange(info.blip, true)
   BeginTextCommandSetBlipName("STRING")
   AddTextComponentString("Owned Home")
   EndTextCommandSetBlipName(info.blip)
  end
 end
end)

RegisterNetEvent('housing:removefromhouse')
AddEventHandler('housing:removefromhouse', function(id)
  for _, info in pairs(ownedHouses) do
    if info.id == id then
      local ped = GetPlayerPed(-1)
      RequestCollisionAtCoord(allHouses[info.id].pos.x, allHouses[info.id].pos.y, allHouses[info.id].pos.z)
      while (not HasCollisionLoadedAroundEntity(ped)) do
        RequestCollisionAtCoord(allHouses[info.id].pos.x, allHouses[info.id].pos.y, allHouses[info.id].pos.z)
        Wait(0)
      end
      SetEntityCoords(ped, allHouses[info.id].pos.x, allHouses[info.id].pos.y, allHouses[info.id].pos.z)
      TriggerServerEvent("housing:updateHouse", 0)
    end
  end
end)

--- modify_garages
Citizen.CreateThread(function()
  WarMenu.CreateLongMenu('garage_manage', "House Garage")
  WarMenu.CreateLongMenu('vehicle_list', 'Vehicles')
  WarMenu.CreateLongMenu('modify_garages', 'Garage')
  WarMenu.CreateLongMenu('modify_garages2', 'Garage')
  local currentItemIndex = 1
  local PurchasedSlots = 1 
 while true do 
  local coords = GetEntityCoords(GetPlayerPed(-1))
  Citizen.Wait(5)
  if not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
    for _,v in pairs(allHouses) do
      if(GetDistanceBetweenCoords(coords, v.pos.x, v.pos.y, v.pos.z, true) < 3.0) and not ownedHouses[v.id] then
       local rent = math.floor(v.price*exports['core']:getVat(5)) --- removed /8 to make it 1 item purchase for hosue
        DrawText3Ds(v.pos.x, v.pos.y, v.pos.z,'~g~[E]~w~ Buy~g~ $'..rent)
        if IsControlJustPressed(0, 38) then
          local pedids = GetD8PlayersInArea()
          if (pedids and #pedids > 0) then
            TriggerServerEvent('housing:rentProperty', rent, v.id, pedids)
          else
            exports['NRP-notify']:DoHudText('error', 'No Real Estate agents nearby.')
          end
        end
      end
    end
   -- Owned
    for _,v in pairs(ownedHouses) do
      if(GetDistanceBetweenCoords(coords, allHouses[v.id].pos.x, allHouses[v.id].pos.y, allHouses[v.id].pos.z, true) < 3.0) then
        if v.char_id == myCharacterID then
         DrawText3Ds(allHouses[v.id].pos.x, allHouses[v.id].pos.y, allHouses[v.id].pos.z,'~g~[E]~w~ Manage\n~g~'..allHouses[v.id].address)
          if IsControlJustPressed(0, 38) then
            currentHouse = v
            WarMenu.OpenMenu('housing_manage')
          end
        elseif DecorGetInt(PlayerPedId(), 'Faction') == 30 and (allHouses[v.id].id == 1841 or allHouses[v.id].id == 1842 or allHouses[v.id].id == 1843 or allHouses[v.id].id == 1844 or allHouses[v.id].id == 1845) then
          DrawText3Ds(allHouses[v.id].pos.x, allHouses[v.id].pos.y, allHouses[v.id].pos.z,'~g~[E]~w~ Enter Showroom\n~g~'..allHouses[v.id].address)
          if IsControlJustPressed(0, 38) then
            currentHouse = v
            WarMenu.OpenMenu('housing_manage')
          end
        elseif hasHouseKey(v.id) then
          DrawText3Ds(allHouses[v.id].pos.x, allHouses[v.id].pos.y, allHouses[v.id].pos.z,'~g~[E]~w~ Enter\n~g~'..allHouses[v.id].address)
          if IsControlJustPressed(0, 38) then
           TriggerServerEvent("housing:createInstance", v)
           TriggerServerEvent("housing:updateHouse", v.id)
           inhouse = true
           currentHouse = v
           TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 5.0, 'door', 0.5)
          end
        else
          if DecorGetInt(PlayerPedId(), 'Faction') == 30 and (allHouses[v.id].id == 1841 or allHouses[v.id].id == 1842 or allHouses[v.id].id == 1843 or allHouses[v.id].id == 1844 or allHouses[v.id].id == 1845) then
            DrawText3Ds(allHouses[v.id].pos.x, allHouses[v.id].pos.y, allHouses[v.id].pos.z,'~s~[~g~Contact D8 to view this showroom.~s~]')
          else
            if DecorGetInt(PlayerPedId(), 'Faction') == 30 then
              DrawText3Ds(allHouses[v.id].pos.x, allHouses[v.id].pos.y, allHouses[v.id].pos.z,'~g~[Address: ~r~'..allHouses[v.id].address..'~g~]\n~g~ [House ID: ~r~'..allHouses[v.id].id..'~g~]\n~g~ [~r~Owned~g~]') ----- testing
            else
              DrawText3Ds(allHouses[v.id].pos.x, allHouses[v.id].pos.y, allHouses[v.id].pos.z,'~g~[Address: ~r~'..allHouses[v.id].address..'~g~]\n~g~ [~r~Owned~g~]') ----- testing
            end
          end
        end
      end
    end
  end  
      ---owned house garages
  -------------------------------------------------------------------- XZURV NEW HOUSING GARAGE SYSTEM ----------------------------------------------------------------------------------
    for _,v in pairs(ownedHouses) do
      if ownedHouses[v.id].garage ~= nil then
        if(GetDistanceBetweenCoords(coords, ownedHouses[v.id].garage.x, ownedHouses[v.id].garage.y, ownedHouses[v.id].garage.z, true) < 3.0) and not IsPedInAnyVehicle(GetPlayerPed(-1)) then
          if v.char_id == myCharacterID then
            DrawText3Ds(ownedHouses[v.id].garage.x, ownedHouses[v.id].garage.y, ownedHouses[v.id].garage.z,'~g~[E]~w~ Garage\n~g~')
            if IsControlJustPressed(0, 38) then
              WarMenu.OpenMenu('garage_manage')
             currentHouse = v 
             currentgarage = garages[k]
            end
          end
        end
       if(GetDistanceBetweenCoords(coords, ownedHouses[v.id].garage.x, ownedHouses[v.id].garage.y, ownedHouses[v.id].garage.z, true) < 5.0) and IsPedInAnyVehicle(GetPlayerPed(-1)) then
        if v.char_id == myCharacterID then
          DrawText3Ds(ownedHouses[v.id].garage.x, ownedHouses[v.id].garage.y, ownedHouses[v.id].garage.z,'~g~[ENTER]~w~ Store Vehicle')
          if IsControlJustPressed(0, 176) then
           currentHouse = v
           currentgarage = garages[k]
           SetVehicleForwardSpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
           StoreVehicle()
          end
        end
      end
   
    if WarMenu.IsMenuOpened('garage_manage') then   
        local slots = 5
       if WarMenu.Button('Restore Cars ~g~$500') and IsPedOnFoot(GetPlayerPed(-1)) then
         exports['NRP-notify']:DoHudText('success', 'DMV: Please Wait While We Recover Your Cars')
         Wait(3000)
         TriggerServerEvent('garagepayment:removemoney')
       elseif WarMenu.Button('List Vehicles', getCarQ().."/"..getGarageQ()) then
        
         WarMenu.OpenMenu('vehicle_list')
         
       elseif WarMenu.Button('Store Vehicle') then
        StoreVehicle()
       end
      WarMenu.Display()
     elseif WarMenu.IsMenuOpened('vehicle_list') then
     
        for i = 1,#user_vehicles do
          if (user_vehicles[i] ~= nil) then
            if user_vehicles[i].garage == currentHouse.id then
              if user_vehicles[i].stored and not user_vehicles[i].impound then
               if WarMenu.Button(user_vehicles[i].model,'~g~Stored') then
                SpawnVehicle(user_vehicles[i])
                SetVehicleOnGroundProperly(vehicle)
                WarMenu.CloseMenu()
               end
              else
                if WarMenu.Button(user_vehicles[i].model,'~r~Out') then
                 exports['NRP-notify']:DoHudText('error', 'Your vehicle is not in this garage, you will need this to be recovered! If your vehicle has been impounded you will need to release at the impound!')
                end
              end
            end
          end
        end
      WarMenu.Display()
      end
    end
   end        
  end
end)


function SpawnVehicle(data)
  local coords = GetEntityCoords(GetPlayerPed(-1), false)
  RequestModel(data.components.model)
  while not HasModelLoaded(data.components.model) do
   Citizen.Wait(0)
  end
  vehicle = CreateVehicle(data.components.model, coords.x, coords.y, coords.z, GetEntityHeading(PlayerPedId()), true, false)
  DecorRegister("_Fuel_Level", 3);
  DecorRegister("_Max_Fuel_Level", 3);
  if data.components.maxFuelLevel ~= nil or 0 then  ----PETROL FIX
  DecorSetInt(vehicle, "_Max_Fuel_Level", 100000)
  end
  if data.fuel ~= nil then
    DecorSetInt(vehicle, "_Fuel_Level", data.fuel)
  else
    DecorSetInt(vehicle, "_Fuel_Level", math.random(10000, 25000))
  end
  SetVehicleProperties(vehicle, data.components)
  TriggerServerEvent("housegarage:out", data)
  TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
  SetVehicleEngineOn(vehicle, true)
  SetVehicleHasBeenOwnedByPlayer(vehicle, true)
  SetEntityAsMissionEntity(vehicle, true, true)
  exports["onyxLocksystem"]:givePlayerKeys(GetVehicleNumberPlateText(vehicle))
end

 
function getCarQ()
  local count = 0
  for i=1,#user_vehicles do
      if user_vehicles[i].garage == currentHouse.id then
          count = count + 1
         
      end
  end
  return count
end

function getGarageQ()
  for i=1,#user_garages do
      if user_garages[i].id == currentHouse.id then
        
          return user_garages[i].count
      end
  end
end  


RegisterNetEvent("garage:refresh")
AddEventHandler("garage:refresh", function(data, gdata, idata)
 user_vehicles = data
 user_garages = gdata
 insured_vehicles = idata
end)


function StoreVehicle()
local vehicle = nil
local coords = GetEntityCoords(GetPlayerPed(-1))
local model = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1))))
if IsPedInAnyVehicle(GetPlayerPed(-1), false) then vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false) else vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71) end  
print(vehicle, "storing vehicle") 
print(currentHouse.id)   
local components = GetVehProps(vehicle)
local fuel = DecorGetInt(vehicle, "_Fuel_Level") --- change this bozo
for i = 1, #user_vehicles do
if tostring(components.plate) == tostring(user_vehicles[i].plate) and model == tostring(user_vehicles[i].model) then
 local count = 0
  for _,v in pairs(ownedHouses) do
   if ownedHouses[v.id].garage.id == currentHouse.id then
    count = count + 1
   end
  end
 local actualslots = 5 
 for _,v in pairs(ownedHouses) do
  if ownedHouses[v.id].garage.id ==  currentHouse.id then
   actualslots = ownedHouses[v.id].garage.count
  end
 end
 if count <= actualslots then
   TriggerServerEvent("garage:store", components, currentHouse.id, fuel)
   SetEntityAsMissionEntity(vehicle, true, true)
   DeleteVehicle(vehicle)
   exports['NRP-notify']:DoHudText('success', 'Vehicle Stored')
 else
  exports['NRP-notify']:DoHudText('error', 'Garage Full, You can buy more slots at the vehicle shop!')
 end
end
end
end

-------------------------------------------------------------------- XZURV NEW HOUSING GARAGE SYSTEM ----------------------------------------------------------------------------------


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

function hasHouseKey(id)
 if DecorGetInt(GetPlayerPed(-1), "Faction") == 12 then --DecorGetBool(GetPlayerPed(-1), "isOfficer") --- test xzurv
  return true 
 else
  if ownedHouses[id].keys ~= 'No Keys' then 
   local keys = json.decode(ownedHouses[id].keys)
   for _,v in pairs(keys) do 
    if v.id == myCharacterID then 
     return true
    end
   end
  end
 end
end

Citizen.CreateThread(function()
  WarMenu.CreateLongMenu('housing_manage', "Housing")
  WarMenu.CreateLongMenu('housing_key_manage', "Housing")
  WarMenu.CreateLongMenu('housing_key_manage_manage', "Housing")
  WarMenu.CreateLongMenu('housing_key_revoke', "Housing")
  local MenuAction = ''
  local revokehouse = {}
  while true do
   Citizen.Wait(5)
   if WarMenu.IsMenuOpened('housing_manage') then
    local sellPrice = currentHouse.rent/2
    if currentHouse.rent_due == 0 and WarMenu.Button('Enter House')  then
     TriggerServerEvent("housing:createInstance", currentHouse)
     TriggerServerEvent("housing:updateHouse", currentHouse.id)
     inhouse = true
     WarMenu.CloseMenu()
     TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 5.0, 'door', 0.5)
    elseif currentHouse.rent_due == 0 and WarMenu.Button('Enter House With Guests') then
     local pedids = GetPlayersInArea()
     if (pedids and #pedids > 0) then
       TriggerServerEvent("housing:enterallowfriends", pedids, currentHouse)
     else
       exports['NRP-notify']:DoHudText('error', 'No Players Nearby')
     end
     WarMenu.CloseMenu()
    --[[elseif WarMenu.Button('Sell House', '~g~$'..sellPrice) then
     TriggerServerEvent("housing:stopRenting", currentHouse.id, sellPrice)
     WarMenu.CloseMenu()--]]
    end
    WarMenu.Display()
   elseif WarMenu.IsMenuOpened('housing_key_manage') then
    if WarMenu.Button('Give Key') then
     MenuAction = 'Give'
     WarMenu.OpenMenu('housing_key_manage_manage')
    elseif WarMenu.Button('Change Locks') then
     MenuAction = 'Change'
     WarMenu.OpenMenu('housing_key_manage_manage')
    elseif WarMenu.Button('Revoke Key') then
     MenuAction = 'Revoke'
     WarMenu.OpenMenu('housing_key_manage_manage')
    end
    WarMenu.Display()
   elseif WarMenu.IsMenuOpened('housing_key_manage_manage') then
    for _,v in pairs(ownedHouses) do
     if v.char_id == myCharacterID then
      if WarMenu.Button(allHouses[v.id].address) then
       if MenuAction == 'Give' then
        local t, distance = GetClosestPlayer()
        if(distance ~= -1 and distance < 5) then
         TriggerServerEvent("housing:givekey", v, GetPlayerServerId(t))
         WarMenu.CloseMenu()
        end
       elseif MenuAction == 'Change' then
        TriggerServerEvent("housing:changelocks", v.id)
       elseif MenuAction == 'Revoke' then
         revokehouse = v
         WarMenu.OpenMenu('housing_key_revoke')
        end
       end
      end
     end
    WarMenu.Display()
   elseif WarMenu.IsMenuOpened('housing_key_revoke') then
     local keys = json.decode(getKeysById(revokehouse))
     for _,k in pairs(keys) do
      if WarMenu.Button(k.name) then
       TriggerServerEvent("housing:takekey", revokehouse, k.id)
      end
     end
     WarMenu.Display()
    end
   end 
 end)

-- Nearest Players
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

function GetClosestInstancedPlayer()
    local players = GetInstancedPlayers()
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

    for _, player in ipairs(GetActivePlayers()) do
      table.insert(players, player)
    end

    return players
end

function GetInstancedPlayers()
    local players = {}
    for _, player in ipairs(GetActivePlayers()) do
        for _,p in pairs(instance.participants) do
            instancePlayer = GetPlayerFromServerId(p)
            if player == instancePlayer then
              table.insert(players, player)
            end
        end
    end

    return players
end

RegisterNetEvent('housing:keys')
AddEventHandler('housing:keys', function()
 WarMenu.OpenMenu('housing_key_manage')
end)

RegisterNetEvent("housing:updateInstanceMembers")
AddEventHandler("housing:updateInstanceMembers", function(inst)
  instance = inst
end)

RegisterNetEvent("housing:sendToInstance")
AddEventHandler("housing:sendToInstance", function(inst, house)
  instance = inst 
  currentHouse = house
  teleportToInterior(GetPlayerPed(-1), house)
  NetworkSetVoiceChannel(instance.vchan)
end)

RegisterNetEvent("housing:isInHouse")
AddEventHandler("housing:isInHouse", function()
  inhouse = true
end)

Citizen.CreateThread(function()
  while true do
   local playerPed = GetPlayerPed(-1)
   Citizen.Wait(0)
   if (instance and instance.houseid and instance.houseid > 0) then
    DisablePlayerFiring(GetPlayerPed(-1), true)
    DisableControlAction(0, 21)
    if instance.houseid then
      for _, player in ipairs(GetActivePlayers()) do
        local found = false
        for _,p in pairs(instance.participants) do
          instancePlayer = GetPlayerFromServerId(p)
          if player == instancePlayer then
            found = true
          end
        end
        if not found then
          local otherPlayerPed = GetPlayerPed(player)
          SetEntityLocallyInvisible(otherPlayerPed)
          SetEntityNoCollisionEntity(playerPed, otherPlayerPed, true)
        end
      end
    else
      for _, player in ipairs(GetActivePlayers()) do
        local found = false
        for _,p in pairs(instance.participants) do
         instancePlayer = GetPlayerFromServerId(p)
         if player == instancePlayer then
          found = true
         end
        end
        if found then
         local otherPlayerPed = GetPlayerPed(player)
         SetEntityLocallyInvisible(otherPlayerPed)
         SetEntityNoCollisionEntity(playerPed, otherPlayerPed, true)
        end
      end
    end
   end
  end
end)

Citizen.CreateThread(function()
 while true do
  local ped = GetPlayerPed(-1)
  local pos = GetEntityCoords(ped)
  Citizen.Wait(5)
  for _,v in pairs(exit_locations) do
   if(GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 1.5 and inhouse) then
    DrawText3Ds(v.x, v.y, v.z,"~g~[E]~w~ Exit ")
    if (IsControlJustReleased(1, 38)) then
     teleportPlayerToHouse(allHouses[currentHouse.id].pos.x, allHouses[currentHouse.id].pos.y, allHouses[currentHouse.id].pos.z)
     Citizen.InvokeNative(0xE036A705F989E049)
     disableInterior()
     instance.houseid = 0
     TriggerServerEvent("housing:removeFromInstance", currentHouse)
     TriggerServerEvent("housing:updateHouse", 0)
     renderExitMarker = false
     inhouse = false
     currentHouse = nil
     TriggerEvent("gangs:setDefaultRelations")
    end
   end
  end
 end
end)

function GetPlayersInArea()
  local peds
  local pedids = {}
  
  peds = GetPedNearbyPeds(GetPlayerPed(-1), -1)
  
  for _, player in ipairs(GetActivePlayers()) do
    local ped = GetPlayerPed(-1)
    local rped = GetPlayerPed(player)
    
    if rped ~= ped then
      local pos = GetEntityCoords(ped)
      local rpos = GetEntityCoords(rped)
      local dist = Vdist(pos.x, pos.y, pos.z, rpos.x, rpos.y, rpos.z)
      
      if (dist < 5) then
        table.insert(pedids, GetPlayerServerId(player))
      end
    end
  end
  table.insert(pedids, GetPlayerServerId(PlayerId()))
  return pedids
end

function GetD8PlayersInArea()
  local peds
  local pedids = {}
  
  peds = GetPedNearbyPeds(GetPlayerPed(-1), -1)
  
  for _, player in ipairs(GetActivePlayers()) do
    local ped = GetPlayerPed(-1)
    local rped = GetPlayerPed(player)
    
    if rped ~= ped then
      local pos = GetEntityCoords(ped)
      local rpos = GetEntityCoords(rped)
      local dist = Vdist(pos.x, pos.y, pos.z, rpos.x, rpos.y, rpos.z)
      
      if (dist < 5 and DecorGetInt(rped, 'Faction') == 30) then
        table.insert(pedids, GetPlayerServerId(player))
        return pedids
      end
    end
  end
  return pedids
end


function teleportToInterior(house)
  Citizen.CreateThread(function()
   lastipl = ipllist[allHouses[currentHouse.id].ipl]

   if lastipl ~= nil then 
    interior = GetInteriorAtCoords(lastipl.position.x, lastipl.position.y, lastipl.position.z)
    
    Citizen.InvokeNative(0x2CA429C029CCF247, interior)
    SetInteriorActive(interior, true)
    DisableInterior(interior, false)
    
    if (interior) then          
      while (not (IsInteriorReady(interior))) do
        Wait(1)
      end

      teleportPlayerToHouse(lastipl.telepos.x, lastipl.telepos.y, lastipl.telepos.z, lastipl.ipl)
      renderExitMarker = true
    end
   end
  end)
end

function disableInterior()
  if (interior) then
    Citizen.InvokeNative(0x2CA429C029CCF247, interior)
    SetInteriorActive(interior, false)
    DisableInterior(interior, true)
  end
end

function teleportPlayerToHouse(x, y, z, ipl)
  Citizen.CreateThread(function()
    local ped = GetPlayerPed(-1)

    if ipl ~= nil then 
      if (not IsIplActive(ipl)) then
        RequestIpl(ipl)
      end
    end

    RequestCollisionAtCoord(x, y, z)
    
    while (not HasCollisionLoadedAroundEntity(ped)) do
      RequestCollisionAtCoord(x, y, z)
      Wait(0)
    end
    
    SetEntityCoords(ped, x, y, z)

  end)
end

RegisterCommand('newhouse', function(source, args, rawCommand)
  local pos = GetEntityCoords(PlayerPedId(), true)
  if DecorGetInt(PlayerPedId(), 'Faction') == 30 then
    if not args[1] then
      TriggerEvent('chatMessage', "D8", {0, 200, 0}, " ---------------------------------------------------------------------------------------------")
      TriggerEvent('chatMessage', "D8", {0, 200, 0}, " Usage: /newhouse \"Address Line\" <Price> <Interior>")
      TriggerEvent('chatMessage', "D8", {0, 200, 0}, " Example: /newhouse \"1290 Grove St\" 100000 ipl1")
      TriggerEvent('chatMessage', "D8", {0, 200, 0}, " You MUST make sure the Address Line is inside quotation marks.")
      TriggerEvent('chatMessage', "D8", {0, 200, 0}, " ---------------------------------------------------------------------------------------------")
      TriggerEvent('chatMessage', "D8", {0, 200, 0}, " List of Road Abreviations:")
      TriggerEvent('chatMessage', "D8", {0, 200, 0}, " St, Dr, St, Ave, Blvd, Way, Rd, Hills, Lane")
      TriggerEvent('chatMessage', "D8", {0, 200, 0}, " ---------------------------------------------------------------------------------------------")
      return
    end
    if not args[2] and not args[3] then
      exports['NRP-notify']:DoHudText('error', 'You did not specify a price or interior.')
      return
    end
    --[[if args[2] ~= "ipl2" or args[2] ~= "ipl3" or args[2] ~= "ipl4" or args[2] ~= "ipl6" or args[2] ~= "iplapart1" then
      exports['NRP-notify']:DoHudText('error', 'You have specified an incorrect ipl.')
      return
    end--]]
    TriggerServerEvent('housing:addProperty', args[1], tonumber(args[2]), args[3], {x = pos.x, y = pos.y, z = pos.z})
  else
    exports['NRP-notify']:DoHudText('error', 'You are not a Real Estate agent.')
  end
 end)

RegisterCommand('removehouse', function(source, args, rawCommand)
  local pos = GetEntityCoords(PlayerPedId(), true)
  if DecorGetInt(PlayerPedId(), 'Faction') == 30 then
    if not args[1] then
      TriggerEvent('chatMessage', "D8", {0, 200, 0}, " ---------------------------------------------------------------------------------------------")
      TriggerEvent('chatMessage', "D8", {0, 200, 0}, " Usage: /removehouse <House ID>")
      TriggerEvent('chatMessage', "D8", {0, 200, 0}, " Example: /removehouse 1998")
      TriggerEvent('chatMessage', "D8", {0, 200, 0}, " ---------------------------------------------------------------------------------------------")
      return
    end
    TriggerServerEvent('housing:removeProperty', args[1], tonumber(args[2]))
  else
    exports['NRP-notify']:DoHudText('error', 'You are not a Real Estate agent.')
  end
 end)

------------------------------------
-- Vehicle Garage Added To Houses --
------------------------------------
--[[
 
function SpawnVehicle(data)
  local pos = GetEntityCoords(PlayerPedId(), true)
   
  RequestModel(data.components.model)
  while not HasModelLoaded(data.components.model) do
   Citizen.Wait(0)
  end
  vehicle = CreateVehicle(data.components.model, pos.x, pos.y, pos.z, GetEntityHeading(PlayerPedId()), true, false)
  if data.components.maxFuelLevel ~= nil then 
   DecorSetInt(vehicle, "_Max_Fuel_Level", data.components.maxFuelLevel)
  else 
   DecorSetInt(vehicle, "_Max_Fuel_Level", 100000)
  end
  if tonumber(data.fuel) < 10000 then 
   DecorSetInt(vehicle, "_Fuel_Level", 25000)
  else 
   DecorSetInt(vehicle, "_Fuel_Level", tonumber(data.fuel))
  end 
  SetVehicleProperties(vehicle, data.components)
  TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
  SetVehicleEngineOn(vehicle, true)
  SetVehicleHasBeenOwnedByPlayer(vehicle, true)
  SetEntityAsMissionEntity(vehicle, true, true)
end



RegisterCommand('setGarage', function(source, args, rawCommand)
  local t, distance = GetClosestPlayer()
  local pos = GetEntityCoords(PlayerPedId(), true)
  if DecorGetInt(PlayerPedId(), 'Faction') == 30 then 
   --if(distance ~= -1 and distance < 5) then
    if args[1] then 
     TriggerServerEvent('homes:setGarage', tonumber(args[1]), { id= tonumber(args[1]), x = pos.x, y = pos.y, z = pos.z ,count =5})
     TriggerServerEvent("housegarage:buy", 15000, tonumber(args[1]), 5)
    end
   --end GetPlayerServerId(t)
  end
 end)
--]]