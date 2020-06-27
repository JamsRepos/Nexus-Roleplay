RegisterServerEvent('inventory:giveItem')
AddEventHandler('inventory:giveItem', function(itemid, qty, meta)
	local player = tonumber(source)
	TriggerEvent('core:getPlayerFromId', player, function(user)
		local canGetOther = user.isAbleToReceive(qty)
	  if canGetOther then
		 user.addQuantity(item,1,meta)
		end
  end)
end)

--[[RegisterServerEvent('inventory:defaultItems')
AddEventHandler('inventory:defaultItems', function()
	local player = tonumber(source)
	TriggerEvent('core:getPlayerFromId', player, function(user)
		exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM characters WHERE `id` = @id", {['@id'] = user.getCharacterID()}, function(result)
		 if result[1].givenLoadout == 0 then
			local fullname = tostring(user.getIdentity().fullname)
			local characterID = tostring(user.getCharacterID())
			local characterNumber = tostring(user.getPhoneNumber())
			user.addQuantity(267,1,fullname)
			user.addQuantity(265,1,characterID)
			user.addQuantity(266,1,characterNumber)
			exports['GHMattiMySQL']:QueryAsync("UPDATE `characters` SET givenLoadout=@givenLoadout WHERE id=@id",{['@id'] = user.getCharacterID(), ['@givenLoadout'] = 1})
		 end
		end)
  end)
end)
]]--
RegisterServerEvent('inventory:getTargetPlayer')
AddEventHandler('inventory:getTargetPlayer', function(t)
	print("getting target")
 local source = tonumber(source)
 local target = tonumber(t)
 TriggerEvent('core:getPlayerFromId', target, function(user)
  local inventory = user.getInventory()
  TriggerClientEvent('inventory:otherPlayerRefresh', source, inventory, target)
 end)
end) 

RegisterServerEvent('inventory:takeItem')
AddEventHandler('inventory:takeItem', function(t, item, qty, meta)
 local source = tonumber(source)
 local target = tonumber(t)
 print("target")
 TriggerEvent('core:getPlayerFromId', source, function(user)
  local canGet = user.isAbleToReceive(qty)
  if not canGet then
	print('Inventory Full')
  else
	TriggerEvent('core:getPlayerFromId', target, function(tar)
	 local canGive = tar.isAbleToGive(item,qty,meta)
	 if canGive then
	  tar.removeQuantity(item,qty,meta)
	  user.addQuantity(item,qty, meta)
	  print("getting item")
	  local inventory = tar.getInventory()
	  TriggerClientEvent('inventory:otherPlayerRefresh', source, inventory, target)
	 else
	  print("The user does not have enough of that item to take")
	 end
	end)
  end
 end)
end)

RegisterServerEvent('inventory:putItem')
AddEventHandler('inventory:putItem', function(t, item, qty, meta)
 local source = tonumber(source)
 local target = tonumber(t)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  canGive = user.isAbleToGive(item,qty,meta)
  if not canGive then
	print('Unable to give Item!')
  else
	TriggerEvent('core:getPlayerFromId', target, function(tar)
	 local canGetOther = tar.isAbleToReceive(qty)
	 if canGetOther then
	  tar.addQuantity(item,qty,meta)
	  local inventory = tar.getInventory()
	  print("getting item")
	  TriggerClientEvent('inventory:otherPlayerRefresh', source, inventory, target)
	 end
    end)
	user.removeQuantity(item, qty, meta)
   end
 end)
end)

RegisterServerEvent('inventory:trashItem')
AddEventHandler('inventory:trashItem', function(item, qty, meta)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
	canGive = user.isAbleToGive(item,qty,meta)
	if canGive then
	 user.removeQuantity(item,qty,meta)
  end
 end)
end)