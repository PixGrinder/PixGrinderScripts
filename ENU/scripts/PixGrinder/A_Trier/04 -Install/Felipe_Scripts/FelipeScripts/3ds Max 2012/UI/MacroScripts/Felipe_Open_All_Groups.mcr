-------------------------------------------------------------------------------
-- Felipe_Open_All_Groups.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE ( gloom2004@yahoo.fr)
-- 2013/06/18
-- Install in : 3ds Max 2010\ui\macroscripts
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript Open_All_Groups
category:"Felipe Scripts"
toolTip:"Open All Groups"

(
	for i = 1 to 100 do (
		select helpers
		max group open
	)
)


