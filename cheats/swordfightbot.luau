-- source https://pastebin.com/N5cvSYdm
-- updated at september 11, 2023

-- Function to reload the script
local function reloadScript()
    -- Disconnect existing connections (e.g., "X" and "Z" key listeners)
    if getgenv().keyConnection then
        getgenv().keyConnection:Disconnect()
    end

    -- Clear any existing state
    getgenv().i_said_right_foot_creep = false
    getgenv().isRetreating = false

    -- Reload the script by running it again
    loadstring(game:HttpGet("https://path_to_your_script_here.lua"))() -- Replace with the actual script URL or path
end

-- Listen for the "Z" key to reload the script
getgenv().keyConnection = game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Z then
        reloadScript()
    end
end)

-- Define a threshold for low HP (adjust as needed)
local lowHPThreshold = 1 -- Set this to the desired threshold

getgenv().i_said_right_foot_creep = false
getgenv().isRetreating = false

game:GetService("RunService").RenderStepped:Connect(function()
    if i_said_right_foot_creep == true and not getgenv().isRetreating then
        spawn(function()
            local tool = game.Players.LocalPlayer.Character
                and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
            if tool and tool:FindFirstChild("Handle") then
                tool:Activate()
            end
        end)
    end
end)

local localPlayer = game:GetService("Players").LocalPlayer
local currentCamera = game:GetService("Workspace").CurrentCamera
local mouse = localPlayer:GetMouse()

local function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge

    for i, v in pairs(game:GetService("Players"):GetPlayers()) do
        if v.Name ~= localPlayer.Name then
            if
                v.Character
                and v.Character:FindFirstChild("Humanoid")
                and v.Character.Humanoid.Health > 0
                and v.Character:FindFirstChild("HumanoidRootPart")
                and v.Character:FindFirstChild("Head")
            then
                if v.Character:FindFirstChildOfClass("ForceField") then
                else
                    local ray =
                        Ray.new(v.Character:FindFirstChild("HumanoidRootPart").Position, Vector3.new(0, -100000, 0))
                    local Hit = game:GetService("Workspace"):FindPartOnRay(ray, v.Character)
                    if Hit then
                        local magnitude = (
                            v.Character.HumanoidRootPart.Position - localPlayer.Character.HumanoidRootPart.Position
                        ).magnitude
                        if magnitude < shortestDistance then
                            closestPlayer = v
                            shortestDistance = magnitude
                        end
                    end
                end
            end
        end
    end
    return closestPlayer
end

while true do
    wait()
    spawn(function()
        if executed then
        else
            getgenv().executed = true
            spawn(function()
                getgenv().i_said_right_foot_creep = false
                getgenv().ssss = game.Players.LocalPlayer:GetMouse()

                ssss.KeyDown:connect(function(key)
                    if key == "x" then
                        if i_said_right_foot_creep == false then
                            getgenv().i_said_right_foot_creep = true
                            game:GetService("Players").LocalPlayer.Character
                                :FindFirstChildOfClass("Humanoid").AutoRotate =
                                false
                        else
                            getgenv().i_said_right_foot_creep = false
                            game:GetService("Players").LocalPlayer.Character
                                :FindFirstChildOfClass("Humanoid").AutoRotate =
                                true
                        end
                    end
                end)
            end)
        end
    end)

    local myCharacter = game:GetService("Players").LocalPlayer.Character
    local myHumanoid = myCharacter:FindFirstChildOfClass("Humanoid")

    -- Check if HP is low and not already retreating
    if myHumanoid.Health < lowHPThreshold and not getgenv().isRetreating then
        getgenv().isRetreating = true

        -- Find a safe location to retreat to (you can modify this logic)
        local safeLocation = myCharacter.HumanoidRootPart.Position -- Corrected typo here

        -- Move the character away from danger with smooth animation
        local humanoidRootPart = myCharacter:WaitForChild("HumanoidRootPart")
        local goal = {}
        goal.Position = safeLocation
        local moveTo = myHumanoid:MoveTo(goal)
        moveTo.MaxSpeed = 16 -- Adjust speed as needed

        -- You can add additional logic to wait until you're safe to resume your previous behavior
        -- For example, you might want to wait until your HP is back above the threshold.
        repeat
            wait()
        until myHumanoid.Health >= lowHPThreshold

        getgenv().isRetreating = false
    end

    local balls = getClosestPlayer()
    if myCharacter.PrimaryPart and balls and i_said_right_foot_creep == true then
        local TargetPart = balls.Character.HumanoidRootPart
        local Part = myCharacter.HumanoidRootPart

        -- Increase turning speed by adjusting the lerpFactor
        local desiredCFrame = CFrame.new(Part.Position, TargetPart.Position)
            * CFrame.Angles(math.rad(0), math.rad(25), math.rad(0))
        local lerpFactor = 1 -- Increase this value for faster turning
        Part.CFrame = Part.CFrame:Lerp(desiredCFrame, lerpFactor)

        -- Smoothly move towards the target
        local targetPosition = balls.Character.HumanoidRootPart.Position
            - myCharacter.HumanoidRootPart.CFrame.lookVector * 3
        myHumanoid:MoveTo(Vector3.new(targetPosition.x, myCharacter.HumanoidRootPart.Position.y, targetPosition.z))

        -- Adjust WalkSpeed based on whether the player is jumping
        if myHumanoid:GetState() == Enum.HumanoidStateType.Seated then
            myHumanoid.WalkSpeed = 16 -- WalkSpeed when not jumping
        else
            myHumanoid.WalkSpeed = 16 -- Adjust speed when jumping
        end
    end
end
