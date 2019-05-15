-------------------------------------------------------------------------------
-- Felipe_Assign_Linear_Controllers.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE (dassonphil@gmail.com)
-- Max 2010 :  Install in : 3ds Max 2010\ui\macroscripts
-- Max 2013 :  Install in : 3ds Max 2013\macroscripts
-- 2012/09/06
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript Assign_Linear_Controllers
category:"Felipe Scripts"
toolTip:"Assign Linear Controllers to selection"
buttonText:"Assign Linear Ctrl"
icon:#("Felipe Scripts",12)
silentErrors:true
autoUndoEnabled:true

(
	for obj in selection do (
	obj.pos.controller = linear_position ()
	obj.rotation.controller = linear_rotation ()
	)
)