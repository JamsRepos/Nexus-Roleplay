fx_version 'adamant'
game 'gta5'

-- Resource Manifest

-- MySQL Support
dependency 'GHMattiMySQL'

client_script 'warmenu.lua'
client_script 'client.lua'
server_script 'server.lua'

client_script 'storage/client.lua'
server_script 'storage/server.lua'

export 'getHouses'