local foodPeds = {
  { model="mp_m_shopkeep_01", voice="SHOPASSISTANT", x=-46.313, y=-1757.504, z=29.421, a=46.395},
  { model="mp_m_shopkeep_01", voice="SHOPASSISTANT", x=24.376, y=-1345.558, z=29.421, a=267.940},
  { model="mp_m_shopkeep_01", voice="SHOPASSISTANT", x=1134.182, y=-982.477, z=46.416, a=275.432},
  { model="mp_m_shopkeep_01", voice="SHOPASSISTANT", x=373.015, y=328.332, z=103.566, a=257.309},
  { model="mp_m_shopkeep_01", voice="SHOPASSISTANT", x=2676.389, y=3280.362, z=55.241, a=332.305},
  { model="mp_m_shopkeep_01", voice="SHOPASSISTANT", x=1958.960, y=3741.979, z=32.344, a=303.196},
  { model="mp_m_shopkeep_01", voice="SHOPASSISTANT", x=-2966.391, y=391.324, z=15.043, a=88.867},
  { model="mp_m_shopkeep_01", voice="SHOPASSISTANT", x=-1698.542, y=4922.583, z=42.064, a=324.021},
  { model="mp_m_shopkeep_01", voice="SHOPASSISTANT", x=1164.565, y=-322.121, z=69.205, a=100.492},
  { model="mp_m_shopkeep_01", voice="SHOPASSISTANT", x=-1486.530, y=-377.768, z=40.163, a=147.669},
  { model="mp_m_shopkeep_01", voice="SHOPASSISTANT", x=-1221.568, y=-908.121, z=12.326, a=31.739},
  { model="mp_m_shopkeep_01", voice="SHOPASSISTANT", x=-706.153, y=-913.464, z=19.216, a=82.056},
  { model="mp_m_shopkeep_01", voice="SHOPASSISTANT", x=-1820.230, y=794.369, z=138.089, a=130.327},
  { model="mp_m_shopkeep_01", voice="SHOPASSISTANT", x=2555.474, y=380.909, z=108.623, a=355.737},
  { model="mp_m_shopkeep_01", voice="SHOPASSISTANT", x=1728.614, y=6416.729, z=35.037, a=247.369},
  { model="mp_m_shopkeep_01", voice="SHOPASSISTANT", x=2749.95, y=3483.67, z=55.66, a=68.14}
}


Citizen.CreateThread(function()



	for k,v in ipairs(foodPeds) do
		RequestModel(GetHashKey(v.model))
		while not HasModelLoaded(GetHashKey(v.model)) do
			Wait(0)
		end

		local storePed = CreatePed(4, GetHashKey(v.model), v.x, v.y, v.z, v.a, false, false)
		SetBlockingOfNonTemporaryEvents(storePed, true)
		SetAmbientVoiceName(storePed, v.voice)
		TaskStartScenarioInPlace(storePed, "WORLD_HUMAN_STAND_IMPATIENT_UPRIGHT", 0, 0)

		SetModelAsNoLongerNeeded(GetHashKey(v.model))
	end
end)
