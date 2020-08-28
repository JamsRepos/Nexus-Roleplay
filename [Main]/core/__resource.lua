resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

dependency 'GHMattiMySQL'

-- Player [Core]
client_script 'player/client.lua'
server_script 'player/player.lua'
server_script 'player/server.lua'
client_scirpt 'player/discord.lua'

-- Character [Selection]
client_script 'character/client.lua'
client_script 'character/skycam.lua'
server_script 'character/server.lua'

server_script 'server/restart.lua'

-- Vehicle Dealerships
--server_script 'imports/server.lua'
--client_script 'vehicles/client.lua'


ui_page('html/index.html')

files({
    'html/css.css',
    'html/index.html',
   -- 'html/script.js',
    'html/fl-script.js',
    'html/style.css',

    'html/img/logo.png',
    'html/img/chevron-left-128.png'
})

-- Character Clothing
client_script 'character_clothing/client.lua'
client_script 'character_clothing/gui.lua'
--client_script 'character_clothing/skin.lua'
--client_script 'character_clothing/barbers.lua'


-- Garage Store
client_script 'garage/client.lua'
server_script 'garage/server.lua'

-- Inventory
client_script 'inventory/client.lua'
server_script 'inventory/server.lua'
client_script 'inventory/items.lua'

-- Menu
client_script 'menu/client.lua'
client_script 'menu/warmenu.lua'

-- Stores
client_script 'stores/client.lua'
server_script 'stores/server.lua'

-- Vehicle Storage
client_script 'vehicle_storages/client.lua'
server_script 'vehicle_storages/server.lua'

-- Glove Storage
client_script 'glove_storages/client.lua'
server_script 'glove_storages/server.lua'

-- VAT
client_script 'vat/client.lua'
server_script 'vat/server.lua'

-- Server Password
--client_script 'verification/client.lua'
--server_script 'verification/server.lua'

client_script '@global_api/client.lua'

export 'getInventory'
export 'getQuantity'
export 'getWeapons'
export 'GetClothes'
export 'GetItemQuantity'
export 'TrimPlate'
export 'HasKey'
export 'getVehicles'
export 'getAllVehicles'
export 'globalObject'
server_export 'getCops'
server_export 'getEMS'
server_export 'getMechanics'
server_export 'GetActiveCharacter'
server_export 'GetActiveCharacterID'
server_export 'GetCharacterID'
server_export 'getPlayerFromId'
server_export 'getVat'
export 'getVat'