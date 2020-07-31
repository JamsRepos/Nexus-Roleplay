fx_version 'bodacious'
games { 'gta5' }

author 'FSAC Development Team'
description 'FiveM Anti-Cheat and Global Ban Management'
version 'v0.2'

client_scripts {
    'client/main.lua'
}

server_scripts {
    'fsac-config.lua',
    'server/main.lua'
}

provide 'FSAC'