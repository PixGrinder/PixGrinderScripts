(	
	mySmooth = Smooth()
	mySmooth.threshold = 20
	mySmooth.autosmooth = true
	myProg = 1
	
	progressStart "Processing..."
	
	
	for i = 1 to geometry.count do 
	(
		if (100*(i as float)/geometry.count > (myProg as float)) do  --then print "youpi" else print ((obj as float)/gem.count) as string
		(
			myProg = myProg+1
			progressUpdate myProg
		)
		addmodifier geometry[i] mySmooth
		convertToPoly geometry[i]
		if mod myProg 5 == 0.0 do 
		(
			progressUpdate myProg
			pushPrompt (myProg as String)
		)
	)
		
	progressEnd()
)