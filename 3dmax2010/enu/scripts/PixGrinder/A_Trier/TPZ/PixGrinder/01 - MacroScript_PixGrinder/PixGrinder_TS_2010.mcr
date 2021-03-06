-------------------------------------------------------------------------------
-- PixGrinder.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE ( pixgrinder@gmail.com )
-- 28/01/2016
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
(
	macroScript Collapse_Selected
	category:"PixGrinder"
	toolTip:"Collapse Hierarchy on Selection"
	buttonText:"Collapse Selected"
	icon:#("PixGrinder",1)
	silentErrors:true
	autoUndoEnabled:true
	(
		Include "$scripts/PixGrinder/Collapse.mse"
	)
	
	macroScript ResetXForm
	category:"PixGrinder"
	toolTip:"ResetXForm on Selection"
	buttonText:"ResetXForm"
	icon:#("PixGrinder",4)
	silentErrors:true
	autoUndoEnabled:true
	(
		Include "$scripts/PixGrinder/ResetXform.mse"
	)
	
	macroScript Select_Previous_Object
	category:"PixGrinder"
	toolTip:"Select Previous Object"
	buttonText:"Select Previous Object"
	icon:#("PixGrinder",3)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$scripts/PixGrinder/Select_Prev.mse"
	)
	
	macroScript Select_Next_Object
	category:"PixGrinder"
	toolTip:"Select Next Object"
	buttonText:"Select Next Object"
	icon:#("PixGrinder",2)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$scripts/PixGrinder/Select_Next.mse"
	)
	
	macroScript Duplicator
	category:"PixGrinder"
	toolTip:"Duplicator"
	buttonText:"Duplictor"
	icon:#("PixGrinder",15)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$scripts/PixGrinder/Duplicator_v2.mse"
	)
	
	macroScript Select_Hierarcy
	category:"PixGrinder"
	toolTip:"Select Hierarchy"
	buttonText:"Select Hierarchy"
	icon:#("PixGrinder",16)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$scripts/PixGrinder/Select_Hierarchy.mse"
	)
	
	macroScript Rotation_Activator
	category:"PixGrinder"
	toolTip:"Rotation_Activator"
	buttonText:"Rotation_Activator"
	--icon:#("PixGrinder",16)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$scripts/PixGrinder/Rotation_Activator.mse"
	)
	
	macroScript CleanLayers
	category:"PixGrinder"
	toolTip:"Clean Layers"
	buttonText:"Clean Layers"
	icon:#("PixGrinder",8)
	silentErrors:true
	autoUndoEnabled:false
	(
		Include "$scripts/PixGrinder/CleanLayers.mse"
	)
	
)