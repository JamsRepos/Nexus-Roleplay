fx_version 'adamant'
game 'gta5'


ui_page {
	'html/index.html',
}

files {
	'html/css/style.css',
	'html/fonts/pricedown.ttf',
	'html/fonts/gta-ui.ttf',
	'html/js/app.js',
	'html/index.html',
	"html/img/*.svg",
	"html/img/*.png",
	'html/css/jquery-ui.min.css',
	'html/js/jquery.min.js',
	'html/js/jquery-ui.min.js',
}

client_scripts {
	'hud-c.lua',
}

server_scripts {
	'hud-s.lua',
}

dependencies {
	'baseevents'
}