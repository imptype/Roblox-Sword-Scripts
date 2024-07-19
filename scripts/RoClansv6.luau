-- Entry point for the custom sword https://create.roblox.com/store/asset/4544019605/LinkedSword-RoClans
-- Designed by Lametta but not widely used probably because it's too overwhelming, over 10,000 lines of code really...
-- Updated at Apr 17, 2024

--[[ ROCLANS V6 ]]--

warn(
	[[
		USE THE ROCLANS PLUGIN FOR EASIER SETUP AND AUTOMATIC UPDATES:
		https://create.roblox.com/marketplace/asset/15117387671/RoClans-Plugin
	]])

-- DO NOT REMOVE THIS SCRIPT.


--[[***********DEFAULT SETTING FOR ROCLANS IS CURRENTLY LINKEDSWORD - YOU CAN SET ROCLANSENABLED TO TRUE FROM SETTINGS***********

		   /\                                                         /\
 _         )( ______________________           ______________________ )(         _
(_)///////(**)______________________> ROCLANS <______________________(**)\\\\\\\(_)
           )(                                                         )(
           \/                                                         \/
		
		  ]..[ BASIC SET UP ]..[
		  
	1) KEEP ROCLANS INSIDE OF WORKSPACE.
	
	2) PUT THE "RCSWORD" FROM OUR STARTERPACK TO THE GAME STARTERPACK OR WHERE YOUR SWORD CAN BE OBTAINED.
	
	3) ON THE TOP BAR OF STUDIO, GO TO "HOME" > GO TO "GAME SETTINGS" > GO TO "SECURITY" > ENABLE ALL 4 OPTIONS.
		NOTE: IF YOU NEED HELP OR FEEL YOUR GAME MAY BE VULNERABLE BY ENABLING THOSE OPTIONS - MESSAGE LAMETTA AT ANY TIME.
		
	4) GO TO "SETTINGS" IN THE ROCLANS FOLDER. ADJUST THE SETTINGS THE WAY YOU WANT.
		NOTE: DETAILS ON SETTINGS CAN BE FOUND BELOW.
		
	5) THAT'S IT! YOU'RE DONE. FEEL FREE TO READ THE ADVANCED SET UP BELOW.
	
	6) NEED HELP? CONTACT US OR USE THE NEW SETUP PLUGIN: https://create.roblox.com/marketplace/asset/15117387671/RoClans-Plugin
	
	
		]..[ ADVANCED SET UP ]..[
	
	 THIS DOCUMENT WILL INSTRUCT YOU ON PROPER USE OF THE MODEL AND PROVIDE EXPLANATIONS FOR EACH FEATURE.
 
 NOTE: ROCLANS MODE IS NOT MADE FOR ALL TYPES OF PLACES. CHECK VIABILITY:
 - Ask for assistance if your place already uses a lot of complex loops (such as part rotations and increment changes).
 - Ask for assistance if you are trying to implement this sword into a place with multiple weapons.
 - Ask for assistance if your place has a high usage of memory (sword quality may be reduced).
 - Consider whether or not you use RoClans mode if the amount of players in your game exceeds 50 (high player amounts are in experimental phase).
 IF ANY OF THE ABOVE APPLY TO YOU, GO TO SETTINGS > CORE AND DISABLE BOTH VALUES IN IT TO TURN THIS INTO A NORMAL SWORD.
 
 YOU CAN ALSO USE THIS AS AN ACCURACY CORRECTION SYSTEM WITHOUT THE NEED OF A SWORD.
 IF YOU WANT TO USE THIS FOR ACCURACY PURPOSES ONLY, GO TO CORE_OPTIONS IN SETTINGS AND TURN "ONLYCORRECTIONENABLED" TO TRUE AND
 SET ROCLANSENABLED TO FALSE. THEN REMOVE SWORD FROM PACK.
 
 IF YOU NEED HELP FOR SOME REASON, CONTACT LAMETTA IN /ROCLANS OR LOOK UP THE ROCLANS SET UP VIDEO(S) ON YOUTUBE.
  
 [ EXPLAINING FEATURES ]
 - ROCLANSENABLED: WARNING - DISABLING THIS FEATURE WILL REVERT THE ROCLANS SWORD TO A NORMAL LINKEDSWORD. NORMAL
 	LINKEDSWORDS ARE VULNERABLE TO EXPLOITS. FEATURES THAT SPECIFICALLY REQUIRE ROCLANSENABLED WILL ALSO BE DISABLED.
 		INCLUDING [WARNINGS; PERFORMANCE; DEFAULT; TRACKMETHOD; ANTI-SPEED]
 - ACCURACYENABLED: WARNING - DISABLING THIS FEATURE WILL DISABLE THE ROCLANSENABLED FEATURE, AS ROCLANS REQUIRES THE
 	ACCURACY SYSTEM TO WORK EFFICIENTLY. THIS SYSTEM ASSISTS IN STOPPING LATENCY RELATED INACCURACIES AS MUCH AS POSSIBLE,
 	ALLOWING FOR A FAR STRONGER CHARACTER MODEL ACCURACY IN POSITIONING BY REMOVING UN-NECESSARY MOVEMENT YIELDS IN FILTERING.
 	
 - INCREMENT: Don't touch this. It is just a value that can be used to trigger events on the client to ensure runtime speed is
 	as accurate as possible.
 
 - DEFAULT: You can set this to one of the following options - "Tweening" or "Reposition". Tweening will run animations
 	smoothly but the accuracy of the character model may be hindered. Reposition will simply force the character model into
 	its most accurate position on the server as soon as possible without animating in between. This is most accurate especially
 	when combined with the updated and advanced "auto-predict" feature.
 - SHEATH: You can set this to one of the following options - "Choice", "Side", "Back", or "None". Choice will allow players
 	to choose where the sword gets sheathed in settings. Side will force the sheath to the hip. Back will force the sheath to
 	the back. None will make it so no sheath options are available.
 - AFTERLIFE: If this feature is enabled, people can damage while at 0 HP. This allows people to forcetie but it also
 	gives exploiters the ability to abuse mechanics so I recommend you keep this feature disabled.
 - FLOAT: You can set this to one of the following options - "Choice", "Yes", or "No". Choice allows the player to decide
 	if they want Float enabled or not. Enabling this feature (by putting "Yes") allows a mid-range float when swords are lunged similar
 	to how swords used to be before the mass and density updates. This will not cause you to float if you are already grounded.
 - TEAM_KILL: Disabling this feature will disallow people from being able to kill people of their own team. By default, this
 	will simply stop anyone of the same team from harming each other but scroll down and read how Team_Control works for advanced
 	settings regarding adjusting which teams can attach which teams and which teams are allowed to TK each other.
 - HEAL_AMOUNT: Increasing this to an amount above 0 will grant a healing bonus equal to the number per KO.
 - DAMAGE: The amount of damage the sword deals on a lunge. Slash damage = lunge/3 & Equip damage = lunge/6. Default is 30
 	which is regular sword damage.
 - PERFORMANCE: You can set this to one of the following options - 0, 1, 2. Option 0 is the fastest but in larger servers it
 	may not as efficient. Each option higher sacrifices a small bit of speed for a more efficient performance in larger servers or
 	in servers that are more complex. * Setting Performance higher may make the swords seem less accurate. WARNING; if you use 3
 	we recommend having damage cooldown lower.
 - WARNINGS: Warning messages will include anything from a player spiking (therefore not dealing damage) to teleporting/lagging.
 	Check "Distance Checks and Teleportation" below for more details on how to properly implement teleportation with this system.
 	This option cannot be disabled anymore, as we have provided the client the ability to choose if it wants certain warnings or none.
 	Distance_Warnings can be set to false if you do not know how to implement teleportation checks properly to disable those warnings.
 - DUELING: Disabling this feature prevents people from being able to duel against another individual by pressing "H" (which
 	turns on duel mode). You can also add a cylinder part called "DuelingPlate" and it will enable TK inside of it. You can also
 	add a non-cancollide part called "DuelArena" and all players inside of that part will be able to TK.
 - CUSTOMS: Disabling this feature prevents players from editing the aesthetic design of their sword using the custom sword shop 
 	and editing features.
 - DISTANCE: Set this to 0 to disable it. This is the distance in studs it counts before triggering a distance warning check for
 	potentially teleportation.
 - COOLDOWN: How fast each instance of damage calculation will be applied. For example, 0.08 (considered a single frame in this ex.)
 	will allow damage to be performed once every 0.08 seconds. This does not count for damage on different body parts. Lower = higher DPS.
 - TOPBAR_POSITION: Where will the sword configuration icon go? Typically each icon is separated by 44 each. This just simplifies the
 	process if you have something quick like a terminal GUI or HD Admin. In which case, if you do, you can set this to adjust it.
 - TEAM_HEAL_AMOUNT: If this is set to any amount above 0, when a team mate hits another team mate with the sword, they will heal by
 	the amount set by the value.
 	- You can also add "Team_Heal" to the tool with a value equal to the amount you want that sword to heal for individual weapons to team heal.
 - PARTICLELIGHTENABLED: Set this to false if you do not want custom effects to produce light in your places.
 - FEEDBACK: This provides message feedback to the client whenever an attack misses or another important event happens like a lag spike.
 - SWORD_TYPE: This option allows you to change the sword type used by default. The options are "RoClans" and "Engraved". Other options may be
 	available in newer versions but these versions should be updated automatically. For the expanded list of options, update the core script.
 
 [ ANTI-LITE ]
  - ANTI_SPEED: This is not a full-proof method to prevent speed exploits, but this is located in "Anti_Lite" as a means to catch amateur
 	exploiters. This being at true means that anyone caught having a higher speed than what is allowed will trigger an exploit warning.
 - ANTI_GRIP: This is not a full-proof method to prevent speed exploits, but this is located in "Anti_Lite" as a means to catch amateur
 	exploiters. This being at true means anyone that attempts to change their grip will be announced as an exploiter.
 - ANTI_CIRCLE: This is not a full-proof method to prevent speed exploits, but this is located in "Anti_Lite" as a means to catch amateur
 	exploiters. This being at true means anyone that attempts to create circle reach unprotected will be announced as an exploiter.
 - ANTI_FLIGHT:
 - PLATFORMSTANDALLOWED: If your game never uses PlatformStand, set PlatformStandAllowed to false.
 
 [ CUSTOM DAMAGE ]
 	If you have multiple swords that do different amounts of damage, you can add a number value into the tool and name it "Sword_Damage".
 	Sword_Damage value should be the amount of damage that the lunge will do (example: default is 30). This will overwrite the global
 	damage that is in the settings folder.
 
 [ TEAM CONTROL SETTINGS ]
 	These settings allow you to adjust team settings in a more advanced way.
 STEP ONE: Change, remove, or add teams currently inside of the Team_Control folder according to your current teams.
 		EXAMPLE: In this example your teams are "Raider", "Noble Blade", "Ally", and "Raider Ally". Simply rename "Defenders"
 		to "Noble Blade" (your defending team), rename "Allies" to "Ally", rename "Enemies" to "Raider", and then duplicate "Raider"
 		and change the duplicate's name to "Raider Ally".
 STEP TWO: Adjust what teams can harm who. In properties, set the number of each team to the same number. Then set the number of 
 	teams you want to be harmable to a different number. Same numbers = No TK. Different numbers = TK. The only exception to this
 	is any team with the number "0" will automatically be set to TK. Any team set to 0 has Team_Kill ENABLED. Any number set above
 	or equal to 101 cannot be harmed at all by any other team except by a team with another number equal to or above 100. If the
 	number is set to exactly "100" then that team cannot be harmed by anyone except a team with a number of 100 or higher. Any team
 	set to 100 also has Team_Kill ENABLED. Any team set to "-1" cannot harm or be harmed by a number less than 100.
 		EXAMPLE: We do not want "Noble Blade" or "Ally" to be able to hurt each other. So we will set their value to 1 each. We
 		want raiders to fight the defenders so we will set "Raider" and "Raider Ally" to 2. Now Noble Blade + Ally teams will not
 		harm each other and "Raider" + "Raider Ally" teams will not harm each other. If we want, we could also add a "Free for All"
 		team and set its value to "0" that way anyone who is a part of the Free for All team can harm each other.
 			Additionally, we can add a "Supervisor" team and give it a value of 101, making it so the Supervisor can harm others but
 		not be harmed by anyone of a lower value. We can also add "Anti-Supervisor" and make its value 102 so they can harm each
 		other. Lastly, you can add a team called "Spectator" with a value of -1 to prevent them from taking or dealing damage unless
 		by the Supervisor, whose value is 100+.
 		
 		Common Set Up Exs.:
 		Defender = 1
 		Allies = 1
 		Raider = 2
 		Spectator = -1
 		Trainer = 101
 		FFA = 0
 		NOTE: DO NOT HAVE UN-NECESSARY TEAMS IN THE TEAM_CONTROL FOLDER OR THIS WILL NOT WORK PROPERLY.
 STEP THREE: Double check to make sure each team name is *exactly* the same. This is including capital letters. Awesome!
 
 NOTE: You can add a folder to a character model called "Killable" and place character objects with the names of the individuals that can 
	be killed and it follow normal TK rules with the exception of being able to kill individuals inside of that folder.
 
 [ ABOUT PING, LOOPS, AND LEADERBOARD ]
 	If you have a leaderboard that uses a ping stat, we strongly recommend removing the code as our sword has a built in system for doing it
 	which allows the performance of the sword to remain intact while still providing you with the function of the stat.
 	
 	All you need to do to implement our ping reading system is to add an int stat on the leaderboard to "Ping" and the rest will be done for you.
 	Due to our sword using a strong loop, it is absolutely necessary that the amount of stressful loops done in-game are limited to prevent
 	performance issues. That means anything that uses a short delay time such as wait() should be considered carefully or integrated to this
 	system instead.
 
 [ DISTANCE CHECKS AND TELEPORTATION ]
 	You may need some knowledge of coding to do this. In your teleportation script, you should add this piece of code to prevent
 	the warning system from creating false positives with teleportations that are actually supposed to happen naturally in-game.
 	
 	-- Modify this as necessary. You should make sure your teleportations are properly "debouncing" to prevent false positives.
	function FilterWarp(RootPart, WarpSpot) -- This is an example of how to filter teleportation through RoClans.
		if typeof(WarpSpot) == "CFrame" then WarpSpot = WarpSpot.Position end -- When we're using a CFrame to teleport, we need to convert.
		local PASS = Instance.new("Vector3Value")
		PASS.Name = "PASS"
		PASS.Value = WarpSpot -- make sure to adjust this to the position being teleported.
		PASS.Parent = RootPart.Parent -- make sure to adjust this to the character being teleported.
	end
	
	local WarpTo = CFrame.new(script.Parent.Teleporter2.Position + Vector3.new(0, 5, 0)) -- Create the position they'll be teleported first.
	FilterWarp(t.Parent.HumanoidRootPart, WarpTo) -- Call the function to filter the teleport.
	t.Parent.HumanoidRootPart.CFrame = WarpTo -- Teleport them.
	
 [ FLIGHT ]
 	If a character is flying, you have to properly track it.
 	Add this code any time a character is supposed to be flying in the air, levitating in the air, or will stay in the air for a long period of
 	time:
 	local Flight = Instance.new("BoolValue")
 	Flight.Name = "Flight"
 	Flight.Parent = Character -- make this the character
 	-- You will have to remove the Flight value when they land or are supposed to land to prevent abuse.
 	
 	Landing Code:
 	local Landed
 	Landed = Humanoid.StateChanged:Connect(function(_oldState, newState)
 		if newState == Enum.HumanoidStateType.Landed then
 			Flight:Destroy()
 			Landed:Disconnect()
 		end
 	end)
 	
 	Alternatively you can disable Anti_Flight from the Anti_Lite folder.
	
 [ SPEED CONTROL ]
 	Make sure if you have "Anti_Speed" enabled, you also set the Max_WalkSpeed to the highest possible speed that can be used in the server.
 	If you do not give any speed boosts then just leave the Max_WalkSpeed at 16.
 	
 	If the Max_WalkSpeed is set to anything higher than 16 then an exploiter can use that as their maximum speed limit before being registered
 	by the anti-system, if they are.
 	
 [ PARTICLE DISABLE IMMUNITY ]
 	If you do not want particles or parts to be disabled or turned plastic, add any object (maybe a BoolValue) to the object and name it "IMMUNE".
 	Objects inside of the IMMUNE folder also cannot be affected by material or effect disabling. You can move the IMMUNE folder anywhere, do not remove it.
 	
 [ STUD LOGS ]
 	If you have your own stud logs, feel free to use them. We have a built in stud log that checks studs and ping as normal without the use of
 	the leaderboard. Since it is not directly connected to the leaderboard it may not be as efficient as it could be, so if your stud log is more
 	efficiently connected to your game, you are better off switching ours off, which will automatically remove it as an option from the GUI.
 
 Lametta :o]]

local F = script.Parent
if F:FindFirstChild("StarterPack") then
	for _,Tools in pairs(F.StarterPack:GetChildren()) do
		Tools.Parent = game.StarterPack
	end
end
if F.Parent ~= game.Workspace then
	F.Parent = game.Workspace
end
local S = F:WaitForChild("Scripts")
local Debris = game:GetService("Debris")
local Statistics = F:WaitForChild("Statistics")
local Settings = F:WaitForChild("Settings")

if game.StarterGui:FindFirstChild("TrackMethod") then
	if S:FindFirstChild("TrackMethod") then
		S.TrackMethod:Destroy()
	end
	game.StarterGui.TrackMethod.Parent = S
end

if Settings.StudLogs.Value == false then
	S.TrackMethod.Configuration.ScrollSettings.Studlogs.Visible = false
end

if Settings.Core_Options.OnlyCorrectionEnabled.Value == true then
	S.TrackMethod.Configuration.ScrollWeapon.AutoPredict.Visible = false
end

if not game.ServerStorage:FindFirstChild("CachedSwords") then
	local CS = Instance.new("Folder")
	CS.Name = "CachedSwords"
	CS.Parent = game.ServerStorage
end

F.Events.Dueling.OnServerEvent:Connect(function(Player, Duel)
	if Player then
		if Player:FindFirstChild("Duel_Mode") then
			Player.Duel_Mode.Value = Duel
		end
	end
end)

F.Events.Sheath.OnServerEvent:Connect(function(Player, Sheath)
	if not Player:FindFirstChild("Sheath") then
		local AddSheath = Instance.new("StringValue")
		AddSheath.Name = "Sheath"
		AddSheath.Value = Sheath
		AddSheath.Parent = Player
	else
		Player.Sheath.Value = Sheath
	end
end)

F.Events.Sheath.OnServerEvent:Connect(function(Player, Sheath)
	if not Player:FindFirstChild("Sheath") then
		local AddSheath = Instance.new("StringValue")
		AddSheath.Name = "Sheath"
		AddSheath.Value = Sheath
		AddSheath.Parent = Player
	else
		Player.Sheath.Value = Sheath
	end
end)

F.Events.Float.OnServerEvent:Connect(function(Player, Float)
	if not Player:FindFirstChild("Float") then
		local AddFloat = Instance.new("StringValue")
		AddFloat.Name = "Float"
		AddFloat.Value = Float
		AddFloat.Parent = Player
	else
		Player.Float.Value = Float
	end
end)

local PlaceId = game.PlaceId
local PlaceInfo = game:GetService("MarketplaceService"):GetProductInfo(PlaceId)

local Idcache = {}
function GetId(name)
	if Idcache[name] then return Idcache[name] end
	local player = game.Players:FindFirstChild(name)
	if player then
		Idcache[name] = player.UserId
		return player.UserId
	end 
	local id
	pcall(function ()
		id = game.Players:GetUserIdFromNameAsync(name)
	end)
	Idcache[name] = id
	return id
end

if PlaceInfo.Creator.CreatorType == "Group" then
	GroupOwner = game:GetService("GroupService"):GetGroupInfoAsync(PlaceInfo.Creator.CreatorTargetId).Owner.Name
	GameOwner = GetId(GroupOwner)
elseif PlaceInfo.Creator.CreatorType == "User" then
	GameOwner = game.CreatorId
end

local OwnerId = Instance.new("IntValue")
OwnerId.Name = "OwnerId"
OwnerId.Value = GameOwner
OwnerId.Parent = F
local PrivateOwnerId = Instance.new("IntValue")
PrivateOwnerId.Name = "PrivateOwnerId"
PrivateOwnerId.Value = game.PrivateServerOwnerId
PrivateOwnerId.Parent = F

if game.ServerStorage:FindFirstChild("Main") and game.ServerStorage.Main:FindFirstChild("MainModule") then
	require(game.ServerStorage.Main.MainModule):Implement(F, S)
else
	require(13415929378):Implement(F, S)
end

--[[ LAMETTA ]]--
