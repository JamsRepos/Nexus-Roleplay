K9Config = {}
K9Config = setmetatable(K9Config, {})

K9Config.OpenMenuIdentifierRestriction = true
K9Config.OpenMenuPedRestriction = false
K9Config.LicenseIdentifiers = {
	"license:dea595884c791e6c879704312d8e0e4097b708e4",
	"license:dea595884c791e6c879704312d8e0e4097b708e4",
	
}
K9Config.SteamIdentifiers = {
	"steam:11000010496981b",
	"steam:110000109f12052"
}
K9Config.PedsList = {
	"g_m_y_ballasout_01",
	"g_m_y_ballaorig_01"
}

-- Restricts the dog to getting into certain vehicles
K9Config.VehicleRestriction = false
K9Config.VehiclesList = {
	
}

-- Searching Type ( RANDOM [AVAILABLE] | VRP [NOT AVAILABLE] | ESX [NOT AVAILABLE] )
K9Config.SearchType = "Random"
K9Config.OpenDoorsOnSearch = true

-- Used for Random Search Type --
K9Config.Items = {
	--[[{item = "Cocaine", illegal = true},
	{item = "Marijuana", illegal = true},
	{item = "Blunt Spray", illegal = false},
	{item = "Crowbar", illegal = false},
	{item = "Lockpicks", illegal = false},
	{item = "Baggies", illegal = false},
	{item = "Used Needle", illegal = false},
	{item = "Open Container", illegal = false},]]--
}

-- Language --
K9Config.LanguageChoice = "English"
K9Config.Languages = {
	["English"] = {
		follow = "Come",
		stop = "Heel",
		attack = "Bite",
		enter = "In",
		exit = "Out"
	}
}