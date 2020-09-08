--[[local text1 = "Server will automatically restart in 15 minutes!"
local text2 = "Server will automatically restart in 10 minutes!"
local text3 = "Server will automatically restart in 5 minutes!"
local text4 = "Server will automatically restart now!"

RegisterServerEvent("restart:checkreboot")

AddEventHandler('restart:checkreboot', function()
	date_local1 = os.date('%H:%M:%S', os.time())
	local date_local = date_local1
	if date_local == '04:46:00' then
		TriggerClientEvent('chatMessage', -1, "ANNOUNCEMENT", {255, 0, 0}, "" .. text1)
	elseif date_local == '06:51:00' then
		TriggerClientEvent('chatMessage', -1, "ANNOUNCEMENT", {255, 0, 0}, "" .. text2)
	elseif date_local == '06:56:00' then
		TriggerClientEvent('chatMessage', -1, "ANNOUNCEMENT", {255, 0, 0}, "" .. text3)
	elseif date_local == '06:59:50' then
		TriggerClientEvent('chatMessage', -1, "ANNOUNCEMENT", {255, 0, 0}, "" .. text4)
		
	elseif date_local == '12:46:00' then
		TriggerClientEvent('chatMessage', -1, "ANNOUNCEMENT", {255, 0, 0}, "" .. text1)
	elseif date_local == '12:51:00' then
		TriggerClientEvent('chatMessage', -1, "ANNOUNCEMENT", {255, 0, 0}, "" .. text2)
	elseif date_local == '12:56:00' then
		TriggerClientEvent('chatMessage', -1, "ANNOUNCEMENT", {255, 0, 0}, "" .. text3)
	elseif date_local == '12:59:50' then
		TriggerClientEvent('chatMessage', -1, "ANNOUNCEMENT", {255, 0, 0}, "" .. text4)
		
	elseif date_local == '18:46:00' then
		TriggerClientEvent('chatMessage', -1, "ANNOUNCEMENT", {255, 0, 0}, "" .. text1)
	elseif date_local == '18:51:00' then
		TriggerClientEvent('chatMessage', -1, "ANNOUNCEMENT", {255, 0, 0}, "" .. text2)
	elseif date_local == '18:56:00' then
		TriggerClientEvent('chatMessage', -1, "ANNOUNCEMENT", {255, 0, 0}, "" .. text3)
	elseif date_local == '18:59:50' then
		TriggerClientEvent('chatMessage', -1, "ANNOUNCEMENT", {255, 0, 0}, "" .. text4)
		
	elseif date_local == '00:46:00' then
		TriggerClientEvent('chatMessage', -1, "ANNOUNCEMENT", {255, 0, 0}, text1)
	elseif date_local == '00:51:00' then
		TriggerClientEvent('chatMessage', -1, "ANNOUNCEMENT", {255, 0, 0}, text2)
	elseif date_local == '00:56:00' then
		TriggerClientEvent('chatMessage', -1, "ANNOUNCEMENT", {255, 0, 0}, text3)
	elseif date_local == '00:59:50' then
		TriggerClientEvent('chatMessage', -1, "ANNOUNCEMENT", {255, 0, 0}, text4)
	end
end)

function restart_server()
	SetTimeout(1000, function()
		TriggerEvent('restart:checkreboot')
		restart_server()
	end)
end
restart_server()]]--
