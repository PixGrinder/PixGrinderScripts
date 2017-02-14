-------------------------------------------------------------------------------
-- Felipe_Delete_Unselected_Objects.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE (dassonphil@gmail.com)
-- Max 2010 :  Install in : 3ds Max 2010\ui\macroscripts
-- Max 2013 :  Install in : 3ds Max 2013\macroscripts
-- 2012/10/05
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript Delete_Unselected_Objects
category:"Felipe Scripts"
toolTip:"Delete_Unselected_Objects"
buttonText:"Delete_Unselected"
--icon:#("Felipe Scripts",11)
silentErrors:true
autoUndoEnabled:true

(
c=#()
for obj in objects do (
	if obj != $ do append c obj

)

delete c
)
