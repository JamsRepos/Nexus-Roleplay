local storage_boxes = {}
local storage_boxes_props = {}
local box_inventory = {}
local box_id = nil

function DrawText3Ds(x,y,z)
  local text = "~g~[E]~w~ Open"
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

RegisterNetEvent('admin:storagebox')
AddEventHandler('admin:storagebox', function(boxx)
  TriggerServerEvent("storage_box:getInventory", boxx)
end)

RegisterNetEvent('admin:pickupSmall')
AddEventHandler('admin:pickupSmall', function()
  local coords = GetEntityCoords(GetPlayerPed(-1))
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
        moveStorageBox(box_id)
      else
       exports['NRP-notify']:DoHudText('inform', "Wrong Pass Code")
      end
     end
    end
end)

Citizen.CreateThread(function()
 while true do
  Wait(5)
  local coords = GetEntityCoords(GetPlayerPed(-1))
  for k,v in pairs(storage_boxes) do
   if(GetDistanceBetweenCoords(coords, v.location.x, v.location.y, v.location.z-0.95, true) < 1.2) then
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
      TriggerServerEvent("storage_box:getInventory", box_id)
     else
      exports['NRP-notify']:DoHudText('inform', "Wrong Pass Code")
     end
    end
   end
  end
 end
end)

RegisterNetEvent('storage_box:check')
AddEventHandler('storage_box:check', function(id, item,name,quantity)
  print(id, item,name,quantity)
  local meta = "This Item Contains No Meta Data"
    if tonumber(quantity) + getBoxQuantity() <= 80 then
      TriggerServerEvent('storage_box:additems', id, item, name, quantity,meta)
    else
      exports['NRP-notify']:DoHudText('error', 'Max Storage: 80 items')
    end
end)


function getBoxQuantity()
 local quantity = 0
 for i=1,#box_inventory do
  quantity = quantity + box_inventory[i].q
 end
 return quantity
end

function openNumberBox(text)
 local amount = "xxsdrtghyuujhdjsjenenfjfjtjtjtj"
 if(amount == "xxsdrtghyuujhdjsjenenfjfjtjtjtj") then
  showLoadingPrompt(text, 3)
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
  return amount
 end
end

RegisterNetEvent('storage_box:admindel')
AddEventHandler('storage_box:admindel', function(box_id)
 TriggerServerEvent("storage_box:getInventory", box_id)
 WarMenu.OpenMenu('storage_box')
end)

RegisterNetEvent('storage_box:updateitems')
AddEventHandler('storage_box:updateitems', function(items)
 box_inventory = items
end)

AddEventHandler('storage_box:new', function()
 WarMenu.CloseMenu()
 local pos = GetEntityCoords(GetPlayerPed(-1))
 local pin = openNumberBox("Create A Pass Code [NUMBERS ONLY]")
 TriggerServerEvent('storage_box:addbox', pos.x, pos.y, pos.z, pin)
end)

RegisterNetEvent('storage_box:updateboxes')
AddEventHandler('storage_box:updateboxes', function(boxes)
 storage_boxes = boxes
 -- Create new props
 for _,v in pairs(boxes) do 
  if not storage_boxes_props[v.box_id] then 
   SpawnObject(v.box_id, v.location)
  end
 end
end)

function SpawnObject(id, coords)
 local prophash = GetHashKey('v_serv_abox_04')
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

function moveStorageBox(id)
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
  drawTxt('~w~Press ~g~M~w~ To Drop Box')
  if not IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
   if not IsEntityPlayingAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 3) then
    TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 50, 0, false, false, false) 
   end
  end
  if IsControlJustPressed(0, 244) then
   local pos = GetEntityCoords(GetPlayerPed(-1), false) 
   ClearPedTasks(GetPlayerPed(-1))
   DeleteObject(boxObject)
   TriggerServerEvent('storage_box:move', id, pos.x,pos.y,pos.z)
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
