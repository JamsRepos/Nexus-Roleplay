
local barberPeds = {
	{model= "s_f_m_fembarber", voice="S_F_M_FEMBARBER_BLACK_MINI_01", x=-817.349, y=-184.541, z=37.569, h=134.069},
    {model= "s_f_m_fembarber", voice="S_F_M_FEMBARBER_BLACK_MINI_01", x=134.749, y=-1708.106, z=29.292, h=146.281},
    {model= "s_f_m_fembarber", voice="S_F_M_FEMBARBER_BLACK_MINI_01", x=-1284.038, y=-1115.635, z=6.990, h=85.177},
    {model= "s_f_m_fembarber", voice="S_F_M_FEMBARBER_BLACK_MINI_01", x=1930.855, y=3728.141, z=32.844, h=220.243},
    {model= "a_m_y_stbla_02", voice="S_M_M_HAIRDRESSER_01_BLACK_MINI_01", x=1211.521, y=-470.704, z=66.208, h=79.543},
    {model= "a_m_y_stbla_02", voice="S_M_M_HAIRDRESSER_01_BLACK_MINI_01", x=-30.804, y=-151.648, z=57.077, h=349.238},
    {model= "a_m_y_stbla_02", voice="S_M_M_HAIRDRESSER_01_BLACK_MINI_01", x=-278.205, y=6230.279, z=31.696, h=49.216}
}



Citizen.CreateThread(function()
	
	for k,v in ipairs(barberPeds) do
		RequestModel(GetHashKey(v.model))
		while not HasModelLoaded(GetHashKey(v.model)) do
			Wait(0)
		end

		barber = CreatePed(4, GetHashKey(v.model), v.x, v.y, v.z, v.h, false, false)
		SetBlockingOfNonTemporaryEvents(barber, true)
		SetAmbientVoiceName(barber, v.voice)
		TaskStartScenarioInPlace(barber, "WORLD_HUMAN_STAND_IMPATIENT_UPRIGHT", 0, 0)

		SetModelAsNoLongerNeeded(GetHashKey(v.model))
	end
end)
