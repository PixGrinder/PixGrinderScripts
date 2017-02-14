-- Auto UV 2

(
	clearListener()
	--select geometry[1]
	global myMod = unwrap_UVW()
	myMod.setMapChannel 2
	myMod.name = "FelipeUnwrap"
	global myProg = 0
	max modify mode
	progressStart "Unwrapping UVs 2..."
	
	for i = 1 to geometry.count do
	(
		select geometry[i]
		convertToPoly geometry[i]
		addmodifier geometry[i] myMod
		--selection[1].modifiers["FelipeUnwrap"].setMapChannel 2
		subobjectlevel = 3
		max select all
		geometry[i].modifiers[1].flattenMap 66.0 #() 0.01 true 0 true true
		subobjectlevel = 0
		collapseStack geometry[i]
		if (100*(i as float)/geometry.count > (myProg as float)) do  --then print "youpi" else print ((obj as float)/gem.count) as string
		(
			myProg = myProg+1
			progressUpdate myProg
		)
	)
	progressEnd()
)