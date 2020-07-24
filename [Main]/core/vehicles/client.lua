local vehshop = {
	opened = false,
	title = "Vehicle Shop",
	currentmenu = "main",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	marker = { r = 0, g = 153, b = 51, a = 200, type = 1 },
	menu = {
		x = 0.9,
		y = 0.08,
		width = 0.2,
		height = 0.04,
		buttons = 15,
		from = 1,
		to = 15,
		scale = 0.4,
		font = 0,
		["main"] = {
			title = "CATEGORIES",
			name = "main",
			buttons = {
				{name = "Vehicles"},
				{name = "Motorcycles"},
				{name = "Customs"},
			}
		},
		["vehicles"] = {
			title = "VEHICLES",
			name = "vehicles",
			buttons = {
				{name = "Compacts"},
				{name = "Coupes"},
				{name = "Sedans"},
				{name = "Muscle"},
				{name = "Off-Road"},
				{name = "SUVs"},
				{name = "Vans"},  
			}
		},
		["compacts"] = {
			title = "compacts",
			name = "compacts",
			buttons = {
				{name = "Blista", costs = 7000, model = "blista"},
				{name = "Brioso R/A", costs = 6000, model = "brioso"},
				{name = "Dilettante", costs = 2000, model = "Dilettante"},
				{name = "Issi", costs = 1800, model = "issi2"},
				{name = "Panto", costs = 3000, model = "panto"},
				{name = "Prairie", costs = 2500, model = "prairie"},
        		--{name = "Escort MK1", costs = 14000, model = "retinue"},  
        		{name = "Sentinal Classic", costs = 8000, model = "sentinel3"},
        		{name = "Blista Compact", costs = 4000, model = "blista2"},
        		{name = "Blista Compact 2", costs = 4200, model = "blista3"},
			}
		},
		["coupes"] = {
			title = "coupes",
			name = "coupes",
			buttons = {
				{name = "Itali GTO", costs = 136400, model = "ItaliGTO"},
				{name = "Cognoscenti Cabrio", costs = 15600, model = "cogcabrio"},
				{name = "Exemplar", costs = 30000, model = "exemplar"},
				--[[{name = "F620", costs = 16500, model = "f620"},
				{name = "Felon", costs = 7200, model = "felon"},
				{name = "Felon GT", costs = 9400, model = "felon2"},
				{name = "Jackal", costs = 4200, model = "jackal"},]]--
				{name = "Oracle", costs = 26100, model = "oracle"},
				{name = "Oracle XS", costs = 27900, model = "oracle2"},
				{name = "Sentinel", costs = 23000, model = "sentinel"},
				{name = "Sentinel XS", costs = 22000, model = "sentinel2"},
				{name = "Windsor", costs = 57500, model = "windsor"},
				{name = "Windsor Drop", costs = 59500, model = "windsor2"},
				{name = "Zion", costs = 52600, model = "zion"},
				{name = "Zion Cabrio", costs = 60100, model = "zion2"},
			}
		},
		["muscle"] = {
			title = "muscle",
			name = "muscle",
			buttons = {
				{name = "Blade", costs = 4500, model = "blade"},
				{name = "Coquette BlackFin", costs = 25000, model = "coquette3"},
				{name = "Dominator", costs = 17500, model = "dominator"},
				{name = "Dukes", costs = 9500, model = "dukes"},
				{name = "Gauntlet", costs = 9500, model = "gauntlet"},
				--{name = "Hotknife", costs = 4000, model = "hotknife"},
				{name = "Nightshade", costs = 39995, model = "nightshade"},
				{name = "Tampa", costs = 10000, model = "tampa"},
				{name = "Vigero", costs = 6050, model = "vigero"},
                {name = "Rapid GT Classic", costs = 13500, model = "rapidgt3"},
                --{name = "Albany Hermes", costs = 12200, model = "hermes"},
			}
		},
		["offroad"] = {
			title = "off-road",
			name = "off-road",
			buttons = {
				{name = "Bifta", costs = 19500, model = "bifta"},
				{name = "Blazer", costs = 12299, model = "blazer"},
				{name = "Brawler", costs = 9999, model = "brawler"},
				{name = "Bubsta 6x6", costs = 80000, model = "dubsta3"},
				{name = "Dune Buggy", costs = 28000, model = "dune"},
				{name = "Rebel", costs = 41195, model = "rebel2"},
				{name = "Sandking", costs = 18559, model = "sandking"},
				{name = "Trophy Truck", costs = 49199, model = "trophytruck"},
       	        {name = "XLS", costs = 16000, model = "xls"},
                {name = "Vapid Riata", costs = 15200, model = "riata"},
			}
		},
		["vans"] = {
			title = "vans",
			name = "vans",
			buttons = {
				{name = "Bison", costs = 20000, model = "bison"},
				{name = "Bobcat XL", costs = 29400, model = "bobcatxl"},
				{name = "Burrito", costs = 29200, model = "burrito3"},
				{name = "Gangsta Burrito", costs = 45000, model = "gburrito2"},
				{name = "Camper", costs = 18000, model = "camper"},
				{name = "Lost MC Burrito", costs = 20000, model = "gburrito"},
				{name = "Journey", costs = 20000, model = "journey"},
				{name = "Minivan", costs = 22000, model = "minivan"},
				{name = "Paradise", costs = 22500, model = "paradise"},
				{name = "Rumpo", costs = 29600, model = "rumpo"},
				{name = "Rumpo Trail", costs = 33000, model = "rumpo3"},
				{name = "Surfer", costs = 24500, model = "surfer"},
				{name = "Youga", costs = 29100, model = "youga"},
				{name = "Youga Luxuary", costs = 29400, model = "youga2"},
			}
		},
		["suvs"] = {
			title = "suvs",
			name = "suvs",
			buttons = {
				{name = "Baller", costs = 20500, model = "baller"},
				{name = "Baller Sport", costs = 22500, model = "baller3"},
				{name = "Cavalcade", costs = 14600, model = "cavalcade"},
				{name = "Granger", costs = 17500, model = "granger"},
				{name = "Huntley S", costs = 12000, model = "huntley"},
				{name = "Landstalker", costs = 15000, model = "landstalker"},
				{name = "Radius", costs = 1200, model = "radi"},
				{name = "Rocoto", costs = 14500, model = "rocoto"},
				{name = "Seminole", costs = 14000, model = "seminole"},
			--	{name = "Mesa", costs = 15200, model = "mesa"},
				{name = "Toros", costs = 40000, model = "toros"},
			}
		},
		["sedans"] = {
			title = "sedans",
			name = "sedans",
			buttons = {
				{name="Asea", costs=3200, model="asea"},
		        {name="Fugitive", costs=9500, model="fugitive"},
		        {name="Asterope", costs=6000, model="asterope"},
		        {name="Glendale", costs=6000, model="glendale"},
		        {name="Ingot", costs=2000, model="ingot"},
		        {name="Intruder", costs=8000, model="intruder"},
		        {name="Premier", costs=7500, model="premier"},
		        {name="Regina", costs=4000, model ="regina"},
				{name="Primo", costs=8000, model="primo"},
				{name="Futo", costs=6000, model="futo"},
		        {name="Schafter", costs=35000, model="schafter2"},
		        {name="Tailgater", costs=14000, model="tailgater"},
		        {name="Warrener", costs=16000, model="warrener"},
		        {name="Washington", costs=18000, model="washington"},
		        {name="Surge", costs=7000, model="surge"},
		        {name="Super Diamond", costs=80500, model="superd"},
		        {name="Stretch", costs=125600, model="stretch"},
			}
		},
		["motorcycles"] = {
			title = "MOTORCYCLES",
			name = "motorcycles",
			buttons = {
				{name = "Akuma", costs = 7000, model = "AKUMA"},
				{name = "Vortex", costs = 5000, model = "vortex"},
				{name = "KTM SM", costs = 44000, model = "ktmsm"},
				{name = "Esskey", costs = 10000, model = "esskey"},
				--{name = "Avarus", costs = 2600, model = "avarus"},
				{name = "Hexer", costs = 8000, model = "hexer"},
				{name = "Innovation", costs = 8000, model = "innovation"},
				{name = "Sanctus", costs = 11000, model = "sanctus"},
				{name = "Aprilia 450mxv", costs = 40000, model = "mxv450sm"},
				{name = "Zombie Luxuary", costs = 24000, model = "zombieb"},
				{name = "Bagger", costs = 8000, model = "RC"},
				{name = "Thrust", costs = 1400, model = "thrust"},
				{name = "Bati 801", costs = 9000, model = "bati"},
				{name = "Bati 801RR", costs = 9200, model = "bati2"},
				{name = "BF400", costs = 2000, model = "bf400"},
				{name = "Honda Fireblade", costs = 20000, model = "900s"},
				{name = "Carbon RS", costs = 4500, model = "carbonrs"},
				{name = "Double T", costs = 2300, model = "double"},
				{name = "Hakuchou", costs = 6900, model = "hakuchou"},
				{name = "Hakuchou Sport", costs = 7600, model = "hakuchou2"},
				{name = "Nemesis", costs = 1800, model = "nemesis"},
				{name = "Enduro", costs = 5000, model = "enduro"},
				{name = "Daemon", costs = 1900, model = "daemon"},
				--{name = "Suzuki GSXR", costs = 45000, model = "gsxr"},
				{name = "Nightblade", costs = 2900, model = "nightblade"},
				{name = "Sovereign", costs = 2700, model = "sovereign"},
				{name = "Wolfsbane", costs = 1400, model = "wolfsbane"},
				{name = "Cliffhanger", costs = 3200, model = "cliffhanger"},
				{name = "Faggio", costs = 1000, model = "faggio"},
				{name = "Vespa", costs = 1200, model = "faggio2"},
				{name = "Rat Bike", costs = 2900, model = "ratbike"},
			}		
		},
		["customs"] = {
			title = "CUSTOMS",
			name = "customs",
			buttons = {
				{name = "Toyota"},
                {name = "Nissan"},
                {name = "Audi"},
                {name = "Mercedes"},
                {name = "BMW"},
                {name = "Volkswagen"},
                {name = "Vauxhall"},
				{name = "Peugeot"},
				{name = "Mazda"},
				{name = "Honda"},
                {name = "Citroen"},
                {name = "Ford"},
                {name = "Chevrolet"},
                {name = "Dodge"},
                {name = "Porsche"},
                {name = "Ferrari"},
                {name = "Lamborghini"},
                {name = "Mclaren"},
                {name = "Bugatti"},
				{name = "Others"},
			}		
		},
		["toyota"] = {
			title = "toyota",
			name = "toyota",
			buttons = {	
			    {name = "Camry", costs = 30000, model = "camry18"},
				{name = "Supra2JZ", costs = 180000, model = "supra2"},
				{name = "Supra", costs = 85000, model = "supra"},
				{name = "Prius", costs = 18000, model = "prius"},
			}
		},
		["nissan"] = {
			title = "nissan",
			name = "nissan",
			buttons = {
				{name = "R32 Skyline", costs = 135000, model = "r32"},
				{name = "Nissan ALTIMA", costs = 15000, model = "altima"},
				{name = "Nissan S13", costs = 25000, model = "onevia"},
				{name = "Skyline GTR Nismo", costs = 200000, model = "gtrnismo"},
				{name = "300ZX", costs = 55000, model = "z32"},
				{name = "350z", costs = 45000, model = "350z"},
				{name = "Skyline GTR Convertible", costs = 235000, model = "gtrc"},
			}
		},
		["audi"] = {
			title = "audi",
			name = "audi",
			buttons = {	
			    --{name = "RS6", costs = 90000, model = "	rs6sedan"},
				{name = "RS3", costs = 65000, model = "audirs3"},
				{name = "a8audi", costs = 22000, model = "a8audi"},
				{name = "RS3 SB", costs = 80000, model = "rs318"},
				{name = "RS6", costs = 120000, model = "AUDIRS6TK"},
			}
		},
		["mercedes"] = {
			title = "mercedes",
			name = "mercedes",
			buttons = {	
			    {name = "500E", costs = 12500, model = "500w124"},
				{name = "C63AMG", costs = 110000, model = "mc63"},
				{name = "E63", costs = 100000, model = "me63"},
				{name = "300 SEL", costs = 200000, model = "300sel"},
				{name = "mers63c", costs = 165000, model = "mers63c"},
				{name = "90s S600", costs = 8000, model = "w140s600"},
				{name = "E400", costs = 70000, model = "e400w213"},
				{name = "cls63s", costs = 150000, model = "cls63s"},
				{name = "cls500", costs = 65000, model = "cls500w219"},
				{name = "S63w2", costs = 115000, model = "s63w2"},
				{name = "S63w", costs = 105000, model = "s63w"},
				{name = "E420", costs = 13000, model = "w210"},
				{name = "Black Bison", costs = 220000, model = "w222wald"},
				{name = "GL63", costs = 125000, model = "GL63"},
				{name = "Mayback S400", costs = 420000, model = "X222"},
				{name = "s500", costs = 160000, model = "S500W222"},
				{name = "CLA45", costs = 70000, model = "CLA45SB"},
				{name = "CLA45SB2", costs = 85000, model = "CLA45SB2"},
				{name = "S600", costs = 55000, model = "s600w220"},
				{name = "a45", costs = 55000, model = "a45"},
				{name = "W213", costs = 75000, model = "e63w213"},
			    {name = "S6 Brabus", costs = 105000, model = "s6brabus"},
			}
		},
		["bmw"] = {
			title = "bmw",
			name = "bmw",
			buttons = {
			    {name = "M5", costs = 20000, model = "m5e39"},
			    {name = "M4", costs = 120000, model = "bmwm4"},
			    {name = "X5", costs = 65000, model = "x5e53"},
			    {name = "Mini Cooper Works", costs = 28000, model = "cooperworks"},
				{name = "BMW 750li", costs = 60000, model = "750li"},
				{name = "BMW 750l", costs = 75000, model = "750li2"},
				{name = "lumma 750", costs = 135000, model = "lumma750"},
				{name = "90s BMW 535i", costs = 16000, model = "bmwe34"},
				{name = "90s BMW 750i", costs = 18000, model = "bmwe38"},
				{name = "00s BMW 750i", costs = 35000, model = "bmwe65"},			
			}
		},		
		["volkswagen"] = {
			title = "volkswagen",
			name = "volkswagen",
			buttons = {
			    {name = "Passat Estate", costs = 30000, model = "passatr"},
				{name = "Golf MK6", costs = 23000, model = "VWMK6"},
				{name = "Fox", costs = 7000, model = "VFOX"},
				{name = "Golf MK2", costs = 12000, model = "vgmk2gti"},
				{name = "R50", costs = 35000, model = "r50"},
			}	
		},
		["vauxhall"] = {
			title = "vauxhall",
			name = "vauxhall",
			buttons = {	
				{name = "Corsa 09", costs = 13000, model = "corsa09"},
				{name = "Astra", costs = 17000, model = "astraj"},
			}
		},
		["peugeot"] = {
			title = "peugeot",
			name = "peugeot",
			buttons = {	
				{name = "308", costs = 17000, model = "peug308"},
				{name = "208", costs = 14000, model = "208"},
				{name = "207", costs = 14000, model = "p207"},
			}
		},
		["mazda"] = {
			title = "mazda",
			name = "mazda",
			buttons = {
				{name = "RX8", costs = 35000, model = "rx804"},
				{name = "Stanced MX5", costs = 30000, model = "miata3"},
				{name = "Stanced Mazdaspeed3", costs = 65000, model = "ma3"},
				{name = "Mazda3", costs = 8000, model = "mz3"},
				{name = "90s Miata", costs = 45000, model = "na6"},
			}
		},
		["honda"] = {
			title = "honda",
			name = "honda",
			buttons = {	
			    {name = "CRX", costs = 18000, model = "crx2"},
				{name = "Integra", costs = 45000, model = "integra"},
				{name = "S2000", costs = 55000, model = "ap2"},
				{name = "Civic Type R", costs = 60000, model = "fk8"},
			}
		},
		["citroen"] = {
			title = "citroen",
			name = "citroen",
			buttons = {	
				{name = "ds3", costs = 18000, model = "ds3"},
			}
		},
		["ford"] = {
			title = "ford",
			name = "ford",
			buttons = {
			    {name = "Escort", costs = 9000, model = "fe86"},
			    {name = "Mustang Boss302", costs = 175000, model = "boss302"},
				{name = "Ford F150 6x6", costs = 285000, model = "velociraptor"},
			    {name = "F150 Rapter", costs = 85000, model = "f150"},
				{name = "C250 Super Duty", costs = 325000, model = "04f250k"},
			}
		},
		["chevrolet"] = {
			title = "chevrolet",
			name = "chevrolet",
			buttons = {
				{name = "ZR1", costs = 220000, model = "corvettezr1"},
				{name = "Camaro SS", costs = 110000, model = "camaro_ss"},
				{name = "94 Silverado", costs = 18000, model = "SILVER94"},
				{name = "Trailblazer", costs = 25000, model = "TRAILBLAZER"},
				{name = "GMT400", costs = 35000, model = "GMT400"},
				{name = "Stingray", costs = 87500, model = "STINGRAY66"},
				{name = "ZL1", costs = 180000, model = "2018zl1"},
			}
		},
		["dodge"] = {
			title = "dodge",
			name = "dodge",
			buttons = { 
			    {name = "Viper", costs = 250000, model = "viper" },
			    {name = "Charger SRT", costs = 65000, model = "srt392" },
				{name = "Challenger R/T", costs = 35000, model = "challengerrt" },
				{name = "Dodge Charger R/T", costs = 45000, model = "chargerrt" },
				{name = "Dodge Charger SRT8", costs = 90000, model = "chargerrt" },
				{name = "MEGA Ram", costs = 250000, model = "megaram" },
			}
		},
		["porsche"] = {
			title = "porsche",
			name = "porsche",
			buttons = {
			    {name = "911 Turbo S", costs = 255000, model = "911tbs"},
			    {name = "2018 Cayenne", costs = 165000, model = "pcs18"},
				{name = "718 Boxster", costs = 220000, model = "718boxster"},
				{name = "Cayenne", costs = 135000, model = "cayenne"},
				{name = "Panamera Turbo ", costs = 300000, model = "panamera17turbo"},
				{name = "Speedster", costs = 275000, model = "str20"}, -- needs buff
			}
		},
		["ferrari"] = {
			title = "ferrari",
			name = "ferrari",
			buttons = {	
				{name = "458", costs = 350000, model = "458"},
				{name = "458", costs = 425000, model = "f8t"},
				{name = "f812", costs = 500000, model = "f812"},
				{name = "F60", costs = 3000000, model = "F60"},
				{name = "laferrari", costs = 3500000, model = "laferrari"},
				{name = "f40", costs = 4000000, model = "f40"},
			}
		},
		["lamborghini"] = {
			title = "lamborghini",
			name = "lamborghini",
			buttons = {	
				{name = "Urus 4x4", costs = 190000, model = "urus"},
				{name = "Aventador", costs = 400000, model = "aventador"},
				--{name = "Diablo", costs = 3500000, model = "diablostallion"},
				{name = "Asterion", costs = 1000000, model = "ASTERION"},
				{name = "Centario", costs = 2300000, model = "lp770"},
				{name = "Centario Roadster", costs = 2500000, model = "lp770r"},
			}
		},
		["mclaren"] = {
			title = "mclaren",
			name = "mclaren",
			buttons = {	
			  {name = "P1", costs = 2050000, model = "p1"},
			}
		},
		["bugatti"] = {
			title = "bugatti",
			name = "bugatti",
			buttons = {	
			    {name = "Divo", costs = 6500000, model = "bdivo"},
				{name = "Veyron", costs = 2000000, model = "veyron"},
				{name = "chiron 2017", costs = 2300000, model = "2017chiron"},
				{name = "chiron 2019", costs = 2500000, model = "2019chiron"},
			}
		},
		["others"] = {
			title = "others",
			name = "others",
			buttons = {
			    {name = "Jaguar XF", costs = 65000, model = "xfr"},
			    {name = "Toyota Corolla", costs = 8000, model = "levin86"},
			    {name = "Maserati Ghibli", costs = 60000, model = "ghibli"},
				{name = "Mitsubishi EVO9", costs = 75000, model = "evo9"},
				{name = "Mitsubishi EVO10", costs = 85000, model = "evox"},	
			    {name = "Saab 93", costs = 11000, model = "saab"},
			    {name = "lexus LX570", costs = 95000, model = "wald2018"},
			    {name = "lexus IS350", costs = 120000, model = "is350"},
				{name = "Tesla Model S", costs = 225000, model = "tmodel"},
				{name = "Stanced Impreza", costs = 75000, model = "subwrx"},
			    {name = "Subaru Wagon", costs = 33000, model = "subaruwagon2002"},
				{name = "90s Drift Subaru", costs = 55000, model = "subarugt"},
				{name = "Subaru Impreza", costs = 65000, model = "subarusti7"},
				{name = "Subaru Impreza STI", costs = 95000, model = "impreza3"},
				{name = "Aston Martin DB9", costs = 295000, model = "db9v"},
				{name = "Lexus LX570", costs = 35000, model = "lx2018"},
				{name = "Lexus RCF", costs = 70000, model = "rcf"},
				{name = "Chrysler Crossfire", costs = 25000, model = "srt6r"},
			    {name = "2019 Shelby GT500", costs = 135000, model = "19gt500"},
				{name = "Renault Twingo", costs = 3000, model = "twingo"},
				{name = "Toyota Rav4", costs = 13000, model = "rav4"},
				{name = "Suzuki Grand Vitara", costs = 12000, model = "suzukigv"},
				{name = "Chrysler 300C", costs = 10000, model = "chry300"},
				{name = "Quad Ltr450", costs = 30000, model = "ltr450s"},
				{name = "Infiniti QX56", costs = 40000, model = "qx56"},
				{name = "BFbenito", costs = 175000, model = "BFbenito"},
				{name = "Land Rover Discovery", costs = 60000, model = "FX4"},
				{name = "Kia Optima", costs = 20000, model = "OPTIMA"},
				{name = "Bentley Bentayga", costs = 200000, model = "bentaygast"},
				{name = "Fiat tipo", costs = 5000, model = "FTIPO"},
				{name = "Koenigsegg CC8S", costs = 5000000, model = "cc8s"},
				{name = "Hummer H1", costs = 250000, model = "HH1"},
				{name = "Shelby Cobra", costs = 1000000, model = "cobra"},
				{name = "Shelby gt500", costs = 85000, model = "gt500"},
			}
		},
	}
}


local fakecar = { model = '', car = nil}
local vehshop_locations = {entering = {-33.803,-1102.322,25.422}, inside = {-46.56327,-1097.382,25.99875, 120.1953}, outside = {-31.849,-1090.648,25.998,322.345}}
local inrangeofvehshop = false
local currentlocation = {entering = {-33.803,-1102.322,25.422}, inside = {-46.56327,-1097.382,25.99875, 120.1953}, outside = {-31.849,-1090.648,25.998,322.345}}
local boughtcar = false

function drawTxt2(text,font,centre,x,y,scale,r,g,b,a)

end

function IsPlayerInRangeOfVehshop()
return inrangeofvehshop
end

Citizen.CreateThread(function()
 local blip = AddBlipForCoord(-33.803, -1102.322, 25.422)
 SetBlipSprite (blip, 326)
 SetBlipDisplay(blip, 4)
 SetBlipScale  (blip, 0.8)
 SetBlipAsShortRange(blip, true)
 BeginTextCommandSetBlipName("STRING")
 AddTextComponentString("Vehicle Shop")
 EndTextCommandSetBlipName(blip)
 while true do
  Citizen.Wait(5)
  local coords = GetEntityCoords(GetPlayerPed(-1), true)
  if GetDistanceBetweenCoords(coords, -32.726, -1102.195, 26.422, true) < 20 then
   DrawMarker(27, -32.726, -1102.195, 26.422-0.95, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5, 0,155,255,200,0,0,0,0)
   if GetDistanceBetweenCoords(coords, -32.726, -1102.195, 26.422, true) < 2 then
    drawTxt('~g~[E]~w~ Vehicle Store')
    inrange = true
    if IsControlJustPressed(0, 38) then 
	 if vehshop.opened then
	  CloseCreator()
	 else
	  OpenCreator()
	  exports['NRP-notify']:DoHudText('inform', 'If You Have Frozen In Here Reload Fivem Its Due to Your New Character! Sorry For the Inconvience')
	 end
    end
   end
  end
  if GetDistanceBetweenCoords(coords, -45.357, -1082.406, 26.207, true) < 25 then
   DrawMarker(27, -45.357, -1082.406, 25.807, 0, 0, 0, 0, 0, 0, 2.5, 2.5, 0.5, 0,155,255,200,0,0,0,0)
   if GetDistanceBetweenCoords(coords, -45.357, -1082.406, 26.207, true) < 2.5 then
    drawTxt('~g~[E]~w~ Sell Vehicle 50% Of RRP')
  	if IsControlJustPressed(0, 38) then
     TriggerServerEvent('carshop:sell', GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false)))
  	end
   end
  end
 end
end)



function f(n)
return n + 0.0001
end

function try(f, catch_f)
local status, exception = pcall(f)
if not status then
catch_f(exception)
end
end
function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

function OpenCreator()
	boughtcar = false
	local ped = GetPlayerPed(-1)
	local pos = currentlocation.inside
	FreezeEntityPosition(ped,true)
	SetEntityVisible(ped,false)
	local g = Citizen.InvokeNative(0xC906A7DAB05C8D2B,pos[1],pos[2],pos[3],Citizen.PointerValueFloat(),0)
	SetEntityCoords(ped,pos[1],pos[2],g)
	SetEntityHeading(ped,pos[4])
	vehshop.currentmenu = "main"
	vehshop.opened = true
	vehshop.selectedbutton = 0
end


local vehicle_price = 0
function CloseCreator()
	Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
	Citizen.CreateThread(function()
		local ped = GetPlayerPed(-1)
		if not boughtcar then
			local pos = currentlocation.entering
			SetEntityCoords(ped,pos[1],pos[2],pos[3])
			FreezeEntityPosition(ped,false)
			SetEntityVisible(ped,true)
		end
		vehshop.opened = false
		vehshop.menu.from = 1
		vehshop.menu.to = 10
	end)
end

function drawMenuButton(button,x,y,selected)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(menu.scale, menu.scale)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(255, 255, 255, 255)
	end
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(button.name)
	if selected then
		DrawRect(x,y,menu.width,menu.height,255,255,255,255)
	else
		DrawRect(x,y,menu.width,menu.height,0,0,0,150)
	end
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end

function drawMenuInfo(text)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(0.45, 0.45)
	SetTextColour(255, 255, 255, 255)
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawRect(0.675, 0.95,0.65,0.050,0,0,0,150)
	DrawText(0.365, 0.934)
end

function drawMenuRight(txt,x,y,selected)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(menu.scale, menu.scale)
	SetTextRightJustify(1)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(255, 255, 255, 255)
	end
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawText(x + menu.width/2 - 0.03, y - menu.height/2 + 0.0028)
end

function drawMenuTitle(txt,x,y)
local menu = vehshop.menu
	SetTextFont(2)
	SetTextProportional(0)
	SetTextScale(0.5, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawRect(x,y,menu.width,menu.height,0,0,0,150)
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end
function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
function Notify(text)
SetNotificationTextEntry('STRING')
AddTextComponentString(text)
DrawNotification(false, false)
end

local backlock = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if IsControlJustPressed(1,201) and IsPlayerInRangeOfVehshop() then
			if vehshop.opened then
				CloseCreator()
			else
				OpenCreator()
			end
		end
		if vehshop.opened then
			local ped = GetPlayerPed(-1)
			local menu = vehshop.menu[vehshop.currentmenu]
			drawTxt2(vehshop.title,1,1,vehshop.menu.x,vehshop.menu.y,1.0, 255,255,255,255)
			drawMenuTitle(menu.title, vehshop.menu.x,vehshop.menu.y + 0.08)
			drawTxt2(vehshop.selectedbutton.."/"..tablelength(menu.buttons),0,0,vehshop.menu.x + vehshop.menu.width/2 - 0.0385,vehshop.menu.y + 0.067,0.4, 255,255,255,255)
			local y = vehshop.menu.y + 0.12
			buttoncount = tablelength(menu.buttons)
			local selected = false

			for i,button in pairs(menu.buttons) do
				if i >= vehshop.menu.from and i <= vehshop.menu.to then

					if i == vehshop.selectedbutton then
						selected = true
					else
						selected = false
					end
					drawMenuButton(button,vehshop.menu.x,y,selected)
					if button.costs ~= nil then
						if vehshop.currentmenu == "compacts" or vehshop.currentmenu == "coupes" or vehshop.currentmenu == "sedans" or vehshop.currentmenu == "sports" or vehshop.currentmenu == "sportsclassics" or vehshop.currentmenu == "super" or vehshop.currentmenu == "muscle" or vehshop.currentmenu == "offroad" or vehshop.currentmenu == "suvs" or vehshop.currentmenu == "vans" or vehshop.currentmenu == "industrial" or vehshop.currentmenu == "cycles" or vehshop.currentmenu == "motorcycles" or vehshop.currentmenu == "toyota" or vehshop.currentmenu == "nissan" or vehshop.currentmenu == "audi" or vehshop.currentmenu == "mercedes" or vehshop.currentmenu == "bmw" or vehshop.currentmenu == "volkswagen" or vehshop.currentmenu == "vauxhall" or vehshop.currentmenu == "peugeot" or vehshop.currentmenu == "mazda" or vehshop.currentmenu == "honda" or vehshop.currentmenu == "citroen" or vehshop.currentmenu == "ford" or vehshop.currentmenu == "chevrolet" or vehshop.currentmenu == "dodge" or vehshop.currentmenu == "porsche" or vehshop.currentmenu == "ferrari" or vehshop.currentmenu == "lamborghini" or vehshop.currentmenu == "mclaren" or vehshop.currentmenu == "bugatti" or vehshop.currentmenu == "others" then
						 drawMenuRight("~g~$"..button.costs*getVat(17),vehshop.menu.x,y,selected)
						else
						 drawMenuRight("~g~$"..button.costs*getVat(17),vehshop.menu.x,y,selected)
						end
					end
					y = y + 0.04
					if vehshop.currentmenu == "compacts" or vehshop.currentmenu == "coupes" or vehshop.currentmenu == "sedans" or vehshop.currentmenu == "sports" or vehshop.currentmenu == "sportsclassics" or vehshop.currentmenu == "super" or vehshop.currentmenu == "muscle" or vehshop.currentmenu == "offroad" or vehshop.currentmenu == "suvs" or vehshop.currentmenu == "vans" or  vehshop.currentmenu == "industrial" or vehshop.currentmenu == "cycles" or vehshop.currentmenu == "motorcycles" or vehshop.currentmenu == "toyota" or vehshop.currentmenu == "nissan" or vehshop.currentmenu == "audi" or vehshop.currentmenu == "mercedes" or vehshop.currentmenu == "bmw" or vehshop.currentmenu == "volkswagen" or vehshop.currentmenu == "vauxhall" or vehshop.currentmenu == "peugeot" or vehshop.currentmenu == "mazda" or vehshop.currentmenu == "honda" or vehshop.currentmenu == "citroen" or vehshop.currentmenu == "ford" or vehshop.currentmenu == "chevrolet" or vehshop.currentmenu == "dodge" or vehshop.currentmenu == "porsche" or vehshop.currentmenu == "ferrari" or vehshop.currentmenu == "lamborghini" or vehshop.currentmenu == "mclaren" or vehshop.currentmenu == "bugatti" or vehshop.currentmenu == "others"then
						if selected then
							if fakecar.model ~= button.model then
								if DoesEntityExist(fakecar.car) then
									Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
								end
								local pos = currentlocation.inside
								local hash = GetHashKey(button.model)
								RequestModel(hash)
								while not HasModelLoaded(hash) do
									Citizen.Wait(0)

								end
								local veh = CreateVehicle(hash,pos[1],pos[2],pos[3],pos[4],false,false)
								while not DoesEntityExist(veh) do
									Citizen.Wait(0)
								end
								FreezeEntityPosition(veh,true)
								SetEntityInvincible(veh,true)
								SetVehicleDoorsLocked(veh,4)
								--SetEntityCollision(veh,false,false)
								TaskWarpPedIntoVehicle(GetPlayerPed(-1),veh,-1)
								for i = 0,24 do
									SetVehicleModKit(veh,0)
									RemoveVehicleMod(veh,i)
								end
								fakecar = { model = button.model, car = veh}
							end
						end
					end
					if selected and IsControlJustPressed(1,201) then
						ButtonSelected(button)
					end
				end
			end
		end
		if vehshop.opened then
			if IsControlJustPressed(1,202) then
				Back()
			end
			if IsControlJustReleased(1,202) then
				backlock = false
			end
			if IsControlJustPressed(1,188) then
				if vehshop.selectedbutton > 1 then
					vehshop.selectedbutton = vehshop.selectedbutton -1
					if buttoncount > 15 and vehshop.selectedbutton < vehshop.menu.from then
						vehshop.menu.from = vehshop.menu.from -1
						vehshop.menu.to = vehshop.menu.to - 1
					end
				end
			end
			if IsControlJustPressed(1,187)then
				if vehshop.selectedbutton < buttoncount then
					vehshop.selectedbutton = vehshop.selectedbutton +1
					if buttoncount > 15 and vehshop.selectedbutton > vehshop.menu.to then
						vehshop.menu.to = vehshop.menu.to + 1
						vehshop.menu.from = vehshop.menu.from + 1
					end
				end
			end
		end

	end
end)


function round(num, idp)
  if idp and idp>0 then
    local mult = 10^idp
    return math.floor(num * mult + 0.5) / mult
  end
  return math.floor(num + 0.5)
end
function ButtonSelected(button)
	local ped = GetPlayerPed(-1)
	local this = vehshop.currentmenu
	local btn = button.name
	if this == "main" then
		if btn == "Vehicles" then
			OpenMenu('vehicles')
		elseif btn == "Motorcycles" then
			OpenMenu('motorcycles')
		elseif btn == "Customs" then
			OpenMenu('customs')	
		end
	elseif this == "vehicles" then
		if btn == "Sports" then
			OpenMenu('sports')
		elseif btn == "Sedans" then
			OpenMenu('sedans')
		elseif btn == "Compacts" then
			OpenMenu('compacts')
		elseif btn == "Coupes" then
			OpenMenu('coupes')
		elseif btn == "Sports Classics" then
			OpenMenu("sportsclassics")
		elseif btn == "Super" then
			OpenMenu('super')
		elseif btn == "Muscle" then
			OpenMenu('muscle')
		elseif btn == "Off-Road" then
			OpenMenu('offroad')
		elseif btn == "SUVs" then
			OpenMenu('suvs')
		elseif btn == "Vans" then
			OpenMenu('vans')
		end	
	elseif this == "customs" then
		if btn == "Toyota" then
			OpenMenu('toyota')
		elseif btn == "Nissan" then
			OpenMenu('nissan')
		elseif btn == "Audi" then
			OpenMenu('audi')
		elseif btn == "Mercedes" then
			OpenMenu('mercedes')
		elseif btn == "BMW" then
			OpenMenu("bmw")
		elseif btn == "Volkswagen" then
			OpenMenu('volkswagen')
		elseif btn == "Vauxhall" then
			OpenMenu('vauxhall')
		elseif btn == "Peugeot" then
			OpenMenu('peugeot')
		elseif btn == "Mazda" then
			OpenMenu('mazda')
		elseif btn == "Honda" then
			OpenMenu('honda')
		elseif btn == "Citroen" then
			OpenMenu('citroen')
		elseif btn == "Ford" then
			OpenMenu('ford')
		elseif btn == "Chevrolet" then
			OpenMenu('chevrolet')
		elseif btn == "Dodge" then
			OpenMenu('dodge')
		elseif btn == "Porsche" then
			OpenMenu('porsche')
		elseif btn == "Ferrari" then
			OpenMenu('ferrari')
		elseif btn == "Lamborghini" then
			OpenMenu('lamborghini')
		elseif btn == "Mclaren" then
			OpenMenu('mclaren')
		elseif btn == "Bugatti" then
			OpenMenu('bugatti')
		elseif btn == "Others" then
			OpenMenu('others')	
		end
	elseif this == "compacts" or this == "coupes" or this == "sedans" or this == "sports" or this == "sportsclassics" or this == "super" or this == "muscle" or this == "offroad" or this == "suvs" or this == "vans" or  this == "industrial" or this == "cycles" or this == "motorcycles" or this == "toyota" or this == "nissan" or this == "audi" or this == "mercedes" or this == "bmw" or this == "volkswagen" or this == "vauxhall" or this == "peugeot" or this == "mazda" or this == "honda" or this == "citroen" or this == "ford" or this == "chevrolet" or this== "dodge" or this == "porsche" or this == "ferrari" or this == "lamborghini" or this == "mclaren" or this == "bugatti" or this == "others" then
		local price = button.costs*getVat(17)
		local vehicleProps = GetVehProps(GetVehiclePedIsIn(GetPlayerPed(-1), false))
		local model = GetDisplayNameFromVehicleModel(vehicleProps.model)
		TriggerServerEvent('carshop:buy', vehicleProps, price, model)
	end
end

function OpenMenu(menu)
	fakecar = {model = '', car = nil}
	vehshop.lastmenu = vehshop.currentmenu
	if menu == "vehicles" then 
		vehshop.lastmenu = "main"
	elseif menu == "bikes"  then
		vehshop.lastmenu = "main"
	elseif menu == "customs"  then
		vehshop.lastmenu = "main"	
	elseif menu == 'race_create_objects' then
		vehshop.lastmenu = "main"
	elseif menu == "race_create_objects_spawn" then
		vehshop.lastmenu = "race_create_objects"
	end
	vehshop.menu.from = 1
	vehshop.menu.to = 15
	vehshop.selectedbutton = 0
	vehshop.currentmenu = menu
end


function Back()
	if backlock then
		return
	end
	backlock = true
	if vehshop.currentmenu == "main" then
		CloseCreator()
	elseif vehshop.currentmenu == "compacts" or vehshop.currentmenu == "coupes" or vehshop.currentmenu == "sedans" or vehshop.currentmenu == "sports" or vehshop.currentmenu == "sportsclassics" or vehshop.currentmenu == "super" or vehshop.currentmenu == "muscle" or vehshop.currentmenu == "offroad" or vehshop.currentmenu == "suvs" or vehshop.currentmenu == "vans" or vehshop.currentmenu == "industrial" or vehshop.currentmenu == "cycles" or vehshop.currentmenu == "motorcycles" or vehshop.currentmenu == "toyota" or vehshop.currentmenu == "nissan" or vehshop.currentmenu == "audi" or vehshop.currentmenu == "mercedes" or vehshop.currentmenu == "bmw" or vehshop.currentmenu == "volkswagen" or vehshop.currentmenu == "vauxhall" or vehshop.currentmenu == "peugeot" or vehshop.currentmenu == "mazda" or vehshop.currentmenu == "honda" or vehshop.currentmenu == "citroen" or vehshop.currentmenu == "ford" or vehshop.currentmenu == "chevrolet" or vehshop.currentmenu == "dodge" or vehshop.currentmenu == "porsche" or vehshop.currentmenu == "ferrari" or vehshop.currentmenu == "lamborghini" or vehshop.currentmenu == "mclaren" or vehshop.currentmenu == "bugatti" or vehshop.currentmenu == "others"then
		if DoesEntityExist(fakecar.car) then
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
		end
		fakecar = {model = '', car = nil}
		OpenMenu(vehshop.lastmenu)
	else
		OpenMenu(vehshop.lastmenu)
	end

end

function stringstarts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end

--[[RegisterNetEvent("carshop:bought")
AddEventHandler("carshop:bought",function(data, plate)
	boughtcar = true
    CloseCreator()
	FreezeEntityPosition(GetPlayerPed(-1),false)
	SetEntityVisible(GetPlayerPed(-1),true)
	RequestModel(data.model)
	while not HasModelLoaded(data.model) do
	Citizen.Wait(0)
	end
	spawned = CreateVehicle(data.model, -46.677, -1110.872, 26.436, 70.008, true, false)
	SetVehicleProperties(spawned, data)
	SetVehicleNumberPlateText(spawned, plate)
	SetEntityAsMissionEntity(spawned, true, true)
	SetVehicleIsConsideredByPlayer(spawned, true)
	TaskWarpPedIntoVehicle(GetPlayerPed(-1), spawned, -1)
end)
]]
function GetVehProps(vehicle)
  local color1, color2 = GetVehicleColours(vehicle)
  local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)

  return {
    model            = GetEntityModel(vehicle),
    plate            = GetVehicleNumberPlateText(vehicle),
    plateIndex       = GetVehicleNumberPlateTextIndex(vehicle),
	health           = GetVehicleEngineHealth(vehicle),
    dirtLevel        = GetVehicleDirtLevel(vehicle),
    color1           = color1,
    color2           = color2,
    pearlescentColor = pearlescentColor,
    wheelColor       = wheelColor,
    wheels           = GetVehicleWheelType(vehicle),
    customTires      = GetVehicleModVariation(vehicle, 23),
    windowTint       = GetVehicleWindowTint(vehicle),
    neonEnabled      = {
     IsVehicleNeonLightEnabled(vehicle, 0),
     IsVehicleNeonLightEnabled(vehicle, 1),
     IsVehicleNeonLightEnabled(vehicle, 2),
     IsVehicleNeonLightEnabled(vehicle, 3),
    },
    neonColor        = table.pack(GetVehicleNeonLightsColour(vehicle)),
    tyreSmokeColor   = table.pack(GetVehicleTyreSmokeColor(vehicle)),
    modSpoilers      = GetVehicleMod(vehicle, 0),
    modFrontBumper   = GetVehicleMod(vehicle, 1),
    modRearBumper    = GetVehicleMod(vehicle, 2),
    modSideSkirt     = GetVehicleMod(vehicle, 3),
    modExhaust       = GetVehicleMod(vehicle, 4),
    modFrame         = GetVehicleMod(vehicle, 5),
    modGrille        = GetVehicleMod(vehicle, 6),
    modHood          = GetVehicleMod(vehicle, 7),
    modFender        = GetVehicleMod(vehicle, 8),
    modRightFender   = GetVehicleMod(vehicle, 9),
    modRoof          = GetVehicleMod(vehicle, 10),
    modEngine        = GetVehicleMod(vehicle, 11),
    modBrakes        = GetVehicleMod(vehicle, 12),
    modTransmission  = GetVehicleMod(vehicle, 13),
    modHorns         = GetVehicleMod(vehicle, 14),
    modSuspension    = GetVehicleMod(vehicle, 15),
    modArmor         = GetVehicleMod(vehicle, 16),
    modTurbo         = IsToggleModOn(vehicle,  18),
    modSmokeEnabled  = IsToggleModOn(vehicle,  20),
    modXenon         = IsToggleModOn(vehicle,  22),
    modFrontWheels   = GetVehicleMod(vehicle, 23),
    modBackWheels    = GetVehicleMod(vehicle, 24),
    modPlateHolder    = GetVehicleMod(vehicle, 25),
    modVanityPlate    = GetVehicleMod(vehicle, 26),
    modTrimA        = GetVehicleMod(vehicle, 27),
    modOrnaments      = GetVehicleMod(vehicle, 28),
    modDashboard      = GetVehicleMod(vehicle, 29),
    modDial         = GetVehicleMod(vehicle, 30),
    modDoorSpeaker      = GetVehicleMod(vehicle, 31),
    modSeats        = GetVehicleMod(vehicle, 32),
    modSteeringWheel    = GetVehicleMod(vehicle, 33),
    modShifterLeavers   = GetVehicleMod(vehicle, 34),
    modAPlate       = GetVehicleMod(vehicle, 35),
    modSpeakers       = GetVehicleMod(vehicle, 36),
    modTrunk        = GetVehicleMod(vehicle, 37),
    modHydrolic       = GetVehicleMod(vehicle, 38),
    modEngineBlock      = GetVehicleMod(vehicle, 39),
    modAirFilter      = GetVehicleMod(vehicle, 40),
    modStruts       = GetVehicleMod(vehicle, 41),
    modArchCover      = GetVehicleMod(vehicle, 42),
    modAerials        = GetVehicleMod(vehicle, 43),
    modTrimB        = GetVehicleMod(vehicle, 44),
    modTank         = GetVehicleMod(vehicle, 45),
    modWindows        = GetVehicleMod(vehicle, 46),
	modLivery       = GetVehicleLivery(vehicle),
	modLivery2       = GetVehicleMod(vehicle, 48),
	maxFuelLevel = DecorGetInt(vehicle, "_Max_Fuel_Level")
	
  }

end

RegisterNetEvent('vehstore:delete')
AddEventHandler('vehstore:delete', function()
 local ped = GetPlayerPed(-1)
 local vehicle = GetVehiclePedIsIn(ped, false)
 SetEntityAsMissionEntity(vehicle, true, true)
 DeleteVehicle(vehicle)
 DeleteEntity(vehicle)
end)

function SetVehicleProperties(vehicle, props)
  SetVehicleModKit(vehicle,  0)

  if props.plate ~= nil then
    SetVehicleNumberPlateText(vehicle,  props.plate)
  end

  if props.plateIndex ~= nil then
    SetVehicleNumberPlateTextIndex(vehicle,  props.plateIndex)
  end

  if props.health ~= nil and not IsThisModelABike(GetEntityModel(vehicle)) then
	if tonumber(props.health) < 750 then
     SetEntityHealth(vehicle, 700)
     SetVehicleDamage(vehicle, 0.0, 1.0, 0.1, 250.0, 1650.0, true) --800
     SetVehicleDamage(vehicle, -0.2, 1.0, 0.5, 250.0, 600.0, true) -- 50
     SetVehicleDamage(vehicle, -0.7, -0.2, 0.3, 250.0, 450.0, true) --00 50
     SetEntityHealth(vehicle, 700)
     SetVehicleBodyHealth(vehicle, 700)
	 SetVehicleEngineHealth(vehicle, 700)
	end
	if tonumber(props.health) < 500 then
		SetEntityHealth(vehicle, 500)
		SetVehicleDamage(vehicle, 0.0, 1.0, 0.1, 250.0, 1950.0, true) --800
		SetVehicleDamage(vehicle, -0.2, 1.0, 0.5, 250.0, 700.0, true) -- 50
		SetVehicleDamage(vehicle, -0.7, -0.2, 0.3, 250.0, 550.0, true) --00 50
		SetEntityHealth(vehicle, 500)
		SetVehicleBodyHealth(vehicle, 500)
		SetVehicleEngineHealth(vehicle, 500)
	end
	if tonumber(props.health) < 250 then
		SetEntityHealth(vehicle, 250)
		SetVehicleDamage(vehicle, 0.0, 1.0, 0.1, 250.0, 2400.0, true) --800
		SetVehicleDamage(vehicle, -0.2, 1.0, 0.5, 250.0, 750.0, true) -- 50
		SetVehicleDamage(vehicle, -0.7, -0.2, 0.3, 250.0, 600.0, true) --00 50
		SetEntityHealth(vehicle, 250)
		SetVehicleBodyHealth(vehicle, 250)
		SetVehicleEngineHealth(vehicle, 250)
	end
	if tonumber(props.health) < 100 then
		SetEntityHealth(vehicle, 100)
		SetVehicleDamage(vehicle, 0.0, 1.0, 0.1, 250.0, 2500.0, true) --800
		SetVehicleDamage(vehicle, -0.2, 1.0, 0.5, 250.0, 850.0, true) -- 50
		SetVehicleDamage(vehicle, -0.7, -0.2, 0.3, 250.0, 700.0, true) --00 50
		SetEntityHealth(vehicle, 100)
		SetVehicleBodyHealth(vehicle, 100)
		SetVehicleEngineHealth(vehicle, 100)
	end
	exports['NRP-notify']:DoHudText('inform', 'Vehicle Health : '..props.health..'%')
  end

  if props.dirtLevel ~= nil then
    SetVehicleDirtLevel(vehicle,  props.dirtLevel)
  end

  if props.color1 ~= nil then
    local color1, color2 = GetVehicleColours(vehicle)
    SetVehicleColours(vehicle, props.color1, color2)
  end

  if props.color2 ~= nil then
    local color1, color2 = GetVehicleColours(vehicle)
    SetVehicleColours(vehicle, color1, props.color2)
  end

  if props.pearlescentColor ~= nil then
    local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
    SetVehicleExtraColours(vehicle,  props.pearlescentColor,  wheelColor)
  end

  if props.wheelColor ~= nil then
    local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
    SetVehicleExtraColours(vehicle,  pearlescentColor,  props.wheelColor)
  end

  if props.wheels ~= nil then
    SetVehicleWheelType(vehicle,  props.wheels)
  end

  if props.windowTint ~= nil then
    SetVehicleWindowTint(vehicle,  props.windowTint)
  end

  if props.neonEnabled ~= nil then
    SetVehicleNeonLightEnabled(vehicle, 0, props.neonEnabled[1])
    SetVehicleNeonLightEnabled(vehicle, 1, props.neonEnabled[2])
    SetVehicleNeonLightEnabled(vehicle, 2, props.neonEnabled[3])
    SetVehicleNeonLightEnabled(vehicle, 3, props.neonEnabled[4])
  end

  if props.neonColor ~= nil then
    SetVehicleNeonLightsColour(vehicle,  props.neonColor[1], props.neonColor[2], props.neonColor[3])
  end

  if props.modSmokeEnabled ~= nil then
    ToggleVehicleMod(vehicle, 20, true)
  end

  if props.tyreSmokeColor ~= nil then
    SetVehicleTyreSmokeColor(vehicle,  props.tyreSmokeColor[1], props.tyreSmokeColor[2], props.tyreSmokeColor[3])
  end

  if props.modSpoilers ~= nil then
    SetVehicleMod(vehicle, 0, props.modSpoilers, false)
  end

  if props.modFrontBumper ~= nil then
    SetVehicleMod(vehicle, 1, props.modFrontBumper, false)
  end

  if props.modRearBumper ~= nil then
    SetVehicleMod(vehicle, 2, props.modRearBumper, false)
  end

  if props.modSideSkirt ~= nil then
    SetVehicleMod(vehicle, 3, props.modSideSkirt, false)
  end

  if props.modExhaust ~= nil then
    SetVehicleMod(vehicle, 4, props.modExhaust, false)
  end

  if props.modFrame ~= nil then
    SetVehicleMod(vehicle, 5, props.modFrame, false)
  end

  if props.modGrille ~= nil then
    SetVehicleMod(vehicle, 6, props.modGrille, false)
  end

  if props.modHood ~= nil then
    SetVehicleMod(vehicle, 7, props.modHood, false)
  end

  if props.modFender ~= nil then
    SetVehicleMod(vehicle, 8, props.modFender, false)
  end

  if props.modRightFender ~= nil then
    SetVehicleMod(vehicle, 9, props.modRightFender, false)
  end

  if props.modRoof ~= nil then
    SetVehicleMod(vehicle, 10, props.modRoof, false)
  end

  if props.modEngine ~= nil then
    SetVehicleMod(vehicle, 11, props.modEngine, false)
  end

  if props.modBrakes ~= nil then
    SetVehicleMod(vehicle, 12, props.modBrakes, false)
  end

  if props.modTransmission ~= nil then
    SetVehicleMod(vehicle, 13, props.modTransmission, false)
  end

  if props.modHorns ~= nil then
    SetVehicleMod(vehicle, 14, props.modHorns, false)
  end

  if props.modSuspension ~= nil then
    SetVehicleMod(vehicle, 15, props.modSuspension, false)
  end

  if props.modArmor ~= nil then
    SetVehicleMod(vehicle, 16, props.modArmor, false)
  end

  if props.modTurbo ~= nil then
    ToggleVehicleMod(vehicle,  18, props.modTurbo)
  end

  if props.modXenon ~= nil then
    ToggleVehicleMod(vehicle,  22, props.modXenon)
  end

  if props.modFrontWheels ~= nil then
    SetVehicleMod(vehicle, 23, props.modFrontWheels, false)
  end

  if props.modBackWheels ~= nil then
    SetVehicleMod(vehicle, 24, props.modBackWheels, false)
  end

  if props.modPlateHolder ~= nil then
    SetVehicleMod(vehicle, 25, props.modPlateHolder , false)
  end

  if props.modVanityPlate ~= nil then
    SetVehicleMod(vehicle, 26, props.modVanityPlate , false)
  end

  if props.modTrimA ~= nil then
    SetVehicleMod(vehicle, 27, props.modTrimA , false)
  end

  if props.modOrnaments ~= nil then
    SetVehicleMod(vehicle, 28, props.modOrnaments , false)
  end

  if props.modDashboard ~= nil then
    SetVehicleMod(vehicle, 29, props.modDashboard , false)
  end

  if props.modDial ~= nil then
    SetVehicleMod(vehicle, 30, props.modDial , false)
  end

  if props.modDoorSpeaker ~= nil then
    SetVehicleMod(vehicle, 31, props.modDoorSpeaker , false)
  end

  if props.modSeats ~= nil then
    SetVehicleMod(vehicle, 32, props.modSeats , false)
  end

  if props.modSteeringWheel ~= nil then
    SetVehicleMod(vehicle, 33, props.modSteeringWheel , false)
  end

  if props.modShifterLeavers ~= nil then
    SetVehicleMod(vehicle, 34, props.modShifterLeavers , false)
  end

  if props.modAPlate ~= nil then
    SetVehicleMod(vehicle, 35, props.modAPlate , false)
  end

  if props.modSpeakers ~= nil then
    SetVehicleMod(vehicle, 36, props.modSpeakers , false)
  end

  if props.modTrunk ~= nil then
    SetVehicleMod(vehicle, 37, props.modTrunk , false)
  end

  if props.modHydrolic ~= nil then
    SetVehicleMod(vehicle, 38, props.modHydrolic , false)
  end

  if props.modEngineBlock ~= nil then
    SetVehicleMod(vehicle, 39, props.modEngineBlock , false)
  end

  if props.modAirFilter ~= nil then
    SetVehicleMod(vehicle, 40, props.modAirFilter , false)
  end

  if props.modStruts ~= nil then
    SetVehicleMod(vehicle, 41, props.modStruts , false)
  end

  if props.modArchCover ~= nil then
    SetVehicleMod(vehicle, 42, props.modArchCover , false)
  end

  if props.modAerials ~= nil then
    SetVehicleMod(vehicle, 43, props.modAerials , false)
  end

  if props.modTrimB ~= nil then
    SetVehicleMod(vehicle, 44, props.modTrimB , false)
  end

  if props.modTank ~= nil then
    SetVehicleMod(vehicle, 45, props.modTank , false)
  end

  if props.modWindows ~= nil then
    SetVehicleMod(vehicle, 46, props.modWindows , false)
  end

  if props.modLivery ~= nil then
	SetVehicleLivery(vehicle, props.modLivery)
  end

  if props.modLivery2 ~= nil then
	SetVehicleMod(vehicle, 48, props.modLivery2, false)
  end
  
  if props.customTires == 1 then
	SetVehicleMod(vehicle, 23, GetVehicleMod(vehicle, 23), true)
	SetVehicleMod(vehicle, 24, GetVehicleMod(vehicle, 23), true)	
  end
  if props.health ~= nil then
	SetVehicleEngineHealth(vehicle, props.health+0.00)
  end 
end

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