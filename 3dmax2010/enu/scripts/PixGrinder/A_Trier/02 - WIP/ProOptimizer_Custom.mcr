macroScript ProOptimizer_Custom
	category:"Felipe Scripts"
	toolTip:"ProOptimizer_Custom"
(
	-- variables : 
	---------------
		
		local pda_percent = 20    -- poucentage d'optim du ProOptimizer
		
		local pda_thresh = 60    -- poucentage de lissage du Smooth
		
		------------------------------
		
	-- script :
	------------
		
		addModifier $ (ProOptimizer() ) 
		$.modifiers[#ProOptimizer].MergePoints = on
		$.modifiers[#ProOptimizer].Calculate = on
		$.modifiers[#ProOptimizer].VertexPercent  = pda_percent
		addModifier $ (Smooth() ) 
		$.modifiers[#Smooth].autosmooth = on
		$.modifiers[#Smooth].threshold  = pda_thresh
		addModifier $ (Edit_Poly() ) 
)
