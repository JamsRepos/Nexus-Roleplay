local inService = {}
local onDuty = {}
local dispatchCodes = {}

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then

        local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM dispatch_codes")
		for k, v in pairs(result) do
            dispatchCodes[v.code] = {
                dbId = v.id,
                displayCode = v.display_code,
                description = v.description,
                isImportant = v.is_important,
                priority = v.priority,
                recipientList = json.decode(v.recepients)
            }
        end
    end
end)

RegisterServerEvent('nrp:svNotify')
AddEventHandler('nrp:svNotify', function(pData, suspectLocation)
    if pData ~= nil then
        if dispatchCodes[pData.dispatchCode] ~= nil then
            local dispatchData = dispatchCodes[pData.dispatchCode]
            pData.dbId = dispatchData.dbId
            pData.priority = dispatchData.priority
            pData.dispatchMessage = dispatchData.description
            pData.isImportant = dispatchData.isImportant
            pData.recipientList = dispatchData.recipientList
			TriggerClientEvent('nrp:clNotify', -1, pData)
			if pData.dispatchCode == "10-13" then
				TriggerClientEvent('dispatch:shotPos', -1, suspectLocation)
			elseif pData.dispatchCode == "10-35" then
				TriggerClientEvent('dispatch:vehiclePos', -1, suspectLocation)
			elseif pData.dispatchCode == "10-60" then
				TriggerClientEvent('dispatch:cdsPos', -1, suspectLocation)
			elseif pData.dispatchCode == "10-31B" then
				TriggerClientEvent('dispatch:robberyPos', -1, suspectLocation)
			end
        end
    end
end)

RegisterServerEvent('dispatch:duty')
AddEventHandler('dispatch:duty', function(status, callsign)
	local source = tonumber(source)
	TriggerEvent('core:getPlayerFromId', source, function(user)
		local name = user.getIdentity()
		fal = name.firstname .. " " .. name.lastname
		if status then
			inService[source] = callsign .. " | " .. fal
			onDuty[source] = source
			TriggerClientEvent("dispatch:update", -1, inService, onDuty)
		else
			inService[source] = nil
			onDuty[source] = nil
			TriggerClientEvent("dispatch:update", -1, inService, onDuty)
		end
	end)
end)

AddEventHandler('playerDropped', function()
	inService[source] = nil
	onDuty[source] = nil
	TriggerClientEvent("dispatch:update", -1, inService, onDuty)
end)

RegisterServerEvent('dispatch:noInsurance')
AddEventHandler('dispatch:noInsurance', function(suspectLocation, suspectSex, vehicleName, vehiclePlate, vehicleColour)
	if suspectLocation.both then
	 TriggerClientEvent('dispatch:notify', -1, suspectSex.." Driving An Uninsured "..vehicleColour.primary.." "..vehicleName.." Between "..suspectLocation.street1.." & "..suspectLocation.street2)
	else
     TriggerClientEvent('dispatch:notify', -1, suspectSex.." Driving An Uninsured "..vehicleColour.primary.." "..vehicleName.." Between "..suspectLocation.street1)
	end
	TriggerClientEvent('dispatch:noInsurancePos', -1, suspectLocation.pos)
end)