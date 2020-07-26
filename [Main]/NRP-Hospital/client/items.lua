local isInAnimation = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if isInAnimation then
            DisableControlAction(0, 245, true) -- T
            DisableControlAction(0, 73, true) -- X
            DisableControlAction(0, 168, true) -- F7
            DisableControlAction(0, 37, true) -- TAB
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
        end
    end
end)

RegisterNetEvent("NRP-hospital:items:gauze")
AddEventHandler("NRP-hospital:items:gauze", function(item)
    ExecuteCommand("e smallbag")
    isInAnimation = true
    exports['pogressBar']:drawBar(1500, 'Packing Wounds', function()
        TriggerEvent('NRP-hospital:client:RemoveBleed')
        isInAnimation = false
        ExecuteCommand("e c")
    end)
end)

RegisterNetEvent("ML:items:bandage")
AddEventHandler("ML:items:bandage", function(item)
    ExecuteCommand("e smallbag")
    isInAnimation = true
    exports['pogressBar']:drawBar(5000, 'Using Bandage', function()
        local maxHealth = GetEntityMaxHealth(PlayerPedId())
        local health = GetEntityHealth(PlayerPedId())
        local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 16))
        SetEntityHealth(PlayerPedId(), newHealth)
        isInAnimation = false
        ExecuteCommand("e c")
    end)
end)

RegisterNetEvent("NRP-hospital:items:firstaid")
AddEventHandler("NRP-hospital:items:firstaid", function(item)
    ExecuteCommand("e firstaid")
    isInAnimation = true
    exports['pogressBar']:drawBar(30000, 'Using Human Fixkit', function()
        SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(PlayerPedId()))
        TriggerEvent('NRP-hospital:client:RemoveBleed')
        TriggerEvent('NRP-hospital:client:ResetLimbs')
        isInAnimation = false
        ExecuteCommand("e c")
    end)
end)

RegisterNetEvent("ML:items:medkit")
AddEventHandler("ML:items:medkit", function(item)
    ExecuteCommand("e medkit")
    isInAnimation = true
    exports['pogressBar']:drawBar(20000, 'Using Medkit', function()
        SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(PlayerPedId()))
        TriggerEvent('NRP-hospital:client:FieldTreatLimbs')
        isInAnimation = false
        ExecuteCommand("e c")
    end)
end)

RegisterNetEvent("ML:items:vicodin")  ---- add use of
AddEventHandler("ML:items:vicodin", function(item)
    ExecuteCommand("e painkillers")
    isInAnimation = true
    exports['pogressBar']:drawBar(1000, 'Taking Painkillers', function()
        TriggerEvent('NRP-hospital:client:UsePainKiller', 1)
        isInAnimation = false
        ExecuteCommand("e c")
    end)
end)

RegisterNetEvent("ML:items:hydrocodone") ---- add use of drug
AddEventHandler("ML:items:hydrocodone", function(item)
    ExecuteCommand("e painkillers")
    isInAnimation = true
    exports['pogressBar']:drawBar(1000, 'Taking Strong Painkillers', function()
        TriggerEvent('NRP-hospital:client:UsePainKiller', 2)
        isInAnimation = false
        ExecuteCommand("e c")
    end)
end)

RegisterNetEvent("ML:items:morphine") ---- add use of morphine
AddEventHandler("ML:items:morphine", function(item)
    ExecuteCommand("e painkillers")
    isInAnimation = true
    exports['pogressBar']:drawBar(2000, 'Taking Morphine', function()
        TriggerEvent('NRP-hospital:client:UsePainKiller', 6)
        isInAnimation = false
        ExecuteCommand("e c")
    end)
end)