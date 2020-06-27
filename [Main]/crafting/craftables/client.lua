--[[
    TriggerEvent("inventory:addQty", ITEMID, AMOUNT)
    TriggerEvent("inventory:removeQty", ITEMID, AMOUNT)
    exports['core']:GetItemQuantity(ITEMID) >= 1

    TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this item!")
    TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You have successfully crafted XX")

]]--

----------------------------------((((( CASH STACKS START)))))----------------------
-- Cash 10k
RegisterNetEvent("crafting:trigger:12")
AddEventHandler("crafting:trigger:12", function()
 if math.floor(exports['core']:getQuantity() + 1) > 120 then
    TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, " You do not have enough space for this.")
    return
 end
 if exports['core']:GetItemQuantity(155) >= 3 then
  TriggerServerEvent("NRP-M-Cashstacks-10k")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You have no rubber Bands!")
 end  
end)
-- cash 5k
RegisterNetEvent("crafting:trigger:11")
AddEventHandler("crafting:trigger:11", function()
    if math.floor(exports['core']:getQuantity() + 1) > 120 then
        TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, " You do not have enough space for this.")
        return
     end
 if exports['core']:GetItemQuantity(155) >= 2 then
  TriggerServerEvent("NRP-M-Cashstacks-5k")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You have no rubber Bands!")
 end  
end)
-- cash 1k
RegisterNetEvent("crafting:trigger:10")
AddEventHandler("crafting:trigger:10", function()
    if math.floor(exports['core']:getQuantity() + 1) > 120 then
        TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, " You do not have enough space for this.")
        return
     end
 if exports['core']:GetItemQuantity(155) >= 1 then
  TriggerServerEvent("NRP-M-Cashstacks-1k")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You have no rubber Bands!")
 end  
end)
-----------------------((((( CASH STACKS END )))))--------------------------------
RegisterNetEvent("crafting:trigger:15")
AddEventHandler("crafting:trigger:15", function()
    if math.floor(exports['core']:getQuantity() + 1) > 120 then
        TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, " You do not have enough space for this.")
        return
     end
 if exports['core']:GetItemQuantity(155) >= 3 then
  TriggerServerEvent("NRP-M-Dirtystacks-10k")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You have no rubber Bands!")
 end  
end)
-- cash 5k
RegisterNetEvent("crafting:trigger:16")
AddEventHandler("crafting:trigger:16", function()
    if math.floor(exports['core']:getQuantity() + 1) > 120 then
        TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, " You do not have enough space for this.")
        return
     end
 if exports['core']:GetItemQuantity(155) >= 2 then
  TriggerServerEvent("NRP-M-Dirtystacks-5k")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You have no rubber Bands!")
 end  
end)
-- cash 1k
RegisterNetEvent("crafting:trigger:17")
AddEventHandler("crafting:trigger:17", function()
    if math.floor(exports['core']:getQuantity() + 1) > 120 then
        TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, " You do not have enough space for this.")
        return
     end
 if exports['core']:GetItemQuantity(155) >= 1 then
  TriggerServerEvent("NRP-M-Dirtystacks-1k")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You have no rubber Bands!")
 end  
end)


--------------------------------------((((( DRUGS )))))------------------------------
-- Bar of Cocaine > 9 x Oz of Cocaine
--[[RegisterNetEvent("crafting:trigger:2")
AddEventHandler("crafting:trigger:2", function()
 if exports['core']:GetItemQuantity(108) >= 1 and exports['core']:GetItemQuantity(112) >= 1 then
  TriggerEvent("inventory:removeQty", 108, 1)
  TriggerEvent("inventory:addQty", 109, 9)
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You have successfully crafted 9x Oz of Cocaine")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this item!")
 end
end)

-- Oz of Cocaine > 28 x Grams of Cocaine
RegisterNetEvent("crafting:trigger:3")
AddEventHandler("crafting:trigger:3", function()
 if exports['core']:GetItemQuantity(109) >= 1 and exports['core']:GetItemQuantity(113) >= 1 then
  TriggerEvent("inventory:removeQty", 109, 1)
  TriggerEvent("inventory:addQty", 110, 28)
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You have successfully crafted 28x Gram of Cocaine")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this item!")
 end
end)--]]

RegisterNetEvent("crafting:trigger:1")
AddEventHandler("crafting:trigger:1", function()
    if math.floor(exports['core']:getQuantity() + 28) > 120 then
        TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, " You do not have enough space for this.")
        return
     end
 if exports['core']:GetItemQuantity(109) >= 1 and exports['core']:GetItemQuantity(119) >= 1 and exports['core']:GetItemQuantity(113) >= 1 then
  TriggerEvent("inventory:removeQty", 109, 1)
  TriggerEvent("inventory:removeQty", 119, 1)
  TriggerEvent("inventory:addQty", 110, 28)
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You have successfully crafted 28 Grams of Cocaine")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this")
 end
end)


-- bar of wedd
RegisterNetEvent("crafting:trigger:2")
AddEventHandler("crafting:trigger:2", function()
    if math.floor(exports['core']:getQuantity() + 4) > 120 then
        TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, " You do not have enough space for this.")
        return
     end
 if exports['core']:GetItemQuantity(108) >= 1 and exports['core']:GetItemQuantity(136) >= 1 and exports['core']:GetItemQuantity(113) >= 1 then
  TriggerEvent("inventory:removeQty", 108, 1)
  TriggerEvent("inventory:removeQty", 136, 1)
  TriggerEvent("inventory:addQty", 138, 4)
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You have successfully crafted 4x Bar of Weed")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this item!")
 end
end)

-- oz of weed
RegisterNetEvent("crafting:trigger:3")
AddEventHandler("crafting:trigger:3", function()
    if math.floor(exports['core']:getQuantity() + 9) > 120 then
        TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, " You do not have enough space for this.")
        return
     end
 if exports['core']:GetItemQuantity(138) >= 1 and exports['core']:GetItemQuantity(137) >= 1 and exports['core']:GetItemQuantity(113) >= 1 then
  TriggerEvent("inventory:removeQty", 138, 1)
  TriggerEvent("inventory:removeQty", 137, 1)
  TriggerEvent("inventory:addQty", 120, 9)
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You have successfully crafted 9x Oz of Weed")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this item!")
 end
end)

RegisterNetEvent("crafting:trigger:4") --- xzurv ketamine
AddEventHandler("crafting:trigger:4", function()
    if math.floor(exports['core']:getQuantity() + 1) > 120 then
        TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, " You do not have enough space for this.")
        return
     end
 if exports['core']:GetItemQuantity(17) >= 1 and exports['core']:GetItemQuantity(18) >= 1 and exports['core']:GetItemQuantity(48) >= 1 and exports['core']:GetItemQuantity(47) >= 1 then
  TriggerEvent("inventory:removeQty", 17, 1)
  TriggerEvent("inventory:removeQty", 18, 1)
  TriggerEvent("inventory:addQty", 19, 1)
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You have combined your ingredients and made ketone")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to use your chemistry set!")
 end
end)

--ketone x liquid methlamine > 1 x Oz of Ketamine
RegisterNetEvent("crafting:trigger:5")              -- ketamine
AddEventHandler("crafting:trigger:5", function()
    if math.floor(exports['core']:getQuantity() + 1) > 120 then
        TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, " You do not have enough space for this.")
        return
     end
 if exports['core']:GetItemQuantity(19) >= 1 and exports['core']:GetItemQuantity(20) >= 1 and exports['core']:GetItemQuantity(47) >= 1  and exports['core']:GetItemQuantity(48) >= 1 then
  TriggerEvent("inventory:removeQty", 19, 1)
  TriggerEvent("inventory:removeQty", 20, 1) 
  TriggerEvent("inventory:addQty", 49, 1)
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You have successfully crafted 1 x Oz of Ketamine")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this item!")
 end
end)
--1 x Oz of Ketamine -- 28  x grams
RegisterNetEvent("crafting:trigger:6")              -- ketamine
AddEventHandler("crafting:trigger:6", function()
    if math.floor(exports['core']:getQuantity() + 28) > 120 then
        TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, " You do not have enough space for this.")
        return
     end
 if exports['core']:GetItemQuantity(49) >= 1 and exports['core']:GetItemQuantity(119) >= 1 and exports['core']:GetItemQuantity(113) >= 1 then
  TriggerEvent("inventory:removeQty", 49, 1)
  TriggerEvent("inventory:removeQty", 119, 1) 
  TriggerEvent("inventory:addQty", 50, 28)
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You have successfully crafted an 28 x Gram of Ketamine")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this item!")
 end
end)

-- Oz of Weed > 28 x Bags of Weed
RegisterNetEvent("crafting:trigger:7")
AddEventHandler("crafting:trigger:7", function()
    if math.floor(exports['core']:getQuantity() + 28) > 120 then
        TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, " You do not have enough space for this.")
        return
     end
 if exports['core']:GetItemQuantity(119) >= 1 and exports['core']:GetItemQuantity(120) >= 1 and exports['core']:GetItemQuantity(113) >= 1 then
  TriggerEvent("inventory:removeQty", 119, 1)
  TriggerEvent("inventory:removeQty", 120, 1)
  TriggerEvent("inventory:addQty", 121, 28)
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You have successfully crafted 28x Gram of Weed")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this item!")
 end
end)

-- 2 Blunts
RegisterNetEvent("crafting:trigger:8")
AddEventHandler("crafting:trigger:8", function()
    if math.floor(exports['core']:getQuantity() + 2) > 120 then
        TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, " You do not have enough space for this.")
        return
     end
 if exports['core']:GetItemQuantity(121) >= 1 and exports['core']:GetItemQuantity(122) >= 2 then
  TriggerEvent("inventory:removeQty", 121, 1)
  TriggerEvent("inventory:removeQty", 122, 2)
  TriggerEvent("inventory:addQty", 123, 2)
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You have successfully crafted 2x Blunt")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this item!")
 end
end)

-- 4 Spliffs
--[[RegisterNetEvent("crafting:trigger:9")
AddEventHandler("crafting:trigger:9", function()
 if exports['core']:GetItemQuantity(121) >= 1 and exports['core']:GetItemQuantity(15) >= 1 and exports['core']:GetItemQuantity(125) >= 1 then
  TriggerEvent("inventory:removeQty", 121, 1)
  TriggerEvent("inventory:removeQty", 15, 1)
  TriggerEvent("inventory:removeQty", 125, 1)
  TriggerEvent("inventory:addQty", 124, 4)
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You have successfully crafted 4x Spliff")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this item!")
 end
end)]]--


RegisterNetEvent("crafting:trigger:13")
AddEventHandler("crafting:trigger:13", function()
    if math.floor(exports['core']:getQuantity() + 28) > 120 then
        TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, " You do not have enough space for this.")
        return
     end
 if exports['core']:GetItemQuantity(156) >= 1 and exports['core']:GetItemQuantity(119) >= 1 and exports['core']:GetItemQuantity(113) >= 1 then
  TriggerEvent("inventory:removeQty", 156, 1)
  TriggerEvent("inventory:removeQty", 119, 1)
  TriggerEvent("inventory:addQty", 157, 28)
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You have successfully crafted 28 Grams of Crystal Meth")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this")
 end
end)

RegisterNetEvent("crafting:trigger:14")
AddEventHandler("crafting:trigger:14", function()
    if math.floor(exports['core']:getQuantity() + 28) > 120 then
        TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, " You do not have enough space for this.")
        return
     end
 if exports['core']:GetItemQuantity(31) >= 1 and exports['core']:GetItemQuantity(119) >= 1 and exports['core']:GetItemQuantity(113) >= 1 then
  TriggerEvent("inventory:removeQty", 31, 1)
  TriggerEvent("inventory:removeQty", 119, 1)
  TriggerEvent("inventory:addQty", 159, 28)
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You have successfully crafted 28 Grams of Heroin")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this")
 end
end)
-- Bomb
RegisterNetEvent("crafting:trigger:18")
AddEventHandler("crafting:trigger:18", function()
    if math.floor(exports['core']:getQuantity() + 1) > 120 then
        TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, " You do not have enough space for this.")
        return
     end
 if exports['core']:GetItemQuantity(75) >= 1 and exports['core']:GetItemQuantity(55) >= 1 and exports['core']:GetItemQuantity(275) >= 1 and exports['core']:GetItemQuantity(46) >= 1 and exports['core']:GetItemQuantity(276) >= 1 then
  TriggerEvent("inventory:removeQty", 55, 1)
  TriggerEvent("inventory:removeQty", 275, 1)
  TriggerEvent("inventory:removeQty", 46, 1)
  TriggerEvent("inventory:removeQty", 276, 1)
  TriggerEvent("inventory:addQty", 274, 1)
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You have successfully crafted a C4 Bomb")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this")
 end
end)
-- Snus
RegisterNetEvent("crafting:trigger:19")
AddEventHandler("crafting:trigger:19", function()
    if math.floor(exports['core']:getQuantity() + 3) > 120 then
        TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, " You do not have enough space for this.")
        return
     end
 if exports['core']:GetItemQuantity(122) >= 1 and exports['core']:GetItemQuantity(13) >= 1 then
  TriggerEvent("inventory:removeQty", 122, 1)
  TriggerEvent("inventory:removeQty", 13, 1)
  TriggerEvent("inventory:addQty", 299, 3)
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You have successfully crafted 3x Snus")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this")
 end
end)
--[[RegisterNetEvent("crafting:trigger:4")
AddEventHandler("crafting:trigger:4", function()
 if exports['core']:GetItemQuantity(114) >= 1 and exports['core']:GetItemQuantity(115) >= 1 and exports['core']:GetItemQuantity(116) >= 1 and exports['core']:GetItemQuantity(117) >= 1 then
  TriggerEvent("inventory:removeQty", 114, 1)
  TriggerEvent("inventory:removeQty", 115, 1)
  TriggerEvent("inventory:removeQty", 116, 1)
  TriggerEvent("inventory:removeQty", 117, 1)  
  TriggerServerEvent('blackmarket:addWeapon', 'WEAPON_SNSPISTOL', 'SNS Pistol')
  TriggerEvent('chatMessage', "SUCCESS", {0, 173, 66}, "You have successfully crafted 1x SNS Pistol")
 else
  TriggerEvent('chatMessage', "ERROR", {255, 28, 28}, "You do not have the correct materials to craft this item!")
 end
end)]]--