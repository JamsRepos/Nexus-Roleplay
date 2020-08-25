local storage_boxes = {}
local storage_boxes_props = {}
local box_inventory = {}
local box_id = nil

RegisterNetEvent('admin:storagebox2')
AddEventHandler('admin:storagebox2', function(boxx)
  TriggerServerEvent("storage_box2:getInventory", boxx)
  WarMenu.OpenMenu('storage_box2')
end)

RegisterCommand('pickup', function(source, args, rawCommand)
  local setting = args[1]
  local coords = GetEntityCoords(GetPlayerPed(-1))
  local t, distance = GetClosestPlayer()
  if(distance ~= -1 and distance < 5) then
    exports['NRP-notify']:DoHudText('error', "Player near the storage, tell them to move back.")
    return
  end
  if setting == 'large' then
    for k,v in pairs(storage_boxes) do
     if(GetDistanceBetweenCoords(coords, v.location.x, v.location.y, v.location.z, true) < 1.6) then
      box_id = v.box_id
      print('[DEV INFO] Storage Box ID: '..box_id)
      local amount = "xxsdrtghyuujhdjsjenenfjfjtjtjtj"
      if(amount == "xxsdrtghyuujhdjsjenenfjfjtjtjtj") then
       showLoadingPrompt('Enter Pass Code [NUMBERS ONLY]', 3)
       DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8S", "", "", "", "", "", 20)
       TriggerEvent('NRP-notify:client:SendAlert', { type = 'inform', text = "Please ensure the passcode is numbers only.", length = 10000})
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
       moveStorageBox2(box_id)
      else
       exports['NRP-notify']:DoHudText('inform', "Wrong Pass Code")
      end
     end
    end
  elseif setting == 'small' then
    TriggerEvent('admin:pickupSmall')
  else
    TriggerEvent('NRP-notify:client:SendAlert', { type = 'error', text = "Please ensure you specify size. <br> Example: /pickup large", length = 5000})
  end
end)

Citizen.CreateThread(function()
 while true do
  Wait(5)
  local coords = GetEntityCoords(GetPlayerPed(-1))
  for k,v in pairs(storage_boxes) do
   if(GetDistanceBetweenCoords(coords, v.location.x, v.location.y, v.location.z, true) < 1.6) then
    DrawText3Ds(v.location.x, v.location.y, v.location.z+0.15)
    if IsControlJustPressed(0, 38) then
     box_id = v.box_id
     print('[DEV INFO] Storage Box ID: '..box_id)
     local amount = "xxsdrtghyuujhdjsjenenfjfjtjtjtj"
     if(amount == "xxsdrtghyuujhdjsjenenfjfjtjtjtj") then
      showLoadingPrompt('Enter Pass Code [NUMBERS ONLY]', 3)
      DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8S", "", "", "", "", "", 20)
      TriggerEvent('NRP-notify:client:SendAlert', { type = 'inform', text = "Please ensure the passcode is numbers only.", length = 10000})
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
      TriggerServerEvent("storage_box2:getInventory", box_id)
     else
      exports['NRP-notify']:DoHudText('inform', "Wrong Pass Code")
     end
    end
   end
  end
 end
end)

function StorageItemStore2(item, name, quantity)
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
  if amount + getBoxQuantity() <= 320 then
   if tonumber(quantity) >= tonumber(amount) then
    TriggerServerEvent('storage_box2:additems', box_id, item, name, amount)
   end
  else
   exports['NRP-notify']:DoHudText('inform', "Storage Boxes Can Only Hold 320 Items")
  end
 end
end

RegisterNetEvent('storage_box2:check')
AddEventHandler('storage_box2:check', function(id, item,name,quantity)
  print(id, item,name,quantity)
  local meta = "This Item Contains No Meta Data"
    if tonumber(quantity) + getBoxQuantity() <= 160 then
      TriggerServerEvent('storage_box2:additems', id, item, name, quantity,meta)
    else
     exports['NRP-notify']:DoHudText('error', 'Max Storage: 160 items')
    end
end)


function getBoxQuantity()
 local quantity = 0
 for i=1,#box_inventory do
  quantity = quantity + box_inventory[i].q
 end
 return quantity
end

RegisterNetEvent('large_storage_box:admindel')
AddEventHandler('large_storage_box:admindel', function(box_id)
 TriggerServerEvent("storage_box2:getInventory", box_id)
 WarMenu.OpenMenu('storage_box2')
end)

RegisterNetEvent('storage_box2:updateitems')
AddEventHandler('storage_box2:updateitems', function(items)
 box_inventory = items
end)

AddEventHandler('storage_box2:new', function()
 WarMenu.CloseMenu()
 local pos = GetEntityCoords(GetPlayerPed(-1))
 local pin = openNumberBox("Create A Pass Code [NUMBERS ONLY]")
 TriggerServerEvent('storage_box2:addbox', pos.x, pos.y, pos.z, pin)
end)

RegisterNetEvent('storage_box2:updateboxes')
AddEventHandler('storage_box2:updateboxes', function(boxes)
 storage_boxes = boxes
 -- Create new props
 for _,v in pairs(storage_boxes) do 
  if not storage_boxes_props[v.box_id] then 
   SpawnObject2(v.box_id, v.location)
  end
 end
end)

function SpawnObject2(id, coords)
 local prophash = GetHashKey('prop_boxpile_04a')
 RequestModel(prophash)
 while not HasModelLoaded(prophash) do
  Citizen.Wait(0)
 end

 local _, worldZ = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z)
 local propsobj = CreateObjectNoOffset(prophash, coords.x, coords.y, worldZ, false, true, true)
 
 SetEntityHeading(propsobj, 0)
 SetEntityAsMissionEntity(propsobj)
 FreezeEntityPosition(propsobj, true)
 SetModelAsNoLongerNeeded(prophash)
 exports['core']:globalObject(propsobj)
 storage_boxes_props[id] = {prop = propsobj, location = coords}
end

--- way to move storage boxes when moving places you into animation and you hold the box aka carry it until placed back down
local boxObject = nil 

function moveStorageBox2(id)
 local pos = GetEntityCoords(GetPlayerPed(-1), false) 
 DeleteObject(storage_boxes_props[id].prop)
 LoadModel("prop_cs_cardbox_01")
 boxObject = CreateObject(GetHashKey("prop_cs_cardbox_01"), pos.x, pos.y, pos.z, true)
 AttachEntityToEntity(boxObject, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), 0.0, -0.03, 0.0, 5.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
 LoadAnim("anim@heists@box_carry@")
 TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
 movingBox = true 

 while movingBox do
  Citizen.Wait(1)
  drawTxt('~b~Press ~g~M~b~ To Drop Box')
  if not IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
   if not IsEntityPlayingAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 3) then
    TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 50, 0, false, false, false) 
   end
  end
  if IsControlJustPressed(0, 244) then
   local pos = GetEntityCoords(GetPlayerPed(-1), false) 
   ClearPedTasks(GetPlayerPed(-1))
   DeleteObject(boxObject)
   TriggerServerEvent('storage_box2:move', id, pos.x,pos.y,pos.z)
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

  for _, player in ipairs(GetActivePlayers()) do
    table.insert(players, player)
  end

  return players
end
