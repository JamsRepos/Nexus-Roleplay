local animals = {
 [1] = {model = "a_c_deer", hash = -664053099,item = "Deer Meat", id = 35, profit = 40},
 [2] = {model = "a_c_pig", hash = -1323586730, item = "Pig Meat", id = 36, profit = 30},
 [2] = {model = "a_c_mtlion", hash = 307287994, item = "Mountain Lion Meat", id = 37, profit = 50},
 [3] = {model = "a_c_cow", hash = -50684386, item = "Cow Meat", id = 38, profit = 40},
 [4] = {model = "a_c_coyote", hash = 1682622302, item = "Coyote Skin", id = 39, profit = 20},
 [5] = {model = "a_c_rabbit_01", hash = -541762431, item = "Rabbit Meat", id = 40, profit = 10},
}


RegisterServerEvent("hunting:sell")
AddEventHandler("hunting:sell", function()
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  for i = 1, #animals do
   if user.getQuantity(animals[i].id) ~= nil and user.getQuantity(animals[i].id) > 0 then
    local pay = math.floor(user.getQuantity(animals[i].id)*animals[i].profit * exports['core']:getVat(3))
    if pay < 200000 then
     user.addMoney(pay)
     TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = animals[i].item.." Sold For $"..pay})
     user.removeQuantity(animals[i].id, user.getQuantity(animals[i].id))
     TriggerEvent("core:moneylog", source, 'Hunting Payment: $'..pay)
    else
     TriggerEvent('anticheat:message', source, pay)
    end
   end
  end
 end)
end) 