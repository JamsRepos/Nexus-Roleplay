local ownedCustoms = {}
local tbl = {
  [1] = {locked = false, player = nil},
  [2] = {locked = false, player = nil},
  [3] = {locked = false, player = nil},
  [4] = {locked = false, player = nil},
  [5] = {locked = false, player = nil},
  [6] = {locked = false, player = nil},
}

RegisterServerEvent('lockGarage2')
AddEventHandler('lockGarage2', function(b,garage)
	tbl[tonumber(garage)].locked = b
	if not b then
		tbl[tonumber(garage)].player = nil
	else
		tbl[tonumber(garage)].player = source
	end
	TriggerClientEvent('lockGarage2',-1,tbl)
end)

RegisterServerEvent('getGarageInfo2')
AddEventHandler('getGarageInfo2', function()
	TriggerClientEvent('lockGarage2',-1,tbl)
end)

AddEventHandler('playerDropped', function()
	for i,g in pairs(tbl) do
		if g.player then
			if source == g.player then
				g.locked = false
				g.player = nil
				TriggerClientEvent('lockGarage2',-1,tbl)
			end
		end
	end
end)

RegisterServerEvent("LSC:buttonSelected2")
AddEventHandler("LSC:buttonSelected2", function(name, button, id)
 TriggerEvent('core:getPlayerFromId', source, function(user)
   if button.price then
    if (tonumber(user.getMoney()) >= tonumber(button.price)) then
	 TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Upgrade/Modification Bought Cost: $".. button.price})
	 TriggerEvent("core:moneylog", source, 'Tunershop Payment: '..button.name..' bought for $'..button.price)
 	   TriggerClientEvent("LSC:buttonSelected2", source,name, button, true) 
	   user.removeMoney(tonumber(button.price))
    elseif (tonumber(user.getBank()) >= tonumber(button.price)) then
	 TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "[BANK] Upgrade/Modification Bought Cost: $".. button.price})
	 TriggerEvent("core:moneylog", source, 'Tunershop Payment: '..button.name..' bought for $'..button.price)
	   TriggerClientEvent("LSC:buttonSelected2", source,name, button, true)
	   user.removeBank(tonumber(button.price))
    else
     TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "You Do Not Have Enough Money To Upgrade/Modify Your Vehicle"})
     TriggerClientEvent("LSC:buttonSelected2", source,name, button, false)
   end
  end
 end)
end)

RegisterServerEvent("LSC:finished2")
AddEventHandler("LSC:finished2", function(plate, data)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  if user.isVehicleOwner(plate) then
   user.updateVehicle(plate, data)
  end
 end)
end)



