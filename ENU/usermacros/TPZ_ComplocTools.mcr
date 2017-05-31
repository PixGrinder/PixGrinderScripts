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



)