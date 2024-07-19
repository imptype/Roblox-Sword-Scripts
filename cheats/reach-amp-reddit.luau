-- source https://www.reddit.com/r/robloxhackers/comments/pv0h9i/sword_reach_extender_with_damage_amp_bypasses/
-- updated at september 25, 2021

--// Information \\--

-- some games have a maximum amount to the reach you can have

-- if you have the original script you want to use this cause this version is improved by a lot and easier to use

-- q increases the reach by 1 e decreases reach by 1

--// Setting \\--

local range = 7

--// Variable \\--

local player = game:GetService("Players").LocalPlayer

--// Script \\--

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

game:GetService("Players").LocalPlayer:GetMouse().KeyDown:Connect(function(Key)

if Key == "q" then

range = range + 1

game:GetService("StarterGui"):SetCore("SendNotification", {

Title = "ok we going up!!!";

Text = "reach went up by " .. range;

Icon = "";

Duration = 0.5;})

end

if Key == "e" then

range = range - 1

game:GetService("StarterGui"):SetCore("SendNotification", {

Title = "reach is going down ;(";

Text = "reach went down by " .. range;

Icon = "";

Duration = 0.5;})

end

end)
