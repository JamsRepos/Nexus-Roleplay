local restraunts = {
  {x = -1193.290, y = -892.294, z = 13.995, id = 1}, -- Burger Shot
}

local currentStock = {}
local currentStore = nil

RegisterNetEvent('fastfood:getstock')
AddEventHandler('fastfood:getstock', function(results)
 currentStock = results
end)

local pattyDelivery = 0
local bunDelivery = 0

local nearPoint = false

Citizen.CreateThread(function()
 WarMenu.CreateLongMenu('food', "Menu")
 WarMenu.CreateLongMenu('fridge', "Fridge")
 WarMenu.CreateLongMenu('stocking', "Stock Listing")
 WarMenu.CreateLongMenu('stocklisting', "Stock Listing")
 while true do
  local coords = GetEntityCoords(GetPlayerPed(-1))
  Citizen.Wait(5)
  if not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
   for id,v in pairs(restraunts) do
    if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 15.0) then
     DrawMarker(25, v.x, v.y, v.z-0.99, 0, 0, 0, 0, 0, 0, 0.8,0.8,0.5, 255, 15, 15, 200, 0, true, 2, 0, 0, 0, 0)
     if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2) then
       drawTxt('~g~[E]~w~ Shop')
      if IsControlJustPressed(0, 38) then
       currentStore = v.id
       WarMenu.OpenMenu('food')
       TriggerServerEvent('fastfood:getstock', v.id)
      end
     end
    end
   end
  end

  if DecorGetInt(GetPlayerPed(-1), "Job") == 27 then
   if(GetDistanceBetweenCoords(coords, -1202.309, -894.618, 13.995, true) < 15.0) then
    DrawMarker(25, -1202.309, -894.618, 13.995-0.95, 0, 0, 0, 0, 0, 0, 0.65,0.65,0.5, 255, 255, 255, 200, 0, true, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(coords, -1202.309, -894.618, 13.995, true) < 1.2) then
     drawTxt('~g~[E]~w~ Fridge')
     if IsControlJustPressed(0, 38) then
      TriggerServerEvent('fastfood:getstock', 2)
      WarMenu.OpenMenu('fridge')
     end
    end
   end
  end
  
  --[[if DecorGetInt(GetPlayerPed(-1), "Job") == 3 then
    if(GetDistanceBetweenCoords(coords, 98.025, 6619.415, 32.435, true) < 15.0) then
     DrawMarker(25, 98.025, 6619.415, 32.435-0.95, 0, 0, 0, 0, 0, 0, 0.65,0.65,0.5, 255, 255, 255, 200, 0, true, 2, 0, 0, 0, 0)
     if(GetDistanceBetweenCoords(coords, 98.025, 6619.415, 32.435, true) < 1.2) then
      API_DrawTxt('~g~[E]~w~ Part Storage')
      if IsControlJustPressed(0, 38) then
       WarMenu.OpenMenu('stocklisting', "Parts")
       TriggerServerEvent('fastfood:getstock', 3)
       --TriggerServerEvent('fastfood:getstock', v.id)
      end
     end
    end
   end
  ]]--
  if pattyDelivery == 0 and bunDelivery == 0 and not IsPedInAnyVehicle(GetPlayerPed(-1), false) and DecorGetInt(GetPlayerPed(-1), "Job") == 28 then
   if(GetDistanceBetweenCoords(coords, -1200.733, -885.499, 13.492, true) < 15.0) then
    DrawMarker(25, -1200.733, -885.499, 13.492-0.95, 0, 0, 0, 0, 0, 0, 0.65,0.65,0.5, 255, 255, 255, 200, 0, true, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(coords, -1200.733, -885.499, 13.492, true) < 1.2) then
     drawTxt('~g~[E]~w~ Stock Ledger')
     if IsControlJustPressed(0, 38) then
      TriggerServerEvent('fastfood:getstock', 2)
      WarMenu.OpenMenu('stocking')
     end
    end
   end
  end

  if pattyDelivery == 1 and DecorGetInt(GetPlayerPed(-1), "Job") == 28 then
   if(GetDistanceBetweenCoords(coords, 1440.813, 1142.031, 114.325, true) < 15.0) then
    nearPoint = true
    DrawMarker(20, 1440.813, 1142.031, 114.325, 0, 0, 0, 0, 0, 0, 0.65,0.65,0.5, 255, 15, 15, 200, 0, true, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(coords, 1440.813, 1142.031, 114.325, true) < 1.2) then  
     drawTxt('~g~[E]~w~ Collect')
     if IsControlJustPressed(0, 38) then
      RemoveJobBlip()
      pattyDelivery = 2
      SetJobBlip(-1175.645, -882.759, 13.957)
      exports['NRP-notify']:DoHudText('inform', "Return the product to the restraunt")
     end
    end
   else
    nearPoint = false
   end
  end

  if bunDelivery == 1 and DecorGetInt(GetPlayerPed(-1), "Job") == 28 then
   if(GetDistanceBetweenCoords(coords, -302.295, 6212.453, 31.408, true) < 15.0) then
    nearPoint = true
    DrawMarker(20, -302.295, 6212.453, 31.408, 0, 0, 0, 0, 0, 0, 0.65,0.65,0.5, 255, 15, 15, 200, 0, true, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(coords, -302.295, 6212.453, 31.408, true) < 3.0) then
     drawTxt('~g~[E]~w~ Collect')
     if IsControlJustPressed(0, 38) then
      RemoveJobBlip()
      bunDelivery = 2
      SetJobBlip(-1175.645, -882.759, 13.957)
      exports['NRP-notify']:DoHudText('inform', "Return the product to the restraunt")
     end
    end
   else
    nearPoint = false
   end
  end

  if bunDelivery == 2 or pattyDelivery == 2 and DecorGetInt(GetPlayerPed(-1), "Job") == 28 and IsPedInAnyVehicle(GetPlayerPed(-1), false) then
   if(GetDistanceBetweenCoords(coords, -1175.645, -882.759, 13.957, true) < 15.0) then
    nearPoint = true
    DrawMarker(20, -1175.645, -882.759, 13.957, 0, 0, 0, 0, 0, 0, 0.65,0.65,0.5, 255, 15, 255, 200, 0, true, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(coords, -1175.645, -882.759, 13.957, true) < 1.2) then
     drawTxt('~g~[E]~w~ Drop Off')
     if IsControlJustPressed(0, 38) then
      RemoveJobBlip()
      local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1))
      SetEntityAsMissionEntity(vehicle, true, true)
      DeleteVehicle(vehicle)

      if bunDelivery == 2 then
       TriggerServerEvent('fastfood:addstock', 2, 93, math.random(30,50))
       TriggerServerEvent('jobs:paytheplayer', math.random(950, 1450), 'Fast Food: Bun')
       pattyDelivery = 0
       bunDelivery = 0
      elseif pattyDelivery == 2 then
       TriggerServerEvent('fastfood:addstock', 2, 92, math.random(30,50))
       TriggerServerEvent('jobs:paytheplayer', math.random(550, 600), 'Fast Food: Patty')
       pattyDelivery = 0
       bunDelivery = 0
      end
     end
    end
   else
    nearPoint = false
   end
  end

  if not IsPedInAnyVehicle(GetPlayerPed(-1), false) and DecorGetInt(GetPlayerPed(-1), "Job") == 27 then
   if(GetDistanceBetweenCoords(coords, -1198.722, -895.005, 13.995, true) < 15.0) then
    DrawMarker(25, -1198.722, -895.005, 13.995-0.99, 0, 0, 0, 0, 0, 0, 0.8,0.8,0.5, 255, 255, 255, 200, 0, true, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(coords, -1198.722, -895.005, 13.995, true) < 1.2) then
     drawTxt('~g~[E]~w~ Restock Drinks')
     if IsControlJustPressed(0, 38) then
      API_ProgressBar('Making Drink', 30)
      Wait(3000)
      TriggerServerEvent('fastfood:addstock', 1, 13, 10)
     end
    end
   end
  end

  if not IsPedInAnyVehicle(GetPlayerPed(-1), false) and DecorGetInt(GetPlayerPed(-1), "Job") == 27 then
   if(GetDistanceBetweenCoords(coords, -1199.720, -900.349, 13.995, true) < 15.0) then
    DrawMarker(25, -1199.720, -900.349, 13.995-0.99, 0, 0, 0, 0, 0, 0, 0.8,0.8,0.5, 255, 255, 255, 200, 0, true, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(coords, -1199.720, -900.349, 13.995, true) < 1.2) then
     drawTxt('~g~[E]~w~ Cook Cheese Burger')
     if IsControlJustPressed(0, 38) then
      if exports['core']:GetItemQuantity(92) >= 1 and exports['core']:GetItemQuantity(93) >= 1 then
       SetEntityCoords(GetPlayerPed(-1), -1199.747, -900.819, 13.995-0.95)
       SetEntityHeading(GetPlayerPed(-1), 124.934)
       TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_BBQ", 32, true)
       TriggerEvent("inventory:removeQty", 92, 1)
       TriggerEvent("inventory:removeQty", 93, 1)
       API_ProgressBar('Cooking Patty', 150)
       Wait(15000)
       API_ProgressBar('Warming Bun', 150)
       Wait(15000)
       API_ProgressBar('Assembling Burger', 100)
       Wait(10000)
       TriggerServerEvent('fastfood:addstock', 1, 14, 1)
       ClearPedTasks(GetPlayerPed(-1))
       if math.random(1, 100) <= 25 then
        local pay = math.random(250, 400)
        TriggerServerEvent('jobs:paytheplayer', pay, 'Fast Food: Cheese Burger')
        exports['NRP-notify']:DoHudText('inform', "Gordan Ramsey would love that greasy pile of meat! You have recieved a bonus tip.")
       else
        exports['NRP-notify']:DoHudText('inform', "You have created x1 Cheese Burger")
       end
      else
       exports['NRP-notify']:DoHudText('inform', "You need at least 1 Raw Patty and 1 Burger Bun to do this!")
      end
     end
    end
   end
  end

  if not IsPedInAnyVehicle(GetPlayerPed(-1), false) and DecorGetInt(GetPlayerPed(-1), "Job") == 27 then
    if(GetDistanceBetweenCoords(coords, -1198.660, -901.868, 13.995, true) < 15.0) then
     DrawMarker(25, -1198.660, -901.868, 13.995-0.99, 0, 0, 0, 0, 0, 0, 0.8,0.8,0.5, 255, 255, 255, 200, 0, true, 2, 0, 0, 0, 0)
     if(GetDistanceBetweenCoords(coords, -1198.660, -901.868, 13.995, true) < 1.2) then
      drawTxt('~g~[E]~w~ Make Healthy Sandwich')
      if IsControlJustPressed(0, 38) then
       if exports['core']:GetItemQuantity(93) >= 1 then
        SetEntityCoords(GetPlayerPed(-1), -1198.590, -902.208, 13.995-0.95)
        SetEntityHeading(GetPlayerPed(-1), 124.934)
        TriggerEvent("inventory:removeQty", 93, 1)
        API_ProgressBar('Cutting Open Bun', 100)
        Wait(10000)
        API_ProgressBar('Chopping Salad', 150)
        Wait(15000)
        API_ProgressBar('Assembling Sandwich', 150)
        Wait(15000)
        TriggerServerEvent('fastfood:addstock', 1, 106, 3)
        ClearPedTasks(GetPlayerPed(-1))
        if math.random(1, 100) <= 25 then
         local pay = math.random(250, 350)
         TriggerServerEvent('jobs:paytheplayer', pay, 'Fast Food: Healthy Sandwich')
         exports['NRP-notify']:DoHudText('inform', "Gordan Ramsey would love that green pile of veganism! You have recieved a bonus tip.")
        else
         exports['NRP-notify']:DoHudText('inform', "You have created x1 Healthy Sandwich")
        end
       else
        exports['NRP-notify']:DoHudText('inform', "You need at least 1 Burger Bun to do this!")
       end
      end
     end
    end
   end

  if WarMenu.IsMenuOpened('food') then
   for ind,v in pairs(currentStock) do
    if v.amount > 0 then
     if WarMenu.Button(v.stockname.." ["..v.amount.."]", " ~g~$"..v.price) then
      local item = v.itemid
      TriggerServerEvent('fastfood:removestock', currentStore, item, 1, v.price)
      TriggerServerEvent('shops:purchase', v.stockname, v.price, 1, item)
      TriggerServerEvent('fastfood:getstock', currentStore)
     end
    elseif v.amount <= 0 then
     if WarMenu.Button(v.stockname, "~r~No Stock") then
     exports['NRP-notify']:DoHudText('inform', "This item is currently out of stock!")
     end
    end
   end
   WarMenu.Display()
  end

  if WarMenu.IsMenuOpened('fridge') then
   for ind,v in pairs(currentStock) do
    if v.amount > 0 then
     if WarMenu.Button(v.stockname, " ["..v.amount.."]") then
      local item = v.itemid
      TriggerServerEvent('fastfood:removestock', 2, item, 1, 0)
      TriggerServerEvent('shops:purchase', v.stockname, 0, 1, item)
      TriggerServerEvent('fastfood:getstock', 2)
     end
    elseif v.amount <= 0 then
     if WarMenu.Button(v.stockname, "~r~No Stock") then
     exports['NRP-notify']:DoHudText('inform', "The suppliers need to collect more "..v.stockname)
     end
    end
   end
   WarMenu.Display()
  end

  if WarMenu.IsMenuOpened('stocklisting') then
   for ind,v in pairs(currentStock) do
    if v.amount > 0 then
     if WarMenu.Button(v.stockname.." ["..v.amount.."]", "~g~$"..v.price) then
      local item = v.itemid
      TriggerServerEvent('fastfood:removestock', 3, item, 1, 0)
      TriggerServerEvent('shops:purchase', v.stockname, 0, 1, item)
      TriggerServerEvent('fastfood:getstock', 3)
     end
    elseif v.amount <= 0 then
     if WarMenu.Button(v.stockname, "~r~No Stock") then
     exports['NRP-notify']:DoHudText('inform', "You need to collect more "..v.stockname)
     end
    end
   end
   WarMenu.Display()
  end

  if WarMenu.IsMenuOpened('stocking') then
   for ind,v in pairs(currentStock) do
    if WarMenu.Button(v.stockname.." Delivery", " ["..v.amount.."]") then
     local item = v.itemid
     WarMenu.CloseMenu()
     SpawnJobTruck('mule', -1202.440, -876.358, 13.301)
     if item == 92 then
      pattyDelivery = 1
      SetJobBlip(1440.813, 1142.031, 114.325)
     elseif item == 93 then
      bunDelivery = 1
      SetJobBlip(-302.295, 6212.453, 31.408)
     end
    end
   end
   WarMenu.Display()
  end

  if pattyDelivery == 1 and not nearPoint then
   drawTxt('~m~Drive to collect the ~g~Burger Patties')
  elseif bunDelivery == 1 and not nearPoint then
   drawTxt('~m~Drive to collect the ~g~Burger Buns')
  elseif pattyDelivery == 2 and not nearPoint then
   drawTxt('~m~Return and drop off the ~g~Burger Patties ~m~to be paid!')
  elseif bunDelivery == 2 and not nearPoint then
   drawTxt('~m~Return and drop off the ~g~Burger Buns ~m~to be paid!')
  end

 end
end)


function SpawnJobTruck(model, x,y,z)
 if DoesEntityExist(vehicle) then DeleteVehicle(vehicle) end
 local vehiclehash = GetHashKey(model)
 RequestModel(vehiclehash)
 while not HasModelLoaded(vehiclehash) do
  Citizen.Wait(0)
 end
 vehicle = CreateVehicle(vehiclehash, x,y,z, 122.814, true, false)
 SetVehicleDirtLevel(vehicle, 0)
 TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
 SetVehicleHasBeenOwnedByPlayer(vehicle, true)
 SetEntityAsMissionEntity(vehicle, true, true)
 SetVehicleMod(vehicle,16, 20)
 SetVehicleEngineOn(vehicle, true)
 SetVehicleLivery(vehicle, vehlivery)
 DecorRegister("_Fuel_Level", 3);
 DecorRegister("_Max_Fuel_Level", 3);
 DecorSetInt(vehicle, "_Max_Fuel_Level", 100000)
 DecorSetInt(vehicle, "_Fuel_Level", 100000)
 exports["onyxLocksystem"]:givePlayerKeys(GetVehicleNumberPlateText(vehicle))
end