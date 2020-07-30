Config = {}

Config.allow_test_drive = true -- allow test driving
Config.test_drive_time = 120 -- test drive time in seconds
Config.currency = "$" -- currency to show in menu above car
Config.buy_point = { pos = vector3(-17.91, -1109.85, 26.69-0.85), heading = 27.44 } -- location where to tp player with car after buying it
Config.test_point = { pos = vector3(1214.433, 107.717, 81.865-0.85), heading = 134.58 } -- location where to tp player when test driving car
Config.return_point = { pos = vector3(-38.29, -1100.77, 26.42-0.85), heading = 86.05 }
Config.track_area = vector3(1139.116, 100.855, 80.846)
Config.render_center = vector3(-42.439, -1098.578, 26.422)
Config.render_distance = 50 -- distance from render_center from which the cars will be visible
Config.cars = {
    -- RIGHT HAND SIDE
    {
        model = "a80", -- spawn name of car
        label = "1998 Toyota Supra", -- label to show in menu above car (set to nil to get name from model)
        pos = vector3(-49.014, -1093.278, 26.4220-0.85), -- position - vector3(x,y,z)
        heading = 136,
        price = 130000
    },
    {
        model = "2013rs7", -- spawn name of car
        label = "Audi RS7", -- label to show in menu above car (set to nil to get name from model)
        pos = vector3(-44.014, -1095.278, 26.4220-0.85), -- position - vector3(x,y,z)
        heading = 136,
        price = 175000
    },
    {
        model = "rmodx6", -- spawn name of car
        label = "BMW X6", -- label to show in menu above car (set to nil to get name from model)
        pos = vector3(-39.014, -1097.278, 26.4220-0.85), -- position - vector3(x,y,z)
        heading = 136,
        price = 165000
    },
    -- LEFT HAND SIDE
    {
        model = "na1", -- spawn name of car
        label = "Honda NSX R", -- label to show in menu above car (set to nil to get name from model)
        pos = vector3(-46.214, -1101.278, 26.4220-0.85), -- position - vector3(x,y,z)
        heading = 4,
        price = 200000
    },
    {
        model = "contss18", -- spawn name of car
        label = "Bentley Continental GT", -- label to show in menu above car (set to nil to get name from model)
        pos = vector3(-41.214, -1103.278, 26.4220-0.85), -- position - vector3(x,y,z)
        heading = 4,
        price = 200000
    }
}