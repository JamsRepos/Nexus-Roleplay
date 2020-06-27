local box_id = nil
local storage = 80

RegisterNetEvent('storage_box:updateitems')
AddEventHandler('storage_box:updateitems', function(inv)
    setSBoxItems(inv)
end)

RegisterNetEvent("storage_box:openInventory")
AddEventHandler("storage_box:openInventory", function(boxid)
    box_id = boxid
    openSBoxInventory()
end)

function setSBoxItems(data)

    SendNUIMessage(
        {
            action = "setInfoText",
            text = "SMALL STORAGE BOX"
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

function openSBoxInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "sbox"
        }
    )

    SetNuiFocus(true, true)
end

RegisterNUICallback(
    "PutIntoSBox",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if quantity + data.number <= storage then
            if type(data.number) == "number" and math.floor(data.number) == data.number then
            local count = tonumber(data.number)
            if data.item.q >= data.number then
                TriggerServerEvent('storage_box:additems', box_id, data.item.id, data.item.name, data.number, data.item.meta)
                --TriggerEvent('storage_box:check', box_id, data.item.id, data.item.name, data.number, data.item.meta)
                TriggerServerEvent("core:log", tostring("[SMALL STORAGE BOX] "..GetPlayerName(PlayerId()).."("..PlayerId()..") put "..data.number.."x "..data.item.name.."("..data.item.id..") into the box: "..box_id), "item")
            else
                exports['NRP-notify']:DoHudText('inform', 'You do not have enough of that item to put in the box!')
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
    "TakeFromSBox",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
         if data.item.q >= data.number then
            TriggerServerEvent('storage_box:removeitems', box_id, data.item.item, data.number, data.item.meta)
            TriggerServerEvent("core:log", tostring("[SMALL STORAGE BOX] "..GetPlayerName(PlayerId()).."("..PlayerId()..") took "..data.number.."x "..data.item.name.." from the box: "..box_id), "item")
         else
            exports['NRP-notify']:DoHudText('inform', 'You can not take out more than what is in the box!')
         end
        end

        Wait(250)
        loadPlayerInventory()

        cb("ok")
    end
)
