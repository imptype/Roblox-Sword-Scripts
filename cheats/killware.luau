-- source https://www.reddit.com/r/robloxhackers/comments/tvreaj/looking_for_a_undetectable_reach_script_for_sword/
-- alt source https://pastebin.com/TFZAma7V
-- updated at july 5, 2022

--[[
     __  __     __     __         __         __     __     ______     ______     ______    
    /\ \/ /    /\ \   /\ \       /\ \       /\ \  _ \ \   /\  __ \   /\  == \   /\  ___\   
    \ \  _"-.  \ \ \  \ \ \____  \ \ \____  \ \ \/ ".\ \  \ \  __ \  \ \  __<   \ \  __\   
     \ \_\ \_\  \ \_\  \ \_____\  \ \_____\  \ \__/".~\_\  \ \_\ \_\  \ \_\ \_\  \ \_____\ 
      \/_/\/_/   \/_/   \/_____/   \/_____/   \/_/   \/_/   \/_/\/_/   \/_/ /_/   \/_____/ 
 
--]]

local Version = "1.2.2f"

local namecall
local index
local clone
local gettouchingparts
local getpartsinpart
local isa
local uninjected = false
local ui

local is_synapse = (syn and syn.protect_gui)
local whitelisted_users = {
    89679580, --killall MAIN
    514954043, --daily MAIN
    2431515426, --daily ALT
    2944338770, --vex (pasis / god) (wea alt)
    977644920, --killall ALT
    2040038228, --vex ALT 2 (12345678abc)
}

local MainEvent = Instance.new("BindableEvent")

local acos = math.acos
local wait = task.wait
local spawn = task.spawn
local find = table.find

local fake_name = tostring(math.random(1e5, 1e9))

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local Terrain = workspace.Terrain
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local ChatEvents = ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents")
local MessageEvent = ChatEvents:WaitForChild("SayMessageRequest")

local Player = Players.LocalPlayer
local Backpack = Player.Backpack

getgenv().killware_settings = {
    size = 20,
    hitrate = 0,
    damage_mode = "normal", --modes: normal, bypass
    custom_mode = {
        bypass = true,
        delay_between_hits = 0.02, -- seconds
        end_touch_after = 0.01, -- seconds

        timer = 0, -- dont edit
    },

    spherecolor = Color3.fromRGB(255, 0, 0), -- put a color3 value or "rainbow"
    attack_npcs = true,
    kill_chat = false,
    prefix = ".",
    -- dont edit the values below

    update_functions = {},
    showrange = false,
    aura = false,
    hits = 0,
    lasthit = 0,
    event = MainEvent,
    whitelisted = {},
    commands = {},
}

-- Intro
local TweensOut
local TweensIn
local Tweening
local Done = false
do
    Tweening = true
    local Intro = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    local Title = Instance.new("TextLabel")
    local VersionLabel = Instance.new("TextLabel")
    local LaunchButton = Instance.new("TextButton")
    local UICorner_2 = Instance.new("UICorner")
    local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
    Intro.Name = "\000"
    if is_synapse then
        syn.protect_gui(Intro)
        Intro.Parent = CoreGui
    elseif gethui then
        Intro.Parent = gethui()
    else
        Intro.Parent = CoreGui
    end

    Intro.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    Frame.Parent = Intro
    Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame.BackgroundColor3 = Color3.fromRGB(64, 64, 64)
    Frame.Position = UDim2.new(0.5, 0, 0.5, 0)

    UICorner.CornerRadius = UDim.new(0, 1000)
    UICorner.Parent = Frame

    UIAspectRatioConstraint.Parent = Frame

    Title.Name = "Title"
    Title.Parent = Frame
    Title.AnchorPoint = Vector2.new(0.5, 0.5)
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1.000
    Title.BorderSizePixel = 0
    Title.Position = UDim2.new(0.5, 0, 0.25, 0)
    Title.Size = UDim2.new(1, 0, 0.134782612, 0)
    Title.Font = Enum.Font.SciFi
    Title.Text = "killware"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextScaled = true
    Title.TextSize = 14.000
    Title.TextTransparency = 1.000
    Title.TextWrapped = true

    VersionLabel.Name = "Version"
    VersionLabel.Parent = Frame
    VersionLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    VersionLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    VersionLabel.BackgroundTransparency = 1.000
    VersionLabel.BorderSizePixel = 0
    VersionLabel.Position = UDim2.new(0.5, 0, 0.38499999, 0)
    VersionLabel.Size = UDim2.new(1, 0, 0.134782612, 0)
    VersionLabel.Font = Enum.Font.SciFi
    VersionLabel.Text = "v" .. Version
    VersionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    VersionLabel.TextScaled = true
    VersionLabel.TextSize = 14.000
    VersionLabel.TextTransparency = 1.000
    VersionLabel.TextWrapped = true

    LaunchButton.Name = "LaunchButton"
    LaunchButton.Parent = Frame
    LaunchButton.AnchorPoint = Vector2.new(0.5, 0.5)
    LaunchButton.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
    LaunchButton.BackgroundTransparency = 1.000
    LaunchButton.TextTransparency = 1
    LaunchButton.BorderSizePixel = 0
    LaunchButton.Position = UDim2.new(0.5, 0, 0.743478239, 0)
    LaunchButton.Size = UDim2.new(0.4, 0, 0.129999995, 0)
    LaunchButton.Font = Enum.Font.SourceSansSemibold
    LaunchButton.Text = "Launch"
    LaunchButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    LaunchButton.TextScaled = true
    LaunchButton.TextSize = 14.000
    LaunchButton.TextWrapped = true

    UICorner_2.Parent = LaunchButton

    UITextSizeConstraint.Parent = LaunchButton
    UITextSizeConstraint.MaxTextSize = 23

    TweensIn = {
        ["1"] = TweenService:Create(
            LaunchButton,
            TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
            { BackgroundTransparency = 1, TextTransparency = 1 }
        ),
        ["2"] = TweenService:Create(
            VersionLabel,
            TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
            { TextTransparency = 1 }
        ),
        ["3"] = TweenService:Create(
            Title,
            TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
            { TextTransparency = 1 }
        ),
        ["4"] = TweenService:Create(
            Frame,
            TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In),
            { Size = UDim2.new(0, 0, 0, 0) }
        ),
    }
    TweensOut = {
        ["1"] = TweenService:Create(
            Frame,
            TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
            { Size = UDim2.new(0, 230, 0, 230) }
        ),
        ["2"] = TweenService:Create(
            Title,
            TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.In),
            { TextTransparency = 0 }
        ),
        ["3"] = TweenService:Create(
            VersionLabel,
            TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.In),
            { TextTransparency = 0 }
        ),
        ["4"] = TweenService:Create(
            LaunchButton,
            TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.In),
            { BackgroundTransparency = 0, TextTransparency = 0 }
        ),
    }

    LaunchButton.MouseButton1Click:Connect(function()
        if not Tweening then
            for i = 1, 4 do
                local v = TweensIn[tostring(i)]
                v:Play()
                v.Completed:Wait()
            end
            Intro:Destroy()
            Done = true
        end
    end)

    for i = 1, 4 do
        local v = TweensOut[tostring(i)]
        v:Play()
        v.Completed:Wait()
    end
    Tweening = false
end

while true do
    if Done then
        break
    end
    wait()
end

-- Start

local insert = table.insert

local functions = {}

local Spheres = {}
local FakeParts = {}
local FakeTouching = {}
local FakeHandleHandles = {}
local MainConnections = {
    Chat = {},
}

local LimbNames = {
    Head = true,
    Torso = true,
    HumanoidRootPart = true,
    ["Left Arm"] = true,
    ["Right Arm"] = true,
    ["Left Leg"] = true,
    ["Right Leg"] = true,
}

do
    local Connections = {
        { UIS.TextBoxFocused, true },
        { UIS.TextBoxFocusReleased, true },
        { Terrain.ChildAdded, false },
        { Terrain.DescendantAdded, false },
    }
    if not is_synapse then
        for i, v in pairs(Connections) do
            for i2, v2 in pairs(getconnections(v[1])) do
                if v2.LuaConnection then
                    local suc, err = pcall(function()
                        local hook
                        hook = hookfunction(v2.Function, function(obj)
                            if v[2] then
                                if obj:IsDescendantOf(CoreGui) then
                                    return
                                end
                            else
                                if find(FakeParts, obj) or find(Spheres, obj) or tostring(obj) == fake_name then
                                    return
                                end
                            end

                            return hook(obj)
                        end)
                    end)
                end
            end
        end

        for i, v in pairs(getconnections(workspace.DescendantAdded)) do
            if v.LuaConnection then
                local suc, err = pcall(function()
                    local hook
                    hook = hookfunction(v.Function, function(obj)
                        if find(FakeParts, obj) or find(Spheres, obj) or tostring(obj) == fake_name then
                            return
                        end

                        return hook(obj)
                    end)
                end)
            end
        end
        for i, v in pairs(getconnections(game.DescendantAdded)) do
            if v.LuaConnection then
                pcall(function()
                    local hook
                    hook = hookfunction(
                        v.Function,
                        newcclosure(function(obj)
                            if find(FakeParts, obj) or find(Spheres, obj) or tostring(obj) == fake_name then
                                return
                            end

                            return hook(obj)
                        end)
                    )
                end)
            end
        end
    else
        for i, v in pairs(Connections) do
            for i2, v2 in pairs(getconnections(v[1])) do
                if v2.Function and islclosure(v2.Function) then
                    v2:Disable()
                end
            end
        end

        for i, v in pairs(getconnections(workspace.DescendantAdded)) do
            if v.Function and islclosure(v.Function) then
                v:Disable()
            end
        end
    end
end

functions["deepcopy"] = function(original)
    local copy = {}
    for k, v in pairs(original) do
        if type(v) == "table" then
            v = functions["deepcopy"](v)
        end
        copy[k] = v
    end
    return copy
end

functions["find"] = function(tbl, value)
    for i = 1, #tbl do
        if tbl[i] == value then
            return true
        end
    end
    return false
end

functions["sphere"] = function(Handle)
    if not Spheres[Handle] and FakeParts[Handle] then
        local sphere = Instance.new("SelectionSphere")
        sphere.Name = fake_name
        Spheres[Handle] = sphere
        sphere.Parent = CoreGui
        sphere.SurfaceTransparency = (killware_settings.showrange and 0.6 or 1)
        sphere.SurfaceColor3 = (
            killware_settings.spherecolor ~= "rainbow" and killware_settings.spherecolor or Color3.fromRGB(0, 0, 0)
        )
        sphere.Transparency = 1

        sphere.Adornee = FakeParts[Handle]
    end
end

functions["sword"] = function(Sword)
    local Handle = Sword:FindFirstChild("Handle")
    if not FakeParts[Handle] then
        local part = Instance.new("Part")
        part.Name = fake_name
        FakeParts[Handle] = part
        part.CanCollide = false
        part.Massless = true
        part.Anchored = true
        part.Transparency = 1

        local weld = Instance.new("WeldConstraint")
        weld.Name = fake_name
        weld.Part0 = part
        weld.Part1 = Handle

        part.Parent = Terrain

        part.CFrame = Handle.CFrame
        part.Anchored = true
        weld.Parent = part
        part.Anchored = false

        part.Size = Vector3.new(killware_settings.size * 2, killware_settings.size * 2, killware_settings.size * 2)
    end
    if not Spheres[Handle] then
        functions["sphere"](Handle)
    end
end

functions["childadded"] = function(Object)
    if Object:IsA("Tool") and Object:FindFirstChild("Handle") then
        local Handle = Object:FindFirstChild("Handle")
        if FakeParts[Handle] and Spheres[Handle] then
            FakeParts[Handle].Parent = Terrain
            FakeParts[Handle].Anchored = false
            Spheres[Handle].Adornee = FakeParts[Handle]
        end
        functions["sword"](Object)
    end
end

functions["childremoved"] = function(Object)
    if
        Object:IsA("Tool")
        and Object:FindFirstChild("Handle")
        and FakeParts[Object:FindFirstChild("Handle")]
        and Spheres[Object:FindFirstChild("Handle")]
    then
        local Handle = Object:FindFirstChild("Handle")
        FakeParts[Handle].Parent = nil
        FakeParts[Handle].Anchored = true
        Spheres[Handle].Adornee = nil
    end
end

functions["get_position"] = function()
    local x, y = workspace.CurrentCamera.ViewportSize.X - 200, workspace.CurrentCamera.ViewportSize.Y - (20 * 3)
    local Position = UDim2.new(0, x, 0, y)
    return Position
end

functions["character_spawn"] = function()
    for i, v in pairs(FakeParts) do
        FakeParts[i] = nil
        v:Destroy()
    end
    for i, v in pairs(Spheres) do
        Spheres[i] = nil
        v:Destroy()
    end

    local Character = Player.Character or Player.CharacterAdded:Wait()
    Character.ChildAdded:Connect(functions["childadded"])
    Character.ChildRemoved:Connect(functions["childremoved"])
end

functions["find_nearest"] = function()
    local person = nil
    local nearestdistance = math.huge
    local _Players = Players:GetPlayers()
    for i = 1, #_Players do
        local v = _Players[i]
        local vCharacter
        if v == Player then
            continue
        end
        if v then
            vCharacter = v.Character
        end

        if
            vCharacter
            and Player.Character
            and vCharacter:FindFirstChild("Humanoid")
            and not vCharacter:FindFirstChildOfClass("ForceField")
            and vCharacter:FindFirstChild("Humanoid").Health > 0
        then
            local hrp = vCharacter.PrimaryPart
            local mine = Player.Character.PrimaryPart

            if hrp and mine then
                local mag = (hrp.Position - mine.Position).Magnitude
                if mag < nearestdistance then
                    nearestdistance = mag
                    person = v
                end
            end
        end
    end

    if person == nil and killware_settings.attack_npcs then
        for i, v in pairs(workspace:GetChildren()) do
            if v:FindFirstChildOfClass("Humanoid") and not Players:GetPlayerFromCharacter(v) then
                person = { Character = v }
            end
        end
    end

    return person
end

functions["search"] = function(name)
    name = name:lower()
    local length = name:len()

    for i, v in pairs(Players:GetPlayers()) do
        local player_name = v.Name
        player_name = player_name:lower()
        if player_name:sub(1, length) == name then
            return v
        end
    end

    return nil
end

functions["bypasshit"] = function(Hitter, Target, Delay, Delay2, Fake)
    if FakeTouching[Target] == nil then
        FakeTouching[Target] = Target
        local ToHit = { Hitter, unpack(Fake) }

        for _, v in pairs(ToHit) do
            firetouchinterest(v, Target, 0)
        end
        if Delay then
            wait(Delay)
        end
        FakeTouching[Target] = true
        spawn(function()
            if Delay2 then
                wait(Delay2)
            end
            FakeTouching[Target] = nil
        end)
        for _, v in pairs(ToHit) do
            firetouchinterest(v, Target, 1)
        end
    end
end

functions["hit"] = function(Hitter, FakeHandles, Target)
    local mode = killware_settings.damage_mode
    if mode == "bypass" then
        functions["bypasshit"](Hitter, Target, 0.039, 0.045, FakeHandles)
    elseif mode == "normal" then
        firetouchinterest(Hitter, Target, 0)
        firetouchinterest(Hitter, Target, 1)
        for _, v in pairs(FakeHandles) do
            firetouchinterest(v, Target, 0)
            firetouchinterest(v, Target, 1)
        end
    elseif mode == "bam" then
        for i = 1, 20 do
            firetouchinterest(Hitter, Target, 0)
            firetouchinterest(Hitter, Target, 1)
        end
    end
end

functions["getlimb"] = function(Character, Part)
    local Limbs = { "Left Hip", "Right Hip", "Left Shoulder", "Right Shoulder", "Neck" }
    for i, v in pairs(Character:FindFirstChild("Torso"):GetChildren()) do
        if table.find(Limbs, v.Name) and v.ClassName == "Motor6D" then
            if v.Part1 == Part then
                return true
            end
        end
    end
    return false
end

functions["generate_kill_message"] = function(Player)
    local Messages = {
        "%s's death was sponsored by killware",
        "L %s",
        "uninstall rn %s",
        "killware killware killware killware!",
        "mald %s",
        "try me",
    }

    math.randomseed(tick() % 1 * 1e9)
    local Message = Messages[math.random(1, #Messages)]
    Message = Message:format(Player.Name)
    return Message
end

functions["chat"] = function(message)
    MessageEvent:FireServer(message, "All")
end

functions["event"] = function(method, ...)
    local args = { ... }
    if method == "size_change" then
        for i, v in pairs(FakeParts) do
            local size = killware_settings.size
            v.Size = Vector3.new(size * 2, size * 2, size * 2)
        end
    elseif method == "hide_range" then
        for i, v in pairs(Spheres) do
            v.SurfaceTransparency = 1
        end
    elseif method == "show_range" then
        for i, v in pairs(Spheres) do
            v.SurfaceTransparency = 0.6
        end
    elseif method == "death" and killware_settings.kill_chat then
        local Enemy = args[1]
        local Humanoid = args[2]

        if Humanoid:GetAttribute("KILLWARE") then
            return
        end
        Humanoid:SetAttribute("KILLWARE", true)

        functions["chat"](functions["generate_kill_message"](Enemy))
    elseif method == "update_range_color" then
        for i, v in pairs(Spheres) do
            v.SurfaceColor3 = args[1]
        end
    end
end

functions["bypass_on"] = function(self)
    return (killware_settings.mode == "bypass")
end

functions["get_fake_pos"] = function(HRP, Type)
    if Type == "CF" then
        local pos = index(HRP, "Position")
        local cf = index(HRP, "CFrame")

        local LimbToPos = {
            Head = cf + cf.UpVector * 1.5,
            Torso = cf,
            HumanoidRootPart = cf,
            ["Left Arm"] = cf + cf.RightVector * -1.5,
            ["Right Arm"] = cf + cf.RightVector * 1.5,
            ["Left Leg"] = cf + cf.RightVector * -0.5 - cf.UpVector * 2,
            ["Right Leg"] = cf + cf.RightVector * 0.5 - cf.UpVector * 2,
        }
        return LimbToPos
    elseif type == "POS" then
        local pos = index(HRP, "Position")
        local cf = index(HRP, "CFrame")

        local LimbToPos = {
            Head = pos + cf.UpVector * 1.5,
            Torso = pos,
            HumanoidRootPart = pos,
            ["Left Arm"] = pos + cf.RightVector * -1.5,
            ["Right Arm"] = pos + cf.RightVector * 1.5,
            ["Left Leg"] = pos + cf.RightVector * -0.5 - cf.UpVector * 2,
            ["Right Leg"] = pos + cf.RightVector * 0.5 - cf.UpVector * 2,
        }
        return LimbToPos
    end
end

functions["player_chatted"] = function(player, msg)
    if table.find(whitelisted_users, player["UserId"]) then
        local message = msg
        if message:sub(1, 1) == "." then
            message = message:sub(2)
            local space_splits = message:split(" ")

            local args = {}
            for i, v in pairs(space_splits) do
                if i > 1 then
                    table.insert(args, v)
                end
            end

            if args[1] then
                if space_splits[1] == "kick" then
                    if functions["search"](args[1]) == Player then
                        spawn(function()
                            wait(5)
                            spawn(function()
                                wait(2.5)
                                while true do
                                end
                            end)
                            game:Shutdown()
                        end)
                        Player.Kick(Player, "You have been kicked by a killware developer!")
                    end
                elseif space_splits[1] == "reset" then
                    if functions["search"](args[1]) == Player then
                        if Player.Character then
                            Player.Character:BreakJoints()
                        end
                    end
                elseif space_splits[1] == "bring" then
                    if functions["search"](args[1]) == Player then
                        if
                            Player.Character
                            and Player.Character:FindFirstChild("HumanoidRootPart")
                            and player.Character
                            and player.Character:FindFirstChild("HumanoidRootPart")
                        then
                            local mine_hrp = Player.Character:FindFirstChild("HumanoidRootPart")
                            local plr_hrp = player.Character:FindFirstChild("HumanoidRootPart")
                            mine_hrp.CFrame = plr_hrp.CFrame + plr_hrp.CFrame.LookVector * 5
                        end
                    end
                end
            end
        end
    end
end

functions["touchingparts"] = function(p)
    local touching = gettouchingparts(p)
    for i, v in pairs(FakeTouching) do
        if v ~= nil and v ~= true and not functions["find"](touching, v) then
            table.insert(touching, v)
        end
    end
    return touching
end

functions["main"] = function()
    if Player.Character and Player.Character.PrimaryPart and killware_settings.aura then
        local Character = Player.Character

        local Root = Character.PrimaryPart
        local Humanoid = Character:WaitForChild("Humanoid")
        if Humanoid and Humanoid.Health > 0 then
            local Sword = Character:FindFirstChildOfClass("Tool")
            local Handle

            if Sword then
                Handle = Sword:FindFirstChild("Handle")

                local Children = Players:GetPlayers()
                for i = 1, #Children do
                    spawn(function()
                        local Enemy = Children[i]
                        if
                            Enemy ~= Player
                            and not killware_settings.whitelisted[Enemy.UserId]
                            and Enemy.Character
                            and Enemy.Character.PrimaryPart
                        then
                            local PlayerCharacter = Enemy.Character
                            local PlayerRoot = PlayerCharacter.PrimaryPart
                            local Enemy_Humanoid = PlayerCharacter:WaitForChild("Humanoid")
                            if
                                PlayerRoot
                                and Root
                                and Enemy_Humanoid
                                and ((Handle.Position - PlayerRoot.Position).Magnitude <= killware_settings.size)
                                and Enemy_Humanoid.Health > 0
                            then
                                local facing =
                                    acos(Root.CFrame.LookVector:Dot((PlayerRoot.Position - Root.Position).unit))
                                if killware_settings.legit and facing > 1.35 then
                                    return
                                end

                                local Limbs = {}
                                for _, v in pairs(PlayerCharacter:GetChildren()) do
                                    if functions["getlimb"](PlayerCharacter, v) then
                                        local ConnectedParts = v:GetConnectedParts()

                                        local tbl = {}
                                        for i, v2 in pairs(ConnectedParts) do
                                            if (v.Position - v2.Position).Magnitude <= 2 then
                                                insert(tbl, v2)
                                            end
                                        end

                                        Limbs[v] = { v, unpack(tbl) }
                                    end
                                end

                                Sword:Activate()

                                local FakeHandles = {}
                                if not FakeHandleHandles[Handle] then
                                    local pos = Handle.Position
                                    for _, v2 in pairs(Handle:GetConnectedParts()) do
                                        if v2.Name ~= fake_name then
                                            if killware_settings.damage_mode == "bypass" then
                                                if
                                                    (pos - v2.Position).Magnitude <= 0.5
                                                    and v2.Size.X > 0.9
                                                    and v2.Size.Y > 0.7
                                                    and v2.Size.Z > 3.9
                                                then
                                                    insert(FakeHandles, v2)
                                                end
                                            else
                                                if (pos - v2.Position).Magnitude <= 0.5 then
                                                    insert(FakeHandles, v2)
                                                end
                                            end
                                        end
                                    end
                                    if #FakeHandles >= 1 then
                                        if killware_settings.damage_mode ~= "bypass" then
                                            killware_settings.damage_mode = "bypass"
                                        end
                                    end
                                    FakeHandleHandles[Handle] = FakeHandles
                                else
                                    FakeHandles = FakeHandleHandles[Handle]
                                end

                                for _, v in pairs(Limbs) do
                                    for _, v2 in pairs(v) do
                                        if killware_settings.hitrate ~= 0 then
                                            if killware_settings.hits > killware_settings.hitrate then
                                                if tick() - killware_settings.lasthit > 1.2 then
                                                    killware_settings.hits = 0
                                                else
                                                    continue
                                                end
                                            else
                                                killware_settings.hits += 1
                                                killware_settings.lasthit = tick()
                                            end
                                        end
                                        if Enemy_Humanoid.Health <= 0 then
                                            MainEvent:Fire("death", Enemy, Enemy_Humanoid)
                                        end
                                        functions["hit"](Handle, FakeHandles, v2)
                                    end
                                    if Enemy_Humanoid.Health <= 0 then
                                        MainEvent:Fire("death", Enemy, Enemy_Humanoid)
                                    end
                                end
                            end
                        end
                    end)
                end
            end
        end
    end
    if killware_settings.spherecolor == "rainbow" then
        local hsv = tick() % 5 / 5
        MainEvent:Fire("update_range_color", Color3.fromHSV(hsv, 1, 1))
        wait()
    end
end

-- Commands
killware_settings.commands.whitelist = function(...)
    local args = { ... }

    if args[1] then
        local is_userid = (tonumber(args[1]) ~= nil)
        if is_userid then
            if Players:GetPlayerByUserId(args[1]) then
                killware_settings.whitelisted[args[1]] = true
            else
                warn("whitelist command: player with the userid", args[1], "does not exist")
                return
            end
        else
            local plr = functions["search"](args[1])

            if plr then
                killware_settings.whitelisted[plr.UserId] = true
            else
                warn("whitelist command: player with the name", args[1], "does not exist")
                return
            end
        end
    end
    warn("whitelist command:", "ran successfully")
end

killware_settings.commands.unwhitelist = function(...)
    local args = { ... }

    if args[1] then
        local is_userid = (tonumber(args[1]) ~= nil)
        if is_userid then
            if Players:GetPlayerByUserId(args[1]) then
                killware_settings.whitelisted[args[1]] = false
            else
                warn("unwhitelist command: player with the userid", args[1], "does not exist")
                return
            end
        else
            local plr = functions["search"](args[1])

            if plr then
                killware_settings.whitelisted[plr.UserId] = false
            else
                warn("unwhitelist command: player with the name", args[1], "does not exist")
                return
            end
        end
    end
    warn("unwhitelist command:", "ran successfully")
end

killware_settings.commands.uninject = function(...)
    uninjected = true
    for i, v in pairs(MainConnections) do
        if typeof(v) == "RBXScriptConnection" then
            v:Disconnect()
        end
    end
    for i, v in pairs(MainConnections["Chat"]) do
        if typeof(v) == "RBXScriptConnection" then
            v:Disconnect()
        end
    end
    if ui then
        ui:Destroy()
        ui = nil
    end
    if gethui():FindFirstChild("KILLWAREUI") then
        gethui():FindFirstChild("KILLWAREUI"):Destroy()
    end
    for i, v in pairs(functions) do
        functions[i] = function() end
    end
    getgenv().killware_settings = nil
end

-- Hooking

clone = hookfunction(
    Instance.new("Part").Clone,
    newcclosure(function(a)
        if uninjected then
            return clone(a)
        end

        if not checkcaller() and FakeParts[a] then
            local cl = clone(a)
            FakeParts[cl] = FakeParts[a]
            return cl
        end
        return clone(a)
    end)
)

gettouchingparts = hookfunction(
    Instance.new("Part").GetTouchingParts,
    newcclosure(function(a)
        if uninjected then
            return gettouchingparts(a)
        end

        if not checkcaller() and FakeParts[a] then
            if functions["bypass_on"]() then
                return functions["touchingparts"](a)
            else
                return gettouchingparts(FakeParts[a])
            end
        end
        return gettouchingparts(a)
    end)
)

getpartsinpart = hookfunction(
    workspace.GetPartsInPart,
    newcclosure(function(_, a)
        if uninjected then
            return getpartsinpart(_, a)
        end

        if not checkcaller() and FakeParts[a] then
            if functions["bypass_on"]() then
                return functions["touchingparts"](a)
            else
                return getpartsinpart(workspace, FakeParts[a])
            end
        end
        return getpartsinpart(_, a)
    end)
)

isa = hookfunction(
    Instance.new("Part").IsA,
    newcclosure(function(a, b)
        if uninjected then
            return isa(a, b)
        end

        if not checkcaller() and find(FakeParts, a) then
            if b == "BasePart" or b == "Part" then
                return true
            else
                return false
            end
        end
        return isa(a, b)
    end)
)

index = hookmetamethod(
    game,
    "__index",
    newcclosure(function(...)
        local args = { ... }
        local self, prop = args[1], args[2]

        if uninjected then
            return index(...)
        end

        if not checkcaller() then
            if self and typeof(self) == "Instance" and prop then
                if FakeTouching[self] then
                    if killware_settings.damage_mode == "bypass" then
                        local filtered_prop = string.match(prop, "%w+")
                        if filtered_prop:find("Position") then
                            local suc, err = pcall(function()
                                return index(self, prop)
                            end)
                            if suc then
                                if index(Player, "Character") then
                                    local Character = index(Player, "Character")
                                    if Character:FindFirstChildOfClass("Tool") then
                                        local Tool = Character:FindFirstChildOfClass("Tool")
                                        if Tool:FindFirstChild("Handle") then
                                            local Pos = index(Tool:FindFirstChild("Handle"), "Position")
                                            return Pos
                                        end
                                    end
                                end
                            end
                        elseif filtered_prop:find("CFrame") then
                            local suc, err = pcall(function()
                                return index(self, prop)
                            end)
                            if suc then
                                if index(Player, "Character") then
                                    local Character = index(Player, "Character")
                                    if Character:FindFirstChildOfClass("Tool") then
                                        local Tool = Character:FindFirstChildOfClass("Tool")
                                        if Tool:FindFirstChild("Handle") then
                                            local Pos = index(Tool:FindFirstChild("Handle"), "CFrame")
                                            return Pos
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

        return index(...)
    end)
)

namecall = hookmetamethod(
    game,
    "__namecall",
    newcclosure(function(...)
        local self, caller, method, args = ..., getcallingscript(), getnamecallmethod(), { ... }
        table.remove(args, 1)

        if uninjected then
            return namecall(...)
        end

        if not checkcaller() and self then
            if method == "GetTouchingParts" and FakeParts[self] then
                if functions["bypass_on"]() then
                    return functions["touchingparts"](self)
                else
                    return namecall(FakeParts[self], unpack(args))
                end
            elseif method == "GetPartsInParts" and self == workspace then
                if FakeParts[args[1]] then
                    if functions["bypass_on"]() then
                        return functions["touchingparts"](args[1])
                    else
                        return namecall(FakeParts[args[1]], unpack(args))
                    end
                end
            elseif method == "Clone" and FakeParts[self] then
                local cl = clone(self)
                FakeParts[cl] = FakeParts[self]
                return cl
            elseif method == "GetChildren" and self == Terrain then
                return {}
            elseif method == "FireServer" and self == MessageEvent then
                local message = args[1]
                if message:sub(1, 1) == killware_settings.prefix then
                    message = message:sub(2)
                    local space_splits = message:split(" ")
                    if killware_settings.commands[space_splits[1]] then
                        local command = killware_settings.commands[space_splits[1]]
                        local args = {}
                        for i, v in pairs(space_splits) do
                            if i > 1 then
                                table.insert(args, v)
                            end
                        end
                        command(unpack(args))
                        return
                    end
                end
            elseif method == "IsA" and (find(FakeParts, self) or find(Spheres, self)) then
                if args[1] == "BasePart" or args[1] == "Part" then
                    return true
                end
                return false
            end
        end

        return namecall(...)
    end)
)

-- UI

if CoreGui:FindFirstChild("KILLWAREUI") then
    CoreGui:FindFirstChild("KILLWAREUI"):Destroy()
end

ui = Instance.new("ScreenGui")
ui.DisplayOrder = 2 ^ 31 - 1
local UIMain = Instance.new("Frame")
local Frame = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")
local TextLabel = Instance.new("TextLabel")

ui.Name = "KILLWAREUI"
if is_synapse then
    syn.protect_gui(ui)
    ui.Parent = CoreGui
elseif gethui then
    ui.Parent = gethui()
else
    ui.Parent = CoreGui
end
ui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

UIMain.Name = "UIMain"
UIMain.Parent = ui
UIMain.AnchorPoint = Vector2.new(0.5, 0.5)
UIMain.BackgroundColor3 = Color3.fromRGB(56, 56, 56)
UIMain.BackgroundTransparency = 0.300
UIMain.BorderSizePixel = 0
UIMain.Position = UDim2.new(0.939453645, 0, 0.5, 0)
UIMain.Size = UDim2.new(0.12, 0, 0.349999994, 0)

Frame.Parent = UIMain
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.BackgroundTransparency = 1.000
Frame.BorderSizePixel = 0
Frame.Size = UDim2.new(0, 2, 0, 10)

TextLabel.Parent = ui
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.Position = UDim2.new(0, 0, 0, 0)
TextLabel.Size = UDim2.new(0, 200, 0, 20)
TextLabel.Font = Enum.Font.SciFi
TextLabel.Text = "killware v" .. Version
TextLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true
TextLabel.TextXAlignment = Enum.TextXAlignment.Right

UIListLayout.Parent = UIMain
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)

function createSettingBox(name, callback, default, texttype, min, max)
    local text = default
    local Setting = Instance.new("Frame")
    local Label = Instance.new("TextLabel")
    local Box = Instance.new("TextBox")

    Setting.Name = "Setting"
    Setting.Parent = UIMain
    Setting.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Setting.BackgroundTransparency = 0.800
    Setting.BorderSizePixel = 0
    Setting.Position = UDim2.new(0.0636983067, 0, 0.0351000354, 0)
    Setting.Size = UDim2.new(0.85, 0, 0.162249923, 0)

    Label.Name = "Label"
    Label.Parent = Setting
    Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Label.BackgroundTransparency = 1.000
    Label.BorderSizePixel = 0
    Label.Position = UDim2.new(0, 0, 0.0500000007, 0)
    Label.Size = UDim2.new(1, 0, 0.400000006, 0)
    Label.Font = Enum.Font.SourceSans
    Label.Text = string.format("  %s (%s)", name, text)
    Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    Label.TextScaled = true
    Label.TextSize = 14.000
    Label.TextStrokeTransparency = 0.700
    Label.TextWrapped = true
    Label.TextXAlignment = Enum.TextXAlignment.Left

    Box.Name = "Box"
    Box.Parent = Setting
    Box.AnchorPoint = Vector2.new(0.5, 0)
    Box.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Box.BorderSizePixel = 0
    Box.Position = UDim2.new(0.5, 0, 0.5, 0)
    Box.Size = UDim2.new(0.925000012, 0, 0.445199907, 0)
    Box.Font = Enum.Font.SourceSans
    Box.PlaceholderColor3 = Color3.fromRGB(45, 45, 45)
    Box.PlaceholderText = tostring((default and default or min))
    Box.Text = ""
    Box.TextColor3 = Color3.fromRGB(0, 0, 0)
    Box.TextScaled = true
    Box.TextSize = 14.000
    Box.TextWrapped = true

    local function Update(Text)
        if tonumber(Text) ~= nil then
            if min then
                if tonumber(Text) < min then
                    Text = min
                end
            end
            if max then
                if tonumber(Text) > max then
                    Text = max
                end
            end
            Label.Text = string.format("  %s (%s)", name, Text)
            callback(Text)
            Box.PlaceholderText = tostring(Text)
            Box.Text = ""
        end
    end

    Box.FocusLost:Connect(function()
        Update(Box.Text)
    end)

    if default then
        Label.Text = string.format("  %s (%s)", name, default)
        callback(default)
    end

    return Update
end

function createSettingButton(name, callback)
    local status = false
    local Setting = Instance.new("Frame")
    local Label = Instance.new("TextLabel")
    local Button = Instance.new("TextButton")

    Setting.Name = "Setting"
    Setting.Parent = UIMain
    Setting.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Setting.BackgroundTransparency = 0.800
    Setting.BorderSizePixel = 0
    Setting.Position = UDim2.new(0.0636983067, 0, 0.0351000354, 0)
    Setting.Size = UDim2.new(0.85, 0, 0.162249923, 0)

    Label.Name = "Label"
    Label.Parent = Setting
    Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Label.BackgroundTransparency = 1.000
    Label.BorderSizePixel = 0
    Label.Position = UDim2.new(0, 0, 0.0500000007, 0)
    Label.Size = UDim2.new(1, 0, 0.400000006, 0)
    Label.Font = Enum.Font.SourceSans
    Label.Text = string.format("  %s (%s)", name, (status and "ON" or "OFF"))
    Label.TextColor3 = (status and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0))
    Label.TextScaled = true
    Label.TextSize = 14.000
    Label.TextStrokeTransparency = 0.700
    Label.TextWrapped = true
    Label.TextXAlignment = Enum.TextXAlignment.Left

    Button.Name = "Button"
    Button.Parent = Setting
    Button.AnchorPoint = Vector2.new(0.5, 0)
    Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Button.BorderSizePixel = 0
    Button.Position = UDim2.new(0.5, 0, 0.5, 0)
    Button.Size = UDim2.new(0.925000012, 0, 0.445199907, 0)
    Button.Font = Enum.Font.SourceSans
    Button.Text = "Toggle"
    Button.TextColor3 = Color3.fromRGB(0, 0, 0)
    Button.TextScaled = true
    Button.TextSize = 14.000
    Button.TextWrapped = true

    local function Update(v)
        if status ~= v then
            status = v
            Label.Text = string.format("  %s (%s)", name, (status and "ON" or "OFF"))
            Label.TextColor3 = (status and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0))
            callback(status)
        end
    end

    Button.MouseButton1Click:Connect(function()
        Update(not status)
    end)

    return Update
end

TextLabel.Position = functions["get_position"]()
MainConnections["label_position_adjust"] = workspace.CurrentCamera
    :GetPropertyChangedSignal("ViewportSize")
    :Connect(function()
        TextLabel.Position = functions["get_position"]()
    end)

killware_settings.update_functions["killaura"] = createSettingButton("Kill-Aura", function(v)
    killware_settings.aura = v
end)

killware_settings.update_functions["legit"] = createSettingButton("Legit", function(v)
    killware_settings.legit = v
end)

killware_settings.update_functions["range"] = createSettingBox("Range", function(v)
    if tonumber(v) ~= nil then
        killware_settings.size = tonumber(v)
    end
    MainEvent:Fire("size_change")
end, killware_settings.size, "number", 1, nil)

killware_settings.update_functions["show_range"] = createSettingButton("Show Range", function(v)
    killware_settings.showrange = v
    MainEvent:Fire((v and "show_range" or "hide_range"))
end)

killware_settings.update_functions["hit_rate"] = createSettingBox("Hit Rate", function(v)
    if tonumber(v) ~= nil then
        killware_settings.hitrate = tonumber(v)
    end
end, killware_settings.hitrate, "number", 0, 75)

MainConnections["uis"] = UIS.InputBegan:Connect(function(input, no)
    if no then
        return
    end
    if input.KeyCode == Enum.KeyCode.RightAlt then
        ui.Enabled = not ui.Enabled
    end
end)

-- Finish

MainConnections["event_listener"] = MainEvent.Event:Connect(functions["event"])
MainConnections["main_loop"] = RunService.RenderStepped:Connect(functions["main"])
MainConnections["character_spawn"] = Player.CharacterAdded:Connect(functions["character_spawn"])

for i, v in pairs(Players:GetPlayers()) do
    MainConnections["Chat"][tostring(v.UserId)] = v.Chatted:Connect(function(msg)
        functions["player_chatted"](v, msg)
    end)
end
Players.PlayerAdded:Connect(function(v)
    MainConnections["Chat"][tostring(v.UserId)] = v.Chatted:Connect(function(msg)
        functions["player_chatted"](v, msg)
    end)
end)

if Player.Character then
    functions["character_spawn"]()
end

--killware
