-- Auto UV2 Flatten
(
	global myProg = 1
	progressStart "Unwrapping UVs 2..."
	for i = 1 to geometry.count do
	(
		select geometry[i]
		max modify mode
		x1 = unwrap_UVW()
		modPanel.addModToSelection x1
		subobjectLevel = 3
		max select all
		redrawViews()
		myMod = geometry[i].modifiers["Unwrap UVW"]
		myMod.setMapChannel 2
		myMod.flattenMap 66.0 #() 0.01 true 0 true true
		collapseStack geometry[i]
		
		if (100*(i as float)/geometry.count > (myProg as float)) do  --then print "youpi" else print ((obj as float)/gem.count) as string
		(
			myProg = myProg+1
			progressUpdate myProg
		)
	)
	progressEnd()
)



-- deleteModifier geometry geometry.modifiers["Unwrap UVW"]