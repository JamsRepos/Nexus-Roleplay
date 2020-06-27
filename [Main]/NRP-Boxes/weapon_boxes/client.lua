local weapon_boxes = {}
local weapon_boxes_props = {}
local box_inventory = {}
local box_id = nil

Citizen.CreateThread(function()
 while true do
  Wait(5)
  local coords = GetEntityCoords(GetPlayerPed(-1))
  for k,v in pairs(weapon_boxes) do
   if(GetDistanceBetweenCoords(coords, v.location.x, v.location.y, v.location.z-0.95, true) < 1.2) then
    drawTxt('~m~Press ~g~E~m~ To Access Weapon Box')
    if IsControlJustPressed(0, 38) then
     box_id = v.box_id
     print('[DEV INFO] Weapon Box ID: '..box_id)
     local amount = "xxsdrtghyuujhdjsjenenfjfjtjtjtj"
     if(amount == "xxsdrtghyuujhdjsjenenfjfjtjtjtj") then
      showLoadingPrompt('Enter Pass Code', 3)
      DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8S", "", "", "", "", "", 20)
      while (UpdateOnscreenKeyboard() == 0) do
       DisableAllControlActions(0);
       Wait(0);
      end
      if (GetOnscreenKeyboardResult()) then
       local option = tonumber(GetOnscreenKeyboardResult())
       if(option ~= nil and option ~= 0) then
        amount = option
       end
      end
     end
     stopLoadingPrompt()
     if amount == v.pin then
      TriggerServerEvent("weapon_box:getInventory", box_id)
      WarMenu.OpenMenu('weapon_box')
     else
      exports['NRP-notify']:DoHudText('error','Wrong Pass Code')
     end
    end
   end
  end
 end
end)


Citizen.CreateThread(function()
 WarMenu.CreateLongMenu('weapon_box', 'Weapon Box')
 WarMenu.CreateSubMenu('weapon_inv3', 'weapon_box', 'weapon_inv3')
 WarMenu.CreateSubMenu('player_inv3', 'weapon_box', 'player_inv3')
 while true do
  Citizen.Wait(5)
  if WarMenu.IsMenuOpened('weapon_box') then
   if WarMenu.MenuButton('Store Items', 'player_inv3') then
   elseif WarMenu.MenuButton('Take Items', 'weapon_inv3') then
   elseif WarMenu.Button('Move Weapon Box') then
    moveweaponBox(box_id)
   elseif WarMenu.Button('Remove Weapon Box') then
    DeleteObject(weapon_boxes_props[box_id].prop)
    TriggerServerEvent('weapon_box:removebox', box_id)
   end
   WarMenu.Display()
  elseif WarMenu.IsMenuOpened('weapon_inv3') then
   for i = 1,#box_inventory do
    if WarMenu.Button(tostring(box_inventory[i].label)) then
      local t, distance = GetClosestPlayer()
      if(distance ~= -1 and distance < 4) then
       exports['NRP-notify']:DoHudText('inform', 'Player to Close, Tell Them To Move Back')
      else
       TriggerServerEvent('weapon_box:removeweapon', box_id, box_inventory[i].name, box_inventory[i].id, box_inventory[i].label, box_inventory[i].weapon_id, box_inventory[i].blackmarket)
       TriggerServerEvent('core:giveweapons')
       TriggerEvent('weapons:updateback')
      end 
    end
   end
   if WarMenu.MenuButton('Back', 'weapon_box') then
   end
   WarMenu.Display()
  elseif WarMenu.IsMenuOpened('player_inv3') then
   local inventory = exports['core']:getWeapons()
   for i = 1,#inventory do
    if WarMenu.Button(tostring(inventory[i].label)) then
     if 1 + getBoxWeapons() <= 4 then
      TriggerServerEvent('weapon_box:addweapon', box_id, inventory[i].name, inventory[i].label, inventory[i].id, inventory[i].blackmarket)
      TriggerServerEvent('core:giveweapons')
      TriggerEvent('weapons:updateback')
     else
      exports['NRP-notify']:DoHudText('error','Box Can Only Hold 4 Weapons')
     end
    end
   end
   if WarMenu.MenuButton('Back', 'weapon_box') then
   end
   WarMenu.Display()
  end       
 end
end)

function getBoxWeapons()
 local quantity = 0
 for i=1,#box_inventory do
  quantity = quantity + 1
 end
 return quantity
end

RegisterNetEvent('weapon_box:updateitems')
AddEventHandler('weapon_box:updateitems', function(items)
 box_inventory = items
end)

AddEventHandler('weapon_box:new', function()
 WarMenu.CloseMenu()
 local pos = GetEntityCoords(GetPlayerPed(-1))
 local pin = openNumberBox("Create A Pass Code, (Numbers Only)")
 TriggerServerEvent('weapon_box:addbox', pos.x, pos.y, pos.z, pin)
end)

RegisterNetEvent('weapon_box:admindel')
AddEventHandler('weapon_box:admindel', function(box_id)
 TriggerServerEvent("weapon_box:getInventory", box_id)
 WarMenu.OpenMenu('weapon_box')
end)

RegisterNetEvent('weapon_box:updateboxes')
AddEventHandler('weapon_box:updateboxes', function(boxes)
 weapon_boxes = boxes
 -- Create new props
 for _,v in pairs(boxes) do 
  if not weapon_boxes_props[v.box_id] then 
   WeaponSpawnObject(v.box_id, v.location)
  end
 end
end)

function WeaponSpawnObject(id, coords)
 local prophash = GetHashKey('prop_box_ammo03a')
 RequestModel(prophash)
 while not HasModelLoaded(prophash) do
  Citizen.Wait(0)
 end

 local _, worldZ = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z)
 local propsobj = CreateObjectNoOffset(prophash, coords.x, coords.y, worldZ, true, true, true)
 
 SetEntityHeading(propsobj, 0)
 SetEntityAsMissionEntity(propsobj)
 FreezeEntityPosition(propsobj, true)
 SetModelAsNoLongerNeeded(prophash)
 exports['core']:globalObject(propsobj)
 weapon_boxes_props[id] = {prop = propsobj, location = coords}
end

--- way to move weapon boxes when moving places you into animation and you hold the box aka carry it until placed back down
local boxObject = nil 

function moveweaponBox(id)
 local pos = GetEntityCoords(GetPlayerPed(-1), false) 
 DeleteObject(weapon_boxes_props[id].prop)
 LoadModel("prop_cs_cardbox_01")
 boxObject = CreateObject(GetHashKey("prop_cs_cardbox_01"), pos.x, pos.y, pos.z, true)
 AttachEntityToEntity(boxObject, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), 0.0, -0.03, 0.0, 5.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
 LoadAnim("anim@heists@box_carry@")
 TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
 movingBox = true 

 while movingBox do
  Citizen.Wait(1)
  drawTxt('~m~Press ~g~M~m~ To Drop Box')
  if not IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
   if not IsEntityPlayingAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 3) then
    TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 50, 0, false, false, false) 
   end
  end
  if IsControlJustPressed(0, 244) then
   local pos = GetEntityCoords(GetPlayerPed(-1), false) 
   ClearPedTasks(GetPlayerPed(-1))
   DeleteObject(boxObject)
   TriggerServerEvent('weapon_box:move', id, pos.x,pos.y,pos.z)
   movingBox = false
  end
 end
end

function LoadAnim(animDict)
  RequestAnimDict(animDict)

  while not HasAnimDictLoaded(animDict) do
    Citizen.Wait(10)
  end
end

function LoadModel(model)
  RequestModel(model)

  while not HasModelLoaded(model) do
    Citizen.Wait(10)
  end
end

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