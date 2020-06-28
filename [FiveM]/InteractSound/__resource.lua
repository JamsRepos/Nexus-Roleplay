
------
-- InteractSound by Scott
-- Verstion: v0.0.1
------

-- Manifest Version
resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

-- Client Scripts
client_script 'client/main.lua'

-- Server Scripts
server_script 'server/main.lua'

-- NUI Default Page
ui_page('client/html/index.html')

-- Files needed for NUI
-- DON'T FORGET TO ADD THE SOUND FILES TO THIS!
files({
    'client/html/index.html',
    -- Begin Sound Files Here...
    -- client/html/sounds/ ... .ogg
    'client/html/sounds/stop_vehicle.ogg',
	'client/html/sounds/stop_vehicle-2.ogg',
    'client/html/sounds/demo.ogg',
    'client/html/sounds/ring.ogg',
    'client/html/sounds/lock.ogg',
    'client/html/sounds/Firearmdis.ogg',
    'client/html/sounds/VTheft.ogg',
    'client/html/sounds/get_out_of_here_now.ogg',
    'client/html/sounds/CDScomp.ogg',
    'client/html/sounds/move_along_people.ogg',
    'client/html/sounds/this_is_the_lspd.ogg',
    'client/html/sounds/door.ogg',
    'client/html/sounds/doorknock.ogg',
    'client/html/sounds/drinking.ogg',
    'client/html/sounds/eating.ogg',
    'client/html/sounds/belt.ogg',
    'client/html/sounds/fuel.ogg',
    'client/html/sounds/pager.ogg',
    
})
