
local Aiming2 = loadstring(game:HttpGet("https://raw.githubusercontent.com/ntai1/scripts/main/blizzi.tk/aimlock2.lua"))()
Aiming2.TeamCheck(false)

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local CurrentCamera = Workspace.CurrentCamera

local DaHoodSettings2 = {
    SilentAim = false,
    AimLock = owo,
    Prediction = 0.12,
    AimLockKeybind = Enum.KeyCode[unu]
}
getgenv().DaHoodSettings2 = DaHoodSettings2

function Aiming2.Check()
    if not (Aiming2.Enabled == true and Aiming2.Selected ~= LocalPlayer and Aiming2.SelectedPart ~= nil) then
        return false
    end

    local Character = Aiming2.Character(Aiming2.Selected)
    local KOd = Character:WaitForChild("BodyEffects")["K.O"].Value
    local Grabbed = Character:FindFirstChild("GRABBING_CONSTRAINT") ~= nil

    if (KOd or Grabbed) then
        return false
    end

    return true
end

local __index
__index = hookmetamethod(game, "__index", function(t, k)
    if (t:IsA("Mouse") and (k == "Hit" or k == "Target") and Aiming.Check()) then
        local SelectedPart = Aiming.SelectedPart

        if (DaHoodSettings2.SilentAim and (k == "Hit" or k == "Target")) then
            local Hit = SelectedPart.CFrame + (SelectedPart.Velocity * DaHoodSettings2.Prediction)

            return (k == "Hit" and Hit or SelectedPart)
        end
    end

    return __index(t, k)
end)

RunService:BindToRenderStep("AimLock", 0, function()
    if (DaHoodSettings2.AimLock and Aiming.Check() and UserInputService:IsKeyDown(DaHoodSettings2.AimLockKeybind)) then
        local SelectedPart = Aiming.SelectedPart

        local Hit = SelectedPart.CFrame + (SelectedPart.Velocity * DaHoodSettings2.Prediction)

        CurrentCamera.CFrame = CFrame.lookAt(CurrentCamera.CFrame.Position, Hit.Position)
    end
    end)
