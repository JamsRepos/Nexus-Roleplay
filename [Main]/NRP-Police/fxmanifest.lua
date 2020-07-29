fx_version 'adamant'
game 'gta5'

-- Resource Manifest

-- MySQL Support
dependency 'GHMattiMySQL'
client_script 'warmenu.lua'

-- Settings File
client_script 'settings.lua'

-- Officer's Clothing
--client_script 'clothing.lua'

client_script 'client.lua'
server_script 'server.lua'

-- Dispatch
client_script 'dispatch/client.lua'
server_script 'dispatch/server.lua'

ui_page	'dispatch/html/index.html'

files {
	'dispatch/html/css/style.css',
	'dispatch/html/fonts/pricedown.ttf',
	'dispatch/html/fonts/gta-ui.ttf',
	'dispatch/html/js/dispatch.js',
	'dispatch/html/js/alerts.js',
	'dispatch/html/index.html',
}

-- Doors
server_script "lockabledoors/server.lua"
client_script "lockabledoors/client.lua"