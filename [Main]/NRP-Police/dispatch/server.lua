local inService = {}
local onDuty = {}

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


RegisterServerEvent('dispatch:vehicle')
AddEventHandler('dispatch:vehicle', function(suspectLocation, suspectSex, vehicleName, vehiclePlate, vehicleColour)
	if suspectLocation.both then
	 TriggerClientEvent('dispatch:notify', -1, "Vehicle Theft Of A <div>"..vehicleColour.primary.." "..vehicleName.." By A "..suspectSex.."<div> Between "..suspectLocation.street1.." & "..suspectLocation.street2)
	else
	 TriggerClientEvent('dispatch:notify', -1, "Vehicle Theft Of A <div>"..vehicleColour.primary.." "..vehicleName.." By A "..suspectSex.."<div> Between "..suspectLocation.street1)
	end
	TriggerClientEvent('dispatch:vehiclePos', -1, suspectLocation.pos)
end)

RegisterServerEvent('dispatch:shot')
AddEventHandler('dispatch:shot', function(suspectLocation, suspectSex, vehicleName, vehiclePlate, vehicleColour)
	if suspectLocation.both then
	 TriggerClientEvent('dispatch:notify', -1, "Gunshot Report By A "..suspectSex.." Between "..suspectLocation.street1.." & "..suspectLocation.street2)
	else
	 TriggerClientEvent('dispatch:notify', -1, "Gunshot Report By A "..suspectSex.." At "..suspectLocation.street1)
	end
	TriggerClientEvent('dispatch:shotPos', -1, suspectLocation.pos)
end)

RegisterServerEvent('dispatch:cds')
AddEventHandler('dispatch:cds', function(suspectLocation, suspectSex)
	if suspectLocation.both then
	 TriggerClientEvent('dispatch:notify', -1, "CDS Report By A "..suspectSex.." Between "..suspectLocation.street1.." & "..suspectLocation.street2)
	else
	 TriggerClientEvent('dispatch:notify', -1, "CDS Report Of A "..suspectSex.." At "..suspectLocation.street1)
	end
	TriggerClientEvent('dispatch:cdsPos', -1, suspectLocation.pos)
end)

RegisterServerEvent('dispatch:robbery')
AddEventHandler('dispatch:robbery', function(suspectLocation, suspectSex)
	if suspectLocation.both then
	 TriggerClientEvent('dispatch:notify', -1, "Robbery of a Civillian By A "..suspectSex.." Between "..suspectLocation.street1.." & "..suspectLocation.street2)
	else
	 TriggerClientEvent('dispatch:notify', -1, "Robbery of a Civillian By A "..suspectSex.." At "..suspectLocation.street1)
	end
	TriggerClientEvent('dispatch:robberyPos', -1, suspectLocation.pos)
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

RegisterServerEvent('dispatch:hospital')
AddEventHandler('dispatch:hospital', function(suspectLocation, suspectSex)
	if suspectLocation.both then
	 TriggerClientEvent('dispatch:notify', -1, "Robbery of a Hospital By A "..suspectSex.." Between "..suspectLocation.street1.." & "..suspectLocation.street2)
	else
	 TriggerClientEvent('dispatch:notify', -1, "Robbery of a Hospital By A "..suspectSex.." At "..suspectLocation.street1)
	end
	TriggerClientEvent('dispatch:hospitalPos', -1, suspectLocation.pos)
end)