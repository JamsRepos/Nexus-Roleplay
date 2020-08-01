local SuccessLimit = 0.175
local FishingRod = nil
local IsFishing = false
local CFish = false
local BarAnimation = 0
local PosX = 0.5
local PosY = 0.2
local blipson = false
local catch = nil
local Fish = {
 [1] = {name = 'Catfish', price = 100, item = 3},
 [2] = {name = 'Catfish', price = 100, item = 3},
 [3] = {name = 'Catfish', price = 100, item = 3},
 [4] = {name = 'Catfish', price = 100, item = 3},
 [5] = {name = 'Cod', price = 120, item = 4},
 [6] = {name = 'Cod', price = 120, item = 4},
 [7] = {name = 'Salmon', price = 200, item = 5}
}

local fishing_zones = {
 {x = -2025.67, y = -1415.38, z = 1.61, dist = 100, drawmarker = false, markerdist = 200},
 {x = -1837.302, y = -1260.918, z = 8.616, dist = 1.1, drawmarker = true, markerdist = 20.0},
 {x = -1836.012, y = -1262.066, z = 8.616, dist = 1.1, drawmarker = true, markerdist = 20.0},
 {x = -1855.841, y = -1245.269, z = 8.615, dist = 1.1, drawmarker = true, markerdist = 20.0},
 {x = -1854.607, y = -1246.343, z = 8.615, dist = 1.1, drawmarker = true, markerdist = 20.0},
}

Citizen.CreateThread(function()
  WarMenu.CreateMenu('fisherman_boss', 'Fisherman')
  while true do
    local inveh = IsPedInAnyVehicle(GetPlayerPed(-1), false)
    Citizen.Wait(0)
    if DecorGetInt(GetPlayerPed(-1), "Job") == 5 and not blipson then FishingBlips() blipson = true end

    -- Fishing Zone
    for k,v in pairs(fishing_zones) do
      if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < v.markerdist) and DecorGetInt(GetPlayerPed(-1), "Job") == 5 then
        if v.drawmarker then DrawMarker(27, v.x, v.y, v.z-0.95, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 3.0, 50, 102, 255, 200, 0, 0, 2, 0, 0, 0, 0) end
          if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < v.dist) then
          DrawText3Ds(v.x, v.y, v.z,'~g~[E]~w~ Start Fishing')
          if IsControlJustPressed(0, 38) and not CFish and not IsPedInAnyBoat(GetPlayerPed(-1)) and not IsEntityInWater(GetPlayerPed(-1)) then
            if exports['core']:GetItemQuantity(288) >= 1 and exports['core']:GetItemQuantity(289) >= 1 then
              if not v.drawmarker then catch = Fish[math.random(5,7)] else catch = Fish[math.random(3,7)] end
              IsFishing = true
              BarAnimation = 0
            else
              exports['NRP-notify']:DoHudText('error', 'You need a fishing rod and fish bait to fish.')
            end
          end
        end
      end
    end

    -- Fishing | Sell Point
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -245.244,-354.201, 29.985, true) < 50) and DecorGetInt(GetPlayerPed(-1), "Job") == 5 and not inveh then
      
      DrawMarker(25, -245.244,-354.201, 29.985-0.95, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 3.0, 50, 102, 255, 200, 0, 0, 2, 0, 0, 0, 0)
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -245.244,-354.201, 29.985, true) < 2.0) then
        DrawText3Ds(-245.244,-354.201, 29.985,'~g~[E]~w~ Sell Fish')
          if IsControlJustPressed(0, 38) then
            SuccessLimit = 0.175
            local catfish = (exports['core']:GetItemQuantity(3))--*100
            local cod = (exports['core']:GetItemQuantity(4))--*100
            local salmon = (exports['core']:GetItemQuantity(5))--*200
  
            TriggerEvent("inventory:removeQty", 3, catfish)
            TriggerEvent("inventory:removeQty", 4, cod)
            TriggerEvent("inventory:removeQty", 5, salmon)
            local fishcount = catfish+cod+salmon
            local payout = catfish*100+cod*120+salmon*200
            print(payout)
            if payout > 0 then
              TriggerServerEvent("fishing:sellfish", payout)
              exports['NRP-notify']:DoHudText('success', 'You have sold '..fishcount..' fish for $'..payout)
            else
              exports['NRP-notify']:DoHudText('error', 'You do not have any fish to sell.')
            end
          end
      end
    end

    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1800.174, -1225.530, 1.575-0.95, true) < 40) and IsPedInAnyBoat(GetPlayerPed(-1)) and DecorGetInt(GetPlayerPed(-1), "Job") == 5 then
      DrawMarker(1, -1789.140, -1239.789, 0.00, 0, 0, 0, 0, 0, 0, 10.0, 10.0, 2.0, 100, 252, 255, 200, 0, 0, 2, 0, 0, 0, 0)
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1789.140, -1239.789, 0.00, 1.736, true) < 25) then
        DrawText3Ds(-1789.140, -1239.789, 0.00,'~g~[E]~w~ Return the Fishing Boat')
        if IsControlJustPressed(0, 38) then
          local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
          SetEntityAsMissionEntity(vehicle, true, true)
          Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
          SetEntityCoords(GetPlayerPed(-1), -1803.316, -1229.755, 1.593)
        end
      end
    end

    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1800.174, -1225.530, 1.575-0.95, true) < 40) and not IsPedInAnyBoat(GetPlayerPed(-1)) and DecorGetInt(GetPlayerPed(-1), "Job") == 5 then
      DrawMarker(25, -1800.174, -1225.530, 1.575-0.95, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 100, 252, 255, 200, 0, 0, 2, 0, 0, 0, 0)
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1800.174, -1225.530, 1.575-0.95, true) < 1.5) then
        DrawText3Ds(-1800.174, -1225.530, 1.575,'~g~[E]~w~ Rent a Fishing Boat')
        if IsControlJustPressed(0, 38) then
          WarMenu.OpenMenu('fisherman_boss')
        end
      end
    end


    -- Fisherman Menu
    if WarMenu.IsMenuOpened('fisherman_boss') then
      if WarMenu.Button('Hire Boat') then 
        RequestModel("tug")
        if vehicle ~= nil then
          DeleteVehicle(vehicle)
          vehicle = nil
        end
        vehicle = CreateVehicle("suntrap", -1783.83, -1241.01, 1.58, 153.00, 1, 0)
        TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)

        DecorRegister("_Fuel_Level", 3);
        DecorRegister("_Max_Fuel_Level", 3);
        DecorSetInt(vehicle, "_Max_Fuel_Level", 100000)
        DecorSetInt(vehicle, "_Fuel_Level", 100000)
        exports["onyxLocksystem"]:givePlayerKeys(GetVehicleNumberPlateText(vehicle))
        WarMenu.CloseMenu()
      end
      WarMenu.Display()
    end
  end
end)

-- Despawn vehicle if too far away
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(5000)
    if vehicle ~= nil and (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), GetEntityCoords(vehicle), true) > 100) then
      SetEntityAsMissionEntity(vehicle, false, false)
      DeleteVehicle(vehicle)
      vehicle = nil
      exports['NRP-notify']:DoHudText('error', 'Your work vehicle was removed because you were too far away.')
    end
  end
end)

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(0)
  while IsFishing do
   local time = 4*3000
   TaskStandStill(GetPlayerPed(-1), time+7000)
   FishingRod = AttachEntityToPed('prop_fishing_rod_01',60309, 0,0,0, 0,0,0)
   PlayAnim(GetPlayerPed(-1),'amb@world_human_stand_fishing@idle_a','idle_c',1,0)
   CFish = true
   IsFishing = false
  end

  while CFish do
   Citizen.Wait(0)
   local finished = exports["skillbar"]:taskBar(2500,math.random(5,15))
   if finished ~= 100 then
    CFish = false
    ClearPedTasksImmediately(GetPlayerPed(-1))
    DeleteEntity(FishingRod)
   else
    Wait(10)
    CFish = false
    ClearPedTasksImmediately(GetPlayerPed(-1))
    DeleteEntity(FishingRod)
    local chance = math.random(1,3)
    TriggerEvent("inventory:removeQty", 289, 1)
    if chance == 2 then 
     exports['NRP-notify']:DoHudText('success', 'You have successfully caught 1x '..catch.name)
     TriggerEvent("inventory:addQty", catch.item, 1)
    end
   end
  end
 end 
end)

function FishingBlips()
  for k,v in pairs(fishing_zones) do
   local blip = AddBlipForCoord(v.x, v.y, v.z)
   SetBlipSprite (blip, 88)
   SetBlipDisplay(blip, 4)
   SetBlipScale  (blip, 0.8)
   SetBlipColour (blip, 3)
   SetBlipAsShortRange(blip, true)
   BeginTextCommandSetBlipName("STRING")
   AddTextComponentString("Fishing Zone")
   EndTextCommandSetBlipName(blip)
  end

  local blip2 = AddBlipForCoord(-245.244,-354.201, 29.985)
  SetBlipSprite (blip2, 88)
  SetBlipDisplay(blip2, 4)
  SetBlipScale  (blip2, 0.6)
  SetBlipColour (blip2, 3) 
  SetBlipAsShortRange(blip2, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString("Fish Sell Point")
  EndTextCommandSetBlipName(blip2)
end

function AttachEntityToPed(prop,bone_ID,x,y,z,RotX,RotY,RotZ)
    if DoesEntityExist(FishingRod) then DeleteEntity(FishingRod) end
  BoneID = GetPedBoneIndex(GetPlayerPed(-1), bone_ID)
  obj = CreateObject(GetHashKey(prop),  1729.73,  6403.90,  34.56,  true,  true,  true)
  AttachEntityToEntity(obj, GetPlayerPed(-1), BoneID, x,y,z, RotX,RotY,RotZ,  false, false, false, false, 2, true)
  return obj
end

function PlayAnim(ped,base,sub,nr,time) 
  Citizen.CreateThread(function() 
    RequestAnimDict(base) 
    while not HasAnimDictLoaded(base) do 
      Citizen.Wait(1) 
    end
    if IsEntityPlayingAnim(ped, base, sub, 3) then
      ClearPedSecondaryTask(ped) 
    else 
      for i = 1,nr do 
        TaskPlayAnim(ped, base, sub, 4.0, -1, -1, 50, 0, false, false, false)
        Citizen.Wait(time) 
      end 
    end 
  end) 
end
 