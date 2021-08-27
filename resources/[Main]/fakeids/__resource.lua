resource_manifest_version "05cfa83c-a124-4cfa-a768-c24a5811d8f9"

client_script 'warmenu.lua'
client_script 'client.lua'
server_script 'server.lua'

-- RLRP API
client_script '@global_api/client.lua'

ui_page('source/index.html')

files {
    'source/index.html'
}