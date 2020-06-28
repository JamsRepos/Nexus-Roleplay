local vehicles = {}
local searchedVehicles = {}
local pickedVehicled = {}
local hasCheckedOwnedVehs = false
local lockDisable = false

function givePlayerKeys(plate)
    local vehPlate = plate
    table.insert(vehicles, vehPlate)
end

function hasToggledLock()
    lockDisable = true
    Wait(100)
    lockDisable = false
end

function playLockAnim(vehicle)
    local dict = "anim@mp_player_intmenu@key_fob@"
    RequestAnimDict(dict)

    local veh = vehicle

    while not HasAnimDictLoaded do
        Citizen.Wait(0)
    end

    if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
        TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
    end
end

function toggleLock(vehicle)
    local veh = vehicle

    local plate = GetVehicleNumberPlateText(veh)
    local lockStatus = GetVehicleDoorLockStatus(veh)
    if hasKeys(plate) and not lockDisable then
        print('lock status: ' .. lockStatus)
        if lockStatus == 1 then
            SetVehicleDoorsLocked(veh, 2)
            SetVehicleDoorsLockedForAllPlayers(veh, true)
            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "lock", 0.1)
            exports['NRP-notify']:DoHudText('error', 'Vehicle Locked')
            playLockAnim()
            hasToggledLock()
        elseif lockStatus == 2 then
            SetVehicleDoorsLocked(veh, 1)
            SetVehicleDoorsLockedForAllPlayers(veh, false)
            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "lock", 0.1)
            exports['NRP-notify']:DoHudText('success', 'Vehicle Unlocked')
            playLockAnim(veh)
            hasToggledLock()
        else
            SetVehicleDoorsLocked(veh, 2)
            SetVehicleDoorsLockedForAllPlayers(veh, true)
            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "lock", 0.1)
            exports['NRP-notify']:DoHudText('error', 'Vehicle Locked')
            playLockAnim()
            hasToggledLock()
        end
        if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
            Wait(500)
            local flickers = 0
            while flickers < 2 do
                SetVehicleLights(veh, 2)
                Wait(170)
                SetVehicleLights(veh, 0)
                flickers = flickers + 1
                Wait(170)
            end
        end
    end
end

RegisterNetEvent('onyx:pickDoor')
AddEventHandler('onyx:pickDoor', function()
    -- TODO: Lockpicking vehicle doors to gain access
end)

-- Locking vehicles
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local pos = GetEntityCoords(GetPlayerPed(-1))
        if IsControlJustReleased(0, 47) then
            if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
                toggleLock(veh)
            else
                local veh = GetClosestVehicle(pos.x, pos.y, pos.z, 16.0, 0, 71)
                if DoesEntityExist(veh) then
                    toggleLock(veh)
                end
            end
        end

        -- TODO: Unable to gain access to vehicles without a lockpick or keys
        -- local enteringVeh = GetVehiclePedIsTryingToEnter(GetPlayerPed(-1))
        -- local enteringPlate = GetVehicleNumberPlateText(enteringVeh)

        -- if not hasKeys(entertingPlate) then
        --     SetVehicleDoorsLocked(enteringVeh, 2)
        -- end
    end
end)

local isSearching = false
local isHotwiring = false

-- Has entered vehicle without keys
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = GetPlayerPed(-1)
        if IsPedInAnyVehicle(ped, false) then
            local veh = GetVehiclePedIsIn(ped)
            local driver = GetPedInVehicleSeat(veh, -1)
            local plate = GetVehicleNumberPlateText(veh)
            if driver == ped then
                if not hasKeys(plate) and not isHotwiring and not isSearching then
                    local pos = GetEntityCoords(ped)
                    if hasBeenSearched(plate) then
                        DrawText3Ds(pos.x, pos.y, pos.z + 0.2, 'Press ~y~[H] ~w~to hotwire')
                    else
                        DrawText3Ds(pos.x, pos.y, pos.z + 0.2, 'Press ~y~[H] ~w~to hotwire or ~g~[K] ~w~to search')
                    end
                    SetVehicleEngineOn(veh, false, true, true)
                    -- Searching
                    if IsControlJustReleased(0, 311) and not isSearching and not hasBeenSearched(plate) then -- K
                        if hasBeenSearched(plate) then
                            isSearching = true
                            TriggerEvent("mythic_progbar:client:progress", {
                                name = "searching_vehicle",
                                duration = 5000,
                                label = "Searching Vehicle",
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
                                    isSearching = false
                                    exports['NRP-notify']:DoHudText('error', 'You search the vehicle and find nothing')
                                end
                            end)
                        else
                            local rnd = math.random(1, 8)
                            if rnd == 4 then
                                isSearching = true
                                TriggerEvent("mythic_progbar:client:progress", {
                                    name = "searching_vehicle2",
                                    duration = 6000,
                                    label = "Searching Vehicle",
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
                                        isSearching = false
                                        exports['NRP-notify']:DoHudText('inform', "You found the keys for plate [" .. plate .. ']')
                                        table.insert(vehicles, plate)
                                        TriggerServerEvent('onyx:updateSearchedVehTable', plate)
                                        table.insert(searchedVehicles, plate)
                                    end
                                end)
                            else
                                isSearching = true
                                TriggerEvent("mythic_progbar:client:progress", {
                                    name = "searching_vehicle3",
                                    duration = 6000,
                                    label = "Searching Vehicle",
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
                                        isSearching = false
                                        exports['NRP-notify']:DoHudText('error', 'You search the vehicle and find nothing')
        
                                        -- Update veh table so other players cant search the same vehicle
                                        TriggerServerEvent('onyx:updateSearchedVehTable', plate)
                                        table.insert(searchedVehicles, plate)
                                    end
                                end)
                            end
                        end
                    end
                    -- Hotwiring
                    if IsControlJustReleased(0, 74) and not isHotwiring then -- E
                        if exports['core']:GetItemQuantity(7) >= 1 then
                            TriggerServerEvent('onyx:reqHotwiring', plate)
                            local rnd = math.random(1, 5)
                            if rnd == 1 then
                                TriggerEvent("inventory:removeQty", 7, 1)
                                TriggerEvent('NRP-notify:client:SendAlert', {type = 'error', text = 'Your lockpick has bent out of shape.'})
                            end
                        else
                            exports['NRP-notify']:DoHudText('error', 'You do not have a lockpick.')
                        end
                    end
                else
                    --SetVehicleEngineOn(veh, true, true, false)
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if isHotwiring then
            DisableControlAction(0, 75, true)  -- Disable exit vehicle
            DisableControlAction(0, 74, true)  -- Lights
        end
    end
end)

RegisterNetEvent('onyx:updatePlates')
AddEventHandler('onyx:updatePlates', function(plate)
    table.insert(vehicles, plate)
end)

RegisterNetEvent('onyx:beginHotwire')
AddEventHandler('onyx:beginHotwire', function(plate)
    local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    RequestAnimDict("veh@std@ds@base")

    while not HasAnimDictLoaded("veh@std@ds@base") do
        Citizen.Wait(100)
	end
    local time = 12500 -- in ms

    local vehPlate = plate
    isHotwiring = true

    SetVehicleEngineOn(veh, false, true, true)
    SetVehicleLights(veh, 0)
    
    if Config.HotwireAlarmEnabled then
        local alarmChance = math.random(1, Config.HotwireAlarmChance)

        if alarmChance == 1 then
            SetVehicleAlarm(veh, true)
            StartVehicleAlarm(veh)

            local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh)))
            local vehicleColour = getVehicleColours(veh)
            local suspectSex = getSuspectSex()
            local suspectLocation = getSuspectLocation()

            TriggerServerEvent('dispatch:vehicle', suspectLocation, suspectSex, vehicleName, vehPlate, vehicleColour)
            if DecorGetBool(GetPlayerPed(-1), "isOfficer") and DecorGetBool(GetPlayerPed(-1), "isInService") then
                TriggerServerEvent('InteractSound_SV:PlayOnSource', 'VTheft', 0.05)
            end
        end
    end

    TaskPlayAnim(PlayerPedId(), "veh@std@ds@base", "hotwire", 8.0, 8.0, -1, 1, 0.3, true, true, true)
    TriggerEvent("mythic_progbar:client:progress", {
        name = "hotwiring_stage1",
        duration = time,
        label = "Hotwiring [Stage 1]",
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
            TaskPlayAnim(PlayerPedId(), "veh@std@ds@base", "hotwire", 8.0, 8.0, -1, 1, 0.6, true, true, true)
            TriggerEvent("mythic_progbar:client:progress", {
                name = "hotwiring_stage2",
                duration = time,
                label = "Hotwiring [Stage 2]",
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
                    TaskPlayAnim(PlayerPedId(), "veh@std@ds@base", "hotwire", 8.0, 8.0, -1, 1, 0.4, true, true, true)
                    TriggerEvent("mythic_progbar:client:progress", {
                        name = "hotwiring_stage3",
                        duration = time,
                        label = "Hotwiring [Stage 3]",
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
                            table.insert(vehicles, vehPlate)
                            StopAnimTask(PlayerPedId(), 'veh@std@ds@base', 'hotwire', 1.0)
                            isHotwiring = false
                            SetVehicleEngineOn(veh, true, true, false)
                        end
                    end)
                end
            end)
        end
    end)
end)

local isRobbing = false
local canRob = false
local prevPed = false
local prevCar = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local foundEnt, aimingEnt = GetEntityPlayerIsFreeAimingAt(PlayerId())
        local entPos = GetEntityCoords(aimingEnt)
        local pos = GetEntityCoords(GetPlayerPed(-1))
        local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, entPos.x, entPos.y, entPos.z, true)

        if foundEnt and prevPed ~= aimingEnt and IsPedInAnyVehicle(aimingEnt, false) and IsPedArmed(PlayerPedId(), 7) and dist < 20.0 and not IsPedInAnyVehicle(PlayerPedId()) then
            if not IsPedAPlayer(aimingEnt) then
                prevPed = aimingEnt
                Wait(math.random(300, 700))
                local dict = "random@mugging3"
                RequestAnimDict(dict)
                while not HasAnimDictLoaded(dict) do
                    Citizen.Wait(0)
                end
                local rand = math.random(1, 10)

                if rand > 4 then
                    prevCar = GetVehiclePedIsIn(aimingEnt, false)
                    TaskLeaveVehicle(aimingEnt, prevCar)
                    SetVehicleEngineOn(prevCar, false, false, false)
                    while IsPedInAnyVehicle(aimingEnt, false) do
                        Citizen.Wait(0)
                    end
                    SetBlockingOfNonTemporaryEvents(aimingEnt, true)
                    ClearPedTasksImmediately(aimingEnt)
                    TaskPlayAnim(aimingEnt, dict, "handsup_standing_base", 8.0, -8.0, 0.01, 49, 0, 0, 0, 0)
                    ResetPedLastVehicle(aimingEnt)
                    TaskWanderInArea(aimingEnt, 0, 0, 0, 20, 100, 100)
                    canRob = true
                    beginRobTimer(aimingEnt)
                end
            end
        end
    end
end)

local canTakeKeys = true

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if canRob and not IsEntityDead(prevPed) and IsPlayerFreeAiming(PlayerId()) then
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            local entPos = GetEntityCoords(prevPed)
            if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, entPos.x, entPos.y, entPos.z, false) < 3.5 then
                DrawText3Ds(entPos.x, entPos.y, entPos.z, 'Press ~y~[E]~w~ to rob')
                if IsControlJustReleased(0, 38) then
                    local rand = math.random(1, 5)
                    if rand == 1 then
                        Wait(400)
                        exports['NRP-notify']:DoHudText('inform', 'They do not hand over the keys')
                    else
                        local plate = GetVehicleNumberPlateText(prevCar)
                        local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(prevCar)))
                        local vehicleColour = getVehicleColours(prevCar)
                        local suspectSex = getSuspectSex()
                        local suspectLocation = getSuspectLocation()
            
                        TriggerServerEvent('dispatch:vehicle', suspectLocation, suspectSex, vehicleName, plate, vehicleColour)
                        if DecorGetBool(GetPlayerPed(-1), "isOfficer") and DecorGetBool(GetPlayerPed(-1), "isInService") then
                            TriggerServerEvent('InteractSound_SV:PlayOnSource', 'VTheft', 0.05)
                        end

                        Wait(1000)
                        
                        givePlayerKeys(plate)
                        exports['NRP-notify']:DoHudText('inform', 'You rob the keys')
                    end
                    SetBlockingOfNonTemporaryEvents(prevPed, false)
                    canRob = false
                end
            end
        end
    end
end)

-- if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, entPos.x, entPos.y, entPos.z, false) < 4.5 and canRob then
--     if not IsEntityDead(aimingEnt) then
--         DrawText3Ds(entPos.x, entPos.y, entPos.z, 'Press ~y~[E]~w~ to rob')
--         print('message should pop up')
--         if IsControlJustReleased(0, 38) then
--             local plate = GetVehicleNumberPlateText(prevCar)
--             exports['progressBars']:startUI(3500, "Taking Keys")
--             Wait(3600)
--             givePlayerKeys(plate)
--             exports['NRP-notify']:DoHudText('inform', 'You rob the keys')
--             canRob = false
--         end
--     end

function beginRobTimer(entity)
    local timer = 18

    while canRob do
        timer = timer - 1
        if timer == 0 then
            canRob = false
            SetBlockingOfNonTemporaryEvents(entity, false)
        end
        Wait(1000)
    end
end

function isNpc(ped)
    if IsPedAPlayer(ped) then
        return false
    else
        return true
    end
end


RegisterNetEvent('onyx:returnSearchedVehTable')
AddEventHandler('onyx:returnSearchedVehTable', function(plate)
    local vehPlate = plate
    table.insert(searchedVehicles, vehPlate)
end)

function hasBeenSearched(plate)
    local vehPlate = plate
    for k, v in ipairs(searchedVehicles) do
        if v == vehPlate then
            return true
        end
    end
    return false
end

function hasKeys(plate)
    local vehPlate = plate
    for k, v in ipairs(vehicles) do
        if v == vehPlate or v == vehPlate .. ' ' then
            return true
        end
    end
    if exports['core']:HasKey(vehPlate) then
        return true
    end
    if DecorGetBool(GetPlayerPed(-1), "isOfficer") or DecorGetBool(GetPlayerPed(-1), "isParamedic") then
        return true
    end
    return false
end

function DrawText3Ds(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local factor = #text / 460
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	
	SetTextScale(0.3, 0.3)
	SetTextFont(6)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 160)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	DrawRect(_x,_y + 0.0115, 0.02 + factor, 0.027, 28, 28, 28, 95)
end

local vehicleColors = {['0'] = "Metallic Black", ['1'] = "Metallic Graphite Black", ['2'] = "Metallic Black Steal", ['3'] = "Metallic Dark Silver", ['4'] = "Metallic Silver", ['5'] = "Metallic Blue Silver", ['6'] = "Metallic Steel Gray", ['7'] = "Metallic Shadow Silver", ['8'] = "Metallic Stone Silver", ['9'] = "Metallic Midnight Silver", ['10'] = "Metallic Gun Metal", ['11'] = "Metallic Anthracite Grey", ['12'] = "Matte Black", ['13'] = "Matte Gray", ['14'] = "Matte Light Grey", ['15'] = "Util Black", ['16'] = "Util Black Poly", ['17'] = "Util Dark silver", ['18'] = "Util Silver", ['19'] = "Util Gun Metal", ['20'] = "Util Shadow Silver", ['21'] = "Worn Black", ['22'] = "Worn Graphite", ['23'] = "Worn Silver Grey", ['24'] = "Worn Silver", ['25'] = "Worn Blue Silver", ['26'] = "Worn Shadow Silver", ['27'] = "Metallic Red", ['28'] = "Metallic Torino Red", ['29'] = "Metallic Formula Red", ['30'] = "Metallic Blaze Red", ['31'] = "Metallic Graceful Red", ['32'] = "Metallic Garnet Red", ['33'] = "Metallic Desert Red", ['34'] = "Metallic Cabernet Red", ['35'] = "Metallic Candy Red", ['36'] = "Metallic Sunrise Orange", ['37'] = "Metallic Classic Gold", ['38'] = "Metallic Orange", ['39'] = "Matte Red", ['40'] = "Matte Dark Red", ['41'] = "Matte Orange", ['42'] = "Matte Yellow", ['43'] = "Util Red", ['44'] = "Util Bright Red", ['45'] = "Util Garnet Red", ['46'] = "Worn Red", ['47'] = "Worn Golden Red", ['48'] = "Worn Dark Red", ['49'] = "Metallic Dark Green", ['50'] = "Metallic Racing Green", ['51'] = "Metallic Sea Green", ['52'] = "Metallic Olive Green", ['53'] = "Metallic Green", ['54'] = "Metallic Gasoline Blue Green", ['55'] = "Matte Lime Green", ['56'] = "Util Dark Green", ['57'] = "Util Green", ['58'] = "Worn Dark Green", ['59'] = "Worn Green", ['60'] = "Worn Sea Wash", ['61'] = "Metallic Midnight Blue", ['62'] = "Metallic Dark Blue", ['63'] = "Metallic Saxony Blue", ['64'] = "Metallic Blue", ['65'] = "Metallic Mariner Blue", ['66'] = "Metallic Harbor Blue", ['67'] = "Metallic Diamond Blue", ['68'] = "Metallic Surf Blue", ['69'] = "Metallic Nautical Blue", ['70'] = "Metallic Bright Blue", ['71'] = "Metallic Purple Blue", ['72'] = "Metallic Spinnaker Blue", ['73'] = "Metallic Ultra Blue", ['74'] = "Metallic Bright Blue", ['75'] = "Util Dark Blue", ['76'] = "Util Midnight Blue", ['77'] = "Util Blue", ['78'] = "Util Sea Foam Blue", ['79'] = "Uil Lightning blue", ['80'] = "Util Maui Blue Poly", ['81'] = "Util Bright Blue", ['82'] = "Matte Dark Blue", ['83'] = "Matte Blue", ['84'] = "Matte Midnight Blue", ['85'] = "Worn Dark blue", ['86'] = "Worn Blue", ['87'] = "Worn Light blue", ['88'] = "Metallic Taxi Yellow", ['89'] = "Metallic Race Yellow", ['90'] = "Metallic Bronze", ['91'] = "Metallic Yellow Bird", ['92'] = "Metallic Lime", ['93'] = "Metallic Champagne", ['94'] = "Metallic Pueblo Beige", ['95'] = "Metallic Dark Ivory", ['96'] = "Metallic Choco Brown", ['97'] = "Metallic Golden Brown", ['98'] = "Metallic Light Brown", ['99'] = "Metallic Straw Beige", ['100'] = "Metallic Moss Brown", ['101'] = "Metallic Biston Brown", ['102'] = "Metallic Beechwood", ['103'] = "Metallic Dark Beechwood", ['104'] = "Metallic Choco Orange", ['105'] = "Metallic Beach Sand", ['106'] = "Metallic Sun Bleeched Sand", ['107'] = "Metallic Cream", ['108'] = "Util Brown", ['109'] = "Util Medium Brown", ['110'] = "Util Light Brown", ['111'] = "Metallic White", ['112'] = "Metallic Frost White", ['113'] = "Worn Honey Beige", ['114'] = "Worn Brown", ['115'] = "Worn Dark Brown", ['116'] = "Worn straw beige", ['117'] = "Brushed Steel", ['118'] = "Brushed Black steel", ['119'] = "Brushed Aluminium", ['120'] = "Chrome", ['121'] = "Worn Off White", ['122'] = "Util Off White", ['123'] = "Worn Orange", ['124'] = "Worn Light Orange", ['125'] = "Metallic Securicor Green", ['126'] = "Worn Taxi Yellow", ['127'] = "police car blue", ['128'] = "Matte Green", ['129'] = "Matte Brown", ['130'] = "Worn Orange", ['131'] = "Matte White", ['132'] = "Worn White", ['133'] = "Worn Olive Army Green", ['134'] = "Pure White", ['135'] = "Hot Pink", ['136'] = "Salmon pink", ['137'] = "Metallic Vermillion Pink", ['138'] = "Orange", ['139'] = "Green", ['140'] = "Blue", ['141'] = "Mettalic Black Blue", ['142'] = "Metallic Black Purple", ['143'] = "Metallic Black Red", ['144'] = "hunter green", ['145'] = "Metallic Purple", ['146'] = "Metaillic V Dark Blue", ['147'] = "MODSHOP BLACK1", ['148'] = "Matte Purple", ['149'] = "Matte Dark Purple", ['150'] = "Metallic Lava Red", ['151'] = "Matte Forest Green", ['152'] = "Matte Olive Drab", ['153'] = "Matte Desert Brown", ['154'] = "Matte Desert Tan", ['155'] = "Matte Foilage Green", ['156'] = "DEFAULT ALLOY COLOR", ['157'] = "Epsilon Blue",}
function getVehicleColours(vehicle)
    local primary, secondary = GetVehicleColours(vehicle)
    return {primary = vehicleColors[tostring(primary)], secondary = vehicleColors[tostring(secondary)]}
end

function getSuspectSex()
    local sex = 'Male'
    if GetEntityModel(GetPlayerPed(-1)) == -1667301416 then 
        sex = "Female" 
    else 
        sex = "Male" 
    end
    return sex
end

function getSuspectLocation()
    local pos = GetEntityCoords(GetPlayerPed(-1),  true)
    local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, pos.x, pos.y, pos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
    if s2 == 0 then 
        return {street1 = GetStreetNameFromHashKey(s1), street2 = GetStreetNameFromHashKey(s2), both = false, pos = {x = pos.x, y = pos.y, z = pos.z}}
    else 
        return {street1 = GetStreetNameFromHashKey(s1), street2 = GetStreetNameFromHashKey(s2), both = true, pos = {x = pos.x, y = pos.y, z = pos.z}}
    end
end