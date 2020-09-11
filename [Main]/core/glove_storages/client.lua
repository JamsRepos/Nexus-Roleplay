local glove_inventory = {}
local glove_weapons = {}
local vehicle_plate = nil
local maxCapacity = {
  [0] = {["item"] = 3, ["weapons"] = 1}, --Compact
  [1] = {["item"] = 5, ["weapons"] = 2}, --Sedan
  [2] = {["item"] = 7, ["weapons"] = 3}, --SUV 
  [3] = {["item"] = 5, ["weapons"] = 2}, --Coupes
  [4] = {["item"] = 5, ["weapons"] = 1}, --Muscle
  [5] = {["item"] = 5, ["weapons"] = 1}, --Sports Classics
  [6] = {["item"] = 5, ["weapons"] = 1}, --Sports
  [7] = {["item"] = 3, ["weapons"] = 1}, --Super
  [8] = {["item"] = 2, ["weapons"] = 1}, --Motorcycles
  [9] = {["item"] = 7, ["weapons"] = 1}, --Off-road
  [10] = {["item"] = 10, ["weapons"] = 8}, --Industrial
  [11] = {["item"] = 10, ["weapons"] = 1}, --Utility
  [12] = {["item"] = 10, ["weapons"] = 4}, --Vans
  [14] = {["item"] = 0, ["weapons"] = 1}, --Boats
  [15] = {["item"] = 0, ["weapons"] = 1}, --Helicopters
  [16] = {["item"] = 0, ["weapons"] = 1}, --Planes
  [17] = {["item"] = 10, ["weapons"] = 1}, --Service
  [18] = {["item"] = 10, ["weapons"] = 2}, --Emergency
  [20] = {["item"] = 10, ["weapons"] = 5}, --Commercial
}

local fastResponse = {
  [1] = {id = "FBI"},
  [2] = {id = "SSPRES"},
  [3] = {id = "ONEBEAST"},
  [4] = {id = "POLICE2"},
  [5] = {id = "FBI2"},
  [6] = {id = "SUBURBAN '0"},
  [7] = {id = "POLICE"},
  [8] = {id = "POLICE3"},
  [9] = {id = "POLICE4"},
  [10] = {id = "RIOT"},
  [11] = {id = "RIOT2"},
  [12] = {id = "2015polstang"},
  [13] = {id = "POLICE"},
}

RegisterNetEvent('glove_inventory:updateitems')
AddEventHandler('glove_inventory:updateitems', function(inv, weapons)
 glove_inventory = {}
 glove_weapons = {}
 glove_inventory = inv
 glove_weapons = weapons
end)

-- Only thing that needs to be written now is the opening glove box logic and refreshing the inventory if multiple people have it open and take an item.

Citizen.CreateThread(function()
  while true do
    Wait(0)
    if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
      if GetPlayerPed(-1) == GetPedInVehicleSeat(veh, -1) or GetPlayerPed(-1) == GetPedInVehicleSeat(veh, 0) then 
        if IsControlJustPressed(0, 170) then
          local veh = GetVehiclePedIsUsing(GetPlayerPed(-1))
          print(GetVehicleNumberPlateText(veh))
          print(GetVehicleClass(veh))
          for k,v in pairs(fastResponse) do
            vehicle_plate = GetVehicleNumberPlateText(veh)
            TriggerServerEvent("glove_inventory:getInventory", GetVehicleNumberPlateText(veh))
            TriggerEvent('glove_inventory:settype', GetVehicleClass(veh))
          end 
        end
      end
    end
  end
end)