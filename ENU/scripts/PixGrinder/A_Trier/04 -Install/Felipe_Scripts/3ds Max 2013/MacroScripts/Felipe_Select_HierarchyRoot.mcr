-------------------------------------------------------------------------------
-- Felipe_Select_HierarchyRoot.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE (phda2000-fb@yahoo.fr)
-- 2014/04/18
-- Install in : 3ds Max 2010\ui\macroscripts
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------


macroScript Select_Hierarchy_root
category:"Felipe Scripts"
toolTip:"Select Hierarchy Root"
(
	x = GetCurrentSelection()
	x = x[1]
	while x.parent != undefined do x=x.parent
	select x
)

