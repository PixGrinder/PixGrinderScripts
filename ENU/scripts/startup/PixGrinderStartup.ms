
---------------------------------------------------------------------

-- PixGrinder Scripts --
-- PixGrinderStartup --
-- PixGrinderStartup.ms --
-- Initialisations for PixGrinder Scripts --
-- V 1.0 --

---------------------------------------------------------------------

-- FullNameDisplay.ms --
-- global pixGrinder_Globals_objSelect
global pixGrinder_Globals_NmDisplay
global pixGrinder_Globals_myBackupName = ""


-- global pixGrinder_Globals_myEventA
-- callbacks.addScript #filePostOpen "myAutoSaveOpenFile()" id:#FelipeCallback persistent:false

	rollout pixGrinder_Globals_NmDisplay "Name Display"
	(

		
		edittext myName "Name:" text:"" fieldWidth:350 offset:[-5,10] -- height:20
		button NmBtn "OK" offset:[120,20] across:2 align:#left width:50
		button NmBtnCancel "Cancel" offset:[25,20] align:#left width:50
		on NmBtn pressed do 
		(
			if selection[1] != undefined then selection[1].name = myName.text
			destroyDialog pixGrinder_Globals_NmDisplay
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
		on myName changed txtTemp do if selection[1] != undefined then selection[1].name = txtTemp
	)



fn pixGrinder_Globals_selectChanged = 
(
	if selection.count > 0 then 
	(
		pixGrinder_Globals_myBackupName = selection[1].name
		pixGrinder_Globals_NmDisplay.myName.text = selection[1].name 
	) else (
		pixGrinder_Globals_NmDisplay.myName.text = ""
	)

)

-- pixGrinder_Globals_myEventA = NodeEventCallback selectionChanged:pixGrinder_Globals_selectChanged






callbacks.addScript #selectionSetChanged "pixGrinder_Globals_selectChanged()" id:#pixGrinder_selectChanged  persistent:false

