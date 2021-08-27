local motel_contents = nil
local storage = 50
local itemsTaken = {}

RegisterNetEvent('motel:storage:updateitems')
AddEventHandler('motel:storage:updateitems', function(inv)
    setMotelItems(inv)
end)

RegisterNetEvent("motel:storage:openInventory")
AddEventHandler("motel:storage:openInventory", function(boxid)
    motel_contents = boxid
    print("Motel ID is: "..motel_contents)
    openMotelInventory()
end)

function setMotelItems(data)

    SendNUIMessage(
        {
            action = "setInfoText",
            text = "Motel Storage"
        }
    )

    items = {}
    quantity = 0


    if data ~= nil then
        for key, value in pairs(data) do
            if data[key].q <= 0 then
                data[key] = nil
            else
                quantity = quantity + data[key].q
                data[key].type = "item_standard"
                data[key].usable = false
                data[key].limit = -1
                data[key].canRemove = false
                if data[key].meta == "This Item Contains No Meta Data" then data[key].desc = "" else data[key].desc = data[key].meta end
                itemsTaken[value.item] = 0
                table.insert(items, data[key])
            end
        end
        SendNUIMessage(
            {
                action = "setStorageText",
                text = quantity .."/" .. storage
            }
        )
    end

    SendNUIMessage(
        {
            action = "setSecondInventoryItems",
            itemList = items
        }
    )

end

function openMotelInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "motel"
        }
    )

    SetNuiFocus(true, true)
end

RegisterNUICallback(
    "PutIntoMotel",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if quantity + data.number <= storage then
            if type(data.number) == "number" and math.floor(data.number) == data.number then
            local count = tonumber(data.number)
            if data.item.q >= data.number then
                TriggerServerEvent('motel:storage:additems', motel_contents, data.item.id, data.item.name, data.number, data.item.meta)
                TriggerServerEvent("core:log", tostring("[HOTEL] "..GetPlayerName(PlayerId()).."("..PlayerId()..") put "..data.number.."x "..data.item.name.."("..data.item.id..") into the hotel: "..motel_contents), "item")
                --TriggerServerEvent('motel:storage:additems', motel_contents, data.item.id, data.item.name, data.number, data.item.meta)
            else
                exports['NRP-notify']:DoHudText('inform', 'You do not have enough of that item to put in the storage!')
            end
            end
        else
            exports['NRP-notify']:DoHudText('inform', 'You can only store up to '..storage..' items!')
        end

        Wait(250)
        loadPlayerInventory()

        cb("ok")
    end
)

RegisterNUICallback(
    "TakeFromMotel",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
         if (data.item.q - itemsTaken[data.item.item]) >= data.number then
            itemsTaken[data.item.item] = itemsTaken[data.item.item] + data.number
            TriggerServerEvent('motel:storage:removeitems', motel_contents, data.item.item, data.number, data.item.meta)
            TriggerServerEvent("core:log", tostring("[HOTEL] "..GetPlayerName(PlayerId()).."("..PlayerId()..") took "..data.number.."x "..data.item.name.." from the hotel: "..motel_contents), "item")
         else
            exports['NRP-notify']:DoHudText('inform', 'You can not take out more than what is in the storage!')
         end
        end

        Wait(250)
        loadPlayerInventory()

        cb("ok")
    end
)
