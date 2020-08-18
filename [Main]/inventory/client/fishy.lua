local Fish = {
    [1] = {name = 'Catfish', price = 80, item = 3},
    [2] = {name = 'Cod', price = 110, item = 4},
    [3] = {name = 'Salmon', price = 160, item = 5}
   }

RegisterNetEvent("inventory:sellFish")
AddEventHandler("inventory:sellFish", function()
    openFishShop()
end)

function openFishShop()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "setInfoText",
            text = "FISH SHOP"
        }
    )

    SendNUIMessage(
        {
            action = "display",
            type = "fish"
        }
    )

    SetNuiFocus(true, true)
end

RegisterNUICallback(
    "SellToFishStore",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end
        if type(data.number) == "number" and math.floor(data.number) == data.number then
        local count = tonumber(data.number)
         if data.item.q >= data.number then
          for k,v in pairs(Fish) do
            if v.item == data.item.id then
             TriggerServerEvent('jobs:sellfish', data.item.id, v.price, data.number, data.item.name)
             TriggerServerEvent("core:moneylog", PlayerId(), 'Fish Sell Payment: '..data.number..'x '..data.item.name..'('..data.item.id..') for $'..v.price)
            end
          end
         else
            exports['NRP-notify']:DoHudText('inform', 'You do not have enough of that item to sell.')
         end
        end

        Wait(250)
        loadPlayerInventory()

        cb("ok")
    end
)