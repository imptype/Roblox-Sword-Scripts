-- source https://pastebin.com/QxHGiJTt
-- updated at january 26, 2024

local player = game.Players.LocalPlayer

local tool = nil
while wait() do
    if player.Character then
        local character = player.Character
        tool = character:FindFirstChildOfClass("Tool")
        if tool and character then
            tool:Activate()
        end
    end
end
