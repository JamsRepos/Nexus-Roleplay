
local clothingPeds = {
    {model="s_f_y_shop_mid", voice="SHOPASSISTANT", x=73.883, y=-1392.551, z=29.376, heading=258.693},
    {model="s_f_y_shop_mid", voice="SHOPASSISTANT", x=-708.705, y=-152.150, z=37.415, heading=118.490},
    {model="s_f_y_shop_mid", voice="SHOPASSISTANT", x=-164.849, y=-302.719, z=39.733, heading=249.119},
    {model="s_f_y_shop_low", voice="SHOPASSISTANT", x=126.824, y=-224.512, z=54.558, heading=71.926},
    {model="s_f_y_shop_low", voice="SHOPASSISTANT", x=427.069, y=-806.280, z=29.491, heading=84.203},
    {model="s_f_y_shop_low", voice="SHOPASSISTANT", x=-822.872 , y=-1072.162, z=11.328, heading=203.007},
    {model="s_f_y_shop_low", voice="SHOPASSISTANT", x=-1193.691, y=-766.863, z=17.316, heading=216.273},
    {model="s_f_y_shop_mid", voice="SHOPASSISTANT", x=-1448.901, y=-238.138, z=49.814, heading=48.307},
    {model="s_f_y_shop_mid", voice="SHOPASSISTANT", x=5.809, y=6511.428, z=31.878 , heading=40.329},
    {model="s_f_y_shop_low", voice="SHOPASSISTANT", x=1695.387, y=4823.019, z=42.063, heading=96.539},
    {model="s_f_y_shop_low", voice="SHOPASSISTANT", x=613.015, y=2762.577, z=42.088, heading=277.766},
    {model="s_f_y_shop_low", voice="SHOPASSISTANT", x=1196.435, y=2711.634, z=38.223, heading=179.040},
    {model="s_f_y_shop_low", voice="SHOPASSISTANT", x=-3169.260, y=1043.606, z=20.863, heading=57.917},
    {model="s_f_y_shop_low", voice="SHOPASSISTANT", x=-1102.184, y=2711.799, z=19.108, heading=223.387},
    {model="s_f_y_shop_low", voice="SHOPASSISTANT", x=-0.381, y=6510.237, z=31.878, heading=310.662}
  }

 

  Citizen.CreateThread(function()
  
    for k,v in ipairs(clothingPeds) do
      RequestModel(GetHashKey(v.model))
      while not HasModelLoaded(GetHashKey(v.model)) do
        Wait(0)
      end

      local shopOwner = CreatePed(5, GetHashKey(v.model), v.x, v.y, v.z, v.heading, false, false)
      SetBlockingOfNonTemporaryEvents(shopOwner, true)
      SetAmbientVoiceName(shopOwner, v.voice)
      SetModelAsNoLongerNeeded(GetHashKey(v.model))
    end
  end)