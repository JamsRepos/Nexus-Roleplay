local woodAmts = {low = 5, high = 20}
local trees = {}

function loadTrees()
  local treedata = LoadResourceFile("NRP-Jobs", "lumberjack/trees.json")

  if (treedata) then
    trees = json.decode(treedata)
  end

  for _,v in pairs(trees) do
    math.randomseed(os.time())
    local high = math.random(woodAmts.low, woodAmts.high)
    v.max = high
    v.amount = high
  end
end

RegisterServerEvent('lumberjack:gettrees')
AddEventHandler('lumberjack:gettrees', function()
 loadTrees()
 TriggerClientEvent('lumberjack:trees', source, trees)
end) 

RegisterServerEvent('lumberjack:harvest')
AddEventHandler('lumberjack:harvest', function(treeid)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  local canGet = user.isAbleToReceive(1)
  if not canGet then
   Notify(source, 'Inventory Full')
  else
   user.addQuantity(1,4)
  end
 end)
end) 

RegisterServerEvent('lumberjack:load')
AddEventHandler('lumberjack:load', function(treeid)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  local canDrop = user.isAbleToDrop(1,16)
  if canDrop then 
   user.removeQuantity(1,16)
   TriggerClientEvent('lumberjack:loadlogs', source)
  else
   Notify(source, 'You Need 16x Wood Logs')
  end
 end)
end) 

function Notify(source,message)
    TriggerClientEvent('NRP-notify:client:SendAlert', source, { type = 'inform', text = message})
end