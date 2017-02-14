
-- CAO Welder v2

(
	clearListener()
	i = 1
	mySelec = selection as array
	for obj in mySelec do 
	(
		max modify mode
		print ((i as string)+" : "+obj.name)
		addModifier obj (ProOptimizer())
		obj.modifiers[obj.modifiers.count].MergePoints = true
		obj.modifiers[obj.modifiers.count].MergePointsThreshold = 0.1
		obj.modifiers[obj.modifiers.count].Calculate = true
		addModifier obj (Smooth())
		collapseStack obj
		convertToPoly obj
		i = i+1
		-- clearListener()
	)
)

