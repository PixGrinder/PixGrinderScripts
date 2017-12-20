-------------------------------------------------------------------------------
-- PixGrinder.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE ( pixgrinder@gmail.com )
-- 05/04/2016
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
(
	
	macroScript AutoSavePixGrinder
	category:"-- PixGrinder --"
	toolTip:"AutoSave - PixGrinder"
	buttonText:"AutoSave - PixGrinder"
	icon:#("FileLinkActionItems",9)
	silentErrors:false
	autoUndoEnabled:false
	(
		FileIn "$userScripts/PixGrinder/AutoSave_PixGrinder.ms"
	)

)