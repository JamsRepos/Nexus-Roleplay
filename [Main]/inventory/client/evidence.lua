local evidence_contents = nil
local itemsTaken = {}

RegisterNetEvent('evidence:updateitems')
AddEventHandler('evidence:updateitems', function(inv)
    setEvidenceItems(inv)
end)

RegisterNetEvent("evidence:openInventory")
AddEventHandler("evidence:openInventory", function(boxid)
    evidence_contents = boxid
    openEvidenceInventory()
end)

function setEvidenceItems(data)

    SendNUIMessage(
        {
            action = "setInfoText",
            text = "LSPD Evidence"
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

function openEvidenceInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "evidence"
        }
    )

    SetNuiFocus(true, true)
end

RegisterNUICallback(
    "PutIntoEvidence",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            local count = tonumber(data.number)
            if data.item.q >= data.number then
                TriggerServerEvent('evidence:additems', data.item.id, data.item.name, data.number, data.item.meta)
            else
                exports['NRP-notify']:DoHudText('inform', 'You do not have enough of that item to put in the box!')
            end
        end

        Wait(250)
        loadPlayerInventory()

        cb("ok")
    end
)

RegisterNUICallback(
    "TakeFromEvidence",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
         if (data.item.q - itemsTaken[data.item.item]) >= data.number then
            itemsTaken[data.item.item] = itemsTaken[data.item.item] + data.number
            TriggerServerEvent('evidence:removeitems', data.item.item, data.item.name, data.number, data.item.meta)
         else
            exports['NRP-notify']:DoHudText('inform', 'You can not take out more than what is in the box!')
         end
        end

        Wait(250)
        loadPlayerInventory()

        cb("ok")
    end
)
