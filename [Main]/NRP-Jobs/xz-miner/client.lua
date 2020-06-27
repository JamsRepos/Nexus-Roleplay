

--[[

final stage to finish 

1. check blips for level 10
2. check sell locations work for level 10
3. maybe add an npc to sell locations


]]--

RegisterNetEvent('xz:getpoints')
AddEventHandler('xz:getpoints',function(name,value)
  job = name
  points = value 
end)

-------------------------------------------------------------------------ALL-LOCALS-------------------------------------------------------------------------------------
 local PlayerData                = {}
 local blip1 = {}
 local blips = false
 local blipActive = false
 local mineActive = false
 local washingActive = false
 local remeltingActive = false
 local firstspawn = false
 local impacts = 0
 local timer = 0
 local locations = {
    { ['x'] = -591.47,  ['y'] = 2076.52,  ['z'] = 131.37},
    { ['x'] = -590.35,  ['y'] = 2071.76,  ['z'] = 131.29},
    { ['x'] = -589.61,  ['y'] = 2069.3,  ['z'] = 131.19},
    { ['x'] = -588.6,  ['y'] = 2064.03,  ['z'] = 130.96},
 }
 local points = {}
 local job = {}
 local sellActive = false
 local LevelOne = 25 -- money increase 25%
 local LevelTwo = 50 -- mining speed increase 7 instead of 10
 local LevelThree = 75 -- you can mine and hold upto 60 stones instead of 40
 local LevelFour = 100 -- increased 0.25 payout from gold
 local LevelFive = 150 -- chance to find diamonds when washing stones
 local LevelSix = 200 -- faster washing time 25% reduction
 local LevelSeven = 250 -- faster resmelting time 25% reduction
 local LevelEight = 350 -- increased pay to rest of stones 25%
 local LevelNine = 500 -- double ore when mining
 local LevelTen = 750 -- quick sell location to offload all metals at once
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------ NET-EVENT-HANDLER/BLIPS------------------------------------------------------------------------------

 RegisterNetEvent('xz_miner:timer')
 AddEventHandler('xz_miner:timer', function()
    local timer = 0
    local ped = PlayerPedId()
    
    Citizen.CreateThread(function()
		while timer > -1 do
			Citizen.Wait(300)

			if timer > -1 then
				timer = timer + 1
            end
            if timer == 100 then
                break
            end
		end
    end) 

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(5)
            if GetDistanceBetweenCoords(GetEntityCoords(ped), -592.649, 2532.475, 41.884, true) < 5 then
                Draw3DText( -592.649, 2532.475, 41.884+0.5 -1.400, ('Washing stones in progress ' .. timer .. '%'), 4, 0.1, 0.1)
            end
            if GetDistanceBetweenCoords(GetEntityCoords(ped), 1109.03,-2007.61,30.94, true) < 5 then
                Draw3DText( 1109.03,-2007.61,30.94+0.5 -1.400, ('Remelting stones in progress ' .. timer .. '%'), 4, 0.1, 0.1)
            end
            if timer == 100 then
                timer = 0
                break
            end
        end
    end)
 end)
   

 RegisterNetEvent('xz_miner:createblips')
 AddEventHandler('xz_miner:createblips', function()
    TriggerServerEvent('FL_Perks:LevelChecks')
    Citizen.CreateThread(function()
        while true do 
         Citizen.Wait(5)
         if blips == true and blipActive == false then
            blip1 = AddBlipForCoord(-597.01, 2091.42, 131.41)
            blip2 = AddBlipForCoord(-592.649, 2532.475, 41.884)
            blip3 = AddBlipForCoord(1109.03,-2007.61,30.94)
            blip4 = AddBlipForCoord(-622.387, -230.860, 38.057)
            blip5 = AddBlipForCoord(-428.779, -1728.071, 19.784)
            blip6 = AddBlipForCoord(29.901, -2638.076, 6.057)
            blip7 = AddBlipForCoord(-770.305, -287.233, 37.090)
            SetBlipSprite(blip1, 365)
            SetBlipColour(blip1, 5)
            SetBlipAsShortRange(blip1, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Mine")
            EndTextCommandSetBlipName(blip1)   
            SetBlipSprite(blip2, 365)
            SetBlipColour(blip2, 5)
            SetBlipAsShortRange(blip2, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Washing stones")
            EndTextCommandSetBlipName(blip2)   
            SetBlipSprite(blip3, 365)
            SetBlipColour(blip3, 5)
            SetBlipAsShortRange(blip3, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Smelting stones")
            EndTextCommandSetBlipName(blip3)
            SetBlipSprite(blip4, 272)
            SetBlipColour(blip4, 5)
            SetBlipAsShortRange(blip4, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Sell Gold")
            EndTextCommandSetBlipName(blip4)   
            SetBlipSprite(blip5, 272)
            SetBlipColour(blip5, 5)
            SetBlipAsShortRange(blip5, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Sell Copper")
            EndTextCommandSetBlipName(blip5)
            SetBlipSprite(blip6, 272)
            SetBlipColour(blip6, 5)
            SetBlipAsShortRange(blip6, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Sell Iron")
            EndTextCommandSetBlipName(blip6)
            SetBlipSprite(blip7, 272)
            SetBlipColour(blip7, 5)
            SetBlipAsShortRange(blip7, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Sell Diamond")
            EndTextCommandSetBlipName(blip7)
            blipActive = true
            if tostring(job) == 'Mining' then
                if tonumber(points) >= 750 then  
                 if blips == true and blipActive == false then
                    blipLevelTen= AddBlipForCoord(152.849, -3211.895, 5.900)
                    SetBlipSprite(blipLevelTen, 365)
                    SetBlipColour(blipLevelTen, 5)
                    SetBlipAsShortRange(blipLevelTen, true)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString("Mining Fast Sell")
                    EndTextCommandSetBlipName(blipLevelTen) 
                    blipActive = true
                 elseif blips == false and blipActive == false then
                    RemoveBlip(blipLevelTen)
                 end
               end
             end  
          elseif blips == false and blipActive == false then
            RemoveBlip(blip1)
            RemoveBlip(blip2)
            RemoveBlip(blip3)
            RemoveBlip(blip4)
            RemoveBlip(blip5)
            RemoveBlip(blip6)
            RemoveBlip(blip7)
          end
        end
    end)
 end)

 

------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------ CLOCK-ON/OFF----------------------------------------------------------------------------------
 Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
    Citizen.Wait(5)
      if DecorGetInt(GetPlayerPed(-1), "Job") == 60 and not IsEntityDead( ped ) then
        if GetDistanceBetweenCoords(GetEntityCoords(ped), -96.862, 2810.740, 53.261, true) < 25 then
           DrawMarker(27, -96.862, 2810.740, 53.261-0.95, 0, 0, 0, 0, 0, 90.0, 1.0, 1.0, 1.0, 255, 255, 0,155, 0, 0, 2, 0, 0, 0, 0)
            if GetDistanceBetweenCoords(GetEntityCoords(ped), -96.862, 2810.740, 53.261, true) < 1 then
             Jaybee(-96.862, 2810.740, 53.261,'~g~[E]~w~ Clock ~g~ON/~r~OFF~w~ duty with a ~g~Work Vehicle.\n~g~[H]~w~ Clock ~g~ON/~r~OFF~w~ Duty')
                if IsControlJustReleased(1, 51) then
                    TriggerServerEvent('FL_Perks:LevelChecks')
                    
                    if blips == false then   
                     exports['NRP-notify']:DoLongHudText('success', ' Your Now on Duty, Go To the mine some rocks make sure to use your work truck!')
                     blips = true
                     TriggerEvent('xz_miner:createblips')
                    
                     RequestModel("rumpo3")
                     Citizen.Wait(100)
                     if vehicle ~= nil then
                        DeleteVehicle(vehicle)
                        vehicle = nil
                      end
                     vehicle = CreateVehicle("rumpo3", -92.488, 2808.606, 53.342, 246.198, true, true)
                     exports["onyxLocksystem"]:givePlayerKeys(GetVehicleNumberPlateText(vehicle))
                    else
                     exports['NRP-notify']:DoLongHudText('error', ' Your Now off Duty!')
                     blips = false
                     blipActive = false
                     TriggerEvent('admin:dv')
                     TriggerEvent('xz_miner:createblips')
                     
                    end                    
                end
                if IsControlJustReleased(1, 74) then
                    TriggerServerEvent('FL_Perks:LevelChecks')
                    if blips == false then   
                     exports['NRP-notify']:DoLongHudText('success', ' Your Now on Duty, Go To the mine some rocks!')
                     blips = true
                     
                     TriggerEvent('xz_miner:createblips')
                    else
                     exports['NRP-notify']:DoLongHudText('error', ' Your Now off Duty!')
                     blips = false
                     blipActive = false
                     
                     TriggerEvent('xz_miner:createblips')
                    end    
                end
            end
        end
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
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------- START---------------------------------------------------------------------------------------
 Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(5)
          if DecorGetInt(GetPlayerPed(-1), "Job") == 60 and not IsEntityDead( ped ) then
            for i=1, #locations, 1 do
            if GetDistanceBetweenCoords(GetEntityCoords(ped), locations[i].x, locations[i].y, locations[i].z, true) < 25 and mineActive == false then
                DrawMarker(27, locations[i].x, locations[i].y, locations[i].z-0.90, 0, 0, 0, 0, 0, 100.0, 1.0, 1.0, 1.0, 255, 255, 0, 255, 0, 0, 2, 0, 0, 0, 0)
                if GetDistanceBetweenCoords(GetEntityCoords(ped), locations[i].x, locations[i].y, locations[i].z, true) < 1 then
                    Jaybee(locations[i].x, locations[i].y, locations[i].z,"~g~[E]~w~ to start mining.")
                    if IsControlJustReleased(1, 51) then
                        if exports['core']:GetItemQuantity(282) < 40 then                        
                         TriggerServerEvent('FL_Perks:fastermining')
                         mineActive = true
                        else
                            exports['NRP-notify']:DoHudText('error', 'You cannot carry more then 40 stones!')
                        end        
                    end
                end
            end
          end  
        end
    end
 end)
  function Animation()   
  Citizen.CreateThread(function()
    while impacts < 10 do
        Citizen.Wait(5)
	local ped = PlayerPedId()	
         RequestAnimDict("melee@large_wpn@streamed_core")
         Citizen.Wait(100)
         TaskPlayAnim((ped), 'melee@large_wpn@streamed_core', 'ground_attack_on_spot', 8.0, 8.0, -1, 80, 0, 0, 0, 0)
         SetEntityHeading(ped, 270.0)
         --TriggerServerEvent('InteractSound_SV:PlayOnSource', 'pickaxe', 0.5)
        if impacts == 0 then
                pickaxe = CreateObject(GetHashKey("prop_tool_pickaxe"), 0, 0, 0, true, true, true) 
                AttachEntityToEntity(pickaxe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.18, -0.02, -0.02, 350.0, 100.00, 140.0, true, true, false, true, 1, true)
        end  
         Citizen.Wait(2500)
         ClearPedTasks(ped)
         impacts = impacts+1
        if impacts == 10 then
            DetachEntity(pickaxe, 1, true)
            DeleteEntity(pickaxe)
            DeleteObject(pickaxe)
            mineActive = false
            impacts = 0
            TriggerServerEvent("xz_miner:givestone")
            break
        end                       
      end
  end)
 end

 function Animation2()    
  Citizen.CreateThread(function()  
    while impacts < 7 do
        Citizen.Wait(5)
    local ped = GetPlayerPed(-1)	
         RequestAnimDict("melee@large_wpn@streamed_core")
         Citizen.Wait(100)
         TaskPlayAnim((ped), 'melee@large_wpn@streamed_core', 'ground_attack_on_spot', 8.0, 8.0, -1, 80, 0, 0, 0, 0)
         SetEntityHeading(ped, 270.0)
         --TriggerServerEvent('InteractSound_SV:PlayOnSource', 'pickaxe', 0.5)
        if impacts == 0 then
                pickaxe = CreateObject(GetHashKey("prop_tool_pickaxe"), 0, 0, 0, true, true, true) 
                AttachEntityToEntity(pickaxe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.18, -0.02, -0.02, 350.0, 100.00, 140.0, true, true, false, true, 1, true)
        end  
         Citizen.Wait(2500)
         ClearPedTasks(ped)
         impacts = impacts+1
        if impacts == 7 then
            DetachEntity(pickaxe, 1, true)
            DeleteEntity(pickaxe)
            DeleteObject(pickaxe)
            mineActive = false
            impacts = 0
            TriggerServerEvent("xz_miner:givedoublestone")           
            exports['NRP-notify']:DoLongHudText('inform', 'Your Level 2 Mining or Above So Faster Mining Has Been activated')
            break
        end                              
      end
  end)
 end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------WASHING------------------------------------------------------------------------------------
 Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(5)
      if DecorGetInt(GetPlayerPed(-1), "Job") == 60 and not IsEntityDead( ped ) then 
        if GetDistanceBetweenCoords(GetEntityCoords(ped), -592.649, 2532.475, 41.884, true) < 25 and washingActive == false then
         DrawMarker(27, -592.649, 2532.475, 41.884-0.95, 0, 0, 0, 0, 0, 55.0, 1.0, 1.0, 1.0, 255, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
          if GetDistanceBetweenCoords(GetEntityCoords(ped), -592.649, 2532.475, 41.884, true) < 1 then
            Jaybee(-592.649, 2532.475, 41.884,"~g~[E]~w~ to wash the stones.")
            if IsControlJustReleased(1, 51) then
              if exports['core']:GetItemQuantity(282) > 9 then
                TriggerServerEvent('FL_Perks:fastwashing')         
              else
               exports['NRP-notify']:DoHudText('error', 'You need 10 stones to start washing!') 
              end 
            end
          end
        end
      end  
    end
 end)

 function Washing()
    local ped = PlayerPedId()
    RequestAnimDict("amb@prop_human_bum_bin@idle_a")
    washingActive = true
    Citizen.Wait(100)
    FreezeEntityPosition(ped, true)
    TaskPlayAnim((ped), 'amb@prop_human_bum_bin@idle_a', 'idle_a', 8.0, 8.0, -1, 81, 0, 0, 0, 0)
    TriggerEvent("xz_miner:timer")
    Citizen.Wait(30900)
    ClearPedTasks(ped)
    FreezeEntityPosition(ped, false)
    washingActive = false
    TriggerServerEvent("xz_miner:washing")
    exports['NRP-notify']:DoHudText('success', ' You have washed 10 stones!') 
 end


 function Washing2()
    local ped = PlayerPedId()
    exports['NRP-notify']:DoLongHudText('inform', 'Your Level 6 Mining or Above So Faster Washing Has Been activated')
    RequestAnimDict("amb@prop_human_bum_bin@idle_a")
    washingActive = true
    Citizen.Wait(100)
    FreezeEntityPosition(ped, true)
    TaskPlayAnim((ped), 'amb@prop_human_bum_bin@idle_a', 'idle_a', 8.0, 8.0, -1, 81, 0, 0, 0, 0)
    TriggerEvent("xz_miner:fasttimer")
    Citizen.Wait(26900)
    ClearPedTasks(ped)
    FreezeEntityPosition(ped, false)
    washingActive = false
    TriggerServerEvent("xz_miner:washing")
    exports['NRP-notify']:DoHudText('success', ' You have washed 10 stones!') 
 end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------REMELTING---------------------------------------------------------------------------------
 Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
    Citizen.Wait(5)
      if DecorGetInt(GetPlayerPed(-1), "Job") == 60 and not IsEntityDead( ped ) then  
        if GetDistanceBetweenCoords(GetEntityCoords(ped), 1109.03,-2007.61,30.94, true) < 25 and remeltingActive == false then
            DrawMarker(27, 1109.03,-2007.61,30.94-0.90, 0, 0, 0, 0, 0, 55.0, 1.0, 1.0, 1.0, 255, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
            if GetDistanceBetweenCoords(GetEntityCoords(ped), 1109.03,-2007.61,30.94, true) < 1 then
              Jaybee(1109.03,-2007.61,30.94,"~g~[E]~w~ to remelting stones.")
                if IsControlJustReleased(1, 51) then
                    if exports['core']:GetItemQuantity(283) > 9 then  
                        TriggerServerEvent("xz_miner:fastermelting")
                    else
                        exports['NRP-notify']:DoLongHudText('error', 'You do not have enough washed stones!')
                    end        
                end 
            end    
        end
      end
    end  
 end)

 function Remelting()
    local ped = PlayerPedId()
    RequestAnimDict("amb@prop_human_bum_bin@idle_a")
    remeltingActive = true
    Citizen.Wait(100)
    FreezeEntityPosition(ped, true)
    TaskPlayAnim((ped), 'amb@prop_human_bum_bin@idle_a', 'idle_a', 8.0, 8.0, -1, 81, 0, 0, 0, 0)
    TriggerEvent("xz_miner:timer")
    Citizen.Wait(30900)
    TriggerServerEvent("xz_miner:remelting")
    ClearPedTasks(ped)
    FreezeEntityPosition(ped, false)
    remeltingActive = false
 end

 function Remelting2()
    local ped = PlayerPedId()
    exports['NRP-notify']:DoLongHudText('inform', 'Your Level 7 Mining or Above So Faster Smelting Has Been activated')
    RequestAnimDict("amb@prop_human_bum_bin@idle_a")
    remeltingActive = true
    Citizen.Wait(100)
    FreezeEntityPosition(ped, true)
    TaskPlayAnim((ped), 'amb@prop_human_bum_bin@idle_a', 'idle_a', 8.0, 8.0, -1, 81, 0, 0, 0, 0)
    TriggerEvent("xz_miner:fasttimer")
    Citizen.Wait(26900)
    TriggerServerEvent("xz_miner:remelting")
    ClearPedTasks(ped)
    FreezeEntityPosition(ped, false)
    remeltingActive = false
 end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------SELLING------------------------------------------------------------------------------------
 Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(5)
        if DecorGetInt(GetPlayerPed(-1), "Job") == 60 and not IsEntityDead( ped ) then
            if GetDistanceBetweenCoords(GetEntityCoords(ped), -622.387, -230.860, 38.057, true) < 1 then
                Jaybee(-622.387, -230.860, 38.057,"~g~[E]~w~ To Sell Gold.")
                if IsControlJustReleased(1, 51) then
                     sellActive = true
                    if exports['core']:GetItemQuantity(285) > 4 then
                        TriggerServerEvent("xz_miner:sellgold")
                        TriggerServerEvent('points:add','Mining', 0.50 )
                        Wait(2000)
                        sellActive = false
                    else
                         exports['NRP-notify']:DoLongHudText('error', 'Need atleast 5 Pieces of Gold to sell!')
                         sellActive = false
                    end                           
                end
            end 
            if GetDistanceBetweenCoords(GetEntityCoords(ped), -428.779, -1728.071, 19.784, true) < 1 then
                Jaybee(-428.779, -1728.071, 19.784,"~g~[E]~w~ To Sell Copper.")
                if IsControlJustReleased(1, 51) then
                    if exports['core']:GetItemQuantity(287) > 19 then
                     TriggerServerEvent("xz_miner:sellcopper")
                     TriggerServerEvent('points:add', 'Mining', 0.25) 
                    else
                     exports['NRP-notify']:DoLongHudText('error', 'Need atleast 10 Pieces of Copper to sell!')
                    end
                end
            end
            if GetDistanceBetweenCoords(GetEntityCoords(ped), 29.901, -2638.076, 6.057, true) < 1 then
                Jaybee(29.901, -2638.076, 6.057,"~g~[E]~w~ To Sell Iron.")
                if IsControlJustReleased(1, 51) then    
                    if exports['core']:GetItemQuantity(286) > 9 then
                     TriggerServerEvent("xz_miner:selliron")
                     TriggerServerEvent('points:add', 'Mining', 0.25)
                    else
                     exports['NRP-notify']:DoLongHudText('error', 'Need atleast 10 Pieces of Iron to sell!')
                    end                            
                end
            end
            if GetDistanceBetweenCoords(GetEntityCoords(ped), -770.305, -287.233, 37.090, true) < 1 then
                Jaybee(-770.305, -287.233, 37.090,"~g~[E]~w~ To Sell Diamond.")
                if IsControlJustReleased(1, 51) then 
                    sellActive = true 
                    if exports['core']:GetItemQuantity(284) > 0  then
                     TriggerServerEvent('points:add', 'Mining', 1.00)
                     TriggerServerEvent("xz_miner:selldiamond")
                     Wait(2000)
                     sellActive = false
                    else
                     exports['NRP-notify']:DoLongHudText('error', 'You do not have any diamonds on you!')
                    end
                end
            end   
        end
    end
 end)
    


----------------------------------------------##############################################################################------------------------------------------
--------------------------------------------------------------------------FUNCTIONS-----------------------------------------------------------------------------------


 function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)    
    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100 
    SetTextScale(0.35, 0.35)
    SetTextFont(fontId)
    SetTextProportional(0)
    SetTextColour(255, 255, 255, 215)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()   
 end

 function Jaybee(x,y,z,text)
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
---------------------------------------------################################################################################-----------------------------------------
----------------------------------------------------------------GALLOWS-XZURV-RUNESCAPE-FIVE-M------------------------------------------------------------------------
local cunt = false

Citizen.CreateThread(function()
    while true do 
       Citizen.Wait(5)
       local ped = PlayerPedId()
        if DecorGetInt(GetPlayerPed(-1), "Job") == 60 and not IsEntityDead( ped ) then
            
             TriggerServerEvent('FL_Perks:LevelChecks')
            
        if tostring(job) == 'Mining' then
            if tonumber(points) >= 750 then   
            if GetDistanceBetweenCoords(GetEntityCoords(ped),152.849, -3211.895, 5.900, true) < 1.5 then      ------- ADDD IN CORDS --- and make to level 10
                Jaybee(152.849, -3211.895, 5.900,"~g~[E]~w~ To Sell Diamonds/Gold/Iron/Copper.")  ------- ADDD IN CORDS
                if IsControlJustReleased(1, 51) then
                    sellActive = true 
                    if exports['core']:GetItemQuantity(284) > 0  then
                     TriggerServerEvent("xz_miner:selldiamond")
                     TriggerServerEvent('points:add', 'Mining', 1)
                     Wait(2000)
                     sellActive = false
                    else
                     exports['NRP-notify']:DoLongHudText('error', 'You do not have any diamonds on you!')
                    end
                    if exports['core']:GetItemQuantity(286) > 19 then
                      TriggerServerEvent("xz_miner:selliron")
                      TriggerServerEvent('points:add', 'Mining', 0.25) 
                      Wait(2000)
                      sellActive = false
                    else
                      exports['NRP-notify']:DoLongHudText('error', 'Need atleast 20 Pieces of Iron to sell!')
                      sellActive = false
                    end 
                    if exports['core']:GetItemQuantity(287) > 9 then
                     TriggerServerEvent("xz_miner:sellcopper")
                     TriggerServerEvent('points:add', 'Mining', 0.25) 
                     Wait(2000)
                     sellActive = false
                    else
                     exports['NRP-notify']:DoLongHudText('error', 'Need atleast 10 Pieces of Copper to sell!')
                     sellActive = false
                    end
                    if exports['core']:GetItemQuantity(285) > 4 then
                     TriggerServerEvent("xz_miner:sellgold")
                     TriggerServerEvent('points:add', 'Mining', 0.50)
                     Wait(2000)
                     sellActive = false
                    else
                      exports['NRP-notify']:DoLongHudText('error', 'Need atleast 5 Pieces of Gold to sell!')
                      sellActive = false
                    end 
                    sellActive = false                                  
                end
            end
        end
         end 
        end    
    end
end)




Citizen.CreateThread(function()
       while true do 
        Citizen.Wait(5)     
     if tostring(job) == 'Mining' then
       if tonumber(points) >= 750 then  
        if blips == true and blipActive == false then
           blipLevelTen= AddBlipForCoord(152.849, -3211.895, 5.900)
           SetBlipSprite(blipLevelTen, 365)
           SetBlipColour(blipLevelTen, 5)
           SetBlipAsShortRange(blipLevelTen, true)
           BeginTextCommandSetBlipName("STRING")
           AddTextComponentString("Mining Fast Sell")
           EndTextCommandSetBlipName(blipLevelTen) 
           blipActive = true
        elseif blips == false and blipActive == false then
           RemoveBlip(blipLevelTen)
        end
      end
    end  
     end
end)


 RegisterNetEvent("xz_miner:fastermining")
 AddEventHandler("xz_miner:fastermining", function(value)
    if value >= LevelTwo then  
     Animation2()
    else 
     Animation()    
    end
 end)

 RegisterNetEvent("xz_miner:fastermelting")
 AddEventHandler("xz_miner:fastermelting", function(value)
  if value >= LevelSeven then
    Remelting2()
  else
    Remelting()
   end
 end)


 RegisterNetEvent("xz_miner:doubleore")
 AddEventHandler("xz_miner:doubleore", function(value)
    if value >= LevelNine then
        exports['NRP-notify']:DoHudText('inform', 'Your Level 9 Mining or Above : Faster Mining and Holding 60 Stones Has Been activated')
        if exports['core']:GetItemQuantity(282) < 60 then
            exports['NRP-notify']:DoHudText('success', 'You have gathered 10 stones!')
            TriggerServerEvent("xz_miner:givedoublestone")
        else
            exports['NRP-notify']:DoHudText('error', 'You cannot carry more then 60 stones!')
        end 
    elseif value >= LevelThree then
        exports['NRP-notify']:DoHudText('inform', 'Your Level 3 Mining or Above : Holding 60 Stones Has Been activated')
        if exports['core']:GetItemQuantity(282) < 60 then 
            exports['NRP-notify']:DoHudText('success', 'You have gathered 5 stones!')
            TriggerServerEvent("xz_miner:givestone")
        else
            exports['NRP-notify']:DoHudText('error', 'You cannot carry more then 60 stones!')
        end          
    else
        if exports['core']:GetItemQuantity(282) < 40 then 
            exports['NRP-notify']:DoHudText('success', 'You have gathered 5 stones!')
            TriggerServerEvent("xz_miner:givestone")
        else
            exports['NRP-notify']:DoHudText('error', 'You cannot carry more then 40 stones!')
        end          
    end
 end)    
    
 RegisterNetEvent("xz_miner:fasterwashing")
 AddEventHandler("xz_miner:fasterwashing", function(value)
    if value >= LevelSix then
     Washing2()
    else   
     Washing() 
    end
 end)


 RegisterNetEvent('xz_miner:fasttimer')
 AddEventHandler('xz_miner:fasttimer', function()
    local timer = 0
    local ped = PlayerPedId()
    Citizen.CreateThread(function()
		while timer > -1 do
			Citizen.Wait(230)

			if timer > -1 then
				timer = timer + 1
            end
            if timer == 100 then
                break
            end
		end
    end) 
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(5)
            if GetDistanceBetweenCoords(GetEntityCoords(ped), -592.649, 2532.475, 41.884, true) < 5 then
                Draw3DText( -592.649, 2532.475, 41.884+0.5 -1.400, ('Washing stones in progress ' .. timer .. '%'), 4, 0.1, 0.1)
            end
            if GetDistanceBetweenCoords(GetEntityCoords(ped), 1109.03,-2007.61,30.94, true) < 5 then
                Draw3DText( 1109.03,-2007.61,30.94+0.5 -1.400, ('Remelting stones in progress ' .. timer .. '%'), 4, 0.1, 0.1)
            end
            if timer == 100 then
                timer = 0
                break
            end
        end
    end)
 end)
