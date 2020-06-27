local points = {}
local LevelOne = 25
local LevelTwo = 50
local LevelThree = 75
local LevelFour = 100
local LevelFive = 150
local LevelSix = 200
local LevelSeven = 250
local LevelEight = 350
local LevelNine = 500
local LevelTen = 750


RegisterNetEvent('gallows:miningcheck')
AddEventHandler('gallows:miningcheck', function(value)
    if value == LevelOne then 
        exports['NRP-notify']:DoHudText('inform', "Your Level One")
     elseif value >= LevelTwo then
        exports['NRP-notify']:DoHudText('inform', "Your Level Two")
    elseif value >= LevelThree then
        exports['NRP-notify']:DoHudText('inform', "Your Level Three")
    elseif value >= LevelFour then
        exports['NRP-notify']:DoHudText('inform', "Your Level Four")    
    elseif value >= LevelFive then
        exports['NRP-notify']:DoHudText('inform', "Your Level Five")
    elseif value >= LevelSix then
        exports['NRP-notify']:DoHudText('inform', "Your Level Six")
    elseif value >= LevelSeven then
        exports['NRP-notify']:DoHudText('inform', "Your Level Seven")
    elseif value >= LevelEight then
        exports['NRP-notify']:DoHudText('inform', "Your Level Eight")
    elseif value >= LevelNine then
        exports['NRP-notify']:DoHudText('inform', "Your Level Nine")
    elseif value >= LevelTen then
        exports['NRP-notify']:DoHudText('inform', "Your Level Ten")
     end
end)

RegisterNetEvent('gallows:SOWcheck')
AddEventHandler('gallows:SOWcheck', function(data)
 for _,v in pairs(data) do
  if v.name == 'SOW' then
     if v.value >= 50 then 
      exports['NRP-notify']:DoHudText('inform', "THIS IS WORKING!")
     else
      exports['NRP-notify']:DoHudText('inform', "get good!")
     end
  else
    exports['NRP-notify']:DoHudText('inform', "cunt!")
  end
 end
end)





  