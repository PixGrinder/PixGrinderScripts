-------------------------------------------------------------------------------
-- Felipe_Export_By_Object.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE ( gloom2004@yahoo.fr)
-- 2012/09/17
-- Install in : 3ds Max 2010\ui\macroscripts
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript Export_By_Objects
category:"Felipe Scripts"
toolTip:"Export Each Scene Object Separately"
(
	obj = objects as array
	for i = 1 to obj.count do (
	select obj[i]
	max select invert
	delete selection
	exportFile ( "d:/" + obj[i].name + ".reb") #noprompt selectedOnly:true using:RebExportExporterPlugin
	max undo
	)
)
