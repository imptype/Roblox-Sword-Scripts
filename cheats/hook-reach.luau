-- source https://pastebin.com/ahkcSPz4
-- updated at january 11, 2024

local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()
local Init = tick()
local found = false
local blacklisted = {
    "check",
    "sword",
    "handle",
    "change",
    "changing",
    "remove",
    "add",
    "size",
    "set",
    "gui",
    "syn",
    "touch",
    "fti",
    "match",
    "err",
}
if _G.IgnoreNames then
    return
else
    _G.IgnoreNames = {}
end

_G.SpyEnabled, _G.FireSpy, _G.InvokeSpy = true, true, true

local Fire = Instance.new("RemoteEvent").FireServer
local Invoke = Instance.new("RemoteFunction").InvokeServer

local FireHook
local InvokeHook

local Count = 0
local tabChar = "      "

local function getSmaller(a, b, notLast)
    local aByte = a:byte() or -1
    local bByte = b:byte() or -1
    if aByte == bByte then
        if notLast and #a == 1 and #b == 1 then
            return -1
        elseif #b == 1 then
            return false
        elseif #a == 1 then
            return true
        else
            return getSmaller(a:sub(2), b:sub(2), notLast)
        end
    else
        return aByte < bByte
    end
end

local function parseData(obj, numTabs, isKey, overflow, noTables, forceDict)
    local objType = typeof(obj)
    local objStr = tostring(obj)
    if objType == "table" then
        if noTables then
            return objStr
        end
        local isCyclic = overflow[obj]
        overflow[obj] = true
        local out = {}
        local nextIndex = 1
        local isDict = false
        local hasTables = false
        local data = {}

        for key, val in next, obj do
            if not hasTables and typeof(val) == "table" then
                hasTables = true
            end

            if not isDict and key ~= nextIndex then
                isDict = true
            else
                nextIndex = nextIndex + 1
            end

            data[#data + 1] = { key, val }
        end

        if isDict or hasTables or forceDict then
            out[#out + 1] = (isCyclic and "Cyclic " or "") .. "{"
            table.sort(data, function(a, b)
                local aType = typeof(a[2])
                local bType = typeof(b[2])
                if bType == "string" and aType ~= "string" then
                    return false
                end
                local res = getSmaller(aType, bType, true)
                if res == -1 then
                    return getSmaller(tostring(a[1]), tostring(b[1]))
                else
                    return res
                end
            end)
            for i = 1, #data do
                local arr = data[i]
                local nowKey = arr[1]
                local nowVal = arr[2]
                local parseKey = parseData(nowKey, numTabs + 1, true, overflow, isCyclic)
                local parseVal = parseData(nowVal, numTabs + 1, false, overflow, isCyclic)
                if isDict then
                    local nowValType = typeof(nowVal)
                    local preStr = ""
                    local postStr = ""
                    if i > 1 and (nowValType == "table" or typeof(data[i - 1][2]) ~= nowValType) then
                        preStr = "\n"
                    end
                    if
                        i < #data
                        and nowValType == "table"
                        and typeof(data[i + 1][2]) ~= "table"
                        and typeof(data[i + 1][2]) == nowValType
                    then
                        postStr = "\n"
                    end
                    out[#out + 1] = preStr
                        .. string.rep(tabChar, numTabs + 1)
                        .. parseKey
                        .. " = "
                        .. parseVal
                        .. ";"
                        .. postStr
                else
                    out[#out + 1] = string.rep(tabChar, numTabs + 1) .. parseVal .. ";"
                end
            end
            out[#out + 1] = string.rep(tabChar, numTabs) .. "}"
        else
            local data2 = {}
            for i = 1, #data do
                local arr = data[i]
                local nowVal = arr[2]
                local parseVal = parseData(nowVal, 0, false, overflow, isCyclic)
                data2[#data2 + 1] = parseVal
            end
            out[#out + 1] = "{" .. table.concat(data2, ", ") .. "}"
        end

        return table.concat(out, "\n")
    else
        local returnVal = nil
        if (objType == "string" or objType == "Content") and (not isKey or tonumber(obj:sub(1, 1))) then
            local retVal = '"' .. objStr .. '"'
            if isKey then
                retVal = "[" .. retVal .. "]"
            end
            returnVal = retVal
        elseif objType == "EnumItem" then
            returnVal = "Enum." .. tostring(obj.EnumType) .. "." .. obj.Name
        elseif objType == "Enum" then
            returnVal = "Enum." .. objStr
        elseif objType == "Instance" then
            returnVal = obj.Parent and obj:GetFullName() or obj.ClassName
        elseif objType == "CFrame" then
            returnVal = "CFrame.new(" .. objStr .. ")"
        elseif objType == "Vector3" then
            returnVal = "Vector3.new(" .. objStr .. ")"
        elseif objType == "Vector2" then
            returnVal = "Vector2.new(" .. objStr .. ")"
        elseif objType == "UDim2" then
            returnVal = "UDim2.new(" .. objStr:gsub("[{}]", "") .. ")"
        elseif objType == "BrickColor" then
            returnVal = 'BrickColor.new("' .. objStr .. '")'
        elseif objType == "Color3" then
            returnVal = "Color3.new(" .. objStr .. ")"
        elseif objType == "NumberRange" then
            returnVal = "NumberRange.new(" .. objStr:gsub("^%s*(.-)%s*$", "%1"):gsub(" ", ", ") .. ")"
        elseif objType == "PhysicalProperties" then
            returnVal = "PhysicalProperties.new(" .. objStr .. ")"
        else
            returnVal = objStr
        end
        return returnVal
    end
end

local function tableToString(t)
    return parseData(t, 0, false, {}, nil, false)
end

FireHook = hookfunction(
    Fire,
    newcclosure(function(...)
        local args = {
            ...,
        }
        local Remote = args[1]
        if _G.SpyEnabled and _G.FireSpy then
            Count = Count + 1
            local Caller = rawget(getfenv(2), "script") and rawget(getfenv(2), "script"):GetFullName() or "N/A"

            if Caller:find("\n") then
                Caller = Caller:gsub("\n", "\\n")
            end
        end
        print(tableToString(args):lower())
        for i, v in pairs(blacklisted) do
            if tableToString(args):lower():match(blacklisted[i]) then
                print("had to blacklist this bozo")
                return nil
            end
        end
        return FireHook(unpack(args))
    end)
)

InvokeHook = hookfunction(
    Invoke,
    newcclosure(function(...)
        local args = {
            ...,
        }

        local Caller = rawget(getfenv(2), "script") and rawget(getfenv(2), "script"):GetFullName() or "N/A"

        spawn(function()
            local Remote = args[1]
            if _G.SpyEnabled and _G.InvokeSpy then
                Count = Count + 1

                if Caller:find("\n") then
                    Caller = Caller:gsub("\n", "\\n")
                end
            end
        end)

        return InvokeHook(unpack(args))
    end)
)

_G.OldFire = FireHook
_G.OldInvoke = InvokeHook
local LocalPlayer = game:GetService("Players").LocalPlayer
local Reach = 1
local LungeOnly = false
local R = 0
local G = 0
local B = 0
local VisualizerEnabled = false
local DMGEnabled = false
local DMGMultiplied = 1
local Shape = "Block"
local DamageBypass = false
local FTIOnBypass = false
local GetPartsInpartBypass = false
for i, v in next, getconnections(game:GetService("ScriptContext").Error) do
    v:Disable()
end

local TouchingHook
TouchingHook = hookmetamethod(game, "__namecall", function(...)
    if getnamecallmethod() == "GetTouchingParts" and DamageBypass then
        return nil
    end
    return TouchingHook(...)
end)

local TouchingHook
TouchingHook = hookmetamethod(game, "__namecall", function(...)
    if getnamecallmethod() == "GetPartsInPart" and DamageBypass then
        return nil
    end
    return TouchingHook(...)
end)

local hook
hook = hookfunc(
    getrenv().wait,
    newcclosure(function(...)
        local args = { ... }
        if args[1] == 2 and getcallingscript().Parent == nil and FTIOnBypass then
            return coroutine.yield()
        end
        return hook(...)
    end)
)

local hook
hook = hookfunc(
    getrenv().wait,
    newcclosure(function(...)
        local args = { ... }
        if args[1] == 3 and getcallingscript().Parent == nil and FTIOnBypass then
            return coroutine.yield()
        end
        return hook(...)
    end)
)
local ACStopBind = ""
local ACEnabled = false
local OnlyFireOnTouchTransmitter = false
local FireRealHandle = false
local visualizer = Instance.new("Part")
visualizer.Color = Color3.new(R, G, B)
visualizer.Transparency = 0.4
visualizer.Anchored = true
visualizer.CanCollide = false
visualizer.CastShadow = false
visualizer.Size = Vector3.new(0.5, 0.5, 0.5)
visualizer.Material = Enum.Material.ForceField
visualizer.BottomSurface = Enum.SurfaceType.Smooth
visualizer.TopSurface = Enum.SurfaceType.Smooth
local UI = Material.Load({
    Title = "Eclipse",
    Style = 1,
    SizeX = 341,
    SizeY = 233,
    Theme = "Dark",
})
local Page1 = UI.New({
    Title = "Main",
})
local VisualizerPage = UI.New({
    Title = "Visualizer",
})
local DamagePage = UI.New({
    Title = "Amplifier",
})
local BypassPage = UI.New({
    Title = "Bypasses",
})
local ReachSlider = Page1.Slider({
    Text = "Circle Radius",
    Callback = function(value)
        Reach = tonumber(value)
    end,
    Min = 1,
    Max = 10,
    Def = 1,
})
local lungeOnly = Page1.Toggle({
    Text = "Lunge Only",
    Callback = function(value)
        LungeOnly = value
    end,
})
local ftionrealhandle = Page1.Toggle({
    Text = "Fire FTI On Real Handle",
    Callback = function(v)
        FireRealHandle = v
    end,
})

local note = Page1.Label({
    Text = "Please set the toggle under to true.",
})

local UseTouchTransmitter = Page1.Toggle({
    Text = "Fire FTI On TouchTransmitter",
    Callback = function(value)
        OnlyFireOnTouchTransmitter = value
    end,
})
local ToggleVisualizer = VisualizerPage.Toggle({
    Text = "Toggle Visualizer",
    Callback = function(v)
        VisualizerEnabled = v
    end,
})
local Shapes = VisualizerPage.Dropdown({
    Text = "Visualizer Shapes",
    Callback = function(v)
        Shape = v
    end,
    Options = { "Ball", "Block", "Cylinder" },
})
local VColorPicker = VisualizerPage.ColorPicker({
    Text = "Visualizer RGB Wheel",
    Default = Color3.fromRGB(0, 0, 0),
    Callback = function(value)
        R = value.R
        G = value.G
        B = value.B
    end,
})

local ToggleAMP = DamagePage.Toggle({
    Text = "Damage Amplifier",
    Callback = function(value)
        DMGEnabled = value
    end,
})

local MultiplierSlider = DamagePage.Slider({
    Text = "Damage Multiplier",
    Callback = function(value)
        DMGMultiplied = tonumber(value)
    end,
    Min = 1,
    Max = 5,
    Def = 1,
})

local DamageBypassToggle = BypassPage.Toggle({
    Text = "hook __namecall GetTouchingParts (DMG)",
    Callback = function(value)
        DamageBypass = value
    end,
})
local FtiOnBYpassTYoggle = BypassPage.Toggle({
    Text = "hook __index getrenv().wait (FTI[])",
    Callback = function(value)
        FTIOnBypass = value
    end,
})

local GETTOnBYpassTYoggle = BypassPage.Toggle({
    Text = "hook __namecall GetPartsInpart (FTI[])",
    Callback = function(value)
        GetPartsInpartBypass = value
    end,
})

-- // Skidded Xen-Zone? I think not.
local HitParts = {}
local t = tick()

-- // FTI Function.
local FTI = function(hit, handle)
    local Hum = hit.Parent.Humanoid
    if Hum and Hum.Parent.Name ~= LocalPlayer.Name then
        for _, q in pairs(handle.Parent.Parent:GetChildren()) do
            if q:IsA("Part") then
                if q:FindFirstChildOfClass("TouchTransmitter") and OnlyFireOnTouchTransmitter then
                    if LungeOnly and handle.Parent.GripUp ~= Vector3.new(-1, 0, 0) then
                        return
                    end
                    if q.Parent.Humanoid.Health ~= 0 then
                        if not DMGEnabled then
                            for _, x in pairs(hit.Parent:GetChildren()) do
                                if x:IsA("BasePart") and x.Parent.Humanoid.Health ~= 0 then
                                    local parts = x
                                    if not table.find(HitParts, parts.Name) then
                                        if #HitParts >= 6 then
                                            table.clear(HitParts)
                                        end
                                        table.insert(HitParts, parts.Name)
                                        if math.abs(tick() - t) < 0.05 then
                                            return
                                        end
                                        t = tick()
                                        firetouchinterest(x, q, 0)
                                        firetouchinterest(x, q, 1)
                                        firetouchinterest(x, handle, 0)
                                        firetouchinterest(x, handle, 1)
                                    end
                                end
                            end
                        else
                            for _, x in pairs(hit.Parent:GetChildren()) do
                                if x:IsA("BasePart") and x.Parent.Humanoid.Health ~= 0 then
                                    for i = 1, DMGMultiplied do
                                        firetouchinterest(x, q, 0)
                                        firetouchinterest(x, q, 1)
                                        firetouchinterest(x, handle, 0)
                                        firetouchinterest(x, handle, 1)
                                    end
                                end
                            end
                        end
                    end
                elseif OnlyFireOnTouchTransmitter == false then
                    if LungeOnly and handle.Parent.GripUp ~= Vector3.new(-1, 0, 0) then
                        return
                    end
                    if q.Parent.Humanoid.Health ~= 0 then
                        for _, x in pairs(hit.Parent:GetChildren()) do
                            if x:IsA("BasePart") and x.Parent.Humanoid.Health ~= 0 then
                                local parts = x
                                if not table.find(HitParts, parts.Name) then
                                    if #HitParts >= 6 then
                                        table.clear(HitParts)
                                    end
                                    table.insert(HitParts, parts.Name)
                                    if math.abs(tick() - t) < 0.05 then
                                        return
                                    end
                                    t = tick()
                                    firetouchinterest(x, q, 0)
                                    firetouchinterest(x, q, 1)
                                    firetouchinterest(x, handle, 0)
                                    firetouchinterest(x, handle, 1)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

-- // FTI Handler
game:GetService("RunService").RenderStepped:Connect(function()
    visualizer.Color = Color3.new(R, G, B)
    local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
    Reach = Reach
    visualizer.Size = Vector3.new(Reach, Reach, Reach)
    if ACEnabled then
        tool:Activate()
        tool:Activate()
    end
    if not tool then
        visualizer.Parent = nil
        return
    end
    local handle = tool:FindFirstChild("Handle") or tool:FindFirstChildOfClass("Part")
    visualizer.CFrame = handle.CFrame
    visualizer.Shape = Enum.PartType[Shape]
    for _, x in pairs(game:GetService("Players"):GetPlayers()) do
        if VisualizerEnabled then
            visualizer.Parent = workspace
        else
            visualizer.Parent = nil
        end
        local humpart = x.Character:FindFirstChild("HumanoidRootPart")
        local Region = Region3.new(handle.Position + Vector3.new(-1, -1, -1), handle.Position + Vector3.new(1, 1, 1))
        local InRegion = game:GetService("Workspace"):FindPartsInRegion3(Region)
        if humpart and handle and x.Character.Humanoid.Health ~= 0 then
            local mag = (humpart.Position - handle.Position).Magnitude
            if mag <= Reach and x.Name ~= LocalPlayer.Name then
                if FireRealHandle == false then
                    FTI(humpart, handle)
                else
                    for _, v in pairs(InRegion) do
                        if v:IsA("Part") and v:FindFirstChildOfClass("TouchTransmitter") and v.Name ~= "Handle" then
                            FTI(humpart, v)
                        end
                    end
                end
            end
        end
    end
end)
