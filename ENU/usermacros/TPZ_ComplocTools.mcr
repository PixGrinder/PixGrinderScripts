-------------------------------------------------------------------------------
-- TPZ_ComplocTools.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE ( pixgrinder@gmail.com )
-- 26/01/2017
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
(
	
	macroScript ComplocExporter
	category:"-- PixGrinder - TPZ Tools --"
	toolTip:"Comploc Exporter"
	buttonText:"Comploc Exporter"
	--icon:#("FileLinkActionItems",9)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder_TPZ_Tools/Comploc_Exporter.ms"
	)

	macroScript Rotation_Activator
	category:"-- PixGrinder --"
	toolTip:"Rotation_Activator"
	buttonText:"Rotation_Activator"
	icon:#("FileLinkActionItems",1)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/Rotation_Activator.mse"
	)

	macroScript CustAttribTransfert
	category:"-- PixGrinder - TPZ Tools --"
	toolTip:"Comploc Attributes Transfert"
	buttonText:"Comploc Attributes Transfert"
	--icon:#("FileLinkActionItems",9)
	silentErrors:false
	autoUndoEnabled:true
	(
		Include "$userScripts/PixGrinder_TPZ_Tools/CustomAttributesTransfer.ms"
	)


	macroScript Bitmap_AH_Path
	category:"-- PixGrinder - TPZ Tools --"
	toolTip:"Bitmap Relative Path"
	buttonText:"Bitmap Relative Path"
-- 	icon:#("MaxScript",5)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder_TPZ_Tools/BitmapPath_AH.ms"
	)


	macroScript ConflictManagerLauncher
	category:"-- PixGrinder - TPZ Tools --"
	toolTip:"ConflictManagerLauncher"
	buttonText:"ConflictManagerLauncher"
	icon:#("MaxScript",2)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder_TPZ_Tools/ConflictManagerLauncher.ms"
	)

	macroScript SelectClComps
	category:"-- PixGrinder - TPZ Tools --"
	toolTip:"Comploc Select Tagged Components"
	buttonText:"Comploc Select Tagged Components"
	-- icon:#("MaxScript",2)
	silentErrors:true
	autoUndoEnabled:true
	(
		Include "$userScripts/PixGrinder_TPZ_Tools/CL_Select_CL_Comps.ms"
	)

	macroScript DeleteClComps
	category:"-- PixGrinder - TPZ Tools --"
	toolTip:"Comploc Delete Tags"
	buttonText:"Comploc Delete Tags"
	-- icon:#("MaxScript",2)
	silentErrors:true
	autoUndoEnabled:true
	(
		Include "$userScripts/PixGrinder_TPZ_Tools/CL_Remove_Custom_Attributes.ms"
	)

	macroScript CleanGhostLinks
	category:"-- PixGrinder - TPZ Tools --"
	toolTip:"Clean Ghost Comploc Links"
	buttonText:"Clean Ghost Comploc Links"
	-- icon:#("MaxScript",2)
	silentErrors:true
	autoUndoEnabled:true
	(
		Include "$userScripts/PixGrinder_TPZ_Tools/compLoc_fixComponent_problems.ms"
	)


	macroScript DelecteCameras
	category:"-- PixGrinder - TPZ Tools --"
	toolTip:"Delete All Cameras"
	buttonText:"Delete All Cameras"
	-- icon:#("MaxScript",2)
	silentErrors:true
	autoUndoEnabled:true
	(
		Include "$userScripts/PixGrinder_TPZ_Tools/DelecteCameras.ms"
	)
	
	macroScript CamFromComp
	category:"-- PixGrinder - TPZ Tools --"
	toolTip:"CamFromComp"
	buttonText:"CamFromComp"
	-- icon:#("MaxScript",2)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder_TPZ_Tools/CL_CamFromComponent.ms"
	)


	
	macroScript VMT_Cam
	category:"-- PixGrinder - TPZ Tools --"
	toolTip:"VMT_Cam"
	buttonText:"VMT_Cam"
	-- icon:#("MaxScript",2)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder_TPZ_Tools/VMT_Cam.ms"
	)


	macroScript CAO_OneClickProcess
	category:"-- PixGrinder - TPZ Tools --"
	toolTip:"CAO_OneClickProcess"
	buttonText:"CAO_Optim"
	--icon:#("PixGrinder",21)
	silentErrors:true
	autoUndoEnabled:true
	(
		FileIn "$userScripts/PixGrinder_TPZ_Tools/CAO_OneClickProcess.ms"
	)


	macroScript CAO_OneClickOptim_35p
	category:"-- PixGrinder - TPZ Tools --"
	toolTip:"CAO_OneClickOptim"
	buttonText:"CAO_Optim_35p"
	--icon:#("PixGrinder",21)
	silentErrors:true
	autoUndoEnabled:true
	(
		FileIn "$userScripts/PixGrinder_TPZ_Tools/CAO_OneClickOptim_35p.ms"
	)

	macroScript Physical_to_Standard
	category:"-- PixGrinder - TPZ Tools --"
	toolTip:"Physical_To_Standard"
	buttonText:"Physical_To_Standard"
	--icon:#("PixGrinder",21)
	silentErrors:true
	autoUndoEnabled:true
	(
		FileIn "$userScripts/PixGrinder_TPZ_Tools/Physical_To_Standard.ms"
	)

	macroScript Standard_to_Physical
	category:"-- PixGrinder - TPZ Tools --"
	toolTip:"Standard_To_Physical"
	buttonText:"Standard_To_Physical"
	--icon:#("PixGrinder",21)
	silentErrors:true
	autoUndoEnabled:true
	(
		FileIn "$userScripts/PixGrinder_TPZ_Tools/Standard_To_Physical.ms"
	)

	macroScript SugzInit
	category:"-- PixGrinder - TPZ Tools --"
	toolTip:"SugzTools Init"
	buttonText:"SugzTools Init"
	icon:#("SugzTools",1)
	silentErrors:true
	autoUndoEnabled:true
	(
		FileIn "$userScripts/PixGrinder_TPZ_Tools/SugzTools_Init.ms"
	)

	macroScript MapSeeker_Current
	category:"-- PixGrinder - TPZ Tools --"
	toolTip:"MapSeeker_Current"
	buttonText:"MapSeeker_Current"
	icon:#("Material_Modifiers",1)
	silentErrors:true
	autoUndoEnabled:true
	(
		FileIn "$userScripts/PixGrinder_TPZ_Tools/MapSeeker_Current.ms"
	)



)