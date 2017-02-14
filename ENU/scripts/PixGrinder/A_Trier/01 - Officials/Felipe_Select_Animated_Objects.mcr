-------------------------------------------------------------------------------
-- Felipe_Select_Animated_Objects.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE (dassonphil@gmail.com)
-- Max 2010 :  Install in : 3ds Max 2010\ui\macroscripts
-- Max 2013 :  Install in : 3ds Max 2013\macroscripts
-- 2012/10/03
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript Select_Animated_Objects
category:"Felipe Scripts"
toolTip:"Selects All Animated Objects in Scene"
buttonText:"Select Anims"
--icon:#("Felipe Scripts",11)
silentErrors:true
autoUndoEnabled:true

(

for i = 0 to (layermanager.count-1) do (
	lay = layermanager.getLayer i
	lay.on = true
)


ar_anim = #()
for obj in objects do (
	if obj.isAnimated == true do append ar_anim obj
)
max select none
select ar_anim

)