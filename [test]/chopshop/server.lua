local neededVehicles = {}
local whoHasList = {}
local vehicles = {
 [1] = {name = 'Sultan', model = GetHashKey('sultan'), chopped = false},
 [2] = {name = 'Ingot', model = GetHashKey('ingot'), chopped = false},
 [3] = {name = 'Surge', model = GetHashKey('surge'), chopped = false},
 [4] = {name = 'Issi', model = GetHashKey('issi2'), chopped = false},
 [5] = {name = 'Gresley', model = GetHashKey('gresley'), chopped = false},
 [6] = {name = 'Panto', model = GetHashKey('panto'), chopped = false},
 [7] = {name = 'Super Diamond', model = GetHashKey('superd'), chopped = false},
 [8] = {name = 'Bullet', model = GetHashKey('bullet'), chopped = false},
 [9] = {name = 'Massacro', model = GetHashKey('massacro'), chopped = false},
 [10] = {name = 'Ruiner', model = GetHashKey('ruiner'), chopped = false},
 [11] = {name = 'Prairie', model = GetHashKey('prairie'), chopped = false},
 [12] = {name = 'Voltic', model = GetHashKey('voltic'), chopped = false},
 [13] = {name = 'Sentinel', model = GetHashKey('sentinel2'), chopped = false},
 [14] = {name = 'Intruder', model = GetHashKey('intruder'), chopped = false},
 [15] = {name = 'Seminole', model = GetHashKey('seminole'), chopped = false},
 [16] = {name = 'Felon GT', model = GetHashKey('felon2'), chopped = false},
 [17] = {name = 'Emperor', model = GetHashKey('emperor'), chopped = false},
 [18] = {name = 'Taxi', model = GetHashKey('taxi'), chopped = false},
 [19] = {name = 'Cognoscenti Cabrio', model = GetHashKey('cogcabrio'), chopped = false},
 [20] = {name = 'Comet', model = GetHashKey('comet2'), chopped = false},
 [21] = {name = 'Rapid GT', model = GetHashKey('rapidgt'), chopped = false},
 [22] = {name = 'Vigero', model = GetHashKey('vigero'), chopped = false},
 [23] = {name = 'Banshee', model = GetHashKey('banshee'), chopped = false},
 [24] = {name = 'Tornado', model = GetHashKey('tornado'), chopped = false},
 [25] = {name = 'Zion', model = GetHashKey('zion'), chopped = false},
 [26] = {name = 'Blista', model = GetHashKey('blista'), chopped = false},
 [27] = {name = 'Buffalo', model = GetHashKey('buffalo'), chopped = false},
 [28] = {name = 'Oracle', model = GetHashKey('oracle2'), chopped = false},
 [29] = {name = 'F620', model = GetHashKey('f620'), chopped = false},
 [30] = {name = 'Asea', model = GetHashKey('asea'), chopped = false},
 [31] = {name = 'Feltzer', model = GetHashKey('feltzer2'), chopped = false},
 [32] = {name = 'Dubsta', model = GetHashKey('dubsta'), chopped = false},
 [33] = {name = 'Jackal', model = GetHashKey('jackal'), chopped = false},
 [34] = {name = 'Oracle XS', model = GetHashKey('oracle'), chopped = false},
 [35] = {name = 'Sentinel XS', model = GetHashKey('sentinel'), chopped = false},
 [36] = {name = 'Windsor', model = GetHashKey('windsor'), chopped = false},
 [37] = {name = 'Windsor Drop', model = GetHashKey('windsor2'), chopped = false},
 [38] = {name = 'Zion Cabrio', model = GetHashKey('zion2'), chopped = false},
 [39] = {name = 'Nightshade', model = GetHashKey('nightshade'), chopped = false},
 [40] = {name = 'Picador', model = GetHashKey('picador'), chopped = false},
 [41] = {name = 'Sabre Turbo', model = GetHashKey('sabregt'), chopped = false},
 [42] = {name = 'Tampa', model = GetHashKey('tampa'), chopped = false},
 [43] = {name = 'Virgo', model = GetHashKey('virgo'), chopped = false},
 [44] = {name = 'Rapid GT Classic', model = GetHashKey('rapidgt3'), chopped = false}, 
 [45] = {name = 'Yosemite', model = GetHashKey('yosemite'), chopped = false},
 [46] = {name = "Blade", model = GetHashKey("blade"), chopped = false},
 [47] = {name = "Buccaneer", model = GetHashKey("buccaneer"), chopped = false},
 [48] = {name = "Chino", model = GetHashKey("chino"), chopped = false},
 [49] = {name = "Coquette BlackFin", model = GetHashKey("coquette3"), chopped = false},
 [50] = {name = "Dominator", model = GetHashKey("dominator"), chopped = false},
 [52] = {name = "Dukes", model = GetHashKey("dukes"), chopped = false},
 [53] = {name = "Gauntlet", model = GetHashKey("gauntlet"), chopped = false},
 [54] = {name = "Hotknife", model = GetHashKey("hotknife"), chopped = false},
 [55] = {name = "Faction", model = GetHashKey("faction"), chopped = false},
 [56] = {name = "Nightshade", model = GetHashKey("nightshade"), chopped = false},
 [57] = {name = "Picador", model = GetHashKey("picador"), chopped = false},
 [58] = {name = "Sabre Turbo", model = GetHashKey("sabregt"), chopped = false},
 [59] = {name = "Tampa", model = GetHashKey("tampa"), chopped = false},
 [60] = {name = "Virgo", model = GetHashKey("virgo"), chopped = false},
 [61] = {name = "Exemplar", model = GetHashKey("EXEMPLAR"), chopped = false},
 [62] = {name = "Huntley", model = GetHashKey("HUNTLEY"), chopped = false},
 [63] = {name = "Glendale", model = GetHashKey("GLENDALE"), chopped = false},
 [64] = {name = "Fusilade", model = GetHashKey("FUSILADE"), chopped = false},
 [65] = {name = "Patriot", model = GetHashKey("PATRIOT"), chopped = false},
 [66] = {name = "Exemplar", model = GetHashKey("EXEMPLAR"), chopped = false},
 [67] = {name = "Huntley", model = GetHashKey("HUNTLEY"), chopped = false},
 [68] = {name = "Glendale", model = GetHashKey("GLENDALE"), chopped = false},
 [69] = {name = "Fusilade", model = GetHashKey("FUSILADE"), chopped = false},
 [70] = {name = "Patriot", model = GetHashKey("PATRIOT"), chopped = false},
 [61] = {name = "Exemplar", model = GetHashKey("EXEMPLAR"), chopped = false},
 [71] = {name = "Huntley", model = GetHashKey("HUNTLEY"), chopped = false},
 [72] = {name = "Glendale", model = GetHashKey("GLENDALE"), chopped = false},
 [73] = {name = "Fusilade", model = GetHashKey("FUSILADE"), chopped = false},
 [74] = {name = "Patriot", model = GetHashKey("PATRIOT"), chopped = false},
 [75] = {name = "Exemplar", model = GetHashKey("EXEMPLAR"), chopped = false},
 [76] = {name = "Huntley", model = GetHashKey("HUNTLEY"), chopped = false},
 [77] = {name = "Glendale", model = GetHashKey("GLENDALE"), chopped = false},
 [78] = {name = "Fusilade", model = GetHashKey("FUSILADE"), chopped = false},
 [79] = {name = "Patriot", model = GetHashKey("PATRIOT"), chopped = false},
 [80] = {name = 'Seminole', model = GetHashKey('seminole'), chopped = false},
 [81] = {name = 'Felon GT', model = GetHashKey('felon2'), chopped = false},
 [82] = {name = 'Emperor', model = GetHashKey('emperor'), chopped = false},
 [83] = {name = 'Taxi', model = GetHashKey('taxi'), chopped = false},
 [84] = {name = 'Cognoscenti Cabrio', model = GetHashKey('cogcabrio'), chopped = false},
 [85] = {name = 'Comet', model = GetHashKey('comet2'), chopped = false},
 
}


AddEventHandler('onResourceStart', function(resource)
 if resource == GetCurrentResourceName() then
  for i=1, 16 do 
   neededVehicles[i] = vehicles[math.random(1,#vehicles)] 
  end
 end
end)

local function newVehicleList()
  SetTimeout(3600000, function()
    Citizen.CreateThread(function()
     neededVehicles = {}
     for i=1, 16 do 
      neededVehicles[i] = vehicles[math.random(1,#vehicles)] 
     end
     sendUpdatedList()
     newVehicleList()
    end)
  end)
end 
newVehicleList()

function sendUpdatedList()
 local source = tonumber(source)
 local list = ''
 for _,v in pairs(neededVehicles) do
  if not v.chopped then 
   list = list..v.name.." | "
  end
 end
 for _,v in pairs(whoHasList) do
  TriggerEvent('phone:addEmail', v, 'Updated List Of Required Vehicles: <br>'..list, 'Anonomous')
 end
 TriggerClientEvent('chopshop:vehicleList', -1, neededVehicles)
end

RegisterServerEvent('chopshop:getVehicleList')
AddEventHandler('chopshop:getVehicleList', function()
 local source = tonumber(source)
 local list = ''
 for _,v in pairs(neededVehicles) do
  if not v.chopped then 
   list = list..v.name.." | "
  end
 end
 TriggerEvent('phone:addEmail', source, 'List Of Required Vehicles: '..list, 'Anonomous')
 whoHasList[source] = source
 TriggerClientEvent('chopshop:vehicleList', -1, neededVehicles)
end)

RegisterServerEvent('core:characterloaded')
AddEventHandler('core:characterloaded', function()
 TriggerClientEvent('chopshop:vehicleList', -1, neededVehicles)
 whoHasList[source] = nil
end)

RegisterServerEvent('chopshop:scrap')
AddEventHandler('chopshop:scrap', function(id, plate)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  if user.isVehicleOwner(plate) then
   print(GetPlayerName(source)..' Has Chooped His Own Car') 
   TriggerClientEvent('vehstore:delete', tonumber(source))
   user.removeVehicle(plate)
   TriggerClientEvent("pNotify:SendNotification", tonumber(source), {text= "You Chopped Your Vehicle"})
   exports['GHMattiMySQL']:QueryAsync("DELETE FROM `dmv_records` WHERE plate=@plate", {['@plate'] = plate})
  end

  if not neededVehicles[id].chopped then 
   neededVehicles[id].chopped = true
   for _,v in pairs(whoHasList) do
    TriggerEvent('phone:addEmail', v, neededVehicles[id].name.." Has Been Removed From Chop List", 'Anonomous')
   end
  end
  TriggerEvent('chopshop:refreshVehicleList')
 end)
end)

AddEventHandler('chopshop:refreshVehicleList', function(source)
 local list = ''
 for _,v in pairs(neededVehicles) do
  if not v.chopped then 
   list = list..v.name.." | "
  end
 end
 TriggerEvent('phone:addEmail', source, 'List Of Required Vehicles: '..list, 'Anonomous')
 TriggerClientEvent('chopshop:vehicleList', -1, neededVehicles)
end)


RegisterServerEvent('drug:addmoney')
AddEventHandler('drug:addmoney', function(pay)
 local source = tonumber(source)
 TriggerEvent('core:getPlayerFromId', source, function(user)
  user.addMoney(pay)
  TriggerEvent("core:moneylog", source, 'Drug Payment: $'..pay)
 end)
end) 
