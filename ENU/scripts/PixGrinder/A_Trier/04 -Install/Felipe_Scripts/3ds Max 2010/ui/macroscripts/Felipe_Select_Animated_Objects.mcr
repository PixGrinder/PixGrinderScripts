-------------------------------------------------------------------------------
-- Felipe_Select_Animated_Objects.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE ( gloom2004@yahoo.fr)
-- 2012/10/03
-- Install in : 3ds Max 2010\ui\macroscripts
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript Select_Animated_Objects
category:"Felipe Scripts"
toolTip:"Selects All Animated Objects in Scene"

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