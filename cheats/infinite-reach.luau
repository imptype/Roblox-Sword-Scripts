-- source https://scriptblox.com/script/Universal-Script-Sword-Fight-Script-14225
-- updated at < 20 june, 2024

--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
local Whitelist = {
    ["lolasdawdsawdolo"] = true,
}

local reach = 20

function Loop()
    while true do
        local player = game.Players.LocalPlayer

        local folder = workspace:FindFirstChild(player.Name)
        if not folder then
            wait(1)
            continue -- Skip to the next iteration of the loop
        end

        local tool = folder:FindFirstChildOfClass("Tool")
        if not tool then
            wait(1)
            continue -- Skip to the next iteration of the loop
        end

        local handle = tool:FindFirstChild("Handle")
        if not handle then
            wait(1)
            continue -- Skip to the next iteration of the loop
        end

        local function getDistance(point1, point2)
            return (point1 - point2).magnitude
        end

        local function hit(parts)
            local touchInterest = handle:FindFirstChildOfClass("TouchTransmitter")
            if touchInterest then
                for _, part in ipairs(parts) do
                    firetouchinterest(handle, part, 0)
                    firetouchinterest(handle, part, 1)
                end
            end
        end

        local Character = game.Players.LocalPlayer.Character
        local Health = Character.Humanoid.Health
        wait()
        if Health ~= 0 then
            local folder = workspace:FindFirstChild(player.Name)
            if not folder then
                wait(1)
                continue -- Skip to the next iteration of the loop
            end

            local tool = folder:FindFirstChildOfClass("Tool")
            if not tool then
                wait(1)
                continue -- Skip to the next iteration of the loop
            end

            if tool.Parent == folder then
                for _, targetPlayer in pairs(game.Players:GetPlayers()) do
                    if
                        targetPlayer ~= player
                        and targetPlayer.Character
                        and targetPlayer.Character:FindFirstChild("HumanoidRootPart")
                    then
                        local distance = getDistance(
                            player.Character.HumanoidRootPart.Position,
                            targetPlayer.Character.HumanoidRootPart.Position
                        )
                        if distance <= reach and not Whitelist[targetPlayer.Name] then
                            local hits = {}
                            local character = targetPlayer.Character
                            if character:FindFirstChild("Left Arm") then
                                table.insert(hits, character["Left Arm"])
                            end
                            if character:FindFirstChild("Right Arm") then
                                table.insert(hits, character["Right Arm"])
                            end
                            if character:FindFirstChild("Torso") then
                                table.insert(hits, character.Torso)
                            end
                            hit(hits)
                        end
                    end
                end
            end
        end

        wait()
    end
end

Loop()
