-------------------------------------------------------------------------------
-- Felipe_Remove_Empty_Layers.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE (dassonphil@gmail.com)
-- Max 2010 :  Install in : 3ds Max 2010\ui\macroscripts
-- Max 2013 :  Install in : 3ds Max 2013\macroscripts
-- 2012/10/04
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript Remove_Empty_Layers
category:"Felipe Scripts"
toolTip:"Remove Empty Layers"
buttonText:"Remove Empty Layers"
icon:#("Felipe Scripts",8)
silentErrors:true
autoUndoEnabled:true

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