-------------------------------------------------------------------------------
-- Felipe_UV2_Flat.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE (dassonphil@gmail.com)
-- Max 2010 :  Install in : 3ds Max 2010\ui\macroscripts
-- Max 2013 :  Install in : 3ds Max 2013\macroscripts
-- 2014/10/13
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------


macroScript UV2_Flat
category:"Felipe Scripts"
toolTip:"UV2_Flat"
buttonText:"UV2_Flat"
--icon:#("Felipe Scripts",17)
silentErrors:true
autoUndoEnabled:true

(
	pda = getCurrentSelection()
	for i = 1 to pda.count do 
	(
		select pda[i]
		modPanel.addModToSelection (Unwrap_UVW())
		$.modifiers[1].unwrap.setMapChannel 2
		subobjectlevel = 3
		x1 = $.modifiers[1].flattenMap 80 #([1,0,0], [-1,0,0], [0,1,0], [0,-1,0], [0,0,1], [0,0,-1]) 0.02 true 0 false false
	)
)

	
