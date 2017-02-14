(
	clearListener()
	myMod = ProOptimizer()
	myMod.MergePointsThreshold = 0.1
	myMod.MergePoints = true

	for obj in selection do
	(
		addmodifier obj myMod
		obj.modifiers[1].Calculate = true
		maxOps.CollapseNodeTo obj 1 off
		addmodifier obj (Smooth())
		maxOps.CollapseNodeTo obj 1 off
	)

)




