-- Resource Manifest
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

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