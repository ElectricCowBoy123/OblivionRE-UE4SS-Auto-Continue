<<<<<<< HEAD
RegisterHook("/Script/Altar.VMainMenuViewModel:LoadInstanceOfLevels", function(Context)
	local mainMenuViewModelm = FindFirstOf("VMainMenuViewModel")
	local isContinue = mainMenuViewModelm:GetContinueVisibility()
	if isContinue then
		mainMenuViewModelm:RegisterSendClickedContinue()
	end
=======
RegisterHook("/Script/Altar.VPairedPawn:OnCombatHitTaken", function(Context)
	local actor=Context:get()
	local isDead = actor:IsDead()
	if isDead then
		local playerController = FindFirstOf("VAltarPlayerController")
		playerController:RequestQuickLoad()
	end	
>>>>>>> 210f30a (initial commit)
end)