Citizen.CreateThread(function()
 while true do
  Citizen.Wait(0)
  local pos = GetEntityCoords(GetPlayerPed(-1))
   if(GetDistanceBetweenCoords(pos, -32.163, -1111.901, 26.422, true) < 25) then
    DrawMarker(27, -32.163, -1111.901, 26.422-0.95, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 100, 255, 100, 140, 0, 0, 2, 0, 0, 0, 0)
    if(GetDistanceBetweenCoords(pos, -32.163, -1111.901, 26.422, true) < 1.35) then
      DrawText3Ds(-32.163, -1111.901, 26.422,'~m~Press ~g~E~m~ To Register A License')
     if IsControlJustPressed(0, 38) then
      TriggerServerEvent('license:check')
     end
    end
   end
   if(GetDistanceBetweenCoords(pos, -31.701, -1114.334, 26.422, true) < 25) then
    if(GetDistanceBetweenCoords(pos, -31.701, -1114.334, 26.422, true) < 0.55) then
      DrawText3Ds(-31.701, -1114.334, 26.422,'~m~Press ~g~E~m~ To Change Address')
     if IsControlJustPressed(0, 38) then
      local amount = "xxsdrtghyuujhdjsjenenfjfjtjtjtj"
      if(amount == "xxsdrtghyuujhdjsjenenfjfjtjtjtj") then
      showLoadingPrompt("Enter New Address", 3)
      DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8S", "", "", "", "", "", 20)
      while (UpdateOnscreenKeyboard() == 0) do
       DisableAllControlActions(0);
       Wait(0);
      end
      if (GetOnscreenKeyboardResult()) then
       local option = GetOnscreenKeyboardResult()
       if(option ~= nil and option ~= 0) then
        amount = ""..option
       end
      end
     end
     stopLoadingPrompt()
     if (amount ~= "xxsdrtghyuujhdjsjenenfjfjtjtjtj") then
      TriggerServerEvent('license:changeaddress', amount)
     else
      exports['NRP-notify']:DoHudText('error', 'Invalid Address')
     end

     end
    end
   end
  end
end)

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

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    local pos = GetEntityCoords(GetPlayerPed(-1))
    if(GetDistanceBetweenCoords(pos, 235.789, -417.017,-118.163, true) < 25) then
      DrawMarker(27, 235.789, -417.017,-118.163-0.95, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 255, 255, 0, 140, 0, 0, 2, 0, 0, 0, 0)
       if(GetDistanceBetweenCoords(pos, 235.789, -417.017,-118.163, true) < 1.35) then
          DrawText3Ds(235.789, -417.017,-118.163,'~g~[E]~w~ Purchase A Gun License For ~g~$4000')
         if IsControlJustPressed(0, 38) then
          TriggerServerEvent('gun:addLicense')
         end
       end
     end
    end
end)


RegisterNetEvent('license:opencreate')
AddEventHandler('license:opencreate', function(fakeids)
 ShowPurchase()
end)

RegisterNUICallback('confirmsale', function(data, cb) 
  TriggerServerEvent('insurance:create', data.fullname, data.date, data.address)
  _GuiEnabled = false
  SetNuiFocus(false)
  SendNUIMessage({open = false})
  cb('ok')
end)

RegisterNUICallback('escape', function()
  _GuiEnabled = false
  SetNuiFocus(false)
  SendNUIMessage({open = false})
end)

RegisterNUICallback('escape', function(data, cb)
  _GuiEnabled = false
  SetNuiFocus(false)
  SendNUIMessage({open = false})
  cb('ok')
end)

function ShowPurchase()  
 _GuiEnabled = true
 SetNuiFocus(true, true)
 SendNUIMessage({open = true})
end

function showLoadingPrompt(showText, showType)
  Citizen.CreateThread(function()
      Citizen.Wait(0)
      N_0xaba17d7ce615adbf("STRING") -- set type
      AddTextComponentString(showText) -- sets the text
      N_0xbd12f8228410d9b4(showType) -- show promt (types = 3)
  end)
end

function stopLoadingPrompt()
  Citizen.CreateThread(function()
      Citizen.Wait(0)
      N_0x10d373323e5b9c0d()
  end)
end