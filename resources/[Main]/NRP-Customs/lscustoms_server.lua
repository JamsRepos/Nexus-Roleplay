local ownedCustoms = {}
local tbl = {
  [1] = {locked = false, player = nil},
  [2] = {locked = false, player = nil},
  [3] = {locked = false, player = nil},
  [4] = {locked = false, player = nil},
  [5] = {locked = false, player = nil},
  [6] = {locked = false, player = nil},
}

RegisterServerEvent('lockGarage')
AddEventHandler('lockGarage', function(b,garage)
	tbl[tonumber(garage)].locked = b
	if not b then
		tbl[tonumber(garage)].player = nil
	else
		tbl[tonumber(garage)].player = source
	end
	TriggerClientEvent('lockGarage',-1,tbl)
end)

RegisterServerEvent('getGarageInfo')
AddEventHandler('getGarageInfo', function()
	TriggerClientEvent('lockGarage',-1,tbl)
end)

AddEventHandler('playerDropped', function()
	for i,g in pairs(tbl) do
		if g.player then
			if source == g.player then
				g.locked = false
				g.player = nil
				TriggerClientEvent('lockGarage',-1,tbl)
			end
		end
	end
end)

RegisterServerEvent("LSC:buttonSelected")
AddEventHandler("LSC:buttonSelected", function(name, button, id)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  if ownedCustoms[id] then 
   if button.price then
   	local price = math.floor(button.price)
    if (tonumber(user.getMoney()) >= tonumber(price)) then
     TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Upgrade/Modification Bought Cost: $"..price})
     TriggerClientEvent("LSC:buttonSelected", source,name, button, true) 
     user.removeMoney(tonumber(price))
     exports['GHMattiMySQL']:QueryAsync('UPDATE `owned_customs` SET bank=bank+@bank WHERE `id`=@id',{['@bank'] = ownedCustoms[id].vat, ['@id'] = id})
    elseif (tonumber(user.getBank()) >= tonumber(price)) then
     TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "[BANK] Upgrade/Modification Bought Cost: $".. price})
     TriggerClientEvent("LSC:buttonSelected", source,name, button, true) 
     user.removeBank(tonumber(price))
     exports['GHMattiMySQL']:QueryAsync('UPDATE `owned_customs` SET bank=bank+@bank WHERE `id`=@id',{['@bank'] = ownedCustoms[id].vat, ['@id'] = id})
    else
     TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "You Do Not Have Enough Money To Upgrade/Modify Your Vehicle"})
     TriggerClientEvent("LSC:buttonSelected", source,name, button, false)
    end
   end
  else
   if button.price then
    if (tonumber(user.getMoney()) >= tonumber(button.price)) then
     TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "Upgrade/Modification Bought Cost: $".. button.price})
 	   TriggerClientEvent("LSC:buttonSelected", source,name, button, true) 
	   user.removeMoney(tonumber(button.price))
    elseif (tonumber(user.getBank()) >= tonumber(button.price)) then
     TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "[BANK] Upgrade/Modification Bought Cost: $".. button.price})
	   TriggerClientEvent("LSC:buttonSelected", source,name, button, true)
	   user.removeBank(tonumber(button.price))
    else
     TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = "You Do Not Have Enough Money To Upgrade/Modify Your Vehicle"})
     TriggerClientEvent("LSC:buttonSelected", source,name, button, false)
    end
   end
  end
 end)
end)

RegisterServerEvent("LSC:finished")
AddEventHandler("LSC:finished", function(plate, data)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  if user.isVehicleOwner(plate) then
   user.updateVehicle(plate, data)
  end
 end)
end)

AddEventHandler('onResourceStart', function(resource)
 if resource == GetCurrentResourceName() then
  local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `owned_customs`")		
  for i,v in pairs(result) do
   ownedCustoms[v.id] = {id = v.id, vat = v.vat, price = v.price, bank = v.bank, owner = v.owner}
  end
 end
end)

RegisterServerEvent('customs:update')
AddEventHandler('customs:update', function()
 ownedCustoms = {}
 local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `owned_customs`") 
 for i,v in pairs(result) do
  ownedCustoms[v.id] = {id = v.id, vat = v.vat, price = v.price, bank = v.bank, owner = v.owner}
 end
 TriggerEvent("core:getPlayers", function(users)
  for _,v in pairs(users) do
   TriggerClientEvent('customs:update', v.getSource(), ownedCustoms, v.getCharacterID())
  end
 end)
end)

RegisterServerEvent('core:characterloaded')
AddEventHandler('core:characterloaded', function()
 TriggerEvent('core:getPlayerFromId', source, function(user)
  TriggerClientEvent('customs:update', source, ownedCustoms, user.getCharacterID())
 end)
end)


RegisterServerEvent('customs:purchase')
AddEventHandler('customs:purchase', function(id, price)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  if (tonumber(user.getMoney()) >= tonumber(price)) then
   exports['GHMattiMySQL']:QueryAsync('INSERT INTO `owned_customs` (id, price, owner) VALUES (@id, @price, @owner)',{['@id'] = id, ['@price'] = price, ['@owner'] = user.getCharacterID()})
   user.removeMoney(price)
   TriggerClientEvent('NRP-notify:client:SendAlert', tonumber(source), { type = 'inform', text = "You have purchased this customs", timeout = 2500,layout = "centerRight"})
   TriggerEvent('customs:update')
  else
   TriggerClientEvent('NRP-notify:client:SendAlert', tonumber(source), { type = 'inform', text = "Insufficient funds",length = 2500,layout = "centerRight"})
  end
 end)
end)

RegisterServerEvent('customs:updatevat')
AddEventHandler('customs:updatevat', function(price, id)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  exports['GHMattiMySQL']:QueryAsync('UPDATE `owned_customs` SET vat=@fuel WHERE `id`=@id',{['@fuel'] = price, ['@id'] = id})
  TriggerClientEvent('NRP-notify:client:SendAlert', tonumber(source), { type = 'inform', text = "Vat Price Updated",length = 2500,layout = "centerRight"})
  TriggerEvent('customs:update')
 end)
end)

RegisterServerEvent('customs:takeBank')
AddEventHandler('customs:takeBank', function(bank, id)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  exports['GHMattiMySQL']:QueryAsync('UPDATE `owned_customs` SET bank=@fuel WHERE `id`=@id',{['@fuel'] = 0, ['@id'] = id})
  TriggerClientEvent('NRP-notify:client:SendAlert', tonumber(source), { type = 'inform', text = "Bank Deposited Into Your Account",length = 2500,layout = "centerRight"})
  user.addBank(bank)
  TriggerEvent('customs:update')
 end)
end)

RegisterServerEvent('customs:sell')
AddEventHandler('customs:sell', function(id)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  exports['GHMattiMySQL']:QueryAsync('DELETE FROM `owned_customs` WHERE id=@id',{['@id'] = id})
  user.addMoney(price)
  TriggerClientEvent('NRP-notify:client:SendAlert', tonumber(source), { type = 'inform', text = "LS Customs Sold"})
  TriggerEvent('customs:update')
 end)
end)
