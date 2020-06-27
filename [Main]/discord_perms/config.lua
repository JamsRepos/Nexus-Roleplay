Config = {
	DiscordToken = "Njk5NzExNzE3OTQ4NjUzNjcw.XtAyeA.bnPP5OOF_jP3Hr-0YciyE64MWxg",
	GuildId = "699702073951912028",

	-- Format: ["Role Nickname"] = "Role ID" You can get role id by doing \@RoleName
	Roles = {
		["Nitro Booster"] = "715656360120942623", -- This would be checked by doing exports.discord_perms:IsRolePresent(user, "TestRole")
		["Civilian"] = "713169411930062971" -- This would be checked by doing exports.discord_perms:IsRolePresent(user, "TestRole")
	}
}
