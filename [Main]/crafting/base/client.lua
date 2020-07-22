local inGUI = false
local recipies = {
    [1] = {id = 10, name = "1k Cash Stack", amount = 1, requirements = "1k Cash + 1 Rubber Bands", rep = 0},
    [2] = {id = 11, name = "5k Cash Stack", amount = 1, requirements = "5k Cash + 2 Rubber Bands", rep = 0},
    [3] = {id = 12, name = "10k Cash Stack", amount = 1, requirements = "10k Cash + 3 Rubber Bands", rep = 0},
    [4] = {id = 17, name = "1k Dirty Stack", amount = 1, requirements = "1k Dirty Cash + 1 Rubber Bands", rep = 0},
    [5] = {id = 16, name = "5k Dirty Stack", amount = 1, requirements = "5k Dirty Cash + 2 Rubber Bands", rep = 0},
    [6] = {id = 15, name = "10k Dirty Stack", amount = 1, requirements = "10k Dirty Cash + 3 Rubber Bands", rep = 0},
    [7] = {id = 19, name = "Snus", amount = 3, requirements = "1 x Water, 1 x Tobacco Leaf", rep = 0},
    [8] = {id = 8, name = "Blunt", amount = 2, requirements = "1 x Gram of Weed, 2 x Tobacco Leaf", rep = 0},
    [9] = {id = 7, name = "Grams of Weed", amount = 28, requirements = "1 x Bundle of Baggies, 1 x Oz of Weed , 1 x Digital Scales", rep = 0},
    [10] = {id = 13, name = "Grams of Crystal Meth", amount = 28, requirements = "1 x Oz of Crystal Meth, 1 x Bundle of Baggies, 1 x Digital Scales", rep = 500},
    [11] = {id = 4, name = "Ketone", amount = 1, requirements = "1 x Magnesium, 1 x Cyclopentyl, 1 x Chemistry Set, 1 x Bunson Burner", rep = 1000},
    [12] = {id = 6, name = "Grams of Ketamine", amount = 28, requirements = "1 x Oz of Ketamine, 1 x Bundle of Baggies, 1 x Digital Scales", rep = 1000},
    [13] = {id = 14, name = "Grams of Heroin", amount = 28, requirements = "1 x Oz of Heroin, 1 x Bundle of Baggies, 1 x Digital Scales", rep = 1500},
    [14] = {id = 1, name = "Grams of Cocaine", amount = 28, requirements = "1 x Oz of Cocaine, 1 x Bundle of Baggies, 1 x Digital Scales", rep = 2000},
    [15] = {id = 18, name = "C4 Bomb", amount = 1, requirements = "1 x Electrical Wire, 1 x Calculator, 1 x Tape, 1 x Wire Cutters", rep = 1500},
}

function EnableGui(enable, chars)
    SetNuiFocus(enable, enable)
    guiEnabled = enable
    inGUI = true
    SendNUIMessage({type = "enableui",  enable = enable, characters = chars})
end 

RegisterNetEvent("crafting:loadrecipies")
AddEventHandler("crafting:loadrecipies", function()
 local html = ''
 local rep = DecorGetInt(GetPlayerPed(-1), "Reputation")
 --local faction = DecorGetInt(GetPlayerPed(-1), "Faction")  --xzzurv test it
 if rep < 0 then
  rep = 0
 end
 for id,v in pairs(recipies) do
  if rep >= v.rep then
   local char = string.format('<div class="character" id="%s"><p>%s<span class="date">Crafts: %s</span></p><p>%s</p></div>', v.id, v.name, v.amount, tostring(v.requirements))
   html = html..char
  end
 end
 EnableGui(true, html)
end)

-- NUI Callback Events
RegisterNUICallback('selectrecipe', function(data, cb)
  EnableGui(false,false)
  cb('ok')
    TriggerEvent("mythic_progbar:client:progress", {
        name = "crafting_item",
        duration = 10000,
        label = "Crafting Item",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
    }, function(status)
        if not status then
          TriggerEvent('crafting:trigger:'..data.id)
          inGUI = false
        end
    end)
end)

RegisterNUICallback('escape', function(data, cb)
  _GuiEnabled = false
  SetNuiFocus(false, false)
  SendNUIMessage({open = false})
  inGUI = false
end)

Citizen.CreateThread(function()
  while true do
   Wait(1)
   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 153.926, -1006.835, -99.000, true) < 0.5 and not inGUI then
    DrawText3Ds(153.926, -1006.835, -99.000)
    if IsControlJustPressed(0, 38) then          --- aprtment
     TriggerEvent('crafting:loadrecipies')
    end
   end
  end
end)

Citizen.CreateThread(function()
  while true do
   Wait(1)
   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 339.678, -1000.252, -99.196, true) < 0.5 and not inGUI then
    DrawText3Ds(339.678, -1000.252, -99.196)
    if IsControlJustPressed(0, 38) then  ---- nice house
     TriggerEvent('crafting:loadrecipies')
    end
   end
  end
end)

Citizen.CreateThread(function()
  while true do
   Wait(1)
   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -175.16, 489.88, 130.043, true) < 0.5 and not inGUI then
    DrawText3Ds(-175.16, 489.88, 130.043)
    if IsControlJustPressed(0, 38) then -- ipl4
     TriggerEvent('crafting:loadrecipies')
    end
   end
  end
end)

Citizen.CreateThread(function()
  while true do
   Wait(1)
   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 379.185, 432.180, 138.300, true) < 0.5 and not inGUI then
    DrawText3Ds(379.185, 432.180, 138.300)
    if IsControlJustPressed(0, 38) then -- ipl6
     TriggerEvent('crafting:loadrecipies')
    end
   end
  end
end)

Citizen.CreateThread(function()
  while true do
   Wait(1)
   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 262.489, -999.887, -99.008, true) < 0.5 and not inGUI then
    DrawText3Ds(262.489, -999.887, -99.008)
    if IsControlJustPressed(0, 38) then -- ipl3 
     TriggerEvent('crafting:loadrecipies')
    end
   end
  end
end) 

Citizen.CreateThread(function()
  while true do
   Wait(1)
   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -798.679, 327.806, 217.038, true) < 0.5 and not inGUI then
    DrawText3Ds(-798.679, 327.806, 217.038)
    if IsControlJustPressed(0, 38) then -- iplapart1
     TriggerEvent('crafting:loadrecipies')
    end
   end
  end
end) 

function DrawText3Ds(x,y,z)
	local text = "~g~[E]~w~ Crafting Table"
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)

    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end



