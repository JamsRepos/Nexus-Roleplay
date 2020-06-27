local office_contents = nil

RegisterNetEvent('office:storage:updateitems')
AddEventHandler('office:storage:updateitems', function(inv)
    setOfficeItems(inv)
end)

RegisterNetEvent("office:storage:openInventory")
AddEventHandler("office:storage:openInventory", function(boxid)
    office_contents = boxid
    openOfficeInventory()
end)

function setOfficeItems(data)

    SendNUIMessage(
        {
            action = "setInfoText",
            text = "OFFICE STORAGE"
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

function openOfficeInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "office"
        }
    )

    SetNuiFocus(true, true)
end

RegisterNUICallback(
    "PutIntoOffice",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
        local count = tonumber(data.number)
         if data.item.q >= data.number then
            TriggerServerEvent('office:storage:additems', office_contents, data.item.id, data.item.name, data.number, data.item.meta)
            TriggerServerEvent("core:log", tostring("[OFFICE] "..GetPlayerName(PlayerId()).."("..PlayerId()..") put "..data.number.."x "..data.item.name.."("..data.item.id..") into the office: "..office_contents), "item")
         else
            exports['NRP-notify']:DoHudText('inform', 'You do not have enough of that item to put in the storage!')
         end
        end

        Wait(250)
        loadPlayerInventory()

        cb("ok")
    end
)

RegisterNUICallback(
    "TakeFromOffice",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
         if data.item.q >= data.number then
            TriggerServerEvent('office:storage:removeitems', office_contents, data.item.item, data.number, data.item.meta)
            TriggerServerEvent("core:log", tostring("[OFFICE] "..GetPlayerName(PlayerId()).."("..PlayerId()..") took "..data.number.."x "..data.item.name.." from the office: "..office_contents), "item")
         else
            exports['NRP-notify']:DoHudText('inform', 'You can not take out more than what is in the storage!')
         end
        end

        Wait(250)
        loadPlayerInventory()

        cb("ok")
    end
)
