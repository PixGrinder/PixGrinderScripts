
---------------------------------------------------------------------

-- PixGrinder Scripts --
-- Full Name Display --
-- FullNameDisplay.ms --
-- Opens a rollout with a large Text field  to display objects full length name !! --
-- Warning : Typing Text and pressing [ENTER] renames the selected object --
-- V 1.0 --

---------------------------------------------------------------------






		try (destroyDialog pixGrinder_Globals_NmDisplay) catch()
		createDialog pixGrinder_Globals_NmDisplay 650 120 1230 100
		if selection[1] != undefined do pixGrinder_Globals_NmDisplay.myName.text = selection[1].name
		setFocus pixGrinder_Globals_NmDisplay.myName




