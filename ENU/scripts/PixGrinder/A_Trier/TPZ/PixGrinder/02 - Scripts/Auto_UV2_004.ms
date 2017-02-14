-- Auto UV2 Flatten
(
	
	rollout myProgress "ProgressBar"
	(
		progressBar theBar value:0
	)
	createDialog myProgress width:500
	
	
	myMod = unwrap_UVW()
	myMod.setMapChannel 2
	myMod.Name = "TPZ_Unwrapper"
	for i = 1 to geometry.count do
	(
		if (100*(i as float)/geometry.count > (myProgress.theBar.value as float)) do  --then print "youpi" else print ((obj as float)/gem.count) as string
		(
			myProgress.theBar.value = myProgress.theBar.value+1
		)
		select geometry[i]
		max modify mode
		addModifier geometry[i] myMod
		subobjectLevel = 3
		max select all
		-- redrawViews()
		myMod.flattenMap 66.0 #() 0.01 true 0 true true
		subobjectLevel = 0
		--collapseStack geometry[i]
	)
)



-- deleteModifier geometry geometry.modifiers["Unwrap UVW"]


myProgress.theBar.value = 10