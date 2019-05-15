-- Auto UV2 Flatten
(
	clearListener()
	myMod = unwrap_UVW()
	myMod.setMapChannel 2
	myMod.Name = "TPZ_Unwrapper"
	for i = 1 to geometry.count do
	(
		select geometry[i]
		max modify mode
		addModifier geometry[i] myMod
		subobjectLevel = 3
		max select all
		-- redrawViews()
		myMod.flattenMap 66.0 #() 0.01 true 0 true true
		subobjectLevel = 0
		collapseStack geometry[i]
	)
)



