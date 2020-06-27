RegisterServerEvent('points:add')
AddEventHandler('points:add', function(name, value)
 local source = tonumber(source)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  user.addPoint(name, value)
  TriggerClientEvent('points:character', source, user.getPoints())
  TriggerClientEvent('chatMessage', source, "You have gained "..value.." points  in "..name..", do /perks to see your total.")
 end)
end)

RegisterServerEvent('points:remove')
AddEventHandler('points:remove', function(name, value)
 local source = tonumber(source)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  user.removePoint(name, value)
  TriggerClientEvent('points:character', source, user.getPoints())
  TriggerClientEvent('chatMessage', source, "You have lost 1 "..name.." point, do /perks to see your total..")
 end)
end)


RegisterServerEvent('points:load')
AddEventHandler('points:load', function(source)
 local source = tonumber(source)
 TriggerEvent("core:getPlayerFromId", source, function(user)
  TriggerClientEvent('points:character', source, user.getPoints())
 end)
end)

TriggerEvent('core:addGroupCommand', 'perks', 'user', function(source, args, user)
    TriggerEvent("core:getPlayerFromId", source, function(user)
     TriggerClientEvent('chatMessage', source, "^5Your Job Points: ")
     for _,v in pairs(user.getPoints()) do
      TriggerClientEvent('chatMessage', source, v.name.." - "..v.value)
     end
    end)
end)
-------------------################################################################------------------------------
----------------------------------------------MINING-------------------------------------------------------------


RegisterServerEvent('FL_Perks:LevelChecks')
AddEventHandler('FL_Perks:LevelChecks', function()
 TriggerEvent("core:getPlayerFromId", source, function(user)
    for _,v in pairs(user.getPoints()) do          
        TriggerClientEvent('xz:getpoints',source,v.name,v.value)    
    end
 end)
end)



RegisterServerEvent('FL_Perks:fastermining')
AddEventHandler('FL_Perks:fastermining', function(data)
 TriggerEvent("core:getPlayerFromId", source, function(user)
    for _,v in pairs(user.getPoints()) do
       if v.name == 'Mining' then 
        TriggerClientEvent("xz_miner:fastermining",source , v.value)                       
       end
    end
 end)
end)
RegisterServerEvent('FL_Perks:doubleore')
AddEventHandler('FL_Perks:doubleore', function(data)
 TriggerEvent("core:getPlayerFromId", source, function(user)
    for _,v in pairs(user.getPoints()) do
       if v.name == 'Mining' then 
        TriggerClientEvent("xz_miner:doubleore",source , v.value)                       
       end
    end
 end)
end)
RegisterServerEvent('FL_Perks:fastwashing')
AddEventHandler('FL_Perks:fastwashing', function(data)
 TriggerEvent("core:getPlayerFromId", source, function(user)
    for _,v in pairs(user.getPoints()) do
       if v.name == 'Mining' then 
         TriggerClientEvent("xz_miner:fasterwashing",source , v.value)                       
       end
    end
 end)
end)
RegisterServerEvent("xz_miner:fastermelting")
AddEventHandler('xz_miner:fastermelting', function(data)
 TriggerEvent("core:getPlayerFromId", source, function(user)
    for _,v in pairs(user.getPoints()) do
       if v.name == 'Mining' then 
         TriggerClientEvent("xz_miner:fastermelting",source , v.value)                       
       end
    end
 end)
end)
RegisterServerEvent('FL_Perks:fastsell')
AddEventHandler('FL_Perks:fastsell', function(data)
 TriggerEvent("core:getPlayerFromId", source, function(user)
    for _,v in pairs(user.getPoints()) do
       if v.name == 'Mining' then           ---------------- NEEEEEEEDS WORK OR TESTING BLIPS DEFO NEED WORK
          TriggerClientEvent('xz_miner:sellLocations',source , v.value)
          TriggerClientEvent('xz_miner:sellall',source , v.value)                  
       end
    end
 end)
end)
--------------------------------------------------------------------------- SMOKE ONN THE WATER -------------------------------------------
RegisterServerEvent("xz_smoke:pickuppayincrease")
AddEventHandler('xz_smoke:pickuppayincrease', function(data)
   local source = tonumber(source)
   TriggerEvent('core:getPlayerFromId', source, function(user)
      local payday = math.random(1100,1300)
      if user ~= nil then
         for _,v in pairs(user.getPoints()) do
            if v.name == 'SOTW' then          
               if v.value >= 25 then
                TriggerEvent('jobs:paytheplayer', payday*1.25, 'SOTW: Pickup Pay')
               else
                TriggerEvent('jobs:paytheplayer', payday, 'SOTW: Pickup Pay')
               end
            end
         end
      end
   end)
end)

RegisterServerEvent("xz_smoke:growpayincrease")
AddEventHandler('xz_smoke:growpayincrease', function(payday)
   local source = tonumber(source)
   TriggerEvent('core:getPlayerFromId', source, function(user)
      if user ~= nil then
         for _,v in pairs(user.getPoints()) do
            if v.name == 'SOTW' then          
               if v.value >= 200 then
                TriggerEvent('jobs:paytheplayer', payday*1.25, 'SOTW: Grow Pay')
               else
                TriggerEvent('jobs:paytheplayer', payday, 'SOTW: Grow Pay')
               end
            end
         end
      end
   end)
end)


RegisterServerEvent("xz_smoke:grow:check")
AddEventHandler('xz_smoke:grow:check', function(data)
   local source = tonumber(source)
   TriggerEvent('core:getPlayerFromId', source, function(user)
      if user ~= nil then
         for _,v in pairs(user.getPoints()) do
            if v.name == 'SOTW' then          
               if v.value >= 75 then
                TriggerClientEvent('FL_Perks:growcheck')
               else
                TriggerClientEvent('chatMessage', source, "You have "..v.value.." points in SOTW you need 75 points to access the grow room")
               end
            end
         end
      end
   end)
end)

RegisterServerEvent("xz_smoke:water:check")
AddEventHandler('xz_smoke:water:check', function(data)
   local source = tonumber(source)
   TriggerEvent('core:getPlayerFromId', source, function(user)
      if user ~= nil then
         for _,v in pairs(user.getPoints()) do
            if v.name == 'SOTW' then          
               if v.value >= 100 then
                TriggerClientEvent('FL_Perks:fasterwater')
               else
                TriggerClientEvent('FL_Perks:normalwater')
               end
            end
         end
      end
   end)
end)

-----[[[[[[      HOW TO USE PERK SYSTEM                                                        ]]]]]]

--[[   put this in client file where u want to load points


RegisterNetEvent('xz:getpoints')
AddEventHandler('xz:getpoints',function(name,value)
  job = name
  points = value 
end)

  then put this under a press e or calling function to use it

    TriggerServerEvent('FL_Perks:LevelChecks')
        Wait(100)
       if tostring(job) == 'NAME' then
        if tonumber(points) >= 000 then

        else

        end
      end
    

RegisterServerEvent('FL_Perks:LevelChecks')
 AddEventHandler('FL_Perks:LevelChecks', function()
 TriggerEvent("core:getPlayerFromId", source, function(user)
    for _,v in pairs(user.getPoints()) do          
        TriggerClientEvent('xz:getpoints',source,v.name,v.value)    
    end
 end)
end)



]]




