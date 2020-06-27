function drawTxt(text)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(0.32, 0.32)
    SetTextColour(0, 255, 255, 255)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(1)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(0.5, 0.93)
  end

  function SetJobBlip(x,y,z)
    if DoesBlipExist(missionblip) then RemoveBlip(missionblip) end
    missionblip = AddBlipForCoord(x,y,z)
    SetBlipSprite(missionblip, 164)
    SetBlipColour(missionblip, 53)
    SetBlipRoute(missionblip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Destination")
    EndTextCommandSetBlipName(missionblip)
   end

   function RemoveJobBlip()
    if DoesBlipExist(missionblip) then RemoveBlip(missionblip) end
   end
   
   function Notify(message)
    exports.pNotify:SendNotification({text = message})
   end
   
   function LoadAnim(animDict)
     RequestAnimDict(animDict)
   
     while not HasAnimDictLoaded(animDict) do
       Citizen.Wait(10)
     end
   end
   
   function LoadModel(model)
     RequestModel(model)
   
     while not HasModelLoaded(model) do
       Citizen.Wait(10)
     end
   end