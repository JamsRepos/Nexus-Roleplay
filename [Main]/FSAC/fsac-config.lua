FSAC = {}
--[[=====================================================================
||                       _____ ____    _    ____                       ||
||                      |  ___/ ___|  / \  / ___|                      ||
||                      | |_  \___ \ / _ \| |                          ||
||                      |  _|  ___) / ___ \ |___                       ||
||                      |_|   |____/_/   \_\____|                      ||
||                                                                     ||
|| The FiveStar AntiCheat resource will detect cheaters on your FiveM  ||
|| server.                                                             ||
||                                                                     ||
|| When a cheater is flagged, they will be temporarily banned from     ||
|| your server and their identifers will be sent to the FSAC web panel ||
|| for review. FSAC Staff will determine if a user was cheating and    ||
|| either remove the temporary ban or implement a global ban.          ||
||                                                                     ||
|| If you need any assistance, please feel free to create a support    ||
|| ticket on the FSAC Web Panel (https://fivestarac.net)               ||
||                                                                     ||
=====================================================================]]--

-- FSAC License key
-- Generate a key on the FSAC Web Panel (https://fivestarac.net)
FSAC.LicenseKey = ''

-- Language Setting
-- Supported Languages: en
FSAC.Lang = 'en'

-- Require all players to have a Discord account connected to join your server
-- This DOES NOT require them to be in your Discord Server, they just have their Discord identifier connected to FiveM
FSAC.RequireDiscord = false

-- Identifiers in this list will ignore global bans
-- If an alert is generated on this server, these players will still be temporarily banned until FSAC Staff reviews the temp ban
FSAC.IgnoreGlobalBans = {

}