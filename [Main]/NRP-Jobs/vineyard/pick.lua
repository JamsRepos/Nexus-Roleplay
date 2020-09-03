local atvVehicle = nil
local onJob = false
local grapesDelivered = 0
local currentJobID = nil
local PackageObject = nil

local grapePos = {
  ['Max'] = 44,
  [1] = {x = -1903.490, y = 2103.758, z = 134.501},
  [2] = {x = -1875.374, y = 2097.563, z = 139.736},
  [3] = {x = -1856.153, y = 2097.912, z = 139.195},
  [4] = {x = -1825.891, y = 2112.304, z = 135.509},
  [5] = {x = -1797.909, y = 2123.389, z = 131.584},
  [6] = {x = -1757.453, y = 2140.158, z = 125.310}, 
  [7] = {x = -1717.927, y = 2160.943, z = 115.599}, 
  [8] = {x = -1698.925, y = 2166.491, z = 110.879},
  [9] = {x = -1740.514, y = 2166.349, z = 117.712},
  [10] = {x = -1798.769, y = 2166.557, z = 112.711},
  [11] = {x = -1802.281, y = 2175.269, z = 108.021},
  [12] = {x = -1775.801, y = 2172.915, z = 114.579},
  [13] = {x = -1750.481, y = 2175.118, z = 114.454},
  [14] = {x = -1721.994, y = 2173.311, z = 110.888}, 
  [15] = {x = -1681.142, y = 2175.426, z = 105.256},
  [16] = {x = -1683.166, y = 2180.133, z = 103.791},
  [17] = {x = -1747.298, y = 2179.512, z = 111.902},
  [18] = {x = -1831.969, y = 2186.222, z = 100.969},
  [19] = {x = -1894.120, y = 2195.859, z = 99.513},
  [20] = {x = -1874.330, y = 2198.920, z = 102.644},
  [21] = {x = -1837.174, y = 2201.653, z = 93.284},
  [22] = {x = -1886.172, y = 2208.094, z = 96.485},
  [23] = {x = -1870.198, y = 2216.070, z = 95.462},
  [24] = {x = -1847.818, y = 2235.641, z = 85.170},
  [25] = {x = -1899.477, y = 2245.046, z = 79.312},
  [26] = {x = -1900.121, y = 2254.130, z = 75.114},
  [27] = {x = -1855.227, y = 2245.171, z = 83.814},
  [28] = {x = -1817.849, y = 2239.306, z = 80.403},
  [29] = {x = -1761.608, y = 2241.771, z = 89.473}, 
  [30] = {x = -1745.346, y = 2250.652, z = 86.856},
  [31] = {x = -1807.442, y = 2248.591, z = 79.088},
  [32] = {x = -1836.033, y = 2252.195, z = 76.927},
  [33] = {x = -1880.779, y = 2258.414, z = 78.019},
  [34] = {x = -1900.216, y = 2263.777, z = 70.919},
  [35] = {x = -1889.505, y = 2268.356, z = 71.867},
  [36] = {x = -1853.196, y = 2264.846, z = 76.905},
  [37] = {x = -1813.917, y = 2257.177, z = 74.399},
  [38] = {x = -1769.743, y = 2259.472, z = 82.837},
  [39] = {x = -1744.057, y = 2257.174, z = 85.001},
  [40] = {x = -1690.780, y = 2195.822, z = 98.001},
  [41] = {x = -1674.352, y = 2182.347, z = 102.300},
  [42] = {x = -1716.553, y = 2169.334, z = 111.536},
  [43] = {x = -1789.014, y = 2170.796, z = 112.413}, 
  [44] = {x = -1819.729, y = 2168.881, z = 108.780},
}

Citizen.CreateThread(function()
    while true do
     Citizen.Wait(5)
     if DecorGetInt(GetPlayerPed(-1), "Job") == 43 then
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1928.722, 2060.512, 140.837, true) < 215) then
          DrawMarker(27, -1928.722, 2060.512, 140.837-0.98, 0,0,0,0,0,0,1.0,1.0,1.0,255,165,0,165,0,0,0,0)
          if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1928.722, 2060.512, 140.837, true) < 1.5) then
           if DoesEntityExist(atvVehicle) then drawTxt('~w~Press ~g~[E]~w~ To End Work') else drawTxt('~w~Press ~g~[E]~w~ To Start Work') end
           if IsControlJustPressed(0, 38) then 
            if DoesEntityExist(atvVehicle) then 
             onJob = false
             DeleteVehicle(atvVehicle)
            else
             newLocs()
             SpawnATV(-1903.995, 2056.484, 140.724, 45.708)
             onJob = true
             grapesDelivered = 0
         end
        end
       end
      end
      if onJob and PackageObject == nil and not grapeReturn then
        DrawMarker(2, grapePos[currentJobID].x,grapePos[currentJobID].y,grapePos[currentJobID].z+2, 0, 0, 0, 0, 0, 0, 0.4, 0.4, 0.4, 255, 255, 0, 150, 0, 0, 2, 0, 0, 0, 0)
       if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), grapePos[currentJobID].x,grapePos[currentJobID].y,grapePos[currentJobID].z, true) < 2.5 and not IsPedInAnyVehicle(GetPlayerPed(-1)) then 
        drawTxt('~w~Press ~g~[E]~w~ To Collect Grapes')
        if IsControlJustPressed(0, 38) then
         LoadModel("prop_cs_cardbox_01")
         local pos = GetEntityCoords(GetPlayerPed(-1), false)
         PackageObject = CreateObject(GetHashKey("prop_cs_cardbox_01"), pos.x, pos.y, pos.z, true, true, true)
         AttachEntityToEntity(PackageObject, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), 0.0, -0.03, 0.0, 5.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
         LoadAnim("anim@heists@box_carry@")
         TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
        end
       end 
      end
      local atvPosition = GetEntityCoords(atvVehicle)
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), atvPosition.x, atvPosition.y, atvPosition.z, true) < 20) and onJob and PackageObject ~= nil and not grapeReturn then
        DrawMarker(2, atvPosition.x, atvPosition.y, atvPosition.z+1.5, 0,0,0,0,0,0,0.5,0.5,0.5,255,165,0,165,0,0,0,0)
       if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), atvPosition.x, atvPosition.y, atvPosition.z, true) < 1.5) then
        drawTxt('~w~Press ~g~[E]~w~ To Store Grapes')
        if IsControlJustPressed(0, 38) then
         DeleteObject(PackageObject)
         ClearPedTasks(GetPlayerPed(-1))
         PackageObject = nil
         RemoveJobBlip()
         grapesDelivered = grapesDelivered + 1
         if grapesDelivered > 6 then
          grapeReturn = true
         else
          newLocs()
         end
        end
       end
      end
      if grapeReturn then
       SetJobBlip(-1909.137, 2056.916, 140.738)
       drawTxt('~w~Return the ATV\nPress ~g~[E]~w~ To Empty Storage')
       DrawMarker(27, -1909.137, 2056.916, 140.738-0.95, 0,0,0,0,0,0,4.0,4.0,4.0,255,165,0,165,0,0,0,0)
       if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1909.137, 2056.916, 140.738, true) < 2.5) then
        if IsControlJustPressed(0, 38) then
         onJob = false
         grapeReturn = false
         DeleteVehicle(atvVehicle)
         grapesDelivered = 0
         -- Add code to give money and add to storage
         local pay = math.random(1250, 1700)
         RemoveJobBlip()
         TriggerServerEvent('jobs:paytheplayer', pay, 'Vineyard: Storage Payment')
         --Notify('You have been paid $'..pay.. ' for completing your rounds.')
        end
       end
      end
     end
    end
   end)


   function SpawnATV(x,y,z,h)
    local vehicleHash = GetHashKey('blazer')
    RequestModel(vehicleHash)
    while not HasModelLoaded(vehicleHash) do
     Citizen.Wait(0)
    end
   
    atvVehicle = CreateVehicle(vehicleHash, x, y, z, h, true, false)
    local id = NetworkGetNetworkIdFromEntity(atvVehicle)
    SetNetworkIdCanMigrate(id, true)
    SetNetworkIdExistsOnAllMachines(id, true)
    SetVehicleDirtLevel(atvVehicle, 0)
    SetVehicleHasBeenOwnedByPlayer(atvVehicle, true)
    SetEntityAsMissionEntity(atvVehicle, true, true)
    SetVehicleEngineOn(atvVehicle, true)
    exports["onyxLocksystem"]:givePlayerKeys(GetVehicleNumberPlateText(atvVehicle))
   end

   function newLocs()
    local jobID = math.random(1, grapePos['Max'])
    SetJobBlip(grapePos[jobID].x,grapePos[jobID].y,grapePos[jobID].z)
    currentJobID = jobID
   end