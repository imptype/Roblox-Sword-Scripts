-- source https://pastebin.com/SmkyYpqK
-- updated at may 13, 2024

-- thought I'd post this here too (sirius)
-- source https://pastebin.com/3Dvk7dsF
-- local mods = {
--     "DauuX", "Dxmanding", "edgardominoes26", "literallymatt", "m1keaswell",
--     "Mooniar", "AmitBX", "creamy_2s", "Dino_raf", "FrancisHUnderwood",
--     "Ghostanovuh", "Honoripedia", "leoisok", "iRyuxn", "MarkBaretta",
--     "NapoleonicTank", "NorthyLikeWoah", "rixvzx", "SinisterScott",
--     "spookdan", "thetribe56","AdamDosen","NerfSniper1234"
-- }

-- [[  Reacher MODIFIED v2.0.1 ]]
--This version was modified by LiteralIyMatt (m.#0115)
--Designed for Steal Time From Others & Be The Best by Detourious
--Game can be found at: https://www.roblox.com/games/6361937392/steal-time-from-others-be-the-best
--================================WARNING================================
--THIS SCRIPT IS DESIGNED FOR A VERY NICHE TYPE OF SWORD, THIS WILL CAUSE YOU TO TP AROUND PLAYERS ON MOST SWORDS.
--USE AT YOUR OWN RISK.
--================================WARNING================================
local KEY = Enum.KeyCode
local Settings = {
    Keybinds = {
        ["INCREASE"] = KEY["Q"],
        ["DECREASE"] = KEY["E"],
        ["TOGGLE_REACH"] = KEY["R"],
        ["TOGGLE_VISUALIZER"] = KEY["T"],
        ["TOGGLE_DAMAGE_AMP"] = KEY["X"],
        ["CHECK_SETTINGS"] = KEY["C"],
        ["TOGGLE_NOTIFICATIONS"] = KEY["V"],
        ["TOGGLE_AUTO_CLICKER"] = KEY["B"],
        ["KILL_SCRIPT"] = KEY["Z"],
    },
    Values = { -- Set these to what you want the default values for each to be upon execution
        ["distance"] = 3.5,
        ["enabled"] = true,
        ["notifications"] = true,
        ["visualizer"] = true,
        ["damage_amp"] = true,
        ["auto_clicking"] = true,
        ["cooldown"] = false,
        ["killed"] = true,
    },
    DISTANCE_INCREMENT = 0.5, -- How much will be added/removed upon distance increase/decrease
    COOLDOWN = 0.05, -- How long the cooldown is on regular FTI (NOT FOR DAMAGE AMP)
}

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")

-- Globals
local F = string.format
local Upper = string.upper

-- Statics
local SPEED_COLOR = 1
local WHITELIST = { "Head", "Torso", "Right Arm", "Left Arm", "Right Leg", "Left Leg" }

-- Non statics
local connections = {}
local instances = {}

-- Instances
local localPlayer = Players.LocalPlayer

local Notify = function(x)
    if Settings.Values.notifications == true then
        StarterGui:SetCore("SendNotification", {
            Title = " Reach v3.0",
            Text = x,
        })
    end
end

connections.InputBegan = UserInputService.InputBegan:Connect(function(INPUT, GPE)
    if GPE then
        return
    end
    local KEY = INPUT.KeyCode
    if KEY == Settings.Keybinds.INCREASE then
        Settings.Values.distance = Settings.Values.distance + Settings.DISTANCE_INCREMENT
        Notify(F("Distance: %s", Settings.Values.distance))
    elseif KEY == Settings.Keybinds.DECREASE then
        Settings.Values.distance = Settings.Values.distance - Settings.DISTANCE_INCREMENT
        Notify(F("Distance: %s", Settings.Values.distance))
    elseif KEY == Settings.Keybinds.TOGGLE_REACH then
        Settings.Values.enabled = not Settings.Values.enabled
        Notify(F("Reach: %s", tostring(Settings.Values.enabled)))
    elseif KEY == Settings.Keybinds.TOGGLE_DAMAGE_AMP then
        Settings.Values.damage_amp = not Settings.Values.damage_amp
        Notify(F("Damage Amp: %s", tostring(Settings.Values.damage_amp)))
    elseif KEY == Settings.Keybinds.TOGGLE_VISUALIZER then
        Settings.Values.visualizer = not Settings.Values.visualizer
        Notify(F("Visualizer: %s", tostring(Settings.Values.visualizer)))
    elseif KEY == Settings.Keybinds.TOGGLE_NOTIFICATIONS then
        Settings.Values.notifications = not Settings.Values.notifications
    elseif KEY == Settings.Keybinds.CHECK_SETTINGS then
        local str = F(
            "Distance: %s\nDamage Amp: %s\nCooldown: %s",
            Settings.Values.distance,
            tostring(Settings.Values.damage_amp),
            tostring(Settings.Values.cooldown)
        )
        Notify(str)
    elseif KEY == Settings.Keybinds.TOGGLE_AUTO_CLICKER then
        Settings.Values.auto_clicking = not Settings.Values.auto_clicking
        Notify(F("Auto Clicking: %s", tostring(Settings.Values.auto_clicking)))
    elseif KEY == Settings.Keybinds.KILL_SCRIPT then
        Settings.Values.killed = true
        Notify("DISABLED")
        for _, connection in pairs(connections) do
            pcall(function()
                connection:Disconnect()
            end)
        end
        for _, part in pairs(instances) do
            part:Destroy()
        end
    end
end)

local FireFakes = function(handle, part)
    local region = Region3.new(handle.Position + Vector3.new(-1, -1, -1), handle.Position + Vector3.new(1, 1, 1))
    local objects = game:GetService("Workspace"):FindPartsInRegion3(region)
    for i, instance in pairs(objects) do
        if
            instance:IsA("Part")
            and instance:FindFirstChild("TouchTransmitter")
            and instance.Parent.ClassName ~= "Tool"
        then
            coroutine.wrap(function()
                firetouchinterest(part, handle, 0)
                task.wait()
                firetouchinterest(part, handle, 1)
            end)()
        end
    end
end

local FireTouchInterest = function(handle, part)
    coroutine.wrap(FireFakes)(handle, part)
    coroutine.wrap(function()
        firetouchinterest(part, handle, 0)
        task.wait()
        firetouchinterest(part, handle, 1)
    end)()
end

local BindVisualizer = function(obj)
    while obj.Parent == game:GetService("CoreGui") do
        pcall(function()
            local selectionBox = instances["visualizer"]:FindFirstChildOfClass("SelectionBox")
            for i = 0, 1, 0.001 * SPEED_COLOR do
                selectionBox.Color3 = Color3.fromHSV(i, 1, 1)
                selectionBox.SurfaceColor3 = Color3.fromHSV(i, 1, 1)
                task.wait()
            end
        end)

        if Settings.Values.killed == true then
            break
        end
        task.wait()
    end
end

connections.Heartbeat = RunService.Heartbeat:Connect(function()
    local character = localPlayer.Character

    if not character then
        return
    end

    local sword = character:FindFirstChildOfClass("Tool")
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChild("Humanoid")
    if Settings.Values.enabled and sword and sword.Handle and humanoidRootPart and humanoid then
        local handle = sword.Handle

        if Settings.Values.auto_clicking then
            sword:Activate()
        end

        if not instances["visualizer"] and Settings.Values.visualizer == true then
            local part = Instance.new("Part")
            part.Name = "_"
            part.Anchored = false
            part.CanCollide = false
            part.Massless = true

            local selectionBox = Instance.new("SelectionBox", part)
            selectionBox.Name = "_"
            selectionBox.Adornee = part
            selectionBox.LineThickness = 0.015
            selectionBox.SurfaceTransparency = 0.5
            selectionBox.Transparency = 0

            part.Parent = game:GetService("CoreGui")
            instances["visualizer"] = part
            BindVisualizer(part)
        elseif instances["visualizer"] and Settings.Values.visualizer == false then
            instances["visualizer"]:Destroy()
            instances["visualizer"] = nil
        end

        if instances["visualizer"] then
            instances["visualizer"].Size =
                Vector3.new(Settings.Values.distance * 1.65, 0.55, Settings.Values.distance * 1.65)
            instances["visualizer"].CFrame = humanoidRootPart.CFrame
                - (humanoidRootPart.CFrame.UpVector * 2.75)
                + (humanoidRootPart.CFrame.RightVector * 1.5)
                + (humanoidRootPart.CFrame.LookVector * 1.5)
        end

        for i, player in pairs(Players:GetPlayers()) do
            if player ~= localPlayer and player.Character then
                local targetCharacter = player.Character
                local targetRoot = targetCharacter:FindFirstChild("HumanoidRootPart")
                local targetHumanoid = targetCharacter:FindFirstChild("Humanoid")
                local targetPart

                local chosenIndex = math.random(1, #WHITELIST)
                local last
                for i = 1, #WHITELIST do
                    if i == chosenIndex and targetCharacter:FindFirstChild(WHITELIST[i]) then
                        targetPart = targetCharacter:FindFirstChild(WHITELIST[i])
                        if targetPart and targetPart.Transparency <= 0.8 then
                            break
                        else
                            last = nil
                            break
                        end
                    end
                    last = i
                end
                if not targetRoot or not targetHumanoid or last == nil then
                    return
                end

                if (handle.Position - targetRoot.Position).Magnitude <= Settings.Values.distance then
                    if Settings.Values.damage_amp == true then
                        for _, v in pairs({ "Right Arm", "Right Arm", "Left Arm", "Torso" }) do
                            local part = targetCharacter:FindFirstChild(v)
                            if part and part.Transparency <= 0.8 and targetHumanoid.Health > 0 then
                                for i = 1, math.random(1, 2) do
                                    FireTouchInterest(part, handle)
                                end
                            else
                                break
                            end
                        end
                    elseif Settings.Values.cooldown == false then
                        Settings.Values.cooldown = true
                        FireTouchInterest(targetPart, handle)
                        task.wait(Settings.COOLDOWN)
                        Settings.Values.cooldown = false
                    end
                end
            end
        end
    else -- GC instances since everythings disabled
        for i, v in pairs(instances) do
            v:Destroy()
            instances[i] = nil
        end
    end
end)

_G.HeadSize = 25
_G.Disabled = true

game:GetService("RunService").RenderStepped:connect(function()
    if _G.Disabled then
        for i, v in next, game:GetService("Players"):GetPlayers() do
            if v.Name ~= game:GetService("Players").LocalPlayer.Name then
                pcall(function()
                    v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
                    v.Character.HumanoidRootPart.Transparency = 1
                    v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really blue")
                    v.Character.HumanoidRootPart.Material = "Neon"
                    v.Character.HumanoidRootPart.CanCollide = false
                end)
            end
        end
    end
end)
