fx_version 'adamant'
game 'gta5'


dependency 'GHMattiMySQL'

client_script 'client.lua'
server_script 'server.lua'

ui_page('html/index.html')

files({
    'html/index.html',
    'html/script.js',
    'html/bootstrap.css',
    'html/style.css',
})


client_script 'lockabledoors/client.lua'
server_script 'lockabledoors/server.lua'
