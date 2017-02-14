-------------------------------------------------------------------------------
-- Felipe_Select_Hierarchy.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE (phda2000-fb@yahoo.fr)
-- 2014/04/18
-- Install in : 3ds Max 2010\ui\macroscripts
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------


macroScript Select_Hierarchy
category:"Felipe Scripts"
toolTip:"Select Hierarchy"

(
local pda_ar = #()
x = getCurrentSelection()
x= x[1]
while x.parent != undefined do x=x.parent
append pda_ar x
for i = 1 to x.children.count do append pda_ar x.children[i]
select pda_ar
)