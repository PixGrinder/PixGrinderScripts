
---------------------------------------------------------------------

-- PixGrinder Scripts --
-- Full Name Display --
-- FullNameDisplay.ms --
-- Opens a rollout with a large Text field  to display objects full length name !! --
-- Warning : Typing Text and pressing [ENTER] renames the selected object --
-- V 1.0 --

---------------------------------------------------------------------



(
	
	if selection.count > 0 then 
	(
		global NmDisplay
		rollout NmDisplay "Name Display"
		(
			button NmBtn "Update" offset:[0,10]
			edittext myName "Name:" text:selection[1].name fieldWidth:350 offset:[-5,10]
	-- 		edittext myName "Name:" text:"youpla" fieldWidth:250 --align:#centre
			on NmBtn pressed do myName.text = selection[1].name
			on myName entered txtTemp do selection[1].name = txtTemp
			--on myName entered (myName.text) do messageBox (myName.text)
		)

		try (destroyDialog NmDisplay) catch()
		createDialog NmDisplay 400 100 1530 90
	)


)

--GetDialogPos NmDisplay