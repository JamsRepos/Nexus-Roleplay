resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"
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