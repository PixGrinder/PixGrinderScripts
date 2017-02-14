
(
	clearListener()
	max modify mode
	for i = 1 to selection.count do
	(
		addModifier selection[i] (ProOptimizer())
		selection[i].modifiers[selection[i].modifiers.count].MergePoints = true
		selection[i].modifiers[selection[i].modifiers.count].MergePointsThreshold = 0.1
		selection[i].modifiers[selection[i].modifiers.count].Calculate = true
		addModifier selection[i] (Smooth())
		collapseStack selection[i]
		convertToPoly selection[i]
	)
	-- clearListener()
)

