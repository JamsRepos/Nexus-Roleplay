fx_version 'adamant'
game 'gta5'

-- Resource Manifest

-- MySQL Support
dependency 'GHMattiMySQL'
client_script '@global_api/client.lua'

-- Menu Support
client_script 'base/warmenu.lua'
server_script 'base/server.lua'
client_script 'base/client.lua'

-- Jobs

-- Lumberjack
client_script 'lumberjack/client.lua'
client_script 'lumberjack/trees.json'
server_script 'lumberjack/server.lua'

-- Fishing 
client_script 'fishing/client.lua'

-- trucking
client_script 'trucking/trucking.lua'
client_script 'trucking/fuel.lua'
client_script 'trucking/box.lua'
client_script 'trucking/boat.lua'
-- Taxi
client_script 'taxi/client.lua'
server_script 'taxi/server.lua'

-- Fast Food System
client_script 'fastfood/client.lua'
server_script 'fastfood/server.lua'

-- Post OP
client_script 'post_op/client.lua'

-- Maintenance
client_script 'maintenance/client.lua'
--vineyard
client_script 'vineyard/deliver.lua'
client_script 'vineyard/function.lua'
client_script 'vineyard/pick.lua'
--miner
--client_script 'xz-miner/client.lua'
--server_script 'xz-miner/server.lua'
--smoke
--client_script 'xz-smoke/client.lua'
--client_script 'xz-smoke/weedruns.lua'
--server_script 'xz-smoke/server.lua'
