local startCameraRotations = false
local selectedCameraRot = nil
local spawnedCamera = nil
local angle = 0.0
local angleInc = 0.001
local radius = 200.0

local cameraRotations = {
    [1] = {
        ["centerPoint"] = {x = -296.63, y = -555.25, z = 200.0},
        ["centerRadius"] = 250
    },
    [2] = {
        ["centerPoint"] = {x = 1757.293, y = 3581.043, z = 396.650},
        ["centerRadius"] = 250
    },
    [3] = {
        ["centerPoint"] = {x = -228.898, y = 6301.143, z = 261.650},
        ["centerRadius"] = 250
    },
    [4] = {
        ["centerPoint"] = {x = -2077.050, y = -1423.422, z = 119.150},
        ["centerRadius"] = 250
    }
    -- Add More Points To This When Done With Core
}

RegisterNetEvent("core:startSkyCamera")
AddEventHandler("core:startSkyCamera", function()
    local randomIndex = math.random(1, #cameraRotations)
    selectedCameraRot = randomIndex
    spawnedCamera = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(spawnedCamera, posX, posY, posZ)
    SetEntityVisible(GetPlayerPed(-1), false)
    SetPlayerInvincible(PlayerId(), true)
    RenderScriptCams(1, 1, 1500, 1, 1)
    startCameraRotations = true
end)

RegisterNetEvent("core:stopSkyCamera")
AddEventHandler("core:stopSkyCamera", function()
    startCameraRotations = false
    RenderScriptCams(0, 1, 1500, 1, 1)
    DestroyCam(spawnedCamera, false)
    spawnedCamera = nil
    selectedCameraRot = nil
    SetEntityVisible(GetPlayerPed(-1), true)
    SetPlayerInvincible(PlayerId(), false)
    SetEntityHealth(GetPlayerPed(-1), 200)
    SetPedArmour(GetPlayerPed(-1), 0)
    NetworkSetTalkerProximity(12.0)
end)

Citizen.CreateThread(function()
    while true do
        if startCameraRotations then
            angle = angle - angleInc
            local xOffset = math.cos(angle) * radius
            local yOffset = math.cos(angle) * radius
            local zOffset = math.cos(angle) * radius
            SetCamCoord(spawnedCamera, xOffset, cameraRotations[selectedCameraRot]["centerPoint"].y, cameraRotations[selectedCameraRot]["centerPoint"].z)
            PointCamAtCoord(spawnedCamera, cameraRotations[selectedCameraRot]["centerPoint"].x, cameraRotations[selectedCameraRot]["centerPoint"].y, cameraRotations[selectedCameraRot]["centerPoint"].z)
            HideHudAndRadarThisFrame()
        end
        Citizen.Wait(0)
    end
end)
