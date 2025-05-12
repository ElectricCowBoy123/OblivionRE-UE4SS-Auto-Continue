local function WaitForObject(className)
    local object = nil
    while not object or not object:IsValid() do
        object = FindFirstOf(className)
    end
    return object
end

local function loadConfig()
    local info       = debug.getinfo(1, "S")
    local scriptPath = info.source:match("@?(.*[\\/])") or "./"
    local cfg = {}
    local f = io.open(scriptPath .. "Config.ini", "r")
    if not f then error("Cannot open config: " .. scriptPath .. "Config.ini") end
    for line in f:lines() do
        local k, v = line:match("([%w_]+)%s*=%s*(%-?%d+)")
        if k and v then cfg[k] = tonumber(v) end
    end
    f:close()
    return cfg
end

local config = loadConfig()
config.press_continue_delay = config.press_continue_delay or 800

local hooked = false
ExecuteInGameThread(function()
	local preId, postId = RegisterHook("/Script/Altar.VMainMenuViewModel:LoadInstanceOfLevels", function(Context)
		local objMainMenuViewModel = FindFirstOf("VMainMenuViewModel")
		local isContinue = objMainMenuViewModel:GetContinueVisibility()
		if isContinue then
			objMainMenuViewModel:RegisterSendClickedContinue()
		end
		ExecuteWithDelay(config.press_continue_delay, function()
			local objWBP_ModernMenu_Message_C = WaitForObject("WBP_ModernMenu_Message_C")
			if objWBP_ModernMenu_Message_C and objWBP_ModernMenu_Message_C:IsValid() then
				if objWBP_ModernMenu_Message_C:IsVisible() then
					objWBP_ModernMenu_Message_C:SendClickedButton(0)
					hooked = true
					return true
				end
			end
		end)
	end)
end)

if hooked then
	UnregisterHook("/Script/Altar.VMainMenuViewModel:LoadInstanceOfLevels", preId, postId)
	collectgarbage()
end