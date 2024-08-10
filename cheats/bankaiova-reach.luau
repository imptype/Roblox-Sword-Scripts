-- source https://pastebin.com/8cLbTuSU
-- updated at september 15, 2023

--Made by BankaiOVA--
local Bankai = Instance.new("ScreenGui")
local Mayonaise = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Circle = Instance.new("TextButton")
local Reach = Instance.new("TextLabel")
local Credits = Instance.new("TextLabel")
local Bypass = Instance.new("TextButton")
local Open = Instance.new("TextButton")

-- Properties

Bankai.Name = "Bankai"
Bankai.Parent = game.CoreGui

Mayonaise.Name = "Mayonaise"
Mayonaise.Parent = Bankai
Mayonaise.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
Mayonaise.BorderColor3 = Color3.new(0, 0, 0)
Mayonaise.BorderSizePixel = 5
Mayonaise.Position = UDim2.new(0, 0, 0.413969338, 0)
Mayonaise.Size = UDim2.new(0, 216, 0, 294)
Mayonaise.Visible = false
Mayonaise.Active = true
Mayonaise.Draggable = true

-- Main Gui

Title.Name = "Title"
Title.Parent = Mayonaise
Title.BackgroundColor3 = Color3.new(0.227451, 0.227451, 0.227451)
Title.BorderColor3 = Color3.new(0, 0, 0)
Title.BorderSizePixel = 5
Title.Size = UDim2.new(0, 216, 0, 50)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "Bankai X"
Title.TextColor3 = Color3.new(0, 0, 0)
Title.TextScaled = true
Title.TextSize = 14
Title.TextWrapped = true

-- Circle Button

Circle.Name = "Circle"
Circle.Parent = Mayonaise
Circle.BackgroundColor3 = Color3.new(0.227451, 0.227451, 0.227451)
Circle.BorderColor3 = Color3.new(0, 0, 0)
Circle.BorderSizePixel = 2
Circle.Position = UDim2.new(0.027777778, 0, 0.25170067, 0)
Circle.Size = UDim2.new(0, 88, 0, 50)
Circle.Font = Enum.Font.SourceSans
Circle.Text = "Circle"
Circle.TextColor3 = Color3.new(1, 1, 1)
Circle.TextScaled = true
Circle.TextSize = 14
Circle.TextWrapped = true

-- Reach Script

Circle.MouseButton1Down:connect(function()
    wait(0.25)
    _G.Size = 5
    local Mouse = game.Players.LocalPlayer:GetMouse()
    Mouse.KeyDown:Connect(function(key)
        if key == "q" then
            _G.Size = _G.Size + 1

            for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                if v:IsA("Tool") then
                    Handle = v.Handle
                    Sphere = Instance.new("SelectionSphere", Handle)
                    Sphere.Adornee = Handle
                    Sphere.Color3 = Color3.new(255, 255, 255)
                    v.Handle.Size = Vector3.new(_G.Size, _G.Size, _G.Size)
                    Handle.CanCollide = false
                    Handle.Massless = true
                end
            end
        end
    end)

    local Mouse = game.Players.LocalPlayer:GetMouse()
    Mouse.KeyDown:Connect(function(key)
        if key == "e" then
            _G.Size = _G.Size - 1

            for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                if v:IsA("Tool") then
                    Handle = v.Handle
                    Sphere = Instance.new("SelectionSphere", Handle)
                    Sphere.Adornee = Handle
                    Sphere.Color3 = Color3.new(255, 255, 255)
                    v.Handle.Size = Vector3.new(_G.Size, _G.Size, _G.Size)
                    Handle.CanCollide = false
                    Handle.Massless = true
                end
            end
        end
    end)
end)

-- Reach Instructions

Reach.Name = "Reach"
Reach.Parent = Circle
Reach.BackgroundColor3 = Color3.new(1, 1, 1)
Reach.BackgroundTransparency = 1
Reach.BorderSizePixel = 0
Reach.Position = UDim2.new(-0.0782827884, 0, 0.981768787, 0)
Reach.Size = UDim2.new(0, 94, 0, 46)
Reach.Font = Enum.Font.SourceSansBold
Reach.Text = "Click Q & E to Change Reach"
Reach.TextColor3 = Color3.new(1, 1, 1)
Reach.TextScaled = true
Reach.TextSize = 14
Reach.TextWrapped = true

-- Credits

Credits.Name = "Credits"
Credits.Parent = Mayonaise
Credits.BackgroundColor3 = Color3.new(1, 1, 1)
Credits.BackgroundTransparency = 1
Credits.BorderSizePixel = 0
Credits.Position = UDim2.new(0.0694444478, 0, 0.921768725, 0)
Credits.Size = UDim2.new(0, 186, 0, 23)
Credits.Font = Enum.Font.SourceSansBold
Credits.Text = "Credits to: Shocking#2957 & Bankai#5544"
Credits.TextColor3 = Color3.new(1, 1, 1)
Credits.TextScaled = true
Credits.TextSize = 14
Credits.TextWrapped = true

-- Bypass
Bypass.Name = "Bypass"
Bypass.Parent = Mayonaise
Bypass.BackgroundColor3 = Color3.new(0.227451, 0.227451, 0.227451)
Bypass.BorderColor3 = Color3.new(0, 0, 0)
Bypass.BorderSizePixel = 2
Bypass.Position = UDim2.new(0.523148119, 0, 0.25170067, 0)
Bypass.Size = UDim2.new(0, 88, 0, 50)
Bypass.Font = Enum.Font.SourceSans
Bypass.Text = "Bypass (WIP)"
Bypass.TextColor3 = Color3.new(1, 1, 1)
Bypass.TextScaled = true
Bypass.TextSize = 14
Bypass.TextWrapped = true

-- Bypass Script

Bypass.MouseButton1Down:connect(function()
    local mt = getrawmetatable(game)
    local OldNC = mt.__namecall
    setreadonly(mt, false)

    mt.__namecall = function(arg, ...)
        local args = { ... }
        local Method = getnamecallmethod()
        if Method == "Kick" or Method == "InvokeServer" then
            return wait(9e9)
        end
        return OldNC(arg, ...)
    end
end)

-- Open Button

Open.Name = "Open"
Open.Parent = Bankai
Open.BackgroundColor3 = Color3.new(0.105882, 0.105882, 0.105882)
Open.BorderColor3 = Color3.new(0, 0, 0)
Open.BorderSizePixel = 3
Open.Position = UDim2.new(0, 0, 0.519591153, 0)
Open.Size = UDim2.new(0, 90, 0, 42)
Open.Font = Enum.Font.Cartoon
Open.Text = "OPEN"
Open.TextColor3 = Color3.new(1, 1, 1)
Open.TextScaled = true
Open.TextSize = 14
Open.TextWrapped = true

-- Open Button Click Invisible Function

Open.MouseButton1Down:connect(function()
    wait(0.25)
    Open.Visible = false
end)

-- Main Gui Visibile Function

while wait(0.25) do
    if Open.Visible == false then
        Mayonaise.Visible = true
    end
end
