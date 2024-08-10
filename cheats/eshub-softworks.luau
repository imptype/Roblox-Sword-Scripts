-- source https://pastebin.com/iZXXiiAU
-- built on top of brew-reach.luau
-- updated at april 12, 2024

-- ESHub Softworks -- SwordHax v3; Made with Code <3
-------------------------------------------------------
-- open sourced cause i probably won't develop this
-- anymore
-------------------------------------------------------

---- General Variables & Functions ----
Players = game:GetService("Players")
Player = Players.LocalPlayer

---- ESHub Variables & Functions ----
ESHub = {
    -- Init ESHub Variables --
    isReach = false,
    curReach = "Spoof",
    damageAmp = false,
    reachMagnitude = Vector3.new(1, 0.800000011920929, 4),
    reachType = "Box",
    selBox = false,
    selBoxColor = Color3.fromRGB(0, 0, 0),

    cWalkspeed = 16,
    cJumppower = 50,
    cWalking = false,
    CFSpeed = 1.35,

    Autoclick = false,
    Spin = false,
}

function ESHub:Interpolate(part, targetCFrame, duration)
    return coroutine.wrap(function()
        local startTime = tick()
        local startCFrame = part.CFrame
        while tick() - startTime < duration do
            local elapsedTime = tick() - startTime
            local t = elapsedTime / duration
            local lerpedCFrame = startCFrame:Lerp(targetCFrame, t)
            local slerpedCFrame = CFrame.new(lerpedCFrame.Position, targetCFrame.Position)
                :lerp(lerpedCFrame, math.sin(t * math.pi * 0.5))

            part.CFrame = slerpedCFrame
            game:GetService("RunService").Heartbeat:Wait()
        end
        part.CFrame = targetCFrame
    end)
end
function ESHub:WaitForChildOfClass(parents, className, timeout)
    local startTime = tick()
    timeout = timeout or 9e9
    while tick() - startTime < timeout do
        for _, parent in pairs(parents) do
            for _, child in pairs(parent:GetChildren()) do
                if child:IsA(className) then
                    return child
                end
            end
        end
        wait(0.01)
    end
    return nil
end
function ESHub:Spoof(Instance, Property, Value)
    local b
    b = hookmetamethod(game, "__index", function(A, B)
        if not checkcaller() then
            if A == Instance then
                local filter = string.gsub(tostring(B), "\0", "")
                if filter == Property then
                    return Value
                end
            end
        end
        return b(A, B)
    end)
end
function ESHub:disableConnection(Connection)
    for i, v in pairs(getconnections(Connection)) do
        v:Disable()
    end
end
function ESHub:getSword()
    return ESHub:WaitForChildOfClass({ Player.Character, Player.Backpack }, "Tool")
end
function ESHub:getHitbox()
    for i, v in pairs(ESHub:getSword():GetDescendants()) do
        if v:FindFirstChildOfClass("TouchTransmitter") then
            v.Massless = true
            return v
        end
    end
end
function ESHub:doReach()
    ESHub:getSword()
    ESHub:disableConnection(ESHub:getHitbox():GetPropertyChangedSignal("Size"))
    ESHub:Spoof(ESHub:getHitbox(), "Size", Vector3.new(1, 0.800000011920929, 4))
    ESHub.isReach = true
    damageAmplification = ESHub:getHitbox().Touched:Connect(function(part)
        if ESHub.isReach == true and ESHub.damageAmp == true and part.Parent:FindFirstChildOfClass("Humanoid") then
            local victimCharacter = part.Parent
            for i, v in pairs(victimCharacter:GetChildren()) do
                if
                    v:IsA("Part")
                    and victimCharacter.Humanoid.Health ~= 0
                    and victimCharacter.Humanoid.Health > 0
                    and victimCharacter.Name ~= Player.Name
                then
                    task.spawn(function()
                        firetouchinterest(v, ESHub:getHitbox(), 0)
                        wait()
                        firetouchinterest(v, ESHub:getHitbox(), 1)
                    end)
                end
            end
        end
    end)
    while ESHub.isReach == true do
        ESHub:getHitbox().Size = ESHub.reachMagnitude
        wait()
    end
end
function ESHub:undoReach()
    ESHub:disableConnection(ESHub:getHitbox():GetPropertyChangedSignal("Size"))
    ESHub:Spoof(ESHub:getHitbox(), "Size", Vector3.new(1, 0.800000011920929, 4))
    ESHub.isReach = false
    if ESHub:getHitbox() then
        ESHub:getHitbox().Size = Vector3.new(1, 0.800000011920929, 4)
    end
    if damageAmplification then
        damageAmplification:Disconnect()
    end
end
function ESHub:doSelBox()
    if not ESHub:getHitbox():FindFirstChildOfClass("SelectionBox") then
        ESHub.selBox = true
        local Box = Instance.new("SelectionBox", ESHub:getHitbox())
        Box.Adornee = ESHub:getHitbox()
        Box.LineThickness = 0.01
        while ESHub.selBox == true do
            Box.Color3 = ESHub.selBoxColor
            wait()
        end
    end
end
function ESHub:undoSelBox()
    if ESHub:getHitbox() and ESHub:getHitbox():FindFirstChildOfClass("SelectionBox") then
        ESHub.selBox = false
        wait(0.15)
        ESHub:getHitbox():FindFirstChildOfClass("SelectionBox"):Destroy()
    end
end
function ESHub:Patch()
    local Seat = Instance.new("Seat")
    ESHub:Spoof(Seat, "Parent", nil)
    local Weld = Instance.new("Weld")
    ESHub:Spoof(Weld, "Parent", nil)
    Seat.Transparency = 1
    Seat.CanCollide = false
    wait(0.2)
    Player.Character["HumanoidRootPart"].Anchored = true
    Seat.Parent = workspace
    Seat.CFrame = Player.Character["HumanoidRootPart"].CFrame
    Seat.Anchored = false
    Weld.Parent = Seat
    Weld.Part0 = Seat
    Weld.Part1 = Player.Character["HumanoidRootPart"]
    Player.Character["HumanoidRootPart"].Anchored = false
    Seat.CFrame = Player.Character["HumanoidRootPart"].CFrame
end

---- Init ESHub ----
print([[----------------------------------
| __ ) _ __ _____      __
|  _ \| '__/ _ \ \ /\ / /
| |_) | | |  __/\ V  V /
|____/|_|  \___| \_/\_/    @dex4tw - bleh
----------------------------------------------]])
ESHub:disableConnection(game:GetService("ScriptContext").Error)

-- Init UI Library --
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/Vape.txt"))()
local Window = Library:Window("ESHub (" .. game.PlaceId .. ")", Color3.fromRGB(0, 0, 0), Enum.KeyCode.RightControl)
local WindowInstance = game:GetService("CoreGui"):WaitForChild("ui")
WindowInstance.Main:WaitForChild("Title").Text = "ESHub - Waiting For Sword (" .. game.PlaceId .. ")"
Sword = ESHub:WaitForChildOfClass({ Player.Character, Player.Backpack }, "Tool")
WindowInstance.Main:WaitForChild("Title").Text = "ESHub (" .. game.PlaceId .. ")"
local HomeTab = Window:Tab("Home")
local SwordTab = Window:Tab("Mods")
local CharacterTab = Window:Tab("Character")
local AppearanceTab = Window:Tab("Appearance")

-- Alert user of Executor --
Library:Notification(
    "Warning",
    "Please make sure you are using a proper executor, if not this may be detected.",
    "Okay"
)

-- Prevent Client-Sided Anticheat --
ESHub:disableConnection(ESHub:getHitbox():GetPropertyChangedSignal("Size"))

-- Setting Reconstruction --
Player.Character.Humanoid.Died:Connect(function()
    ESHub:Spoof(Player.Character.Humanoid, "WalkSpeed", 16)
    ESHub:Spoof(Player.Character.Humanoid, "JumpPower", 50)
    if ESHub:getHitbox() then
        ESHub:disableConnection(ESHub:getHitbox():GetPropertyChangedSignal("Size"))
        ESHub:Spoof(ESHub:getHitbox(), "Size", Vector3.new(1, 0.800000011920929, 4))
        ESHub:getHitbox().Size = Vector3.new(1, 0.800000011920929, 4)
        ESHub:undoReach()
        ESHub:undoSelBox()
    end
end)

Player.CharacterAdded:Connect(function()
    -- Re-do Settings --
    ESHub:getSword() -- wait for sword
    wait(0.25)
    for i, v in pairs(ESHub:getSword():GetDescendants()) do
        if v:FindFirstChildOfClass("TouchTransmitter") then
            v.Massless = true
        end
    end
    task.spawn(function()
        if ESHub.isReach == true then
            ESHub:doReach()
        end
    end)
    task.spawn(function()
        if ESHub.selBox == true then
            ESHub:doSelBox()
        end
    end)
    task.spawn(function()
        if ESHub.Spin then
            if not Player.Character:FindFirstChild("HumanoidRootPart"):FindFirstChildOfClass("BodyAngularVelocity") then
                local Velocity =
                    Instance.new("BodyAngularVelocity", Player.Character:FindFirstChild("HumanoidRootPart"))
                Velocity.AngularVelocity = Vector3.new(0, 75, 0)
                Velocity.MaxTorque = Vector3.new(0, 9e9, 0)
                Velocity.P = 1250
            end
        end
    end)
end)

-- Init UI Commands --
HomeTab:Label("ESHub V3 - Sword Modding")
HomeTab:Label("https://discord.gg/subdomain")

SwordTab:Toggle("Reach", false, function(value)
    if value == true then
        ESHub:doReach()
        ESHub.isReach = true
    elseif value == false then
        ESHub:undoReach()
        ESHub.isReach = false
    end
end)

SwordTab:Toggle("Damage Amp", false, function(value)
    if value == true then
        ESHub.damageAmp = true
    elseif value == false then
        ESHub.damageAmp = false
    end
end)

SwordTab:Textbox("Reach Magnitude", true, function(text)
    if ESHub.reachType == "Box" then
        ESHub.reachMagnitude = Vector3.new(tonumber(text), tonumber(text), tonumber(text))
    elseif ESHub.reachType == "Linear" then
        ESHub.reachMagnitude = Vector3.new(1, 0.800000011920929, tonumber(text))
    elseif ESHub.reachType == "Wide" then
        ESHub.reachMagnitude = Vector3.new(tonumber(text) * 0.3, tonumber(text) * 0.3, tonumber(text))
    end
end)

SwordTab:Dropdown("Reach Method", { "Sword Spoofing" }, function(option)
    ESHub.curReach = option
end)

SwordTab:Dropdown("Reach Type", { "Box", "Linear", "Wide" }, function(option)
    ESHub.reachType = option
    lastMagnitude = ESHub.reachMagnitude

    -- Set New Magnitude
    if ESHub.reachType == "Box" then
        ESHub.reachMagnitude = Vector3.new(lastMagnitude.Z, lastMagnitude.Z, lastMagnitude.Z)
    elseif ESHub.reachType == "Linear" then
        ESHub.reachMagnitude = Vector3.new(1, 0.800000011920929, lastMagnitude.Z)
    elseif ESHub.reachType == "Wide" then
        ESHub.reachMagnitude = Vector3.new(lastMagnitude.Z * 0.3, lastMagnitude.Z * 0.3, lastMagnitude.Z)
    end

    -- Restart Reach
    if ESHub.isReach then
        ESHub:undoReach()
        wait()
        ESHub:doReach()
    end
end)

SwordTab:Toggle("SelectionBox", false, function(value)
    if value == true then
        ESHub:doSelBox()
        ESHub.selBox = true
    elseif value == false then
        ESHub:undoSelBox()
        ESHub.selBox = false
    end
end)

SwordTab:Colorpicker("SelectionBox Color", Color3.fromRGB(0, 0, 0), function(color)
    ESHub.selBoxColor = color
end)

SwordTab:Toggle("Autoclick", false, function(value)
    if value == true then
        ESHub.Autoclick = true
        while ESHub.Autoclick do
            if ESHub:getSword().Parent == Player.Character then
                ESHub:getSword():Activate()
            end
            wait()
        end
    elseif value == false then
        ESHub.Autoclick = false
    end
end)

CharacterTab:Toggle("Spin", false, function(value)
    if value == true then
        ESHub.Spin = true
        if not Player.Character:FindFirstChild("HumanoidRootPart"):FindFirstChildOfClass("BodyAngularVelocity") then
            local Velocity = Instance.new("BodyAngularVelocity", Player.Character:FindFirstChild("HumanoidRootPart"))
            Velocity.AngularVelocity = Vector3.new(0, 75, 0)
            Velocity.MaxTorque = Vector3.new(0, 9e9, 0)
            Velocity.P = 1250
        end
    elseif value == false then
        ESHub.Spin = false
        if Player.Character:FindFirstChild("HumanoidRootPart"):FindFirstChildOfClass("BodyAngularVelocity") then
            Player.Character:FindFirstChild("HumanoidRootPart"):FindFirstChildOfClass("BodyAngularVelocity"):Destroy()
        end
    end
end)

CharacterTab:Textbox("Speed", true, function(ws)
    ESHub:Spoof(Player.Character:WaitForChild("Humanoid"), "WalkSpeed", 16)
    Player.Character:WaitForChild("Humanoid").WalkSpeed = tonumber(ws)
    ESHub.cWalkspeed = tonumber(ws)
end)

CharacterTab:Textbox("Jumppower", true, function(jp)
    ESHub:Spoof(Player.Character:WaitForChild("Humanoid"), "JumpPower", 50)
    Player.Character:WaitForChild("Humanoid").JumpPower = tonumber(jp)
    ESHub.cJumppower = tonumber(jp)
end)

AppearanceTab:Colorpicker("Accent Color", Color3.fromRGB(0, 0, 0), function(t)
    Library:ChangePresetColor(Color3.fromRGB(t.R * 255, t.G * 255, t.B * 255))
end)

AppearanceTab:Bind("Toggle UI", Enum.KeyCode.LeftControl, function()
    if WindowInstance.Enabled then
        WindowInstance.Enabled = false
    elseif WindowInstance.Enabled == false then
        WindowInstance.Enabled = true
    end
end)
