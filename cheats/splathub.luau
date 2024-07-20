-- source https://github.com/Phoenix11112/Roblox-script-sword-sim/commit/75ab0128a980f048fe3aea22ea0b32d8caecad03
-- updated at february 8, 2023

bc = BrickColor.new("White")
game.StarterGui:SetCore("ChatMakeSystemMessage", {
    Text = "{Loading-SplatHubPrivate Made By [Wain and Phoenix]}";
    Font = Enum.Font.Cartoon;
    Color = bc.Color;
    FontSize = Enum.FontSize.Size96;    
})

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("{Loading-SplatHubPublic Made By [Wain and Phoenix]}", "DarkTheme")

local Tab = Window:NewTab("Main")
local MainSection = Tab:NewSection("Main")
MainSection:NewSlider("Walkspeed", "More WalkSpeed", 250, 16, function(s) -- 250 (MaxValue) | 16 (MinValue)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

MainSection:NewSlider("JumpPower", "Makes u bounce", 200, 50, function(s) -- 200 (MaxValue) | 50 (MinValue)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = s
end)

MainSection:NewButton("E to Fly", "Click E and u can fly anywhere you want", function()-- Bring to you by 7alexv7
    -- Enjoy the script!

    -- Instances:

    local FlyGui = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")
    local TextButton = Instance.new("TextButton")
    local TextLabel = Instance.new("TextLabel")

    --Properties:

    FlyGui.Name = "FlyGui"
    FlyGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    Frame.Parent = FlyGui
    Frame.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    Frame.BorderSizePixel = 0
    Frame.Position = UDim2.new(0.0685602352, 0, 0.168769717, 0)
    Frame.Size = UDim2.new(0.264544547, 0, 0.100000024, 0)

    TextButton.Parent = Frame
    TextButton.BackgroundColor3 = Color3.fromRGB(66, 66, 66)
    TextButton.BorderSizePixel = 0
    TextButton.Position = UDim2.new(0.06324628, 0, 0.400667697, 0)
    TextButton.Size = UDim2.new(0.871157169, 0, 0.495614201, 0)
    TextButton.Font = Enum.Font.ArialBold
    TextButton.Text = "Fly"
    TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextButton.TextScaled = true
    TextButton.TextSize = 14.000
    TextButton.TextStrokeTransparency = 0.000
    TextButton.TextWrapped = true

    TextLabel.Parent = Frame
    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.Size = UDim2.new(0, 86, 0, 24)
    TextLabel.Font = Enum.Font.Oswald
    TextLabel.Text = "Made by 7alexv7"
    TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel.TextScaled = true
    TextLabel.TextSize = 14.000
    TextLabel.TextWrapped = true

    -- Scripts:

    local function NQWSTGE_fake_script() -- Frame.Fly 
        local script = Instance.new('LocalScript', Frame)

        local plr = script.Parent.Parent.Parent.Parent
        repeat wait() until plr and plr.Character and plr.Character:findFirstChild("HumanoidRootPart") and plr.Character:findFirstChild("Humanoid") 
        local mouse = game.Players.LocalPlayer:GetMouse()  
        repeat wait() until mouse

        local torso = plr.Character.HumanoidRootPart 
        local flying = false
        local deb = true 
        local ctrl = {f = 0, b = 0, l = 0, r = 0} 
        local lastctrl = {f = 0, b = 0, l = 0, r = 0} 
        local maxspeed = 1000 
        local speed = 50
        function Fly() 
        local bg = Instance.new("BodyGyro", torso) 
        bg.P = 9e4 
        bg.maxTorque = Vector3.new(9e9, 9e9, 9e9) 
        bg.cframe = torso.CFrame 
        local bv = Instance.new("BodyVelocity", torso) 
        bv.velocity = Vector3.new(0,0.1,0) 
        bv.maxForce = Vector3.new(9e9, 9e9, 9e9) 
        repeat wait() 
        plr.Character.Humanoid.PlatformStand = true 
        if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then 
        speed = speed+.5+(speed/maxspeed) 
        if speed > maxspeed then 
        speed = maxspeed 
        end 
        elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then 
        speed = speed-1 
        if speed < 0 then 
                        speed = 0
                    else
                        speed = 50
        end 
        end 
        if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then 
        bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed 
        lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r} 
        elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then 
        bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed 
        else 
        bv.velocity = Vector3.new(0,0.1,0) 
        end 
        bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0) 
        until not flying 
        ctrl = {f = 0, b = 0, l = 0, r = 0} 
        lastctrl = {f = 0, b = 0, l = 0, r = 0} 

        bg:Destroy() 
        bv:Destroy() 
            plr.Character.Humanoid.PlatformStand = false 
            speed = 50
        end 

        mouse.KeyDown:connect(function(key) 
        if key:lower() == "e" then 
                if flying then flying = false 
                    speed = 50
        else 
        flying = true 
        Fly()

        end 
        elseif key:lower() == "w" then 
        ctrl.f = 1 
        elseif key:lower() == "s" then 
        ctrl.b = -1 
        elseif key:lower() == "a" then 
        ctrl.l = -1 
        elseif key:lower() == "d" then 
        ctrl.r = 1 
        end 
        end) 
        mouse.KeyUp:connect(function(key) 
        if key:lower() == "w" then 
        ctrl.f = 0 
        elseif key:lower() == "s" then 
        ctrl.b = 0 
        elseif key:lower() == "a" then 
        ctrl.l = 0 
        elseif key:lower() == "d" then 
        ctrl.r = 0 
        end 
        end)

        plr.Character.Humanoid.StateChanged:Connect(function(o,n)
            if n == Enum.HumanoidStateType.Running then
                ctrl.f = 1
            else
                ctrl.f = 0
            end

        end)
        script.Parent.TextButton.MouseButton1Click:Connect(function()
            if flying then
                flying = false
                speed = 50
            else
                flying = true
                Fly()
            end
        end)

    end
    coroutine.wrap(NQWSTGE_fake_script)()
    local function RAQA_fake_script() -- Frame.Buttons 
        local script = Instance.new('LocalScript', Frame)

        local Trigger = script.Parent.MiniTrext
        local IsMini = false
        function CreateTween(Instance,Style,Direction,Time,table,RepeatCount,CanRepeat,Delay)
            local ts = game:GetService("TweenService")
            local TweenInfo = TweenInfo.new(Time,Style,Direction,RepeatCount,CanRepeat,Delay)
            local Tween = ts:Create(Instance,TweenInfo,table)
            repeat wait() until Tween ~= nil
            return Tween

        end
        Trigger.MouseButton1Click:Connect(function()
            if IsMini then
                CreateTween(script.Parent,Enum.EasingStyle.Quad,Enum.EasingDirection.Out,0.5,{Size = UDim2.new(0.265, 0,0.1, 0)},0,false,0.1):Play()
                IsMini = false
                Trigger.Text = "-"
            else
                CreateTween(script.Parent,Enum.EasingStyle.Quad,Enum.EasingDirection.Out,0.5,{Size = UDim2.new(0.265, 0,0.042, 0)},0,false,0.1):Play()
                IsMini = true
                Trigger.Text = "+"
            end
        end)
        script.Parent.Delete.MouseButton1Click:Connect(function()
            script.Parent.Parent:Destroy()
        end)
    end
    coroutine.wrap(RAQA_fake_script)()
    local function TKVUMP_fake_script() -- Frame.Drag Gui 
        local script = Instance.new('LocalScript', Frame)

        local UserInputService = game:GetService("UserInputService")

        local gui = script.Parent

        local dragging
        local dragInput
        local dragStart
        local startPos

        local function update(input)
            local delta = input.Position - dragStart
            gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end

        gui.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = gui.Position

                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)

        gui.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                update(input)
            end
        end)
    end
    coroutine.wrap(TKVUMP_fake_script)()
    print("Clicked")
end)

local Tab = Window:NewTab("AutoFarm")
local AutoSection = Tab:NewSection("AutoFarm")
AutoSection:NewLabel("There will be no AutoFarm in Public script join our")
AutoSection:NewLabel("Discord at https://discord.gg/vGPKq26GkG")

local Tab = Window:NewTab("OP")
local OPSection = Tab:NewSection("OP Stuff")
OPSection:NewButton("Hitbox Expander", "Click right CTRL to hide or show script", function()if not game:IsLoaded() then game.Loaded:Wait() end

local lPlayer = game.Players.LocalPlayer
-- thanks 3ds and kiko metatables r hard
if not getgenv().MTAPIMutex then loadstring(game:HttpGet("https://raw.githubusercontent.com/KikoTheDon/MT-Api-v2/main/__source/mt-api%20v2.lua", true))() end

if game.PlaceId == 111311599 then -- Critical Strike
    local anticheat = game:GetService("ReplicatedFirst")["Serverbased AntiCheat"] -- then why put it in a localscript?
    -- I literally copied the rest of this from the "Serverbased Anticheat"
    local sValue = game:GetService("Players").LocalPlayer:WaitForChild("SValue")
    local function constructAnticheatString()
    	return "CS-" .. math.random(11111, 99999) .. "-" .. math.random(1111, 9999) .. "-" .. math.random(111111, 999999) .. math.random(1111111, 9999999) .. (sValue.Value * 6) ^ 2 + 18;
    end
    -- to be fair the game hasn't been updated in over a year
    task.spawn(function()
	    while true do task.wait(2)
	    	game:GetService("ReplicatedStorage").ACDetect:FireServer(sValue.Value, constructAnticheatString());
	    end
    end)
    anticheat.Disabled = true
end

local playerNames = {}
--local npcNames = {} -- I was planning on adding npc support
local teamNames = {}

-- thanks inori and wally
local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/Library.lua'))()
local SaveManager = loadstring(game:HttpGet('https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/addons/SaveManager.lua'))()
SaveManager:SetLibrary(Library)
SaveManager:SetFolder("HitboxExtender")
Library:Notify("hai :3")
local mainWindow = Library:CreateWindow("Personal object of abuse")

local mainTab = mainWindow:AddTab("Main")
local mainGroupbox = mainTab:AddLeftGroupbox("Hitbox Extender")
local ignoresGroupbox = mainTab:AddRightGroupbox("Ignores")
local miscGroupbox = mainTab:AddLeftGroupbox("Misc")

local extenderToggled = mainGroupbox:AddToggle("extenderToggled", {Text = "Toggle"})
local extenderSize = mainGroupbox:AddSlider("extenderSize", {Text = "Size", Min = 2, Max = 100, Default = 10, Rounding = 0})
local extenderTransparency = mainGroupbox:AddSlider("extenderTransparency", {Text = "Transparency", Min = 0, Max = 1, Default = 0.5, Rounding = 2})
-- for some reason the save manager doesn't save inputs, idk how to fix it
local customPartNameInput = mainGroupbox:AddInput("customPartList", {Text = "Custom Part Name", Default = "HeadHB"})
local extenderPartList = mainGroupbox:AddDropdown("extenderPartList", {Text = "Body Parts", AllowNull = true, Multi = true, Values = {"Custom Part", "Head", "HumanoidRootPart", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg"}, Default = "Head"})
local extenderUpdateRate = miscGroupbox:AddSlider("extenderUpdateRate", {Text = "Update Rate", Min = 0, Max = 1000, Default = 0, Rounding = 0, Suffix = "ms"})

local extenderSitCheck = ignoresGroupbox:AddToggle("extenderSitCheck", {Text = "Ignore Sitting Players"})
local ignoreSelectedPlayersToggled = ignoresGroupbox:AddToggle("ignoreSelectedPlayersToggled", {Text = "Ignore Selected Players"})
local ignorePlayerList = ignoresGroupbox:AddDropdown("ignorePlayerList", {Text = "Players", AllowNull = true, Multi = true, Values = playerNames})
--local ignoreSelectedNpcsToggled = ignoresGroupbox:AddToggle("ignoreSelectedNpcsToggled", {Text = "Ignore Selected Npcs"})
--local ignoreNpcList = ignoresGroupbox:AddDropdown("ignoreNpcList", {Text = "Npcs", AllowNull = true, Multi = true, Values = npcNames})
local ignoreSelfTeamToggled = ignoresGroupbox:AddToggle("ignoreSelfTeamToggled", {Text = "Ignore Own Team"})
local ignoreSelectedTeamsToggled = ignoresGroupbox:AddToggle("ignoreSelectedTeamsToggled", {Text = "Ignore Selected Teams"})
local ignoreTeamList = ignoresGroupbox:AddDropdown("ignoreTeamList", {Text = "Teams", AllowNull = true, Multi = true, Values = teamNames})

-- thanks roblox dev forum
local function CheckTableEquality(t1,t2)
    for i,v in next, t1 do if t2[i]~=v then return false end end
    for i,v in next, t2 do if t1[i]~=v then return false end end
    return true
end

-- updates the player list
task.spawn(function()
    while true do task.wait() -- if you cry about while true do loops then kys
        local temp = {}
        for i,v in ipairs(game.Players:GetPlayers()) do
            if v ~= lPlayer then
                temp[i] = v.Name
            end
        end
        if not CheckTableEquality(playerNames, temp) then
            playerNames = temp
            ignorePlayerList.Values = temp
            ignorePlayerList:SetValues()
            ignorePlayerList:Display()
        end
    end
end)

-- updates the team list
task.spawn(function()
    while true do task.wait()
        local temp = {}
        for i,v in pairs(game.Teams:GetTeams()) do
            temp[i] = v.Name
        end
        if not CheckTableEquality(teamNames, temp) then
            teamNames = temp
            ignoreTeamList.Values = temp
            ignoreTeamList:SetValues()
            ignoreTeamList:Display()
        end
    end
end)

--task.spawn(function()
--    while true do task.wait()
--        local temp = {}
--        for i,v in ipairs(npcs) do
--            temp[i] = v.Name
--        end
--        if not CheckTableEquality(npcNames, temp) then
--            ignoreNpcList.Values = temp
--            ignoreNpcList:SetValues()
--            ignoreNpcList:Display()
--        end
--    end
--end)

SaveManager:BuildConfigSection(mainTab)
SaveManager:LoadAutoloadConfig()

-- Returns a table of every possible bodypart in a character, or nil if the character does not exist.
local function getBodyParts(character)
    local humanoid = character:WaitForChild("Humanoid")
    local parts = {
        Head = character:WaitForChild("Head"),
        HumanoidRootPart = character:WaitForChild("HumanoidRootPart"),
        Humanoid = character:WaitForChild("Humanoid")
    }
    if humanoid.RigType == Enum.HumanoidRigType.R6 then
        parts.Torso = {Torso = character:WaitForChild("Torso")}
        parts["Left Arm"] = {LeftArm = character:WaitForChild("Left Arm")}
        parts["Right Arm"] = {RightArm = character:WaitForChild("Right Arm")}
        parts["Left Leg"] = {LeftLeg = character:WaitForChild("Left Leg")}
        parts["Right Leg"] = {RightLeg = character:WaitForChild("Right Leg")}
    elseif humanoid.RigType == Enum.HumanoidRigType.R15 then
        parts.Torso = {
            UpperTorso = character:WaitForChild("UpperTorso"),
            LowerTorso = character:WaitForChild("LowerTorso")
        }
        parts["Left Arm"] = {
            LeftHand = character:WaitForChild("LeftHand"),
            LeftLowerArm = character:WaitForChild("LeftLowerArm"),
            LeftUpperArm = character:WaitForChild("LeftUpperArm")
        }
        parts["Right Arm"] = {
            RightHand = character:WaitForChild("RightHand"),
            RightLowerArm = character:WaitForChild("RightLowerArm"),
            RightUpperArm = character:WaitForChild("RightUpperArm")
        }
        parts["Left Leg"] = {
            LeftFoot = character:WaitForChild("LeftFoot"),
            LeftLowerLeg = character:WaitForChild("LeftLowerLeg"),
            LeftUpperLeg = character:WaitForChild("LeftUpperLeg")
        }
        parts["Right Leg"] = {
            RightFoot = character:WaitForChild("RightFoot"),
            RightLowerLeg = character:WaitForChild("RightLowerLeg"),
            RightUpperLeg = character:WaitForChild("RightUpperLeg")
        }
    end
    return parts
end

-- Main function that allows the character passed to be expanded at will
local function extendCharacter(character)
    local player = game.Players:GetPlayerFromCharacter(character)
    local timer = 0
    local originals = {}
    local collisions = {}
    local CharacterAdded = {}
    local bodyParts = getBodyParts(character)
    --Sets up original sizes, creates collision constraints, and creates hooks to bypass localscript anticheats
    local function setup(i, v)
        if not originals[i] then
            originals[i] = {}
            originals[i].Size = v.Size
            originals[i].Transparency = v.Transparency
            originals[i].CanCollide = v.CanCollide
            originals[i].Massless = v.Massless
            local sizeHook = v:AddGetHook("Size", originals[i].Size)
            local transparencyHook = v:AddGetHook("Transparency", originals[i].Transparency)
            local canCollideHook = v:AddGetHook("CanCollide", originals[i].CanCollide)
            local masslessHook = v:AddGetHook("Massless", originals[i].Massless)
            v:AddSetHook("Size", function(self, value)
                originals[i].Size = value
                sizeHook:Modify("Size", value)
                return value
            end)
            v:AddSetHook("Transparency", function(self, value)
                originals[i].Transparency = value
                transparencyHook:Modify("Transparency", value)
                return value
            end)
            v:AddSetHook("CanCollide", function(self, value)
                originals[i].CanCollide = value
                canCollideHook:Modify("CanCollide", value)
                return value
            end)
            v:AddSetHook("Massless", function(self, value)
                originals[i].Massless = value
                masslessHook:Modify("Massless", value)
                return value
            end)
        end
        if not collisions[i] then
            collisions[i] = {}
            -- thanks to GameGuy#5286 for telling me collision constraints exist
            for o,b in pairs(getBodyParts(lPlayer.Character)) do
                if o ~= "Humanoid" and type(b) ~= "table" then
                    collisions[i][o] = Instance.new("NoCollisionConstraint", v)
                    collisions[i][o].Enabled = false
                    collisions[i][o].Part0 = v
                    collisions[i][o].Part1 = b
                    CharacterAdded[i] = lPlayer.CharacterAdded:Connect(function(char)
                        local temp = char:WaitForChild(o)
                        collisions[i][o].Part1 = temp
                    end)
                elseif type(b) == "table" then
                    for g,z in pairs(b) do
                        if z:IsA("BasePart") then
                            collisions[i][g] = Instance.new("NoCollisionConstraint", v)
                            collisions[i][g].Enabled = false
                            collisions[i][g].Part0 = v
                            collisions[i][g].Part1 = z
                            CharacterAdded[i] = lPlayer.CharacterAdded:Connect(function(char)
                                local temp = char:WaitForChild(g)
                                if temp:IsA("BasePart") then
                                    collisions[i][g].Part1 = temp
                                end
                            end)
                        end
                    end
                end
            end
        end
    end
    do
        local customPart = character:FindFirstChild(customPartNameInput.Value)
        if customPart and customPart:IsA("BasePart") then
            if not originals[customPart.Name] then
                setup(customPart.Name, customPart)
            end
        end
        for i,v in pairs(bodyParts) do
            if i ~= "Humanoid" and type(v) ~= "table" then
                if not originals[i] then
                    setup(i,v)
                end
            elseif type(v) == "table" then
                for o,b in pairs(v) do
                    if not originals[o] then
                        setup(o,b)
                    end
                end
            end
        end
    end
    -- resets the properties of the selected part.
    -- if "all" is passed, will reset every part
    local function reset(part)
        if part == "custompart" or part == "all" then
            local customPart = character:FindFirstChild(customPartNameInput.Value)
            if customPart and customPart:IsA("BasePart") then
                customPart.Size = originals[customPart.Name].Size
                customPart.Transparency = originals[customPart.Name].Transparency
                customPart.CanCollide = originals[customPart.Name].CanCollide
                customPart.Massless = originals[customPart.Name].Massless
            end
        end
        for i,v in pairs(bodyParts) do
            if string.lower(part) == string.lower(i) or part == "all" then
                if i ~= "Humanoid" and type(v) ~= "table" then
                    v.Size = originals[i].Size
                    v.Transparency = originals[i].Transparency
                    v.CanCollide = originals[i].CanCollide
                    v.Massless = originals[i].Massless
                elseif type(v) == "table" then
                    for o,b in pairs(v) do
                        b.Size = originals[o].Size
                        b.Transparency = originals[o].Transparency
                        b.Massless = originals[o].Massless
                        for _,z in pairs(collisions[o]) do
                            if z.Enabled == true and z.Part0 == b then
                                z.Enabled = false
                            end
                        end
                    end
                end
            end
        end
    end
    local function getChecks()
        if bodyParts.Humanoid:GetState() == Enum.HumanoidStateType.Dead then
            return 2
        end
        if extenderSitCheck.Value then
            if bodyParts.Humanoid.Sit then
                return 1
            end
        end
        if ignoreSelfTeamToggled.Value then
            if game.PlaceId == 2039118386 then -- Neighborhood War
                local selfTeam
                local playerTeam
                pcall(function()
                    selfTeam = lPlayer.Character.HumanoidRootPart.BrickColor
                    playerTeam = bodyParts.HumanoidRootPart.BrickColor
                end)
                if selfTeam == playerTeam then
                    return 1
                end
            else
                if lPlayer.Team == player.Team then
                    return 1
                end
            end
        end
        if ignoreSelectedTeamsToggled.Value then
            local teamList = ignoreTeamList:GetActiveValues()
            if table.find(teamList, tostring(player.Team)) then
                return 1
            end
        end
        if ignoreSelectedPlayersToggled.Value then
            local playerList = ignorePlayerList:GetActiveValues()
            if table.find(playerList, tostring(player.Name)) then
                return 1
            end
        end
        return 0
    end
    -- here's the actual expander code
    local Heartbeat
    Heartbeat = game:GetService("RunService").Heartbeat:Connect(function(deltaTime)
        timer += deltaTime
        if timer >= (extenderUpdateRate.Value / 100) then -- divided by 100 because milliseconds
            timer = 0
            local bodyPartList = extenderPartList:GetActiveValues()
            local checks = getChecks()
            if checks == 2 then
                reset("all")
                for _,v in pairs(CharacterAdded) do
                    v:Disconnect()
                end
                Heartbeat:Disconnect()
                return
            elseif checks == 1 then
                reset("all")
                return
            end
            if extenderToggled.Value then
                if table.find(bodyPartList, "Custom Part") then
                    local customPart = character:FindFirstChild(customPartNameInput.Value)
                    if customPart then
                        customPart.Size = Vector3.new(extenderSize.Value, extenderSize.Value, extenderSize.Value)
                        customPart.Transparency = extenderTransparency.Value
                        customPart.CanCollide = false
                        customPart.Massless = true
                    end
                else
                    reset("custompart")
                end
                for i,v in pairs(bodyParts) do
                    if table.find(bodyPartList, i) then
                        if type(v) ~= "table" then
                            if i ~= "HumanoidRootPart" then
                                v.Massless = true
                            end
                            v.Size = Vector3.new(extenderSize.Value, extenderSize.Value, extenderSize.Value)
                            v.Transparency = extenderTransparency.Value
                            v.CanCollide = false
                        else
                            for o,b in pairs(v) do
                                b.Massless = true
                                b.Size = Vector3.new(extenderSize.Value, extenderSize.Value, extenderSize.Value)
                                b.Transparency = extenderTransparency.Value
                                for _,z in pairs(collisions[o]) do
                                    if z.Enabled == false and z.Part0 == b then
                                        z.Enabled = true
                                    end
                                end
                            end
                        end
                    else
                        reset(i)
                    end
                end
            else
                reset("all")
            end
        end
    end)
    local PlayerRemoving
    PlayerRemoving = game.Players.PlayerRemoving:Connect(function(v)
        if v == player then
            Heartbeat:Disconnect()
            PlayerRemoving:Disconnect()
        end
    end)
end
for _,player in ipairs(game.Players:GetPlayers()) do
    if player ~= lPlayer then
        task.spawn(function()
            if player.Character then
                -- why use coroutine.wrap after I've been abusing task.spawn? fuck you that's why
                coroutine.wrap(extendCharacter)(player.Character)
            end
            player.CharacterAdded:Connect(function(v)
                coroutine.wrap(extendCharacter)(v)
            end)
        end)
    end
end
game.Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function(v)
        coroutine.wrap(extendCharacter)(v)
    end)
end)
    print("Clicked")
end)
