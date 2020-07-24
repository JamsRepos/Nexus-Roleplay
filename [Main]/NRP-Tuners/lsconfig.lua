local colors = {
{name = "Black", colorindex = 0},{name = "Carbon Black", colorindex = 147},
{name = "Graphite", colorindex = 1},{name = "Anhracite Black", colorindex = 11},
{name = "Black Steel", colorindex = 2},{name = "Dark Steel", colorindex = 3},
{name = "Silver", colorindex = 4},{name = "Bluish Silver", colorindex = 5},
{name = "Rolled Steel", colorindex = 6},{name = "Shadow Silver", colorindex = 7},
{name = "Stone Silver", colorindex = 8},{name = "Midnight Silver", colorindex = 9},
{name = "Cast Iron Silver", colorindex = 10},{name = "Red", colorindex = 27},
{name = "Torino Red", colorindex = 28},{name = "Formula Red", colorindex = 29},
{name = "Lava Red", colorindex = 150},{name = "Blaze Red", colorindex = 30},
{name = "Grace Red", colorindex = 31},{name = "Garnet Red", colorindex = 32},
{name = "Sunset Red", colorindex = 33},{name = "Cabernet Red", colorindex = 34},
{name = "Wine Red", colorindex = 143},{name = "Candy Red", colorindex = 250},
{name = "Hot Pink", colorindex = 1250},{name = "Pfsiter Pink", colorindex = 137},
{name = "Salmon Pink", colorindex = 136},{name = "Sunrise Orange", colorindex = 36},
{name = "Orange", colorindex = 38},{name = "Bright Orange", colorindex = 138},
{name = "Gold", colorindex = 99},{name = "Bronze", colorindex = 90},
{name = "Yellow", colorindex = 88},{name = "Race Yellow", colorindex = 89},
{name = "Dew Yellow", colorindex = 91},{name = "Dark Green", colorindex = 49},
{name = "Racing Green", colorindex = 50},{name = "Sea Green", colorindex = 51},
{name = "Olive Green", colorindex = 52},{name = "Bright Green", colorindex = 53},
{name = "Gasoline Green", colorindex = 54},{name = "Lime Green", colorindex = 92},
{name = "Midnight Blue", colorindex = 141},
{name = "Galaxy Blue", colorindex = 61},{name = "Dark Blue", colorindex = 62},
{name = "Saxon Blue", colorindex = 63},{name = "Blue", colorindex = 64},
{name = "Mariner Blue", colorindex = 65},{name = "Harbor Blue", colorindex = 66},
{name = "Diamond Blue", colorindex = 67},{name = "Surf Blue", colorindex = 68},
{name = "Nautical Blue", colorindex = 69},{name = "Racing Blue", colorindex = 73},
{name = "Ultra Blue", colorindex = 70},{name = "Light Blue", colorindex = 74},
{name = "Chocolate Brown", colorindex = 96},{name = "Bison Brown", colorindex = 101},
{name = "Creeen Brown", colorindex = 750},{name = "Feltzer Brown", colorindex = 94},
{name = "Maple Brown", colorindex = 97},{name = "Beechwood Brown", colorindex = 103},
{name = "Sienna Brown", colorindex = 104},{name = "Saddle Brown", colorindex = 98},
{name = "Moss Brown", colorindex = 100},{name = "Woodbeech Brown", colorindex = 102},
{name = "Straw Brown", colorindex = 99},{name = "Sandy Brown", colorindex = 105},
{name = "Bleached Brown", colorindex = 106},{name = "Schafter Purple", colorindex = 71},
{name = "Spinnaker Purple", colorindex = 72},{name = "Midnight Purple", colorindex = 142},
{name = "Bright Purple", colorindex = 11750},{name = "Cream", colorindex = 107},
{name = "Ice White", colorindex = 111},{name = "Frost White", colorindex = 112}}
local metalcolors = {
{name = "Brushed Steel",colorindex = 117},
{name = "Brushed Black Steel",colorindex = 118},
{name = "Brushed Aluminum",colorindex = 119},
{name = "Pure Gold",colorindex = 158},
{name = "Brushed Gold",colorindex = 159}
}
local mattecolors = {
{name = "Black", colorindex = 12},
{name = "Gray", colorindex = 13},
{name = "Light Gray", colorindex = 14},
{name = "Ice White", colorindex = 131},
{name = "Blue", colorindex = 83},
{name = "Dark Blue", colorindex = 82},
{name = "Midnight Blue", colorindex = 84},
{name = "Midnight Purple", colorindex = 149},
{name = "Schafter Purple", colorindex = 148},
{name = "Red", colorindex = 39},
{name = "Dark Red", colorindex = 900},
{name = "Orange", colorindex = 41},
{name = "Yellow", colorindex = 42},
{name = "Lime Green", colorindex = 55},
{name = "Green", colorindex = 128},
{name = "Frost Green", colorindex = 151},
{name = "Foliage Green", colorindex = 155},
{name = "Olive Darb", colorindex = 152},
{name = "Dark Earth", colorindex = 153},
{name = "Desert Tan", colorindex = 154}
}



LSC_Config = {}
LSC_Config.prices = {}

--------Prices---------
LSC_Config.prices = {

------Window tint------
	windowtint = {
		{ name = "Pure Black - [Illegal]", tint = 1, price = 450},
		{ name = "Darksmoke", tint = 2, price = 350},
		{ name = "Lightsmoke", tint = 3, price = 250},
		{ name = "Limo", tint = 4, price = 150},
		{ name = "Green", tint = 5, price = 500},
	},

-------Respray--------
----Primary color---
	--Chrome 
	chrome = {
		colors = {
			{name = "Chrome", colorindex = 120}
		},
		price = 3500
	},
	--Classic 
	classic = {
		colors = colors,
		price = 500
	},
	--Matte 
	matte = {
		colors = mattecolors,
		price = 1000
	},
	--Metallic 
	metallic = {
		colors = colors,
		price = 750
	},
	--Metals 
	metal = {
		colors = metalcolors,
		price = 1000
	},

----Secondary color---
	--Chrome 
	chrome2 = {
		colors = {
			{name = "Chrome", colorindex = 120}
		},
		price = 1250
	},
	--Classic 
	classic2 = {
		colors = colors,
		price = 500
	},
	--Matte 
	matte2 = {
		colors = mattecolors,
		price = 500
	},
	--Metallic 
	metallic2 = {
		colors = colors,
		price = 500
	},
	--Metals 
	metal2 = {
		colors = metalcolors,
		price = 500
	},

------Neon layout------
	neonlayout = {
		{name = "Front,Back and Sides", price = 1000},
	},
	--Neon color
	neoncolor = {
		{ name = "White", neon = {255,255,255}, price = 175},
		{ name = "Blue [Illegal]", neon = {0,0,255}, price = 375},
		{ name = "Electric Blue [Illegal]", neon = {0,150,255}, price = 375},
		{ name = "Mint Green", neon = {50,255,155}, price = 200},
		{ name = "Lime Green", neon = {0,255,0}, price = 200},
		{ name = "Yellow", neon = {255,255,0}, price = 200},
		{ name = "Golden Shower", neon = {204,204,0}, price = 200},
		{ name = "Orange", neon = {255,128,0}, price = 200},
		{ name = "Red [Illegal]", neon = {255,0,0}, price = 375},
		{ name = "Pony Pink", neon = {255,102,255}, price = 200},
		{ name = "Hot Pink",neon = {255,0,255}, price = 200},
		{ name = "Purple", neon = {153,0,153}, price = 200},
		{ name = "Brown", neon = {139,69,19}, price = 200},
	},
	
--------Plates---------
	plates = {
		{ name = "Blue on White 1", plateindex = 0, price = 100},
		{ name = "Blue On White 2", plateindex = 3, price = 100},
		{ name = "Blue On White 3", plateindex = 4, price = 100},
		{ name = "Yellow on Blue", plateindex = 2, price = 100},
		{ name = "Yellow on Black", plateindex = 1, price = 100},
	},
	
--------Wheels--------
----Wheel accessories----
	wheelaccessories = {
		{ name = "Stock Tires", price = 0},
		{ name = "Custom Tires", price = 75},
		{ name = "White Tire Smoke",smokecolor = {254,254,254}, price = 150},
		{ name = "Black Tire Smoke", smokecolor = {1,1,1}, price = 150},
		{ name = "Blue Tire Smoke", smokecolor = {0,150,255}, price = 150},
		{ name = "Yellow Tire Smoke", smokecolor = {255,255,50}, price = 150},
		{ name = "Orange Tire Smoke", smokecolor = {255,153,51}, price = 150},
		{ name = "Red Tire Smoke", smokecolor = {255,10,10}, price = 150},
		{ name = "Green Tire Smoke", smokecolor = {10,255,10}, price = 150},
		{ name = "Purple Tire Smoke", smokecolor = {153,10,153}, price = 150},
		{ name = "Pink Tire Smoke", smokecolor = {255,102,178}, price = 150},
		{ name = "Gray Tire Smoke",smokecolor = {128,128,128}, price = 150},
	},

----Wheel color----
	wheelcolor = {
		colors = colors,
		price = 75,
	},

----Front wheel (Bikes)----
	frontwheel = {
		{name = "Stock", wtype = 6, mod = -1, price = 250},
		{name = "Speedway", wtype = 6, mod = 0, price = 250},
		{name = "Streetspecial", wtype = 6, mod = 1, price = 250},
		{name = "Racer", wtype = 6, mod = 2, price = 250},
		{name = "Trackstar", wtype = 6, mod = 3, price = 250},
		{name = "Overlord", wtype = 6, mod = 4, price = 250},
		{name = "Trident", wtype = 6, mod = 5, price = 250},
		{name = "Triplethreat", wtype = 6, mod = 6, price = 250},
		{name = "Stilleto", wtype = 6, mod = 7, price = 250},
		{name = "Wires", wtype = 6, mod = 8, price = 250},
		{name = "Bobber", wtype = 6, mod = 9, price = 250},
		{name = "Solidus", wtype = 6, mod = 10, price = 250},
		{name = "Iceshield", wtype = 6, mod = 11, price = 250},
		{name = "Loops", wtype = 6, mod = 12, price = 250},
	},

----Back wheel (Bikes)-----
	backwheel = {
		{name = "Stock", wtype = 6, mod = -1, price = 250},
		{name = "Speedway", wtype = 6, mod = 0, price = 250},
		{name = "Streetspecial", wtype = 6, mod = 1, price = 250},
		{name = "Racer", wtype = 6, mod = 2, price = 250},
		{name = "Trackstar", wtype = 6, mod = 3, price = 250},
		{name = "Overlord", wtype = 6, mod = 4, price = 250},
		{name = "Trident", wtype = 6, mod = 5, price = 250},
		{name = "Triplethreat", wtype = 6, mod = 6, price = 250},
		{name = "Stilleto", wtype = 6, mod = 7, price = 250},
		{name = "Wires", wtype = 6, mod = 8, price = 250},
		{name = "Bobber", wtype = 6, mod = 9, price = 250},
		{name = "Solidus", wtype = 6, mod = 10, price = 250},
		{name = "Iceshield", wtype = 6, mod = 11, price = 250},
		{name = "Loops", wtype = 6, mod = 12, price = 250},
	},

----Sport wheels-----
	sportwheels = {
		{name = "Stock", wtype = 0, mod = -1, price = 750},
		{name = "Inferno", wtype = 0, mod = 0, price = 750},
		{name = "Deepfive", wtype = 0, mod = 1, price = 750},
		{name = "Lozspeed", wtype = 0, mod = 2, price = 750},
		{name = "Diamondcut", wtype = 0, mod = 3, price = 750},
		{name = "Chrono", wtype = 0, mod = 4, price = 750},
		{name = "Feroccirr", wtype = 0, mod = 5, price = 750},
		{name = "Fiftynine", wtype = 0, mod = 6, price = 750},
		{name = "Mercie", wtype = 0, mod = 7, price = 750},
		{name = "Syntheticz", wtype = 0, mod = 8, price = 750},
		{name = "Organictyped", wtype = 0, mod = 9, price = 750},
		{name = "Endov1", wtype = 0, mod = 10, price = 750},
		{name = "Duper7", wtype = 0, mod = 11, price = 750},
		{name = "Uzer", wtype = 0, mod = 12, price = 750},
		{name = "Groundride", wtype = 0, mod = 13, price = 750},
		{name = "Spacer", wtype = 0, mod = 14, price = 750},
		{name = "Venum", wtype = 0, mod = 15, price = 750},
		{name = "Cosmo", wtype = 0, mod = 16, price = 750},
		{name = "Dashvip", wtype = 0, mod = 17, price = 750},
		{name = "Icekid", wtype = 0, mod = 18, price = 750},
		{name = "Ruffeld", wtype = 0, mod = 19, price = 750},
		{name = "Wangenmaster", wtype = 0, mod = 20, price = 750},
		{name = "Superfive", wtype = 0, mod = 21, price = 750},
	 	{name = "Endov2", wtype = 0, mod = 22, price = 750},
		{name = "Slitsix", wtype = 0, mod = 23, price = 750},
		{name = "Import", wtype = 0, mod = 24, price = 750},
		{name = "Import", wtype = 0, mod = 25, price = 750},
		{name = "Import", wtype = 0, mod = 26, price = 750},
		{name = "Import", wtype = 0, mod = 27, price = 750},
		{name = "Import", wtype = 0, mod = 28, price = 750},
		{name = "Import", wtype = 0, mod = 29, price = 750},
		{name = "Import", wtype = 0, mod = 30, price = 750},
		{name = "Import", wtype = 0, mod = 31, price = 750},
		{name = "Import", wtype = 0, mod = 32, price = 750},
		{name = "Import", wtype = 0, mod = 33, price = 750},
		{name = "Import", wtype = 0, mod = 34, price = 750},
		{name = "Import", wtype = 0, mod = 35, price = 750},
		{name = "Import", wtype = 0, mod = 36, price = 750},
		{name = "Import", wtype = 0, mod = 37, price = 750},
		{name = "Import", wtype = 0, mod = 38, price = 750},
		{name = "Import", wtype = 0, mod = 39, price = 750},
		{name = "Import", wtype = 0, mod = 40, price = 750},
		{name = "Import", wtype = 0, mod = 41, price = 750},
		{name = "Import", wtype = 0, mod = 42, price = 750},
		{name = "Import", wtype = 0, mod = 43, price = 750},
		{name = "Import", wtype = 0, mod = 44, price = 750},
		{name = "Import", wtype = 0, mod = 45, price = 750},
		{name = "Import", wtype = 0, mod = 46, price = 750},
		{name = "Import", wtype = 0, mod = 47, price = 750},
		{name = "Import", wtype = 0, mod = 48, price = 750},
		{name = "Import", wtype = 0, mod = 49, price = 750},
		{name = "Import", wtype = 0, mod = 50, price = 750},
		{name = "Import", wtype = 0, mod = 51, price = 750},
		{name = "Import", wtype = 0, mod = 52, price = 3500},
		{name = "Buggati 2019s Chrome Wall", wtype = 0, mod = 53, price = 100000},
		{name = "Buggati 2019s", wtype = 0, mod = 54, price = 95000},
		{name = "Buggati 2019s Full Chrome", wtype = 0, mod = 55, price = 150000},
		{name = "BBS Reps", wtype = 0, mod = 56, price = 3500},
		{name = "Import", wtype = 0, mod = 57, price = 3500},
		{name = "Import", wtype = 0, mod = 58, price = 3500},
		{name = "Import", wtype = 0, mod = 59, price = 3500},
		{name = "Import", wtype = 0, mod = 60, price = 3500},
		{name = "Import", wtype = 0, mod = 61, price = 3500},
		{name = "Import", wtype = 0, mod = 62, price = 3500},
		{name = "Import", wtype = 0, mod = 63, price = 3500},
		{name = "Import", wtype = 0, mod = 64, price = 3500},
		{name = "Import", wtype = 0, mod = 65, price = 3500},
		{name = "Works NightRiders", wtype = 0, mod = 66, price = 3500},
		{name = "Import", wtype = 0, mod = 67, price = 3500},
		{name = "Import", wtype = 0, mod = 68, price = 3500},
		{name = "Import", wtype = 0, mod = 69, price = 3500},
		{name = "Import", wtype = 0, mod = 70, price = 3500},
		{name = "Import", wtype = 0, mod = 71, price = 3500},
		{name = "Import", wtype = 0, mod = 72, price = 3500},
		{name = "Import", wtype = 0, mod = 73, price = 3500},
		{name = "Import", wtype = 0, mod = 74, price = 3500},
		{name = "Import", wtype = 0, mod = 75, price = 3500},
		{name = "Import", wtype = 0, mod = 76, price = 3500},
		{name = "Import", wtype = 0, mod = 77, price = 3500},
		{name = "Import", wtype = 0, mod = 78, price = 3500},
		{name = "Import", wtype = 0, mod = 79, price = 3500},
		{name = "Import", wtype = 0, mod = 80, price = 3500},
		{name = "SSR Fours", wtype = 0, mod = 81, price = 3500},
		{name = "BBS OGS", wtype = 0, mod = 82, price = 4500},
		{name = "Nismo Fives Black", wtype = 0, mod = 83, price = 11000},
		{name = "Nismo Fives", wtype = 0, mod = 84, price = 12000},
		{name = "NMR Splits", wtype = 0, mod = 85, price = 3500},
		{name = "LA OGS", wtype = 0, mod = 86, price = 18000},
		{name = "PVR Split Fives", wtype = 0, mod = 87, price = 10000},
		{name = "LA ballas", wtype = 0, mod = 88, price = 15000},
		{name = "Nissan Gtr Originals", wtype = 0, mod = 89, price = 10000},
		{name = "Rays Chrome Sixes", wtype = 0, mod = 90, price = 3500},
		{name = "ChromeWall Ninjas", wtype = 0, mod = 91, price = 3500},
		{name = "VS DeepFives", wtype = 0, mod = 92, price = 3500},
		{name = "VS Reps", wtype = 0, mod = 93, price = 4500},
		{name = "BAS Sevens", wtype = 0, mod = 94, price = 5500},
		{name = "Faboulous OGS", wtype = 0, mod = 95, price = 6500},
		{name = "SSR Reps", wtype = 0, mod = 96, price = 3500},
		{name = "SSR Diamondstars", wtype = 0, mod = 97, price = 4500},
		{name = "Split Ninjas", wtype = 0, mod = 98, price = 5500},
		{name = "Split Iport Sixes", wtype = 0, mod = 99, price = 3500},
		{name = "Enkei Splits", wtype = 0, mod = 100, price = 3500},
		{name = "Straight Sixes", wtype = 0, mod = 101, price = 3500},
		{name = "Enkei Rallyarts", wtype = 0, mod = 102, price = 3500},
		{name = "Volk Sixes", wtype = 0, mod = 103, price = 3500},
		{name = "Mines's Fives", wtype = 0, mod = 104, price = 3500},
		{name = "OZ Fives", wtype = 0, mod = 105, price = 3500},
		{name = "Split Quads", wtype = 0, mod = 106, price = 3500},
		{name = "OY Splits", wtype = 0, mod = 107, price = 3500},
		{name = "Slit Fives + Toyo Tyres", wtype = 0, mod = 108, price = 7500},

	},
-----Suv wheels------
	suvwheels = {
		{name = "Stock", wtype = 3, mod = -1, price = 750},
		{name = "Vip", wtype = 3, mod = 0, price = 750},
		{name = "Benefactor", wtype = 3, mod = 1, price = 750},
		{name = "Cosmo", wtype = 3, mod = 2, price = 750},
		{name = "Bippu", wtype = 3, mod = 3, price = 750},
		{name = "Royalsix", wtype = 3, mod = 4, price = 750},
		{name = "Fagorme", wtype = 3, mod = 5, price = 750},
		{name = "Deluxe", wtype = 3, mod = 6, price = 750},
		{name = "Icedout", wtype = 3, mod = 7, price = 750},
		{name = "Cognscenti", wtype = 3, mod = 8, price = 750},
		{name = "Lozspeedten", wtype = 3, mod = 9, price = 750},
		{name = "Supernova", wtype = 3, mod = 10, price = 750},
		{name = "Obeyrs", wtype = 3, mod = 11, price = 750},
		{name = "Lozspeedballer", wtype = 3, mod = 12, price = 750},
		{name = "Extra vaganzo", wtype = 3, mod = 13, price = 750},
		{name = "Splitsix", wtype = 3, mod = 14, price = 750},
		{name = "Empowered", wtype = 3, mod = 15, price = 750},
		{name = "Sunrise", wtype = 3, mod = 16, price = 750},
		{name = "Dashvip", wtype = 3, mod = 17, price = 750},
		{name = "Cutter", wtype = 3, mod = 18, price = 750},
	},
-----Offroad wheels-----
	offroadwheels = {
		{name = "Stock", wtype = 4, mod = -1, price = 750},
		{name = "Raider", wtype = 4, mod = 0, price = 750},
		{name = "Mudslinger", wtype = 4, modtype = 23, wtype = 4, mod = 1, price = 750},
		{name = "Nevis", wtype = 4, mod = 2, price = 750},
		{name = "Cairngorm", wtype = 4, mod = 3, price = 750},
		{name = "Amazon", wtype = 4, mod = 4, price = 750},
		{name = "Challenger", wtype = 4, mod = 5, price = 750},
		{name = "Dunebasher", wtype = 4, mod = 6, price = 750},
		{name = "Fivestar", wtype = 4, mod = 7, price = 750},
		{name = "Rockcrawler", wtype = 4, mod = 8, price = 750},
		{name = "Milspecsteelie", wtype = 4, mod = 9, price = 750},
	},
-----Tuner wheels------
	tunerwheels = {
		{name = "Stock", wtype = 5, mod = -1, price = 1500},
		{name = "Cosmo", wtype = 5, mod = 0, price = 1500},
		{name = "Supermesh", wtype = 5, mod = 1, price = 1500},
		{name = "Outsider", wtype = 5, mod = 2, price = 1500},
		{name = "Rollas", wtype = 5, mod = 3, price = 1500},
		{name = "Driffmeister", wtype = 5, mod = 4, price = 1500},
		{name = "Slicer", wtype = 5, mod = 5, price = 1500},
		{name = "Elquatro", wtype = 5, mod = 6, price = 1500},
		{name = "Dubbed", wtype = 5, mod = 7, price = 1500},
		{name = "Fivestar", wtype = 5, mod = 8, price = 1500},
		{name = "Slideways", wtype = 5, mod = 9, price = 1500},
		{name = "Apex", wtype = 5, mod = 10, price = 1500},
		{name = "Stancedeg", wtype = 5, mod = 11, price = 1500},
		{name = "Countersteer", wtype = 5, mod = 12, price = 1500},
		{name = "Endov1", wtype = 5, mod = 13, price = 1500},
		{name = "Endov2dish", wtype = 5, mod = 14, price = 1500},
		{name = "Guppez", wtype = 5, mod = 15, price = 1500},
		{name = "Chokadori", wtype = 5, mod = 16, price = 1500},
		{name = "Chicane", wtype = 5, mod = 17, price = 1500},
		{name = "Saisoku", wtype = 5, mod = 18, price = 1500},
		{name = "Dishedeight", wtype = 5, mod = 19, price = 1500},
		{name = "Fujiwara", wtype = 5, mod = 20, price = 1500},
		{name = "Zokusha", wtype = 5, mod = 21, price = 1500},
		{name = "Battlevill", wtype = 5, mod = 22, price = 1500},

	},
-----Highend wheels------
	highendwheels = {
		{name = "Stock", wtype = 7, mod = -1, price = 1750},
		{name = "Shadow", wtype = 7, mod = 0, price = 1750},
		{name = "Hyper", wtype = 7, mod = 1, price = 1750},
		{name = "Blade", wtype = 7, mod = 2, price = 1750},
		{name = "Diamond", wtype = 7, mod = 3, price = 1750},
		{name = "Supagee", wtype = 7, mod = 4, price = 1750},
		{name = "Chromaticz", wtype = 7, mod = 5, price = 1750},
		{name = "Merciechlip", wtype = 7, mod = 6, price = 1750},
		{name = "Obeyrs", wtype = 7, mod = 7, price = 1750},
		{name = "Gtchrome", wtype = 7, mod = 8, price = 1750},
		{name = "Cheetahr", wtype = 7, mod = 9, price = 1750},
		{name = "Solar", wtype = 7, mod = 10, price = 1750},
		{name = "Splitten", wtype = 7, mod = 11, price = 1750},
		{name = "Dashvip", wtype = 7, mod = 12, price = 1750},
		{name = "Lozspeedten", wtype = 7, mod = 13, price = 1750},
		{name = "Carboninferno", wtype = 7, mod = 14, price = 1750},
		{name = "Carbonshadow", wtype = 7, mod = 15, price = 1750},
		{name = "Carbonz", wtype = 7, mod = 16, price = 1750},
		{name = "Carbonsolar", wtype = 7, mod = 17, price = 1750},
		{name = "Carboncheetahr", wtype = 7, mod = 18, price = 1750},
		{name = "Carbonsracer", wtype = 7, mod = 19, price = 1750},
	},
-----Lowrider wheels------
	lowriderwheels = {
		{name = "Stock", wtype = 2, mod = -1, price = 900},
		{name = "Flare", wtype = 2, mod = 0, price = 900},
		{name = "Wired", wtype = 2, mod = 1, price = 900},
		{name = "Triplegolds", wtype = 2, mod = 2, price = 900},
		{name = "Bigworm", wtype = 2, mod = 3, price = 900},
		{name = "Sevenfives", wtype = 2, mod = 4, price = 900},
		{name = "Splitsix", wtype = 2, mod = 5, price = 900},
		{name = "Freshmesh", wtype = 2, mod = 6, price = 900},
		{name = "Leadsled", wtype = 2, mod = 7, price = 900},
		{name = "Turbine", wtype = 2, mod = 8, price = 900},
		{name = "Superfin", wtype = 2, mod = 9, price = 900},
		{name = "Classicrod", wtype = 2, mod = 10, price = 900},
		{name = "Dollar", wtype = 2, mod = 11, price = 22500},
		{name = "Dukes", wtype = 2, mod = 12, price = 900},
		{name = "Lowfive", wtype = 2, mod = 13, price = 900},
		{name = "Gooch", wtype = 2, mod = 14, price = 900},
	},
-----Muscle wheels-----
	musclewheels = {
		{name = "Stock", wtype = 1, mod = -1, price = 900},
		{name = "Classicfive", wtype = 1, mod = 0, price = 900},
		{name = "Dukes", wtype = 1, mod = 1, price = 900},
		{name = "Musclefreak", wtype = 1, mod = 2, price =900},
		{name = "Kracka", wtype = 1, mod = 3, price = 900},
		{name = "Azrea", wtype = 1, mod = 4, price = 900},
		{name = "Mecha", wtype = 1, mod = 5, price = 900},
		{name = "Blacktop", wtype = 1, mod = 6, price = 900},
		{name = "Dragspl", wtype = 1, mod = 7, price = 900},
		{name = "Revolver", wtype = 1, mod = 8, price = 900},
		{name = "Classicrod", wtype = 1, mod = 9, price = 900},
		{name = "Spooner", wtype = 1, mod = 10, price = 900},
		{name = "Fivestar", wtype = 1, mod = 11, price = 900},
		{name = "Oldschool", wtype = 1, mod = 12, price = 900},
		{name = "Eljefe", wtype = 1, mod = 13, price = 900},
		{name = "Dodman", wtype = 1, mod = 14, price = 900},
		{name = "Sixgun", wtype = 1, mod = 15, price = 900},
		{name = "Mercenary", wtype = 1, mod = 16, price = 900},
	},
	
---------Trim color--------
	trim = {
		colors = colors,
		price = 12
	},
	
----------Mods-----------
	mods = {
	
----------Liveries--------
	[48] = {
		startprice = 60,
		increaseby = 125
	},

	[49] = {
		startprice = 60,
		increaseby = 125
	},
	
----------Windows--------
	[46] = {
		startprice = 60,
		increaseby = 50
	},
	
----------Tank--------
	[45] = {
		startprice = 75,
		increaseby = 25
	},
	
----------Trim--------
	[44] = {
		startprice = 75,
		increaseby = 30
	},
	
----------Aerials--------
	[43] = {
		startprice = 100,
		increaseby = 10
	},

----------Arch cover--------
	[42] = {
		startprice = 125,
		increaseby = 75
	},

----------Struts--------
	[41] = {
		startprice = 75,
		increaseby = 35
	},
	
----------Air filter--------
	[40] = {
		startprice = 75,
		increaseby = 35
	},
	
----------Engine block--------
	[39] = {
		startprice = 800,
		increaseby = 400
	},

----------Hydraulics--------
	[38] = {
		startprice = 10000,
		increaseby = 1000
	},
	
----------Trunk--------
	[37] = {
		startprice = 850,
		increaseby = 200
	},

----------Speakers--------
	[36] = {
		startprice = 75,
		increaseby = 25
	},

----------Plaques--------
	[35] = {
		startprice = 85,
		increaseby = 25
	},
	
----------Shift leavers--------
	[34] = {
		startprice = 150,
		increaseby = 40
	},
	
----------Steeringwheel--------
	[33] = {
		startprice = 150,
		increaseby = 35
	},
	
----------Seats--------
	[32] = {
		startprice = 180,
		increaseby = 25
	},
	
----------Door speaker--------
	[31] = {
		startprice = 150,
		increaseby = 25
	},

----------Dial--------
	[30] = {
		startprice = 125,
		increaseby = 40
	},
----------Dashboard--------
	[29] = {
		startprice = 200,
		increaseby = 40
	},
	
----------Ornaments--------
	[28] = {
		startprice = 60,
		increaseby = 20
	},
	
----------Trim--------
	[27] = {
		startprice = 100,
		increaseby = 40
	},
	
----------Vanity plates--------
	[26] = {
		startprice = 100,
		increaseby = 10
	},
	
----------Plate holder--------
	[25] = {
		startprice = 100,
		increaseby = 25
	},
	
---------Headlights---------
	[22] = {
		{name = "Stock Lights", mod = 0, price = 0},
		{name = "Xenon Lights", mod = 1000, price = 75},
	},
	
----------Turbo---------
	[18] = {
		{ name = "None", mod = 0, price = 0},
		{ name = "Turbo Tuning", mod = 1, price = 7500},
	},
	
-----------Armor-------------
	[16] = {
	},

---------Suspension-----------
	[15] = {
		{name = "Lowered Suspension",mod = 0, price = 250},
		{name = "Street Suspension",mod = 1, price = 950},
		{name = "Sport Suspension",mod = 2, price = 2250},
		{name = "Competition Suspension",mod = 3, price = 4000},
	},

-----------Horn----------
	[14] = {
		{name = "Truck Horn", mod = 0, price = 2250},
		{name = "Clown Horn", mod = 2, price = 2250},
		{name = "Musical Horn 1", mod = 3, price = 2250},
		{name = "Musical Horn 2", mod = 4, price = 1750},
		{name = "Musical Horn 3", mod = 5, price = 1750},
		{name = "Musical Horn 4", mod = 6, price = 1750},
		{name = "Musical Horn 5", mod = 7, price = 1750},
		{name = "Sadtrombone Horn", mod = 8, price = 1750},
		{name = "Calssical Horn 1", mod = 9, price = 1750},
		{name = "Calssical Horn 2", mod = 10, price = 1750},
		{name = "Calssical Horn 3", mod = 11, price = 1750},
		{name = "Calssical Horn 4", mod = 12, price = 1750},
		{name = "Calssical Horn 5", mod = 13, price = 1750},
		{name = "Calssical Horn 6", mod = 14, price = 1750},
		{name = "Calssical Horn 7", mod = 15, price = 1750},
		{name = "Scaledo Horn", mod = 16, price = 1750},
		{name = "Scalere Horn", mod = 17, price = 1750},
		{name = "Scalemi Horn", mod = 18, price = 1750},
		{name = "Scalefa Horn", mod = 19, price = 1750},
		{name = "Scalesol Horn", mod = 20, price = 1750},
		{name = "Scalela Horn", mod = 21, price = 1750},
		{name = "Scaleti Horn", mod = 22, price = 1750},
		{name = "Scaledo Horn High", mod = 23, price = 1750},
		{name = "Jazz Horn 1", mod = 25, price = 1750},
		{name = "Jazz Horn 2", mod = 26, price = 1750},
		{name = "Jazz Horn 3", mod = 27, price = 1750},
		{name = "Jazzloop Horn", mod = 28, price = 1750},
		{name = "Starspangban Horn 1", mod = 29, price = 1750},
		{name = "Starspangban Horn 2", mod = 30, price = 1750},
		{name = "Starspangban Horn 3", mod = 31, price = 1750},
		{name = "Starspangban Horn 4", mod = 32, price = 1750},
		{name = "Classicalloop Horn 1", mod = 33, price = 1750},
		{name = "Classicalloop Horn 2", mod = 34, price = 1750},
		{name = "Classicalloop Horn 3", mod = 35, price = 1750},
	},

----------Transmission---------
	[13] = {
		{name = "Street Transmission", mod = 0, price = 1750},
		{name = "Sports Transmission", mod = 1, price = 3000},
		{name = "Race Transmission", mod = 2, price = 6500},	
	},
	
-----------Brakes-------------
	[12] = {
		{name = "Street Brakes", mod = 0, price = 1000},
		{name = "Sport Brakes", mod = 1, price = 2500},
		{name = "Race Brakes", mod = 2, price = 5250},
	},
	
------------Engine----------
	[11] = {
		{name = "EMS Upgrade, Level 2", mod = 0, price = 2500},
		{name = "EMS Upgrade, Level 3", mod = 1, price = 4500},
		{name = "EMS Upgrade, Level 4", mod = 2, price = 8000},
		{name = "EMS Upgrade, Race [illegal]", mod = 3, price = 20000},
	},
	
-------------Roof----------
	[10] = {
		{ name = "Roof 1", mod = 0, price = 250},
		{ name = "Roof 2", mod = 1, price = 275},
		{ name = "Roof 3", mod = 2, price = 300},
		{ name = "Roof 4", mod = 3, price = 325},
		{ name = "Roof 5", mod = 4, price = 350},
		{ name = "Roof 6", mod = 5, price = 375},
		{ name = "Roof 7", mod = 6, price = 400},
		{ name = "Roof 8", mod = 7, price = 425},
		{ name = "Roof 9", mod = 8, price = 450},
		{ name = "Roof 10", mod = 9, price = 475},
		{ name = "Roof 11", mod = 10, price = 500},
		{ name = "Roof 12", mod = 11, price = 525},
		{ name = "Roof 13", mod = 12, price = 550},
	},
	
------------Fenders---------
	[8] = {
		{ name = "Fenders 1", mod = 0, price = 250},
		{ name = "Fenders 2", mod = 1, price = 275},
		{ name = "Fenders 3", mod = 2, price = 300},
		{ name = "Fenders 4", mod = 3, price = 325},
		{ name = "Fenders 5", mod = 4, price = 350},
		{ name = "Fenders 6", mod = 5, price = 375},
		{ name = "Fenders 7", mod = 6, price = 400},
	},
	
------------Hood----------
	[7] = {
		{ name = "Hood 1", mod = 0, price = 250},
		{ name = "Hood 2", mod = 1, price = 275},
		{ name = "Hood 3", mod = 2, price = 300},
		{ name = "Hood 4", mod = 3, price = 325},
		{ name = "Hood 5", mod = 4, price = 350},
		{ name = "Hood 6", mod = 5, price = 375},
		{ name = "Hood 7", mod = 6, price = 400},
		{ name = "Hood 8", mod = 6, price = 425},
		{ name = "Hood 9", mod = 6, price = 450},
		{ name = "Hood 10", mod = 6, price = 475},
	},
	
----------Grille----------
	[6] = {
		{ name = "Grille 1", mod = 0, price = 250},
		{ name = "Grille 2", mod = 1, price = 275},
		{ name = "Grille 3", mod = 2, price = 300},
		{ name = "Grille 4", mod = 3, price = 325},
		{ name = "Grille 5", mod = 4, price = 350},
		{ name = "Grille 6", mod = 5, price = 375},
		{ name = "Grille 7", mod = 6, price = 400},
		{ name = "Grille 8", mod = 6, price = 475},
		{ name = "Grille 9", mod = 6, price = 500},
		{ name = "Grille 10", mod = 6, price = 525},
	},
	
----------Roll cage----------
	[5] = {
		{ name = "Roll cage 1", mod = 0, price = 2200},
		{ name = "Roll cage 2", mod = 1, price = 2500},
		{ name = "Roll cage 3", mod = 2, price = 2750},
		{ name = "Roll cage 4", mod = 3, price = 3000},
		{ name = "Roll cage 5", mod = 4, price = 3250},
	},
	
----------Exhaust----------
	[4] = {
		{ name = "Exhaust 1", mod = 0, price = 700},
		{ name = "Exhaust 2", mod = 1, price = 800},
		{ name = "Exhaust 3", mod = 2, price = 900},
		{ name = "Exhaust 4", mod = 3, price = 1000},
		{ name = "Exhaust 5", mod = 4, price = 1150},
	},
	
----------Skirts----------
	[3] = {
		{ name = "Skirts 1", mod = 0, price = 250},
		{ name = "Skirts 2", mod = 1, price = 275},
		{ name = "Skirts 3", mod = 2, price = 300},
		{ name = "Skirts 4", mod = 3, price = 325},
		{ name = "Skirts 5", mod = 4, price = 350},
		{ name = "Skirts 6", mod = 5, price = 375},
		{ name = "Skirts 7", mod = 6, price = 400},
		{ name = "Skirts 8", mod = 6, price = 475},
		{ name = "Skirts 9", mod = 6, price = 500},
		{ name = "Skirts 10", mod = 6, price = 525},
	},
	
-----------Rear bumpers----------
	[2] = {
		{ name = "Rear bumper 1", mod = 0, price = 500},
		{ name = "Rear bumper 2", mod = 1, price = 575},
		{ name = "Rear bumper 3", mod = 2, price = 675},
		{ name = "Rear bumper 4", mod = 3, price = 775},
		{ name = "Rear bumper 5", mod = 4, price = 875},
		{ name = "Rear bumper 6", mod = 5, price = 975},
		{ name = "Rear bumper 7", mod = 6, price = 1075},
		{ name = "Rear bumper 8", mod = 6, price = 1175},
		{ name = "Rear bumper 9", mod = 6, price = 1275},
		{ name = "Rear bumper 10", mod = 6, price = 1375},
	},
	
----------Front bumpers----------
	[1] = {
		{ name = "Front bumper 1", mod = 0, price = 500},
		{ name = "Front bumper 2", mod = 1, price = 600},
		{ name = "Front bumper 3", mod = 2, price = 700},
		{ name = "Front bumper 4", mod = 3, price = 800},
		{ name = "Front bumper5", mod = 4, price = 900},
		{ name = "Front bumper 6", mod = 5, price = 1000},
		{ name = "Front bumper 7", mod = 6, price = 1100},
		{ name = "Front bumper 8", mod = 6, price = 1200},
		{ name = "Front bumper 9", mod = 6, price = 1300},
		{ name = "Front bumper 10", mod = 6, price = 1400},
	},
	
----------Spoiler----------
	[0] = {
		{ name = "Spoiler 1", mod = 0, price = 400},
		{ name = "Spoiler 2", mod = 1, price = 500},
		{ name = "Spoiler3", mod = 2, price = 600},
		{ name = "Spoiler 4", mod = 3, price = 700},
		{ name = "Spoiler 5", mod = 4, price = 800},
		{ name = "Spoiler 6", mod = 5, price = 900},
		{ name = "Spoiler 7", mod = 6, price = 1000},
		{ name = "Spoiler 8", mod = 6, price = 1100},
		{ name = "Spoiler 9", mod = 6, price = 1200},
		{ name = "Spoiler 10", mod = 6, price = 1300},
	},
	}
	
}

------Model Blacklist--------
--Does'nt allow specific vehicles to be upgraded
LSC_Config.ModelBlacklist = {
	"lp770cop",
}


--Sets if garage will be locked if someone is inside it already
LSC_Config.lock = true

--Enable/disable old entering way
LSC_Config.oldenter = true

--Menu settings
LSC_Config.menu = {

-------Controls--------
	controls = {
		menu_up = 27,
		menu_down = 173,
		menu_left = 174,
		menu_right = 175,
		menu_select = 201,
		menu_back = 177
	},

-------Menu position-----
	--Possible positions:
	--Left
	--Right
	--Custom position, example: position = {x = 0.2, y = 0.2}
	position = "right",

-------Menu theme--------
	--Possible themes: light, darkred, bluish, greenish
	--Custom example:
	--[[theme = {
		text_color = { r = 255,g = 255, b = 255, a = 255},
		bg_color = { r = 0,g = 0, b = 0, a = 155},
		--Colors when button is selected
		stext_color = { r = 0,g = 0, b = 0, a = 255},
		sbg_color = { r = 255,g = 255, b = 0, a = 200},
	},]]
	theme = "light",
	
--------Max buttons------
	--Default: 10
	maxbuttons = 10,

-------Size---------
	--[[
	Default:
	width = 0.24
	height = 0.36
	]]
	width = 0.24,
	height = 0.36

}
