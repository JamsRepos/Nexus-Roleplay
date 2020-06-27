
--[[RegisterServerEvent('SmallTattoos:GetPlayerTattoos')
AddEventHandler('SmallTattoos:GetPlayerTattoos', function(source)
	local source = tonumber(source)
    TriggerEvent('core:getPlayerFromId', source, function(user)
	
		exports['GHMattiMySQL']:QueryResultAsync('SELECT tattoos FROM character WHERE id = @id', {
			['@id'] = user.GetCharacterID()
		}, function(result)
			
			if result[1].tattoos then
				TriggerClientEvent('SmallTattoos:GetPlayerTattoos',json.decode(result[1].tattoos))
				--cb(json.decode(result[1].tattoos))
			else
				--cb()
			end

		end)	
    end)
end)
]]--

RegisterServerEvent("fl_tattoo:purchase")
AddEventHandler("fl_tattoo:purchase", function(tattooList, price, tattoo, tattooName)
local source = tonumber(source)
print(tattooList, price, tattoo, tattooName)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  if (tattooList) then
	print(tattooList, price, tattoo, tattooName)
    if user.getMoney() >= tonumber(price) then
	 user.removeMoney(price)
	 exports['GHMattiMySQL']:QueryAsync('UPDATE characters SET `tattoos`=@tattoos WHERE id = @id',{['@id'] = user.getCharacterID(), ['@tattoos'] = json.encode(tattooList)})
	 TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text ="You have bought the " .. tattooName .. " tattoo for $" .. price}) 

	else
		TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text ="You do not have enough money for this tattoo"}) 
	end
   end
 end)
end)


RegisterServerEvent('SmallTattoos:PurchaseTattoo')
AddEventHandler('SmallTattoos:PurchaseTattoo', function(tattooList, price, tattoo, tattooName)
	local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
   print(tattooList, price, tattoo, tattooName)
	if user.getMoney() >= tonumber(price) then
		user.removeMoney(price)
		--table.insert(tattooList, tattoo)
    
		exports['GHMattiMySQL']:QueryAsync('UPDATE characters SET tattoos = @tattoos WHERE id = @id', {
			['@tattoos'] = json.encode(tattooList),
			['@id'] = user.getCharacterID()
		})
		TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text ="You have bought the " .. tattooName .. " tattoo for $" .. price}) 
		TriggerClientEvent('buytat')
    elseif user.getBank() >= tonumber(price) then
		user.removeBank(price)
		table.insert(tattooList, tattoo)
    
		exports['GHMattiMySQL']:QueryAsync('UPDATE characters SET tattoos = @tattoos WHERE id = @id', {
			['@tattoos'] = json.encode(tattooList),
			['@id'] = user.getCharacterID()
		})
		TriggerClientEvent('buytat')
		TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text ="You have bought the " .. tattooName .. " tattoo for $" .. price}) 
		
	else
		TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text ="You do not have enough money for this tattoo"}) 
		
	end
 end)
end)



RegisterServerEvent('SmallTattoos:RemoveTattoo')
AddEventHandler('SmallTattoos:RemoveTattoo', function (tattooList)
	local source = tonumber(source)
    TriggerEvent('core:getPlayerFromId', source, function(user)

		exports['GHMattiMySQL']:QueryAsync('UPDATE tattoos FROM `characters` = @tattoos WHERE id = @id', {
		['@tattoos'] = json.encode(tattooList),
		['@id'] = user.getCharacterID()
	})

 end)
end)


AddEventHandler("tattoo:getTattoos", function(source, cb)
  TriggerEvent("core:getPlayerFromId", source, function(user)
    local data = exports['GHMattiMySQL']:QueryResult("SELECT tattoos FROM `characters` WHERE id=@char_id",{['@char_id'] = user.getCharacterID()})
    cb(json.decode(data[1].tattoos))
  end)
end)

RegisterServerEvent("tattoo:activateTattooShop")
AddEventHandler("tattoo:activateTattooShop", function()
  local source = tonumber(source)
  TriggerEvent("tattoo:getTattoos", source, function(tattooList)
    TriggerClientEvent("tattoo:setTattoos", source, tattooList)
  end)
end)

RegisterServerEvent("core:characterloaded")
AddEventHandler("core:characterloaded", function()
  local source = tonumber(source)
  TriggerEvent("tattoo:getTattoos", source, function(tattooList)
    TriggerClientEvent("tattoo:setTattoos", source, tattooList)
  end)
end)



RegisterServerEvent("tattoos:requestTattooData")
AddEventHandler("tattoos:requestTattooData", function(name, gender)
  if (name) then
    for _,v in pairs(tattooList) do
      if (v.name == name and v.gender == gender) then
        TriggerClientEvent("tattoos:setTattooData", source, v)
        break
      end
    end
  end
end)

RegisterServerEvent("tattoos:saveCharTattoos")
AddEventHandler("tattoos:saveCharTattoos", function(tats)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  if (tats) then
   local source = tonumber(source)
   exports['GHMattiMySQL']:QueryAsync('UPDATE characters SET `tattoos`=@tattoos WHERE id = @id',{['@id'] = user.getCharacterID(), ['@tattoos'] = json.encode(tats)})
  end
 end)
end)

