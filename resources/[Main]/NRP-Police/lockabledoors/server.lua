local doorList = {
    [1] = { ["obj"] = "v_ilev_ph_gendoor004", ["x"] = 449.69, ["y"] = -986.46, ["z"] = 30.68, ["locked"] = true, ["rotation"] = 90.0},
    [2] = { ["obj"] = "v_ilev_ph_gendoor002", ["x"] = 446.85, ["y"] = -980.42, ["z"] = 30.69, ["locked"] = true, ["rotation"] = 180.0},
    [3] = { ["obj"] = "v_ilev_ph_door002", ["x"] = 434.74, ["y"] = -983.21, ["z"] = 30.83, ["locked"] = false, ["rotation"] = 270.0},
    [4] = { ["obj"] = "v_ilev_ph_door01", ["x"] = 434.74, ["y"] = -980.61, ["z"] = 30.83, ["locked"] = false, ["rotation"] = 270.0},
    [5] = { ["obj"] = "v_ilev_ph_gendoor005", ["x"] = 443.40, ["y"] = -989.44, ["z"] = 30.83, ["locked"] = true, ["rotation"] = 180.0},
    [6] = { ["obj"] = "v_ilev_ph_gendoor005", ["x"] = 446.00, ["y"] = -989.44, ["z"] = 30.83, ["locked"] = true, ["rotation"] = 0.0},
    [7] = { ["obj"] = "v_ilev_gtdoor", ["x"] = 444.62, ["y"] = -999.55, ["z"] = 30.72, ["locked"] = true, ["rotation"] = 0.0},
    [8] = { ["obj"] = "v_ilev_gtdoor", ["x"] = 447.24, ["y"] = -999.49, ["z"] = 30.72, ["locked"] = true, ["rotation"] = 180.0},
    [9] = { ["obj"] = "prop_fnclink_02gate7", ["x"] = 475.98, ["y"] = -986.96, ["z"] = 24.91, ["locked"] = true, ["rotation"] = 90.0},
    [10] = { ["obj"] = "v_ilev_ph_gendoor006", ["x"] = 470.92, ["y"] = -986.16, ["z"] = 24.91, ["locked"] = true, ["rotation"] = 270.0},
    [11] = { ["obj"] = "v_ilev_ph_cellgate", ["x"] = 464.49, ["y"] = -992.26, ["z"] = 24.91, ["locked"] = true, ["rotation"] = 0.0},
    [12] = { ["obj"] = "v_ilev_ph_cellgate", ["x"] = 462.15, ["y"] = -994.38, ["z"] = 24.91, ["locked"] = true, ["rotation"] = 270.0},
    [13] = { ["obj"] = "v_ilev_ph_cellgate", ["x"] = 462.24, ["y"] = -997.63, ["z"] = 24.91, ["locked"] = true, ["rotation"] = 90.0},
    [14] = { ["obj"] = "v_ilev_ph_cellgate", ["x"] = 462.30, ["y"] = -1001.29, ["z"] = 24.91, ["locked"] = true, ["rotation"] = 90.0},
    [15] = { ["obj"] = "v_ilev_gtdoor", ["x"] = 463.73, ["y"] = -1002.99, ["z"] = 24.91, ["locked"] = true, ["rotation"] = 0.0},
    [16] = { ["obj"] = "v_ilev_rc_door2", ["x"] = 467.74, ["y"] = -1014.90, ["z"] = 26.39, ["locked"] = true, ["rotation"] = 0.0},
    [17] = { ["obj"] = "v_ilev_rc_door2", ["x"] = 469.61, ["y"] = -1014.84, ["z"] = 26.39, ["locked"] = true, ["rotation"] = 180.0},
    [18] = { ["obj"] = "v_ilev_gtdoor", ["x"] = 467.17, ["y"] = -996.95, ["z"] = 24.91, ["locked"] = true, ["rotation"] = 0.0},
    [19] = { ["obj"] = "v_ilev_gtdoor", ["x"] = 471.41, ["y"] = -996.92, ["z"] = 24.91, ["locked"] = true, ["rotation"] = 0.0},
    [20] = { ["obj"] = "v_ilev_gtdoor", ["x"] = 475.71, ["y"] = -996.92, ["z"] = 24.91, ["locked"] = true, ["rotation"] = 0.0},
    [21] = { ["obj"] = "v_ilev_gtdoor", ["x"] = 480.08, ["y"] = -996.96, ["z"] = 24.91, ["locked"] = true, ["rotation"] = 0.0},
    [22] = { ["obj"] = "v_ilev_arm_secdoor", ["x"] = 461.77, ["y"] = -985.28, ["z"] = 30.69, ["locked"] = true, ["rotation"] = 90.0},
  }

RegisterServerEvent('doorLock:LockDoor')
AddEventHandler('doorLock:LockDoor', function(door, bool)
 doorList[door]["locked"] = bool
 TriggerClientEvent('doorLock:doors', -1, doorList)
end)

RegisterServerEvent('core:characterloaded')
AddEventHandler('core:characterloaded', function()
 TriggerClientEvent('doorLock:doors', -1, doorList)
end)