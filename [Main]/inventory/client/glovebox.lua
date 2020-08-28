local gloveData = nil
local glove_inventory = {}
local vehicle_plate = nil
local vehicleType = nil
local totalAmount = 0
local itemsTaken = {}

local maxCapacity = {
    [0] = {["item"] = 20, ["weapons"] = 1}, --Compact
    [1] = {["item"] = 30, ["weapons"] = 2}, --Sedan
    [2] = {["item"] = 50, ["weapons"] = 3}, --SUV
    [3] = {["item"] = 30, ["weapons"] = 2}, --Coupes
    [4] = {["item"] = 25, ["weapons"] = 1}, --Muscle
    [5] = {["item"] = 20, ["weapons"] = 1}, --Sports Classics
    [6] = {["item"] = 20, ["weapons"] = 1}, --Sports
    [7] = {["item"] = 15, ["weapons"] = 1}, --Super
    [8] = {["item"] = 5, ["weapons"] = 1}, --Motorcycles
    [9] = {["item"] = 40, ["weapons"] = 1}, --Off-road
    [10] = {["item"] = 100, ["weapons"] = 8}, --Industrial
    [11] = {["item"] = 25, ["weapons"] = 1}, --Utility
    [12] = {["item"] = 75, ["weapons"] = 4}, --Vans
    [14] = {["item"] = 0, ["weapons"] = 1}, --Boats
    [15] = {["item"] = 0, ["weapons"] = 1}, --Helicopters
    [16] = {["item"] = 0, ["weapons"] = 1}, --Planes
    [17] = {["item"] = 40, ["weapons"] = 1}, --Service
    [18] = {["item"] = 40, ["weapons"] = 2}, --Emergency
    [20] = {["item"] = 100, ["weapons"] = 5}, --Commercial
  }

RegisterNetEvent('glove_inventory:settype')
AddEventHandler('glove_inventory:settype', function(vehtype)
 vehicleType = vehtype
end)

RegisterNetEvent('glove_inventory:updateitems')
AddEventHandler('glove_inventory:updateitems', function(inv, weapons, total)
 setGloveInventoryData(inv)
 glove_inventory = {}
 veh_weapons = {}
 glove_inventory = inv
 veh_weapons = weapons
 totalAmount = total
end)

RegisterNetEvent("glove_inventory:openInventory")
AddEventHandler("glove_inventory:openInventory", function(plate)
    vehicle_plate = plate
    openGloveInventory()
end)

function setGloveInventoryData(data)

    gloveData = data

    SendNUIMessage(
        {
            action = "setInfoText",
            text = "GLOVE BOX"
        }
    )

    SendNUIMessage(
        {
            action = "setStorageText",
            text = totalAmount .."/" .. maxCapacity[vehicleType].item
        }
    )

    items = {}

    if data ~= nil then
        for key, value in pairs(data) do
            if data[key].q <= 0 then
                data[key] = nil
            else
                data[key].type = "item_standard"
                data[key].usable = false
                data[key].limit = -1
                data[key].canRemove = false
                if data[key].meta == "This Item Contains No Meta Data" then data[key].desc = "" else data[key].desc = data[key].meta end
                itemsTaken[value.item] = 0
                table.insert(items, data[key])
            end
        end
    end

    SendNUIMessage(
        {
            action = "setSecondInventoryItems",
            itemList = items
        }
    )

end

function openGloveInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "glove"
        }
    )

    SetNuiFocus(true, true)
end

RegisterNUICallback(
    "PutIntoGlove",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if totalAmount + data.number <= maxCapacity[vehicleType].item then
         if type(data.number) == "number" and math.floor(data.number) == data.number then
         local count = tonumber(data.number)
          print("Attempting to put "..data.number.." of ID: "..data.item.id.." into the glove box: "..vehicle_plate.." with meta data as: "..data.item.meta)
          if data.item.q >= data.number then
            TriggerServerEvent('glove_inventory:additems', vehicle_plate, data.item.id, data.item.name, data.number, data.item.meta)
            TriggerServerEvent("core:log", tostring("[GLOVE] "..GetPlayerName(PlayerId()).."("..PlayerId()..") put "..data.number.."x "..data.item.name.."("..data.item.id..") into the vehicle: "..vehicle_plate), "item")
          else
             exports['NRP-notify']:DoHudText('inform', 'You do not have enough of that item to put in the vehicle!')
          end
         end
        else
            exports['NRP-notify']:DoHudText('inform', 'You can only store up to '..maxCapacity[vehicleType].item..' items!')
        end

        Wait(250)
        SendNUIMessage(
            {
                action = "setStorageText",
                text = totalAmount .."/" .. maxCapacity[vehicleType].item
            }
        )
        loadPlayerInventory()

        cb("ok")
    end
)

RegisterNUICallback(
    "TakeFromGlove",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
         if (data.item.q - itemsTaken[data.item.item]) >= data.number then
            itemsTaken[data.item.item] = itemsTaken[data.item.item] + data.number
            TriggerServerEvent('glove_inventory:removeitems', vehicle_plate, data.item.item, data.number, data.item.meta)
            TriggerServerEvent("core:log", tostring("[GLOVE] "..GetPlayerName(PlayerId()).."("..PlayerId()..") took "..data.number.."x "..data.item.name.." from the glovebox: "..vehicle_plate), "item")
         else
            exports['NRP-notify']:DoHudText('inform', 'You can not take out more than what is in the glovebox!')
         end
        end

        Wait(250)
        SendNUIMessage(
            {
                action = "setStorageText",
                text = totalAmount .."/" .. maxCapacity[vehicleType].item
            }
        )
        loadPlayerInventory()

        cb("ok")
    end
)
