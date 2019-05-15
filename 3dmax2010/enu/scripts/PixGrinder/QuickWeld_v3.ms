-------------------------------------------------------------------------------
-- Welder_Advanced.ms
-- MacroScripts File
-- By Philippe DASSONVILLE ( ph_dassonville@yahoo.fr)
-- 2018/03/22

-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

(
	max modify mode
	mySelec = for obj in selection where superClassOf obj == GeometryClass collect obj
	global myOptim = ProOptimizer()
	global mySmooth = Smooth()
	myOptim.MergePoints = true  
	myOptim.MergePointsThreshold = 0.0001
	myOptim.Calculate = true
	mySmooth.autosmooth = true
	mySmooth.threshold = 20.0

	for obj in mySelec do 
	(
		--obj = mySelec[i]
		select obj
		ResetXForm obj
		convertToPoly obj
		addModifier obj myOptim
		obj.modifiers[1].Calculate = true
		addModifier obj mySmooth
		convertToPoly obj
		
	)
)
