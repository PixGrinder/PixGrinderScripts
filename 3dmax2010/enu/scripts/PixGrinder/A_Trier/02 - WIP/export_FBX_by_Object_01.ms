-------------------------------------------------------------------------------
-- Felipe_Export_By_Object.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE (dassonphil@gmail.com)
-- Max 2010 :  Install in : 3ds Max 2010\ui\macroscripts
-- Max 2013 :  Install in : 3ds Max 2013\macroscripts
-- 2012/09/17
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript Export_By_Objects
category:"Felipe Scripts"
toolTip:"Export Each Scene Object Separately"
buttonText:"Export by object"
--icon:#("Felipe Scripts",11)
silentErrors:true
autoUndoEnabled:true


(
	obj = selection as array
	for i = 1 to obj.count do (
	select obj[i]
	max select invert
	delete selection
	exportFile ( "d:/" + obj[i].name + ".fbx") #noprompt selectedOnly:true using:FBXEXP
	max undo
	)
)
