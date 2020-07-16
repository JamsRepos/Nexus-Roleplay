local locations = {
    [1] = {name = 'The Court House', enter = {x= 233.206, y= -410.577, z= 47.121}, exit = {x= 235.851, y= -413.782, z= -119.153}},
    [2] = {name = 'The Court Room', enter = {x= 225.179, y= -419.713, z= -119.189}, exit = {x= 238.897, y= -334.212, z= -119.763}},
    [3] = {name = 'The Hallway', enter = {x= 246.305, y= -337.176, z= -119.789}, exit = {x= 248.111, y= -337.610, z= -119.789}},
    [4] = {name = 'The Cellblock', enter = {x= 1669.297, y= 2565.767, z= 44.574}, exit = {x= 1677.712, y= 2518.810, z= -121.839}},
    [5] = {name = 'Cells', enter = {x= 1851.189, y= 3683.385, z= 33.277}, exit = {x= 1849.620, y= 3683.022, z= -119.761}},
    [6] = {name = 'Cells', enter = {x= -442.544, y= 6012.520, z= 30.726}, exit = {x= -441.949, y= 6010.596, z= -119.751}},
    [7] = {name = 'Cells', enter = {x = 1694.450, y = 2518.730, z = -120.850-0.95}, exit = {x = 1696.900, y = 2518.796, z = -120.850-0.95}},
    [8] = {name = 'La Fuente Blanca', enter = {x= 1400.550, y= 1127.208, z= 113.344}, exit = {x= 1400.550, y= 1129.208, z= 113.344}},
    [12] = {name = 'The Office', enter = {x= 412.042, y= -1487.935, z= 29.149}, exit = {x= -1003.085, y= -478.094, z= 50.026}},
    [13] = {name = 'Split-Sides', enter = {x= -419.887, y= 266.354, z= 82.204}, exit = {x= 382.299, y= -1001.551, z= -100.00}},
    [14] = {name = 'The Roof', enter = {x= 246.8483, y= -1372.196, z= 23.60}, exit = {x= 335.038, y= -1432.489, z= 45.560}},
    [17] = {name = 'Clubhouse', enter = {x=-38.421, y=6419.541, z=31.490-0.95}, exit = {x= 1121.042, y= -3152.413, z= -38.062}},
    [18] = {name = 'Vinewood PD', enter = {x= 639.470, y= 1.425, z= 81.836}, exit = {x= 2155.102, y= 2921.036, z= -62.052}},
    [19] = {name = 'The Car Showroom', enter = {x = -803.536, y = -224.350, z = 37.224-0.95}, exit = {x = -1391.832, y = -482.808, z = 78.200-0.95}},
    --[22] = {name = 'The Bike Showroom', enter = {x=267.833, y=-1155.332, z=29.290-0.95}, exit = {x= 997.373, y= -3158.010, z= -39.807}},
    [24] = {name = 'The Bar', enter = {x=132.664, y=-1293.992, z=29.270-0.95}, exit = {x=132.483, y=-1287.010, z=29.273-0.95}},
    [25] = {name = 'The Bar', enter = {x=-1389.558, y=-591.830, z=30.320-0.95}, exit = {x=-1385.460, y=-606.701, z=30.320-0.95}},
    [26] = {name = 'The Bar', enter = {x=-1381.760, y=-632.952, z=30.820-0.95}, exit = {x=-1379.496, y=-630.881, z=30.820-0.95}},
    [27] = {name = 'The Warehouse', enter = {x = 765.966, y = -1895.613, z = 29.277-0.95}, exit = {x = 1048.213, y = -3097.184, z = -39.000}}, -- Darnel's Drug Place
    [28] = {name = 'The Store', enter = {x = 1736.895, y = 6417.975, z = 35.037-0.95}, exit = {x = 1741.606, y = 6419.847, z = 35.042-0.95}},
    [29] = {name = 'The Store', enter = {x = 1994.404, y = 3046.756, z = 47.215-0.95}, exit = {x = 1979.818, y = 3049.278, z = 50.432-0.95}},
    [34] = {name = 'Document Office', enter = {x = 580.938, y = 138.635, z = 99.475-0.95}, exit = {x = 1173.190, y = -3196.613, z = -39.008-0.95}},
    [37] = {name = 'FIB ATC', enter = {x = -1147.750, y = -2825.731, z = 13.964-0.95}, exit = {x = 136.218, y = -761.859, z = 242.152-0.95}}, -- Airport ATC
    --[38] = {name = 'Night Club', enter = {x = -12.754, y = 239.566, z = 109.553-0.95}, exit = {x = -1569.383, y = -3016.768, z = -74.406-0.95}}, ---NightClub
    --[39] = {name = 'The Basement', enter = {x = 1004.257, y = -2997.615, z = -39.647}, exit = {x = 1006.511, y = -2997.713, z = -39.648}}, ---NightClub
    [40] = {name = 'The Firing Range', enter = {x = 459.596, y = -988.909, z = 30.689}, exit = {x = 902.787, y = -3182.665, z = -97.053}},
    [42] = {name = 'Money Wash', enter = {x = -583.089, y = 227.638, z = 79.104-0.95}, exit = {x = 1138.056, y = -3198.634, z = -39.666-0.95}},
    --[41] = {name = 'Garage Storage', enter = {x = 548.637, y = -172.505, z = 54.481-0.95}, exit = {x = 548.680, y = -169.883, z = 46.883-0.95}}, -- RJ Motors
    [43] = {name = 'Warehouse', enter = {x = 985.025, y = -125.260, z = 73.930-0.99}, exit = {x = 968.360, y = -2987.792, z = -39.647-0.99}}, --- Lost Mc
    [44] = {name = 'The Penthouse', enter = {x = 948.161, y = 50.895, z = 75.116-0.95}, exit = {x = 964.594, y = 58.744, z = 112.553-0.95}}, --- Penthouse
   }
   
   local vehicle_locations = {
    [1] = {name = 'The Clubhouse', enter = {x=-39.638, y=6415.091, z=31.490-0.95}, exit = {x= 1109.310, y= -3164.257, z= -38.418}},
    --=[2] = {name = 'The Bike Showroom', enter = {x = 266.563, y = -1159.518, z = 29.252-0.95}, exit = {x=998.758, y = -3164.160, z = -38.907-0.95}},
    [4] = {name = 'The Car Showroom', enter = {x = -781.898, y = -195.472, z = 37.284-0.95}, exit = {x = -1388.633, y = -481.073, z = 78.200-0.95}},
    [6] = {name = 'Diamond HQ', enter = {x = 911.614, y = -1262.704, z = 25.703}, exit = {x = 977.151, y = -1273.869, z = -19.296}}, ----Diamond
    [7] = {name = 'The Warehouse', enter = {x = 982.735, y = -129.920, z = 73.391-0.95}, exit = {x = 971.066, y = -2989.184, z = -39.647-0.95}}, ----Lost MC
    --[8] = {name = 'Night Club', enter = {x = -22.392, y = 215.439, z = 106.564-0.95}, exit = {x = -1640.961, y = -2989.958, z = -77.131-0.95}}, ---NightClub
   }
   
   Citizen.CreateThread(function()
    while true do
     Wait(5)
     for _,v in pairs(locations) do
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.exit.x, v.exit.y, v.exit.z, true) < 20) then
       DrawMarker(27, v.exit.x, v.exit.y, v.exit.z, 0, 0, 0, 0, 0, 0, 0.5,0.5,0.5, 255,255,255,80, 0, 0, 2, 0, 0, 0, 0)
       if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.exit.x, v.exit.y, v.exit.z+0.20, true) < 1.2) then
        drawTxt('~g~[E]~w~ Exit '..v.name)
        if IsControlJustPressed(0, 38) then
         TriggerEvent('sync:insideInterior', false)
         Teleport(v.enter.x, v.enter.y, v.enter.z)
        end
       end
      end
      -- Exit Locations
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.enter.x, v.enter.y, v.enter.z, true) < 20) then
       DrawMarker(27, v.enter.x, v.enter.y, v.enter.z, 0, 0, 0, 0, 0, 0, 0.5,0.5,0.5, 255,255,255,80, 0, 0, 2, 0, 0, 0, 0)
       if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.enter.x, v.enter.y, v.enter.z+0.20, true) < 1.2) then
        drawTxt('~g~[E]~w~ Enter '..v.name)
        if IsControlJustPressed(0, 38) then
         TriggerEvent('sync:insideInterior', true)
         Teleport(v.exit.x, v.exit.y, v.exit.z)
        end
       end
      end
     end
     for _,v in pairs(vehicle_locations) do
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.exit.x, v.exit.y, v.exit.z, true) < 20) and IsPedInAnyVehicle(GetPlayerPed(-1), false) then
       DrawMarker(27, v.exit.x, v.exit.y, v.exit.z, 0, 0, 0, 0, 0, 0, 1.2,1.2,0.5, 200,255,255,120, 0, 0, 2, 0, 0, 0, 0)
       if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.exit.x, v.exit.y, v.exit.z, true) < 1.5) then
        drawTxt('~m~ [~g~E~m~] Exit '..v.name)
        if IsControlJustPressed(0, 38) then
         TriggerEvent('sync:insideInterior', false)
         VehicleTeleport(v.enter.x, v.enter.y, v.enter.z)
        end
       end
      end 
      -- Exit Locations 
      if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.enter.x, v.enter.y, v.enter.z, true) < 20) and IsPedInAnyVehicle(GetPlayerPed(-1), false) then
       DrawMarker(27, v.enter.x, v.enter.y, v.enter.z, 0, 0, 0, 0, 0, 0, 1.2,1.2,0.5, 200,255,255,120, 0, 0, 2, 0, 0, 0, 0)
       if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.enter.x, v.enter.y, v.enter.z, true) < 1.5) then
        drawTxt('~g~[E]~w~ Enter '..v.name)
        if IsControlJustPressed(0, 38) then
         TriggerEvent('sync:insideInterior', true)
         VehicleTeleport(v.exit.x, v.exit.y, v.exit.z)
        end
       end
      end
     end
    end
   end)
   
   function Teleport(x,y,z)
     Wait(100)
     RequestCollisionAtCoord(x,y,z)
     while not HasCollisionLoadedAroundEntity(GetPlayerPed(-1)) do 
       RequestCollisionAtCoord(x,y,z)
       Citizen.Wait(0)
     end
     SetEntityCoords(GetPlayerPed(-1), x,y,z)
   end
   
   function VehicleTeleport(x,y,z)
     Wait(100)
     RequestCollisionAtCoord(x,y,z)
     while not HasCollisionLoadedAroundEntity(GetPlayerPed(-1)) do 
       RequestCollisionAtCoord(x,y,z)
       Citizen.Wait(0)
     end
     local targetPed = GetPlayerPed(-1)
     if(IsPedInAnyVehicle(targetPed))then
       targetPed = GetVehiclePedIsUsing(targetPed)
     end
     SetEntityCoords(targetPed, x,y,z)
   end
   
   function drawTxt(text)
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
     AddTextComponentString(text)
     DrawText(0.5, 0.93)
   end
   
  --[[local Interior = GetInteriorAtCoords(440.84, -983.14, 30.69)
   LoadInterior(Interior)]]-- check what this is
  
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