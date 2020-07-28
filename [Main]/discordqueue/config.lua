Config = {
	Default_Prio = 500000, -- This is the default priority value if a discord isn't found
	AllowedPerTick = 1, -- How many players should we allow to connect at a time?
	HostDisplayQueue = true,
	onlyActiveWhenFull = true,
	Displays = {
		Prefix = 'Nexus Roleplay |',
		ConnectingLoop = { 
			'🖐🖖🖐🖖',
			'🖖🖐🖖🖐',
			'🖐🖖🖐🖖',
			'🖖🖐🖖🖐',
			'🖐🖖🖐🖖',
			'🖖🖐🖖🖐',
			'🖐🖖🖐🖖',
			'🖖🖐🖖🖐',
			'🖐🖖🖐🖖',
			'🖖🖐🖖🖐',
			'🖐🖖🖐🖖',
			'🖖🖐🖖🖐',
			'🖐🖖🖐🖕',
			'🖖🖐🖕🖐',
			'🖐🖕🖐🖖',
			'🖕🖐🖖🖐',
		},
		Messages = {
			MSG_CONNECTING = 'You are in the queue. [{QUEUE_NUM}/{QUEUE_MAX}]: ', -- Default message if they have no discord roles 
			MSG_CONNECTED = 'The airport is ready for you, flying in now!'
		}
	}
}

Config.Rankings = {
	-- LOWER NUMBER === HIGHER PRIORITY 
	-- ['roleID'] = {rolePriority, connectQueueMessage},
	['713169411930062971'] = {500, "You are in the queue. (Donate for Higher Priority) [{QUEUE_NUM}/{QUEUE_MAX}]:"}, -- Normal Players
	['715622738886262805'] = {400, "You are in the queue. (Bronze Supporter Priority) [{QUEUE_NUM}/{QUEUE_MAX}]:"}, -- Bronze Supporter
	['715622664953266176'] = {300, "You are in the queue. (Silver Supporter Priority) [{QUEUE_NUM}/{QUEUE_MAX}]:"}, -- Silver Supporter
	['715622594174255114'] = {200, "You are in the queue. (Gold Supporter Priority) [{QUEUE_NUM}/{QUEUE_MAX}]:"}, -- Gold Supporter
	['713169762233876613'] = {100, "You are in the queue. (Diamond Supporter Priority) [{QUEUE_NUM}/{QUEUE_MAX}]:"}, -- Diamond Supporter
	['713167412735770635'] = {4, "You are in the queue. (Admin Priority) [{QUEUE_NUM}/{QUEUE_MAX}]:"}, -- Admin
	['715722762412359702'] = {3, "You are in the queue. (Community Manager Priority) [{QUEUE_NUM}/{QUEUE_MAX}]:"}, -- Community Manager
	['713166994471518269'] = {2, "You are in the queue. (Lead Admin Priority) [{QUEUE_NUM}/{QUEUE_MAX}]:"}, -- Lead Admin
	['699702705123491990'] = {1, "You are in the queue. (Owner Priority) [{QUEUE_NUM}/{QUEUE_MAX}]:"}, -- Owner
}