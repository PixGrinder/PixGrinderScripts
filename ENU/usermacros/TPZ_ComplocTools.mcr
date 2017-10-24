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

)