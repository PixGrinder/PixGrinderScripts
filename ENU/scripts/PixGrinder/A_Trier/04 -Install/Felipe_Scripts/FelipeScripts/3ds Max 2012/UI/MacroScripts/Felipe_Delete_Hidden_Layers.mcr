-------------------------------------------------------------------------------
-- Felipe_Delete_Hidden_Layers.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE ( gloom2004@yahoo.fr)
-- 2013/02/15
-- Install in : 3ds Max 2010\ui\macroscripts
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript Delete_Hidden_Layers
category:"Felipe Scripts"
toolTip:"Deletes Hidden Layers and their objects"

(
for x = 1 to (layermanager.count-1) do (
		lx = layermanager.getLayer x
		if lx.on == false do (
			lx.select on
			delete selection
		)
)
)