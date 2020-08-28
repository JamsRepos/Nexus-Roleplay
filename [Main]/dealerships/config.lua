Config = {}

Config.allow_test_drive = true -- allow test driving
Config.test_drive_time = 120 -- test drive time in seconds
Config.currency = "$" -- currency to show in menu above car
Config.buy_point = { pos = vector3(-17.91, -1109.85, 26.69-0.85), heading = 27.44 } -- location where to tp player with car after buying it
Config.test_point = { pos = vector3(-970.891, -3354.66, 13.944-0.85), heading = 60.0 } -- location where to tp player when test driving car
Config.return_point = { pos = vector3(-38.29, -1100.77, 26.42-0.85), heading = 86.05 }
Config.track_area = vector3(-1337.059, -3047.133, 13.533)
Config.render_center = vector3(-42.439, -1098.578, 26.422)
Config.render_distance = 50 -- distance from render_center from which the cars will be visible
Config.cars = {
    -- RIGHT HAND SIDE
    {
        model = "rrphantom", -- spawn name of car
        label = "Rolls Royce Phantom", -- label to show in menu above car (set to nil to get name from model)
        pos = vector3(-49.014, -1093.278, 26.4220-0.85), -- position - vector3(x,y,z)
        heading = 136,
        price = 550000
    },
    {
        model = "mi8", -- spawn name of car
        label = "BMW I8", -- label to show in menu above car (set to nil to get name from model)
        pos = vector3(-44.014, -1095.278, 26.4220-0.85), -- position - vector3(x,y,z)
        heading = 136,
        price = 1000000
    },
    {
        model = "rmodx6", -- spawn name of car
        label = "BMW X6M", -- label to show in menu above car (set to nil to get name from model)
        pos = vector3(-39.014, -1097.278, 26.4220-0.85), -- position - vector3(x,y,z)
        heading = 136,
        price = 600000
    },
    -- LEFT HAND SIDE
    {
        model = "boss302", -- spawn name of car
        label = "1969 Mustang", -- label to show in menu above car (set to nil to get name from model)
        pos = vector3(-46.214, -1101.278, 26.4220-0.85), -- position - vector3(x,y,z)
        heading = 4,
        price = 325000
    },
    {
        model = "rmodamgc63", -- spawn name of car
        label = "Mercedes c63", -- label to show in menu above car (set to nil to get name from model)
        pos = vector3(-41.214, -1103.278, 26.4220-0.85), -- position - vector3(x,y,z)
        heading = 4,
        price = 650000
    }
}