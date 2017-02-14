-------------------------------------------------------------------------------
-- Felipe_Select_Previous_Object.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE ( gloom2004@yahoo.fr)
-- 2012/08/24
-- Install in : 3ds Max 2010\ui\macroscripts
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript Select_Previous_Object
category:"Felipe Scripts"
toolTip:"Select Previous Object"
buttonText:"Select Previous Object"
icon:#("Felipe Scripts",3)
silentErrors:true
autoUndoEnabled:false
(
	c = $selection as array
	max select all
	all = $selection as array
	v = findItem all c[1]
	nt = all.count
	if v-1 < 1 then select all[nt]  else ( 
	v=v-1
	select all[v]
	)
)