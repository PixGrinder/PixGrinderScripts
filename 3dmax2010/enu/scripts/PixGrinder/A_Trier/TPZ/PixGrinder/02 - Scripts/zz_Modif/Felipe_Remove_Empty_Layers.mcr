-------------------------------------------------------------------------------
-- Felipe_Remove_Empty_Layers.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE ( gloom2004@yahoo.fr)
-- 2012/10/04
-- Install in : 3ds Max 2010\ui\macroscripts
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript Remove_Empty_Layers
category:"Felipe Scripts"
toolTip:"Remove Empty Layers"

(

l_ar = #()

l0 = layermanager.getLayer 0
l0.current = true

for i = 1 to (layermanager.count-1) do (
	x = layermanager.getLayer i
	append l_ar x.name
)
for j = 1 to l_ar.count do layermanager.deleteLayerByName l_ar[j]


)