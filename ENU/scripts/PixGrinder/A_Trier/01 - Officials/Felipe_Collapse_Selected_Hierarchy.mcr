-------------------------------------------------------------------------------
-- Felipe_Collapse_Selected_Hierarchy.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE (dassonphil@gmail.com)
-- Max 2010 :  Install in : 3ds Max 2010\ui\macroscripts
-- Max 2013 :  Install in : 3ds Max 2013\macroscripts
-- 2014/10/02
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript Collapse_Selected
category:"Felipe Scripts"
toolTip:"Collapse Hierarchy on Selection"
buttonText:"Collapse Selected"
icon:#("Felipe Scripts",1)
silentErrors:true
autoUndoEnabled:true
(
for obj in selection do maxOps.CollapseNodeTo obj 1 off
)
