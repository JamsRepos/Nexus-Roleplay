local medical_contents = nil
local itemsTaken = {}

RegisterNetEvent('medical:updateitems')
AddEventHandler('medical:updateitems', function(inv)
    setMedicalItems(inv)
end)

RegisterNetEvent("medical:openInventory")
AddEventHandler("medical:openInventory", function(boxid)
    medical_contents = boxid
    openMedicalInventory()
end)

function setMedicalItems(data)

    SendNUIMessage(
        {
            action = "setInfoText",
            text = "Medical Cabinet"
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

function openMedicalInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "medical"
        }
    )

    SetNuiFocus(true, true)
end

RegisterNUICallback(
    "PutIntoMedical",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            local count = tonumber(data.number)
            exports['NRP-notify']:DoHudText('error', 'You cannot place items into the medical cabinet!')
        end

        Wait(250)
        loadPlayerInventory()

        cb("ok")
    end
)

RegisterNUICallback(
    "TakeFromMedical",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
         if (data.item.q - itemsTaken[data.item.item]) >= data.number then
            itemsTaken[data.item.item] = itemsTaken[data.item.item] + data.number
            TriggerServerEvent('medical:removeitems', data.item.item, data.item.name, data.number, data.item.meta)
         else
            exports['NRP-notify']:DoHudText('inform', 'You can not take out more than what is in the box!')
         end
        end

        Wait(250)
        loadPlayerInventory()

        cb("ok")
    end
)
