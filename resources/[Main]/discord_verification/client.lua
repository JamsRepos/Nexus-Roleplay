local controls = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,  
28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,53,5,
4,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,  
79,80,81,82,85,86,87,88,89,90,91,92,93,95,96,97,98,99,100,101,102,103,105,  
107,108,109,110,111,112,113,114,115,116,117,118,119,123,126,129,130,131,132,  
133,134,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,  
153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,171,172  
,177,187,188,189,190,195,196,199,200,201,202,203,205,207,208,209,211,212,213, 217,219,220,221,225,226,230,234,235,236,237,238,239,240,241,242,243,244,257,  
261,262,263,264,265,270,271,272,273,274,278,279,280,281,282,283,284,285,286,  
287,288,289,337}

local blocked = false
function toggleBlocked(flag)
	blocked = flag
end

Citizen.CreateThread(function()
	while blocked do
		Citizen.Wait(0)
		for i in ipairs(controls) do
			DisableControlAction(0,i,true)
		end
	end
end)

RegisterNetEvent('SkayVerifier:clientCheck')
AddEventHandler('SkayVerifier:clientCheck', function()
	TriggerServerEvent('SkayVerifier:checkPlayer')
end)

RegisterNUICallback('checkCode', function(data, cb)
	TriggerServerEvent('SkayVerifier:checkCode', data.code)
    cb('ok')
end)

RegisterNetEvent('SkayVerifier:toggleChecker')
AddEventHandler('SkayVerifier:toggleChecker', function(toggle)
	ToggleChecker(toggle)
	toggleBlocked(toggle)
end)

RegisterNetEvent('SkayVerifier:giveError')
AddEventHandler('SkayVerifier:giveError', function(toggle)
	giveError(toggle)
end)


RegisterCommand('test', function()
	TriggerServerEvent('SkayVerifier:checkPlayer')
end)

RegisterCommand('testFalse', function()
	TriggerServerEvent('SkayVerifier:giveFalse')
end)

function ToggleChecker(toggle)
	SendNUIMessage({
		type = "ToggleChecker",
		toggle = toggle
	})
	if(toggle) then
		TriggerScreenblurFadeIn(5000)
		AnimpostfxPlay("DrugsMichaelAliensFight", 1000, true)
		SetNuiFocus(true, true)
	end
	if(toggle == false) then
		TriggerScreenblurFadeOut(5000)
		AnimpostfxStop("DrugsMichaelAliensFight")
		SetNuiFocus(false, false)
	end
end

function giveError(int)
	SendNUIMessage({
		type = "TriggerError",
		count = int
	})
end