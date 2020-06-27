-- Resource Manifest
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_script 'warmenu.lua'

-- API
client_script '@global_api/client.lua'

-- Chopshop
--[[client_script 'chopshop/client.lua'
server_script 'chopshop/server.lua'

ui_page('chopshop/html/index.html')

files({
    'chopshop/html/index.html',
    'chopshop/html/script.js',
    'chopshop/html/style.css',
})
]]--
client_script "dg-guns/client.lua"

--golf
client_script 'golf/client.lua'

-- Pawn Shop
client_script 'pawnshop/client.lua'
server_script 'pawnshop/server.lua'

client_script 'tow/client.lua'
client_script 'tow/config.lua'

-- Weapons
client_script 'weapons/client.lua'
server_script 'weapons/server.lua'
client_script 'weapons/blackmarket.lua'
--client_script 'weapons/market.lua'

-- reputation
client_script 'reputation/client.lua'
server_script 'reputation/server.lua'

client_script 'gunrunning/client.lua'
server_script 'gunrunning/server.lua'

client_script 'robbing/client.lua'
server_script 'robbing/server.lua'

client_script 'meth/client.lua'
server_script 'meth/server.lua'

client_script 'weed/client.lua'

client_script 'drugs/client.lua'
server_script 'drugs/server.lua'

server_script 'moonshine/server.lua'
client_script 'moonshine/client.lua'

