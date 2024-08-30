-- source https://pastebin.com/LVBj259x
-- updated at june 24, 2024

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
 
local Window = Rayfield:CreateWindow({
   Name = "Volware",
   LoadingTitle = "Volware",
   LoadingSubtitle = "by Vo1ters",
   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Volware Hub"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },
   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Volware | Key",
      Subtitle = "Ask Vo1ters For Key",
      Note = "Secret Script",
      FileName = "Volware", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = false, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = true, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"https://pastebin.com/raw/t4tEs2ii"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})
 
local MainTab = Window:CreateTab("Home", nil) -- Title, Image
local MainSection = MainTab:CreateSection("Main")
 
Rayfield:Notify({
   Title = "You Executed The Script!",
   Content = "Volware",
   Duration = 6.5,
   Image = nil,
   Actions = { -- Notification Buttons
      Ignore = {
         Name = "Okay!",
         Callback = function()
         print("The user tapped Okay!")
      end
   },
},
})
 
local Button = MainTab:CreateButton({
   Name = "Infinite Yield",
   Callback = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
   end,
})
 
local Slider = MainTab:CreateSlider({
   Name = "Walkspeed",
   Range = {16, 300},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = (Value)
   end,
})
 
local Slider = MainTab:CreateSlider({
   Name = "Jump Power",
   Range = {50, 300},
   Increment = 1,
   Suffix = "Jump",
   CurrentValue = 50,
   Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = (Value)
   end,
})
 
local ReachTab = Window:CreateTab("Swordfighting", nil) -- Title, Image
local Selection = ReachTab:CreateSection("Reaches")
 
local Button = ReachTab:CreateButton({
   Name = "cBring",
   Callback = function()
_G.Reach = 10
_G.KeyBindHigher = "q"
_G.KeyBindLower = "e"
_G.ReachOff = false -- 
 
game:GetService"RunService".Stepped:Connect(function()
    if _G.ReachOff then return end
    pcall(function()
      Sword = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Handle
        for i,v in pairs(game.Players:GetPlayers()) do 
            if v ~= game.Players.LocalPlayer and v.Character:FindFirstChild("Left Arm") then
             if (game.Players.LocalPlayer.Character.Torso.Position - v.Character.Torso.Position).Magnitude <= _G.Reach then
                   v.Character['Left Arm']:BreakJoints()
                   v.Character['Left Arm'].Transparency = 1
                   v.Character['Left Arm'].CanCollide = false
                   v.Character['Left Arm'].CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(1,0,-3.5)
                   v.Character['Left Leg']:BreakJoints()
                   v.Character['Left Leg'].Transparency = 1
                   v.Character['Left Leg'].CanCollide = false
                   v.Character['Left Leg'].CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(1,0,-3.5)
               end
           end
       end
    end)
end)
 
local Mouse = game.Players.LocalPlayer:GetMouse()
    Mouse.KeyDown:Connect(function(key)
        if key == _G.KeyBindHigher then
                 _G.Reach = _G.Reach + 1 
                 game.StarterGui:SetCore("SendNotification", {
                 Title = "Volware";
                 Text = "Reach set to " .. _G.Reach;
                 Icon = "";
                 Duration = 1;})
             end
          end)
 
 
     local Mouse = game.Players.LocalPlayer:GetMouse()
    Mouse.KeyDown:Connect(function(key)
        if key == _G.KeyBindLower then
                 _G.Reach = _G.Reach - 1 
                 game.StarterGui:SetCore("SendNotification", {
                 Title = "Volware";
                 Text = "Reach set to " .. _G.Reach;
                 Icon = "";
                 Duration = 1;})
             end
          end)
 
_G.AutoClicker = true
        while _G.AutoClicker do
            wait()
            pcall(function()
                local Sword = game:GetService'Players'.LocalPlayer.Character:FindFirstChildOfClass'Tool'
                Sword:Activate()
            end)
        end
 
game.Players.Name = "1 Line Bypass"
 
wait(0.5)
 
game:GetService("ReplicatedStorage").ClientAlert:Destroy()
game:GetService("ReplicatedStorage").ServerAlert:Destroy()
game:GetService("ReplicatedStorage").CheckAdmin:Destroy()
game:GetService("ReplicatedStorage").WarnRemote:Destroy()
   end,
})
 
local Button = ReachTab:CreateButton({
   Name = "Skidzone V3",
   Callback = function()
--- SKIDZONE V3 Modded by Vo1ters.
--- 8/06/2024
 
 
getgenv().circlesize = 5
getgenv().circle = true -- if false then resize is block
_G.CIRCLETOGGLE = "y"
_G.KeyBindHigherCircle = "z"
_G.KeyBindLowerCircle = "x"
_G.KeyBindVisuals = "l"
 
-----------------------------------------
 
 
------ box, press y to change 
getgenv().reach = 4.4
getgenv().wide = 3
getgenv().height = 1.3
getgenv().visuals = true 
 
local Mouse = game.Players.LocalPlayer:GetMouse()
    Mouse.KeyDown:Connect(function(key)
        if key == _G.KeyBindVisuals then
                 if visuals then
                 getgenv().visuals = false
                 game.StarterGui:SetCore("SendNotification", {
                 Title = "SKIDZONE V3";
                 Text = "visuals is "..tostring(getgenv().visuals);
                 Icon = "";
                 Duration = 1;})
                 else
                 getgenv().visuals = true
                 game.StarterGui:SetCore("SendNotification", {
                 Title = "SKIDZONE V3";
                 Text = "visuals is "..tostring(getgenv().visuals);
                 Icon = "";
                 Duration = 1;})
             end
             end
          end)
 
local Mouse = game.Players.LocalPlayer:GetMouse()
     Mouse.KeyDown:Connect(function(key) 
        if key == _G.CIRCLETOGGLE then
                 if circle then
                 getgenv().circle = false
                 game.StarterGui:SetCore("SendNotification", {
                 Title = "SKIDZONE V3";
                 Text = "selectionsphere is "..tostring(getgenv().circle);
                 Icon = "";
                 Duration = 1;})
                 else
                 getgenv().circle = true
                 game.StarterGui:SetCore("SendNotification", {
                 Title = "SKIDZONE V3";
                 Text = "selectionsphere is "..tostring(getgenv().circle);
                 Icon = "";
                 Duration = 1;})
             end
             end
          end)
 
 
 
local Mouse = game.Players.LocalPlayer:GetMouse()
    Mouse.KeyDown:Connect(function(key)
        if key == _G.KeyBindHigherCircle then
                 circlesize = circlesize + 1
                 game.StarterGui:SetCore("SendNotification", {
                 Title = "SKIDZONE V3";
                 Text = "circle increased ".. circlesize;
                 Icon = "";
                 Duration = 1;})
             end
          end)
 
 
local Mouse = game.Players.LocalPlayer:GetMouse()
    Mouse.KeyDown:Connect(function(key)
        if key == _G.KeyBindLowerCircle then
                 circlesize = circlesize - 1
                 game.StarterGui:SetCore("SendNotification", {
                 Title = "SKIDZONE V3";
                 Text = "circle decreased ".. circlesize;
                 Icon = "";
                 Duration = 1;})
             end
          end)
 
local Mouse = game.Players.LocalPlayer:GetMouse()
    Mouse.KeyDown:Connect(function(key)
        if key == _G.KeyBindHigherWide then
                 wide = wide + .5
                 game.StarterGui:SetCore("SendNotification", {
                 Title = "SKIDZONE V3";
                 Text = "wide increased ".. wide;
                 Icon = "";
                 Duration = 1;})
             end
          end)
 
 
local Mouse = game.Players.LocalPlayer:GetMouse()
    Mouse.KeyDown:Connect(function(key)
        if key == _G.KeyBindLowerWide then
                 wide = wide - .5
                 game.StarterGui:SetCore("SendNotification", {
                 Title = "SKIDZONE V3";
                 Text = "wide decreased ".. wide;
                 Icon = "";
                 Duration = 1;})
             end
          end)
 
local Mouse = game.Players.LocalPlayer:GetMouse()
    Mouse.KeyDown:Connect(function(key)
        if key == _G.KeyBindHigherReach then
                 reach = reach + .1
                 game.StarterGui:SetCore("SendNotification", {
                 Title = "SKIDZONE V3";
                 Text = "reach increased ".. reach;
                 Icon = "";
                 Duration = 1;})
             end
          end)
 
 
local Mouse = game.Players.LocalPlayer:GetMouse()
    Mouse.KeyDown:Connect(function(key)
        if key == _G.KeyBindLowerReach then
                 reach = reach - .1
                 game.StarterGui:SetCore("SendNotification", {
                 Title = "SKIDZONE V3";
                 Text = "reach decreased ".. reach;
                 Icon = "";
                 Duration = 1;})
             end
          end)
 
local function isInsideCircle(position)
    local localPlayer = game.Players.LocalPlayer
    local localCharacter = localPlayer.Character
    if localCharacter then
        local localPosition = localCharacter:WaitForChild("HumanoidRootPart").Position
        local distance = (position - localPosition).Magnitude
        return distance <= reach
    end
    return false
end
 
local function getClosestPlayerInCircle()
    local localPlayer = game.Players.LocalPlayer
    local localCharacter = localPlayer.Character
    if not localCharacter then
        return nil
    end
 
    local localPosition = localCharacter:WaitForChild("HumanoidRootPart").Position
    local closestPlayer = nil
    local closestDistance = math.huge
 
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local position = player.Character.HumanoidRootPart.Position
            local distance = (position - localPosition).Magnitude
 
            if isInsideCircle(position) and distance < closestDistance and player.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
                closestPlayer = player
                closestDistance = distance
            end
        end
    end
 
    return closestPlayer
end
 
while true do
for _, v in pairs(game:GetService('Players').LocalPlayer.Character:GetChildren()) do
        if v:IsA("Tool") then
            for _, child in pairs(v.Handle:GetChildren()) do
                if child:IsA("SelectionBox") then
                    child:Destroy()
                end
                for _, child in pairs(v.Handle:GetChildren()) do
                if child:IsA("SelectionSphere") then
                    child:Destroy()
                end
            end
                if visuals then
                if not circle then
                local vis = Instance.new("SelectionBox", v.Handle)
                vis.Adornee = v.Handle
                vis.Color3 = Color3.fromRGB(128, 0, 0)
                v.Handle.Massless = true
                v.Handle.Size = Vector3.new(height, wide, reach)  
                end
                end
                if not visuals then
                if not circle then
                v.Handle.Massless = true
                v.Handle.Size = Vector3.new(height, wide, reach)
                end
                end
                if visuals then 
                if circle then 
                local circ = Instance.new("SelectionSphere", v.Handle)
                circ.Adornee = v.Handle
                circ.Color3 = Color3.fromRGB(128, 0, 0)
                v.Handle.Massless = true
                v.Handle.Size = Vector3.new(circlesize, circlesize, circlesize)  
                end
                end
                if circle then 
                if not visuals then
                v.Handle.Massless = true
                v.Handle.Size = Vector3.new(circlesize, circlesize, circlesize)  
                end
                end
            end
        end
        end
        wait()
end
 
 
   end,
})
