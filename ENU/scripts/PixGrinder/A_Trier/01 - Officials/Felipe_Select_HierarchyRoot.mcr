-------------------------------------------------------------------------------
-- Felipe_Select_HierarchyRoot.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE (dassonphil@gmail.com)
-- Max 2010 :  Install in : 3ds Max 2010\ui\macroscripts
-- Max 2013 :  Install in : 3ds Max 2013\macroscripts
-- 2014/04/18
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------


macroScript Select_Hierarchy_root
category:"Felipe Scripts"
toolTip:"Select Hierarchy Root"
buttonText:"Select Hierarchy Root"
icon:#("Felipe Scripts",17)
silentErrors:true
autoUndoEnabled:true


(
	x = GetCurrentSelection()
	x = x[1]
	while x.parent != undefined do x=x.parent
	select x
)

