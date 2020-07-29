fx_version 'adamant'
game 'gta5'

--========================================================================================--
--=================================== Admin Core =========================================--
--========================================================================================--

-- Resource Manifest

-- Dependency
dependency 'GHMattiMySQL'

-- Client Script
client_script {
    'client.lua',
    'weapons.lua',
}

-- Server Script
server_script 'server.lua'