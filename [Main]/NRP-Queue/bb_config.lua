Config = {}

Config.DiscordServerID = 699702073951912028 -- Discord Server ID
Config.DiscordBotToken = "Njk5NzExNzE3OTQ4NjUzNjcw.XpYXUQ.JZSw2UCwpTWKIshcwxAXc3DYv34" -- Discord Bot Token. You can create one on https://discord.com/developers/applications
Config.maxServerSlots = 40

Config.Roles = {
	Owner = {
		roleID = "699702705123491990",
		points = 100,
		name = "Owner"
	},

	LeadAdmin = {
		roleID = "713166994471518269",
		points = 90,
		name = "Senior Management"
	},

	CommunityManager = {
		roleID = "715722762412359702",
		points = 90,
		name = "Senior Management"
	},

	ServerAdmin = {
		roleID = "713167412735770635",
		points = 80,
		name = "Senior Management"
	},

	ServerModerator = {
		roleID = "713167480339562527",
		points = 70,
		name = "Moderator"
	},

	SupportTeam = {
		roleID = "713167547096367167",
		points = 60,
		name = "Support Team"
	},

	SupportTeam = {
		roleID = "715258665132752946",
		points = 50,
		name = "Helper"
	},

	DiamondSupporter = {
		roleID = "713169762233876613",
		points = 40,
		name = "Diamond Supporter"
	},

	GoldSupporter = {
		roleID = "715622594174255114",
		points = 30,
		name = "Gold Supporter"
	},

	SilverSupporter = {
		roleID = "715622664953266176",
		points = 20,
		name = "Silver Supporter"
	},

	BronzeSupporter = {
		roleID = "715622738886262805",
		points = 10,
		name = "Bronze Supporter"
	},

	NitroBooster = {
		roleID = "715656360120942623",
		points = 5,
		name = "Nitro Booster"
	},
}

Config.Colors = {
	"accent",
	"good",
	"warning",
	"attention",
}

Config.NotWhitelisted = "Sorry, I didn't find you in our database."
Config.NoDiscord = "We could not find a Discord Client running so we are giving you the default queue priority."
Config.NoSteam = "Error: Please ensure you have Steam running in the background. We use this to authenticate you to our server. If you already have Steam running, please restart your FiveM client."

Config.Error = "Error: It seems you lost connection to our server at one point, please restart your FiveM client and try again."
Config.HandshakingWith = "Please wait whilst we authenticate...\n\nIf you have been stuck here for a while, you will need to restart Steam and FiveM in order to fix this issue."
