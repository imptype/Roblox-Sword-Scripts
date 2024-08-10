-- source https://pastebin.com/gQddeED4
-- updated at november 8, 2023

getgenv().LaunchConfig = {

    --// Main
    ["Enabled"] = true, -- Script status
    ["Size"] = 3.5, -- Size
    ["Visible"] = true, -- Visibility of the visualizer
    ["Mode"] = "Normal", -- OneTap/Normal, OneTap is the fully one tap mode and cant be recorded with (if hitboxes are visible), but Normal is the normal mode and hits the parts inside the visualizer

    --// Keybindings
    ["Toggle"] = "z", -- Toggle the script ON/OFF
    ["ChangeVisibility"] = "t", -- Toggle the visibility to visible or invisible
    ["IncreaseSize"] = "e", -- Increase the size
    ["DescreaseSize"] = "r", -- Descrease the size
    ["DisableKeybinds"] = "p", -- Disable all keybinds
    ["GetReachProperties"] = "l", -- Will notify you with all script's properties (Size, Visibility, etc)

    --// Misc
    ["IncreaseSizeBy"] = 0.5, -- Increase size by X once you use the keybind to increase the size
    ["DescreaseSizeBy"] = 0.5, -- Descrease size by X once you use the keybind to descrease the size
    ["SilentLaunch"] = false, -- Wont show anything up once u launch the script
    ["ReachOnlyOnLunge"] = false, -- Reach only when the sword is lunged
    ["InvisibilityChecks"] = true, -- Wont damage people that are invisible

    --// Customization
    ["Whitelist"] = { "Player1", "Player2", "etc" }, -- Players you want the FTI script not to damage
}

local getModule = nil

for i, v in pairs(getnilinstances()) do
    if v:IsA("ModuleScript") then
        if v.Name ~= "Encrypt" and v ~= nil then
            getModule = v
        end
    end
end

old = hookfunction(getrenv().wait, function(...)
    local args = { ... }

    if getcallingscript() == getModule then
        if args[1] == 2 then
            return coroutine.yield()
        end
    end

    return old(...)
end)

local function syn_create_secure_part(Properties)
    local Useless_Table = {}
    local Useless_Variable = nil
    local Useless_Value = 0
    ---------------------------------------------------------------------
    local The_Part = {}
    local Secure_Part = Instance.new("Part")
    Secure_Part.Name = "Humanoid"
    Secure_Part.Parent = workspace.CurrentCamera
    if syn.protect_gui then
        syn.protect_gui(workspace.CurrentCamera)
    end
    table.insert(The_Part, Secure_Part)
    if Properties["Anchored"] then
        Secure_Part.Anchored = Properties["Anchored"]
    end
    if Properties["CanCollide"] then
        Secure_Part.CanCollide = Properties["CanCollide"]
    end
    if Properties["Transparency"] then
        Secure_Part.Transparency = Properties["Transparency"]
    end
    if Properties["Shape"] then
        Secure_Part.Shape = Properties["Shape"]
    end
    if Properties["CFrame"] then
        Secure_Part.CFrame = Properties["CFrame"]
    end
    if Properties["Massless"] then
        Secure_Part.Massless = Properties["Massless"]
    end
    if Properties["BrickColor"] then
        Secure_Part.BrickColor = Properties["BrickColor"]
    end
    if Properties["Color"] then
        Secure_Part.Color = Properties["Color"]
    end
    if Properties["Size"] then
        Secure_Part.Size = Properties["Size"]
    end
    if Properties["Name"] then
        Secure_Part.Name = Properties["Name"]
    end
    if Properties["Parent"] then
        Secure_Part.Parent = Properties["Parent"]
    end
    if Properties["TopSurface"] then
        Secure_Part.TopSurface = Properties["TopSurface"]
    end
    if Properties["BottomSurface"] then
        Secure_Part.BottomSurface = Properties["BottomSurface"]
    end
    return Secure_Part
end

local ReachPart = syn_create_secure_part({
    Shape = Enum.PartType.Ball,
    Massless = true,
    Transparency = -1,
    Anchored = false,
    Color = Color3.fromRGB(0, 0, 0),
    CanCollide = false,
    Material = Enum.Material.Neon,
    TopSurface = Enum.SurfaceType.SmoothNoOutlines,
    BottomSurface = Enum.SurfaceType.SmoothNoOutlines,
})

local function getrealhandle()
    local Tool = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool")
        or game:GetService("Players").LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
    for i, v in pairs(Tool:GetDescendants()) do
        if v.ClassName == "TouchTransmitter" then
            return v.Parent
        end
    end
end

local function getfakehandle()
    local Char = game:GetService("Players").LocalPlayer.Character
    local Found = false
    for i, v in pairs(Char:GetDescendants()) do
        if v.ClassName == "TouchTransmitter" and v.Parent ~= getrealhandle() then
            Found = true
            return v.Parent
        end
    end
    if not Found then
        return "NoFH"
    end
end

local function onhitantilag(Part, Handle)
    local Queue = {}
    table.insert(Queue, Part .. " " .. Handle)
    if #Queue > 10 then
        for i, v in pairs(Queue) do
            i[v] = nil
        end
        return task.wait(1)
    end
end

local function hasSwordInHand()
    local Tool = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool")
    if Tool then
        return true
    else
        return false
    end
end

local AkaliNotif = loadstring(game:HttpGet("https://pastebin.com/raw/xQvPWBwH"))()
local Notify = AkaliNotif.Notify
local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
local DisabledKeybinds = false
local tweenService = game:GetService("TweenService")

ReachPart.Shape = Enum.PartType.Ball
ReachPart.Massless = true
ReachPart.Transparency = 0.75
ReachPart.Anchored = false
ReachPart.Color = Color3.fromRGB(128, 0, 128)
ReachPart.CanCollide = false
ReachPart.Material = Enum.Material.Neon
ReachPart.TopSurface = Enum.SurfaceType.SmoothNoOutlines
ReachPart.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
local toTween = ReachPart

Mouse.KeyDown:Connect(function(key)
    if key == LaunchConfig["DisableKeybinds"] then
        DisabledKeybinds = not DisabledKeybinds
    else
        if not DisabledKeybinds then
            if key == LaunchConfig["ChangeVisibility"] then
                LaunchConfig["Visible"] = not LaunchConfig["Visible"]
                if LaunchConfig["Visible"] then
                    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)
                    local tween = tweenService:Create(toTween, tweenInfo, { Transparency = 0.75 })
                    tween:Play()
                else
                    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)
                    local tween = tweenService:Create(toTween, tweenInfo, { Transparency = 1 })
                    tween:Play()
                end
            elseif key == LaunchConfig["IncreaseSize"] then
                LaunchConfig["Size"] = LaunchConfig["Size"] + LaunchConfig["IncreaseSizeBy"]
                local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)
                local tween = tweenService:Create(
                    toTween,
                    tweenInfo,
                    { Size = Vector3.new(LaunchConfig["Size"], LaunchConfig["Size"], LaunchConfig["Size"]) }
                )
                tween:Play()
            elseif key == LaunchConfig["DescreaseSize"] then
                LaunchConfig["Size"] = LaunchConfig["Size"] - LaunchConfig["DescreaseSizeBy"]
                local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)
                local tween = tweenService:Create(
                    toTween,
                    tweenInfo,
                    { Size = Vector3.new(LaunchConfig["Size"], LaunchConfig["Size"], LaunchConfig["Size"]) }
                )
                tween:Play()
            elseif key == LaunchConfig["Toggle"] then
                LaunchConfig["Enabled"] = not LaunchConfig["Enabled"]
                Notify({
                    Description = "Celestial Sword Universal has been toggled to " .. tostring(LaunchConfig["Enabled"]),
                    Title = "CELESTIAL",
                    Duration = 2.5,
                })
            elseif key == LaunchConfig["GetReachProperties"] then
                Notify({
                    Description = "Celestial Sword Universal is toggled to "
                        .. tostring(LaunchConfig["Enabled"])
                        .. " and current Size is "
                        .. tostring(LaunchConfig["Size"])
                        .. ".",
                    Title = "CELESTIAL",
                    Duration = 2.5,
                })
            end
        end
    end
end)

local LoopConnection = game:GetService("RunService").RenderStepped:Connect(function()
    if LaunchConfig["Enabled"] then
        local success, error = pcall(function()
            if not hasSwordInHand() then
                RadiusPart.CFrame = CFrame.new(0, 0, 0)
                return
            end
            local Queue = {}
            local Debounce = false
            local Handle = getrealhandle()
            local FakeHandle = getfakehandle()
            ReachPart.CFrame = getrealhandle().CFrame
            local TouchConnection = ReachPart.Touched:Connect(function() end)
            if LaunchConfig["Mode"] == "Normal" then
                for i, v in pairs(ReachPart:GetTouchingParts()) do
                    coroutine.wrap(function()
                        if
                            v.Parent:FindFirstChild("Humanoid")
                            and v.Parent.Humanoid.Health > 0
                            and v.Parent.Humanoid.Health <= 100
                            and v.Parent ~= game:GetService("Players").LocalPlayer.Character
                            and game:GetService("Players").LocalPlayer.Character.Humanoid.Health > 0
                        then
                            if LaunchConfig["ReachOnlyOnLunge"] and getrealhandle().Parent.GripUp.Z ~= 0 then
                                return
                            end
                            if table.find(LaunchConfig["Whitelist"], v.Parent.Name) then
                                return
                            end
                            if
                                LaunchConfig["InvisibilityChecks"]
                                and v.Parent:FindFirstChildOfClass("Part").Transparency >= 1
                            then
                                return
                            end
                            if v.Name == "HumanoidRootPart" or v.Name == "Torso" or v.Name == "Left Leg" then
                                return
                            end
                            if FakeHandle then
                                firetouchinterest(FakeHandle, v, 0)
                                firetouchinterest(FakeHandle, v, 1)
                            end
                            firetouchinterest(Handle, v, 0)
                            firetouchinterest(Handle, v, 1)
                        end
                    end)()
                    TouchConnection:Disconnect()
                end
            elseif LaunchConfig["Mode"] == "Ublubble" then
                for i, v in pairs(ReachPart:GetTouchingParts()) do
                    coroutine.wrap(function()
                        if
                            v.Parent:FindFirstChild("Humanoid")
                            and v.Parent.Humanoid.Health > 0
                            and v.Parent.Humanoid.Health <= 100
                            and v.Parent ~= game:GetService("Players").LocalPlayer.Character
                            and game:GetService("Players").LocalPlayer.Character.Humanoid.Health > 0
                        then
                            if LaunchConfig["ReachOnlyOnLunge"] and getrealhandle().Parent.GripUp.Z ~= 0 then
                                return
                            end
                            if table.find(LaunchConfig["Whitelist"], v.Parent.Name) then
                                return
                            end
                            if
                                LaunchConfig["InvisibilityChecks"]
                                and v.Parent:FindFirstChildOfClass("Part").Transparency >= 1
                            then
                                return
                            end
                            if FakeHandle then
                                firetouchinterest(FakeHandle, v, 0)
                                firetouchinterest(FakeHandle, v, 1)
                            end
                            firetouchinterest(Handle, v, 0)
                            firetouchinterest(Handle, v, 1)
                        end
                    end)()
                    TouchConnection:Disconnect()
                end
            end
        end)
    else
        RadiusPart.CFrame = CFrame.new(0, 0, 0)
    end
end)

if not LaunchConfig["SilentLaunch"] then
    Notify({
        Description = "Celestial Sword Universal has been loaded successfully.",
        Title = "CELESTIAL",
        Duration = 5,
    })
end
