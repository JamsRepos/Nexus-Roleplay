local SuccessLimit = 0.175
local FishingRod = nil
local IsFishing = false
local CFish = false
local BarAnimation = 0
local PosX = 0.5
local PosY = 0.2
local blipson = false
local catch = nil
local isInAnimation = false
local selling_fish = false

local Fish = {
 [1] = {name = 'Catfish', price = 80, item = 3},
 [2] = {name = 'Catfish', price = 80, item = 3},
 [3] = {name = 'Catfish', price = 80, item = 3},
 [4] = {name = 'Catfish', price = 80, item = 3},
 [5] = {name = 'Cod', price = 110, item = 4},
 [6] = {name = 'Cod', price = 110, item = 4},
 [7] = {name = 'Salmon', price = 160, item = 5}
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
      if not selling_fish then
        DrawMarker(25, -245.244,-354.201, 29.985-0.95, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 3.0, 50, 102, 255, 200, 0, 0, 2, 0, 0, 0, 0)
        if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -245.244,-354.201, 29.985, true) < 2.0) then
          DrawText3Ds(-245.244,-354.201, 29.985,'~g~[E]~w~ Sell Fish')
            if IsControlJustPressed(0, 38) and not selling_fish then
              selling_fish = true
              Citizen.Wait(100)
              SuccessLimit = 0.175
              local catfish = (exports['core']:GetItemQuantity(3))--*100
              local cod = (exports['core']:GetItemQuantity(4))--*100
              local salmon = (exports['core']:GetItemQuantity(5))--*200
    
              TriggerEvent("inventory:removeQty", 3, catfish)
              TriggerEvent("inventory:removeQty", 4, cod)
              TriggerEvent("inventory:removeQty", 5, salmon)
              local fishcount = catfish+cod+salmon
              local payout = catfish*100+cod*120+salmon*200
              if payout > 0 then
                TriggerServerEvent("fishing:sellfish", payout)
                exports['NRP-notify']:DoHudText('success', 'You have sold '..fishcount..' fish for $'..payout)
                print(PlayerId())
                TriggerServerEvent("fish:moneylog", 'Fish Payment: '..fishcount..' sold for $'..payout)
                
                Citizen.Wait(5000)
                selling_fish = false
              else
                exports['NRP-notify']:DoHudText('error', 'You do not have any fish to sell.')
                Citizen.Wait(5000)
                selling_fish = false
              end
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
   ExecuteCommand("e fishing")
   CFish = true
   IsFishing = false
   isInAnimation = false
  end

  while CFish do
   Citizen.Wait(0)
   local finished = exports["skillbar"]:taskBar(2500,math.random(5,15))
   if finished ~= 100 then
    CFish = false
    isInAnimation = false
    ExecuteCommand("e c")
   else
    Wait(10)
    CFish = false
    isInAnimation = false
    ExecuteCommand("e c")
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
 
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    if isInAnimation then
      DisableControlAction(0, 245, true) -- T
      DisableControlAction(0, 73, true) -- X
      DisableControlAction(0, 168, true) -- F7
      DisableControlAction(0, 37, true) -- TAB
      DisableControlAction(0, 24, true) -- Attack
      DisableControlAction(0, 257, true) -- Attack 2
      DisableControlAction(0, 25, true) -- Aim
      DisableControlAction(0, 263, true) -- Melee Attack 1
    end
  end
end)