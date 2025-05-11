RegisterHook("/Script/Altar.VMainMenuViewModel:LoadInstanceOfLevels", function(Context)
	local mainMenuViewModelm = FindFirstOf("VMainMenuViewModel")
	local isContinue = mainMenuViewModelm:GetContinueVisibility()
	if isContinue then
		mainMenuViewModelm:RegisterSendClickedContinue()
	end
end)