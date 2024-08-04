-- source [discord user e12]
-- updated at august 8, 2024

-- Initialize Q-learning parameters
local alpha = 0.7
local gamma = 0.95
local epsilon = 0.2

-- Initialize Q-table (state-action values)
local QTable = {}

-- Initialize experience replay memory
local experienceMemory = {}
local maxMemorySize = 1000

-- Initialize kill counter
local killCounter = 0

-- Initialize saved movements
local savedMovements = {}

-- Initialize recent killer movements tracking
local recentKillerMovements = {}

-- Define state-action space size
local stateSize = 3  -- Example: (position, orientation, health)
local actionSize = 12  -- Number of actions

-- Function to get Q-value for a given state-action pair
local function getQValue(state, action)
    local key = tostring(state) .. "_" .. tostring(action)
    return QTable[key] or 0
end

-- Function to set Q-value for a given state-action pair
local function setQValue(state, action, value)
    local key = tostring(state) .. "_" .. tostring(action)
    QTable[key] = value
end

-- Function to save Q-values to a string
local function saveQValuesToString()
    local qValuesString = ""
    for key, value in pairs(QTable) do
        qValuesString = qValuesString .. key .. ":" .. value .. "\n"
    end
    return qValuesString
end

-- Function to load Q-values from a string
local function loadQValuesFromString(qValuesString)
    QTable = {}
    for line in qValuesString:gmatch("[^\r\n]+") do
        local key, value = line:match("([^:]+):(.+)")
        if key and value then
            QTable[key] = tonumber(value)
        end
    end
end

-- Function to save Q-values
local function saveQValues()
    local qValuesString = saveQValuesToString()
    print("Copy this string to save your Q-values:\n" .. qValuesString)
end

-- Function to load Q-values
local function loadQValues()
    print("Paste your saved Q-values string here:")
    local qValuesString = io.read() -- Read from console input or use a manual paste mechanism
    loadQValuesFromString(qValuesString)
end

-- Function to choose an action based on the epsilon-greedy policy
local function chooseAction(state)
    if math.random() < epsilon then
        return math.random(1, actionSize)
    else
        local bestAction = nil
        local maxQValue = -math.huge
        for action = 1, actionSize do
            local qValue = getQValue(state, action)
            if qValue > maxQValue then
                maxQValue = qValue
                bestAction = action
            end
        end
        return bestAction or 1
    end
end

-- Function to find the closest player
local function findClosestPlayer()
    local players = game:GetService("Players"):GetPlayers()
    local closestPlayer = nil
    local shortestDistance = math.huge
    local localPlayer = game.Players.LocalPlayer
    local character = localPlayer.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

    if not humanoidRootPart then
        return nil
    end

    for _, player in ipairs(players) do
        if player ~= localPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then
            local otherHumanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
            if otherHumanoidRootPart then
                local distance = (humanoidRootPart.Position - otherHumanoidRootPart.Position).magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    closestPlayer = player
                end
            end
        end
    end

    return closestPlayer
end

-- Function to evaluate the AI's performance
local function evaluateMovement(character, lastDistance, targetPosition)
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return lastDistance, 0 end

    local currentPosition = humanoidRootPart.Position
    local currentDistance = (currentPosition - targetPosition).magnitude

    local reward = 0

    -- Check for falling off the map (e.g., below Y = -50)
    local fallPunishmentThreshold = -50
    if currentPosition.Y < fallPunishmentThreshold then
        reward = -20
    elseif currentDistance < lastDistance then
        reward = 20
    else
        reward = -10
    end

    -- Reward for facing the player
    local forwardVector = humanoidRootPart.CFrame.LookVector
    local directionToTarget = (targetPosition - currentPosition).unit
    local dotProduct = forwardVector:Dot(directionToTarget)
    if dotProduct > 0.9 then
        reward = reward + 10
    end

    -- Reward for staying close and not taking damage
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid and humanoid.Health == humanoid.MaxHealth then
        local healthReward = 10
        reward = reward + healthReward
    end

    return currentDistance, reward
end

-- Function to make the AI jump
local function makeAIJump(character)
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid and not humanoid.Jump then
        humanoid.Jump = true
    end
end

-- Function to move randomly and learn
local function moveRandomly(character)
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    local action = chooseAction(character.HumanoidRootPart.Position)
    local movementVector = Vector3.new(0, 0, 0)
    local rotationVector = Vector3.new(0, 0, 0)

    -- Define movement directions and rotations based on action
    if action == 1 then
        movementVector = Vector3.new(0, 0, 10) -- Move forward
    elseif action == 2 then
        movementVector = Vector3.new(0, 0, -10) -- Move backward
    elseif action == 3 then
        movementVector = Vector3.new(-10, 0, 0) -- Move left
    elseif action == 4 then
        movementVector = Vector3.new(10, 0, 0) -- Move right
    elseif action == 5 then
        makeAIJump(character) -- Make the AI jump
    elseif action == 6 then
        rotationVector = Vector3.new(0, math.rad(30), 0) -- Rotate left
    elseif action == 7 then
        rotationVector = Vector3.new(0, math.rad(-30), 0) -- Rotate right
    elseif action == 8 then
        rotationVector = Vector3.new(0, math.rad(60), 0) -- Rotate more left
    elseif action == 9 then
        rotationVector = Vector3.new(0, math.rad(-60), 0) -- Rotate more right
    elseif action == 10 then
        -- Randomized movement and rotation
        movementVector = Vector3.new(math.random(-10, 10), 0, math.random(-10, 10))
        rotationVector = Vector3.new(0, math.random(-60, 60), 0)
    elseif action == 11 then
        -- Advanced movement: Combine forward and sideways movement
        movementVector = Vector3.new(math.random(-10, 10), 0, 10)
    elseif action == 12 then
        -- Advanced rotation with slight forward movement
        movementVector = Vector3.new(5, 0, 10)
        rotationVector = Vector3.new(0, math.random(-45, 45), 0)
    end

    -- Move AI
    if action <= 4 then
        local targetPosition = character.HumanoidRootPart.Position + movementVector
        humanoid:MoveTo(targetPosition)
    elseif action >= 6 then
        local bodyGyro = character:FindFirstChildOfClass("BodyGyro")
        if not bodyGyro then
            bodyGyro = Instance.new("BodyGyro", character.HumanoidRootPart)
            bodyGyro.MaxTorque = Vector3.new(4000, 4000, 4000)
            bodyGyro.P = 3000
        end
        bodyGyro.CFrame = character.HumanoidRootPart.CFrame * CFrame.Angles(rotationVector.X, rotationVector.Y, rotationVector.Z)
    end

    return action
end

-- Function to store experience in memory with prioritized replay
local function storeExperience(state, action, reward, nextState)
    table.insert(experienceMemory, {state = state, action = action, reward = reward, nextState = nextState})
    if #experienceMemory > maxMemorySize then
        table.remove(experienceMemory, 1) -- Remove oldest experience if memory exceeds size
    end
end

-- Function to update Q-values based on experience
local function updateQValues(state, action, reward, nextState)
    local oldQValue = getQValue(state, action)
    local maxNextQValue = -math.huge
    for nextAction = 1, actionSize do
        local qValue = getQValue(nextState, nextAction)
        if qValue > maxNextQValue then
            maxNextQValue = qValue
        end
    end
    local newQValue = oldQValue + alpha * (reward + gamma * maxNextQValue - oldQValue)
    setQValue(state, action, newQValue)
end

-- Function to replay experiences with prioritized sampling
local function replayExperiences()
    -- Sort experiences by reward (descending)
    table.sort(experienceMemory, function(a, b)
        return a.reward > b.reward
    end)
    for _, experience in ipairs(experienceMemory) do
        updateQValues(experience.state, experience.action, experience.reward, experience.nextState)
    end
end

-- Function to handle AI behavior
local function handleAIBehavior()
    local character = game.Players.LocalPlayer.Character
    if not character then return end

    local targetPlayer = findClosestPlayer()
    if not targetPlayer or not targetPlayer.Character then return end
    local targetHumanoidRootPart = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not targetHumanoidRootPart then return end
    local targetPosition = targetHumanoidRootPart.Position
    local lastDistance = (character.HumanoidRootPart.Position - targetPosition).magnitude

    local lastPrintTime = tick()
    while true do
        if not character or not character:FindFirstChild("Humanoid") or not character:FindFirstChild("HumanoidRootPart") then break end
        local action = moveRandomly(character)
        table.insert(savedMovements, {action = action, position = character.HumanoidRootPart.Position})
        wait(0.1) -- Move every 0.1 seconds
        local newDistance, reward = evaluateMovement(character, lastDistance, targetPosition)

        storeExperience(character.HumanoidRootPart.Position, action, reward, character.HumanoidRootPart.Position)
        replayExperiences()

        lastDistance = newDistance

        -- Print information every 1 second
        if tick() - lastPrintTime >= 1 then
            print("Current state-action Q-values:")
            for key, value in pairs(QTable) do
                print(key, value)
            end
            print("Total Kills: " .. killCounter)
            lastPrintTime = tick()
        end
    end
end

-- Monitor character respawn
local function onCharacterAdded(character)
    -- Wait until the character is fully loaded
    repeat wait() until character:FindFirstChild("Humanoid") and character:FindFirstChild("HumanoidRootPart")
    handleAIBehavior()
end

-- Function to track movements and orientations of the player who kills the AI
local function trackKillerMovements(player)
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end

    recentKillerMovements = {} -- Clear previous movements
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

    -- Track movements and orientations for a short period
    local trackDuration = 5 -- Increased duration for more movement data
    local startTime = tick()
    while tick() - startTime < trackDuration do
        table.insert(recentKillerMovements, {
            CFrame = humanoidRootPart.CFrame,
            Position = humanoidRootPart.Position,
            Orientation = humanoidRootPart.Orientation
        })
        wait(0.1) -- Track every 0.1 seconds
    end
end

-- Function to handle player deaths
local function onPlayerDeath(player)
    if player == game.Players.LocalPlayer then
        -- Local player has died; apply punishment
        print("Local player has died. Applying punishment.")
        local state = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
        updateQValues(state, 1, -20, state) -- Increased punishment
    else
        -- Track killer's movements
        trackKillerMovements(player)
        local state = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
        updateQValues(state, 1, 20, state) -- Increased reward
        killCounter = killCounter + 1
    end
end

-- Connect to the character added event
local localPlayer = game.Players.LocalPlayer
localPlayer.CharacterAdded:Connect(onCharacterAdded)

-- Connect to the humanoid died event
game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Died:Connect(function()
                onPlayerDeath(player)
            end)
        end
    end)
end)

-- Handle key presses for saving/loading Q-values
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end
    if input.KeyCode == Enum.KeyCode.X then
        saveQValues() -- Save Q-values when X is pressed
    elseif input.KeyCode == Enum.KeyCode.V then
        loadQValues() -- Load Q-values when V is pressed
    end
end)

-- Start the behavior if the character already exists
if localPlayer.Character then
    onCharacterAdded(localPlayer.Character)
end
