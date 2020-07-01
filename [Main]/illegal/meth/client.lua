local creationStage = 0
local isNearStore = false 
local storeLoc = {x=-629.72, y=-236.41, z=38.06}
local robberyBlip = nil
local currentPolice = 0
local disableInventory = false

RegisterNetEvent('hud:updatepresence')
AddEventHandler('hud:updatepresence', function(copss)
 currentPolice = copss
end)

RegisterNetEvent('xz-meth:addBlip')
AddEventHandler('xz-meth:addBlip', function()
 if DecorGetBool(GetPlayerPed(-1), "isOfficer") then
  --if not DoesBlipExist(robberyBlip) then 
   --robberyBlip = AddBlipForCoord(storeLoc.x,storeLoc.y,storeLoc.z) 
   --SetBlipSprite(robberyBlip, 161)
  -- SetBlipScale(robberyBlip, 1.2)
   --SetBlipColour(robberyBlip, 3)
  -- PulseBlip(robberyBlip)
   PlaySoundFrontend(-1, "CHECKPOINT_MISSED", 'HUD_MINI_GAME_SOUNDSET', 1)
   Wait(600)
   PlaySoundFrontend(-1, "CHECKPOINT_MISSED", 'HUD_MINI_GAME_SOUNDSET', 1)
   Wait(600)  
   PlaySoundFrontend(-1, "CHECKPOINT_MISSED", 'HUD_MINI_GAME_SOUNDSET', 1)
  --end
 end
end)


--[[Citizen.CreateThread(function()
  while true do
   Citizen.Wait(1250)
   isNearStore = false
   local pos = GetEntityCoords(GetPlayerPed(-1))
    if not stealTimer then
     isNearStore = true 
     storeLoc = {['x'] = 361.567, ['y'] =-570.587, ['z'] = 28.791 }
     break 
     end 
    end
end)
 ]]--

RegisterNetEvent('xz-meth:killBlip')
AddEventHandler('xz-meth:killBlip', function()
 if DoesBlipExist(robberyBlip) then 
  RemoveBlip(robberyBlip)
 end
end)

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

--[[

local cooldowntimer = 7200

Citizen.CreateThread(function()
  while true do
   Citizen.Wait(5)
   local coords = GetEntityCoords(GetPlayerPed(-1))
    if DecorGetBool(GetPlayerPed(-1), "isOfficer") or DecorGetBool(GetPlayerPed(-1), "isParamedic") then ---- use this stop whitelist selling
   else
    if currentPolice >= 3 then
    local rep = DecorGetInt(GetPlayerPed(-1), "Reputation")
    if GetDistanceBetweenCoords(coords, 361.567, -570.587, 28.791-0.95, true) < 1.5 and rep >= 500 then
     DrawText3Ds(361.567, -570.587, 28.791,'~g~[E]~w~ To Steal Ammonia')
     if IsControlJustPressed(0, 38) then
       TriggerEvent('NRP-notify:client:SendAlert', { type = 'error', text = "You have been spotted on camera Police units have been notified!", length = 5000})
       TriggerServerEvent('xz-meth:start')
       TriggerEvent('xz-meth:addBlip')
      -- TriggerEvent('meth:activeRobbery')
       TaskStartScenarioInPlace(GetPlayerPed(-1), 'PROP_HUMAN_ATM', false, true)

       TriggerEvent("mythic_progbar:client:progress", {
        name = "ammoniasteal",
        duration = 180000,
        label = "Stealing Ammonia",
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
          if cooldowntimer < 9 then
            ClearPedTasksImmediately(GetPlayerPed(-1))
            TriggerEvent('NRP-notify:client:SendAlert', { type = 'success', text = "You have stolen 5 bottles of Ammonia!", length = 5000})
            TriggerEvent("inventory:addQty", 90, 5)
            TriggerServerEvent('xz-meth:start')
            cooldowntimer = 7200
          else
            TriggerEvent('NRP-notify:client:SendAlert', { type = 'error', text = "You have already emptied the supplies, come back later.", length = 5000})
          end
        end
      end)

     end
     end
    end
   end
  end
end)

-- Timer countdown
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
    if cooldowntimer > 0 then
      cooldowntimer = cooldowntimer - 1
      if cooldowntimer == 1 then
        seedcount = 0
      end
    end
  end
end)

--]]

RegisterNetEvent('meth:activeRobbery')
AddEventHandler('meth:activeRobbery', function()
 TriggerServerEvent('addReputation', 10)
 TriggerServerEvent('xz-meth:start')
 Wait(120000)
 stealTimer = false
 ServerEvent('xz-meth:end')
end)

Citizen.CreateThread(function()
  while true do
    Wait(0)
    if disableInventory then
      DisableControlAction(0, 289)
    end
  end
end)

Citizen.CreateThread(function ()
 while true do
  Citizen.Wait(5)
  local coords = GetEntityCoords(GetPlayerPed(-1))
   if (GetDistanceBetweenCoords(coords, 2432.709, 4970.380, 42.348-0.95, true) > 30.0) and creationStage > 0 then
    DrawText3Ds(2432.709, 4970.380, 42.348,'You have left your Meth cookup unattended for too long. It has failed and can no longer be used.')
    disableInventory = false
   	creationStage = 0
   end
   if(GetDistanceBetweenCoords(coords, 2432.709, 4970.380, 42.348-0.95, true) < 10.0) and creationStage == 0 then
    if(GetDistanceBetweenCoords(coords, 2432.709, 4970.380, 42.348-0.95, true) < 1.2) then
      DrawText3Ds(2432.709, 4970.380, 42.348,'~g~[E]~w~ To Begin Cooking Meth')
     if IsControlJustPressed(0, 38) then
       if exports['core']:GetItemQuantity(90) >= 1 and exports['core']:GetItemQuantity(88) >= 1 and exports['core']:GetItemQuantity(44) >= 1 then
        disableInventory = true
        TaskStartScenarioInPlace(GetPlayerPed(-1), 'PROP_HUMAN_ATM', false, true)

        TriggerEvent("mythic_progbar:client:progress", {
          name = "startingcook",
          duration = 10000,
          label = "Starting Cook",
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
          
          disableInventory = false
          ClearPedTasksImmediately(GetPlayerPed(-1)) 
          exports["NRP-notify"]:DoHudText("inform", "You have begun the cooking proccess.")
          creationStage = 1
          TriggerEvent("inventory:removeQty", 90, 1)
          TriggerEvent("inventory:removeQty", 88, 1)
          TriggerEvent("inventory:removeQty", 44, 1)
          end
        end)

   	  else
        exports["NRP-notify"]:DoHudText("error", "You dont have the ingredients to cook meth")
   	  end
   	 end
   	end
   end
   if(GetDistanceBetweenCoords(coords, 2432.683, 4972.119, 42.348-0.95, true) < 10.0) and creationStage == 1 then
    if(GetDistanceBetweenCoords(coords, 2432.683, 4972.119, 42.348-0.95, true) < 1.2) then
      DrawText3Ds(2432.683, 4972.119, 42.348,'~g~[E]~w~ To Crush Matches')
     if IsControlJustPressed(0, 38) then
      TaskStartScenarioInPlace(GetPlayerPed(-1), 'PROP_HUMAN_ATM', false, true)
      disableInventory = true

      TriggerEvent("mythic_progbar:client:progress", {
        name = "crushingmatches",
        duration = 15000,
        label = "Crushing Matches",
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
          disableInventory = false
          ClearPedTasksImmediately(GetPlayerPed(-1)) 
          creationStage = 2
        end
      end)
      
     end
    end
   end
   if(GetDistanceBetweenCoords(coords, 2434.305, 4969.443, 42.348-0.95, true) < 10.0) and creationStage == 2 then
    if(GetDistanceBetweenCoords(coords, 2434.305, 4969.443, 42.348-0.95, true) < 1.2) then
      DrawText3Ds(2434.305, 4969.443, 42.348,'~g~[E]~w~ To Mix Phosphorus, Cough Medicine And Ammonia')
     if IsControlJustPressed(0, 38) then
      disableInventory = true
      TaskStartScenarioInPlace(GetPlayerPed(-1), 'PROP_HUMAN_ATM', false, true)
      TriggerEvent("mythic_progbar:client:progress", {
        name = "mixingchemicals",
        duration = 30000,
        label = "Mixing Chemicals",
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
            disableInventory = false
            ClearPedTasksImmediately(GetPlayerPed(-1))
            if math.random(1, 100) >= 95 then
            exports["NRP-notify"]:DoHudText("error", "The chemical reaction has gone wrong! Your recipe has failed.")
            creationStage = 0
            elseif math.random(1, 100) >= 50 then
            TriggerServerEvent('addReputation', 1)
            TriggerEvent("inventory:addQty", 156, 1)
            exports["NRP-notify"]:DoHudText("inform", "You have cooked 1x Oz Of Crystal Meth")
            creationStage = 0
            else
            TriggerEvent("inventory:addQty", 156, 1)
            exports["NRP-notify"]:DoHudText("inform", "You have cooked 1x Oz Of Crystal Meth")
            creationStage = 0
          end
        end
      end)

    end
   end
  end
 end
end)