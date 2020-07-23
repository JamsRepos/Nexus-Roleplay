local itemlist = {}
local joblist = {}
local factionlist = {}

function CreatePlayer(source, data)
	local self = {}
	local rTable = {}

	self.source = source
	self.identifier = data.identifier
	self.discord = data.discord
	self.license = data.license
	self.permission_level = data.permission_level
	self.group = data.group
	self.watched = data.watched
	self.session = {}
	-- Character Data
	self.character_id = data.id
	self.character_identity = data.identity
	self.money = data.money
	self.bank = data.bank
	self.dirty_money = data.dirty_money
	self.job = data.job
	self.onduty = false
	self.adminduty = true
	self.faction = data.faction
	self.alive = data.alive
	self.phone_number = data.phone_number
	self.inventory = data.inventory
	self.vehicles = data.vehicles
	self.garages = data.garages
	self.vitals = data.vitals
	self.statistics = data.statistics
	self.points = data.points
	self.timers = data.timers
	self.playtime = data.playtime
	self.reputation = data.reputation
	self.outfit = data.outfit 
	self.coords = {x = 0.0, y = 0.0, z = 0.0}
	self.homeaddress = data.home_address
	self.driversl = data.drivers_license 


	-- Character ID
	rTable.setCharacterID = function(id)
		if type(id) == "number" then
			self.character_id = id
		end
	end
	
	rTable.getCharacterID = function()
		return self.character_id
	end
	
	rTable.getDiscordID = function()
		return self.discord
	end

	rTable.getIdentity = function()
		return self.character_identity
	end

	rTable.homeaddress = function()
		return self.homeaddress
	end

	rTable.driversl = function()
		return self.driversl
	end

	rTable.setDrivers = function(status)
		if status == 1 then
		 self.driversl = "Active"
		elseif status == 0 then
		  self.driversl = "No"
		end
	end

	rTable.setHomeAddress = function(address)
    	self.homeaddress = address

    end

	-- Money
	rTable.setMoney = function(m)
		if type(m) == "number" then
			self.money = m
			TriggerClientEvent('hud:money', self.source, self.money)
		end
	end 
	
	rTable.getMoney = function()
		return self.money
	end

	rTable.addMoney = function(m)
		if type(m) == "number" then
			local newMoney = self.money + m
			self.money = newMoney
			TriggerClientEvent('hud:money', self.source, self.money)
		end
	end

	rTable.removeMoney = function(m)
		if type(m) == "number" then
			local newMoney = self.money - m
			self.money = newMoney
			TriggerClientEvent('hud:money', self.source, self.money)
		end
	end

	-- Bank 
	rTable.setBankBalance = function(m)
		if type(m) == "number" then
			self.bank = m
		end
	end

	rTable.getBank = function()
		return self.bank
	end

	rTable.addBank = function(m)
		if type(m) == "number" then
			local newBank = self.bank + m
			self.bank = newBank
		end
	end

	rTable.removeBank = function(m)
		if type(m) == "number" then
			local newBank = self.bank - m
			self.bank = newBank
		end
	end

	-- Dirty Money 
	rTable.setDirtyMoney = function(m)
		if type(m) == "number" then
			self.dirty_money = m
		end
	end

	rTable.getDirtyMoney = function()
		return self.dirty_money
	end

	rTable.addDirtyMoney = function(m)
		if type(m) == "number" then
			local newDirtyMoney = self.dirty_money + m
			self.dirty_money = newDirtyMoney
		end
	end

	rTable.removeDirtyMoney = function(m)
		if type(m) == "number" then
			local newDirtyMoney = self.dirty_money - m
			self.dirty_money = newDirtyMoney
		end
	end

	-- Inventory System
	rTable.wipeInventory = function()
		self.inventory = {}
	end

	rTable.getInventory = function()
		return self.inventory
	end

	rTable.addQuantity = function(itemid, quantity, metaData)
		local exist = DoesItemExist(itemid)
		if exist then
	        local thisItemId = tonumber(itemid)
	        local thisQuantity = tonumber(quantity)
	        local isFull = CheckIfFull(self.inventory,thisQuantity)
	        if not isFull then
		        for i = 1, #self.inventory do
		            if self.inventory[i].id == tonumber(itemid) then
		                self.inventory[i].q = self.inventory[i].q + tonumber(quantity)
		                TriggerEvent("inventory:updateitems",self.source)
		                return 1
		            end
		        end
		        local name = getItemname(thisItemId)
		        local canUse = getItemCanUse(thisItemId)
		        local isConsumable = getItemConsumable(thisItemId)
		        local isPawnable = getItemPawnable(thisItemId)
		        local isRecyclable = getItemRecyclable(thisItemId)
		        table.insert(self.inventory,
		            {
		                id = thisItemId,
		                q = thisQuantity,
		                name = name,
		                canUse = canUse,
		                isConsumable = isConsumable,
		                isPawnable = isPawnable,
		                isRecyclable = isRecyclable,
		                meta = metaData or 'This Item Contains No Meta Data'
		            }
		        )
		        TriggerEvent("inventory:updateitems",self.source)
	        	return 2
	        else
	        	return 0
	        end
	    end
    end

	rTable.removeQuantity = function(itemid, quantity)
		local exist = DoesItemExist(itemid)
		if exist then
	        local thisItemId = tonumber(itemid)
	        local thisQuantity = tonumber(quantity)
	        for i = 1, #self.inventory do
	            if self.inventory[i].id == tonumber(itemid) and self.inventory[i].q >= tonumber(quantity) then
	                self.inventory[i].q = self.inventory[i].q - tonumber(quantity)
	                TriggerEvent("inventory:updateitems",self.source)
	                return 1
	            elseif self.inventory[i].id == tonumber(itemid) and self.inventory[i].q < tonumber(quantity) then
	                self.inventory[i].q = 0
	                TriggerEvent("inventory:updateitems",self.source)
	                return 1
	            end
	        end
	    end
    end

	rTable.isAbleToReceive = function(quantity)
		local isFull = CheckIfFull(self.inventory, tonumber(quantity))
		if not isFull then
			return true
		else
			return false
		end
	end

	rTable.isAbleToGive = function(itemId, quantity)
        for i = 1, #self.inventory do
            if tonumber(self.inventory[i].id) == tonumber(itemId) then
                if tonumber(quantity) <= tonumber(self.inventory[i].q) then
                    return true
                else
                    return false
                end
            end
        end
        return false
    end

    rTable.getQuantity = function(itemid)
		local exist = DoesItemExist(itemid)
		if exist then
			for i = 1, #self.inventory do
				if self.inventory[i].id == tonumber(itemid) then
					return self.inventory[i].q
		        end
		    end
		end
	end

	rTable.isAbleToDrop = function(itemid, quantity)
		local exist = DoesItemExist(itemid)
		if exist then
		    local thisItemId = tonumber(itemid)
		    local thisQuantity = tonumber(quantity)
		    for i = 1, #self.inventory do
		        if self.inventory[i].id == tonumber(itemid)then
		        	if self.inventory[i].q >= tonumber(quantity) then
		            	return true
		            else
		            	return false
		            end
		        end
		    end
	    else
	    	print("[ERROR]::Resource attempted to DropQuantity but the item does not exist")
	    end
	end

	rTable.isItemIllegal = function(itemId)
		for _, item in pairs(itemlist) do
			if item.id == itemId then
			 if item.IsIllegal == 1 then
				return true
			 end
			end
		end
		return false
    end

	rTable.getItemData = function(itemId)
		local itemId = tonumber(itemId)
		local exist = DoesItemExist(itemId)
		if exist then
		    for i = 1, #self.inventory do
		        if self.inventory[i].id == tonumber(itemId) then
		            return self.inventory[i]
		        end
		    end
			for _, item in pairs(itemlist) do
				if item.id == tonumber(itemId) then
					return {id=item.id,name=item.name,canUse=item.canUse,q=0,meta=item.meta or 'This Item Contains No Meta Data'}
				end
			end		    
		end
	end

	rTable.getItemMeta = function(itemId)
		local itemId = tonumber(itemId)
		local exist = DoesItemExist(itemId)
		if exist then
		    for i = 1, #self.inventory do
		        if self.inventory[i].id == tonumber(itemId) then
		        	if self.inventory[i].meta then
		            	return self.inventory[i].meta
		        	end 
		        end
		    end
			return 'This Item Contains No Meta Data'
		end
	end

	-- Vehicle & Garage
	rTable.getVehicles = function()
 		return self.vehicles
	end

	rTable.getVehicle = function(plate)
		for i = 1, #self.vehicles do
			if self.vehicles[i] ~= nil then
	 			if self.vehicles[i].plate == tostring(plate) then
	 				return self.vehicles[i]
	 			end
			end
		end
	end

	rTable.storeVehicle = function(plate, data, fuel, garage)
		for i = 1, #self.vehicles do
			if self.vehicles[i] ~= nil then
	 			if self.vehicles[i].plate == tostring(plate) then
	 			 self.vehicles[i].components = data
	 			 self.vehicles[i].fuel = fuel 
	 			 self.vehicles[i].stored = true
	 			 self.vehicles[i].garage = garage
	 			end 
			end
		end
		TriggerEvent("garage:update", self.source)
	end

	rTable.updateVehicle = function(plate, data)
		for i = 1, #self.vehicles do
			if self.vehicles[i] ~= nil then
	 			if self.vehicles[i].plate == tostring(plate) then
	 			 self.vehicles[i].components = data
	 			end
			end
		end
		TriggerEvent("garage:update", self.source)
	end

	rTable.isVehicleOwner = function(plate)
		for i = 1, #self.vehicles do
			if self.vehicles[i] ~= nil then
	 			if self.vehicles[i].plate == tostring(plate) then
	 				return true
	 			end
			end
		end
	end

	rTable.getVehicleOwner = function(plate)
		for i = 1, #self.vehicles do
			if self.vehicles[i] ~= nil then
	 			if self.vehicles[i].plate == tostring(plate) then
	 				return self.identity
	 			end
			end
		end
	end

	rTable.setVehicleState = function(plate, v)
		for i = 1, #self.vehicles do
			if self.vehicles[i].plate == plate then 
				self.vehicles[i].stored = v
			end
		end
	end

	rTable.setVehicleOut = function(plate)
		for i = 1, #self.vehicles do
			if self.vehicles[i].plate == tostring(plate) then
				self.vehicles[i].stored = false
			end
		end
		TriggerEvent("garage:update", self.source)
	end

	rTable.setVehicleInsurance = function(plate, v)
		for i = 1, #self.vehicles do
			if self.vehicles[i].plate == tostring(plate) then
				self.vehicles[i].insured = v
			end
		end
		TriggerEvent("garage:update", self.source)
	end

	rTable.setVehicleImpound = function(plate, v)
		for i = 1, #self.vehicles do
			if self.vehicles[i].plate == tostring(plate) then
				self.vehicles[i].impound = v
			end
		end
		TriggerEvent("garage:update", self.source)
	end

	rTable.setAllVehicleState = function(v)
		local count = 0
		for i = 1, #self.vehicles do
			count = count + 1
		end
		if count > 0 then
			for i = 1, #self.vehicles do
				self.vehicles[i].stored = v -- State
			end
		end
		TriggerEvent("garage:update", self.source)
	end

	rTable.removeVehicle = function(plate)
		for i = 1, #self.vehicles do
	 		if self.vehicles[i].plate == tostring(plate) then
		 		table.remove(self.vehicles, i)
		 		TriggerEvent("garage:update", self.source)
		 		break
		 	end
		end
	end

	rTable.addVehicle = function(data, price, model)
		if self.vehicles ~= nil then
			table.insert(self.vehicles, {owner = self.identity, plate = data.plate, model = model, components = data, stored = false, insured = false, impound = false, fuel = 50, price = price, garage = 1})
			TriggerEvent("garage:update", self.source)
		else
			self.vehicles = {}
			table.insert(self.vehicles, {owner = self.identity, plate = data.plate, model = model, components = data, stored = false, insured = false, impound = false, fuel = 50, price = price, garage = 1})
			TriggerEvent("garage:update", self.source)
		end
    end

	rTable.getGarages = function()
		return self.garages
	end

	rTable.setGarageAmount = function(id, amount)
		if id ~= 0 then
			if self.garages[i] == tonumber(id) then
				self.garages[i].count = tonumber(amount)
			end
		end
		TriggerEvent("garage:update", self.source)
	end


	rTable.setGarage = function(plate, gid)
		for i = 1, #self.vehicles do
			if self.vehicles[i].plate == plate then
				self.vehicles[i].garage = gid
			end
		end
		TriggerEvent("garage:update", self.source)
	end

	rTable.removeGarage = function(id)
		for i = 1, #self.garages do
			if self.garages[i].id == tonumber(id) then
 				table.remove(self.garages, i)
 				TriggerEvent("garage:update", self.source)
 			end
		end
	end

	rTable.addGarage = function(id,slots,cost)
		for i = 1, #self.garages do
			if self.garages[i].id == tonumber(id) then
				self.garages[i].cost=self.garages[i].cost + tonumber(cost)
				self.garages[i].count=tonumber(slots)
				TriggerEvent("garage:update", self.source)
				return print("Altered garage")
			end
		end
		table.insert(self.garages,{id=tonumber(id), cost=(tonumber(cost)/2), count=tonumber(slots)})
		TriggerEvent("garage:update", self.source)
	end

	-- Jobs
	rTable.getAllJobs = function()
		return joblist
	end

	rTable.getJob = function()
		return self.job
	end

	rTable.getJobName = function()
		for _,v in pairs(joblist) do
			if v.id == self.job then
				return v.name
			end
		end
	end

	rTable.getJobSalary = function()
		for _,v in pairs(joblist) do
			if v.id == self.job then
				return v.pay
			end
		end
	end

	rTable.setJob = function(v)
		local exist = DoesJobExist(v)
		if exist then
			self.job = tonumber(v)
			TriggerClientEvent("core:setjob", self.source, self.job, joblist)
		end
	end

	rTable.getJobData = function()
		for _,v in pairs(joblist) do
			if v.id == self.job then
				return v
			end
		end
	end

	rTable.isOnDuty = function()
	 if self.onduty then 
	  return true
	 else
 	  return false
	 end
	end

	rTable.setOnDuty = function(v)
	 self.onduty = v
	end

	rTable.isAdminEnabled = function()
		return self.adminduty
	end

	rTable.setAdminEnabled = function(v)
	 self.adminduty = v
	end

	-- Factions
	rTable.getAllFactions = function()
		return factionlist
	end

	rTable.getFaction = function()
		return self.faction
	end

	rTable.isAlive = function()
		if self.alive == 1 or self.alive == '1' then 
			return true
		else
			return false 
		end
	end

	rTable.setFaction = function(v)
		local exist = DoesFactionExist(v)
		if exist then
			self.faction = tonumber(v)
			TriggerClientEvent("core:setfac", self.source, self.faction)
		end
	end

	rTable.getFactionName = function()
		for _,v in pairs(factionlist) do
			if v.id == self.faction then
				return v.name
			end
		end
	end

	-- Weapons
	rTable.addWeapon = function(weapon_name, weapon_label, blackmarket)
		exports['GHMattiMySQL']:QueryAsync('INSERT INTO `owned_weapons` (char_id, owner, name, label, blackmarket) VALUES (@char_id, @owner, @name, @label, @blackmarket)',{['@char_id'] = self.character_id, ['@name'] = weapon_name, ['@label'] = weapon_label, ['@owner'] = self.character_identity.fullname, ['@blackmarket'] = blackmarket or 0})
		TriggerClientEvent('core:addweapon', self.source, weapon_name)
		TriggerClientEvent('weapons:addmodel', self.source, weapon_name)
		TriggerEvent("weapon:refresh", self.source)
	end

	rTable.addStoredWeapon = function(id, name, label, blackmarket)
		exports['GHMattiMySQL']:QueryAsync('INSERT INTO `owned_weapons` (char_id, owner, name, label, blackmarket) VALUES (@char_id, @owner, @name, @label, @blackmarket)',{['@char_id'] = self.character_id, ['@name'] = name, ['@label'] = label, ['@blackmarket'] = blackmarket or 0, ['@owner'] = self.character_identity.fullname})
		TriggerClientEvent('core:addweapon', self.source, weapon_name)
		TriggerClientEvent('weapons:addmodel', self.source, weapon_name)
		TriggerEvent("weapon:refresh", self.source)
	end

	rTable.addBlackMarketWeapon = function(weapon_name, weapon_label)
		exports['GHMattiMySQL']:QueryAsync('INSERT INTO `owned_weapons` (char_id, owner, name, label, blackmarket) VALUES (@char_id, @owner, @name, @label, @blackmarket)',{['@char_id'] = self.character_id, ['@name'] = weapon_name, ['@label'] = weapon_label, ['@blackmarket'] = 1, ['@owner'] = self.character_identity.fullname})
		TriggerClientEvent('core:addweapon', self.source, weapon_name)
		TriggerClientEvent('core:addweapon', self.source, weapon_name)
		TriggerClientEvent('weapons:addmodel', self.source, weapon_name)
		TriggerEvent("weapon:refresh", self.source)
	end

	rTable.removeWeapon = function(id, model)
		exports['GHMattiMySQL']:QueryAsync("DELETE FROM `owned_weapons` WHERE id=@id", {['@id'] = id})
		TriggerClientEvent('core:removeweapon', self.source, model, false)
		TriggerClientEvent('weapons:removemodel', self.source, model)
		TriggerEvent("weapon:refresh", self.source) 
		TriggerClientEvent('weapons:updateback', self.source)
	end

	rTable.removeAllWeapons = function()
		exports['GHMattiMySQL']:QueryAsync("DELETE FROM `owned_weapons` WHERE char_id=@id", {['@id'] = self.character_id})
		TriggerClientEvent('core:removeweapon', self.source, nil, true)
		TriggerClientEvent("police:byebyeweapons", self.source)
		TriggerEvent("weapon:refresh", self.source) 
	end

	rTable.getWeapons = function()
		local weapons = {}
		local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `owned_weapons` WHERE char_id=@char_id",{['@char_id'] = self.character_id}) 
		for _,v in pairs(result) do
		 table.insert(weapons, {id = v.id, name = v.name, label = v.label, bought = v.bought, blackmarket = v.blackmarket})
		end
		return weapons
	end

	-- Illegal Reputation 
	rTable.getReputation = function()
	 return self.reputation
	end

	rTable.setReputation = function(v)
	 self.reputation = v
	 TriggerClientEvent('repuation:set', self.source, self.reputation)
	end

	rTable.addReputation = function(v)
	 self.reputation = self.reputation + v
	 TriggerClientEvent('repuation:set', self.source, self.reputation)
	end

	rTable.removeReputation = function(v)
	 self.reputation = self.reputation - v
	 TriggerClientEvent('repuation:set', self.source, self.reputation)
	end

	-- Statistics 
	rTable.getPlaytime = function()
	 return self.playtime
	end

	rTable.getStatistics = function()
	 return self.statistics
	end

	rTable.getStatistic = function(name)
	 for i = 1, #self.statistics do
	  if self.statistics[i] ~= nil then
	   if self.statistics[i].name == tostring(name) then
		return self.statistics[i].value
	   end
	  end
	 end
	end

	rTable.setStatistic = function(name, value)
		for i = 1, #self.statistics do
			if self.statistics[i] ~= nil then
	 			if self.statistics[i].name == tostring(name) then
	 				self.statistics[i].value = tonumber(value)
	 			end
	 		end
		end
	end

	rTable.addStatistic = function(name, value)
		for i = 1, #self.statistics do
			if self.statistics[i] ~= nil then
	 			if self.statistics[i].name == tostring(name) then
	 				self.statistics[i].value = self.statistics[i].value+tonumber(value)
	 			end
	 		end
		end
	end

	rTable.removeStatistic = function(name, value)
		for i = 1, #self.statistics do
			if self.statistics[i] ~= nil then
	 			if self.statistics[i].name == tostring(name) then
	 				self.statistics[i].value = self.statistics[i].value-tonumber(value)
	 			end
	 		end
		end
	end
	
	-- Points
	 rTable.getPoints = function()
		return self.points
	   end
   
	   rTable.getPoint = function(name)
		for i = 1, #self.points do
		 if self.points[i] ~= nil then
		  if self.points[i].name == tostring(name) then
		   return self.points[i].value
		  end
		 end
		end
	   end
   
	   rTable.setPoint = function(name, value)
		   for i = 1, #self.points do
			   if self.points[i] ~= nil then
					if self.points[i].name == tostring(name) then
						self.points[i].value = tonumber(value)
					end
				end
		   end
	   end
   
	   rTable.addPoint = function(name, value)
		   for i = 1, #self.points do
			   if self.points[i] ~= nil then
					if self.points[i].name == tostring(name) then
						self.points[i].value = self.points[i].value+tonumber(value)
					end
				end
		   end
	   end
   
	   rTable.removePoint = function(name, value)
		   for i = 1, #self.points do
			   if self.points[i] ~= nil then
					if self.points[i].name == tostring(name) then
						self.points[i].value = self.points[i].value-tonumber(value)
					end
				end
		   end
	   end
	
	-- Timers
	 rTable.getTimers = function()
		return self.timers
	   end
   
	   rTable.getTimer = function(name)
		for i = 1, #self.timers do
		 if self.timers[i] ~= nil then
		  if self.timers[i].name == tostring(name) then
		   return self.timers[i].value
		  end
		 end
		end
	   end
   
	   rTable.setTimer = function(name, value)
		   for i = 1, #self.timers do
			   if self.timers[i] ~= nil then
					if self.timers[i].name == tostring(name) then
						self.timers[i].value = tonumber(value)
					end
				end
		   end
	   end
   
	   rTable.addTimer = function(name, value)
		   for i = 1, #self.timers do
			   if self.timers[i] ~= nil then
					if self.timers[i].name == tostring(name) then
						self.timers[i].value = self.timers[i].value+tonumber(value)
					end
				end
		   end
	   end
   
	   rTable.removeTimer = function(name, value)
		   for i = 1, #self.timers do
			   if self.timers[i] ~= nil then
					if self.timers[i].name == tostring(name) then
						self.timers[i].value = self.timers[i].value-tonumber(value)
					end
				end
		   end
	   end


	-- Vitals 
	rTable.getVitals = function()
		return self.vitals
	end

	rTable.getVital = function(name)
		for i = 1, #self.vitals do
			if self.vitals[i] ~= nil then
	 			if self.vitals[i].name == tostring(name) then
	 				return self.vitals[i].value
	 			end
	 		end
		end
	end

	rTable.setVital = function(name, value)
		for i = 1, #self.vitals do
			if self.vitals[i] ~= nil then
	 			if self.vitals[i].name == tostring(name) then
	 				self.vitals[i].value = tonumber(value)
	 			end
	 		end
		end
	end
	
	-- Outfit
	rTable.getOutfit = function()
		return self.outfit
	end

	rTable.setOutfit = function(data)
		self.outfit = tostring(data)
	end

	-- Other
	rTable.getCoords = function()
		return self.coords
	end

	rTable.getPhoneNumber = function()
		return self.phone_number
	end

	rTable.setCoords = function(x, y, z)
		self.coords = {x = x, y = y, z = z}
	end

	rTable.setSessionVar = function(key, value)
		self.session[key] = value
	end

	rTable.getSource = function()
		return self.source
	end

	rTable.getSessionVar = function(k)
		return self.session[k]
	end

	rTable.getPermissions = function()
		return self.permission_level
	end

	rTable.setPermissions = function(p)
		self.permission_level = p
	end

	rTable.getIdentifier = function(i)
		return self.identifier
	end

	rTable.getGroup = function()
		return self.group
	end

	rTable.isWatched = function()
		if self.watched == 1 or self.watched == '1' then 
			return true
		else
			return false 
		end
	end

	rTable.set = function(k, v)
		self[k] = v
	end

	rTable.get = function(k)
		return self[k]
	end

	rTable.setGlobal = function(g, default)
		self[g] = default or ""

		rTable["get" .. g:gsub("^%l", string.upper)] = function()
			return self[g]
		end

		rTable["set" .. g:gsub("^%l", string.upper)] = function(e)
			self[g] = e
		end

		Users[self.source] = rTable
	end

	return rTable
end

-- Character Saving 
local function saveCharacterData()
  SetTimeout(300000, function()
    Citizen.CreateThread(function()
      for k,v in pairs(Users)do
        if Users[k] ~= nil then
         exports['GHMattiMySQL']:QueryAsync("UPDATE `characters` SET money=@money, bank=@bank, dirty_money=@dirty_money, position=@position, job=@job, faction=@faction, inventory=@inventory, vehicles=@vehicles, garages=@garages, outfit=@outfit, statistics=@statistics, points=@points, timers=@timers, vitals=@vitals, reputation=@reputation, playtime = playtime+2 WHERE id = @id", {
          ['@id'] = v.getCharacterID(),
          ['@money'] = v.getMoney(),
          ['@bank'] = v.getBank(),
          ['@dirty_money'] = v.getDirtyMoney(),
          ['@position'] = json.encode(v.getCoords()),
          ['@inventory'] = json.encode(v.getInventory()),
          ['@vehicles'] = json.encode(v.getVehicles()),
          ['@garages'] = json.encode(v.getGarages()),
          ['@outfit'] = v.getOutfit(),
          ['@job'] = v.getJob(),
          ['@faction'] = v.getFaction(),
          ['@reputation'] = v.getReputation(),
          ['@statistics'] = json.encode(v.getStatistics()),
		  ['@vitals'] = json.encode(v.getVitals()),
		  --['@perks'] = json.encode(v.getPerks()),
		  ['@points'] = json.encode(v.getPoints()),
		  ['@timers'] = json.encode(v.getTimers()),
         })
        end
      end
      saveCharacterData()
    end)
  end)
end 
saveCharacterData()

local function payJobSalary()
  SetTimeout(1200000, function()
    Citizen.CreateThread(function()
      for k,v in pairs(Users)do
        if Users[k] ~= nil then
         v.addBank(v.getJobSalary()*getVat(9)) ---- remove *2 for payment not being doubled
		 --TriggerEvent('phone:addEmail', v.getSource(), "Paycheck Received: + <font color='lightgreen'>$"..math.floor(v.getJobSalary()*getVat(9)).."</font>", 'Fleeca Bank')
		 TriggerClientEvent('NRP-notify:client:SendAlert', v.getSource(), { type = 'success', text = "Paycheck Received: + $"..math.floor(v.getJobSalary()*getVat(9)).." Salary Payment"})
        end
      end
      payJobSalary()
    end)
  end)
end
payJobSalary()


-- Other Functions
function CheckIfFull(inventory,quantity)
  local total = 0
  for i = 1, #inventory do
   total = total + tonumber(inventory[i].q)
  end
  if total == 0 then
   return false
  else
   total = total + quantity
   if total > 120 then
    return true
   else
    return false
   end
  end
end

function DoesItemExist(itemId)
	for _, item in pairs(itemlist) do
		if item.id == tonumber(itemId) then
			return true
		end
	end
	return false
end

function getItemname(itemId)
	for _, item in pairs(itemlist) do
		if item.id == tonumber(itemId) then
			return item.name
		end
	end
	return false
end

function getItemCanUse(itemId)
	for _, item in pairs(itemlist) do
		if item.id == tonumber(itemId) then
			return item.canUse
		end
	end
end

function getItemConsumable(itemId)
	for _, item in pairs(itemlist) do
		if item.id == tonumber(itemId) then
			return item.isConsumable
		end
	end
end

function getItemPawnable(itemId)
	for _, item in pairs(itemlist) do
		if item.id == tonumber(itemId) then
			return item.isPawnable
		end
	end
end

function getItemRecyclable(itemId)
	for _, item in pairs(itemlist) do
		if item.id == tonumber(itemId) then
			return item.isRecyclable
		end
	end
end

function DoesJobExist(job)
	for _, item in pairs(joblist) do
		if item.id == tonumber(job) then
			return true
		end
	end
	return false
end

function DoesFactionExist(faction)
	for _, item in pairs(factionlist) do
		if item.id == tonumber(faction) then
			return true
		end
	end
	return false
end

AddEventHandler('onResourceStart', function(resource)
 if resource == GetCurrentResourceName() then
  local items = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `items`")
  local jobs = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `jobs`")
  local factions = exports['GHMattiMySQL']:QueryResult("SELECT * FROM `factions`")
  for _,v in pairs(items) do
   table.insert(itemlist, {id=v.id, name=v.name, canUse=v.canUse, IsIllegal=v.isIllegal, isConsumable=v.isConsumable, isPawnable=v.isPawnable, isRecyclable = v.isRecyclable})
  end
  for _,v in pairs(jobs) do
   table.insert(joblist, {id=v.id, name=v.label, pay=v.pay, whitelisted=v.whitelisted})
  end
  for _,v in pairs(factions) do
   table.insert(factionlist, {id=v.id, name=v.name})
  end
  exports['GHMattiMySQL']:QueryAsync('UPDATE `users` SET `isOnline`= 0')
 end
end)

