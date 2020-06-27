local nearObject = false 
local isNearObject = false
local objectLoc = {}
local clostestProp = nil
local distance = nil
local doorList = {
  [1] = { ["obj"] = "v_ilev_ph_gendoor004", ["x"] = 449.69, ["y"] = -986.46, ["z"] = 30.68, ["locked"] = true, ["rotation"] = 90.0},
  [2] = { ["obj"] = "v_ilev_ph_gendoor002", ["x"] = 446.85, ["y"] = -980.42, ["z"] = 30.69, ["locked"] = true, ["rotation"] = 180.0},
  [3] = { ["obj"] = "v_ilev_ph_door002", ["x"] = 434.74, ["y"] = -983.21, ["z"] = 30.83, ["locked"] = false, ["rotation"] = 270.0},
  [4] = { ["obj"] = "v_ilev_ph_door01", ["x"] = 434.74, ["y"] = -980.61, ["z"] = 30.83, ["locked"] = false, ["rotation"] = 270.0},
  [5] = { ["obj"] = "v_ilev_ph_gendoor005", ["x"] = 443.40, ["y"] = -989.44, ["z"] = 30.83, ["locked"] = true, ["rotation"] = 180.0},
  [6] = { ["obj"] = "v_ilev_ph_gendoor005", ["x"] = 446.00, ["y"] = -989.44, ["z"] = 30.83, ["locked"] = true, ["rotation"] = 0.0},
  [7] = { ["obj"] = "v_ilev_gtdoor", ["x"] = 444.62, ["y"] = -999.55, ["z"] = 30.72, ["locked"] = true, ["rotation"] = 0.0},
  [8] = { ["obj"] = "v_ilev_gtdoor", ["x"] = 447.24, ["y"] = -999.49, ["z"] = 30.72, ["locked"] = true, ["rotation"] = 180.0},
  [9] = { ["obj"] = "prop_fnclink_02gate7", ["x"] = 475.98, ["y"] = -986.96, ["z"] = 24.91, ["locked"] = true, ["rotation"] = 90.0},
  [10] = { ["obj"] = "v_ilev_ph_gendoor006", ["x"] = 470.92, ["y"] = -986.16, ["z"] = 24.91, ["locked"] = true, ["rotation"] = 270.0},
  [11] = { ["obj"] = "v_ilev_ph_cellgate", ["x"] = 464.49, ["y"] = -992.26, ["z"] = 24.91, ["locked"] = true, ["rotation"] = 0.0},
  [12] = { ["obj"] = "v_ilev_ph_cellgate", ["x"] = 462.15, ["y"] = -994.38, ["z"] = 24.91, ["locked"] = true, ["rotation"] = 270.0},
  [13] = { ["obj"] = "v_ilev_ph_cellgate", ["x"] = 462.24, ["y"] = -997.63, ["z"] = 24.91, ["locked"] = true, ["rotation"] = 90.0},
  [14] = { ["obj"] = "v_ilev_ph_cellgate", ["x"] = 462.30, ["y"] = -1001.29, ["z"] = 24.91, ["locked"] = true, ["rotation"] = 90.0},
  [15] = { ["obj"] = "v_ilev_gtdoor", ["x"] = 463.73, ["y"] = -1002.99, ["z"] = 24.91, ["locked"] = true, ["rotation"] = 0.0},
  [16] = { ["obj"] = "v_ilev_rc_door2", ["x"] = 467.74, ["y"] = -1014.90, ["z"] = 26.39, ["locked"] = true, ["rotation"] = 0.0},
  [17] = { ["obj"] = "v_ilev_rc_door2", ["x"] = 469.61, ["y"] = -1014.84, ["z"] = 26.39, ["locked"] = true, ["rotation"] = 180.0},
  [18] = { ["obj"] = "v_ilev_gtdoor", ["x"] = 467.17, ["y"] = -996.95, ["z"] = 24.91, ["locked"] = true, ["rotation"] = 0.0},
  [19] = { ["obj"] = "v_ilev_gtdoor", ["x"] = 471.41, ["y"] = -996.92, ["z"] = 24.91, ["locked"] = true, ["rotation"] = 0.0},
  [20] = { ["obj"] = "v_ilev_gtdoor", ["x"] = 475.71, ["y"] = -996.92, ["z"] = 24.91, ["locked"] = true, ["rotation"] = 0.0},
  [21] = { ["obj"] = "v_ilev_gtdoor", ["x"] = 480.08, ["y"] = -996.96, ["z"] = 24.91, ["locked"] = true, ["rotation"] = 0.0},
  [22] = { ["obj"] = "v_ilev_arm_secdoor", ["x"] = 461.77, ["y"] = -985.28, ["z"] = 30.69, ["locked"] = true, ["rotation"] = 90.0},
}

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(10)
  nearObject = false
  isNearObject = false   
  local myCoords = GetEntityCoords(GetPlayerPed(-1))
  for i = 1, #doorList do
   if(GetDistanceBetweenCoords(myCoords, doorList[i]["x"], doorList[i]["y"], doorList[i]["z"], true) < 1.3) then
    clostestProp = GetClosestObjectOfType(myCoords.x, myCoords.y, myCoords.z, 3.5, GetHashKey(doorList[i]["obj"]), false, false)
    if clostestProp ~= nil and clostestProp ~= 0 then
     local coords = GetEntityCoords(clostestProp)
     isNearObject = true
     objectLoc = {['x'] = coords.x, ['y'] = coords.y, ['z'] = coords.z, ['locked'] = doorList[i]["locked"], ['rotation'] = doorList[i]["rotation"], id = i, object = clostestProp}
    end
   end
  end
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
 --if DecorGetInt(GetPlayerPed(-1), "Job") == 1 or DecorGetInt(GetPlayerPed(-1), "Job") == 18 or DecorGetInt(GetPlayerPed(-1), "Job") == 32 or DecorGetInt(GetPlayerPed(-1), "Job") == 33 or DecorGetInt(GetPlayerPed(-1), "Job") == 34 or DecorGetInt(GetPlayerPed(-1), "Job") == 35 or DecorGetInt(GetPlayerPed(-1), "Job") == 36 or DecorGetInt(GetPlayerPed(-1), "Job") == 37 or DecorGetInt(GetPlayerPed(-1), "Job") == 90 or DecorGetInt(GetPlayerPed(-1), "Job") == 91 then
Citizen.CreateThread(function()
  while true do
   Wait(5)
   if isNearObject then
    if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), objectLoc.x, objectLoc.y, objectLoc.z, true) < 2.0) then
     if objectLoc.locked then DrawText3Ds(objectLoc.x, objectLoc.y, objectLoc.z, '[E] Unlock Door') else DrawText3Ds(objectLoc.x, objectLoc.y, objectLoc.z,'[E] Lock Door') end
      FreezeEntityPosition(objectLoc.object, objectLoc.locked)
     if IsControlJustPressed(0, 38) then
      --playLockAnimation()
      if DecorGetBool(GetPlayerPed(-1), "isOfficer") then
      --if exports['core']:GetItemQuantity(253) >= 1 then 
       if objectLoc.locked then
        --FreezeEntityPosition(objectLoc.object, false)
        if objectLoc.id == 10 or objectLoc.id == 11 then
         TriggerServerEvent('doorLock:LockDoor', 10, false)
         TriggerServerEvent('doorLock:LockDoor', 11, false)
      elseif objectLoc.id == 12 or objectLoc.id == 13 then
         TriggerServerEvent('doorLock:LockDoor', 12, false)
         TriggerServerEvent('doorLock:LockDoor', 13, false)
      else
         TriggerServerEvent('doorLock:LockDoor', objectLoc.id, false)
      end
       else
        --Wait(2000)
        FreezeEntityPosition(objectLoc.object, true)
        SetEntityRotation(objectLoc.object, 0.0, 0.0, objectLoc.rotation, 2, true)
        if objectLoc.id == 10 or objectLoc.id == 11 then
         TriggerServerEvent('doorLock:LockDoor', 10, true)
         TriggerServerEvent('doorLock:LockDoor', 11, true)
        elseif objectLoc.id == 12 or objectLoc.id == 13 then
         TriggerServerEvent('doorLock:LockDoor', 12, true)
         TriggerServerEvent('doorLock:LockDoor', 13, true)
        else
         TriggerServerEvent('doorLock:LockDoor', objectLoc.id, true)
        end
       end
      end
     end
    end
   end
  end
 end)

RegisterNetEvent('doorLock:LockDoor')
AddEventHandler('doorLock:LockDoor', function(door, bool)
 doorList[door]["locked"] = bool
end)

RegisterNetEvent('doorLock:doors')
AddEventHandler('doorLock:doors', function(doors)
 doorList = doors
end)

function playLockAnimation()
 RequestAnimDict('missheistfbisetup1')
 while not HasAnimDictLoaded('missheistfbisetup1') do
  Citizen.Wait(10)
 end
 TaskPlayAnim(PlayerPedId(), "missheistfbisetup1", "unlock_enter_janitor", 8.0, 8.0, -1, 50, 0, false, false, false)
 Wait(2000)
 ClearPedTasks(PlayerPedId())
end