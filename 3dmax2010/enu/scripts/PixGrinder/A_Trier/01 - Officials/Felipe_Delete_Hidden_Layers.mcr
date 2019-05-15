-------------------------------------------------------------------------------
-- Felipe_Delete_Hidden_Layers.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE (dassonphil@gmail.com)
-- Max 2010 :  Install in : 3ds Max 2010\ui\macroscripts
-- Max 2013 :  Install in : 3ds Max 2013\macroscripts
-- 2013/02/15
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript Delete_Hidden_Layers
category:"Felipe Scripts"
toolTip:"Deletes Hidden Layers and their objects"
buttonText:"Delete_Hidden_Layers"
--icon:#("Felipe Scripts",11)
silentErrors:true
autoUndoEnabled:true

(
for x = 1 to (layermanager.count-1) do (
		lx = layermanager.getLayer x
		if lx.on == false do (
			lx.select on
			delete selection
		)
)
)