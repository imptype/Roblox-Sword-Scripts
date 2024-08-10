-- Not really sword cheats but could help in sword cheats
-- source https://scriptblox.com/script/Universal-Script-Mobile-FFlag-fps-booster-13139
-- flags source https://www.youtube.com/watch?v=TPAYh3G8rBs
-- more flags source https://github.com/MaximumADHD/Roblox-FFlag-Tracker
-- updated at january 3, 2024

--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
--
task.spawn(function()
    local flagtables = {
        ["FFlagDebugSimIntegrationStabilityTesting"] = "True", -- speed
        ["DFFlagDebugDrawBroadPhaseAABBs"] = "True", -- hbe
    }

    local function m(z)
        z = z:gsub("^DFInt", "")
        z = z:gsub("^DFFlag", "")
        z = z:gsub("FString", "")
        z = z:gsub("FLog", "")
        z = z:gsub("^FFlag", "")
        z = z:gsub("^DFint", "")
        z = z:gsub("^FInt", "")
        return z
    end

    if setfflag then
        task.spawn(function()
            local start = os.clock()
            for k, v in pairs(flagtables) do
                if getfflag(m(k)) then
                    setfflag(m(k), v)
                elseif getfflag(k) then
                    setfflag(k, v)
                end
            end
            print("Done in " .. os.clock() - start)
        end)
    else
        print("not supported")
    end
end)
