local rob = false
local robbers = {}

function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

RegisterServerEvent('NRP-holdupbank:toofar')
AddEventHandler('NRP-holdupbank:toofar', function(robb)
	local source = source
	rob = false
	--('BANK ROBBERY :  Robbery at Principal Bank Cancelled :  RED ALERT!! ')
	TriggerClientEvent('nrp:dispatch:notify', source, '10-90', json.encode({{robberyMessage="Cameras have spotted criminals leaving"}}))
 TriggerEvent('core:getPlayerFromId', source, function(user)
  if(robbers[source])then
	 TriggerClientEvent('NRP-holdupbank:toofarlocal', source)
	 robbers[source] = nil
  end
 end)
end)

RegisterServerEvent('NRP-holdupbank:toofarhack')
AddEventHandler('NRP-holdupbank:toofarhack', function(robb)
	local source = source
	rob = false
 --AlertPolice('BANK ROBBERY :  Robbery at Principal Bank Cancelled :  RED ALERT!! ')
 TriggerClientEvent('nrp:dispatch:notify', source, '10-90', json.encode({{robberyMessage="Cameras have spotted criminals leaving"}}))
 TriggerEvent('core:getPlayerFromId', source, function(user)
  if(robbers[source])then
	TriggerClientEvent('NRP-holdupbank:toofarlocal', source)
	robbers[source] = nil
	TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = 'Bank Robbery Ended'})
  end
 end)
end)

RegisterServerEvent('NRP-holdupbank:hackfail')
AddEventHandler('NRP-holdupbank:hackfail', function()
	--AlertPolice('BANK ROBBERY :  Somebody is Attempting to Hack there way into the Principal Bank !! RED ALERT !!')
	TriggerClientEvent('nrp:dispatch:notify', source, '10-90', json.encode({{robberyMessage="Cameras have spotted an attempted door hack"}}))
end)


RegisterServerEvent('NRP-holdupbank:robfail')
AddEventHandler('NRP-holdupbank:robfail', function()
	--AlertPolice('BANK ROBBERY :  Somebody Has Been Seen On Camera in the Vault of Principal Bank!! RED ALERT !!')
	TriggerClientEvent('nrp:dispatch:notify', source, '10-90', json.encode({{robberyMessage="Cameras have spotted an attempted vault breach"}}))
end)

RegisterServerEvent('NRP-holdupbank:rob')
AddEventHandler('NRP-holdupbank:rob', function(robb)
  local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
 TriggerEvent('core:getPlayers', function(players)			
  if Banks[robb] then
	local bank = Banks[robb]
	if (os.time() - bank.lastrobbed) < 3600 and bank.lastrobbed ~= 0 then
	 TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = 'Banks Been Robbed Recently!'})
	 return
	end
	if rob == false then	
		rob = true
	  for i in pairs(players)do	
		TriggerClientEvent('NRP-holdupbank:killblip', players[i])							
		TriggerClientEvent('NRP-holdupbank:setblip', players[i], Banks[robb].position)
		TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'success', text = "Robbery Started"})
		Wait(3000)
		--AlertPolice('BANK ROBBERY : Get on Scene ASAP Robbery in progress at Principal Bank :  RED ALERT!! ')
		TriggerClientEvent('nrp:dispatch:notify', source, '10-90', json.encode({{robberyMessage="Vault alarm has been triggered"}}))
		TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = "Vault alarm triggered"})
		TriggerClientEvent('NRP-holdupbank:currentlyrobbing', source, robb)
		Banks[robb].lastrobbed = os.time()
		robbers[source] = robb
	  end	
		local savedSource = source
		SetTimeout(300000, function()
			if(robbers[savedSource])then
				rob = false
				TriggerClientEvent('NRP-holdupbank:robberycomplete', savedSource, job)
				if(user)then
                  user.addDirtyMoney(bank.reward)  --- change
				  --AlertPolice('BANK ROBBERY :  Robbery at Principal Bank Has Ended ')
				  TriggerClientEvent('nrp:dispatch:notify', source, '10-90', json.encode({{robberyMessage="Cameras have spotted the vault is clean"}}))
				end
			end
		end)
	 else
	TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = "Already Robbed"})
	 end
	end
   end)
  end)
end)

RegisterServerEvent('NRP-holdupbank:hack')
AddEventHandler('NRP-holdupbank:hack', function(robb)
	local source = source
	TriggerEvent('core:getPlayerFromId', source, function(user)
	TriggerEvent('core:getPlayers', function(players)   --- change	
	if Banks[robb] then
		local bank = Banks[robb]
		if (os.time() - bank.lastrobbed) < 3600 and bank.lastrobbed ~= 0 then
			TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = "Already Robbed"})
			return
		end
		 TriggerClientEvent('NRP-holdupbank:currentlyhacking', source, robb, Banks[robb])
		end
	  end)	
	end)
end)

RegisterServerEvent('NRP-holdupbank:plantbomb')
AddEventHandler('NRP-holdupbank:plantbomb', function(robb)
 local source = source
 TriggerEvent('core:getPlayerFromId', source, function(user)
 if Banks[robb] then
    local bank = Banks[robb]
    if (os.time() - bank.lastrobbed) < 3600 and bank.lastrobbed ~= 0 then
	 TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'error', text = 'Banks Been Robbed Recently!'})
        return
    end
	--AlertPolice('BANK ROBBERY : Bomb is Being Planted at Principal Bank : RED ALERT!!')
	TriggerClientEvent('nrp:dispatch:notify', source, '10-90', json.encode({{robberyMessage="Cameras have spotted a bomb being planted"}}))
    TriggerClientEvent('NRP-holdupbank:plantingbomb', source, robb, Banks[robb])
    robbers[source] = robb
	local savedSource = source
	SetTimeout(20000, function()
        if(robbers[savedSource])then
            rob = false
		 TriggerClientEvent('NRP-holdupbank:plantbombcomplete', savedSource, Banks[robb])
	    end
    end)
  end
 end)
end)

function AlertPolice(message)
 TriggerEvent('core:getPlayers', function(players)
  for i in pairs(players)do
  if players[i]:getJob() == 1 or players[i]:getJob() == 31 or players[i]:getJob() == 32 or players[i]:getJob() == 33 or players[i]:getJob() == 34 or players[i]:getJob() == 35 or players[i]:getJob() == 36 or players[i]:getJob() == 37 or players[i]:getJob() == 90 or players[i]:getJob() == 91  then
    if players[i].isOnDuty() then
 	 TriggerClientEvent('NRP-notify:client:SendAlert', players[i].get('source'), { type = 'error', text = message, length = 5000})
    end
   end 
   end 
 end)
end 

RegisterServerEvent('NRP-holdupbank:opendoor')
AddEventHandler('NRP-holdupbank:opendoor', function(x,y,z, doortype)
 TriggerClientEvent('NRP-holdupbank:opendoors', -1, x,y,z, doortype)
end)

RegisterServerEvent('NRP-holdupbank:plantbombtoall')
AddEventHandler('NRP-holdupbank:plantbombtoall', function(x,y,z, doortype)
 SetTimeout(20000, function()
  TriggerClientEvent('NRP-holdupbank:plantedbomb', -1, x,y,z, doortype)
 end)
end)

RegisterServerEvent('NRP-holdupbank:finishclear')
AddEventHandler('NRP-holdupbank:finishclear', function()
 TriggerClientEvent('NRP-blowtorch:finishclear', -1)
end)

RegisterServerEvent('NRP-holdupbank:closedoor')
AddEventHandler('NRP-holdupbank:closedoor', function()
 TriggerClientEvent('NRP-holdupbank:closedoor', -1)
end)

RegisterServerEvent('NRP-holdupbank:plantbomb')
AddEventHandler('NRP-holdupbank:plantbomb', function()
 TriggerClientEvent('NRP-holdupbank:plantbomb', -1)
end)

RegisterServerEvent('NRP-CashRewards-runescape')
AddEventHandler('NRP-CashRewards-runescape', function()
 local source = tonumber(source)
 local goldout = math.random(20000,30000)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  user.addDirtyMoney(goldout)
  TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = 'You got $'..goldout..' for your bond'})  
  TriggerEvent("core:moneylog", source, GetPlayerName(source).."[GOLD BAR] Has Been Cashed $"..goldout.." By "..GetPlayerName(source))
 end)
end)

RegisterServerEvent('NRP-BondRewards-runescape')
AddEventHandler('NRP-BondRewards-runescape', function()
 local source = tonumber(source)
 local bondout = math.random(40000,50000)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  user.addDirtyMoney(bondout)
  TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = 'You got $'..bondout..' for your bond'})  
  TriggerEvent("core:moneylog", source, GetPlayerName(source).."[BOND] Has Been Cashed $"..bondout.." By "..GetPlayerName(source))
 end)
end)
