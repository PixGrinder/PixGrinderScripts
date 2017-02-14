-- Auto UV2 Flatten
(
	clearListener()
	rollout myProgress "ProgressBar"
	(
		progressBar theBar value:0
		button myButton "OK"
		on myButton pressed do destroyDialog  myProgress 
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
			x1 = myProgress.theBar.value
			if mod x1 20 == 0.0 do
			(
				destroyDialog  myProgress 
				createDialog myProgress width:500
				sleep .1
				myProgress.theBar.value = x1
				sleep .1
			)
		)
		select geometry[i]
		convertToPoly geometry[i]
		polyop.setFaceSelection geometry[i] #{1..(polyop.getNumFaces  geometry[i])}
		addModifier geometry[i] myMod
		subobjectLevel = 3
		max select all
		-- redrawViews()
		myMod.flattenMap 66.0 #() 0.01 true 0 true true
		subobjectLevel = 0
		--collapseStack geometry[i]
	)
)

--MainThread = dotnetobject "System.ComponentModel.BackGroundWorker"



convertToPoly $
x1 = polyop.getNumFaces $
x2 = #{1..(polyop.getNumFaces  geometry[i])}

polyop.setFaceSelection geometry[i] #{1..(polyop.getNumFaces  geometry[i])}
subobjectLevel = 4
i = 1


