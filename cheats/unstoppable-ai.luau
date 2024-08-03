-- source https://pastebin.com/aUVmhcZx
-- updated at july 28, 2024

local Funcs = {}
 
 
 
--strategy that you jump (when you can run away in a straight line) while opponent's lunge is down
 
--strategy that you walk around the opponent while running away
 
--don't go after the left side if the opponent is hugging the wall
--don't spam hit while not in range (gives opportunity for enemy to attack while lunge is down)
--make it go closer when the opponent's attack is on cooldown
--realize that once it's being attacked, if the opponent is plays optimally it can't dodge so try maneuvers while attacking
--make it not attempt to back off when it's already being hit
--back off when lunging Almost over and down
 
--detecting when enemy is about to lunge doesn't work
 
 
 
local GetXDist = function(Pos1, Pos2)
	return math.sqrt((Pos1.X - Pos2.X)^2+(Pos1.Z - Pos2.Z)^2)
end
 
local FairLookAt = function(Pos1, Pos2)
	return CFrame.lookAt(Pos1, (Pos2 - Vector3.new(0,Pos2.Y - Pos1.Y,0))) * CFrame.Angles(0,math.rad(17.5),0)
end
Funcs.VisualizePosition = function(Position)
	local Part = Instance.new("Part")
	Part.Position = Position
	Part.CanCollide = false
	Part.Parent = workspace.Filter
	Part.Size = Vector3.new(0.1,0.1,0.1)
	Part.Anchored = true
end
 
local GetDist = function(Model, Position)
	return (Model["Right Arm"].Position - Position).Magnitude
end
local VisualizePosition = function(Position)
	local Part = Instance.new("Part")
	Part.Position = Position
	Part.CanCollide = false
	Part.Parent = workspace.Filter
	Part.Size = Vector3.new(0.1,0.1,0.1)
	Part.Anchored = true
end
 
local function GetDist(Model, Position)
	return (Model["Right Arm"].Position - Position).Magnitude
end
 
function FindBestAngle(Model, Enemy, EnemyTool)
 
	local Params = RaycastParams.new()
	Params.FilterType = Enum.RaycastFilterType.Blacklist
	Params.FilterDescendantsInstances = {Model, EnemyTool, table.unpack(Enemy.Humanoid:GetAccessories()),}
 
	local Raycasts = {}
	table.insert(Raycasts, {workspace:Raycast(Model["Right Arm"].Position, Model.PrimaryPart.CFrame.LookVector*10, Params), 0})
	table.insert(Raycasts, {workspace:Raycast(Model["Right Arm"].Position, (Model.PrimaryPart.CFrame * CFrame.Angles(0,-math.rad(1),0)).LookVector.Unit*10, Params), -1})
	table.insert(Raycasts, {workspace:Raycast(Model["Right Arm"].Position, (Model.PrimaryPart.CFrame * CFrame.Angles(0,math.rad(1),0)).LookVector.Unit*10, Params), 1})
	table.insert(Raycasts, {workspace:Raycast(Model["Right Arm"].Position, (Model.PrimaryPart.CFrame * CFrame.Angles(0,math.rad(2),0)).LookVector.Unit*10, Params), 2})
	table.insert(Raycasts, {workspace:Raycast(Model["Right Arm"].Position, (Model.PrimaryPart.CFrame * CFrame.Angles(0,-math.rad(2),0)).LookVector.Unit*10, Params), -2})
	--	workspace.Filter:ClearAllChildren()
	local ClosestDistance = math.huge
	local ClosestAngle = 0
	local ClosestPos = nil
	for i,v in pairs(Raycasts) do 
		if v[1] then
			local Dist = GetDist(Model, v[1].Position)
 
			if Dist < ClosestDistance then
				ClosestDistance = Dist
				ClosestAngle = v[2]
				ClosestPos = v.Position
			end
		end
	end
 
 
 
	return ClosestAngle
 
end
 
local  GetClosestEnemy = function(Model)
	local FF = false
 
	local maxdist = 100000
	local nearest = nil
	local childrentable = workspace:GetChildren()
 
	for i,v in pairs(childrentable) do
		if v:IsA("Folder") or v:IsA("Model") then
			for _,v2 in pairs(v:GetChildren()) do
				table.insert(childrentable,v2)
			end		
		end
	end
	for i,v in pairs(childrentable) do
		if v:IsA("Model") then
			if v:FindFirstChildOfClass("Humanoid") then
				if v:FindFirstChildOfClass("Humanoid").RootPart  then
					if v ~= Model then
						local root  = v:FindFirstChildOfClass("Humanoid").RootPart
						local dist = (root.Position-Model.HumanoidRootPart.Position).Magnitude
						if v:FindFirstChildOfClass("Humanoid"):GetState() ~= Enum.HumanoidStateType.Dead  then
							if  (not v:FindFirstChildOfClass("ForceField") or FF) then
								if dist < maxdist  then
									maxdist = dist
									nearest = v
								end
							end
						end
					end
				end
			end
		end
	end
	return nearest
 
 
end
 
local GetDistance = function (Model, OtherModel)
	return (Model.PrimaryPart.Position - OtherModel.PrimaryPart.Position).Magnitude
end
 
local GetClosestPart = function(Position, OtherModel)
	local ClosestPart = nil
	local ClosestDistance = math.huge
	for i,v in pairs(OtherModel:GetChildren()) do 
		if v:IsA("BasePart") then 
			local Offset = Vector3.new(0,0,0)
			if v.Name == "Right Arm" then 
 
				Offset = OtherModel.PrimaryPart.CFrame.LookVector*3
			end
			local Dist = (Position - (getpos(v)+Offset)).Magnitude
			if Dist < ClosestDistance then
				ClosestDistance = Dist
				ClosestPart = v
			end
		end
	end
 
	return ClosestPart
end
GetRetreatDirection = function(Model, ClosestEnemy, Dist)
	local Difference = (Model.PrimaryPart.Position - getpos(ClosestEnemy.PrimaryPart))
	local Params = RaycastParams.new()
	Params.FilterType = Enum.RaycastFilterType.Blacklist
	Params.FilterDescendantsInstances = getplayers()
	-- must be 10 for now otherwise it might run towards the player
	-- maybe increase to 100 when the closest hit is <10? that way it knows when it's getting cornered
	--local Dist = 10 
	local Angle = -135
	local BestDist = 0
	local BestPosition = nil
	local Raycasts = 10
	for i = 1, Raycasts do
		local Raycast = workspace:Raycast(Model.PrimaryPart.Position, (CFrame.lookAt(Model.PrimaryPart.Position, Model.PrimaryPart.Position + Difference)*CFrame.Angles(0,math.rad(Angle),0)).LookVector*Dist, Params)
 
		if Raycast then 
			local Dist = (Raycast.Position - getpos(ClosestEnemy.PrimaryPart)).Magnitude
			if Dist > BestDist then 
				BestPosition = Raycast.Position
				BestDist = Dist
			end
		end
 
		Angle += 270/Raycasts
 
	end
 
	return BestPosition
end
function getplayers()
	local childrentable = workspace:GetChildren()
	local players ={}
	for i,v in pairs(childrentable) do
		if v:IsA("Folder") or v:IsA("Model") then
			for _,v2 in pairs(v:GetChildren()) do
				table.insert(childrentable,v2)
			end		
		end
	end
	for i,v in pairs(childrentable) do
		if v:IsA("Model") then
			if v:FindFirstChildOfClass("Humanoid") then
				if v:FindFirstChildOfClass("Humanoid").RootPart  then
					local root  = v:FindFirstChildOfClass("Humanoid").RootPart
					table.insert(players,v)
				end
			end
		end
	end
	return players
end
SideCast = function(ClosestEnemy)
	local Params = RaycastParams.new()
	Params.FilterType = Enum.RaycastFilterType.Blacklist
	Params.FilterDescendantsInstances = getplayers()
	local Angle = 0
	local BestDist = 0
	local BestPosition = nil
	local Raycasts = 10
	for i = 1,Raycasts do 
		local Raycast = workspace:Raycast(getpos(ClosestEnemy.PrimaryPart), (ClosestEnemy.PrimaryPart.CFrame * CFrame.Angles(0,math.rad(Angle),0)).LookVector*8, Params)
		Angle += 360/Raycasts
		if Raycast then 
			return Raycast
		end
	end
 
 
end
 
 
Grips = {
	Up = CFrame.new(0, 0, -1.70000005, 0, 0, 1, 1, 0, 0, 0, 1, 0),
}
 
 
 
 
return function(Model)
	local Humanoid:Humanoid = Model.Humanoid
	local PrimaryPart = Model.PrimaryPart
	local Tool = Model:FindFirstChildOfClass("Tool")
	if not Tool then 
		repeat Tool = Model:FindFirstChildOfClass("Tool"); wait() until Tool
	end
	wait(1)
	Grips.Up = Tool.Grip
	print(Grips.Up)
	local Tick = 0
	local LastAttack = 0
	local LastOpponentAttack = 0
	local EnemyExtended = false
	local LastJump = 0
	local attackjump = 0
	local angle = math.random(-95,95)
	local regtick = tick()
	local randomize = Random.new():NextNumber(2,5)
	local jump2 = 0
	local lastoppattack = 0
	function getpos(Main)
		--if Model.Name == "BOT" then
		--	return Main.Position
		--end
		return Main.Position+(Main.Velocity/10)
	end
	Humanoid.StateChanged:Connect(function(old,new)
		if new == Enum.HumanoidStateType.Jumping then
			jump2 = Tick
		end
	end)
	while Model.PrimaryPart and Humanoid.Health > 0 do  
		local jumpPower = Humanoid.JumpPower
		local gravity = workspace.Gravity
		local t_up = jumpPower / gravity
		local t_down = math.sqrt((2 * jumpPower^2) / (gravity^2))
		local totalJumpTime = t_up + t_down
		local function jump()
			--local jumpPower = Humanoid.JumpPower
			--local gravity = workspace.Gravity
			--local t_up = jumpPower / gravity
			--local t_down = math.sqrt((2 * jumpPower^2) / (gravity^2))
			--local totalJumpTime = t_up + t_down
			if Tick-jump2 >= totalJumpTime then
				Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
				jump2 = Tick
			end
		end
 
 
 
		angle = math.random(-95,95)
		task.wait()
		Tick = tick()-regtick
		Tool = Model:FindFirstChildOfClass("Tool")
		if not Tool then 
			repeat Tool = Model:FindFirstChildOfClass("Tool"); wait() until Tool
		end
 
		local ClosestEnemy = GetClosestEnemy(Model)
 
		if ClosestEnemy then 
			if ClosestEnemy.PrimaryPart == nil then
				ClosestEnemy.PrimaryPart = ClosestEnemy:FindFirstChild("HumanoidRootPart")
			end
			local ClosestPart = GetClosestPart(Tool.Handle.Position, ClosestEnemy)
			local EnemyTool = ClosestEnemy:FindFirstChildOfClass("Tool")
 
			local LungeCooldown = false
			if EnemyTool then 
				if EnemyTool.Grip ~= Grips.Up then
					if EnemyExtended == false then 
						LastOpponentAttack = Tick
					end
					lastoppattack = Tick
					EnemyExtended = true
				end
			end
			if ClosestEnemy.Name ==  'Zombie' then
				EnemyExtended = true
			end
			if Tool.Grip == Grips.Up then
				LungeCooldown = true
				--print("cooldown")
			end
			local HigherHp = Model.Humanoid.Health > ClosestEnemy.Humanoid.Health
			local LowerHp = Model.Humanoid.Health < ClosestEnemy.Humanoid.Health
			local XDist = GetXDist(Model.PrimaryPart.Position, getpos(ClosestEnemy.PrimaryPart))
			local Distance = GetDistance(Model, ClosestEnemy)
			local HeightDifference = math.abs(getpos(ClosestEnemy.PrimaryPart).Y - Model.PrimaryPart.Position.Y)
			local SameHeight = HeightDifference < 3
 
			local ClosestPos = getpos(ClosestEnemy.PrimaryPart)
			--LungingGui.BackgroundColor3 = EnemyExtended and Color3.new(0.0470588, 1, 0) or Color3.new(1, 1, 1)
 
			if EnemyExtended and LungeCooldown and SameHeight and Distance > 6 and EnemyTool then 
				--Tool.Grip = Grips.Up
 
				Model:SetPrimaryPartCFrame(FairLookAt(PrimaryPart.Position, EnemyTool.Handle.Position+ ClosestEnemy.PrimaryPart.CFrame.LookVector*EnemyTool.Handle.Size.Y*2.2))
			else 
 
				Tool.Parent = Model
 
 
				Model:SetPrimaryPartCFrame(CFrame.lookAt(PrimaryPart.Position, (getpos(ClosestPart) - Vector3.new(0,getpos(ClosestPart).Y - PrimaryPart.Position.Y,0))) * CFrame.Angles(0,math.rad(17.5),0))
				local Angle = 0
				local LastAngle = Angle
				--points sword towards closest position on part
				for i = 1, 10 do
					Angle = Angle + FindBestAngle(Model, ClosestEnemy, EnemyTool)
					if LastAngle == Angle then 
						-- the wiggle to trigger touched
						if HigherHp then
							Angle += math.random(-25,25)
						else 
							Angle += math.random(-2,2)
						end
						Model:SetPrimaryPartCFrame(CFrame.lookAt(PrimaryPart.Position, (getpos(ClosestPart) - Vector3.new(0,getpos(ClosestPart).Y - PrimaryPart.Position.Y,0))) * CFrame.Angles(0,math.rad(17.5 + Angle),0))
						break
					end
					LastAngle = Angle
					Model:SetPrimaryPartCFrame(CFrame.lookAt(PrimaryPart.Position, (getpos(ClosestPart) - Vector3.new(0,getpos(ClosestPart).Y - PrimaryPart.Position.Y,0))) * CFrame.Angles(0,math.rad(17.5 + Angle),0))
				end
			end 
 
			local EnemyToModelVector = (Model.PrimaryPart.Position - getpos(ClosestEnemy.PrimaryPart)).Unit
			local MoveDirection = ClosestEnemy.Humanoid.MoveDirection
			local EnemyIsMovingTowardsModel = (EnemyToModelVector - MoveDirection).Magnitude < 1
			--goes really aggresive when enemy is on cooldown
			local IdealDistance = EnemyExtended and 8 or 7
			--backs off
			IdealDistance += EnemyIsMovingTowardsModel and 3 or 0
			--detects when last lunged
			--and (Tick - LastAttack > 0.2) -- putting this here for science
			if Tool.Enabled and Tool.Grip ~= Grips.Up then
 
				LastAttack = Tick
			end
			--pushes when enemy is about to run out of lunge (hopefully)
			if EnemyTool and not EnemyTool.Enabled and (Tick - LastOpponentAttack > 0.1) and not (Tick - LastOpponentAttack < 0.2) and  (Tick - LastAttack > 0.05) then 
				IdealDistance -= 23
				--	print("Enemy Attack")
			end
			--EnemyExtended = false
			--backs off when about to stop lunging
			if (Tick - LastAttack > 0.5) then
 
 
				IdealDistance += 8
			end
			if XDist < 15 then
				Tool:Activate()
				if EnemyTool then
					if  Tool.Grip ~= Grips.Up   and Tick-lastoppattack > 1 then
						jump()
						LastJump = Tick
					end
				end
			end
			if Distance > 11 then
				if LowerHp then 
					IdealDistance += 10
				end
			end
			--local SpacedPosition = getpos(ClosestEnemy.PrimaryPart) - (getpos(ClosestEnemy.PrimaryPart) - PrimaryPart.Position).Unit*IdealDistance
			local Offset = -ClosestEnemy.PrimaryPart.CFrame.RightVector
			local SideCast2 = SideCast(ClosestEnemy)
			if HigherHp and SameHeight then 
				Offset*= 3
				IdealDistance = 2
			end
			if SideCast2 or Tool.Grip == Grips.Up then 
				Offset = Vector3.new(0,0,0)
			end
			--using closestpos could be counterintuitive because it uses the root part's magnitude (so it's simpler to calculate range) but it gets applied to the closest part which might not work in all situations
			--favoring the side without the sword
			if Tick-jump2 <= totalJumpTime and XDist > 11 and EnemyTool then
				local Angle = 0
				local LastAngle = Angle
				--points sword towards closest position on part
				for i = 1, 10 do
					Angle = Angle + FindBestAngle(Model, ClosestEnemy, EnemyTool)
					if LastAngle == Angle then 
						-- the wiggle to trigger touched
 
						Angle += math.random(-25,25)
 
						--Angle += math.random(-2,2)
 
						Model:SetPrimaryPartCFrame(CFrame.lookAt(PrimaryPart.Position, (getpos(ClosestPart) - Vector3.new(0,getpos(ClosestPart).Y - PrimaryPart.Position.Y,0))) * CFrame.Angles(0,math.rad(17.5 + Angle),0))
						break
					end
					LastAngle = Angle
					Model:SetPrimaryPartCFrame(CFrame.lookAt(PrimaryPart.Position, (getpos(ClosestPart) - Vector3.new(0,getpos(ClosestPart).Y - PrimaryPart.Position.Y,0))) * CFrame.Angles(0,math.rad(17.5 + Angle),0))
				end
			end
			local SpacedPosition = (ClosestPos - (ClosestPos - PrimaryPart.Position).Unit*IdealDistance) + Offset
			if HigherHp then 
				Offset*= 3
				--SpacedPosition = ClosestEnemy["Left Arm"].Position  + Offset
			end
			if  Tick - lastoppattack < 1.2 then
				IdealDistance -= 10
			end
			if Distance < IdealDistance  then 
				local RetreatPos = GetRetreatDirection(Model, ClosestEnemy,10)
				if RetreatPos and EnemyIsMovingTowardsModel then 
					RetreatPos = GetRetreatDirection(Model, ClosestEnemy,100)
					Humanoid:MoveTo(RetreatPos)
				else
 
					Humanoid:MoveTo(SpacedPosition)
				end
			else 
 
				Humanoid:MoveTo(SpacedPosition)
			end
			if ClosestEnemy.PrimaryPart.AssemblyLinearVelocity.Magnitude < 10 and not EnemyExtended then
				IdealDistance -= 1
				Humanoid:MoveTo(getpos(ClosestEnemy.PrimaryPart))
			end
			--	if (Tick - attackjump) > randomize and (Tick - LastOpponentAttack) > 1.0 and SameHeight then
			--	if not SideCast2 then
			--	Humanoid:MoveTo(getpos(ClosestEnemy.PrimaryPart)+ClosestEnemy.PrimaryPart.CFrame.LookVector*-6)
			--jump()
			--	if Tick - attackjump > randomize+0.5 then
			--	attackjump = Tick
			--	elseif (Tick - LastOpponentAttack) < 1.0 then
			--		jump()
			--	end
			--	end
			--	end
		end
	end
end
