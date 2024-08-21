```lua
-- Silent Aim Script for Murderers VS Sheriffs Duels

local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local character = localPlayer.Character
local humanoid = character:WaitForChild("Humanoid")

local aimEnabled = false
local aimTarget = nil

local function getClosestPlayer()
    local closestPlayer = nil
    local closestDistance = math.huge
    for _, player in pairs(players:GetPlayers()) do
        if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (player.Character.HumanoidRootPart.Position - character.HumanoidRootPart.Position).magnitude
            if distance < closestDistance then
                closestDistance = distance
                closestPlayer = player
            end
        end
    end
    return closestPlayer
end

local function aimAtPlayer(player)
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local targetPosition = player.Character.HumanoidRootPart.Position
        local camera = workspace.CurrentCamera
        local cameraCFrame = camera.CFrame
        local cameraPosition = cameraCFrame.Position
        local direction = (targetPosition - cameraPosition).unit
        camera.CFrame = CFrame.new(cameraPosition, direction)
    end
end

-- Toggle Button
local toggleButton = Instance.new("ScreenGui")
local button = Instance.new("TextButton")
button.Text = "Silent Aim: Off"
button.Size = UDim2.new(0, 100, 0, 25)
button.Position = UDim2.new(0, 10, 0, 10)
button.BackgroundColor3 = Color3.new(1, 1, 1)
button.TextColor3 = Color3.new(0, 0, 0)
button.FontSize = Enum.FontSize.Size14
button.Font = Enum.Font.SourceSans

toggleButton.Name = "SilentAimToggle"
toggleButton.Parent = game:GetService("StarterGui")

button.Parent = toggleButton

button.MouseButton1Click:Connect(function()
    if aimEnabled then
        aimEnabled = false
        button.Text = "Silent Aim: Off"
``````lua
    else
        aimEnabled = true
        button.Text = "Silent Aim: On"
    end
end)

-- Main Loop
while true do
    if aimEnabled then
        local closestPlayer = getClosestPlayer()
        if closestPlayer then
            aimAtPlayer(closestPlayer)
        end
    end
    wait(0.1)
end
```
