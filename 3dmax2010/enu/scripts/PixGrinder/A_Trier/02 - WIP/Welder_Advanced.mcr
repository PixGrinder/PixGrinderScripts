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
	addModifier $ (ProOptimizer() ) 
	$.ProOptimizer.MergePoints = true  
	$.ProOptimizer.Calculate = true 
	addModifier $ (Smooth() ) 
	$.Smooth.autosmooth = true
	addModifier $ (Edit_Poly() ) 
	maxOps.CollapseNode $ true
	max modify mode
	subObjectLevel = 4
	$.selectByAngle = true
	$.selectAngle=45
)
