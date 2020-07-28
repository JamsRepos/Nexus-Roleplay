local Turtle = {
    [4] = {name = 'Turtle', price = 1250, item = 292},
   }

RegisterNetEvent("inventory:sellTurtle")
AddEventHandler("inventory:sellTurtle", function()
    openTurtleShop()
end)

function openTurtleShop()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "setInfoText",
            text = "CHINESE RESTAURANT"
        }
    )

    SendNUIMessage(
        {
            action = "display",
            type = "turtle"
        }
    )

    SetNuiFocus(true, true)
end

RegisterNUICallback(
    "SellToTurtleStore",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end
        if type(data.number) == "number" and math.floor(data.number) == data.number then
        local count = tonumber(data.number)
         if data.item.q >= data.number then
          for k,v in pairs(Turtle) do
            if v.item == data.item.id then
             TriggerServerEvent('jobs:sellturtle', data.item.id, v.price, data.number, data.item.name)
             TriggerServerEvent("core:moneylog", PlayerId(), 'Turtle Sell Payment: '..data.number..'x '..data.item.name..'('..data.item.id..') for $'..v.price)
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