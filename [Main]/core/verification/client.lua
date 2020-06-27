------------------------------
-- Server Password, Made by --
--  FAXES & GlitchDetector  --
------------------------------

--- CONFIG ---
local attempts = 3 -- Amount of attempts a user can have

---------------------------------------------------------------------------------------------------------------
local passwordPending = true

function KeyboardInput(textEntry, inputText, maxLength) -- Thanks to Flatracer for the function.
    AddTextEntry('FMMC_KEY_TIP1', textEntry)
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", inputText, "", "", "", maxLength)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        return result
    else
        Citizen.Wait(500)
        return nil
    end
end

function drawText(text, x, y)
	local resx, resy = GetScreenResolution()
	SetTextFont(0)
	SetTextScale(0.8, 0.8)
	SetTextProportional(true)
	SetTextColour(41, 170, 226, 255)
	SetTextCentre(true)
	SetTextDropshadow(0, 0, 0, 0, 0)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText((float(x) / 1.5) / resx, ((float(y) - 6) / 1.5) / resy)
end

function float(num)
	num = num + 0.00001
	return num
end

Citizen.CreateThread(function()
    while passwordPending do
        Citizen.Wait(1)
        FreezeEntityPosition(GetPlayerPed(-1), true)
        DisableControlAction(2, 199, true)
        DisableControlAction(0, 25, true)
    end
end)
---------------------------------------------------------------------------------------------------------------

RegisterNetEvent("core:showPasswordPrompt")
AddEventHandler("core:showPasswordPrompt", function()
    local password = KeyboardInput("Enter Password (Discord.gg/ZaYvv4K to obtain) [" .. attempts .. "/3 left]", "", 30)
    attempts = attempts - 1
    TriggerServerEvent("core:checkPassword", password, attempts)
end)

RegisterNetEvent('core:PassedPassword')
AddEventHandler('core:PassedPassword', function()
    FreezeEntityPosition(GetPlayerPed(-1), false)
    passwordPending = false
    TriggerEvent('chatMessage', "^2Welcome to Nexus Roleplay!")
end)
-- A FaxDetector Project ;)