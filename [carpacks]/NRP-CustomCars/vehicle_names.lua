Citizen.CreateThread(function()
	-- POLICE2
	AddTextEntry('0x9F05F101', 'Police2')
	-- POLICE3
	AddTextEntry('0x71FA16EA', 'Police3')
	-- POLICE4
	AddTextEntry('0x8A63C7B9', 'Police4')
	-- POLICE5
	AddTextEntry('0x9C32EB57', 'Police5')
	-- POLICE6
	AddTextEntry('0xB2FF98F0', 'Police6')
	-- POLICE7
	AddTextEntry('0xC4B53C5B', 'Police7')
	-- POLICE8
	AddTextEntry('0xD0AF544F', 'Police8')
	-- FBI
	AddTextEntry('0x432EA949', 'FBI')
	-- FBI2
	AddTextEntry('0x9DC66994', 'FBI2')
	-- ZL1
	AddTextEntry('0x15C4DF5E', 'Police Camaro')
	-- fd1
	AddTextEntry('0x9C32EB57', 'FD1') 		
	-- fd2
	AddTextEntry('0xB2FF98F0', 'FD2') 	
	-- fd3
	AddTextEntry('0xC4B53C5B', 'FD3')
	-- fd4
	AddTextEntry('0xD0AF544F', 'FD4')

	
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end)