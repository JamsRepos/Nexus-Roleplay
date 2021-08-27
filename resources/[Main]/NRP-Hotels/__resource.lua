-- Resource Manifest
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

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