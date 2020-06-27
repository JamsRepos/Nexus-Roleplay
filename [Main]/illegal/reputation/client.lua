reputation = 0
local chopshopBlip = nil
local moonshineBlip = nil
local weedBlip = nil
local LaundretteBlip = nil
DecorRegister('Reputation', 3)

RegisterNetEvent("repuation:set")
AddEventHandler("repuation:set", function(v)
 reputation = v
 DecorSetInt(GetPlayerPed(-1), 'Reputation', v)
 updateBlips(v)
end)


function updateBlips(rep)
 --[[if rep > 750 then 
  if not chopshopBlip then
    chopshopBlip = AddBlipForCoord(2337.824, 3049.973, 48.152)
    SetBlipSprite (chopshopBlip, 456)
    SetBlipDisplay(chopshopBlip, 4)
    SetBlipScale  (chopshopBlip, 0.8)
    SetBlipColour (chopshopBlip, 15)
    SetBlipAsShortRange(chopshopBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Chopshop')
    EndTextCommandSetBlipName(chopshopBlip)
  end
 end]]--
 if rep > 975 then 
  if not moonshineBlip then
    moonshineBlip = AddBlipForCoord(-429.082, -1728.043, 19.784)
    SetBlipSprite (moonshineBlip, 456)
    SetBlipDisplay(moonshineBlip, 4)
    SetBlipScale  (moonshineBlip, 0.8)
    SetBlipColour (moonshineBlip, 15)
    SetBlipAsShortRange(moonshineBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Moonshine')
    EndTextCommandSetBlipName(moonshineBlip)
  end
 end
 --[[if rep > 410 then 
  if not weedBlip then
    weedBlip = AddBlipForCoord(1320.486, 4314.610, 38.142)
    SetBlipSprite (weedBlip, 456)
    SetBlipDisplay(weedBlip, 4)
    SetBlipScale  (weedBlip, 0.8)
    SetBlipColour (weedBlip, 15)
    SetBlipAsShortRange(weedBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Weed Farm')
    EndTextCommandSetBlipName(weedBlip)
  end
 end]]--
 --[[if rep > 250 then 
  if not LaundretteBlip then
    LaundretteBlip = AddBlipForCoord(7.478, 6469.628, 31.425)
    SetBlipSprite (LaundretteBlip, 456)
    SetBlipDisplay(LaundretteBlip, 4)
    SetBlipScale  (LaundretteBlip, 0.8)
    SetBlipColour (LaundretteBlip, 15)
    SetBlipAsShortRange(LaundretteBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Laundrette')
    EndTextCommandSetBlipName(LaundretteBlip)
  end
 end]]--
end