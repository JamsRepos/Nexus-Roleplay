local SuccessLimit = 0.175
local FishingRod = nil
local IsFishing = false
local CFish = false
local BarAnimation = 0
local PosX = 0.5
local PosY = 0.2
local TimerAnimation = 0.2
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
 {x = 4240.930, y = 5164.693, z = 0.412, dist = 200, drawmarker = false, markerdist = 200},
 {x = -1837.302, y = -1260.918, z = 8.616, dist = 1.1, drawmarker = true, markerdist = 20.0},
 {x = -1836.012, y = -1262.066, z = 8.616, dist = 1.1, drawmarker = true, markerdist = 20.0},
 {x = -1855.841, y = -1245.269, z = 8.615, dist = 1.1, drawmarker = true, markerdist = 20.0},
 {x = -1854.607, y = -1246.343, z = 8.615, dist = 1.1, drawmarker = true, markerdist = 20.0},
}

Citizen.CreateThread(function()
 WarMenu.CreateMenu('fisherman_boss', 'Fisherman')
 while true do
  Citizen.Wait(0)
              if not v.drawmarker then catch = Fish[math.random(1,7)] else catch = Fish[math.random(3,7)] end
    -- Fishing | Sell Point
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -245.244,-354.201, 29.985, true) < 50) then
    DrawMarker(25, -245.244,-354.201, 29.985-0.95, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 3.0, 50, 102, 255, 200, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -245.244,-354.201, 29.985, true) < 2.0) then
      DrawText3Ds(-245.244,-354.201, 29.985,'~g~[E]~w~ Sell Fish')
      if IsControlJustPressed(0, 38) then
      SuccessLimit = 0.175
      TriggerEvent("inventory:sellFish")
      --TriggerServerEvent('jobs:sellfish')
      end
    end
    end
 if exports['core']:GetItemQuantity(288) >= 1 and exports['core']:GetItemQuantity(289) >= 1 then
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 3866.848, 4464.227, 1.736, true) < 40) and not IsPedInAnyBoat(GetPlayerPed(-1)) then
      DrawMarker(25, 3866.848, 4464.227, 1.736, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 100, 252, 255, 200, 0, 0, 2, 0, 0, 0, 0)
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 3866.848, 4464.227, 1.736, true) < 1.5) then
        DrawText3Ds(3866.848, 4464.227, 1.736,'~g~[E]~w~ Hire A Boat')
      if IsControlJustPressed(0, 38) then
        WarMenu.OpenMenu('fisherman_boss')
    end
  end

   elseif(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 3866.78, 4479.975, 0.923, true) < 50) and IsPedInAnyBoat(GetPlayerPed(-1)) then
    DrawMarker(1, 3866.78, 4479.975, 0.943, 0, 0, 0, 0, 0, 0, 10.0, 10.0, 2.0, 100, 252, 255, 200, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 3866.78, 4479.975, 0.923, 1.736, true) < 25) then
      DrawText3Ds(3866.78, 4479.975, 0.923,'~g~[E]~w~ Return The Boat')
     if IsControlJustPressed(0, 38) then
      local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    SetEntityAsMissionEntity(vehicle, true, true)
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
      SetEntityCoords(GetPlayerPed(-1), 3866.848, 4464.227, 2.736)
     end
    end
  end
  -- Fishing Zone
   for k,v in pairs(fishing_zones) do
    if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < v.markerdist) then
     if v.drawmarker then DrawMarker(27, v.x, v.y, v.z-0.95, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 3.0, 50, 102, 255, 200, 0, 0, 2, 0, 0, 0, 0) end
     if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z, true) < v.dist) then
      DrawText3Ds(v.x, v.y, v.z,'~g~[E]~w~ Start Fishing')
      if IsControlJustPressed(0, 38) and not CFish then
       IsFishing = true
       BarAnimation = 0
      end
     end
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
    vehicle = CreateVehicle("tug", 3866.848, 4484.227, 1.736, 115, 1, 0)
    TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
    --SetVehicleNumberPlateText(vehicle, 'JOB')
    Notify("Return The Boat Before Going Off Duty")

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
      Notify("Your work vehicle was removed because you were too far away.")
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
   FishGUI()
   if TimerAnimation <= 0 then
    CFish = false
    TimerAnimation = 0.2
    ClearPedTasksImmediately(GetPlayerPed(-1))
    DeleteEntity(FishingRod)
    print('No Time Left')
   end
   if IsControlJustPressed(1, 38) then
    if BarAnimation >= SuccessLimit then
     Wait(10)
     CFish = false
     TimerAnimation = 0.2
     ClearPedTasksImmediately(GetPlayerPed(-1))
     DeleteEntity(FishingRod)
     SuccessLimit = SuccessLimit+0.00025
     local catch = Fish[math.random(1,7)]
     local chance = math.random(1,3)
     TriggerEvent("inventory:removeQty", 289, 1)
     if chance == 2 then 
      Notify('You Have Successfully Caught 1x '..catch.name)
      TriggerEvent("inventory:addQty", catch.item, 1)
     end
    else
     CFish = false
     TimerAnimation = 0.2
     ClearPedTasksImmediately(GetPlayerPed(-1))
     DeleteEntity(FishingRod)
     print('Fail')
    end
   end  
  end
 end 
end)

function FishGUI()
    DrawRect(PosX,PosY+0.030,TimerAnimation,0.008,255,255,0,255)
    DrawRect(PosX,PosY,0.2,0.05,0,0,0,255)
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
    AddTextComponentString("~w~Press ~g~[E] ~w~to Reel")
    DrawText(PosX, PosY-0.0125)
    TimerAnimation = TimerAnimation - 0.00050
    if BarAnimation >= SuccessLimit then
        DrawRect(PosX,PosY,BarAnimation,0.05,102,255,102,150)
    else
        DrawRect(PosX,PosY,BarAnimation,0.05,255,51,51,150)
    end
    if BarAnimation <= 0 then
        up = true
    end
    if BarAnimation >= PosY then
        up = false
    end
    if not up then
        BarAnimation = BarAnimation - 0.0015
    else
        BarAnimation = BarAnimation + 0.0015
    end
end

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
 