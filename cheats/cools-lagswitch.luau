-- source https://pastebin.com/uRdJd76Z
-- updated at july 16, 2024

-- Check if Rayfield Library is loaded, if not, load it
if not _G.RayfieldLoaded then
    _G.RayfieldLoaded = true
    loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
end
 
-- Function to display notification
local function displayNotification(message)
    local ScreenGui = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")
    local TextLabel = Instance.new("TextLabel")
 
    ScreenGui.Name = "NotificationGui"
    ScreenGui.Parent = game.CoreGui
 
    Frame.Name = "Frame"
    Frame.Parent = ScreenGui
    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BackgroundTransparency = 0.5
    Frame.Position = UDim2.new(0.5, -100, 0.5, -50)
    Frame.Size = UDim2.new(0, 200, 0, 100)
    Frame.AnchorPoint = Vector2.new(0.5, 0.5)
 
    TextLabel.Name = "TextLabel"
    TextLabel.Parent = Frame
    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Size = UDim2.new(1, 0, 1, 0)
    TextLabel.Font = Enum.Font.SourceSans
    TextLabel.Text = message
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextScaled = true
 
    -- Auto-destroy the notification after 5 seconds
    delay(5, function()
        ScreenGui:Destroy()
    end)
end
 
-- Display the notification
displayNotification("Discord - raifya")
 
-- Create the Window
local Window = Rayfield:CreateWindow({
    Name = "Lag Switch",
    LoadingTitle = "Lag Switch",
    LoadingSubtitle = "by CoolDude123",
    ConfigurationSaving = {
       Enabled = true,
       FolderName = nil,
       FileName = "LagSwitch"
    },
    Discord = {
       Enabled = false,
       Invite = "",
       RememberJoins = true
    },
    KeySystem = false,
    Key = ""
})
 
-- Create the main tab
local MainTab = Window:CreateTab("Main", 4483362458) -- You can replace the icon ID if you want
 
-- Lag Switch Toggle
local lagEnabled = false
local lagAmount = 0.5
 
MainTab:CreateToggle({
    Name = "Enable Lag Switch",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(value)
        lagEnabled = value
        if lagEnabled then
            game:GetService("RunService"):Set3dRenderingEnabled(false)
            game:GetService("RunService"):SetPhysicsEnabled(false)
            spawn(function()
                while lagEnabled do
                    game:GetService("RunService").Stepped:Wait()
                    wait(lagAmount)
                end
            end)
        else
            game:GetService("RunService"):Set3dRenderingEnabled(true)
            game:GetService("RunService"):SetPhysicsEnabled(true)
        end
    end,
})
 
-- Lag Amount Textbox
MainTab:CreateInput({
    Name = "Lag Amount (seconds)",
    PlaceholderText = "Enter lag amount",
    RemoveTextAfterFocusLost = false,
    Flag = "Input1",
    Callback = function(value)
        local numValue = tonumber(value)
        if numValue then
            lagAmount = numValue
        else
            print("Please enter a valid number")
        end
    end,
})
 
-- Ensure the GUI fits the screen
Window:UpdateResizeable(true)
 
Rayfield:LoadConfiguration()
