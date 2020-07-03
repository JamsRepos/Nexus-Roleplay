Config = {}

Config.allow_test_drive = true -- allow test driving
Config.test_drive_time = 45 -- test drive time in seconds
Config.currency = "$" -- currency to show in menu above car
Config.buy_point = { pos = vector3(-17.91, -1109.85, 26.69-0.85), heading = 27.44 } -- location where to tp player with car after buying it
Config.test_point = { pos = vector3(-9.28, -1082.86, 26.7-0.85), heading = 99.49 } -- location where to tp player when test driving car
Config.render_center = vector3(-42.439, -1098.578, 26.422)
Config.render_distance = 50 -- distance from render_center from which the cars will be visible
Config.cars = {
    -- RIGHT HAND SIDE
    {
        model = "hcbr17", -- spawn name of car
        label = "Honda CBR 1000RR", -- label to show in menu above car (set to nil to get name from model)
        pos = vector3(-49.014, -1093.278, 26.4220-0.85), -- position - vector3(x,y,z)
        heading = 136,
        price = 150000
    },
    {
        model = "FK8", -- spawn name of car
        label = "Honda TypeR", -- label to show in menu above car (set to nil to get name from model)
        pos = vector3(-44.014, -1095.278, 26.4220-0.85), -- position - vector3(x,y,z)
        heading = 136,
        price = 120000
    },
    {
        model = "urus", -- spawn name of car
        label = "Lamborghini Urus", -- label to show in menu above car (set to nil to get name from model)
        pos = vector3(-39.014, -1097.278, 26.4220-0.85), -- position - vector3(x,y,z)
        heading = 136,
        price = 200000
    },
    -- LEFT HAND SIDE
    {
        model = "slingshot", -- spawn name of car
        label = "Polaris Slingshot", -- label to show in menu above car (set to nil to get name from model)
        pos = vector3(-46.214, -1101.278, 26.4220-0.85), -- position - vector3(x,y,z)
        heading = 4,
        price = 90000
    },
    {
        model = "teslax", -- spawn name of car
        label = "Tesla Model X", -- label to show in menu above car (set to nil to get name from model)
        pos = vector3(-41.214, -1103.278, 26.4220-0.85), -- position - vector3(x,y,z)
        heading = 4,
        price = 200000
    }
}