-------------------------------------------------------------------------------
-- Felipe_Collapse_selected.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE ( ph_dassonville@yahoo.fr)
-- 2013/10/25
-- Install in : 3ds Max 2010\ui\macroscripts
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript Collapse_selected
category:"Felipe Scripts"
toolTip:"Collapse Selected Hierarchy"



(
	for obj in selection do (
		maxOps.CollapseNode obj true
	)
	
)
