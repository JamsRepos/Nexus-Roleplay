fx_version 'adamant'
game 'gta5'

-- Resource Manifest

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