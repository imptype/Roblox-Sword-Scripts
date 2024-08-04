-- source https://pastebin.com/VUZNbtjW
-- updated at may 22, 2024

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("MADE MY MOS REACH SCRIPT", "Ocean")
local OpreachTab = Window:NewTab("Op Reach")
local PlayerTab = Window:NewTab("Player")
local Section = OpreachTab:NewSection("op script")
Section:NewButton("opreach", "this dont give u ban", function()
_G.Reach = 100
_G.KeyBindHigher = "["
_G.KeyBindLower = "]"
_G.ReachOff = false -- Set this to true if you want to disable the reach lol
 
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
                 Title = "H0ndu's Reach v1";
                 Text = "Reach set to " .. _G.Reach;
                 Icon = "";
                 Duration = 0.3;})
             end
          end)
 
 
     local Mouse = game.Players.LocalPlayer:GetMouse()
    Mouse.KeyDown:Connect(function(key)
        if key == _G.KeyBindLower then
                 _G.Reach = _G.Reach - 1 
                 game.StarterGui:SetCore("SendNotification", {
                 Title = "H0ndu's Reach v1";
                 Text = "Reach set to " .. _G.Reach;
                 Icon = "";
                 Duration = 0.3;})
             end
          end)
end)
local Section = PlayerTab:NewSection("Spin")
Section:NewButton("IY", "warring dont use all cmd or u get ban u can use spin and bang !!!", function()
     loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)
