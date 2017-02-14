-------------------------------------------------------------------------------
-- Felipe_Select_Hierarchy.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE (dassonphil@gmail.com)
-- Max 2010 :  Install in : 3ds Max 2010\ui\macroscripts
-- Max 2013 :  Install in : 3ds Max 2013\macroscripts
-- 2014/04/18
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------


macroScript Select_Hierarchy
category:"Felipe Scripts"
toolTip:"Select Hierarchy"
buttonText:"Select Hierarchy"
icon:#("Felipe Scripts",16)
silentErrors:true
autoUndoEnabled:true

(
local pda_ar = #()
x = getCurrentSelection()
x= x[1]
while x.parent != undefined do x=x.parent
append pda_ar x
for i = 1 to x.children.count do append pda_ar x.children[i]
select pda_ar
)