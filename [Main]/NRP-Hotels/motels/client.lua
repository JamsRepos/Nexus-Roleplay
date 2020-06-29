local rentedHotels = {}
currentHotel = {}
local instance = {}
local managementID = 0
inHotel = false
local myCharacterID = 0
local hotelManagers = {
 --[1] = {x = 1141.888, y = 2663.858, z = 38.161, name = "Route 68B", id=1},
 [2] = {x = 321.258, y = -197.288, z = 54.226, name = "Hawick Ave", id=2},
 [3] = {x = 570.283, y = -1746.707, z = 29.217, name = "Billings Gate", id=3},
 [4] = {x = -125.613, y = -1473.250, z = 33.823, name = "Carson Ave", id=4},
 [5] = {x = 317.512, y = 2623.453, z = 44.466, name = "Route 68", id=5},
 --[6] = {x = 451.610, y = -1569.751, z = 29.283, name = "Crusade Rd", id=6},
 [1] = {x = -96.456, y = 6324.320, z = 31.576, name = "DreamView", id=1},
}

local dailyPrice = 1000

local hotelDoors = {
 [1] = {x = 312.868, y = -218.617, z = 54.226, address = "1 Hawick Ave", manager = 2}, 
 [2] = {x = 310.957, y = -217.917, z = 54.226, address = "2 Hawick Ave", manager = 2}, 
 [3] = {x = 307.326, y = -216.515, z = 54.226, address = "3 Hawick Ave", manager = 2},
 [4] = {x = 307.686, y = -213.429, z = 54.226, address = "4 Hawick Ave", manager = 2},
 [5] = {x = 313.659, y = -198.251, z = 54.226, address = "6 Hawick Ave", manager = 2},
 [6] = {x = 311.532, y = -203.454, z = 54.226, address = "5A Hawick Ave", manager = 2},
 [7] = {x = 309.784, y = -208.084, z = 54.226, address = "5B Hawick Ave", manager = 2},
 [9] = {x = 319.185, y = -196.463, z = 54.226, address = "8 Hawick Ave", manager = 2},
 [10] = {x = 315.682, y = -195.126, z = 54.226, address = "7 Hawick Ave", manager = 2}, 
 [11] = {x = 312.868, y = -218.617, z = 58.016, address = "11 Hawick Ave", manager = 2},    
 [12] = {x = 310.957, y = -217.917, z = 58.016, address = "12 Hawick Ave", manager = 2},     
 [13] = {x = 307.326, y = -216.515, z = 58.016, address = "13 Hawick Ave", manager = 2},    
 [14] = {x = 307.686, y = -213.429, z = 58.016, address = "14 Hawick Ave", manager = 2},     
 [15] = {x = 313.659, y = -198.251, z = 58.016, address = "15 Hawick Ave", manager = 2},     
 [16] = {x = 311.532, y = -203.454, z = 58.016, address = "16 Hawick Ave", manager = 2},     
 [17] = {x = 309.784, y = -208.084, z = 58.016, address = "17 Hawick Ave", manager = 2},     
 [18] = {x = 321.258, y = -197.288, z = 58.016, address = "18 Hawick Ave", manager = 2},     
 [19] = {x = 319.185, y = -196.463, z = 58.016, address = "19 Hawick Ave", manager = 2},    
 [20] = {x = 315.682, y = -195.126, z = 58.016, address = "20 Hawick Ave", manager = 2},      
 [21] = {x = 346.500, y = -199.653, z = 54.222, address = "29 Hawick Ave", manager = 2},   
 [22] = {x = 344.355, y = -204.913, z = 54.222, address = "28 Hawick Ave", manager = 2},   
 [23] = {x = 342.606, y = -209.471, z = 54.222, address = "27 Hawick Ave", manager = 2},   
 [24] = {x = 340.507, y = -214.799, z = 54.222, address = "26 Hawick Ave", manager = 2},   
 [25] = {x = 338.813, y = -219.178, z = 54.222, address = "25 Hawick Ave", manager = 2},   
 [26] = {x = 336.789, y = -224.431, z = 54.222, address = "24 Hawick Ave", manager = 2},  
 [27] = {x = 335.081, y = -227.139, z = 54.222, address = "23 Hawick Ave", manager = 2},   
 [28] = {x = 331.492, y = -225.645, z = 54.222, address = "22 Hawick Ave", manager = 2},  
 [29] = {x = 329.413, y = -224.925, z = 54.222, address = "21 Hawick Ave", manager = 2},  
 [30] = {x = 346.500, y = -199.653, z = 58.016, address = "39 Hawick Ave", manager = 2}, 
 [31] = {x = 344.355, y = -204.913, z = 58.016, address = "37 Hawick Ave", manager = 2}, 
 [32] = {x = 342.606, y = -209.471, z = 58.016, address = "36 Hawick Ave", manager = 2}, 
 [33] = {x = 340.507, y = -214.799, z = 58.016, address = "35 Hawick Ave", manager = 2}, 
 [34] = {x = 338.813, y = -219.178, z = 58.016, address = "34 Hawick Ave", manager = 2},
 [35] = {x = 336.789, y = -224.431, z = 58.016, address = "33 Hawick Ave", manager = 2}, 
 [36] = {x = 335.081, y = -227.139, z = 58.016, address = "32 Hawick Ave", manager = 2}, 
 [37] = {x = 331.492, y = -225.645, z = 58.016, address = "31 Hawick Ave", manager = 2}, 
 [38] = {x = 329.413, y = -224.925, z = 58.016, address = "30 Hawick Ave", manager = 2},   
 --[[[39] = {x = 1141.993, y = 2654.655, z = 38.151, address = "1 Route 68", manager = 1},
 [40] = {x = 1142.017, y = 2651.135, z = 38.141, address = "2 Route 68", manager = 1},
 [41] = {x = 1142.255, y = 2643.553, z = 38.144, address = "3 Route 68", manager = 1},
 [42] = {x = 1141.214, y = 2641.919, z = 38.144, address = "4 Route 68", manager = 1},
 [43] = {x = 1136.436, y = 2641.826, z = 38.144, address = "5 Route 68", manager = 1},
 [44] = {x = 1132.869, y = 2641.964, z = 38.144, address = "6 Route 68", manager = 1},
 [45] = {x = 1125.357, y = 2641.900, z = 38.144, address = "7 Route 68", manager = 1},
 [46] = {x = 1121.528, y = 2642.184, z = 38.144, address = "8 Route 68", manager = 1},
 [47] = {x = 1114.792, y = 2641.975, z = 38.144, address = "9 Route 68", manager = 1},
 [48] = {x = 1107.176, y = 2641.800, z = 38.144, address = "10 Route 68", manager = 1},
 [49] = {x = 1106.326, y = 2648.998, z = 38.141, address = "11 Route 68", manager = 1},
 [50] = {x = 1106.342, y = 2652.815, z = 38.141, address = "12 Route 68", manager = 1},]]
 [51] = {x = 559.222, y = -1777.253, z = 33.443, address = "8 Billings Gate", manager = 3},
 [52] = {x = 550.173, y = -1770.630, z = 33.443, address = "10 Billings Gate", manager = 3},
 [53] = {x = 552.591, y = -1765.328, z = 33.443, address = "11 Billings Gate", manager = 3},
 [54] = {x = 555.686, y = -1758.671, z = 33.443, address = "12 Billings Gate", manager = 3},
 [55] = {x = 559.256, y = -1750.974, z = 33.443, address = "14 Billings Gate", manager = 3},
 [56] = {x = 561.745, y = -1747.380, z = 33.443, address = "15 Billings Gate", manager = 3},
 [57] = {x = 550.513, y = -1775.528, z = 29.312, address = "2 Billings Gate", manager = 3},
 [58] = {x = 552.525, y = -1771.597, z = 29.312, address = "3 Billings Gate", manager = 3},
 [59] = {x = 554.801, y = -1766.377, z = 29.312, address = "4 Billings Gate", manager = 3},
 [60] = {x = 557.975, y = -1759.826, z = 29.314, address = "5 Billings Gate", manager = 3},
 [61] = {x = 561.715, y = -1751.941, z = 29.280, address = "6 Billings Gate", manager = 3},
 [62] = {x = 566.254, y = -1778.202, z = 29.353, address = "1 Billings Gate", manager = 3},
 [63] = {x = -113.477, y = -1467.900, z = 33.823, address = "1 Carson Ave", manager = 4},
 [64] = {x = -107.880, y = -1473.310, z = 33.823, address = "2 Carson Ave", manager = 4},
 [65] = {x = -112.869, y = -1479.087, z = 33.823, address = "3 Carson Ave", manager = 4},
 [66] = {x = -119.158, y = -1486.442, z = 36.982, address = "4 Carson Ave", manager = 4},
 [67] = {x = -112.654, y = -1479.398, z = 36.992, address = "5 Carson Ave", manager = 4},
 [68] = {x = -107.549, y = -1473.317, z = 36.992, address = "6 Carson Ave", manager = 4},
 [69] = {x = -113.431, y = -1467.712, z = 36.992, address = "7 Carson Ave", manager = 4},
 [70] = {x = -122.810, y = -1459.880, z = 36.992, address = "8 Carson Ave", manager = 4},
 [71] = {x = -127.500, y = -1456.802, z = 37.792, address = "9 Carson Ave", manager = 4},
 [72] = {x = -132.317, y = -1462.731, z = 36.992, address = "10 Carson Ave", manager = 4},
 [73] = {x = -138.218, y = -1470.899, z = 36.992, address = "11 Carson Ave", manager = 4},
 [74] = {x = -126.064, y = -1473.588, z = 36.992, address = "12 Carson Ave", manager = 4},
 [75] = {x = -120.116, y = -1478.493, z = 36.992, address = "13 Carson Ave", manager = 4},
 [76] = {x = -120.014, y = -1478.434, z = 33.823, address = "14 Carson Ave", manager = 4},
 [77] = {x = -132.412, y = -1462.835, z = 33.823, address = "15 Carson Ave", manager = 4},
 [78] = {x = -126.547, y = -1456.609, z = 34.614, address = "16 Carson Ave", manager = 4},
 [79] = {x = -122.851, y = -1459.897, z = 33.823, address = "17 Carson Ave", manager = 4},
 [80] = {x = 341.193, y = 2615.812, z = 44.663, address = "1 Route 68", manager = 5},
 [81] = {x = 346.644, y = 2618.851, z = 44.687, address = "2 Route 68", manager = 5},
 [82] = {x = 353.893, y = 2620.557, z = 44.662, address = "3 Route 68", manager = 5},
 [83] = {x = 359.297, y = 2623.660, z = 44.688, address = "4 Route 68", manager = 5},
 [84] = {x = 366.575, y = 2625.420, z = 44.662, address = "5 Route 68", manager = 5},
 [85] = {x = 371.984, y = 2628.338, z = 44.687, address = "6 Route 68", manager = 5},
 [86] = {x = 379.358, y = 2630.092, z = 44.664, address = "7 Route 68", manager = 5},
 [87] = {x = 384.673, y = 2633.190, z = 44.688, address = "8 Route 68", manager = 5},
 [88] = {x = 391.965, y = 2634.949, z = 44.662, address = "9 Route 68", manager = 5},
 [89] = {x = 397.448, y = 2637.926, z = 44.687, address = "10 Route 68", manager = 5},
--[[90] = {x = 467.070, y = -1590.152, z = 31.792, address = "1 Crusade Rd", manager = 6},
 [91] = {x = 461.131, y = -1585.009, z = 31.792}, address = "2 Crusade Rd", manager = 6},
 [92] = {x = 455.120, y = -1579.860, z = 31.792}, address = "3 Crusade Rd", manager = 6},
 [93] = {x = 442.267, y = -1569.263, z = 31.792}, address = "4 Crusade Rd", manager = 6},
 [94] = {x = 436.336, y = -1564.214, z = 31.792}, address = "5 Crusade Rd", manager = 6},
 [95] = {x = 430.478, y = -1559.090, z = 31.792}, address = "6 Crusade Rd", manager = 6},
 [96] = {x = 460.857, y = -1573.637, z = 31.792}, address = "8 Crusade Rd", manager = 6},
 [97] = {x = 466.090, y = -1567.545, z = 31.792}, address = "9 Crusade Rd", manager = 6},
 [98] = {x = 471.305, y = -1561.392, z = 31.792}, address = "10 Crusade Rd", manager = 6},
 [99] = {x = 340.293, y = -1396.163, z = 31.509}, address = "11 Crusade Rd", manager = 6},]]
 [39] = {x = -111.088, y = 6322.704, z = 31.575, address = "1 DreamView", manager = 1},
 [40] = {x = -114.433, y = 6326.048, z = 31.576, address = "2 DreamView", manager = 1},
 [41] = {x = -120.271, y = 6327.089, z = 31.575, address = "3 DreamView", manager = 1},
 [42] = {x = -111.141, y = 6322.757, z = 35.501, address = "4 DreamView", manager = 1},
 [43] = {x = -114.401, y = 6326.051, z = 35.501, address = "5 DreamView", manager = 1},
 [44] = {x = -120.162, y = 6327.201, z = 35.501, address = "6 DreamView", manager = 1},
 [45] = {x = -103.400, y = 6330.859, z = 31.576, address = "7 DreamView", manager = 1},
 [46] = {x = -106.669, y = 6334.104, z = 31.576, address = "8 DreamView", manager = 1},
 [47] = {x = -107.601, y = 6339.826, z = 31.576, address = "9 DreamView", manager = 1},
 [48] = {x = -98.605, y = 6348.291, z = 31.576, address = "11 DreamView", manager = 1},
 [49] = {x = -93.639, y = 6353.709, z = 31.576, address = "12 DreamView", manager = 1},
 [50] = {x = -90.202, y = 6357.153, z = 31.576, address = "13 DreamView", manager = 1},
 [90] = {x = -84.843, y = 6362.640, z = 31.576, address = "14 DreamView", manager = 1},
 [91] = {x = -103.291, y = 6330.567, z = 35.501, address = "15 DreamView", manager = 1},
 [92] = {x = -107.634, y = 6339.722, z = 35.501, address = "16 DreamView", manager = 1},
 [93] = {x = -102.029, y = 6345.325, z = 35.501, address = "17 DreamView", manager = 1},
 [94] = {x = -93.430, y = 6353.675, z = 35.501, address = "18 DreamView", manager = 1},
 [95] = {x = -90.162, y = 6357.194, z = 35.501, address = "19 DreamView", manager = 1},
 [96] = {x = -84.831, y = 6362.468, z = 35.501, address = "20 DreamView", manager = 1},
}

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
  --local factor = (string.len(text)) / 370
  
end

local Objects = {
  { ["x"] = 150.747, ["y"] = -1005.814, ["z"] = -99.00, ["h"] = 270.0, ["model"] = "prop_bin_10a" }
}

Citizen.CreateThread(function()
  for i = 1, #Objects, 1 do
      while not HasModelLoaded(GetHashKey(Objects[i]["model"])) do
          RequestModel(GetHashKey(Objects[i]["model"]))

          Citizen.Wait(5)
      end

      Objects[i]["objectId"] = CreateObject(GetHashKey(Objects[i]["model"]), Objects[i]["x"], Objects[i]["y"], Objects[i]["z"], false)

      PlaceObjectOnGroundProperly(Objects[i]["objectId"])
      SetEntityHeading(Objects[i]["objectId"], Objects[i]["h"])
      FreezeEntityPosition(Objects[i]["objectId"], true)
      SetEntityAsMissionEntity(Objects[i]["objectId"], true, true)
  end
end)


Citizen.CreateThread(function()
 local currentItemIndex = 1
 local days = 1 
 local currentItemIndex2 = 1
 local days2 = 1 
 WarMenu.CreateLongMenu('hotel_rent', "Hotel")
 WarMenu.CreateLongMenu('hotel_management', "Hotel")
 WarMenu.CreateLongMenu('hotel_listings', "Management")
 while true do
  local coords = GetEntityCoords(GetPlayerPed(-1))
  Citizen.Wait(5)
  if not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
   for id,v in pairs(hotelDoors) do
    if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 45.0) then
     if rentedHotels[id] then
       if rentedHotels[id].char_id == myCharacterID then
        DrawMarker(2, v.x, v.y, v.z, 0,0,0,0,0,0,0.3,0.3,0.3, 255, 255, 0,0.2,0,0,0,0)
       end
      if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 0.8) then
       if rentedHotels[id].char_id == myCharacterID then
        DrawText3Ds(v.x, v.y, v.z,'~g~[E]~w~ Enter Hotel Room ')
        if IsControlJustPressed(0, 38) then
         currentHotel = {pos = v, id = id, days = rentedHotels[id].days_left}
         TriggerServerEvent("hotel:createInstance", currentHotel)
         TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 5.0, 'door', 0.5)
        end
       elseif DecorGetBool(GetPlayerPed(-1), "Faction") == 12 then 
        drawTxt('~m~Press ~g~E~m~ To Force Entry To Hotel Room')
        if IsControlJustPressed(0, 38) then
        currentHotel = {pos = v, id = id, days = rentedHotels[id].days_left}
        TriggerServerEvent("hotel:createInstance", currentHotel)
       end
       elseif exports['core']:GetItemQuantity(21) >= 1 and not rentedHotels[id].char_id == myCharacterID then
        drawTxt('~m~Press ~g~F2~m~ To Lock Pick Door')
        if IsControlJustPressed(0, 288) then
         TriggerEvent("inventory:removeQty", 21, 1)
         API_ProgressBar('Picking Lock', 6000)
         Wait(6000)
         if math.random(1, 100) >= 90 then
          currentHotel = {pos = v, id = id, days = rentedHotels[id].days_left}
          TriggerServerEvent("hotel:createInstance", currentHotel)
          exports['NRP-notify']:DoHudText('inform', 'You have successfully broken into the motel room!')
         end
         else
          exports['NRP-notify']:DoHudText('inform', 'You do not know how to break this lock.')
         end
       else
        DrawText3Ds(v.x, v.y, v.z,'~w~Address: ~g~'..rentedHotels[id].address..'\n~w~Status: ~r~Currently Occupied')
       end
      end
     else
      if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2) then
        DrawText3Ds(v.x, v.y, v.z,'~w~Address: ~g~'..v.address..'\n~g~[E]~w~ Rent This Hotel Room ')
       if IsControlJustPressed(0, 38) then 
        currentHotel = {pos = pos, id = id, address = v.address, management = v.manager}
        WarMenu.OpenMenu('hotel_rent')
       end
      end
     end
    end 
   end
  end
  if WarMenu.IsMenuOpened('hotel_rent') then
   if WarMenu.ComboBox('Days To Rent', {1,2,3,4,5,6,7}, currentItemIndex, days, function(currentIndex)
     currentItemIndex = currentIndex 
     days = currentIndex
    end) then
   elseif WarMenu.Button('Rent '..days.." Days", '~g~$'..math.floor(dailyPrice*exports['core']:getVat(22)*days)) then
    TriggerServerEvent('hotel:rentRoom', currentHotel.id, hotelDoors[currentHotel.id].address, days, math.floor(dailyPrice*exports['core']:getVat(22)*days), currentHotel.management)
    WarMenu.CloseMenu()
   end
   WarMenu.Display()
  elseif WarMenu.IsMenuOpened('hotel_management') then
   if WarMenu.Button('Address:', '~g~'..hotelDoors[hotelManaged.id].address) then 
   elseif WarMenu.ComboBox('Add Extra Days', {1,2,3,4,5,6,7}, currentItemIndex2, days2, function(currentIndex2)
      currentItemIndex2 = currentIndex2
      days2 = currentIndex2
     end) then
   elseif WarMenu.Button('Rent '..days2.." Days", '~g~$'..math.floor(dailyPrice*days2)) then
    TriggerServerEvent('hotel:addExtraDays', hotelManaged.id, days2, math.floor(dailyPrice*days2))
    print("Adding Days: " .. days2)
    WarMenu.CloseMenu()
   elseif WarMenu.Button('Days Remaining', hotelManaged.days) then
   elseif WarMenu.Button('Unrent Motel') then
    TriggerServerEvent('hotel:unrentHotel', hotelManaged.id)
    WarMenu.CloseMenu()
   end
   WarMenu.Display()
  elseif WarMenu.IsMenuOpened('hotel_listings') then
    for id,v in pairs(rentedHotels) do
    if v.char_id == myCharacterID and managementID == v.management_id then
      if WarMenu.Button('Address:', '~g~'..v.address) then 
       hotelManaged = {id = id, days = v.days_left}
       WarMenu.OpenMenu('hotel_management')
      end
   end
  end
  WarMenu.Display()
  end
  if(GetDistanceBetweenCoords(coords, 151.428, -1007.758, -99.00, true) < 1.0 and inHotel) then 
   DrawText3Ds(151.428, -1007.758, -99.00, "~g~[E]~w~ Leave Motel")
   if (IsControlJustReleased(1, 38)) then
    RequestCollisionAtCoord(currentHotel.pos.x, currentHotel.pos.y, currentHotel.pos.z)
    while not HasCollisionLoadedAroundEntity(GetPlayerPed(-1)) do
     RequestCollisionAtCoord(currentHotel.pos.x, currentHotel.pos.y, currentHotel.pos.z)
     Wait(0)
    end
    DoScreenFadeOut(500)
    Wait(500)
    SetEntityCoords(GetPlayerPed(-1), currentHotel.pos.x, currentHotel.pos.y, currentHotel.pos.z)
    Citizen.InvokeNative(0xE036A705F989E049)
    instance.houseid = 0

    TriggerServerEvent("hotel:removeFromInstance", currentHotel)
    inHotel = false
    Wait(1250)
    DoScreenFadeIn(500)
    TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 5.0, 'door', 0.5)
   end
  end
  if not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
    for id,v in pairs(hotelManagers) do
     if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 15.0) then
      DrawMarker(27,v.x, v.y, v.z-0.95, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 255, 255, 0, 100, 0, 0, 2, 0, 0, 0, 0)
       if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.2) then
         drawTxt('~m~Press ~g~E~m~ To Access Hotel Management')
         if IsControlJustPressed(0, 38) then
          managementID = v.id
          Wait(10)
          print(managementID)
          WarMenu.OpenMenu('hotel_listings')
         end
       end
     end
    end 
  end

 end
end)

RegisterNetEvent('hotels:update')
AddEventHandler('hotels:update', function(hotels, id)
 rentedHotels = hotels 
 myCharacterID = id
 print(rentedHotels)
end)

RegisterNetEvent("hotel:sendToInstance")
AddEventHandler("hotel:sendToInstance", function(inst, hotel)
  instance = inst 
  currentHotel = hotel
  inHotel = true
  NetworkSetVoiceChannel(instance.vchan)
  RequestCollisionAtCoord(151.428, -1007.758, -99.000)
  while not HasCollisionLoadedAroundEntity(GetPlayerPed(-1)) do
    RequestCollisionAtCoord(151.428, -1007.758, -99.000)
    Wait(0)
  end
  DoScreenFadeOut(500)
  Wait(500)
  SetEntityCoords(GetPlayerPed(-1), 151.428, -1007.758, -99.000)
  Wait(1250)
  DoScreenFadeIn(500)
end)

RegisterNetEvent("hotel:updateInstanceMembers")
AddEventHandler("hotel:updateInstanceMembers", function(inst)
  instance = inst
end)

Citizen.CreateThread(function()
  while true do
   local playerPed = GetPlayerPed(-1)
   Citizen.Wait(1)
   if (instance and instance.hotelid and instance.hotelid > 0) and inHotel then
    DisablePlayerFiring(GetPlayerPed(-1), true)
    DisableControlAction(0, 21)
    if instance.hotelid then
      for i=0, 255, 1 do
          local otherPlayerPed = GetPlayerPed(i)
          if otherPlayerPed ~= GetPlayerPed(-1) then
           SetEntityLocallyInvisible(otherPlayerPed)
           SetEntityNoCollisionEntity(playerPed, otherPlayerPed, true)
          end
      end
    else
      for i=0, 255, 1 do
          local otherPlayerPed = GetPlayerPed(i)
          if otherPlayerPed ~= GetPlayerPed(-1) then
            SetEntityLocallyInvisible(otherPlayerPed)
            SetEntityNoCollisionEntity(playerPed, otherPlayerPed, true)
          end
      end
    end
   else
   end
  end
end)

function GetPlayersInArea()
  local peds
  local pedids = {}
  
  peds = GetPedNearbyPeds(GetPlayerPed(-1), -1)
  
  for id = 0, 255 do
    local ped = GetPlayerPed(-1)
    local rped = GetPlayerPed(id)
    
    if (NetworkIsPlayerActive(id) and rped ~= ped) then
      local pos = GetEntityCoords(ped)
      local rpos = GetEntityCoords(rped)
      local dist = Vdist(pos.x, pos.y, pos.z, rpos.x, rpos.y, rpos.z)
      
      if (dist < 5) then
        table.insert(pedids, GetPlayerServerId(id))
      end
    end
  end
  table.insert(pedids, GetPlayerServerId(PlayerId()))
  return pedids
end
