local smokeonwater = {{x = 1039.516, y = -3195.922, z= -38.169, id = 3},}
local SeedDelivery = 0
local FertilizerDelivery = 0
local nearPoint = false
local currentStock = {}
local currentStore = nil
RegisterNetEvent('xz:getpoints')
AddEventHandler('xz:getpoints',function(name,value)
  job = name
  points = value 
end)


local PlayerData = {}

local LevelOne = 25 -- money increase 25% for picking up stock -- done
local LevelTwo = 50 -- closer pick up points seed -- done
local LevelThree = 75 -- ability to grow cannabis -- DONE
local LevelFour = 100 -- collect water faster -- DONE
local LevelFive = 150 -- quality drains slower --- done
local LevelSix = 200 -- 25% increase pay growing -- done
local LevelSeven = 250 -- weed delivery -- done -- done
local LevelEight = 350 -- water % drains slower --- DONE
local LevelNine = 500 -- 25% faster grow time -- done
local LevelTen = 750 -- you can sell 1-3 medical bags per drop -- done

local grower = DecorGetInt(GetPlayerPed(-1), "Job") == 41
local stockboy = DecorGetInt(GetPlayerPed(-1), "Job") == 46
local seller = DecorGetInt(GetPlayerPed(-1), "Job") == 47




Citizen.CreateThread(function()
  WarMenu.CreateLongMenu('stock',"Menu")
  WarMenu.CreateLongMenu('storage',"Storage")
  WarMenu.CreateLongMenu('water',"Water Storage")
  WarMenu.CreateLongMenu('jobs',"jobs")
  WarMenu.CreateLongMenu('stocklisting',"Stock listing") 
  while true do
    Citizen.Wait(5)
    local grower = DecorGetInt(GetPlayerPed(-1), "Job") == 41
    local stockboy = DecorGetInt(GetPlayerPed(-1), "Job") == 46
    local seller = DecorGetInt(GetPlayerPed(-1), "Job") == 47
    local coords = GetEntityCoords(GetPlayerPed(-1))
    local veh = GetVehiclePedIsUsing(GetPlayerPed(-1))
    local model = GetEntityModel(veh)
   if not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
    for id,v in pairs(smokeonwater) do
    if DecorGetInt(GetPlayerPed(-1), "Job") == 47 then    --- weed delivery @@@@ ADD IN COORDS
     if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z , true) < 15.0) then
      DrawMarker(25, v.x, v.y, v.z-0.99, 0, 0, 0, 0, 0, 0, 0.8,0.8,0.5, 255, 15, 15, 200, 0, true, 2, 0, 0, 0, 0)
      if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2) then
       Jaybee(v.x, v.y, v.z,'~g~[E]~w~ Get Weed To Deliver')
       if IsControlJustPressed(0,38) then
        TriggerServerEvent('FL_Perks:LevelChecks')
        Wait(100)
        if tostring(job) == 'SOTW' then
         if tonumber(points) >= 250 then
          currentStore = v.id
          WarMenu.OpenMenu('stock')
           TriggerServerEvent('xz:getstock',v.id)
         else
          exports['NRP-notify']:DoHudText('inform', "You Need Atleast 75 Points To Use the Grow Room")
         end
        end   
       end
      end
     end
    end --- working
   end
  end
-----------------------------------------------------------------SMOKE ON WATER-----------------------------------------------------------------------------------
   if DecorGetInt(GetPlayerPed(-1), "Job") == 41 then ---- where you fill up the stock @@@@ ADD IN COORDS
    if(GetDistanceBetweenCoords(coords,1031.106,  -3203.178,  -38.193,true) < 15.0) then
     DrawMarker(25,1031.106,  -3203.178,  -38.193-0.95, 0, 0, 0, 0, 0, 0, 0.65,0.65,0.5, 255, 255, 255, 200, 0, true, 2, 0, 0, 0, 0)
     if(GetDistanceBetweenCoords(coords,1031.106,  -3203.178,  -38.193 ,true) < 1.2) then
        Jaybee(1031.106,  -3203.178,  -38.193,'~g~[E]~w~ Open Storage') 
      if IsControlJustPressed(0,38) then
        TriggerServerEvent('FL_Perks:LevelChecks')
        Wait(100)
       if tostring(job) == 'SOTW' then
        if tonumber(points) >= 75 then
          TriggerServerEvent('xz:getstock', 1)     
          WarMenu.OpenMenu('storage')
        else
          exports['NRP-notify']:DoHudText('inform', "You Need Atleast 75 Points To Use the Grow Room")
        end 
       end  
      end
     end
    end
   end  
------------------------------------------------------------------------------------------------------------------------------------------------------------------
 if DecorGetInt(GetPlayerPed(-1), "Job") == 41 then ---- where you fill up the stock @@@@ ADD IN COORDS
  if(GetDistanceBetweenCoords(coords, 1064.883, -3205.760,-39.055,true) < 15.0) then
   DrawMarker(25, 1064.883, -3205.760,-39.055-0.95, 0, 0, 0, 0, 0, 0, 0.65,0.65,0.5, 255, 255, 255, 200, 0, true, 2, 0, 0, 0, 0)
   if(GetDistanceBetweenCoords(coords, 1064.883, -3205.760,-39.055 ,true) < 1.2) then
      Jaybee(1064.883, -3205.760,-39.055,'~g~[E]~w~ Open Water Storage') 
    if IsControlJustPressed(0,38) then
      TriggerServerEvent('FL_Perks:LevelChecks')
      Wait(100)
     if tostring(job) == 'SOTW' then
      if tonumber(points) >= 100 then
        TriggerServerEvent('xz:getstock', 2)    -- working
        WarMenu.OpenMenu('water')
      else
        exports['NRP-notify']:DoHudText('inform', "You Need Atleast 75 Points To Use the Grow Room")
      end
     end     
    end
   end
  end
 end   
----------------------- ------------------------------------------------------------------------------------------------------------------------------------------
   if SeedDelivery == 0 and FertilizerDelivery == 0 and not IsPedInAnyVehicle(GetPlayerPed(-1), false) and DecorGetInt(GetPlayerPed(-1), "Job") == 46 then
    if(GetDistanceBetweenCoords(coords,-1168.810,  -1572.753,  4.664,true) < 15.0) then
     DrawMarker(25,-1168.810,  -1572.753,  4.664-0.95, 0, 0, 0, 0, 0, 0, 0.65,0.65,0.5, 255, 255, 255, 200, 0, true, 2, 0, 0, 0, 0)
      if(GetDistanceBetweenCoords(coords,-1168.810,  -1572.753,  4.664 ,true) < 1.2) then
       Jaybee(-1168.810,  -1572.753,  4.664 ,'~g~[E]~w~ Stock Jobs')
       if IsControlJustPressed(0,38) then
        TriggerServerEvent('FL_Perks:LevelChecks')
        TriggerServerEvent('xz:getstock', 1) --- working
        WarMenu.OpenMenu('jobs')
       end
      end
    end
   end
------------------------------------------------------------------------------------------------------------------------------------------------------------------
 if SeedDelivery == 1 and stockboy then
  if(GetDistanceBetweenCoords(coords, 2214.748,  5609.471,  54.5316, true) < 15.0) then
   nearPoint = true
   DrawMarker(20, 2214.748,  5609.471,  54.5316, 0, 0, 0, 0, 0, 0, 0.65,0.65,0.5, 255, 255, 0, 200, 0, true, 2, 0, 0, 0, 0)
   if(GetDistanceBetweenCoords(coords, 2214.748,  5609.471,  54.5316, true) < 1.2) then
     Jaybee(2214.748,  5609.471,  54.816,'~g~[E]~w~ Collect Medical Weed Seeds')
        if IsControlJustPressed(0,38) then
         if model == 699456151 then
            TriggerEvent("mythic_progbar:client:progress", {
              name = "sfert",
              duration = 20000,
              label = "The truck is being filled",
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
                RemoveJobBlip()
                SeedDelivery = 2
                SetJobBlip(-1152.231,  -1564.938, 4.382)
                exports['NRP-notify']:DoHudText('inform', "Return the Seeds Back to Smoke on the Water")
              end
            end)
          else
           exports['NRP-notify']:DoHudText('inform', "Get your Work Vehicle Otherwise the farmer wont give you the Seeds")
          end
        end
       end
    else
     nearPoint = false
    end  --- working
   end   
   
   if SeedDelivery == 3 and stockboy then
    if(GetDistanceBetweenCoords(coords, 2331.68,  2557.081,  46.667, true) < 15.0) then
     nearPoint = true
     DrawMarker(20, 2331.68,  2557.081,  46.667, 0, 0, 0, 0, 0, 0, 0.65,0.65,0.5, 255, 255, 0, 200, 0, true, 2, 0, 0, 0, 0)
     if(GetDistanceBetweenCoords(coords, 2331.68,  2557.081,  46.667, true) < 1.2) then
       Jaybee(2331.68,  2557.081,  46.667,'~g~[E]~w~ Collect Medical Weed Seeds')
          if IsControlJustPressed(0,38) then
           if model == 699456151 then
              TriggerEvent("mythic_progbar:client:progress", {
                name = "sfert",
                duration = 20000,
                label = "The truck is being filled",
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
                  RemoveJobBlip()
                  SeedDelivery = 2
                  SetJobBlip(-1152.231,  -1564.938, 4.382)
                  exports['NRP-notify']:DoHudText('inform', "Return the Seeds Back to Smoke on the Water")
                end
              end)
            else
             exports['NRP-notify']:DoHudText('inform', "Get your Work Vehicle Otherwise the farmer wont give you the Seeds")
            end
          end
         end
      else
       nearPoint = false
      end  --- working
     end     
------------------------------------------------------------------------------------------------------------------------------------------------------------------
   if FertilizerDelivery == 1 and stockboy then
    if(GetDistanceBetweenCoords(coords,2757.389,  3468.403,  55.733,true) < 15.0) then
      nearPoint = true
      DrawMarker(20,2757.389,  3468.403,  55.733, 0, 0, 0, 0, 0, 0, 0.65,0.65,0.5, 255, 15, 15, 200, 0, true, 2, 0, 0, 0, 0)
       if(GetDistanceBetweenCoords(coords,2757.389,  3468.403,  55.733, true) < 3.0) then
        Jaybee(2757.389,  3468.403,  55.733,'~g~[E]~w~ Collect Fertilizer')      
        if IsControlJustPressed(0,38) then
         if model == 699456151 then
          ---ADD IN PROGRESS BAR VAN IS BEING FILLED
          TriggerEvent("mythic_progbar:client:progress", {
            name = "cfert",
            duration = 20000,
            label = "The truck is being filled",
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
              RemoveJobBlip()
              FertilizerDelivery = 2
              SetJobBlip(-1152.231,  -1564.938, 4.382)
              exports['NRP-notify']:DoHudText('inform', "Return the Fertilizer Back to Smoke on the Water")
            end
          end)
         else
          exports['NRP-notify']:DoHudText('inform', "Get your Work Vehicle Otherwise they wont give you the fertilizer")
         end
        end
       end
    else
     nearPoint = false
    end
   end -- working
------------------------------------------------------------------------------------------------------------------------------------------------------------------

   if SeedDelivery == 2 or FertilizerDelivery == 2 and stockboy and IsPedInAnyVehicle(GetPlayerPed(-1), false)  then
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-1152.231, -1564.938, 4.392,true) < 15.0) then --- add in coords
     nearPoint = true
     DrawMarker(20,-1152.231,  -1564.938, 4.392, 0, 0, 0, 0, 0, 0, 0.65,0.65,0.5, 255, 15, 15, 200, 0, true, 2, 0, 0, 0, 0) --- add in coord
     if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-1152.231,  -1564.938, 4.392, true) < 3.0) then --- add in coords
      Jaybee(-1152.231,  -1564.938, 4.382,'~g~[E]~w~ Deliver products to Smoke On The Water')
      if IsControlJustPressed(0,38) then
       if model == 699456151 then
        TriggerEvent("mythic_progbar:client:progress", {
          name = "ceeert",
          duration = 10000,
          label = "emptying out the truck ",
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
            TriggerServerEvent('FL_Perks:LevelChecks')
            Wait(1000)
            RemoveJobBlip()
           local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1))
            SetEntityAsMissionEntity(vehicle, true, true)
            Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle))
           if SeedDelivery == 2 then 
            local payday = math.random(1400,1900)
              local payday2 = math.random(1100,1500)
             if tostring(job) == 'SOTW' then           
             if tonumber(points) >= 25 then
              TriggerServerEvent('xz:addstock', 1, 295, math.random(12,36))  ----ITEM 295 NEW SEEDS
              TriggerServerEvent("jobs:paytheplayer", payday, 'SOTW: Delivery')             
              TriggerServerEvent('points:add','SOTW', 1)
              SeedDelivery = 0
              FertilizerDelivery = 0
             else
              TriggerServerEvent('xz:addstock', 1, 295, math.random(12,36))  ----ITEM 295 NEW SEEDS
              TriggerServerEvent("jobs:paytheplayer", payday2, 'SOTW: Delivery')
              TriggerServerEvent('points:add','SOTW', 1)           
              SeedDelivery = 0
              FertilizerDelivery = 0
             end
            end
           elseif FertilizerDelivery == 2 then
            local payday = math.random(1400,1900)
              local payday2 = math.random(1100,1500)
            if tostring(job) == 'SOTW' then
              if tonumber(points) >= 25 then
               TriggerServerEvent('xz:addstock', 1, 297, math.random(12,36))  ----ITEM 295 NEW SEEDS
               TriggerServerEvent("jobs:paytheplayer", payday, 'SOTW: Delivery')
               TriggerServerEvent('points:add','SOTW', 1)
               SeedDelivery = 0
               FertilizerDelivery = 0
              else
                TriggerServerEvent('xz:addstock', 1, 295, math.random(12,36))  ----ITEM 295 NEW SEEDS
                TriggerServerEvent("jobs:paytheplayer", payday2, 'SOTW: Delivery')              
                TriggerServerEvent('points:add','SOTW', 1)
                SeedDelivery = 0
                FertilizerDelivery = 0
              end
             end
            end
          end
        end)
       else
        SeedDelivery = 0
        FertilizerDelivery = 0
        RemoveJobBlip()
        exports['NRP-notify']:DoHudText('inform', "The Boss knows you didnt didnt bring back the work truck and recovery and repairs cost him $2000 so you haven't been paid for this run")
       end
      end
    end
   else
     nearPoint = false
    end
   end   --working
------------------------------------------------------------------------------------------------------------------------------------------------------------------
   if not IsPedInAnyVehicle(GetPlayerPed(-1), false) and DecorGetInt(GetPlayerPed(-1), "Job") == 41 then
    if(GetDistanceBetweenCoords(coords,1064.219,  -3202.341,  -39.048, true) < 15.0) then --- add in coords
     DrawMarker(25,1064.919,  -3202.341,  -39.048-0.95, 0, 0, 0, 0, 0, 0, 0.8,0.8,0.5, 255, 255, 255, 200, 0, true, 2, 0, 0, 0, 0) --- add in coords
     if(GetDistanceBetweenCoords(coords,1064.919,  -3202.341,  -39.048, true) < 1.2) then --- add in coords
      Jaybee(1064.919,  -3202.341,  -39.048,'~g~[E]~w~ Restock Ph Neutral Water')
      if IsControlJustPressed(0, 38) then
        TriggerServerEvent('FL_Perks:LevelChecks')
        Wait(100)
       if tostring(job) == 'SOTW' then
        if tonumber(points) >= 100 then
          TriggerEvent("mythic_progbar:client:progress", {
            name = "cfert",
            duration = 3750,
            label = "Filling up Bottles and PH Testing the Water",
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
             },
             animation = {
              animDict = "amb@prop_human_bum_bin@idle_a",
              anim = "idle_a",
            },
          }, function(status)
            if not status then
              local bottles = math.random(2,5)
              TriggerServerEvent('xz:addstock', 2, 296, bottles)
              exports['NRP-notify']:DoHudText('success', "You manage to succesfully test and fill "..bottles.." bottles of water!")
              if math.random(1, 100) <= 3 then
               local pay = math.random(50, 120)
               TriggerServerEvent('jobs:paytheplayer', pay, 'SOTW: Restock Water')
               exports['NRP-notify']:DoHudText('inform', "The Boss Can See Your Extra Effort's Heres a Bonus.")
              end 
            end
           end)
        elseif tonumber(points) >= 75 then 
          TriggerEvent("mythic_progbar:client:progress", {
            name = "cfert",
            duration = 5000,
            label = "Filling up Bottles and PH Testing the Water",
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
             },
             animation = {
              animDict = "amb@prop_human_bum_bin@idle_a",
              anim = "idle_a",
            },
          }, function(status)
            if not status then
              local bottles = math.random(2,5)
              TriggerServerEvent('xz:addstock', 2, 296, bottles)
              exports['NRP-notify']:DoHudText('success', "You manage to succesfully test and fill "..bottles.." bottles of water!")
              if math.random(1, 100) <= 3 then
               local pay = math.random(50, 120)
               TriggerServerEvent('jobs:paytheplayer', pay, 'SOTW: Restock Water')
               exports['NRP-notify']:DoHudText('inform', "The Boss Can See Your Extra Effort's Heres a Bonus.")
              end 
            end
           end)
        else --- NEED FIXING
         exports['NRP-notify']:DoHudText('inform', "You Need Atleast 75 Points To Use the Grow Room")
        end
       end
      end
     end
    end
   end --- working
   
------------------------------------------------------------------------------------------------------------------------------------------------------------------
 if not IsPedInAnyVehicle(GetPlayerPed(-1), false) and grower or not IsPedInAnyVehicle(GetPlayerPed(-1), false) and seller then
  if(GetDistanceBetweenCoords(coords,-1147.430, -1562.204, 4.390, true) < 20) then
   DrawMarker(27,-1147.430, -1562.204, 4.390-0.95, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 0,255,123,255, 0, 0, 2, 0, 0, 0, 0)
   if(GetDistanceBetweenCoords(coords,-1147.430, -1562.204, 4.390, true) < 1.2) then
    Jaybee(-1147.430, -1562.204, 4.390,'~g~[E]~w~  Enter Medical Weed Farm')
    if IsControlJustPressed(0, 38) then
      TriggerServerEvent('FL_Perks:LevelChecks')
       if tostring(job) == 'SOTW' then
        if tonumber(points) >= 75 then
         Teleport(1065.890, -3183.458, -39.164)
        else
         exports['NRP-notify']:DoHudText('inform', "You Need Atleast 75 Points To Use the Grow Room") 
        end
      end
    end
   end
  end

  if (GetDistanceBetweenCoords(coords, 1065.890, -3183.458, -39.164, true) < 20) then  
   DrawMarker(27, 1065.890, -3183.458, -39.164-0.95, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 0,255,123,255, 0, 0, 2, 0, 0, 0, 0)
   if(GetDistanceBetweenCoords(coords, 1065.890, -3183.458, -39.164, true) < 1.2) then
    Jaybee(1065.890, -3183.458, -39.164,'~g~[E]~w~ Exit Medical Weed Farm')
    if IsControlJustPressed(0, 38) then
      TriggerServerEvent('FL_Perks:LevelChecks')
      Wait(100)
     if tostring(job) == 'SOTW' then
      if tonumber(points) >= 75 then
      Teleport(-1147.430, -1562.204, 4.390)
      else
      exports['NRP-notify']:DoHudText('inform', "You Need Atleast 75 Points To Use the Grow Room") 
      end
     end 
    end
   end
  end
 end -- working
 --------------------------------------------------------------------------
   if WarMenu.IsMenuOpened('stock') then
    for ind,v in pairs(currentStock) do
     if v.amount > 0 then
      if WarMenu.Button(v.stockname.." ["..v.amount.."]") then
       local item = v.itemid
       TriggerServerEvent('xz:removestock', 3, item, 1, 0)
       TriggerServerEvent('shops:purchase', v.stockname, v.price, 1, item)
       --TriggerServerEvent('bank:intoSharedBank', v.price, 2)
       TriggerServerEvent('xz:getstock', currentStore)
      end
     elseif v.amount <= 0 then
      if WarMenu.Button(v.stockname, "~r~No Stock") then
      exports['NRP-notify']:DoHudText('inform', "This item is currently out of stock!")
      end
     end
    end
    WarMenu.Display()
   end -- working
------------------------------------------------------------------------------------------------------------------------------------------------------------------
   if WarMenu.IsMenuOpened('storage') then
    for ind,v in pairs(currentStock) do
     if v.amount > 0 then
      if WarMenu.Button(v.stockname, " ["..v.amount.."]") then
       local item = v.itemid
       TriggerServerEvent('xz:removestock', 1, item, 1, 0)
       TriggerServerEvent('shops:purchase', v.stockname, 0, 1, item)
       TriggerServerEvent('xz:getstock', 1)
      end
     elseif v.amount <= 0 then
      if WarMenu.Button(v.stockname, "~r~No Stock") then
      exports['NRP-notify']:DoHudText('inform', "The suppliers need to collect more "..v.stockname)
      end
     end
    end
    WarMenu.Display()
   end --- working
   ------------------------------------------------------------------------------------------------------------------------------------------------------------------
   if WarMenu.IsMenuOpened('water') then
    for ind,v in pairs(currentStock) do
     if v.amount > 0 then
      if WarMenu.Button(v.stockname, " ["..v.amount.."]") then
       local item = v.itemid
       TriggerServerEvent('xz:removestock', 2, item, 1, 0)
       TriggerServerEvent('shops:purchase', v.stockname, 0, 1, item)
       TriggerServerEvent('xz:getstock', 2)
      end
     elseif v.amount <= 0 then
      if WarMenu.Button(v.stockname, "~r~No Stock") then
      exports['NRP-notify']:DoHudText('inform', "The suppliers need to collect more "..v.stockname)
      end
     end
    end
    WarMenu.Display()
   end --- working
------------------------------------------------------------------------------------------------------------------------------------------------------------------
   if WarMenu.IsMenuOpened('stocklisting') then
    for ind,v in pairs(currentStock) do
     if v.amount > 0 then
      if WarMenu.Button(v.stockname.." ["..v.amount.."]") then
       local item = v.itemid
       TriggerServerEvent('xz:removestock', currentStore, item, 1, 0)
       TriggerServerEvent('shops:purchase', v.stockname, 0, 1, item)
       TriggerServerEvent('xz:getstock', 1)
      end
     elseif v.amount <= 0 then
      if WarMenu.Button(v.stockname, "~r~No Stock") then
      exports['NRP-notify']:DoHudText('inform', "You need to collect more "..v.stockname)
      end
     end
    end
    WarMenu.Display()
   end --- working
--------------------------------########################################################################################------------------------------------------
   if WarMenu.IsMenuOpened('jobs') then
    for ind,v in pairs(currentStock) do
     if WarMenu.Button(v.stockname.." :", " ["..v.amount.."]") then
     
      local item = v.itemid
      WarMenu.CloseMenu()
      if item == 295 then
        TriggerServerEvent('FL_Perks:LevelChecks')       
        print("one")     
       if tostring(job) == 'SOTW' then
        print("two")
        if tonumber(points) >= 50 then  
         print("three")
         SeedDelivery = 3  
         SetJobBlip(2331.68,  2557.081,  46.667)
         SpawnStonerCar('surfer',-1158.379, -1588.915, 4.296) 
         exports['NRP-notify']:DoLongHudText('inform', "Drive to the marked GPS location to collect the " ..v.stockname.."!") 
        else
          print("four")
         SeedDelivery = 1  
         SetJobBlip(2214.748,  5609.471,  54.316)
         SpawnStonerCar('surfer',-1158.379, -1588.915, 4.296) 
         exports['NRP-notify']:DoLongHudText('inform', "Drive to the marked GPS location to collect the " ..v.stockname.."!")
        end
       end
      elseif item == 297 then
       FertilizerDelivery = 1
       SetJobBlip(2757.389,  3468.403,  55.733)
       SpawnStonerCar('surfer',-1158.379, -1588.915, 4.296) 
       exports['NRP-notify']:DoLongHudText('inform', "Drive to the marked GPS location to collect the " ..v.stockname.."!")
      end
     end
    end
    WarMenu.Display()
   end   -- working
  end    
 end)

----------------------------------------------------------------XZURV--NEW--WEED-----------------------------------------------------------------------------------
--------------------------------########################################################################################-------------------------------------------
-------------------------------------------------------------------- LOCALS---------------------------------------------------------------------------------------
 local stageOne = false
 local stageTwo = false
 local stageThree = false
 local dryingStage = false
 local finalstage = false
 local growthTimer = 0
 local weedQuality = 0
 local weedThirst = 0
 local dryingTimer = 0
 local weedDrying = false
 local weedPlanted = false
 local weedPruned = false
 local weedCut = false
 
 local smrax = math.random(42,48)
 local gallows = math.random(36,41)
 local xzurv = math.random(33,36)
 local jopu = math.random(29,32)
 local dogShitGrower = math.random(25,28)
 local horseShitGrower = math.random(21,24)
 local wanker = math.random(16,19)
 local boostedPleb = math.random(12,15)
 local nexus = math.random(9,11)
 local forged = math.random(7,8)
 local monkey = math.random(4,6)
 local manWithNoHands = math.random(1,3)
 

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------STAGE LOCALS-----------------------------------------------------------------------------------
 Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
  local coords = GetEntityCoords(GetPlayerPed(-1))
  local stageOneMarker = (GetDistanceBetweenCoords(coords,1056.075,-3205.219,-39.105,true) < 15.0)
  local stageTwoMarker = (GetDistanceBetweenCoords(coords,1061.067, -3206.687, -39.142,true) < 15.0)
  local stageThreeMarker = (GetDistanceBetweenCoords(coords,1058.352, -3200.884, -39.050,true) < 15.0)
  local dryingStageMarker = (GetDistanceBetweenCoords(coords,1040.816,-3202.365,-38.164,true) < 20.0)
  local finalStageMarker = (GetDistanceBetweenCoords(coords,1039.216,-3205.402,-38.166,true) < 15.0)
  local stageOneText = (GetDistanceBetweenCoords(coords,1056.075,-3205.219,-39.105,true) < 1.5)
  local stageTwoText = (GetDistanceBetweenCoords(coords,1061.067, -3206.687, -39.142,true) < 1.5)
  local stageThreeText = (GetDistanceBetweenCoords(coords,1058.352, -3200.884, -39.050,true) < 1.5)
  local dryingStageText = (GetDistanceBetweenCoords(coords,1040.816,-3202.365,-38.164,true) < 1.5)
  local finalStageText = (GetDistanceBetweenCoords(coords,1039.216,-3205.402,-38.166,true) < 1.5)
  local control = IsControlJustPressed(0,38)
  local water = IsControlJustPressed(0,74)
  local ped = PlayerPedId() 
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------TIMERS--------------------------------------------------------------------------------------
  if dryingTimer <= 0 and weedDrying == true then
    dryingStage = false
    finalStage = true     
    if finalStage and dryingStage == false then
      if finalStageMarker then
          DrawMarker(25, 1038.216,-3205.402,-38.166-0.87, 0, 0, 0, 0, 0, 0, 0.8,0.8,0.5, 255, 15, 15, 200, 0, true, 2, 0, 0, 0, 0)
        if finalStageText then
          Jaybee(1038.216,-3205.402,-38.166+0.1,'~g~[E]~w~  Bag Up Finished Product')
          if control then
              TriggerEvent("mythic_progbar:client:progress", {name = "Unpacking",duration = 25000,label = "weighing and bagging 1/4's of Medical weed",useWhileDead = false,canCancel = false,controlDisables = {disableMovement = true,disableCarMovement = true,disableMouse = false,disableCombat = true,},animation = {animDict = "missheistdockssetup1clipboard@idle_a", anim = "idle_a", flags = 49, }, prop = { model = "prop_paper_bag_small",} }, function(status)if not status then
              if weedQuality >= 105 then
                 exports['NRP-notify']:DoLongHudText('success', "Congratulations That was Top Quality Product, You managed to harvest and bag up "..smrax.."!. It has been deposited into storage ")
                 TriggerServerEvent('xz:addstock', 3, 298, smrax)
                 exports['NRP-notify']:DoLongHudText('inform', "Storage Deposit : "..smrax.." 1/4's of Medical Weed")
                 TriggerServerEvent("xz_smoke:growpayincrease", 1250)
                 TriggerServerEvent('points:add','SOTW', 0.75)
              elseif weedQuality >= 95 then
                 exports['NRP-notify']:DoLongHudText('success', "Congratulations That was Top Quality Product, You managed to harvest and bag up "..gallows.."!. It has been deposited into storage ")
                 TriggerServerEvent('xz:addstock', 3, 298, gallows)
                 exports['NRP-notify']:DoLongHudText('inform', "Storage Deposit : "..gallows.." 1/4's of Medical Weed")
                 TriggerServerEvent("xz_smoke:growpayincrease", 1150)
                 TriggerServerEvent('points:add','SOTW', 0.75)
              elseif weedQuality >= 85 then
                  exports['NRP-notify']:DoLongHudText('success', " You managed to harvest and bag up "..gallows.."!. It has been deposited into storage ")
                  TriggerServerEvent('xz:addstock', 3, 298, xzurv)
                  exports['NRP-notify']:DoLongHudText('inform', "Storage Deposit : "..xzurv.." 1/4's of Medical Weed")
                  TriggerServerEvent("xz_smoke:growpayincrease", 1050)
                  TriggerServerEvent('points:add','SOTW', 0.5)
              elseif weedQuality >= 75 then
                  exports['NRP-notify']:DoLongHudText('success', "You managed to harvest and bag up "..jopu.."!. It has been deposited into storage ")
                  TriggerServerEvent('xz:addstock', 3, 298, jopu)
                  exports['NRP-notify']:DoLongHudText('inform', "Storage Deposit : "..jopu.." 1/4's of Medical Weed")
                  TriggerServerEvent("xz_smoke:growpayincrease", 950)
                  TriggerServerEvent('points:add','SOTW', 0.5)
              elseif weedQuality >= 65 then
                  exports['NRP-notify']:DoLongHudText('success', "You managed to harvest and bag up "..dogShitGrower.."!. It has been deposited into storage ")
                  TriggerServerEvent('xz:addstock', 3, 298, dogShitGrower )
                  exports['NRP-notify']:DoLongHudText('inform', "Storage Deposit : "..dogShitGrower.." 1/4's of Medical Weed")
                  TriggerServerEvent("xz_smoke:growpayincrease", 850)
                  TriggerServerEvent('points:add','SOTW', 0.5)
              elseif weedQuality >= 55 then
                  exports['NRP-notify']:DoLongHudText('success', "You managed to harvest and bag up "..horseShitGrower.."!. It has been deposited into storage ")
                  TriggerServerEvent('xz:addstock', 3, 298, horseShitGrower )
                  exports['NRP-notify']:DoLongHudText('inform', "Storage Deposit : "..horseShitGrower.." 1/4's of Medical Weed")
                  TriggerServerEvent("xz_smoke:growpayincrease", 750)
                  TriggerServerEvent('points:add','SOTW', 0.5)
              elseif weedQuality >= 45 then
                  exports['NRP-notify']:DoLongHudText('success', "You managed to harvest and bag up "..wanker.."!. It has been deposited into storage ")
                  TriggerServerEvent('xz:addstock', 3, 298, wanker )
                  exports['NRP-notify']:DoLongHudText('inform', "Storage Deposit : "..wanker.." 1/4's of Medical Weed")
                  TriggerServerEvent("xz_smoke:growpayincrease", 650)
                  TriggerServerEvent('points:add','SOTW', 0.25)
              elseif weedQuality >= 35 then
                  exports['NRP-notify']:DoLongHudText('success', "You managed to harvest and bag up "..boostedPleb.."!. It has been deposited into storage ")
                  TriggerServerEvent('xz:addstock', 3, 298, boostedPleb )
                  exports['NRP-notify']:DoLongHudText('inform', "Storage Deposit : "..boostedPleb.." 1/4's of Medical Weed")
                  TriggerServerEvent("xz_smoke:growpayincrease", 550)
                  TriggerServerEvent('points:add','SOTW', 0.25)
              elseif weedQuality >= 25 then
                  exports['NRP-notify']:DoLongHudText('error', "You managed to harvest and bag up "..nexus.."!. make sure to prune your plant, and keep water levels up")
                  TriggerServerEvent('xz:addstock', 3, 298, nexus )
                  exports['NRP-notify']:DoLongHudText('inform', "Storage Deposit : "..nexus.." 1/4's of Medical Weed")
                  TriggerServerEvent("xz_smoke:growpayincrease", 450)
                  TriggerServerEvent('points:add','SOTW', 0.25)
              elseif weedQuality >= 15 then
                  exports['NRP-notify']:DoLongHudText('error', "You managed to harvest and bag up "..forged.."!. Pay more attention")
                  TriggerServerEvent('xz:addstock', 3, 298, forged )
                  exports['NRP-notify']:DoLongHudText('inform', "Storage Deposit : "..forged.." 1/4's of Medical Weed")
                  TriggerServerEvent("xz_smoke:growpayincrease", 350)
              elseif weedQuality >= 5 then
                  exports['NRP-notify']:DoLongHudText('error', "You managed to harvest and bag up "..monkey.."!. you keep messing up like this we will be taking it out your pay! ")
                  TriggerServerEvent('xz:addstock', 3, 298, monkey )
                  exports['NRP-notify']:DoLongHudText('inform', "Storage Deposit : "..monkey.." 1/4's of Medical Weed")
                  TriggerServerEvent("xz_smoke:growpayincrease", 250)
              elseif weedQuality >= 1 then
                  exports['NRP-notify']:DoLongHudText('error', " You managed to harvest and bag up "..manWithNoHands.."!. That was one of your worst crops!")
                  TriggerServerEvent('xz:addstock', 3, 298,  manWithNoHands )
                  exports['NRP-notify']:DoLongHudText('inform', "Storage Deposit : "..manWithNoHands.." 1/4's of Medical Weed")
                  TriggerServerEvent("xz_smoke:growpayincrease", 150)
              end
             end
            end) 
            Wait(25000)
            stageOne = false stageTwo = false stageThree = false dryingStage = false finalstage = false 
            growthTimer = 0 weedQuality = 0 weedThirst = 0 dryingTimer = 0 
            weedDrying = false weedPlanted = false weedCut = false
          end
        end
      end    
    end
  end
  
  if weedPlanted and growthTimer <= 175 and stageOne == true then 
    if stageOneMarker then
     Jaybee(1056.075, -3205.219,-39.15+0.3,'~w~Stage ~g~One\n~w~Water: ~g~'..weedThirst..'% ~w~| Growth: ~g~'..growthTimer..'% ~w~| Quality: ~g~'..weedQuality..'%')
    end
  elseif weedPlanted and stageTwo == true then
    if stageTwoMarker then
     Jaybee(1061.067, -3206.687, -39.15+0.3,'~w~Stage ~g~Two\n~w~Water: ~g~'..weedThirst..'% ~w~| Growth: ~g~'..growthTimer..'% ~w~| Quality: ~g~'..weedQuality..'%')
    end
  elseif weedPlanted and stageThree == true and weedCut == false then
    if stageThreeMarker then
     Jaybee(1058.352, -3200.884, -39.15+0.3,'~w~Stage ~g~Three\n~w~Water: ~g~'..weedThirst..'% ~w~| Growth: ~g~'..growthTimer..'% ~w~| Quality: ~g~'..weedQuality..'%')
    end
  elseif weedDrying and dryingStage == true and dryingTimer >= 1 then 
    if dryingStageMarker then
     Jaybee(1040.816,-3202.365,-38.164+1.0,'~w~Stage ~g~Four\n~w~Drying: ~g~ '..dryingTimer..'')
    end
  end --- working
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------KILL PLANT-----------------------------------------------------------------------------------
    if weedPlanted and weedQuality == 0 then
      growthTimer = 0
      weedThirst = 0
      weedQuality = 0
      stageOne = false
      stageTwo = false
      stageThree = false
      weedPlanted = false
      weedPruned = false
      weedCut = false
      


      exports['NRP-notify']:DoLongHudText('error', "The Boss will not be happy with you ruining an entire crop , Pay more attention next time!")
    end -- workign

    --[[local prunedForget = math.random(15,30) 
    if growthTimer == 55 then  
     weedQuality = weedQuality - prunedForget   --- NEED FIXING
     exports['NRP-notify']:DoLongHudText('error', "You Forgot To Prune The Plants, The Quality Has Decreased By "..prunedForget.."!")
    end]]--
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------WATERING-------------------------------------------------------------------------------------
    if not dryingStage and weedThirst < 80 and growthTimer >= 121 and stageOne == true then 
     if stageOneText then
        Jaybee(1056.075, -3205.219,-39.105-0.15,'~g~[H]~w~ Water')
      if exports['core']:GetItemQuantity(296) > 0 then 
       if water then
         TriggerEvent("mythic_progbar:client:progress", {
          name = "watert",
          duration = 3000,
          label = "Watering Plants",
          useWhileDead = false,
          canCancel = false,
          controlDisables = {
             disableMovement = true,
             disableCarMovement = true,
             disableMouse = false,
             disableCombat = true,
           },
           animation = {
           animDict = "amb@prop_human_bum_bin@idle_a",
           anim = "idle_a",
           },
         }, function(status)
          if not status then         
          TriggerEvent("inventory:removeQty", 296, 1) 
           end
          end)
           Wait(3000)
           weedThirst = weedThirst + 20
        end
      end
     end 
    end
    if not dryingStage and weedThirst < 80 and stageTwo == true then
      if stageTwoText then
        Jaybee(1061.067, -3206.687, -39.142-0.15,'~g~[H]~w~ Water')
       if exports['core']:GetItemQuantity(296) > 0 then 
        if water then
         TriggerEvent("mythic_progbar:client:progress", {
          name = "watert",
          duration = 3000,
          label = "Watering Plants",
          useWhileDead = false,
          canCancel = false,
          controlDisables = {
             disableMovement = true,
             disableCarMovement = true,
             disableMouse = false,
             disableCombat = true,
           },
           animation = {
           animDict = "amb@prop_human_bum_bin@idle_a",
           anim = "idle_a",
         },
         }, function(status)
         if not status then   
          TriggerEvent("inventory:removeQty", 296, 1) 
          end
         end)
         Wait(3000)
         weedThirst = weedThirst + 20
        end
       end
      end
     end   
    if not dryingStage and weedThirst < 80 and stageThree == true then 
      if stageThreeText then
       Jaybee(1058.352, -3200.884, -39.050-0.15,'~g~[H]~w~ Water')
       if exports['core']:GetItemQuantity(296) > 0 then 
        if water then
         TriggerEvent("mythic_progbar:client:progress", {
          name = "watert",
          duration = 3000,
          label = "Watering Plants",
          useWhileDead = false,
          canCancel = false,
          controlDisables = {
           disableMovement = true,
           disableCarMovement = true,
           disableMouse = false,
           disableCombat = true,
           },
           animation = {
           animDict = "amb@prop_human_bum_bin@idle_a",
           anim = "idle_a",
            },
           }, function(status)
           if not status then   
            TriggerEvent("inventory:removeQty", 296, 1) 
            end
           end)
           Wait(3000)
           weedThirst = weedThirst + 20
        end
       end
      end
     end --- working
    
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------STAGE ONE PLANTING----------------------------------------------------------------------------------
  if grower and stageOneMarker and (stageOne == false) and (stageTwo == false) and (stageThree == false) then
    DrawMarker(25, 1056.075, -3205.219,-39.105-0.99, 0, 0, 0, 0, 0, 0, 0.8,0.8,0.5, 255, 15, 15, 200, 0, true, 2, 0, 0, 0, 0)
    if stageOneText and (stageOne == false) and (stageTwo == false) and (stageThree == false) then
      Jaybee(1056.075, -3205.219,-39.105,'~g~[E]~w~  Start Growing Medical Weed')
     if control then
      TriggerServerEvent('FL_Perks:LevelChecks')
      Wait(100)
     if tostring(job) == 'SOTW' then
      if tonumber(points) >= 75 then      
       if exports['core']:GetItemQuantity(295) >= 12 and exports['core']:GetItemQuantity(296) >= 12 and exports['core']:GetItemQuantity(297) >= 12 then
        TriggerEvent("mythic_progbar:client:progress", {
         name = "cfert",
         duration = 10000,
         label = "Fertilizing Soil And Planting 12 seeds",
         useWhileDead = false,
         canCancel = false,
         controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
          },
          animation = {
          animDict = "amb@prop_human_bum_bin@idle_a",
          anim = "idle_a",
          },
        }, function(status)
        if not status then
          TriggerEvent("inventory:removeQty", 295,12)
          TriggerEvent("inventory:removeQty", 296, 12)
          TriggerEvent("inventory:removeQty", 297, 12) 
         end
        end)
         
         growthTimer = 220
         weedThirst = 100
         weedQuality = 100
         stageOne = true
         weedPlanted = true 
        else
          exports['NRP-notify']:DoHudText('inform', "You Need Atleast 75 Points To Use the Grow Room") 
        end
       end     
      else
        exports['NRP-notify']:DoLongHudText('error', "You need 12x Medical Weed Seeds, 12x Ph Neutral Water and 12x Commercial Fertilizer to start growing!")
      end
     end
    end
   end ---- working
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------PRUNING---------------------------------------------------------------------------------------------
   if stageTwo == true and weedPruned == false and growthTimer <= 80 and growthTimer >= 61 then
    local prunedForget = math.random(15,30) 
    if stageTwoText then
      Jaybee(1061.067, -3206.687, -39.142,'~g~[E]~w~  Start Pruning Weed')
      if control then
        local qualityIncrease = math.random(5,10)
        TriggerEvent("mythic_progbar:client:progress", {name = "cfert", duration = 20000,label = "Pruning Weed",useWhileDead = false,canCancel = false, controlDisables = {disableMovement = true,disableCarMovement = true,disableMouse = false,disableCombat = true,},animation = {animDict = "amb@prop_human_bum_bin@idle_a",anim = "idle_a",},}, function(status)if not status then end end)
        Wait(20000)
        weedPruned = true
        weedQuality = weedQuality + qualityIncrease
        exports['NRP-notify']:DoLongHudText('success', "You Have Successfully Pruned The Plants, Increasing Its Quality By "..qualityIncrease.."%")        
        if weedPruned == true and weedQuality >= 105 and stageTwo == true then     
          exports['NRP-notify']:DoLongHudText('success', "This Is Looking Perfect The Customers Will Love This!")         
        end
      end
    end
   end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------STAGE---THREE------------------------------------------------------------------------------------
  if dryingStage and weedCut == false then
    if stageThreeText then
      Jaybee(1058.352, -3200.884, -39.050,'~g~[E]~w~  Start Cutting Down Weed')
      if control then
        TriggerEvent("mythic_progbar:client:progress", {name = "cwssrt", duration = 20000,label = "Chopping Down Weed",useWhileDead = false,canCancel = false, controlDisables = {disableMovement = true,disableCarMovement = true,disableMouse = false,disableCombat = true,},animation = {animDict = "amb@prop_human_bum_bin@idle_a",anim = "idle_a",},}, function(status)if not status then end end)
        Wait(20000)
        weedDrying = true
        weedCut = true
        dryingTimer = 60
        print("dryingtimer set")
       -- Wait(60100)  
      end
    end
  end
  end
 end) 
----------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------TIMER COUNTDOWNS-----------------------------------------------------------------------------------
 Citizen.CreateThread(function()
  while true do
   Citizen.Wait(1000)
   if weedPlanted then
    if tostring(job) == 'SOTW' then
      if tonumber(points) >= 150 then 
       if weedThirst < 60 and growthTimer >=1 then 
        weedQuality = weedQuality - 0.75
       elseif weedThirst < 55 and growthTimer >=1 then 
        weedQuality = weedQuality - 1.25
       elseif weedThirst < 45 and growthTimer >=1 then 
        weedQuality = weedQuality - 1.75
       elseif weedThirst < 35 and growthTimer >=1 then 
        weedQuality = weedQuality - 2.25
       elseif weedThirst < 25 and growthTimer >=1 then 
        weedQuality = weedQuality - 2.5
       elseif weedThirst < 15 and growthTimer >=1 then 
        weedQuality = weedQuality - 3
       elseif weedThirst <= 0 and growthTimer >=1 then 
        weedQuality = weedQuality - 4
       elseif growthTimer == 0 and growthTimer >=1 then
         weedQuality = weedQuality - 0
         weedThirst = weedThirst - 0
         growthTimer = growthTimer - 0
       end

      if growthTimer <= 120 and growthTimer >= 61 then
        stageOne = false
        stageTwo = true 
    
      elseif growthTimer <= 60 and growthTimer >= 2 then
        stageTwo = false 
        stageThree = true
      
      elseif growthTimer <= 1 or growthTimer == 0 and weedCut == false then
        dryingStage = true
        
      end
     elseif tonumber(points) >= 75 then 
      if weedThirst < 60 and growthTimer >=1 then 
       weedQuality = weedQuality - 1
      elseif weedThirst < 55 and growthTimer >=1 then 
       weedQuality = weedQuality - 1.5
      elseif weedThirst < 45 and growthTimer >=1 then 
       weedQuality = weedQuality - 2
      elseif weedThirst < 35 and growthTimer >=1 then 
       weedQuality = weedQuality - 2.5
      elseif weedThirst < 25 and growthTimer >=1 then 
       weedQuality = weedQuality - 3
      elseif weedThirst < 15 and growthTimer >=1 then 
       weedQuality = weedQuality - 4
      elseif weedThirst <= 0 and growthTimer >=1 then 
       weedQuality = weedQuality - 5
      elseif growthTimer == 0 and growthTimer >=1 then
        weedQuality = weedQuality - 0
       weedThirst = weedThirst - 0
      growthTimer = growthTimer - 0
      end

     if growthTimer <= 120 and growthTimer >= 61 then
       stageOne = false
       stageTwo = true 
   
     elseif growthTimer <= 60 and growthTimer >= 2 then
       stageTwo = false 
       stageThree = true
     
     elseif growthTimer <= 1 or growthTimer == 0 and weedCut == false then
       dryingStage = true
       
     end
    end
   end
   end 
  end ---- working
 end)


 Citizen.CreateThread(function()
  while true do
   Citizen.Wait(1100)
   if weedPlanted then
    if tostring(job) == 'SOTW' then
     if tonumber(points) >= 350 then   
      if weedThirst > 0 then 
       weedThirst = weedThirst - 0.75 
      elseif growthTimer <= 0 and weedPlanted then
      weedThirst = weedThirst - 0
      growthTimer = growthTimer - 0
      weedQuality = weedQuality - 0 
      end
     elseif tonumber(points) >= 75 then   
      if weedThirst > 0 then 
       weedThirst = weedThirst - 1 
      elseif growthTimer <= 0 and weedPlanted then
      weedThirst = weedThirst - 0
      growthTimer = growthTimer - 0
      weedQuality = weedQuality - 0 
      end
     end 
    end
   end 
  end ---- working
 end)

 Citizen.CreateThread(function()
  while true do
   Citizen.Wait(1100) 
    if weedCut then     
       if dryingTimer > 0 then
        dryingTimer = dryingTimer - 1
       end      
    end---- working
  end
 end)
 
 Citizen.CreateThread(function()
    while true do
     Citizen.Wait(1100) --- changes speed of growth timer
     if weedPlanted then 
      if tostring(job) == 'SOTW' then
        if tonumber(points) >= 500 then 
          if weedThirst > 0 then
            if growthTimer > 0 then
             growthTimer = growthTimer - 0.75 
            end 
          end
        elseif tonumber(points) >= 75 then 
          if weedThirst > 0 then
            if growthTimer > 0 then
             growthTimer = growthTimer - 1
            end 
          end
        end 
      end  
    elseif weedPlanted and growthTimer <= 0 then
      weedThirst = weedThirst - 0
      weedQuality = weedQuality - 0
      growthTimer = growthTimer - 0
     end
    end
 end)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------FUNCTIONS---------------------------------------------------------------------------------------
 function SpawnStonerCar(model, x,y,z)
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
  --SetVehicleNumberPlateText(vehicle, 'SMOKEBUD')
  SetVehicleEngineOn(vehicle, true)
  SetVehicleLivery(vehicle, vehlivery) ---- working
  DecorRegister("_Fuel_Level", 3);
  DecorRegister("_Max_Fuel_Level", 3);
  DecorSetInt(vehicle, "_Max_Fuel_Level", 100000)
  DecorSetInt(vehicle, "_Fuel_Level", 100000)
  exports["onyxLocksystem"]:givePlayerKeys(GetVehicleNumberPlateText(vehicle))
 end


 RegisterNetEvent('xz:getstock')
 AddEventHandler('xz:getstock',function(results)
  currentStock = results
 end)
 

 function Jaybee(x,y,z,text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text) ---- working
    DrawText(_x,_y)
 end

 --[[  
   {x =-1147.430, -1562.204, 4.390} ENTER BACK OF SMOKE
   {x =-1147.430, -1562.204, 4.390} EXIT--- inside weed place


   {x = 2214.748,  5609.471,  54.316} SEED PICKUP
   {x = 2757.389,  3468.403,  55.733} FERT PICKUP
   {x = 1064.919,  -3202.341,  -39.048} water testing and filling up

   {x = -1172.091,  -1571.851, 4.664} -- WEED TO SELL STOCK
   {x = -1168.810,  -1572.753,  4.664} JOB SIGN ON

   {x = 1031.106,  -3203.178,  -38.193} grow storage ---

    {x = -1152.231,  -1564.938, 4.382} van drop off
    {x = -1158.379, -1588.915, 4.296} van pick up



 ]]
 
 

 function Teleport(x,y,z)
  Wait(100)
  RequestCollisionAtCoord(x,y,z)
  while not HasCollisionLoadedAroundEntity(GetPlayerPed(-1)) do 
    RequestCollisionAtCoord(x,y,z)
    Citizen.Wait(0)
  end
  SetEntityCoords(GetPlayerPed(-1), x,y,z)
 end
