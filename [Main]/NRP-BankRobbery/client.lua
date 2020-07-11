local holdingup = false
local vault = false
local vault2 = false
local vault3 = false
local vault4 = false
local vault5 = false
local vault6 = false
local vault7 = false
local vault8 = false
local vault9 = false
local vault10 = false
local hackholdingup = false
local bombholdingup = false
local ForgeLife = false
local bank = ""
local savedbank = {}
local secondsRemaining = 0
local dooropen = false
local platingbomb = false
local platingbombtime = 20
local blipRobbery = nil
local currentPolice = 0
globalcoords = nil
globalrotation = nil
globalDoortype = nil
globalbombcoords = nil
globalbombrotation = nil
globalbombDoortype = nil
function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end
function xzbigprize()
	local easywin = math.random(1,12) 
	local moneybags = math.random(1,250)
	local ring = math.random(1,25)
	local necklace = math.random(1,5)
	local terry = math.random(1,7)
	local wick = math.random(0,3)
	local john = math.random(1,5)
	local brad = math.random(1,10)
	if random == 1 then    
	  exports['NRP-notify']:DoHudText('error', 'You Got Nothing')
	 elseif easywin == 2 then
	  exports['NRP-notify']:DoHudText('success', "You Stole a Set of "..terry.." Rolex's !")
	  TriggerEvent("inventory:addQty", 67, terry )
	 elseif easywin == 3 then    
	 exports['NRP-notify']:DoHudText('error', 'You Got Nothing')
	 elseif easywin == 4 then
	  exports['NRP-notify']:DoHudText('error', 'You Got Nothing')
	 elseif easywin == 5 then
	  exports['NRP-notify']:DoHudText('error', 'You Suck At This, Empty Handed')
	 elseif easywin == 6 then
	  exports['NRP-notify']:DoHudText('inform', 'You Stole '..wick..' 10k Cash Stacks!')
	  TriggerEvent("inventory:addQty", 152, wick )
	 elseif easywin == 7 then
	  exports['NRP-notify']:DoHudText('success', "You Grabbed "..necklace.." Diamond Necklaces and "..ring.." Gold Rings!!")
	  TriggerEvent("inventory:addQty", 127, necklace )
	  TriggerEvent("inventory:addQty", 128, ring )
	 elseif easywin == 8 then    
	  exports['NRP-notify']:DoHudText('error', 'You Got Nothing')
	 elseif easywin == 9 then
	  exports['NRP-notify']:DoHudText('success', 'You Stole '..john..' 5k Cash Stacks!')
	  TriggerEvent("inventory:addQty", 153, john )
	 elseif easywin == 10 then    
	  exports['NRP-notify']:DoHudText('error', 'You Got Nothing')
	 elseif easywin == 11 then  
	  exports['NRP-notify']:DoHudText('success', 'You Stole '..brad..' 1k Cash Stacks!')
	  TriggerEvent("inventory:addQty", 154, brad )
	 elseif easywin == 12 then    
	  exports['NRP-notify']:DoHudText('error', 'You Suck At This, Empty Handed')
	end
	if moneybags == 69 then
	  exports['NRP-notify']:DoHudText('success', 'Just hit the jackpot lets go!!')
	  TriggerEvent("inventory:addQty", 142, 1)
	 elseif moneybags == 10 or moneybags == 40 or moneybags == 80 or moneybags == 120 or moneybags == 140 or moneybags == 180 then
	  exports['NRP-notify']:DoHudText('success', 'Damn a Bar of Gold!!')
	  TriggerEvent("inventory:addQty", 133, 1)
	end		
end

function xzprize()
	local easywin = math.random(1,11) 
	local ring = math.random(1,10)
	local necklace = math.random(1,2)
	local terry = math.random(1,3)
	local wick = math.random(0,1)
	local john = math.random(1,3)
	local brad = math.random(1,5)
	if random == 1 then    
	  exports['NRP-notify']:DoHudText('error', 'You Got Nothing')
	 elseif easywin == 2 then
	  exports['NRP-notify']:DoHudText('success', "You Stole a Set of "..terry.." Rolex's !")
	  TriggerEvent("inventory:addQty", 67, terry )
	 elseif easywin == 3 then    
	 exports['NRP-notify']:DoHudText('error', 'You Got Nothing')
	 elseif easywin == 4 then
	  exports['NRP-notify']:DoHudText('error', 'You Got Nothing')
	 elseif easywin == 5 then
	  exports['NRP-notify']:DoHudText('inform', 'You Stole'..wick..' 10k Cash Stacks!')
	  TriggerEvent("inventory:addQty", 152, wick )
	 elseif easywin == 6 then
	  exports['NRP-notify']:DoHudText('success', "You Grabbed "..necklace.." Diamond Necklaces and "..ring.." Gold Rings!!")
	  TriggerEvent("inventory:addQty", 127, necklace )
	  TriggerEvent("inventory:addQty", 128, ring )
	 elseif easywin == 7 then    
	  exports['NRP-notify']:DoHudText('error', 'You Got Nothing')
	 elseif easywin == 8 then
	  exports['NRP-notify']:DoHudText('success', 'You Stole'..john..' 5k Cash Stacks!')
	  TriggerEvent("inventory:addQty", 153, john )
	 elseif easywin == 9 then    
		exports['NRP-notify']:DoHudText('error', 'You Got Nothing')
	 elseif easywin == 10 then  
	  exports['NRP-notify']:DoHudText('success', 'You Stole'..brad..' 1k Cash Stacks!')
	  TriggerEvent("inventory:addQty", 154, brad )
	 elseif easywin == 11 then    
	  exports['NRP-notify']:DoHudText('error', 'You Suck At This, Empty Handed')
	end	
end


RegisterNetEvent('hud:updatepresence')
AddEventHandler('hud:updatepresence', function(copss)
 currentPolice = copss
end)
RegisterNetEvent('NRP-holdupbank:currentlyrobbing')
AddEventHandler('NRP-holdupbank:currentlyrobbing', function(robb)
	holdingup = true
	bank = robb
	secondsRemaining = 300
end)
RegisterNetEvent('NRP-holdupbank:plantingbomb')
AddEventHandler('NRP-holdupbank:plantingbomb', function(robb, thisbank)
 bombholdingup = true
 exports['NRP-notify']:DoHudText('success', 'Planting Bomb')
 savedbank = thisbank
 bank = robb
 plantBombAnimation()
end)
RegisterNetEvent('NRP-holdupbank:success')
AddEventHandler('NRP-holdupbank:success', function(robb, thisbank)
 xzurv()
end)
RegisterNetEvent('NRP-holdupbank:fail')
AddEventHandler('NRP-holdupbank:fail', function(robb, thisbank)
 jaybee()
end)
RegisterNetEvent('NRP-holdupbank:currentlyhacking')
AddEventHandler('NRP-holdupbank:currentlyhacking', function(robb, thisbank)
	savedbank = thisbank
	bank = robb
end)
function xzurv()
  TriggerEvent('mhacking:hide')
  TriggerEvent('NRP-holdupbank:hackcomplete')
  hackholdingup = true
  
end
function jaybee() 
	hackholdingup = false
	TriggerServerEvent('NRP-holdupbank:hackfail')
	TriggerEvent('mhacking:hide')
	incircle = false
	TriggerEvent("inventory:removeQty", 272, 1)
	TriggerEvent("inventory:addQty", 273, 1)
end
RegisterNetEvent('NRP-holdupbank:killblip')
AddEventHandler('NRP-holdupbank:killblip', function()
    RemoveBlip(blipRobbery)
end)
RegisterNetEvent('NRP-holdupbank:setblip')
AddEventHandler('NRP-holdupbank:setblip', function(position)
    blipRobbery = AddBlipForCoord(position.x, position.y, position.z)
    SetBlipSprite(blipRobbery , 161)
    SetBlipScale(blipRobbery , 2.0)
    SetBlipColour(blipRobbery, 3)
    PulseBlip(blipRobbery)
end)
RegisterNetEvent('NRP-holdupbank:toofarlocal')
AddEventHandler('NRP-holdupbank:toofarlocal', function(robb)
	holdingup = false
	bombholdingup = false
	robbingName = ""
	secondsRemaining = 0
	incircle = false
end)
RegisterNetEvent('NRP-holdupbank:toofarlocalhack')
AddEventHandler('NRP-holdupbank:toofarlocalhack', function(robb)
	holdingup = false
	robbingName = ""
	secondsRemaining = 0
	incircle = false
end)
RegisterNetEvent('NRP-holdupbank:closedoor')
AddEventHandler('NRP-holdupbank:closedoor', function()
	dooropen = false
end)
RegisterNetEvent('NRP-holdupbank:robberycomplete')
AddEventHandler('NRP-holdupbank:robberycomplete', function(robb)
	holdingup = false
	exports['NRP-notify']:DoHudText('success', 'Robbery Complete You Manage To Rob $ ' .. Banks[bank].reward .. ' + The Items You Stole')
	bank = ""
	TriggerServerEvent('NRP-holdupbank:closedoor')
	secondsRemaining = 0
	dooropen = false
	incircle = false
end)
RegisterNetEvent('NRP-holdupbank:hackcomplete')
AddEventHandler('NRP-holdupbank:hackcomplete', function()
 exports['NRP-notify']:DoHudText('success', 'Hack Complete')
 bank = ""
 incircle = false
end)
RegisterNetEvent('NRP-holdupbank:plantbombcomplete')
AddEventHandler('NRP-holdupbank:plantbombcomplete', function(bank)
 bombholdingup = false
 hackholdingup = false
 ForgeLife = true
 exports['NRP-notify']:DoHudText('inform', 'Bomb Planted RUN!')
 TriggerServerEvent('NRP-holdupbank:plantbombtoall', bank.bombposition.x,  bank.bombposition.y, bank.bombposition.z, bank.bombdoortype)
 incircle = false
end)
RegisterNetEvent('NRP-holdupbank:plantedbomb')
AddEventHandler('NRP-holdupbank:plantedbomb', function(x,y,z,doortype)
	local coords = {x,y,z}
	local myCoords = GetEntityCoords(GetPlayerPed(-1))
	local obs, distance = GetClosestObjectOfType(myCoords.x, myCoords.y, myCoords.z, 15.0, doortype)
    AddExplosion( x,  y, z , 0, 0.5, 1, 0, 1065353216, 0)
    AddExplosion( x,  y, z , 0, 0.5, 1, 0, 1065353216, 0)
	local rotation = GetEntityHeading(obs) - 85.2869
	SetEntityHeading(obs,rotation)
	globalbombcoords = coords
	globalbombrotation = rotation
	globalbombDoortype = doortype
	Citizen.CreateThread(function()
		while dooropen do
			Wait(2000)
			local obs, distance = GetClosestObjectOfType(myCoords.x, myCoords.y, myCoords.z, 15.0, globalbombDoortype)
			SetEntityHeading(obs, globalbombrotation)
		end 
	end)       
end)         

RegisterNetEvent('NRP-holdupbank:opendoors')
AddEventHandler('NRP-holdupbank:opendoors', function(x,y,z,doortype)
	dooropen = true;
	print("door opening")
	local myCoords = GetEntityCoords(GetPlayerPed(-1))
	local coords = {x,y,z}
	local obs, distance = GetClosestObjectOfType(myCoords.x, myCoords.y, myCoords.z, 1.5,'hei_v_ilev_bk_gate2_pris')
	local pos = GetEntityCoords(obs);
	local rotation = GetEntityHeading(obs) + 70
	globalcoords = coords
	globalrotation = rotation
	globalDoortype = doortype
	Citizen.CreateThread(function()
	while dooropen do
		Wait(2000)
		local obs, distance = GetClosestObjectOfType(myCoords.x, myCoords.y, myCoords.z, 1.5, globalDoortype)
		SetEntityHeading(obs, globalrotation)
	end
	exports['NRP-notify']:DoHudText('inform', 'Door Open!!')
	end)
end)



RegisterNetEvent('NRP-holdupbank:exit')
AddEventHandler('NRP-holdupbank:exit', function(bank)
	SetEntityCoordsNoOffset(GetPlayerPed(-1), bank.hackposition.x , bank.hackposition.y, bank.hackposition.z, 0, 0, 1)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if holdingup then
			Citizen.Wait(1000)
			if(secondsRemaining > 0)then
				secondsRemaining = secondsRemaining - 1
			end
		end
	end
end)

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

Citizen.CreateThread(function()
	while true do
	 Citizen.Wait(5)
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
		for k,v in pairs(Banks)do
		 if currentPolice >= 5 then
			local pos2 = v.position
			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 15.0)then
			  if ForgeLife then
				if not holdingup then
					if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 1.0)then
						if (incircle == false) then
						end
					    incircle = true
						DrawText3Ds(v.position.x, v.position.y, v.position.z,'~g~[E]~w~ Start Robbing')
						  if IsControlJustReleased(1, 51) then
							if exports['core']:GetItemQuantity(217) >= 1 then
							 TriggerServerEvent('NRP-holdupbank:rob', k)
							else	 
								exports['NRP-notify']:DoHudText('error', 'How you plan on opening the vault boxes without any tools?! maybe grab a crowbar?!')
								TriggerServerEvent('NRP-holdupbank:robfail')	 
							end		
						end
					elseif(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 1.0)then
						incircle = false
					end
				end
		 	  end	
			end
		 end
		 local pos3 = {x= 264.08908752441, y = 212.11188, z = 101.6802482605}
		 local position2 = {x= 264.08908752441, y = 212.11188, z = 101.6802482605}
			if(Vdist(pos.x, pos.y, pos.z, pos3.x, pos3.y, pos3.z) < 1.5)then
				if holdingup and (vault == false) then
					if(Vdist(pos.x, pos.y, pos.z, pos3.x, pos3.y, pos3.z) < 1.0) then
						if (incircle == false) then
							DrawText3Ds(position2.x, position2.y, position2.z,'~g~[E]~w~ Rob Vault')
						end
						incircle = true
						if exports['core']:GetItemQuantity(217) >= 1 then
						    if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
                                if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
                                 RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
                                 Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist") 
                                
                                loadAnimDict( "anim@heists@fleeca_bank@drilling" ) 
                                TaskPlayAnim( player, "anim@heists@fleeca_bank@drilling", "intro",8.0, 1.0, -1, 2, 0, 0, 0, 0 )                  
                                Wait(8000)
                                TaskPlayAnim( player, "anim@heists@fleeca_bank@drilling", "outro",8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
                                DrawSubtitleTimed(5000, 1)
                                Citizen.Wait(7000)
                                ClearPedTasksImmediately(GetPlayerPed(-1))
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1) 
								vault = true
								xzprize()								
							  end 
						end
					elseif(Vdist(pos.x, pos.y, pos.z, pos3.x, pos3.y, pos3.z) > 1.0)then
						incircle = false
					end
				end
			end
			local pos4 = {x= 262.55708752441, y = 212.967188, z = 101.6802482605}
		    local position3 = {x= 262.55708752441, y = 212.967188, z = 101.6802482605}
			if(Vdist(pos.x, pos.y, pos.z, pos4.x, pos4.y, pos4.z) < 1.5)then
				if holdingup and (vault2 == false) then
					if(Vdist(pos.x, pos.y, pos.z, pos4.x, pos4.y, pos4.z) < 1.0)then
						if (incircle == false) then
							DrawText3Ds(position3.x, position3.y, position3.z,'~g~[E]~w~ Rob Vault')
						end
						incircle = true
						if exports['core']:GetItemQuantity(217) >= 1 then
						    if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
                                if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
                                 RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
                                 Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist") 
                                
                                loadAnimDict( "anim@heists@fleeca_bank@drilling" ) 
                                TaskPlayAnim( player, "anim@heists@fleeca_bank@drilling", "intro",8.0, 1.0, -1, 2, 0, 0, 0, 0 )                  
                                Wait(8000)
                                TaskPlayAnim( player, "anim@heists@fleeca_bank@drilling", "outro",8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
                                DrawSubtitleTimed(5000, 1)
                                Citizen.Wait(7000)
                                ClearPedTasksImmediately(GetPlayerPed(-1))
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
								vault2 = true
								xzprize()
							  end 
						end
					elseif(Vdist(pos.x, pos.y, pos.z, pos4.x, pos4.y, pos4.z) > 1.0)then
						incircle = false
					end
				end
			end
			local pos5 = {x= 265.45708752441, y = 215.697188, z = 101.6802482605}
		    local position4 = {x= 265.45708752441, y = 215.697188, z = 101.6802482605}
			if(Vdist(pos.x, pos.y, pos.z, pos5.x, pos5.y, pos5.z) < 1.5)then
				if holdingup and (vault3 == false) then
					if(Vdist(pos.x, pos.y, pos.z, pos5.x, pos5.y, pos5.z) < 1.0)then
						if (incircle == false) then
							DrawText3Ds(position4.x, position4.y, position4.z,'~g~[E]~w~ Rob Vault')
						end
						incircle = true
						if exports['core']:GetItemQuantity(217) >= 1 then
						    if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
                                if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
                                 RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
                                 Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist") 
                                
                                loadAnimDict( "anim@heists@fleeca_bank@drilling" ) 
                                TaskPlayAnim( player, "anim@heists@fleeca_bank@drilling", "intro",8.0, 1.0, -1, 2, 0, 0, 0, 0 )                  
                                Wait(8000)
                                TaskPlayAnim( player, "anim@heists@fleeca_bank@drilling", "outro",8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
                                DrawSubtitleTimed(5000, 1)
                                Citizen.Wait(7000)
                                ClearPedTasksImmediately(GetPlayerPed(-1))
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
								vault3 = true
								vault4 = false
								xzprize()
							  end 
						end
					elseif(Vdist(pos.x, pos.y, pos.z, pos5.x, pos5.y, pos5.z) > 1.0)then
						incircle = false
					end
				end
			end
			local pos6 = {x= 261.05708752441, y = 217.967188, z = 101.6802482605}
		    local position5 = {x= 261.05708752441, y = 217.967188, z = 101.6802482605}	
			if(Vdist(pos.x, pos.y, pos.z, pos6.x, pos6.y, pos6.z) < 1.5)then
				if holdingup and (vault4 == false) then
					if(Vdist(pos.x, pos.y, pos.z, pos6.x, pos6.y, pos6.z) < 1.0)then
						if (incircle == false) then
							DrawText3Ds(position5.x, position5.y, position5.z,'~g~[E]~w~ Rob Vault')
						end
						incircle = true
						if exports['core']:GetItemQuantity(217) >= 1 then
						    if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
                                if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
                                 RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
                                 Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist") 
                                
                                loadAnimDict( "anim@heists@fleeca_bank@drilling" ) 
                                TaskPlayAnim( player, "anim@heists@fleeca_bank@drilling", "intro",8.0, 1.0, -1, 2, 0, 0, 0, 0 )                  
                                Wait(8000)
                                TaskPlayAnim( player, "anim@heists@fleeca_bank@drilling", "outro",8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
                                DrawSubtitleTimed(5000, 1)
                                Citizen.Wait(7000)
                                ClearPedTasksImmediately(GetPlayerPed(-1))
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
								vault4 = true
								xzprize()
							  end 
						end
					elseif(Vdist(pos.x, pos.y, pos.z, pos6.x, pos6.y, pos6.z) > 1.0)then
						incircle = false
					end
				end
			end
			local pos7 = {x= 259.05708752441, y = 217.877188, z = 101.6802482605}
		    local position6 = {x= 259.05708752441, y = 217.877188, z = 101.6802482605}
			if(Vdist(pos.x, pos.y, pos.z, pos7.x, pos7.y, pos7.z) < 1.5)then
				if holdingup and (vault5 == false) then
					if(Vdist(pos.x, pos.y, pos.z, pos7.x, pos7.y, pos7.z) < 1.0)then
						if (incircle == false) then
							DrawText3Ds(position6.x, position6.y, position6.z,'~g~[E]~w~ Rob Vault')
						end
						incircle = true
						if exports['core']:GetItemQuantity(217) >= 1 then
						    if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
                                if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
                                 RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
                                 Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist") 
                                
                                loadAnimDict( "anim@heists@fleeca_bank@drilling" ) 
                                TaskPlayAnim( player, "anim@heists@fleeca_bank@drilling", "intro",8.0, 1.0, -1, 2, 0, 0, 0, 0 )                  
                                Wait(8000)
                                TaskPlayAnim( player, "anim@heists@fleeca_bank@drilling", "outro",8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
                                DrawSubtitleTimed(5000, 1)
                                Citizen.Wait(7000)
                                ClearPedTasksImmediately(GetPlayerPed(-1))
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
								vault5 = true
								xzprize()
							  end 

						end
					elseif(Vdist(pos.x, pos.y, pos.z, pos7.x, pos7.y, pos7.z) > 1.0)then
						incircle = false
					end
				end
			end
			local pos8 = {x= 259.55708752441, y = 213.867188, z = 101.6802482605}
		    local position7 = {x= 259.55708752441, y = 213.867188, z = 101.6802482605}
			if(Vdist(pos.x, pos.y, pos.z, pos8.x, pos8.y, pos8.z) < 1.5)then
				if holdingup and (vault6 == false) then
					if(Vdist(pos.x, pos.y, pos.z, pos8.x, pos8.y, pos8.z) < 1.0)then
						if (incircle == false) then
							DrawText3Ds(position7.x, position7.y, position7.z,'~g~[E]~w~ Rob Vault')
						end
						incircle = true
						if exports['core']:GetItemQuantity(217) >= 1 then
						    if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
                                if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
                                 RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
                                 Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist") 
                                
                                loadAnimDict( "anim@heists@fleeca_bank@drilling" ) 
                                TaskPlayAnim( player, "anim@heists@fleeca_bank@drilling", "intro",8.0, 1.0, -1, 2, 0, 0, 0, 0 )                  
                                Wait(8000)
                                TaskPlayAnim( player, "anim@heists@fleeca_bank@drilling", "outro",8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
                                DrawSubtitleTimed(5000, 1)
                                Citizen.Wait(7000)
                                ClearPedTasksImmediately(GetPlayerPed(-1))
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
								vault6 = true
								xzprize()
							  end 

						end
					elseif(Vdist(pos.x, pos.y, pos.z, pos8.x, pos8.y, pos8.z) > 1.0)then
						incircle = false
					end
				end
			end
			local pos9 = {x= 257.05708752441, y = 214.667188, z = 101.6802482605}
		    local position8 = {x= 257.05708752441, y = 214.667188, z = 101.6802482605}		
			if(Vdist(pos.x, pos.y, pos.z, pos9.x, pos9.y, pos9.z) < 1.5)then
				if holdingup and (vault7 == false) then
					if(Vdist(pos.x, pos.y, pos.z, pos9.x, pos9.y, pos9.z) < 1.0)then
						if (incircle == false) then
							DrawText3Ds(position8.x, position8.y, position8.z,'~g~[E]~w~ Rob Vault')
						end
						incircle = true
						if exports['core']:GetItemQuantity(217) >= 1 then
						    if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
                                if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
                                 RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
                                 Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist") 
                                
                                loadAnimDict( "anim@heists@fleeca_bank@drilling" ) 
                                TaskPlayAnim( player, "anim@heists@fleeca_bank@drilling", "intro",8.0, 1.0, -1, 2, 0, 0, 0, 0 )                  
                                Wait(8000)
                                TaskPlayAnim( player, "anim@heists@fleeca_bank@drilling", "outro",8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
                                DrawSubtitleTimed(5000, 1)
                                Citizen.Wait(7000)
                                ClearPedTasksImmediately(GetPlayerPed(-1))
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
								vault7 = true
								xzprize()
							  end 
						end
					elseif(Vdist(pos.x, pos.y, pos.z, pos9.x, pos9.y, pos9.z) > 1.0)then
						incircle = false
					end
				end
			end
			local pos10 = {x= 263.508752441, y = 216.362188, z = 101.6802482605}
		    local position9 = {x= 263.508752441, y = 216.362188, z = 101.6802482605}			
			if(Vdist(pos.x, pos.y, pos.z, pos10.x, pos10.y, pos10.z) < 1.5)then
				if holdingup and (vault8 == false) then  
					if(Vdist(pos.x, pos.y, pos.z, pos10.x, pos10.y, pos10.z) < 1.0)then
						if (incircle == false) then
							DrawText3Ds(position9.x, position9.y, position9.z,'~g~[E]~w~ Rob Vault')
						end
						incircle = true
						if exports['core']:GetItemQuantity(217) >= 1 then
						    if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
                                if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
                                 RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
                                 Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")     
                                
                                loadAnimDict( "anim@heists@fleeca_bank@drilling" ) 
                                TaskPlayAnim( player, "anim@heists@fleeca_bank@drilling", "intro",8.0, 1.0, -1, 2, 0, 0, 0, 0 )                  
                                Wait(8000)
                                TaskPlayAnim( player, "anim@heists@fleeca_bank@drilling", "outro",8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
                                DrawSubtitleTimed(5000, 1)
                                Citizen.Wait(7000)
                                ClearPedTasksImmediately(GetPlayerPed(-1))
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
								vault8 = true
								xzprize()
							  end 
						end
					elseif(Vdist(pos.x, pos.y, pos.z, pos10.x, pos10.y, pos10.z) > 1.0)then
						incircle = false
					end
				end
			end
			local pos11 = {x= 265.626752441, y = 212.782188, z = 101.6802482605}
		    local position10 = {x= 265.622752441, y = 212.782188, z = 101.6802482605}	
			if(Vdist(pos.x, pos.y, pos.z, pos11.x, pos11.y, pos11.z) < 1.5)then
				if holdingup and (vault == true) and (vault2 == true) and (vault3 == true) and (vault4 == true) and (vault5 == true) and (vault6 == true ) and (vault7 == true ) and (vault8 == true) and (vault9 == false) then
					if(Vdist(pos.x, pos.y, pos.z, pos11.x, pos11.y, pos11.z) < 1.0)then
						if (incircle == false) then
							DrawText3Ds(position10.x, position10.y, position10.z,'~g~[E]~w~ Rob Vault')
						end
						incircle = true
						if exports['core']:GetItemQuantity(217) >= 1 then
						    if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
                                if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
                                 RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
                                 Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")     
                                
                                loadAnimDict( "anim@heists@fleeca_bank@drilling" ) 
                                TaskPlayAnim( player, "anim@heists@fleeca_bank@drilling", "intro",8.0, 1.0, -1, 2, 0, 0, 0, 0 )                  
                                Wait(8000)
                                TaskPlayAnim( player, "anim@heists@fleeca_bank@drilling", "outro",8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
                                DrawSubtitleTimed(5000, 1)
                                Citizen.Wait(7000)
                                ClearPedTasksImmediately(GetPlayerPed(-1))
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
								vault9 = true
								xzbigprize()
							  end 

						end
					elseif(Vdist(pos.x, pos.y, pos.z, pos11.x, pos11.y, pos11.z) > 1.0)then
						incircle = false
					end
				end
			end
			local pos12 = {x= 266.256752441, y = 214.542188, z = 101.6802482605}
		    local position11 = {x= 266.256752441, y = 214.542188, z = 101.6802482605}			
			if(Vdist(pos.x, pos.y, pos.z, pos12.x, pos12.y, pos12.z) < 1.5)then
				if holdingup and (vault == true) and (vault2 == true) and (vault3 == true) and (vault4 == true) and (vault5 == true) and (vault6 == true ) and (vault7 == true ) and (vault8 == true) and (vault9 == true) and (vault10 == false) then
					if(Vdist(pos.x, pos.y, pos.z, pos12.x, pos12.y, pos12.z) < 1.0)then
						if (incircle == false) then
							DrawText3Ds(position11.x, position11.y, position11.z,'~g~[E]~w~ Rob Vault')
						end
						incircle = true
						if exports['core']:GetItemQuantity(217) >= 1 then
						    if IsControlJustReleased(1, 51) then
								local player = GetPlayerPed( -1 )
                                if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
                                 RequestNamedPtfxAsset("scr_jewelheist")
                                end
                                while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
                                 Citizen.Wait(0)
                                end
                                SetPtfxAssetNextCall("scr_jewelheist")                                    
                                loadAnimDict( "anim@heists@fleeca_bank@drilling" ) 
                                TaskPlayAnim( player, "anim@heists@fleeca_bank@drilling", "intro",8.0, 1.0, -1, 2, 0, 0, 0, 0 )                  
                                Wait(8000)
                                TaskPlayAnim( player, "anim@heists@fleeca_bank@drilling", "outro",8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
                                DrawSubtitleTimed(5000, 1)
                                Citizen.Wait(7000)
                                ClearPedTasksImmediately(GetPlayerPed(-1))
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
								vault10 = true
								xzbigprize()
							  end 
						end
					elseif(Vdist(pos.x, pos.y, pos.z, pos12.x, pos12.y, pos12.z) > 1.0)then
						incircle = false
					end
				end
			  end	
			end
		    if holdingup then
			 drawTxt(0.9, 0.5, 0.6,0.6,0.3, 'Robbing Bank: ' .. secondsRemaining .. ' Seconds Left', 255, 255, 0, 255)
			local pos2 = Banks[bank].position
			if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), pos2.x, pos2.y, pos2.z, true) > 30.0)then
				TriggerServerEvent('NRP-holdupbank:toofar', bank)
				TriggerEvent('NRP-holdupbank:closedoor')
				TriggerEvent('NRP-holdupbank:robberyover')
				hackholdingup = false
				ForgeLife = false
			end
		end
	end
end)
--- fix vault door locking
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
	 if currentPolice >= 5 then	
        for k,v in pairs(Banks)do
			local pos2 = v.hackposition
			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 15.0)then
				if not hackholdingup then
				  if exports['core']:GetItemQuantity(272) >= 1 then	
					if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 1.0)then
						DrawText3Ds( pos2.x, pos2.y, pos2.z,'~g~[E]~w~ Start Hacking')
						if (incircle == false) then
						end
						incircle = true
						if IsControlJustReleased(1, 51) then
						 TriggerServerEvent('NRP-holdupbank:hack', k)
						end
					elseif(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 1.0)then
						incircle = false
					end
				  end	
				end
			end
		 if hackholdingup then
			local pos2 = v.hackposition
			if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), pos2.x, pos2.y, pos2.z, true) > 30.0)then
				TriggerServerEvent('NRP-holdupbank:toofarhack', bank)
				TriggerEvent('NRP-holdupbank:closedoor')
				TriggerEvent('NRP-holdupbank:robberyover')
				hackholdingup = false
			end
		  end	
		end
	 end	
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
	  if currentPolice >= 5 then
		for k,v in pairs(Banks)do
			local pos2 = v.bombposition
			if (pos2 ~= nil) then
				if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 15.0)then
					if not bombholdingup then
					  if hackholdingup then		  	 					
						if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 1.5)then
							if (incircle == false) then
							end
							incircle = true
							DrawText3Ds(v.bombposition.x, v.bombposition.y, v.bombposition.z,'~g~[E]~w~ Plant Bomb')
							if IsControlJustReleased(1, 51) then
							  if exports['core']:GetItemQuantity(274) >= 1 then
								TriggerServerEvent('NRP-holdupbank:plantbomb', k)
								TriggerEvent("inventory:removeQty", 274, 1)
							  else
								exports['NRP-notify']:DoHudText('error', 'You dont have a Bomb with you, What was your plan!?')
							  end								
							end
						elseif(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 1.5)then
							incircle = false
						end
					  end	
					end
				end
			end
		 if bombholdingup then
			local pos2 = Banks[bank].bombposition
			DrawText3Ds(Banks[bank].bombposition.x, Banks[bank].bombposition.y, Banks[bank].bombposition.z,'~g~[E]~w~ Cancels Robbery')
			if IsControlJustReleased(1, 51) then
			 TriggerServerEvent('NRP-holdupbank:toofar', bank)
			end
			if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), pos2.x, pos2.y, pos2.z, true) > 30.0)then
			 TriggerServerEvent('NRP-holdupbank:toofar', bank)
			 TriggerEvent('NRP-holdupbank:closedoor')
			 TriggerEvent('NRP-holdupbank:robberyover')
			 ForgeLife = false
			end
		 end	
		end
	  end
	end
end)
function plantBombAnimation()
	local playerPed = GetPlayerPed(-1)
	Citizen.CreateThread(function()
	 platingbomb = true
		while platingbomb do
		 Wait(1000)
		 TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_KNEEL", 0, true)
		 Wait(20000)
		 platingbomb = false
		 ClearPedTasksImmediately(PlayerPedId())					
		end
	  Citizen.Wait(0)
	end)
end

function DrawText3Ds(x,y,z, text)
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

local rootphone = {
 {x = 1271.7789, y = -1713.10583, z = 54.771},
}
local root = false
Citizen.CreateThread(function()
	while true do
	 Citizen.Wait(5)
	 for _,v in pairs(rootphone) do
	  if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z) <= 1 and not root then
	   if exports['core']:GetItemQuantity(271) >= 1 then
	    DrawText3Ds(v.x, v.y, v.z,'~g~[E]~w~ Root Phone')
	    if IsControlJustPressed(0, 38) then 
		 root = true
		 TriggerEvent("inventory:removeQty", 271, 1)
		 TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_ATM", 0, true)
		 API_ProgressBar('        Rooting Phone', 300)
		 Citizen.Wait(30000)
		 TriggerEvent("inventory:addQty", 272, 1)
		 ClearPedTasksImmediately(GetPlayerPed(-1))
		 root = false
		end
	   end
	  end
	 end
	end
end)

local bigmoneys = {
 {x = -1192.603, y = -215.370, z = 37.945},
}
local moneys = false
Citizen.CreateThread(function()
  while true do
   Citizen.Wait(5) 
	 for _,v in pairs(bigmoneys) do
	  if exports['sync']:isDay() then 	
	   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v.x, v.y, v.z) <= 1 and not moneys then	   
	     DrawText3Ds(v.x, v.y, v.z,'~g~[E]~w~ Trade Bond\n ~g~[H]~w~ Trade Gold Bar') 
		 if IsControlJustPressed(0, 38) then 
		  if exports['core']:GetItemQuantity(142) >= 1 then
			moneys = true
		   TriggerEvent("inventory:removeQty", 142, 1)
		   TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_ATM", 0, true)
		   API_ProgressBar('        Trading Bond For Cash', 150)
		   Citizen.Wait(15000)
		   TriggerServerEvent('NRP-BondRewards-runescape')
		   ClearPedTasksImmediately(GetPlayerPed(-1))
		   moneys = false
		  else
			exports['NRP-notify']:DoHudText('error', 'You dont have a cash bond on you')
		  end
		 elseif IsControlJustPressed(0, 74) then 
		  if exports['core']:GetItemQuantity(133) >= 1 then
			moneys = true 
		    TriggerEvent("inventory:removeQty", 133, 1)
		    TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_ATM", 0, true)
		    API_ProgressBar('        Trading Gold Bar For Cash', 150)
			Citizen.Wait(15000)
			TriggerServerEvent('NRP-CashRewards-runescape')
		    ClearPedTasksImmediately(GetPlayerPed(-1))
			moneys = false
		  else
			exports['NRP-notify']:DoHudText('error', 'You dont have a gold bar on you')
		  end	
		end
	   end
	  end
	 end
   end
end)