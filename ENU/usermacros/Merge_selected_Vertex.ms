
(
	clearListener()
	max modify mode
	for obj in selection do
	(
		addModifier obj (ProOptimizer())
		obj.modifiers[obj.modifiers.count].MergePoints = true
		obj.modifiers[obj.modifiers.count].MergePointsThreshold = 0.1
		obj.modifiers[obj.modifiers.count].Calculate = true
		addModifier obj (Smooth())
		collapseStack obj
		convertToPoly obj
	)
	-- clearListener()
)

