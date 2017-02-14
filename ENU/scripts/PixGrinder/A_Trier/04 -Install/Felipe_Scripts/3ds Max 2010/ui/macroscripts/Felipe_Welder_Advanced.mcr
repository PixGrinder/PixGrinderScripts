-------------------------------------------------------------------------------
-- Felipe_Welder_Advanced.mcr
-- MacroScripts File
-- By Philippe DASSONVILLE ( ph_dassonville@yahoo.fr)
-- 2013/10/25
-- Install in : 3ds Max 2010\ui\macroscripts
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

macroScript Welder_Advanced
category:"Felipe Scripts"
toolTip:"Advanced Welder"



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
