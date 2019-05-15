-------------------------------------------------------------------------------
-- Felipe_Collapse_Selected_Hierarchy.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE ( gloom2004@yahoo.fr)
-- 2012/08/24
-- Install in : 3ds Max 2010\ui\macroscripts
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript CollapseSelectedHierarchy
category:"Felipe Scripts"
toolTip:"Collapse Selected Hierarchy.mcr"



(
for obj in selection do maxOps.CollapseNodeTo obj 1 off
)
