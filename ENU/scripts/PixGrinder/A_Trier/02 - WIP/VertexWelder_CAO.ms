
-- CAO Vertex Welder --


(
	clearListener()
	max modify mode
	addModifier $ (ProOptimizer())
	$.modifiers[$.modifiers.count].MergePoints = true
	$.modifiers[$.modifiers.count].MergePointsThreshold = 0.1
	$.modifiers[$.modifiers.count].Calculate = true
	addModifier $ (Smooth())
	collapseStack $
	convertToPoly $
	clearListener()
)

