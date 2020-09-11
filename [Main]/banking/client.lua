inMenu			= true
local showblips	= true
local atbank	= false
local atm_counter = 0
local uv_counter = 0
local banks = {
	{name="Bank", id=108, x=150.266, y=-1040.203, z=29.374},
	{name="Bank", id=108, x=-1212.980, y=-330.841, z=37.787},
	{name="Bank", id=108, x=-2962.582, y=482.627, z=15.703},
	{name="Bank", id=108, x=-112.202, y=6469.295, z=31.626},
	{name="Bank", id=108, x=314.187, y=-278.621, z=54.170},
	{name="Bank", id=108, x=-351.534, y=-49.529, z=49.042},
	{name="Pacific Standard Bank", id=108, x=241.727, y=220.706, z=106.286},
	{name="Bank", id=108, x=1175.064, y=2706.643, z=38.094}
}	


function getSuspectSex()
  local sex = 'Male'
  if GetEntityModel(GetPlayerPed(-1)) == -1667301416 then 
   sex = "Female" 
  else 
   sex = "Male" 
  end
  return sex
 end

 function getSuspectLocation()
  local pos = GetEntityCoords(GetPlayerPed(-1),  true)
  local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, pos.x, pos.y, pos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
  if s2 == 0 then 
   return {street1 = GetStreetNameFromHashKey(s1), street2 = GetStreetNameFromHashKey(s2), both = false, pos = {x = pos.x, y = pos.y, z = pos.z}}
  else 
   return {street1 = GetStreetNameFromHashKey(s1), street2 = GetStreetNameFromHashKey(s2), both = true, pos = {x = pos.x, y = pos.y, z = pos.z}}
  end
 end

DecorRegister('UV', 2)

function loadAnimDict( dict )
  while ( not HasAnimDictLoaded( dict ) ) do
      RequestAnimDict( dict )
      Citizen.Wait( 5 )
  end
end 

Citizen.CreateThread(function()
 while true do
  Wait(5)
  if nearBank() then
   if IsControlJustPressed(0, 38) then
    inMenu = true
    SetNuiFocus(true, true)
    SendNUIMessage({type = 'openGeneral'})
    TriggerServerEvent('bank:balance')
   elseif IsControlJustPressed(0, 74) then 
   	TriggerEvent('shared_banking:status', true)
   end
   if IsControlJustPressed(1, 322) then
   	TriggerEvent('shared_banking:status', false)
	inMenu = false
	SetNuiFocus(false, false)
	SendNUIMessage({type = 'close'})
   end
  elseif nearATM() then 
   if IsControlJustPressed(1, 38) then
    inMenu = true
    SetNuiFocus(true, true)
    SendNUIMessage({type = 'openGeneral'})
    TriggerServerEvent('bank:balance')
    TaskStartScenarioInPlace(GetPlayerPed(-1), 'PROP_HUMAN_ATM', false, true) Wait(5000) ClearPedTasksImmediately(GetPlayerPed(-1))
   elseif IsControlJustPressed(0, 45) and atm_counter == 0 then
    if IsPedArmed(GetPlayerPed(-1), 1) then
      TriggerServerEvent('atm:robbed')
      local suspectSex = getSuspectSex()
      local suspectLocation = getSuspectLocation()
      TriggerEvent("dispatch:atm")
      loadAnimDict("anim@heists@fleeca_bank@drilling") 
      TaskPlayAnim(GetPlayerPed(-1), "anim@heists@fleeca_bank@drilling", "intro",8.0, 1.0, -1, 2, 0, 0, 0, 0 )                  
      Wait(8000)
      TaskPlayAnim( GetPlayerPed(-1), "anim@heists@fleeca_bank@drilling", "outro",8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
      Citizen.Wait(7000)
      ClearPedTasksImmediately(GetPlayerPed(-1))
      PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
      local payout = math.random(1000, 5000)
      TriggerServerEvent("core:Get")
      exports['NRP-notify']:DoHudText('Success', 'You stole $'..payout)
      TriggerServerEvent("atm:getDirtyMoney", payout)
    end
   end
   if IsControlJustPressed(1, 322) then
	inMenu = false
	SetNuiFocus(false, false)
	SendNUIMessage({type = 'close'})
   end
  end 
 end
end)

RegisterNetEvent('atm:counters')
AddEventHandler('atm:counters', function()
  atm_counter = 600000
  uv_counter = 10000
end)

RegisterNetEvent('atm:robbed')
AddEventHandler('atm:robbed', function(chance)
  local sprayed = false
  if chance == 2 then 
    sprayed = true 
  else 
    sprayed = false 
  end
  if sprayed then
    Wait(8000)
    TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 5.0, 'tamperspray', 0.3)
    exports['NRP-notify']:DoHudText('error', 'You have been sprayed!')
    SetTimecycleModifier("glasses_green")
    TriggerServerEvent('atm:coughStart')
    DecorSetBool(GetPlayerPed(-1), "UV", true)
  else
    DecorSetBool(GetPlayerPed(-1), "UV", false)
  end
end)

Citizen.CreateThread(function()
  while true do
    Wait(0)
    if atm_counter > 0 then
      atm_counter = atm_counter - 1
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    Wait(0)
    local spray = DecorGetBool(GetPlayerPed(-1), "UV")
    if spray then
      if uv_counter > 0 then
        uv_counter = uv_counter - 1
        print(uv_counter)
        if uv_counter == 0 then
          DecorSetBool(GetPlayerPed(-1), "UV", false)
          ClearTimecycleModifier()
          TriggerServerEvent('atm:coughEnd')
        end
      end
    end
  end
end)

RegisterCommand("uv", function()
  print(DecorGetBool(GetPlayerPed(-1), "UV"))
end)

RegisterCommand("tc", function(source, args)
  if not args[1] then
    ClearTimecycleModifier()
  else
    SetTimecycleModifier(args[1])
  end
end)

RegisterCommand("tce", function(source, args)
  if not args[1] then
    ClearExtraTimecycleModifier()
  else
    SetExtraTimecycleModifier(args[1])
  end
end)

Citizen.CreateThread(function()
 for k,v in ipairs(banks)do
  local blip = AddBlipForCoord(v.x, v.y, v.z)
  SetBlipSprite(blip, v.id)
  SetBlipScale(blip, 0.8)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(tostring(v.name))
  EndTextCommandSetBlipName(blip)
 end
end)

RegisterNetEvent('banking:updateBalance')
AddEventHandler('banking:updateBalance', function(balance, playerName)
 SendNUIMessage({type = "balanceHUD", balance = balance, player = playerName})
end)

RegisterNUICallback('deposit', function(data)
 if nearBank() == true then 
  TriggerServerEvent('bank:deposit', tonumber(data.amount))
  TriggerServerEvent('bank:balance')
 else
  exports['NRP-notify']:DoHudText('error', 'You Can Only Deposit Money At The Bank')
 end
end)

RegisterNUICallback('withdrawl', function(data)
 if nearATM() == true and tonumber(data.amountw) < 5001 then 
  TriggerServerEvent('bank:withdraw', tonumber(data.amountw))
  TriggerServerEvent('bank:balance')
 elseif nearBank() == true then 
  TriggerServerEvent('bank:withdraw', tonumber(data.amountw))
  TriggerServerEvent('bank:balance')
 else
  exports['NRP-notify']:DoHudText('error', 'Withdraw Limit, $5000')
 end
end)

RegisterNUICallback('balance', function()
	TriggerServerEvent('bank:balance')
end)

RegisterNetEvent('balance:back')
AddEventHandler('balance:back', function(balance)
	SendNUIMessage({type = 'balanceReturn', bal = balance})
end)

RegisterNUICallback('transfer', function(data)
	TriggerServerEvent('bank:transfer', tonumber(data.player), tonumber(data.amount))
end)

RegisterNetEvent('bank:result')
AddEventHandler('bank:result', function(type, message)
	SendNUIMessage({type = 'result', m = message, t = type})
end)

RegisterNUICallback('NUIFocusOff', function()
	inMenu = false
	SetNuiFocus(false, false)
	SendNUIMessage({type = 'closeAll'})
end)

function nearBank()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)
	
	for _, search in pairs(banks) do
    local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
		
    if distance <= 3 then
      DrawText3Ds(search.x, search.y, search.z,"~g~[E]~w~ Bank")
			return true
		end
	end
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



local nearObject = false 
local isNearObject = false
local objectLoc = {}
local clostestProp = nil
local models = {
  [1] = 'prop_atm_01',
  [2] = 'prop_atm_02',
  [3] = 'prop_atm_03',
  [4] = 'prop_fleeca_atm',
}

Citizen.CreateThread(function()
 while true do
  Citizen.Wait(1500)
  nearObject = false
  isNearObject = false
  local myCoords = GetEntityCoords(GetPlayerPed(-1))
   
  for i = 1, #models do
   clostestProp = GetClosestObjectOfType(myCoords.x, myCoords.y, myCoords.z, 2.5, GetHashKey(models[i]), false, false)
   if clostestProp ~= nil and clostestProp ~= 0 then
    local coords = GetEntityCoords(clostestProp)
    isNearObject = true
    objectLoc = {['x'] = coords.x, ['y'] = coords.y, ['z'] = coords.z + 1.2}
    break
   end
  end
 end
end)

function nearATM()
 if isNearObject then 
  if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), objectLoc.x, objectLoc.y, objectLoc.z, true) < 1.0) then
    if IsPedArmed(GetPlayerPed(-1), 1) and atm_counter == 0 then
      DrawText3Ds(objectLoc.x, objectLoc.y, objectLoc.z,"~g~[E]~w~ ATM\n~g~[R]~w~ Break Into")
    else
      DrawText3Ds(objectLoc.x, objectLoc.y, objectLoc.z,"~g~[E]~w~ ATM")
    end
   return true 
  end
 end
end 

RegisterNetEvent('atm:cough')
AddEventHandler('atm:cough', function(pedid)
  local playerID = GetPlayerFromServerId(pedid)
  local playerPed = GetPlayerPed(playerID)
  local playerPos = GetEntityCoords(playerPed)
  ExecuteCommand("e cough")
  Wait(300)
  if(GetEntityModel(GetPlayerPed(-1)) == -1667301416) then
    TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 5.0, 'femalecough', 0.5)
  else
    TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 5.0, 'malecough', 0.5)
  end  
  Wait(3000)
  ExecuteCommand("e c")
end)