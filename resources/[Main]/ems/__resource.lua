-- Resource Manifest
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

-- RLRP API
client_script '@global_api/client.lua'
client_script '@peds/enum.lua'

-- MySQL Support
dependency 'GHMattiMySQL'
client_script 'warmenu.lua'

-- Settings File
client_script 'settings.lua'

client_script 'client.lua'
server_script 'server.lua'

ui_page('html/index.html')
files {'html/index.html'}