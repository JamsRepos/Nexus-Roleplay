fx_version 'adamant'
game 'gta5'

-- Resource Manifest

-- MySQL Support
dependency 'GHMattiMySQL'


-- RLRP API
client_script '@global_api/client.lua'

-- Menu Support
client_script 'warmenu.lua'

client_script 'client.lua'
client_script 'cinema.lua'
client_script 'rent.lua'

server_script 'server.lua'