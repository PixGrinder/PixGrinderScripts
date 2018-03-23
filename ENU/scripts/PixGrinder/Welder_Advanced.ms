-------------------------------------------------------------------------------
-- Welder_Advanced.ms
-- MacroScripts File
-- By Philippe DASSONVILLE ( ph_dassonville@yahoo.fr)
-- 2018/03/22

-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

(
	myOptim = ProOptimizer()
	mySmooth = Smooth()
	myOptim.MergePoints = true  
	myOptim.MergePointsThreshold = 0.0001
	-- myOptim.Calculate = true
	mySmooth.autosmooth = true
	mySmooth.threshold = 20.0
	for obj in selection do 
	(
		addModifier obj myOptim
		$.modifiers[1].Calculate = true
		addModifier obj mySmooth
		convertToPoly obj
		ResetXForm obj
		convertToPoly obj
	)
	
-- 	max modify mode
-- 	subObjectLevel = 4
	-- $.selectByAngle = true
	-- $.selectAngle=45
)
