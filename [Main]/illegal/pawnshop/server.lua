local pawnable = {
 [11] = 5, 
 [12] = 5, 
 [8] = 10,
 [6] = 25, 
 [127] = math.random(1000,1300), 
 [128] = math.random(80,160), 
 [129] = math.random(85,150), 
 [67] = math.random(1000,1150), 
 [264] = math.random(50,60),
 [66] = math.random(50,60),
}

RegisterServerEvent('pawnshop:pawn')
AddEventHandler('pawnshop:pawn', function(item, name, qty)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  canGive = user.isAbleToGive(item,qty)
  local pay = pawnable[item] * qty * exports['core']:getVat(4)
  if canGive then
   user.removeQuantity(item,qty)
   user.addMoney(pay)
   TriggerClientEvent('NRP-notify:client:SendAlert', tonumber(source), { type = 'inform', text = name.." Pawned, $"..pay})
   TriggerEvent("core:log", tostring("[PAWN] "..GetPlayerName(source).."("..source..") sold illegal items for $"..pay), "money")
  end
 end)
end)

local recycleable = {
 [81] = math.random(8,11),
 [82] = math.random(6,9),
 [52] = math.random(100,250),
 [53] = math.random(45, 98),
 [54] = math.random(40,125),
 [55] = math.random(50,105),
 [275] = math.random(5,10),
 [264] = math.random(15,25),
 [66] = math.random(15,25),
}

RegisterServerEvent('pawnshop:recycle')
AddEventHandler('pawnshop:recycle', function(item, name, qty)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  canGive = user.isAbleToGive(item,qty)
  local pay = recycleable[item] * qty * exports['core']:getVat(2)
  if canGive then
   user.removeQuantity(item,qty)
   user.addMoney(pay)
   TriggerClientEvent('NRP-notify:client:SendAlert', tonumber(source), { type = 'inform', text = name.." Recycled, $"..pay})
   TriggerEvent("core:log", tostring("[RECYCLE] "..GetPlayerName(source).."("..source..") recycled items for $"..pay), "money")
  end
 end)
end)