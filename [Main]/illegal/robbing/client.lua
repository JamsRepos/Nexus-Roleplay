currentPolice = 0

Citizen.CreateThread(function()
 while true do
  local coords = GetEntityCoords(GetPlayerPed(-1))
  Wait(5)
  if(GetDistanceBetweenCoords(coords, 1122.482, -3195.009, -40.402, true) < 10.0) and not IsPedInAnyVehicle(GetPlayerPed(-1)) then
   DrawMarker(27, 1122.482, -3195.009, -40.402-0.95, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 255, 255, 0, 100, 0, 0, 2, 0, 0, 0, 0)
   if(GetDistanceBetweenCoords(coords, 1122.482, -3195.009, -40.402, true) < 1.5) then
    DrawText3Ds(1122.482, -3195.009, -40.402,'~g~[E]~w~ Wash Dirty Cash')
    if IsControlJustPressed(0, 38) then
     TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_ATM", 0, true)
     FreezeEntityPosition(GetPlayerPed(-1), true)

     TriggerEvent("mythic_progbar:client:progress", {
        name = "crafting_item",
        duration = 10000,
        label = "Trading Cash",
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
                TriggerServerEvent('illegal:washmoney', amount)
            end
         FreezeEntityPosition(GetPlayerPed(-1), false)
        end
    end)

    end
   end
  end
 end
end)

Citizen.CreateThread(function()
 while true do
  local coords = GetEntityCoords(GetPlayerPed(-1))
  Wait(5)
   local rep = DecorGetInt(GetPlayerPed(-1), "Reputation")
   if(GetDistanceBetweenCoords(coords, 905.441, -1688.000, 47.352, true) < 1.5) and rep >= 750 then
    DrawText3Ds(905.441, -1688.000, 47.352,'~g~[E]~w~ Clean Dirty Cash')
    if IsControlJustPressed(0, 38) then
     TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_ATM", 0, true)
     FreezeEntityPosition(GetPlayerPed(-1), true)

     TriggerEvent("mythic_progbar:client:progress", {
        name = "crafting_item",
        duration = 10000,
        label = "Trading Cash",
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
                TriggerServerEvent('illegal:washmoney2', amount)
            end
         FreezeEntityPosition(GetPlayerPed(-1), false)
        end
    end)

    end
   end
 end
end)

Citizen.CreateThread(function()
 while true do
  local coords = GetEntityCoords(GetPlayerPed(-1))
  Wait(5)
   local rep = DecorGetInt(GetPlayerPed(-1), "Reputation")
   if(GetDistanceBetweenCoords(coords, -2040.926, -365.726, 44.107, true) < 1.5) and rep >= 1500 then
    DrawText3Ds(-2040.926, -365.726, 44.107,'~g~[E]~w~ Clean Dirty Cash')
    if IsControlJustPressed(0, 38) then
     TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_ATM", 0, true)
     FreezeEntityPosition(GetPlayerPed(-1), true)

     TriggerEvent("mythic_progbar:client:progress", {
        name = "crafting_item",
        duration = 10000,
        label = "Trading Cash",
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
                TriggerServerEvent('illegal:washmoney3', amount)
            end
         FreezeEntityPosition(GetPlayerPed(-1), false)
        end
    end)

    end
   end
 end
end)
--[[
Citizen.CreateThread(function()
 while true do
  local coords = GetEntityCoords(GetPlayerPed(-1))
  Wait(5)
   if(GetDistanceBetweenCoords(coords, -411.689, 151.568, 81.743, true) < 1.5) then
    DrawText3Ds(-411.689, 151.568, 81.743,'~g~[E]~w~ Clean Dirty Cash')
    if IsControlJustPressed(0, 38) then
     TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_ATM", 0, true)
     FreezeEntityPosition(GetPlayerPed(-1), true)

     TriggerEvent("mythic_progbar:client:progress", {
        name = "crafting_item",
        duration = 10000,
        label = "Trading Cash",
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
                TriggerServerEvent('illegal:washmoney4', amount)
            end
         FreezeEntityPosition(GetPlayerPed(-1), false)
        end
    end)
   
    end
   end
  end
end)
--]]
local targetInventory = nil
local targetMoney = nil
local targetPlayer = nil
local xzurv = true
Citizen.CreateThread(function()
 while true do
  Wait(0)
  if xzurv then
   if IsControlJustPressed(0, 311) and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 2) then  
        currentTarget = nil
        Wait(10)
        currentTarget = t
       if DecorGetBool(GetPlayerPed(t), "Handsup") == 1 then
        if currentPolice >= 2 then
            TriggerServerEvent('rob:getPlayerInventory', GetPlayerServerId(t))
            ExecuteCommand('me searching someones pockets')
        else
            exports['NRP-notify']:DoHudText('inform',  "Not Enough Police In Town")
        end
       end
    end
   end    
  end
end
end)

Citizen.CreateThread(function()
 WarMenu.CreateLongMenu('rob', 'Wallet')
    while true do
        Wait(0)
        if xzurv then
            if IsControlJustPressed(0, 51) and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                local t, distance = GetClosestPlayer()
                if(distance ~= -1 and distance < 2) then
                    currentTarget = nil
                    Wait(10)
                    currentTarget = t
                   if DecorGetBool(GetPlayerPed(t), "Handsup") == 1 then
                    if currentPolice >= 2 then
                        TriggerServerEvent('rob:getPlayerCash', GetPlayerServerId(t))
                        ExecuteCommand('me searching someones wallet')
                    else
                        exports['NRP-notify']:DoHudText('inform',  "Not Enough Police In Town")
                    end
                   end
                end
               end
               if WarMenu.IsMenuOpened('rob') then
                local inventory = targetInventory
                if WarMenu.Button('Money: ~g~$'..targetMoney) then 
                 takeMoney(targetMoney)
                elseif WarMenu.Button('Dirty Money: ~r~$'..targetDirtyMoney) then 
                 takedirtyMoney(targetDirtyMoney)
                end
              end 
            WarMenu.Display() 
        end
    end
end)    

RegisterNetEvent('rob:cash')
AddEventHandler('rob:cash', function(money,dirtymoney, target)
 targetDirtyMoney = dirtymoney
 targetMoney = money
 targetPlayer = target
 WarMenu.OpenMenu('rob')
end)
RegisterNetEvent('rob:inventory')
AddEventHandler('rob:inventory', function(inv, target)
 targetInventory = inv 
 targetPlayer = target
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
function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end
function takeItem(item, name, quantity)
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
  TriggerServerEvent('rob:takeItem', item, name, amount, targetPlayer)
 end
end
function takeMoney(cash)
 local amount = "xxsdrtghyuujhdjsjenenfjfjtjtjtj"
 if(amount == "xxsdrtghyuujhdjsjenenfjfjtjtjtj") then
  showLoadingPrompt("Enter Amount To Take", 3)
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
  if tonumber(cash) >= tonumber(amount) then
   TriggerServerEvent('rob:takeMoney', amount, targetPlayer)
  end
 end
end
function takedirtyMoney(cash)
    local amount = "xxsdrtghyuujhdjsjenenfjfjtjtjtj"
    if(amount == "xxsdrtghyuujhdjsjenenfjfjtjtjtj") then
     showLoadingPrompt("Enter Amount To Take", 3)
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
     if tonumber(cash) >= tonumber(amount) then
      TriggerServerEvent('rob:takedirtyMoney', amount, targetPlayer)
     end
    end
end

--[[RegisterCommand('robcash', function(source, args, rawCommand)
    WarMenu.CreateLongMenu('rob', 'Robbing') 
    local t, distance = GetClosestPlayer()
        if(distance ~= -1 and distance < 3) then
          if DecorGetBool(GetPlayerPed(t), "Handsup") == 1 then
              TriggerServerEvent('rob:getPlayerCash', GetPlayerServerId(t))
          end
       end
    WarMenu.Display()  
end)  
]]--
