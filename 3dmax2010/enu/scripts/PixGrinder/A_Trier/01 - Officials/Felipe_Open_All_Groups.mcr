-------------------------------------------------------------------------------
-- Felipe_Open_All_Groups.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE (dassonphil@gmail.com)
-- Max 2010 :  Install in : 3ds Max 2010\ui\macroscripts
-- Max 2013 :  Install in : 3ds Max 2013\macroscripts
-- 2013/06/18
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript Open_All_Groups
category:"Felipe Scripts"
toolTip:"Open All Groups"
buttonText:"Open all groups"
--icon:#("Felipe Scripts",11)
silentErrors:true
autoUndoEnabled:true


(
	for i = 1 to 100 do (
		select helpers
		max group open
	)
)


