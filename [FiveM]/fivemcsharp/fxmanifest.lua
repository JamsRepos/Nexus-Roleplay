fx_version 'adamant'
game 'gta5'

description "FiveM resource replacement"
version "1"

client_scripts {
    "FiveM.Client.net.dll"
}

exports
{
	"hasSpawned"
}

server_scripts {
    "FiveM.Server.net.dll"
}