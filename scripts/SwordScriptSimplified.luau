-- A simplified version of the original SwordScript.luau by me

--Rescripted by Luckymaxer
--EUROCOW WAS HERE BECAUSE I MADE THE PARTICLES AND THEREFORE THIS ENTIRE SWORD PRETTY AND LOOK PRETTY WORDS AND I'D LIKE TO DEDICATE THIS TO MY FRIENDS AND HI LUCKYMAXER PLS FIX SFOTH SWORDS TY LOVE Y'ALl
--Updated for R15 avatars by StarWars
--Re-updated by TakeoHonorable

RunService = game:GetService("RunService")

Tool = script.Parent
Handle = Tool:WaitForChild("Handle")

DamageValues = {
	BaseDamage = 5,
	SlashDamage = 10,
	LungeDamage = 30
}

Damage = DamageValues.BaseDamage

Grips = {
	Up = CFrame.new(0, 0, -1.70000005, 0, 0, 1, 1, 0, 0, 0, 1, 0),
	Out = CFrame.new(0, 0, -1.70000005, 0, 1, 0, 1, -0, 0, 0, 0, -1)
}

ToolEquipped = false
Tool.Grip = Grips.Up
Tool.Enabled = true
LastAttack = 0

Tool.Activated:Connect(function()
	if not Tool.Enabled or not ToolEquipped or Tool.Parent.Humanoid.Health == 0 then
		return
	end
	Tool.Enabled = false
	local Tick = RunService.Stepped:wait()
	if (Tick - LastAttack < 0.2) then
		Damage = DamageValues.LungeDamage
		if Tool.Parent then
			local Anim = Instance.new("StringValue")
			Anim.Name = "toolanim"
			Anim.Value = "Lunge"
			Anim.Parent = Tool
		end
		wait(0.2)
		Tool.Grip = Grips.Out
		wait(0.6)
		Tool.Grip = Grips.Up
		Damage = DamageValues.SlashDamage
	else
		Damage = DamageValues.SlashDamage
		if Tool.Parent then
			local Anim = Instance.new("StringValue")
			Anim.Name = "toolanim"
			Anim.Value = "Slash"
			Anim.Parent = Tool
		end	
	end
	LastAttack = Tick
	Damage = DamageValues.BaseDamage
	Tool.Enabled = true
end)

Tool.Equipped:Connect(function()
	if Tool.Parent.Humanoid.Health == 0 then
		return
	end
	ToolEquipped = true
end
)

Tool.Unequipped:Connect(function()
	Tool.Grip = Grips.Up
	ToolEquipped = false
end)

Handle.Touched:Connect(function(Hit)
	if not Hit or not Hit.Parent or Tool.Parent.Humanoid.Health == 0 or not ToolEquipped then
		return
	end
	local RightArm = Tool.Parent:FindFirstChild("Right Arm") or Tool.Parent:FindFirstChild("RightHand")
	if not RightArm then
		return
	end
	local RightGrip = RightArm:FindFirstChild("RightGrip")
	if not RightGrip or (RightGrip.Part0 ~= Handle and RightGrip.Part1 ~= Handle) then
		return
	end
	local character = Hit.Parent
	if character == Tool.Parent then
		return
	end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid or humanoid.Health == 0 then
		return
	end
	humanoid:TakeDamage(Damage)	
end)
