-------------------------------------------------------------------------------
-- Felipe_Assign_Linear_Controllers.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE ( gloom2004@yahoo.fr)
-- 2012/09/06
-- Install in : 3ds Max 2010\ui\macroscripts
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript Assign_Linear_Controllers
category:"Felipe Scripts"
toolTip:"Assign Linear Controllers to selection"

(
	for obj in selection do (
	obj.pos.controller = linear_position ()
	obj.rotation.controller = linear_rotation ()
	)
)