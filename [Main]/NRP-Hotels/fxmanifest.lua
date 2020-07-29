fx_version 'adamant'
game 'gta5'

-- Resource Manifest

-- MySQL Support
dependency 'GHMattiMySQL'

-- Menu Support
client_script 'warmenu.lua'

-- Motels
client_script 'motels/client.lua'
server_script 'motels/server.lua'

-- Storage
client_script 'storage/motel_client.lua'
server_script 'storage/server.lua'