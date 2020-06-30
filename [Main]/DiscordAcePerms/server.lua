-----------------------------------
--- Discord ACE Perms by Badger ---
-----------------------------------

--- Code ---

roleList = {
{715258665132752946, "FGAdmins"}, -- Helper
{713167547096367167, "FGAdmins"}, -- Support Team
{713167480339562527, "FGAdmins"}, -- Server Moderator
{713167412735770635, "FGAdmins"}, -- Admin
{715722762412359702, "FGAdmins"}, -- Community Manager
{713166994471518269, "FGAdmins"}, -- Lead Admin
{699702705123491990, "FGAdmins"}, -- Owner
}
local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end
function PlayerIdentifier(type, id)
    local identifiers = {}
    local numIdentifiers = GetNumPlayerIdentifiers(id)

    for a = 0, numIdentifiers do
        table.insert(identifiers, GetPlayerIdentifier(id, a))
    end

    for b = 1, #identifiers do
        if string.find(identifiers[b], type, 1) then
            return identifiers[b]
        end
    end
    return false
end
function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

hasPermsAlready = {}

AddEventHandler('playerConnecting', function()
	local src = source
	local hex = string.sub(tostring(PlayerIdentifier("steam", src)), 7)
	permAdd = "add_principal identifier.steam:" .. hex .. " "
	for k, v in ipairs(GetPlayerIdentifiers(src)) do
			if string.sub(v, 1, string.len("discord:")) == "discord:" then
				identifierDiscord = v
			end
	end
	if identifierDiscord then
		if not has_value(hasPermsAlready, GetPlayerName(src)) then
			local roleIDs = exports.discord_perms:GetRoles(src)
			if not (roleIDs == false) then
				for i = 1, #roleList do
					for j = 1, #roleIDs do
						if (tostring(roleList[i][1]) == tostring(roleIDs[j])) then
							print("Added " .. GetPlayerName(src) .. " to role group " .. roleList[i][2] .. " with discordRole ID: " .. roleIDs[j])
							ExecuteCommand(permAdd .. roleList[i][2])
						end
					end
				end
				table.insert(hasPermsAlready, GetPlayerName(src))
			else
				print(GetPlayerName(src) .. " has not gotten their permissions cause roleIDs == false")
			end
		end
	end
end)

RegisterServerEvent("DiscordAcePerms:GivePerms")
AddEventHandler("DiscordAcePerms:GivePerms", function(_source)
	-- Deprecated
end)
			