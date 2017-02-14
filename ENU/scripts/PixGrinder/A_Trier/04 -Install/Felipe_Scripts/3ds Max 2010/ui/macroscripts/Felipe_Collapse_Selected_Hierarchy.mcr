-------------------------------------------------------------------------------
-- Felipe_Collapse_Selected_Hierarchy.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE ( gloom2004@yahoo.fr)
-- 2013/12/09
-- Install in : 3ds Max 2010\ui\macroscripts
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript Collapse_Selected
category:"Felipe Scripts"
toolTip:"Collapse Hierarchy on Selection"
buttonText:"Collapse Selected"
icon:#("",1)
silentErrors:true
autoUndoEnabled:true
(
for obj in selection do maxOps.CollapseNodeTo obj 1 off
)
