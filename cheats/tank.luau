-- source https://pastebin.com/hwurQMX7
-- updated at june 27, 2024

local players = game:GetService("Players")
local run = game:GetService("RunService")
local uis = game:GetService("UserInputService")

local SendNotification = function(Ti, Te)
    game:GetService("StarterGui"):SetCore("SendNotification", { Title = tostring(Ti), Text = tostring(Te) })
end

local toggle = false

uis.InputBegan:Connect(function(i, gpe)
    if not gpe and i.KeyCode == Enum.KeyCode.Zero then
        toggle = not toggle
        if toggle then
            SendNotification("Cheats", "True")
        else
            SendNotification("Cheats", "False")
        end
    end
end)

while run.Stepped:Wait() do
    if toggle then
        pcall(function()
            for i, v in next, players.LocalPlayer.Character:GetChildren() do
                if players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then
                    if v:IsA("Part") then
                        v.CanTouch = false
                    end
                else
                    if v:IsA("Part") then
                        v.CanTouch = true
                    end
                end
            end
        end)
    else
        pcall(function()
            for i, v in next, players.LocalPlayer.Character:GetChildren() do
                if v:IsA("Part") then
                    v.CanTouch = true
                end
            end
        end)
    end
end
