-------------------------------------------------------------------------------
-- Felipe_Delete_Unselected_Objects.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE ( gloom2004@yahoo.fr)
-- 2012/10/05
-- Install in : 3ds Max 2010\ui\macroscripts
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript Delete_Unselected_Objects
category:"Felipe Scripts"
toolTip:"Delete_Unselected_Objects"

(
c=#()
for obj in objects do (
	if obj != $ do append c obj

)

delete c
)
