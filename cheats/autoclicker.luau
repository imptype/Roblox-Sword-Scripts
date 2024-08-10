-- source https://www.youtube.com/watch?v=y7sSkTDGN9o&lc=Ugx3op5Ndrqn97u_tjl4AaABAg
-- updated at < july 20, 2021

-- bypass:
local AC = false
local Key = Enum.KeyCode.V

game:GetService("UserInputService").InputBegan:Connect(function(k, g)
    if not g and k.KeyCode == Key then
        AC = not AC
    end
end)

while wait() do
    if AC then
        pcall(function()
            local Sword = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool")
            Sword:Activate()
            Sword:Activate()
        end)
    end
end
