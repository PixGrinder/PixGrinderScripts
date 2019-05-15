-------------------------------------------------------------------------------
-- Felipe_Welder_Advanced.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE (dassonphil@gmail.com)
-- Max 2010 :  Install in : 3ds Max 2010\ui\macroscripts
-- Max 2013 :  Install in : 3ds Max 2013\macroscripts
-- 2013/10/25
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript Welder_Advanced
category:"Felipe Scripts"
toolTip:"Advanced Welder"
buttonText:"Advanced Welder"
icon:#("Felipe Scripts",13)
silentErrors:true
autoUndoEnabled:true


(

	-- variables : 
	---------------
	
	pda_angle = 45 -- angle du "select by angle"
	
	pda_smth = on -- smooth on ou off
	


	-- script :
	------------

	addModifier $ (ProOptimizer() ) 
	$.modifiers[#ProOptimizer].MergePoints = on
	$.modifiers[#ProOptimizer].Calculate = on
	addModifier $ (Smooth() ) 
	$.modifiers[#Smooth].autosmooth = pda_smth
	addModifier $ (Edit_Poly() ) 
	maxOps.CollapseNode $ true
	max modify mode
	subObjectLevel = 4
	$.selectByAngle = true
	$.selectAngle = pda_angle
)
