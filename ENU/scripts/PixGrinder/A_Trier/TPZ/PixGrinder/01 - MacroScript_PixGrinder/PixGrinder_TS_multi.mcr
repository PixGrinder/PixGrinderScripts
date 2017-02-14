-------------------------------------------------------------------------------
-- PixGrinder.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE ( pixgrinder@gmail.com )
-- 28/01/2016
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
(
-- 	pda_path = symbolicPaths.getPathValue "$userScripts"
-- 	pda_path = pda_path+"\\PixGrinder"
-- 	try makedir pda_path catch()
	
	macroScript Collapse_Selected
	category:"PixGrinder"
	toolTip:"Collapse Hierarchy on Selection"
	buttonText:"Collapse Selected"
	icon:#("PixGrinder",1)
	silentErrors:true
	autoUndoEnabled:true
	(
		Include "$userScripts/PixGrinder/Collapse.mse"
	)
	
	macroScript myResetXForm
	category:"PixGrinder"
	toolTip:"ResetXForm on Selection"
	buttonText:"ResetXForm"
	icon:#("PixGrinder",4)
	silentErrors:true
	autoUndoEnabled:true
	(
		Include "$userScripts/PixGrinder/ResetXform.mse"
	)
	
	macroScript Select_Previous_Object
	category:"PixGrinder"
	toolTip:"Select Previous Object"
	buttonText:"Select Previous Object"
	icon:#("PixGrinder",3)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/Select_Prev.mse"
	)
	
	macroScript Select_Next_Object
	category:"PixGrinder"
	toolTip:"Select Next Object"
	buttonText:"Select Next Object"
	icon:#("PixGrinder",2)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/Select_Next.mse"
	)
	
	macroScript Duplicator
	category:"PixGrinder"
	toolTip:"Duplicator"
	buttonText:"Duplictor"
	icon:#("PixGrinder",15)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/Duplicator_v2.mse"
	)
	
	macroScript Select_Hierarcy
	category:"PixGrinder"
	toolTip:"Select Hierarchy"
	buttonText:"Select Hierarchy"
	icon:#("PixGrinder",16)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/Select_Hierarchy.mse"
	)
	
	macroScript Rotation_Activator
	category:"PixGrinder"
	toolTip:"Rotation_Activator"
	buttonText:"Rotation_Activator"
	--icon:#("PixGrinder",16)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/Rotation_Activator.mse"
	)
	
	macroScript CleanLayers
	category:"PixGrinder"
	toolTip:"Clean Layers"
	buttonText:"Clean Layers"
	icon:#("PixGrinder",8)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$userScripts/PixGrinder/CleanLayers.mse"
	)
	
)