
	rollout pixGrinder_Globals_NmDisplayTEST "Name Display"
	(

		label nmLbl "NAME" align:#center offset:[0,5]
		edittext myName "" text:"" fieldWidth:350 align:#center  offset:[0,5] -- height:20
		button NmBtn "OK" offset:[55,15] across:4 align:#left width:50
		button NmBtnCopy "Copy" offset:[40,15] across:4 align:#left width:50
		button NmBtnUpd "Update" offset:[30,15] across:4 align:#left width:50
		button NmBtnCancel "Cancel" offset:[25,15] align:#left width:50
		on NmBtn pressed do 
		(
			if selection[1] != undefined then selection[1].name = myName.text
			destroyDialog pixGrinder_Globals_NmDisplay
		)

		on NmBtnCopy pressed do 
		(
			if selection[1] != undefined then setclipboardText selection[1].name
		)


		on NmBtnCancel pressed do 
		(
			
			if selection[1] != undefined then
			(
				try (selection[1].name = pixGrinder_Globals_myBackupName) catch()
				myName.text = selection[1].name
			) else (
				destroyDialog pixGrinder_Globals_NmDisplay
			)

		)

		on NmBtnUpd pressed do 
		(
			myName.text = selection[1].name
		)

		on myName changed txtTemp do if selection[1] != undefined then selection[1].name = txtTemp
	)

	createDialog pixGrinder_Globals_NmDisplayTEST 400 120 1530 100