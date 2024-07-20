-- source https://pastebin.com/n0k43HfR
-- updated at april 22, 2024

-- // Credits: Tactic / Scoper \\ --
-- Basic Sword Reach script for stay alive and flex your time on others
 
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
 
local Heartbeat = RunService.Heartbeat
 
Distance = 35
Damage = true
Blacklisted = {"LLeft Aarm"}
 
getgenv().Connection = Heartbeat:Connect(function()
    pcall(function()
        if Player and Player.Character and Player.Character:FindFirstChildOfClass("Tool") and Player.Character.Humanoid and Player.Character.Humanoid.Health > 0 then
            Player.Character:FindFirstChildOfClass("Tool"):Activate()
        end
                
        for _, Server in next, Players:GetPlayers() do
            if Server ~= Player then
                if Server.Character.Humanoid.Health > 0 then
                    if (Player.Character.HumanoidRootPart.Position - Server.Character.HumanoidRootPart.Position).Magnitude < Distance then
                        for _, Parts in next, Server.Character:GetChildren() do
                            if not table.find(Blacklisted, Parts.Name) then
                                if Damage then
                                    for Iter = 1, 10 do
                                        firetouchinterest(Player.Character:FindFirstChildOfClass("Tool").Handle, Parts, 0)
                                        firetouchinterest(Player.Character:FindFirstChildOfClass("Tool").Handle, Parts, 1)
                                    end
                                else
                                    firetouchinterest(Player.Character:FindFirstChildOfClass("Tool").Handle, Parts, 0)
                                    firetouchinterest(Player.Character:FindFirstChildOfClass("Tool").Handle, Parts, 1)
                                end
                            end
                        end
                    end
                end
            end
        end
    end)
end)
