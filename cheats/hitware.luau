-- source https://pastebin.com/NQiRstD7
-- updated at august 31, 2023

local on = true
local distance = 7

local starterGui = game:GetService("StarterGui")
local plr = game:GetService("Players").LocalPlayer
local cooldown = false
game:GetService("RunService").Heartbeat:connect(function()
    if on then
        local hum = plr.Character.Humanoid
        for _, v in ipairs(game.Players:GetPlayers()) do
            if v.Name ~= plr.Name then
                local s, e = pcall(function()
                    local root = v.Character.HumanoidRootPart
                    local sword = hum.Parent:FindFirstChildOfClass("Tool")
                    if sword and (root.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= distance then
                        if cooldown == false then
                            cooldown = true
                            firetouchinterest(sword.Handle, root, 1)
                            firetouchinterest(sword.Handle, root, 0)
                            wait(0.05)
                            cooldown = false
                        end
                    end
                end)
                if e then
                    print(e)
                end
            end
        end
    end
end)
local is_on = function()
    return on and "on" or "off"
end

local mouse = plr:GetMouse()
mouse.KeyDown:connect(function(key)
    if key == "r" then
        on = not on
    elseif key == "e" then
        local status = is_on()
        starterGui:SetCore(
            "SendNotification",
            { Title = "Hitware", Text = "Exploit is " .. status .. ". Current: " .. distance .. " studs" }
        )
    elseif key == "j" then
        distance = distance + 1
        starterGui:SetCore(
            "SendNotification",
            { Title = "PROJECT HITWARE", Text = "Reach Strength has increased by 1. Current: " .. distance .. " studs" }
        )
    elseif key == "k" then
        if distance > 1 then
            distance = distance - 1
            starterGui:SetCore(
                "SendNotification",
                { Title = "Hitware", Text = "Reach Strength has decreased by 1. Current: " .. distance .. " studs" }
            )
        else
            starterGui:SetCore("SendNotification", { Title = "PROJECTHITWARE", Text = "Cannot decrease any further!" })
        end
    end
end)
