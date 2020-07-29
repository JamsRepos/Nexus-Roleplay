fx_version 'adamant'
game 'gta5'


ui_page {
    'html/ui.html',
}

files {
	'html/ui.html',
	'html/js/app.js', 
	'html/css/style.css',
}


client_script	'client/main.lua'

export	'DoShortHudText'
export	'DoHudText'
export	'DoLongHudText'
export	'DoCustomHudText'
export	'PersistentHudText'
