local house_contents = nil
local itemsTaken = {}

RegisterNetEvent('housing:storage:updateitems')
AddEventHandler('housing:storage:updateitems', function(inv, storage)
    ipl_storage = storage
    setHouseItems(inv, storage)
end)

RegisterNetEvent("housing:storage:openInventory")
AddEventHandler("housing:storage:openInventory", function(boxid, storage)
    house_contents = boxid
    ipl_storage = storage
    openHouseInventory()
end)

RegisterNetEvent('housing:vault:updateitems')
AddEventHandler('housing:vault:updateitems', function(inv, storage)
    ipl_storage = storage
    setVaultItems(inv, storage)
end)

RegisterNetEvent("housing:vault:openInventory")
AddEventHandler("housing:vault:openInventory", function(boxid, storage)
    house_contents = boxid
    ipl_storage = storage
    openVaultInventory()
end)

function setHouseItems(data)

    SendNUIMessage(
        {
            action = "setInfoText",
            text = "House Storage"
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
                itemsTaken[value.item] = 0
                if data[key].meta == "This Item Contains No Meta Data" then data[key].desc = "" else data[key].desc = data[key].meta end
                table.insert(items, data[key])
            end
        end
        SendNUIMessage(
            {
                action = "setStorageText",
                text = quantity .."/" .. ipl_storage
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

function openHouseInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "home"
        }
    )

    SetNuiFocus(true, true)
end

function setVaultItems(data)

    SendNUIMessage(
        {
            action = "setInfoText",
            text = "House Safe"
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
                itemsTaken[value.item] = 0
                if data[key].meta == "This Item Contains No Meta Data" then data[key].desc = "" else data[key].desc = data[key].meta end
                table.insert(items, data[key])
            end
        end
        SendNUIMessage(
            {
                action = "setStorageText",
                text = quantity .."/" .. ipl_storage
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

function openVaultInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "vault"
        }
    )

    SetNuiFocus(true, true)
end


RegisterNUICallback(
    "PutIntoHome",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if quantity + data.number <= ipl_storage then
            if type(data.number) == "number" and math.floor(data.number) == data.number then
            local count = tonumber(data.number)
            if data.item.q >= data.number then
                --TriggerEvent('housing:storage:check', house_contents, data.item.id, data.item.name, data.number)
                TriggerServerEvent('housing:storage:additems', house_contents, data.item.id, data.item.name, data.number, data.item.meta)
                TriggerServerEvent("core:log", tostring("[HOUSE] "..GetPlayerName(PlayerId()).."("..PlayerId()..") put "..data.number.."x "..data.item.name.."("..data.item.id..") into the house: "..house_contents), "item")
            else
                exports['NRP-notify']:DoHudText('inform', 'You do not have enough of that item to put in the storage!')
            end
            end
        else
            exports['NRP-notify']:DoHudText('inform', 'You can only store up to '..ipl_storage..' items!')
        end

        Wait(250)
        loadPlayerInventory()

        cb("ok")
    end
)

RegisterNUICallback(
    "TakeFromHome",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
         if (data.item.q - itemsTaken[data.item.item]) >= data.number then
            itemsTaken[data.item.item] = itemsTaken[data.item.item] + data.number
            TriggerServerEvent('housing:storage:removeitems', house_contents, data.item.item, data.number, data.item.meta)
            TriggerServerEvent("core:log", tostring("[HOUSE] "..GetPlayerName(PlayerId()).."("..PlayerId()..") took "..data.number.."x "..data.item.name.." from the house: "..house_contents), "item")
         else
            exports['NRP-notify']:DoHudText('inform', 'You can not take out more than what is in the storage!')
         end
        end

        Wait(250)
        loadPlayerInventory()

        cb("ok")
    end
)


RegisterNUICallback(
    "PutIntoVault",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end
        print("poggies")
        if quantity + data.number <= ipl_storage then
            if type(data.number) == "number" and math.floor(data.number) == data.number then
            local count = tonumber(data.number)
            if data.item.q >= data.number then
                --TriggerEvent('housing:storage:check', house_contents, data.item.id, data.item.name, data.number)
                TriggerServerEvent('housing:vault:additems', house_contents, data.item.id, data.item.name, data.number, data.item.meta)
                TriggerServerEvent("core:log", tostring("[HOUSE] "..GetPlayerName(PlayerId()).."("..PlayerId()..") put "..data.number.."x "..data.item.name.."("..data.item.id..") into the house: "..house_contents), "item")
            else
                exports['NRP-notify']:DoHudText('inform', 'You do not have enough of that item to put in the storage!')
            end
            end
        else
            exports['NRP-notify']:DoHudText('inform', 'You can only store up to '..ipl_storage..' items!')
        end

        Wait(250)
        loadPlayerInventory()

        cb("ok")
    end
)

RegisterNUICallback(
    "TakeFromVault",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
         if (data.item.q - itemsTaken[data.item.item]) >= data.number then
            itemsTaken[data.item.item] = itemsTaken[data.item.item] + data.number
            TriggerServerEvent('housing:vault:removeitems', house_contents, data.item.item, data.number, data.item.meta)
            TriggerServerEvent("core:log", tostring("[HOUSE] "..GetPlayerName(PlayerId()).."("..PlayerId()..") took "..data.number.."x "..data.item.name.." from the house: "..house_contents), "item")
         else
            exports['NRP-notify']:DoHudText('inform', 'You can not take out more than what is in the storage!')
         end
        end

        Wait(250)
        loadPlayerInventory()

        cb("ok")
    end
)