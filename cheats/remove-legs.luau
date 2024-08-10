-- source https://wearedevs.net/scripts/d/6108159cbc0ef711ad5cb776/Remove%20Legs
-- alt source https://cdn.wearedevs.net/scripts/Remove%20Legs.txt
-- updated at august 2, 2021

--[[
A distribution of https://wearedevs.net/scripts
Last updated August 2, 2021

Description: Removes your characters legs

Instruction: Inject this script into any game using a Lua executor like JJSploit. 
]]

character = game:GetService("Players").LocalPlayer.Character

--R6 Rigs
leftLeg = character:FindFirstChild("Left Leg")
if leftLeg then
    leftLeg:Destroy()
end
rightLeg = character:FindFirstChild("Right Leg")
if rightLeg then
    rightLeg:Destroy()
end

--R15 Rigs
leftUpperLeg = character:FindFirstChild("LeftUpperLeg")
if leftUpperLeg then
    leftUpperLeg:Destroy()
end
leftLowerLeg = character:FindFirstChild("LeftLowerLeg")
if leftLowerLeg then
    leftLowerLeg:Destroy()
end
leftFoot = character:FindFirstChild("LeftFoot")
if leftFoot then
    leftFoot:Destroy()
end
rightUpperLeg = character:FindFirstChild("RightUpperLeg")
if rightUpperLeg then
    rightUpperLeg:Destroy()
end
rightLowerLeg = character:FindFirstChild("RightLowerLeg")
if rightLowerLeg then
    rightLowerLeg:Destroy()
end
rightFoot = character:FindFirstChild("RightFoot")
if rightFoot then
    rightFoot:Destroy()
end
