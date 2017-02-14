
	addModifier $ (ProOptimizer() ) 
	$.ProOptimizer.MergePoints = true
	$.ProOptimizer.Calculate = true
	$.ProOptimizer.VertexPercent  = 35
	addModifier $ (Smooth() ) 
	$.Smooth.autosmooth = true
	$.Smooth.threshold  = 45
	addModifier $ (Edit_Poly() ) 
	--maxOps.CollapseNode $ true


