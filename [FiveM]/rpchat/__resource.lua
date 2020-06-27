--[[

  ESX RP Chat

--]]

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'RP Chat'

dependency 'GHMattiMySQL'

version '1.0.0'

client_script 'client/main.lua'

server_scripts {
  'server/main.lua'
}
