-- original
-- source https://www.youtube.com/watch?v=n3ENZtf5X2M
-- alt source https://github.com/1mpactfuls/1mpactfuls/commit/63fe26d54df66c288eaee7b2abce2a47109d904b
-- updated at march 16, 2024

-- updated version
-- source https://pastebin.com/V4yQZLkb
-- updated at february 13, 2024

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/NICKISBAD/Nick-s-Modded-KAVO-Lib/main/Nick'sModdedKavoLib.lua"))()
local Window = Library.CreateLib("Stfom Copper Aka Impactfuls sword", "BloodTheme")
 
local MAINTab = Window:NewTab("Blatant")
local MAINSection = MAINTab:NewSection("Fov")
MAINSection:NewButton("FOV", "ButtonInfo", function()
    local FovNumber = 120 --Enter your FOV number here
local Camera = workspace.CurrentCamera
Camera.FieldOfView = FovNumber
end)
local MAINSection = MAINTab:NewSection("Speed")
MAINSection:NewToggle("Bypassed speed", "ToggleInfo", function(state)
    if state then
        --[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
getgenv().TpWalking = true
getgenv().Speed = 4
 
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local localPlayer = players.LocalPlayer
 
local function onCharacterAdded(character)
    local humanoid = character:WaitForChild("Humanoid")
    while getgenv().TpWalking and humanoid and humanoid.Parent do
        local delta = runService.Heartbeat:Wait()
        if humanoid.MoveDirection.Magnitude > 0 then
            character:TranslateBy(humanoid.MoveDirection * tonumber(getgenv().Speed) * delta * 10)
        else
            character:TranslateBy(humanoid.MoveDirection * delta * 10)
        end
    end
end
 
localPlayer.CharacterAdded:Connect(onCharacterAdded)
 
-- If the player already has a character when the script runs, apply the functionality to it.
if localPlayer.Character then
    onCharacterAdded(localPlayer.Character)
end
 
    else
        getgenv().TpWalking = false
    end
end)
local MAINSection = MAINTab:NewSection("Hitbox")
MAINSection:NewButton("hitbox", "ButtonInfo", function()
    --[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
-- leave a like pls
 
 
_G.HeadSize = 20
_G.Disabled = true
 
game:GetService('RunService').RenderStepped:connect(function()
if _G.Disabled then
for i,v in next, game:GetService('Players'):GetPlayers() do
if v.Name ~= game:GetService('Players').LocalPlayer.Name then
pcall(function()
v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)
v.Character.HumanoidRootPart.Transparency = 0.7
v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really blue")
v.Character.HumanoidRootPart.Material = "Neon"
v.Character.HumanoidRootPart.CanCollide = false
end)
end
end
end
end)
end)
local MAINSection = MAINTab:NewSection("Reach + auto clicker")
MAINSection:NewButton("reach", "ButtonInfo", function()
    --Subscribe To Alex Scripter--
--You Cant Turn It Off, only if u rejoin --
 
--// Setting \--
local range = 1000
 
--// Variable \--
local player = game:GetService("Players").LocalPlayer
 
--// Script \--
game:GetService("RunService").RenderStepped:Connect(function()
    local p = game.Players:GetPlayers()
    for i = 2, #p do local v = p[i].Character
        if v and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") and player:DistanceFromCharacter(v.HumanoidRootPart.Position) <= range then
            local tool = player.Character and player.Character:FindFirstChildOfClass("Tool")
            if tool and tool:FindFirstChild("Handle") then
                tool:Activate()
                for i,v in next, v:GetChildren() do
                    if v:IsA("BasePart") then
                        firetouchinterest(tool.Handle,v,0)
                        firetouchinterest(tool.Handle,v,1)
                    end
                end
            end
        end
    end
end)
end)
local MAINSection = MAINTab:NewSection("Spammer")
MAINSection:NewButton("Spammer", "ButtonInfo", function()
    local Players = game:GetService("Players")
local chatrem = game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest
 
local phrases = {" haha, use stfom copper so u dont cope!!", " just died by impactfuls i say hi!", "ha! L bozo impactfuls packed u by his script", " Yapper alert stfom copper impactfuls sword on top!"}  -- Add your phrases here
 
local function getRandomPlayerName()
    local playersList = Players:GetPlayers()
    if #playersList > 0 then
        return playersList[math.random(#playersList)].Name
    else
        return nil
    end
end
 
local function getRandomPhrase()
    return phrases[math.random(#phrases)]
end
 
while task.wait(3) do  -- 3-second delay
    local randomPlayerName = getRandomPlayerName()
    if randomPlayerName then
        local message = randomPlayerName .. getRandomPhrase()  -- Combine name with a random phrase
        chatrem:FireServer(message, "All")
    end
end
 
end)
 
local MAINSection = MAINTab:NewSection("infjump")
MAINSection:NewToggle("infinite jumps", "ToggleInfo", function(state)
    if state then
        --[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
local InfiniteJumpEnabled = true
game:GetService("UserInputService").JumpRequest:connect(function()
	if InfiniteJumpEnabled then
		game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
	end
end)
    else
        -- WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
 
if getgenv().InfiniteJumpEnabled == nil then
    getgenv().InfiniteJumpEnabled = false
end
 
if not getgenv().InfiniteJumpEnabled then
    getgenv().InfiniteJumpConnection = game:GetService("UserInputService").JumpRequest:connect(function()
        game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
    end)
    getgenv().InfiniteJumpEnabled = true
else
    if getgenv().InfiniteJumpConnection then
        getgenv().InfiniteJumpConnection:Disconnect()
    end
    getgenv().InfiniteJumpEnabled = false
end
    end
end)
 
local MAINSection = MAINTab:NewSection("Spin")
MAINSection:NewToggle("Spin", "ToggleInfo", function(state)
    if state then
        -- Made by JackMcJagger15
 
power = 1500 -- Increased power for more forceful spin
 
game:GetService('RunService').Stepped:connect(function()
    game.Players.LocalPlayer.Character.Head.CanCollide = false
    game.Players.LocalPlayer.Character.UpperTorso.CanCollide = false
    game.Players.LocalPlayer.Character.LowerTorso.CanCollide = false
    game.Players.LocalPlayer.Character.HumanoidRootPart.CanCollide = false
end)
wait(.1)
local bambam = Instance.new("BodyThrust")
bambam.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
bambam.Force = Vector3.new(power, 0, power)
bambam.Location = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
 
    else
        -- Made by JackMcJagger15
 
if getgenv().isSpinning == nil then
    getgenv().isSpinning = false
end
 
power = 1000 -- Power for spin
 
if not getgenv().isSpinning then
    getgenv().spinConnection = game:GetService('RunService').Stepped:connect(function()
        game.Players.LocalPlayer.Character.Head.CanCollide = false
        game.Players.LocalPlayer.Character.UpperTorso.CanCollide = false
        game.Players.LocalPlayer.Character.LowerTorso.CanCollide = false
        game.Players.LocalPlayer.Character.HumanoidRootPart.CanCollide = false
    end)
    wait(.1)
    getgenv().bambam = Instance.new("BodyThrust")
    getgenv().bambam.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
    getgenv().bambam.Force = Vector3.new(power, 0, power)
    getgenv().bambam.Location = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
    getgenv().isSpinning = true
else
    if getgenv().spinConnection then
        getgenv().spinConnection:Disconnect()
    end
    if getgenv().bambam then
        getgenv().bambam:Destroy()
    end
    getgenv().isSpinning = false
end
 
    end
end)
 
local MAINSection = MAINTab:NewSection("kill aura")
MAINSection:NewButton("kill aura", "ButtonInfo", function()
    --[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
range = math.random(6, 8) -- <9 for legitimate
local player = game:GetService("Players").LocalPlayer
game:GetService("RunService").RenderStepped:Connect(function()
    local p = game.Players:GetPlayers()
    for i = 2, #p do local v = p[i].Character
        if v and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") and player:DistanceFromCharacter(v.HumanoidRootPart.Position) <= range then
            local tool = player.Character and player.Character:FindFirstChildOfClass("Tool")
            if tool and tool:FindFirstChild("Handle") then
                tool:Activate()
                for i,v in next, v:GetChildren() do
                    if v:IsA("BasePart") then
                        firetouchinterest(tool.Handle,v,0)
                        firetouchinterest(tool.Handle,v,1)
                    end
                end
            end
        end
    end
end)
end)
local LegitTab = Window:NewTab("Legit")
local LegitSection = LegitTab:NewSection("tutorial: Just change it to 5 no one will notice")
LegitSection:NewButton("Legit reach visualizer", "ButtonInfo", function()
    -- https://youtube.com/c/ImpulseExploits
 
 
local active = true
local trueActive = true
local reachType = "Sphere"
local dmgEnabled = true
local visualizerEnabled = true
 
local visualizer = Instance.new("Part")
visualizer.BrickColor = BrickColor.Blue()
visualizer.Transparency = 0.6
visualizer.Anchored = true
visualizer.CanCollide = false
visualizer.Size = Vector3.new(0.5,0.5,0.5)
visualizer.BottomSurface = Enum.SurfaceType.Smooth
visualizer.TopSurface = Enum.SurfaceType.Smooth
 
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local TextBox = Instance.new("TextBox")
local TextLabel_2 = Instance.new("TextLabel")
local TextLabel_3 = Instance.new("TextLabel")
local TextLabel_4 = Instance.new("TextLabel")
local TextButton = Instance.new("TextButton")
local Frame_2 = Instance.new("Frame")
local Frame_3 = Instance.new("Frame")
local Frame_4 = Instance.new("Frame")
local Frame_5 = Instance.new("Frame")
local TextButton_2 = Instance.new("TextButton")
 
--Properties:
 
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 999999999
ScreenGui.ResetOnSpawn = false
 
Frame.Parent = ScreenGui
Frame.AnchorPoint = Vector2.new(0, 0.5)
Frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Frame.BackgroundTransparency = 0.300
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 4
Frame.Position = UDim2.new(0, 0, 0.600000024, 0)
Frame.Size = UDim2.new(0.150000006, 0, 0.300000012, 0)
 
TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.Size = UDim2.new(0.600000024, 0, 0.200000003, 0)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "Reach:"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true
 
TextBox.Parent = Frame
TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextBox.BackgroundTransparency = 1.000
TextBox.Position = UDim2.new(0.600000024, 0, 0, 0)
TextBox.Size = UDim2.new(0.400000006, 0, 0.200000003, 0)
TextBox.Font = Enum.Font.SourceSans
TextBox.Text = "3.5"
TextBox.TextColor3 = Color3.fromRGB(255, 76, 76)
TextBox.TextScaled = true
TextBox.TextSize = 14.000
TextBox.TextWrapped = true
 
TextLabel_2.Parent = Frame
TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.BackgroundTransparency = 1.000
TextLabel_2.Position = UDim2.new(0, 0, 0.200000003, 0)
TextLabel_2.Size = UDim2.new(0.600000024, 0, 0.200000003, 0)
TextLabel_2.Font = Enum.Font.SourceSans
TextLabel_2.Text = "Shape:"
TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.TextScaled = true
TextLabel_2.TextSize = 14.000
TextLabel_2.TextWrapped = true
 
TextLabel_3.Parent = Frame
TextLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_3.BackgroundTransparency = 1.000
TextLabel_3.Position = UDim2.new(0, 0, 0.400000006, 0)
TextLabel_3.Size = UDim2.new(0.600000024, 0, 0.200000003, 0)
TextLabel_3.Font = Enum.Font.SourceSans
TextLabel_3.Text = "Damage:"
TextLabel_3.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_3.TextScaled = true
TextLabel_3.TextSize = 14.000
TextLabel_3.TextWrapped = true
 
TextLabel_4.Parent = Frame
TextLabel_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_4.BackgroundTransparency = 1.000
TextLabel_4.Position = UDim2.new(0, 0, 0.600000024, 0)
TextLabel_4.Size = UDim2.new(0.600000024, 0, 0.200000003, 0)
TextLabel_4.Font = Enum.Font.SourceSans
TextLabel_4.Text = "Visualizer:"
TextLabel_4.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_4.TextScaled = true
TextLabel_4.TextSize = 14.000
TextLabel_4.TextWrapped = true
 
TextButton.Parent = Frame
TextButton.AnchorPoint = Vector2.new(0, 1)
TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton.BackgroundTransparency = 1.000
TextButton.Position = UDim2.new(0, 0, 1, 0)
TextButton.Size = UDim2.new(1, 0, 0.150000006, 0)
TextButton.Font = Enum.Font.SourceSansBold
TextButton.Text = "Kill Script"
TextButton.TextColor3 = Color3.fromRGB(222, 0, 0)
TextButton.TextScaled = true
TextButton.TextSize = 14.000
TextButton.TextWrapped = true
 
Frame_2.Parent = Frame
Frame_2.Active = true
Frame_2.AnchorPoint = Vector2.new(0, 0.5)
Frame_2.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
Frame_2.BorderSizePixel = 0
Frame_2.Position = UDim2.new(0.725000024, 0, 0.699999988, 0)
Frame_2.Size = UDim2.new(0, 25, 0, 25)
Frame_2.ZIndex = 5
 
Frame_3.Parent = Frame_2
Frame_3.AnchorPoint = Vector2.new(0.5, 0.5)
Frame_3.BackgroundColor3 = Color3.fromRGB(255, 76, 76)
Frame_3.BorderSizePixel = 0
Frame_3.LayoutOrder = 1
Frame_3.Position = UDim2.new(0.5, 0, 0.5, 0)
 
Frame_4.Parent = Frame
Frame_4.Active = true
Frame_4.AnchorPoint = Vector2.new(0, 0.5)
Frame_4.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
Frame_4.BorderSizePixel = 0
Frame_4.Position = UDim2.new(0.725000024, 0, 0.5, 0)
Frame_4.Size = UDim2.new(0, 25, 0, 25)
Frame_4.ZIndex = 5
 
Frame_5.Parent = Frame_4
Frame_5.AnchorPoint = Vector2.new(0.5, 0.5)
Frame_5.BackgroundColor3 = Color3.fromRGB(255, 76, 76)
Frame_5.BorderSizePixel = 0
Frame_5.LayoutOrder = 1
Frame_5.Position = UDim2.new(0.5, 0, 0.5, 0)
Frame_5.Size = UDim2.new(1, 0, 1, 0)
 
TextButton_2.Parent = Frame
TextButton_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton_2.BackgroundTransparency = 1.000
TextButton_2.Position = UDim2.new(0.600000024, 0, 0.200000003, 0)
TextButton_2.Size = UDim2.new(0.400000006, 0, 0.200000003, 0)
TextButton_2.Font = Enum.Font.SourceSans
TextButton_2.Text = "Sphere"
TextButton_2.TextColor3 = Color3.fromRGB(255, 76, 76)
TextButton_2.TextScaled = true
TextButton_2.TextSize = 14.000
TextButton_2.TextWrapped = true
 
repeat wait() until game.Players.LocalPlayer
ScreenGui.Parent = game:GetService("CoreGui")
 
 
 
Frame_4.InputBegan:connect(function(inp)
	if inp.UserInputType == Enum.UserInputType.MouseButton1 then
		dmgEnabled = not dmgEnabled
		local goal = {Size = UDim2.new(0,0,0,0)}
		if dmgEnabled then
			goal = {Size = UDim2.new(1,0,1,0)}
		end
		game:GetService("TweenService"):Create(Frame_5,TweenInfo.new(0.12,Enum.EasingStyle.Quad),goal):Play()
	end
end)
Frame_2.InputBegan:connect(function(inp)
	if inp.UserInputType == Enum.UserInputType.MouseButton1 then
		visualizerEnabled = not visualizerEnabled
		local goal = {Size = UDim2.new(0,0,0,0)}
		if visualizerEnabled then
			goal = {Size = UDim2.new(1,0,1,0)}
		end
		game:GetService("TweenService"):Create(Frame_3,TweenInfo.new(0.12,Enum.EasingStyle.Linear),goal):Play()
	end
end)
TextButton_2.MouseButton1Click:connect(function()
	if reachType == "Sphere" then
		reachType = "Line"
	else
		reachType = "Sphere"
	end
	TextButton_2.Text = reachType
end)
TextButton.MouseButton1Click:connect(function()
	trueActive = false
	ScreenGui:Destroy()
end)
game:GetService("UserInputService").InputBegan:connect(function(inp,gpe)
	if gpe then return end
	if inp.KeyCode == Enum.KeyCode.H then
		ScreenGui.Enabled = not ScreenGui.Enabled
	end
end)
 
local plr = game.Players.LocalPlayer
 
local function onHit(hit,handle)
    local victim = hit.Parent:FindFirstChildOfClass("Humanoid")
	    if victim and victim.Parent.Name ~= game.Players.LocalPlayer.Name then
		if dmgEnabled then
	        for _,v in pairs(hit.Parent:GetChildren()) do
	            if v:IsA("Part") then
	                firetouchinterest(v,handle,0)
	                firetouchinterest(v,handle,1)
	            end
			end
		else
			firetouchinterest(hit,handle,0)
			firetouchinterest(hit,handle,1)
		end
    end
end
 
local function getWhiteList()
    local wl = {}
    for _,v in pairs(game.Players:GetPlayers()) do
        if v ~= plr then
            local char = v.Character
            if char then
                for _,q in pairs(char:GetChildren()) do
                    if q:IsA("Part") then
                        table.insert(wl,q)
                    end
                end
            end
        end
    end
    return wl
end
 
game:GetService("RunService").RenderStepped:connect(function()
    if not active or not trueActive then return end
	local s = plr.Character and plr.Character:FindFirstChildOfClass("Tool")
	if not s then visualizer.Parent = nil end
    if s then
        local handle = s:FindFirstChild("Handle") or s:FindFirstChildOfClass("Part")
		if handle then
			if visualizerEnabled then
				visualizer.Parent = workspace
			else
				visualizer.Parent = nil
			end
			local reach = tonumber(TextBox.Text)
			if reach then
				if reachType == "Sphere" then
					visualizer.Shape = Enum.PartType.Ball
					visualizer.Size = Vector3.new(reach,reach,reach)
					visualizer.CFrame = handle.CFrame
		            for _,v in pairs(game.Players:GetPlayers()) do
		                local hrp = v.Character and v.Character:FindFirstChild("HumanoidRootPart")
		                if hrp and handle then
		                    local mag = (hrp.Position-handle.Position).magnitude
		                    if mag <= reach then
		                        onHit(hrp,handle)
		                    end
		                end
					end
				elseif reachType == "Line" then
					local origin = (handle.CFrame*CFrame.new(0,0,-2)).p
		    		local ray = Ray.new(origin,handle.CFrame.lookVector*-reach)
					local p,pos = workspace:FindPartOnRayWithWhitelist(ray,getWhiteList())
					visualizer.Shape = Enum.PartType.Block
					visualizer.Size = Vector3.new(1,0.8,reach)
					visualizer.CFrame = handle.CFrame*CFrame.new(0,0,(reach/2)+2)
		    		if p then
		    		    onHit(p,handle)
		    		else
		    		    for _,v in pairs(handle:GetTouchingParts()) do
		    		        onHit(v,handle)
		    		    end
		    		end
				end
			end
        end
    end
end)
end)
 
local LegitSection = LegitTab:NewSection("tutorial: Just change it to 5 no one will notice")
LegitSection:NewButton("Legit reach", "ButtonInfo", function()
    -- https://youtube.com/c/ImpulseExploits
 
 
local active = true
local trueActive = true
local reachType = "Sphere"
local dmgEnabled = true
local visualizerEnabled = false
 
local visualizer = Instance.new("Part")
visualizer.BrickColor = BrickColor.Blue()
visualizer.Transparency = 0.6
visualizer.Anchored = true
visualizer.CanCollide = false
visualizer.Size = Vector3.new(0.5,0.5,0.5)
visualizer.BottomSurface = Enum.SurfaceType.Smooth
visualizer.TopSurface = Enum.SurfaceType.Smooth
 
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local TextBox = Instance.new("TextBox")
local TextLabel_2 = Instance.new("TextLabel")
local TextLabel_3 = Instance.new("TextLabel")
local TextLabel_4 = Instance.new("TextLabel")
local TextButton = Instance.new("TextButton")
local Frame_2 = Instance.new("Frame")
local Frame_3 = Instance.new("Frame")
local Frame_4 = Instance.new("Frame")
local Frame_5 = Instance.new("Frame")
local TextButton_2 = Instance.new("TextButton")
 
--Properties:
 
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 999999999
ScreenGui.ResetOnSpawn = false
 
Frame.Parent = ScreenGui
Frame.AnchorPoint = Vector2.new(0, 0.5)
Frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Frame.BackgroundTransparency = 0.300
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 4
Frame.Position = UDim2.new(0, 0, 0.600000024, 0)
Frame.Size = UDim2.new(0.150000006, 0, 0.300000012, 0)
 
TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.Size = UDim2.new(0.600000024, 0, 0.200000003, 0)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "Reach:"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true
 
TextBox.Parent = Frame
TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextBox.BackgroundTransparency = 1.000
TextBox.Position = UDim2.new(0.600000024, 0, 0, 0)
TextBox.Size = UDim2.new(0.400000006, 0, 0.200000003, 0)
TextBox.Font = Enum.Font.SourceSans
TextBox.Text = "3.5"
TextBox.TextColor3 = Color3.fromRGB(255, 76, 76)
TextBox.TextScaled = true
TextBox.TextSize = 14.000
TextBox.TextWrapped = true
 
TextLabel_2.Parent = Frame
TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.BackgroundTransparency = 1.000
TextLabel_2.Position = UDim2.new(0, 0, 0.200000003, 0)
TextLabel_2.Size = UDim2.new(0.600000024, 0, 0.200000003, 0)
TextLabel_2.Font = Enum.Font.SourceSans
TextLabel_2.Text = "Shape:"
TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.TextScaled = true
TextLabel_2.TextSize = 14.000
TextLabel_2.TextWrapped = true
 
TextLabel_3.Parent = Frame
TextLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_3.BackgroundTransparency = 1.000
TextLabel_3.Position = UDim2.new(0, 0, 0.400000006, 0)
TextLabel_3.Size = UDim2.new(0.600000024, 0, 0.200000003, 0)
TextLabel_3.Font = Enum.Font.SourceSans
TextLabel_3.Text = "Damage:"
TextLabel_3.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_3.TextScaled = true
TextLabel_3.TextSize = 14.000
TextLabel_3.TextWrapped = true
 
TextLabel_4.Parent = Frame
TextLabel_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_4.BackgroundTransparency = 1.000
TextLabel_4.Position = UDim2.new(0, 0, 0.600000024, 0)
TextLabel_4.Size = UDim2.new(0.600000024, 0, 0.200000003, 0)
TextLabel_4.Font = Enum.Font.SourceSans
TextLabel_4.Text = "Visualizer:"
TextLabel_4.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_4.TextScaled = true
TextLabel_4.TextSize = 14.000
TextLabel_4.TextWrapped = true
 
TextButton.Parent = Frame
TextButton.AnchorPoint = Vector2.new(0, 1)
TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton.BackgroundTransparency = 1.000
TextButton.Position = UDim2.new(0, 0, 1, 0)
TextButton.Size = UDim2.new(1, 0, 0.150000006, 0)
TextButton.Font = Enum.Font.SourceSansBold
TextButton.Text = "Kill Script"
TextButton.TextColor3 = Color3.fromRGB(222, 0, 0)
TextButton.TextScaled = true
TextButton.TextSize = 14.000
TextButton.TextWrapped = true
 
Frame_2.Parent = Frame
Frame_2.Active = true
Frame_2.AnchorPoint = Vector2.new(0, 0.5)
Frame_2.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
Frame_2.BorderSizePixel = 0
Frame_2.Position = UDim2.new(0.725000024, 0, 0.699999988, 0)
Frame_2.Size = UDim2.new(0, 25, 0, 25)
Frame_2.ZIndex = 5
 
Frame_3.Parent = Frame_2
Frame_3.AnchorPoint = Vector2.new(0.5, 0.5)
Frame_3.BackgroundColor3 = Color3.fromRGB(255, 76, 76)
Frame_3.BorderSizePixel = 0
Frame_3.LayoutOrder = 1
Frame_3.Position = UDim2.new(0.5, 0, 0.5, 0)
 
Frame_4.Parent = Frame
Frame_4.Active = true
Frame_4.AnchorPoint = Vector2.new(0, 0.5)
Frame_4.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
Frame_4.BorderSizePixel = 0
Frame_4.Position = UDim2.new(0.725000024, 0, 0.5, 0)
Frame_4.Size = UDim2.new(0, 25, 0, 25)
Frame_4.ZIndex = 5
 
Frame_5.Parent = Frame_4
Frame_5.AnchorPoint = Vector2.new(0.5, 0.5)
Frame_5.BackgroundColor3 = Color3.fromRGB(255, 76, 76)
Frame_5.BorderSizePixel = 0
Frame_5.LayoutOrder = 1
Frame_5.Position = UDim2.new(0.5, 0, 0.5, 0)
Frame_5.Size = UDim2.new(1, 0, 1, 0)
 
TextButton_2.Parent = Frame
TextButton_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton_2.BackgroundTransparency = 1.000
TextButton_2.Position = UDim2.new(0.600000024, 0, 0.200000003, 0)
TextButton_2.Size = UDim2.new(0.400000006, 0, 0.200000003, 0)
TextButton_2.Font = Enum.Font.SourceSans
TextButton_2.Text = "Sphere"
TextButton_2.TextColor3 = Color3.fromRGB(255, 76, 76)
TextButton_2.TextScaled = true
TextButton_2.TextSize = 14.000
TextButton_2.TextWrapped = true
 
repeat wait() until game.Players.LocalPlayer
ScreenGui.Parent = game:GetService("CoreGui")
 
 
 
Frame_4.InputBegan:connect(function(inp)
	if inp.UserInputType == Enum.UserInputType.MouseButton1 then
		dmgEnabled = not dmgEnabled
		local goal = {Size = UDim2.new(0,0,0,0)}
		if dmgEnabled then
			goal = {Size = UDim2.new(1,0,1,0)}
		end
		game:GetService("TweenService"):Create(Frame_5,TweenInfo.new(0.12,Enum.EasingStyle.Quad),goal):Play()
	end
end)
Frame_2.InputBegan:connect(function(inp)
	if inp.UserInputType == Enum.UserInputType.MouseButton1 then
		visualizerEnabled = not visualizerEnabled
		local goal = {Size = UDim2.new(0,0,0,0)}
		if visualizerEnabled then
			goal = {Size = UDim2.new(1,0,1,0)}
		end
		game:GetService("TweenService"):Create(Frame_3,TweenInfo.new(0.12,Enum.EasingStyle.Linear),goal):Play()
	end
end)
TextButton_2.MouseButton1Click:connect(function()
	if reachType == "Sphere" then
		reachType = "Line"
	else
		reachType = "Sphere"
	end
	TextButton_2.Text = reachType
end)
TextButton.MouseButton1Click:connect(function()
	trueActive = false
	ScreenGui:Destroy()
end)
game:GetService("UserInputService").InputBegan:connect(function(inp,gpe)
	if gpe then return end
	if inp.KeyCode == Enum.KeyCode.H then
		ScreenGui.Enabled = not ScreenGui.Enabled
	end
end)
 
local plr = game.Players.LocalPlayer
 
local function onHit(hit,handle)
    local victim = hit.Parent:FindFirstChildOfClass("Humanoid")
	    if victim and victim.Parent.Name ~= game.Players.LocalPlayer.Name then
		if dmgEnabled then
	        for _,v in pairs(hit.Parent:GetChildren()) do
	            if v:IsA("Part") then
	                firetouchinterest(v,handle,0)
	                firetouchinterest(v,handle,1)
	            end
			end
		else
			firetouchinterest(hit,handle,0)
			firetouchinterest(hit,handle,1)
		end
    end
end
 
local function getWhiteList()
    local wl = {}
    for _,v in pairs(game.Players:GetPlayers()) do
        if v ~= plr then
            local char = v.Character
            if char then
                for _,q in pairs(char:GetChildren()) do
                    if q:IsA("Part") then
                        table.insert(wl,q)
                    end
                end
            end
        end
    end
    return wl
end
 
game:GetService("RunService").RenderStepped:connect(function()
    if not active or not trueActive then return end
	local s = plr.Character and plr.Character:FindFirstChildOfClass("Tool")
	if not s then visualizer.Parent = nil end
    if s then
        local handle = s:FindFirstChild("Handle") or s:FindFirstChildOfClass("Part")
		if handle then
			if visualizerEnabled then
				visualizer.Parent = workspace
			else
				visualizer.Parent = nil
			end
			local reach = tonumber(TextBox.Text)
			if reach then
				if reachType == "Sphere" then
					visualizer.Shape = Enum.PartType.Ball
					visualizer.Size = Vector3.new(reach,reach,reach)
					visualizer.CFrame = handle.CFrame
		            for _,v in pairs(game.Players:GetPlayers()) do
		                local hrp = v.Character and v.Character:FindFirstChild("HumanoidRootPart")
		                if hrp and handle then
		                    local mag = (hrp.Position-handle.Position).magnitude
		                    if mag <= reach then
		                        onHit(hrp,handle)
		                    end
		                end
					end
				elseif reachType == "Line" then
					local origin = (handle.CFrame*CFrame.new(0,0,-2)).p
		    		local ray = Ray.new(origin,handle.CFrame.lookVector*-reach)
					local p,pos = workspace:FindPartOnRayWithWhitelist(ray,getWhiteList())
					visualizer.Shape = Enum.PartType.Block
					visualizer.Size = Vector3.new(1,0.8,reach)
					visualizer.CFrame = handle.CFrame*CFrame.new(0,0,(reach/2)+2)
		    		if p then
		    		    onHit(p,handle)
		    		else
		    		    for _,v in pairs(handle:GetTouchingParts()) do
		    		        onHit(v,handle)
		    		    end
		    		end
				end
			end
        end
    end
end)
end)
 
local gui = Instance.new("ScreenGui")
gui.Name = "patrickGui"
gui.Parent = game.CoreGui
 
--screengui = gui
 
 
 
	local TextButton = Instance.new("TextButton")
-- Text
TextButton.Text = "Toggle Stfom copper!"
TextButton.TextSize = 24
-- Color
TextButton.TextColor3 = Color3.new(1, 1, 1)
TextButton.BackgroundColor3 = Color3.new(0, 0, 0)
TextButton.BorderColor3 = Color3.new(1, 1, 1)
-- thickness
TextButton.BorderSizePixel = 4
-- Text Code
TextButton.Font = Enum.Font.Code
-- Size
TextButton.Size = UDim2.new(0.2, 0, 0.1, 0)
-- Posisition
TextButton.Position = UDim2.new(0, 0, 0.4, 0)
-- Function
TextButton.MouseButton1Click:Connect (function()
Library:ToggleUI()
end)
TextButton.Parent = gui
TextButton.Draggable = true
 
	local cornerUI = Instance.new("UICorner")
cornerUI.CornerRadius = UDim.new(0, 5)
cornerUI.Parent = TextButton
 
	local uiStroke = Instance.new("UIStroke")
    uiStroke.Color = Color3.new(0, 0, 0)
    uiStroke.Thickness = 2
    uiStroke.Parent = TextButton 
 
    local SniperTab = Window:NewTab("Snipe Time!")
    SniperSection = SniperTab:NewSection("Teleport to a player!")
    SniperSection:NewButton("Teleport", "ButtonInfo", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/Infinity2346/Tect-Menu/main/Teleport%20Gui.lua'))()
end)
 
local SniperSection = SniperTab:NewSection("Server hopper")
    SniperSection:NewButton("teleports u to a different server", "ButtonInfo", function()
    local module = loadstring(game:HttpGet"https://raw.githubusercontent.com/LeoKholYt/roblox/main/lk_serverhop.lua")()
 
module:Teleport(game.PlaceId)
end)
local InstaTab = Window:NewTab("free insta tp!")
InstaSection = InstaTab:NewSection("go to 500k,5m,50m,500m world and click add")
InstaSection = InstaTab:NewSection("this is teleport script so u will teleport there")
InstaSection = InstaTab:NewSection("now new thing will pop up!!")
 InstaSection = InstaTab:NewSection("click and you will ne teleported!")
InstaSection = InstaTab:NewSection("click in where insta tp players spawn")
InstaSection = InstaTab:NewSection("teleport scriot but made as this enjoy! ")
 InstaSection:NewButton("Free insta!", "ButtonInfo", function()
    loadstring(game:HttpGet(('https://raw.githubusercontent.com/0Ben1/fe/main/Tp%20Place%20GUI'),true))()
end)
 
local GrindTab = Window:NewTab("Grinding")
local GrindSection = GrindTab:NewSection("Anti afk")
GrindSection:NewButton("anti afk!", "ButtonInfo", function()
      loadstring(game:GetObjects("rbxassetid://15050819751")[1].Source)()
end)
 
local GrindSection = GrindTab:NewSection("Additional reach")
GrindSection:NewButton("brew softworks", "ButtonInfo", function()
      --subscribe and like to Prox1yz
--Updated version not patched!
loadstring(game:HttpGet("https://raw.githubusercontent.com/Brew-Softworks/StealTime/main/ST.lua"))()
end)
 
local GrindSection = GrindTab:NewSection("infinite yield")
GrindSection:NewButton("infinite yield", "ButtonInfo", function()
      loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)
 
local GrindSection = GrindTab:NewSection("Lag switching")
GrindSection:NewButton("lag switch", "ButtonInfo", function()
      --[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
loadstring(game:HttpGet("https://paste.gg/p/anonymous/d3492bd620bd4c46b54680ac80b0fa0d/files/161ddd9c992c4ceba3c298458d45188a/raw", true))()
end)
 
local GrindSection = GrindTab:NewSection("Keyboard 1")
GrindSection:NewButton("Keyboard 1", "ButtonInfo", function()
      --[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
-- Keyboard script By Red_BloxZ
-- You screen will freeze for a few seconds when execute because it loading
 
loadstring(game:HttpGet("https://gist.githubusercontent.com/RedZenXYZ/4d80bfd70ee27000660e4bfa7509c667/raw/da903c570249ab3c0c1a74f3467260972c3d87e6/KeyBoard%2520From%2520Ohio%2520Fr%2520Fr"))()
end)
 
local GrindSection = GrindTab:NewSection("Keyboard 2")
GrindSection:NewButton("keyboard 2", "ButtonInfo", function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt", true))()
end)
 
local OthersTab = Window:NewTab("Other Scripts Made by me")
local OthersSection = OthersTab:NewSection("Aim script for gun games")
OthersSection:NewButton("Impactfuls aim", "ButtonInfo", function()
      local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/NICKISBAD/Nick-s-Modded-KAVO-Lib/main/Nick'sModdedKavoLib.lua"))()
local Window = Library.CreateLib("Impactfuls aim", "BloodTheme")
 
local MAINTab = Window:NewTab("Main")
local MAINSection = MAINTab:NewSection("Fov")
MAINSection:NewButton("FOV", "ButtonInfo", function()
    local FovNumber = 120 --Enter your FOV number here
local Camera = workspace.CurrentCamera
Camera.FieldOfView = FovNumber
end)
 
local MAINSection = MAINTab:NewSection("Aimbot")
MAINSection:NewButton("Aim", "ButtonInfo", function()
    -- Gui to Lua
-- Version: 3.2
 
-- Instances:
 
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Frame_2 = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local TextButton = Instance.new("TextButton")
local TextButton_2 = Instance.new("TextButton")
local TextLabel_2 = Instance.new("TextLabel")
 
--Properties:
 
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
 
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
Frame.BorderColor3 = Color3.fromRGB(16, 16, 16)
Frame.Position = UDim2.new(0.326547235, 0, 0.442340851, 0)
Frame.Size = UDim2.new(0.346905529, 0, 0.194492236, 0)
 
Frame_2.Parent = Frame
Frame_2.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
Frame_2.BorderColor3 = Color3.fromRGB(16, 16, 16)
Frame_2.Size = UDim2.new(1, 0, 0.26777932, 0)
 
TextLabel.Parent = Frame_2
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.Size = UDim2.new(1.00234735, 0, 1.08253634, 0)
TextLabel.Font = Enum.Font.SourceSansSemibold
TextLabel.Text = "Arceus | Aimbot"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 16.000
 
TextButton.Parent = Frame_2
TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton.BackgroundTransparency = 1.000
TextButton.Position = UDim2.new(0.92957741, 0, 0, 0)
TextButton.Size = UDim2.new(0.0697798356, 0, 0.991438508, 0)
TextButton.Font = Enum.Font.SourceSansSemibold
TextButton.Text = "_"
TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton.TextSize = 14.000
 
TextButton_2.Parent = Frame
TextButton_2.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TextButton_2.BorderColor3 = Color3.fromRGB(20, 20, 20)
TextButton_2.Position = UDim2.new(0.0492957756, 0, 0.495575249, 0)
TextButton_2.Size = UDim2.new(0.0469483584, 0, 0.176991165, 0)
TextButton_2.Font = Enum.Font.SourceSansSemibold
TextButton_2.Text = ""
TextButton_2.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton_2.TextScaled = true
TextButton_2.TextSize = 20.000
TextButton_2.TextWrapped = true
 
TextLabel_2.Parent = TextButton_2
TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.BackgroundTransparency = 1.000
TextLabel_2.Position = UDim2.new(1.54999995, 0, 0, 0)
TextLabel_2.Size = UDim2.new(17.7999992, 0, 1, 0)
TextLabel_2.Font = Enum.Font.SourceSansSemibold
TextLabel_2.Text = "Aimbot"
TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.TextSize = 16.000
TextLabel_2.TextWrapped = true
TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left
 
-- Scripts:
 
local function RPTXOJ_fake_script() -- TextButton.LocalScript 
	local script = Instance.new('LocalScript', TextButton)
 
	local state = true
	script.Parent.MouseButton1Down:Connect(function()
		print"t"
		state = not state
		local LB_Size = script.Parent.Parent.AbsoluteSize
		local NW_Size = UDim2.new(0, LB_Size.X, 0, LB_Size.Y)
		if not state then
			script.Parent.Text = "+"
			game:GetService("TweenService"):Create(script.Parent.Parent.Parent, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
				BackgroundTransparency = 1
			}):Play()
			for i, v in pairs(script.Parent.Parent.Parent:GetChildren()) do
				if v:IsA("TextButton") then 
					v.Visible = false
					v.TextLabel.Visible = false
				end
			end
		else
			script.Parent.Text = "_"
			game:GetService("TweenService"):Create(script.Parent.Parent.Parent, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
				BackgroundTransparency = 0
			}):Play()
			for i, v in pairs(script.Parent.Parent.Parent:GetChildren()) do
				if v:IsA("TextButton") then 
					v.Visible = true
					v.TextLabel.Visible = true
				end
			end
		end
	end)
end
coroutine.wrap(RPTXOJ_fake_script)()
local function CIXXD_fake_script() -- TextButton_2.LocalScript 
	local script = Instance.new('LocalScript', TextButton_2)
 
	local state = false
	script.Parent.MouseButton1Down:Connect(function()
		state = not state
		if state then 
			script.Parent.Text = "x"
		else
			script.Parent.Text = ""
		end
	end)
 
	local Cam = workspace.CurrentCamera
 
	local hotkey = true
	function lookAt(target, eye)
		Cam.CFrame = CFrame.new(target, eye)
	end
 
	function getClosestPlayerToCursor(trg_part)
		local nearest = nil
		local last = math.huge
		for i,v in pairs(game.Players:GetPlayers()) do
			if v ~= game.Players.LocalPlayer and game.Players.LocalPlayer.Character and v.Character and v.Character:FindFirstChild(trg_part) then
				if game.Players.LocalPlayer.Character:FindFirstChild(trg_part) then
					local ePos, vissss = workspace.CurrentCamera:WorldToViewportPoint(v.Character[trg_part].Position)
					local AccPos = Vector2.new(ePos.x, ePos.y)
					local mousePos = Vector2.new(workspace.CurrentCamera.ViewportSize.x / 2, workspace.CurrentCamera.ViewportSize.y / 2)
					local distance = (AccPos - mousePos).magnitude
					if distance < last and vissss and hotkey and distance < 400 then
						last = distance
						nearest = v
					end
				end
			end
		end
		return nearest
	end
 
	game:GetService("RunService").RenderStepped:Connect(function()
		local closest = getClosestPlayerToCursor("Head")
		if state and closest and closest.Character:FindFirstChild("Head") then
			lookAt(Cam.CFrame.p, closest.Character:FindFirstChild("Head").Position)
		end
	end)
end
coroutine.wrap(CIXXD_fake_script)()
local function QNWNII_fake_script() -- Frame.LocalScript 
	local script = Instance.new('LocalScript', Frame)
 
	script.Parent.Active = true
	script.Parent.Selectable = true
	script.Parent.Draggable = true
end
coroutine.wrap(QNWNII_fake_script)()
end)
 
local MAINSection = MAINTab:NewSection("hitbox")
MAINSection:NewButton("hitbox", "ButtonInfo", function()
    _G.HeadSize = 20
_G.Disabled = true
 
-- Create a function to modify players
local function modifyPlayers()
    while _G.Disabled do
        for i, v in next, game:GetService('Players'):GetPlayers() do
            if v.Name ~= game:GetService('Players').LocalPlayer.Name then
                pcall(function()
                    v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
                    v.Character.HumanoidRootPart.Transparency = 0.7
                    v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really blue")
                    v.Character.HumanoidRootPart.Material = "Neon"
                    v.Character.HumanoidRootPart.CanCollide = false
                end)
            end
        end
        wait(1) -- Wait for 1 second before the next iteration
    end
end
 
-- Start the function in a separate thread
spawn(modifyPlayers)
end)
 
local gui = Instance.new("ScreenGui")
gui.Name = "patrickGui"
gui.Parent = game.CoreGui
 
--screengui = gui
 
 
 
	local TextButton = Instance.new("TextButton")
-- Text
TextButton.Text = "Toggle Impactfuls aim"
TextButton.TextSize = 24
-- Color
TextButton.TextColor3 = Color3.new(1, 1, 1)
TextButton.BackgroundColor3 = Color3.new(0, 0, 0)
TextButton.BorderColor3 = Color3.new(1, 1, 1)
-- thickness
TextButton.BorderSizePixel = 4
-- Text Code
TextButton.Font = Enum.Font.Code
-- Size
TextButton.Size = UDim2.new(0.2, 0, 0.1, 0)
-- Posisition
TextButton.Position = UDim2.new(0, 0, 0.4, 0)
-- Function
TextButton.MouseButton1Click:Connect (function()
Library:ToggleUI()
end)
TextButton.Parent = gui
TextButton.Draggable = true
 
	local cornerUI = Instance.new("UICorner")
cornerUI.CornerRadius = UDim.new(0, 5)
cornerUI.Parent = TextButton
 
	local uiStroke = Instance.new("UIStroke")
    uiStroke.Color = Color3.new(0, 0, 0)
    uiStroke.Thickness = 2
    uiStroke.Parent = TextButton 
 
    local MAINSection = MAINTab:NewSection("hitbox invisible")
MAINSection:NewButton("hitbox invisible", "ButtonInfo", function()
    _G.HeadSize = 20
_G.Disabled = true
 
local function modifyPlayers()
    while _G.Disabled do
        for i, v in next, game:GetService('Players'):GetPlayers() do
            if v.Name ~= game:GetService('Players').LocalPlayer.Name then
                pcall(function()
                    v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
                    v.Character.HumanoidRootPart.Transparency = 1 -- Make the part fully transparent
                    v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really blue")
                    v.Character.HumanoidRootPart.Material = "Neon"
                    v.Character.HumanoidRootPart.CanCollide = false
                end)
            end
        end
        wait(1) -- Wait for 1 second before the next iteration
    end
end
 
spawn(modifyPlayers)
end)
 
local MAINSection = MAINTab:NewSection("others")
MAINSection:NewButton("others", "ButtonInfo", function()
    -- press v to use aimbot and press q to disable aimbot
loadstring(game:HttpGet("https://pastebin.com/raw/uw2P2fbY", true))()
 
PLAYER  = game.Players.LocalPlayer
MOUSE   = PLAYER:GetMouse()
CC      = game.Workspace.CurrentCamera
 
ENABLED      = false
ESP_ENABLED  = false
 
_G.FREE_FOR_ALL = false
 
_G.BIND        = 118
_G.ESP_BIND    = 49
_G.CHANGE_AIM  = 'q'
 
_G.AIM_AT = 'Head'
 
wait(1)
 
function GetNearestPlayerToMouse()
local PLAYERS      = {}
local PLAYER_HOLD  = {}
local DISTANCES    = {}
for i, v in pairs(game.Players:GetPlayers()) do
if v ~= PLAYER then
table.insert(PLAYERS, v)
end
end
for i, v in pairs(PLAYERS) do
if _G.FREE_FOR_ALL == false then
if v and (v.Character) ~= nil and v.TeamColor ~= PLAYER.TeamColor then
local AIM = v.Character:FindFirstChild(_G.AIM_AT)
if AIM ~= nil then
local DISTANCE                 = (AIM.Position - game.Workspace.CurrentCamera.CoordinateFrame.p).magnitude
local RAY                      = Ray.new(game.Workspace.CurrentCamera.CoordinateFrame.p, (MOUSE.Hit.p - CC.CoordinateFrame.p).unit * DISTANCE)
local HIT,POS                  = game.Workspace:FindPartOnRay(RAY, game.Workspace)
local DIFF                     = math.floor((POS - AIM.Position).magnitude)
PLAYER_HOLD[v.Name .. i]       = {}
PLAYER_HOLD[v.Name .. i].dist  = DISTANCE
PLAYER_HOLD[v.Name .. i].plr   = v
PLAYER_HOLD[v.Name .. i].diff  = DIFF
table.insert(DISTANCES, DIFF)
end
end
elseif _G.FREE_FOR_ALL == true then
local AIM = v.Character:FindFirstChild(_G.AIM_AT)
if AIM ~= nil then
local DISTANCE                 = (AIM.Position - game.Workspace.CurrentCamera.CoordinateFrame.p).magnitude
local RAY                      = Ray.new(game.Workspace.CurrentCamera.CoordinateFrame.p, (MOUSE.Hit.p - CC.CoordinateFrame.p).unit * DISTANCE)
local HIT,POS                  = game.Workspace:FindPartOnRay(RAY, game.Workspace)
local DIFF                     = math.floor((POS - AIM.Position).magnitude)
PLAYER_HOLD[v.Name .. i]       = {}
PLAYER_HOLD[v.Name .. i].dist  = DISTANCE
PLAYER_HOLD[v.Name .. i].plr   = v
PLAYER_HOLD[v.Name .. i].diff  = DIFF
table.insert(DISTANCES, DIFF)
end
end
end
 
if unpack(DISTANCES) == nil then
return false
end
 
local L_DISTANCE = math.floor(math.min(unpack(DISTANCES)))
if L_DISTANCE > 20 then
return false
end
 
for i, v in pairs(PLAYER_HOLD) do
if v.diff == L_DISTANCE then
return v.plr
end
end
return false
end
 
GUI_MAIN                           = Instance.new('ScreenGui', game.CoreGui)
GUI_TARGET                         = Instance.new('TextLabel', GUI_MAIN)
GUI_AIM_AT                         = Instance.new('TextLabel', GUI_MAIN)
 
GUI_MAIN.Name                      = 'AIMBOT'
 
GUI_TARGET.Size                    = UDim2.new(0,200,0,30)
GUI_TARGET.BackgroundTransparency  = 0.5
GUI_TARGET.BackgroundColor         = BrickColor.new('Fossil')
GUI_TARGET.BorderSizePixel         = 0
GUI_TARGET.Position                = UDim2.new(0.5,-100,0,0)
GUI_TARGET.Text                    = 'AIMBOT : OFF'
GUI_TARGET.TextColor3              = Color3.new(1,1,1)
GUI_TARGET.TextStrokeTransparency  = 1
GUI_TARGET.TextWrapped             = true
GUI_TARGET.FontSize                = 'Size24'
GUI_TARGET.Font                    = 'SourceSansBold'
 
GUI_AIM_AT.Size                    = UDim2.new(0,200,0,20)
GUI_AIM_AT.BackgroundTransparency  = 0.5
GUI_AIM_AT.BackgroundColor         = BrickColor.new('Fossil')
GUI_AIM_AT.BorderSizePixel         = 0
GUI_AIM_AT.Position                = UDim2.new(0.5,-100,0,30)
GUI_AIM_AT.Text                    = 'AIMING : HEAD'
GUI_AIM_AT.TextColor3              = Color3.new(1,1,1)
GUI_AIM_AT.TextStrokeTransparency  = 1
GUI_AIM_AT.TextWrapped             = true
GUI_AIM_AT.FontSize                = 'Size18'
GUI_AIM_AT.Font                    = 'SourceSansBold'
 
local TRACK = false
 
function CREATE(BASE, TEAM)
local ESP_MAIN                   = Instance.new('BillboardGui', PLAYER.PlayerGui)
local ESP_DOT                    = Instance.new('Frame', ESP_MAIN)
local ESP_NAME                   = Instance.new('TextLabel', ESP_MAIN)
 
ESP_MAIN.Name                    = 'ESP'
ESP_MAIN.Adornee                 = BASE
ESP_MAIN.AlwaysOnTop             = true
ESP_MAIN.ExtentsOffset           = Vector3.new(0, 1, 0)
ESP_MAIN.Size                    = UDim2.new(0, 5, 0, 5)
 
ESP_DOT.Name                     = 'DOT'
ESP_DOT.BackgroundColor          = BrickColor.new('Bright red')
ESP_DOT.BackgroundTransparency   = 0.3
ESP_DOT.BorderSizePixel          = 0
ESP_DOT.Position                 = UDim2.new(-0.5, 0, -0.5, 0)
ESP_DOT.Size                     = UDim2.new(2, 0, 2, 0)
ESP_DOT.Visible                  = true
ESP_DOT.ZIndex                   = 10
 
ESP_NAME.Name                    = 'NAME'
ESP_NAME.BackgroundColor3        = Color3.new(255, 255, 255)
ESP_NAME.BackgroundTransparency  = 1
ESP_NAME.BorderSizePixel         = 0
ESP_NAME.Position                = UDim2.new(0, 0, 0, -40)
ESP_NAME.Size                    = UDim2.new(1, 0, 10, 0)
ESP_NAME.Visible                 = true
ESP_NAME.ZIndex                  = 10
ESP_NAME.Font                    = 'ArialBold'
ESP_NAME.FontSize                = 'Size14'
ESP_NAME.Text                    = BASE.Parent.Name:upper()
ESP_NAME.TextColor               = BrickColor.new('Bright red')
end
 
function CLEAR()
for _,v in pairs(PLAYER.PlayerGui:children()) do
if v.Name == 'ESP' and v:IsA('BillboardGui') then
v:Destroy()
end
end
end
 
function FIND()
CLEAR()
TRACK = true
spawn(function()
while wait() do
if TRACK then
CLEAR()
for i,v in pairs(game.Players:GetChildren()) do
if v.Character and v.Character:FindFirstChild('Head') then
if _G.FREE_FOR_ALL == false then
if v.TeamColor ~= PLAYER.TeamColor then
if v.Character:FindFirstChild('Head') then
CREATE(v.Character.Head, true)
end
end
else
if v.Character:FindFirstChild('Head') then
CREATE(v.Character.Head, true)
end
end
end
end
end
end
wait(1)
end)
end
 
MOUSE.KeyDown:connect(function(KEY)
KEY = KEY:lower():byte()
if KEY == _G.BIND then
ENABLED = true
end
end)
 
MOUSE.KeyUp:connect(function(KEY)
KEY = KEY:lower():byte()
if KEY == _G.BIND then
ENABLED = false
end
end)
 
MOUSE.KeyDown:connect(function(KEY)
KEY = KEY:lower():byte()
if KEY == _G.ESP_BIND then
if ESP_ENABLED == false then
FIND()
ESP_ENABLED = true
print('ESP : ON')
elseif ESP_ENABLED == true then
wait()
CLEAR()
TRACK = false
ESP_ENABLED = true
print('ESP : OFF')
end
end
end)
 
MOUSE.KeyDown:connect(function(KEY)
if KEY == _G.CHANGE_AIM then
if _G.AIM_AT == 'Head' then
_G.AIM_AT = 'Torso'
GUI_AIM_AT.Text = 'AIMING : TORSO'
elseif _G.AIM_AT == 'Torso' then
_G.AIM_AT = 'Head'
GUI_AIM_AT.Text = 'AIMING : HEAD'
end
end
end)
 
game:GetService('RunService').RenderStepped:connect(function()
if ENABLED then
local TARGET = GetNearestPlayerToMouse()
if (TARGET ~= false) then
local AIM = TARGET.Character:FindFirstChild(_G.AIM_AT)
if AIM then
CC.CoordinateFrame = CFrame.new(CC.CoordinateFrame.p, AIM.CFrame.p)
end
GUI_TARGET.Text = 'AIMBOT : '.. TARGET.Name:sub(1, 5)
else
GUI_TARGET.Text = 'AIMBOT : OFF'
end
end
end)
 
repeat
wait()
if ESP_ENABLED == true then
FIND()
end
until ESP_ENABLED == false
wait()-- press v to use aimbot and press q to disable aimbot
loadstring(game:HttpGet("https://pastebin.com/raw/uw2P2fbY", true))()
 
PLAYER  = game.Players.LocalPlayer
MOUSE   = PLAYER:GetMouse()
CC      = game.Workspace.CurrentCamera
 
ENABLED      = false
ESP_ENABLED  = false
 
_G.FREE_FOR_ALL = false
 
_G.BIND        = 118
_G.ESP_BIND    = 49
_G.CHANGE_AIM  = 'q'
 
_G.AIM_AT = 'Head'
 
wait(1)
 
function GetNearestPlayerToMouse()
local PLAYERS      = {}
local PLAYER_HOLD  = {}
local DISTANCES    = {}
for i, v in pairs(game.Players:GetPlayers()) do
if v ~= PLAYER then
table.insert(PLAYERS, v)
end
end
for i, v in pairs(PLAYERS) do
if _G.FREE_FOR_ALL == false then
if v and (v.Character) ~= nil and v.TeamColor ~= PLAYER.TeamColor then
local AIM = v.Character:FindFirstChild(_G.AIM_AT)
if AIM ~= nil then
local DISTANCE                 = (AIM.Position - game.Workspace.CurrentCamera.CoordinateFrame.p).magnitude
local RAY                      = Ray.new(game.Workspace.CurrentCamera.CoordinateFrame.p, (MOUSE.Hit.p - CC.CoordinateFrame.p).unit * DISTANCE)
local HIT,POS                  = game.Workspace:FindPartOnRay(RAY, game.Workspace)
local DIFF                     = math.floor((POS - AIM.Position).magnitude)
PLAYER_HOLD[v.Name .. i]       = {}
PLAYER_HOLD[v.Name .. i].dist  = DISTANCE
PLAYER_HOLD[v.Name .. i].plr   = v
PLAYER_HOLD[v.Name .. i].diff  = DIFF
table.insert(DISTANCES, DIFF)
end
end
elseif _G.FREE_FOR_ALL == true then
local AIM = v.Character:FindFirstChild(_G.AIM_AT)
if AIM ~= nil then
local DISTANCE                 = (AIM.Position - game.Workspace.CurrentCamera.CoordinateFrame.p).magnitude
local RAY                      = Ray.new(game.Workspace.CurrentCamera.CoordinateFrame.p, (MOUSE.Hit.p - CC.CoordinateFrame.p).unit * DISTANCE)
local HIT,POS                  = game.Workspace:FindPartOnRay(RAY, game.Workspace)
local DIFF                     = math.floor((POS - AIM.Position).magnitude)
PLAYER_HOLD[v.Name .. i]       = {}
PLAYER_HOLD[v.Name .. i].dist  = DISTANCE
PLAYER_HOLD[v.Name .. i].plr   = v
PLAYER_HOLD[v.Name .. i].diff  = DIFF
table.insert(DISTANCES, DIFF)
end
end
end
 
if unpack(DISTANCES) == nil then
return false
end
 
local L_DISTANCE = math.floor(math.min(unpack(DISTANCES)))
if L_DISTANCE > 20 then
return false
end
 
for i, v in pairs(PLAYER_HOLD) do
if v.diff == L_DISTANCE then
return v.plr
end
end
return false
end
 
GUI_MAIN                           = Instance.new('ScreenGui', game.CoreGui)
GUI_TARGET                         = Instance.new('TextLabel', GUI_MAIN)
GUI_AIM_AT                         = Instance.new('TextLabel', GUI_MAIN)
 
GUI_MAIN.Name                      = 'AIMBOT'
 
GUI_TARGET.Size                    = UDim2.new(0,200,0,30)
GUI_TARGET.BackgroundTransparency  = 0.5
GUI_TARGET.BackgroundColor         = BrickColor.new('Fossil')
GUI_TARGET.BorderSizePixel         = 0
GUI_TARGET.Position                = UDim2.new(0.5,-100,0,0)
GUI_TARGET.Text                    = 'AIMBOT : OFF'
GUI_TARGET.TextColor3              = Color3.new(1,1,1)
GUI_TARGET.TextStrokeTransparency  = 1
GUI_TARGET.TextWrapped             = true
GUI_TARGET.FontSize                = 'Size24'
GUI_TARGET.Font                    = 'SourceSansBold'
 
GUI_AIM_AT.Size                    = UDim2.new(0,200,0,20)
GUI_AIM_AT.BackgroundTransparency  = 0.5
GUI_AIM_AT.BackgroundColor         = BrickColor.new('Fossil')
GUI_AIM_AT.BorderSizePixel         = 0
GUI_AIM_AT.Position                = UDim2.new(0.5,-100,0,30)
GUI_AIM_AT.Text                    = 'AIMING : HEAD'
GUI_AIM_AT.TextColor3              = Color3.new(1,1,1)
GUI_AIM_AT.TextStrokeTransparency  = 1
GUI_AIM_AT.TextWrapped             = true
GUI_AIM_AT.FontSize                = 'Size18'
GUI_AIM_AT.Font                    = 'SourceSansBold'
 
local TRACK = false
 
function CREATE(BASE, TEAM)
local ESP_MAIN                   = Instance.new('BillboardGui', PLAYER.PlayerGui)
local ESP_DOT                    = Instance.new('Frame', ESP_MAIN)
local ESP_NAME                   = Instance.new('TextLabel', ESP_MAIN)
 
ESP_MAIN.Name                    = 'ESP'
ESP_MAIN.Adornee                 = BASE
ESP_MAIN.AlwaysOnTop             = true
ESP_MAIN.ExtentsOffset           = Vector3.new(0, 1, 0)
ESP_MAIN.Size                    = UDim2.new(0, 5, 0, 5)
 
ESP_DOT.Name                     = 'DOT'
ESP_DOT.BackgroundColor          = BrickColor.new('Bright red')
ESP_DOT.BackgroundTransparency   = 0.3
ESP_DOT.BorderSizePixel          = 0
ESP_DOT.Position                 = UDim2.new(-0.5, 0, -0.5, 0)
ESP_DOT.Size                     = UDim2.new(2, 0, 2, 0)
ESP_DOT.Visible                  = true
ESP_DOT.ZIndex                   = 10
 
ESP_NAME.Name                    = 'NAME'
ESP_NAME.BackgroundColor3        = Color3.new(255, 255, 255)
ESP_NAME.BackgroundTransparency  = 1
ESP_NAME.BorderSizePixel         = 0
ESP_NAME.Position                = UDim2.new(0, 0, 0, -40)
ESP_NAME.Size                    = UDim2.new(1, 0, 10, 0)
ESP_NAME.Visible                 = true
ESP_NAME.ZIndex                  = 10
ESP_NAME.Font                    = 'ArialBold'
ESP_NAME.FontSize                = 'Size14'
ESP_NAME.Text                    = BASE.Parent.Name:upper()
ESP_NAME.TextColor               = BrickColor.new('Bright red')
end
 
function CLEAR()
for _,v in pairs(PLAYER.PlayerGui:children()) do
if v.Name == 'ESP' and v:IsA('BillboardGui') then
v:Destroy()
end
end
end
 
function FIND()
CLEAR()
TRACK = true
spawn(function()
while wait() do
if TRACK then
CLEAR()
for i,v in pairs(game.Players:GetChildren()) do
if v.Character and v.Character:FindFirstChild('Head') then
if _G.FREE_FOR_ALL == false then
if v.TeamColor ~= PLAYER.TeamColor then
if v.Character:FindFirstChild('Head') then
CREATE(v.Character.Head, true)
end
end
else
if v.Character:FindFirstChild('Head') then
CREATE(v.Character.Head, true)
end
end
end
end
end
end
wait(1)
end)
end
 
MOUSE.KeyDown:connect(function(KEY)
KEY = KEY:lower():byte()
if KEY == _G.BIND then
ENABLED = true
end
end)
 
MOUSE.KeyUp:connect(function(KEY)
KEY = KEY:lower():byte()
if KEY == _G.BIND then
ENABLED = false
end
end)
 
MOUSE.KeyDown:connect(function(KEY)
KEY = KEY:lower():byte()
if KEY == _G.ESP_BIND then
if ESP_ENABLED == false then
FIND()
ESP_ENABLED = true
print('ESP : ON')
elseif ESP_ENABLED == true then
wait()
CLEAR()
TRACK = false
ESP_ENABLED = true
print('ESP : OFF')
end
end
end)
 
MOUSE.KeyDown:connect(function(KEY)
if KEY == _G.CHANGE_AIM then
if _G.AIM_AT == 'Head' then
_G.AIM_AT = 'Torso'
GUI_AIM_AT.Text = 'AIMING : TORSO'
elseif _G.AIM_AT == 'Torso' then
_G.AIM_AT = 'Head'
GUI_AIM_AT.Text = 'AIMING : HEAD'
end
end
end)
 
game:GetService('RunService').RenderStepped:connect(function()
if ENABLED then
local TARGET = GetNearestPlayerToMouse()
if (TARGET ~= false) then
local AIM = TARGET.Character:FindFirstChild(_G.AIM_AT)
if AIM then
CC.CoordinateFrame = CFrame.new(CC.CoordinateFrame.p, AIM.CFrame.p)
end
GUI_TARGET.Text = 'AIMBOT : '.. TARGET.Name:sub(1, 5)
else
GUI_TARGET.Text = 'AIMBOT : OFF'
end
end
end)
 
repeat
wait()
if ESP_ENABLED == true then
FIND()
end
until ESP_ENABLED == false
wait()
_G.FREE_FOR_ALL = false
_G.BIND = 118 -- LEFT ALT
_G.ESP_BIND = 49 -- RIGHT CTRL
_G.FREE_FOR_ALL = false
_G.BIND = 118 -- LEFT ALT
_G.ESP_BIND = 49 -- RIGHT CTRL
end)
 
 
 
 
local MAINSection = MAINTab:NewSection("Aim Lock")
MAINSection:NewButton("Aimbot/Hitbox/Silent Aim","Increase Range",function()
local Camera = game:GetService("Workspace").CurrentCamera
local Players = game:GetService("Players")
local LocalPlayer = game:GetService("Players").LocalPlayer
 
local function GetClosestPlayer()
   local ClosestPlayer = nil
   local FarthestDistance = math.huge
 
   for i, v in pairs(Players.GetPlayers(Players)) do
       if v ~= LocalPlayer and v.Character and v.Character.FindFirstChild(v.Character, "HumanoidRootPart") then
           local DistanceFromPlayer = (LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude
 
           if DistanceFromPlayer < FarthestDistance then
               FarthestDistance = DistanceFromPlayer
               ClosestPlayer = v
           end
       end
   end
 
   if ClosestPlayer then
       return ClosestPlayer
   end
end
 
local GameMetaTable = getrawmetatable(game)
local OldGameMetaTableNamecall = GameMetaTable.__namecall
setreadonly(GameMetaTable, false)
 
GameMetaTable.__namecall = newcclosure(function(object, ...)
   local NamecallMethod = getnamecallmethod()
   local Arguments = {...}
 
   if tostring(NamecallMethod) == "FindPartOnRayWithIgnoreList" then
       local ClosestPlayer = GetClosestPlayer()
 
       if ClosestPlayer and ClosestPlayer.Character then
           Arguments[1] = Ray.new(Camera.CFrame.Position, (ClosestPlayer.Character.Head.Position - Camera.CFrame.Position).Unit * (Camera.CFrame.Position - ClosestPlayer.Character.Head.Position).Magnitude)
       end
   end
 
   return OldGameMetaTableNamecall(object, unpack(Arguments))
end)
 
setreadonly(GameMetaTable, true)
end)
 
local MAINSection = MAINTab:NewSection("esp")
MAINSection:NewToggle("Esp","Opens Box esp",function()
local Player = game:GetService("Players").LocalPlayer
local Camera = game:GetService("Workspace").CurrentCamera
local Mouse = Player:GetMouse()
 
local function Dist(pointA, pointB) -- magnitude errors for some reason  : (
    return math.sqrt(math.pow(pointA.X - pointB.X, 2) + math.pow(pointA.Y - pointB.Y, 2))
end
 
local function GetClosest(points, dest)
    local min  = math.huge 
    local closest = nil
    for _,v in pairs(points) do
        local dist = Dist(v, dest)
        if dist < min then
            min = dist
            closest = v
        end
    end
    return closest
end
 
local function DrawESP(plr)
    local Box = Drawing.new("Quad")
    Box.Visible = false
    Box.PointA = Vector2.new(0, 0)
    Box.PointB = Vector2.new(0, 0)
    Box.PointC = Vector2.new(0, 0)
    Box.PointD = Vector2.new(0, 0)
    Box.Color = Color3.fromRGB(255, 255, 255)
    Box.Thickness = 2
    Box.Transparency = 1
 
    local function Update()
        local c
        c = game:GetService("RunService").RenderStepped:Connect(function()
            if plr.Character ~= nil and plr.Character:FindFirstChildOfClass("Humanoid") ~= nil and plr.Character:FindFirstChild("HumanoidRootPart") ~= nil and plr.Character:FindFirstChildOfClass("Humanoid").Health > 0 and plr.Character:FindFirstChild("Head") ~= nil then
                local pos, vis = Camera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
                if vis then 
                    local points = {}
                    local c = 0
                    for _,v in pairs(plr.Character:GetChildren()) do
                        if v:IsA("BasePart") then
                            c = c + 1
                            local p = Camera:WorldToViewportPoint(v.Position)
                            if v.Name == "HumanoidRootPart" then
                                p = Camera:WorldToViewportPoint((v.CFrame * CFrame.new(0, 0, -v.Size.Z)).p)
                            elseif v.Name == "Head" then
                                p = Camera:WorldToViewportPoint((v.CFrame * CFrame.new(0, v.Size.Y/2, v.Size.Z/1.25)).p)
                            elseif string.match(v.Name, "Left") then
                                p = Camera:WorldToViewportPoint((v.CFrame * CFrame.new(-v.Size.X/2, 0, 0)).p)
                            elseif string.match(v.Name, "Right") then
                                p = Camera:WorldToViewportPoint((v.CFrame * CFrame.new(v.Size.X/2, 0, 0)).p)
                            end
                            points[c] = p
                        end
                    end
                    local Left = GetClosest(points, Vector2.new(0, pos.Y))
                    local Right = GetClosest(points, Vector2.new(Camera.ViewportSize.X, pos.Y))
                    local Top = GetClosest(points, Vector2.new(pos.X, 0))
                    local Bottom = GetClosest(points, Vector2.new(pos.X, Camera.ViewportSize.Y))
 
                    if Left ~= nil and Right ~= nil and Top ~= nil and Bottom ~= nil then
                        Box.PointA = Vector2.new(Right.X, Top.Y)
                        Box.PointB = Vector2.new(Left.X, Top.Y)
                        Box.PointC = Vector2.new(Left.X, Bottom.Y)
                        Box.PointD = Vector2.new(Right.X, Bottom.Y)
 
                        Box.Visible = true
                    else 
                        Box.Visible = false
                    end
                else 
                    Box.Visible = false
                end
            else
                Box.Visible = false
                if game.Players:FindFirstChild(plr.Name) == nil then
                    c:Disconnect()
                end
            end
        end)
    end
    coroutine.wrap(Update)()
end
 
for _,v in pairs(game:GetService("Players"):GetChildren()) do
    if v.Name ~= Player.Name then 
        DrawESP(v)
    end
end
 
game:GetService("Players").PlayerAdded:Connect(function(v)
    DrawESP(v)
end)
end)
 
local MAINSection = MAINTab:NewSection("Tracers")
MAINSection:NewToggle("Tracers","Opens Tracers",function()
local lplr = game.Players.LocalPlayer
local camera = game:GetService("Workspace").CurrentCamera
local CurrentCamera = workspace.CurrentCamera
local worldToViewportPoint = CurrentCamera.worldToViewportPoint
 
_G.TeamCheck = false -- Use True or False to toggle TeamCheck
 
for i,v in pairs(game.Players:GetChildren()) do
    local Tracer = Drawing.new("Line")
    Tracer.Visible = false
    Tracer.Color = Color3.new(255, 0, 0)
    Tracer.Thickness = 1
    Tracer.Transparency = 1
 
    function lineesp()
        game:GetService("RunService").RenderStepped:Connect(function()
            if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v ~= lplr and v.Character.Humanoid.Health > 0 then
                local Vector, OnScreen = camera:worldToViewportPoint(v.Character.HumanoidRootPart.Position)
 
                if OnScreen then
                    Tracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 1)
                    Tracer.To = Vector2.new(Vector.X, Vector.Y)
 
                    if _G.TeamCheck and v.TeamColor == lplr.TeamColor then
                        --//Teammates
                        Tracer.Visible = false
                    else
                        --//Enemies
                        Tracer.Visible = true
                    end
                else
                    Tracer.Visible = false
                end
            else
                Tracer.Visible = false
            end
        end)
    end
    coroutine.wrap(lineesp)()
end
 
game.Players.PlayerAdded:Connect(function(v)
    local Tracer = Drawing.new("Line")
    Tracer.Visible = false
    Tracer.Color = Color3.new(1,1,1)
    Tracer.Thickness = 1
    Tracer.Transparency = 1
 
    function lineesp()
        game:GetService("RunService").RenderStepped:Connect(function()
            if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v ~= lplr and v.Character.Humanoid.Health > 0 then
                local Vector, OnScreen = camera:worldToViewportPoint(v.Character.HumanoidRootPart.Position)
 
                if OnScreen then
                    Tracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 1)
                    Tracer.To = Vector2.new(Vector.X, Vector.Y)
 
                    if _G.TeamCheck and v.TeamColor == lplr.TeamColor then
                        --//Teammates
                        Tracer.Visible = false
                    else
                        --//Enemies
                        Tracer.Visible = true
                    end
                else
                    Tracer.Visible = false
                end
            else
                Tracer.Visible = false
            end
        end)
    end
    coroutine.wrap(lineesp)()
end)
end)
local CreditsTab = Window:NewTab("Credits")
local CreditsSection = CreditsTab:NewSection("Impactfuls aka AgentV4MP owner")
end)
 
local ChangeTab = Window:NewTab("*Updates*")
local ChangeSection = ChangeTab:NewSection("[+] Created Stfom Copper!")
local ChangeSection = ChangeTab:NewSection("[+] Changed Added way more functions!")
local ChangeSection = ChangeTab:NewSection("[+] Changed name!")
local ChangeSection = ChangeTab:NewSection("[+] Made Universal!")
local ChangeSection = ChangeTab:NewSection("[+] Added more tabs!")
local ChangeSection = ChangeTab:NewSection("[+] Fixed bugs!")
local ChangeSection = ChangeTab:NewSection("[+] Added Grinding tabs!")
 
local CreditsTab = Window:NewTab("Credits")
local CreditsSection = CreditsTab:NewSection("Impactfuls aka AgentV4MP owner")
