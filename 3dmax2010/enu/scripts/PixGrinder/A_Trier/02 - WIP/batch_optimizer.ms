-- batch_optimizer.ms
(
	setCommandPanelTaskMode #modify
	clearListener()
	myAr = for obj in selection where superClassOf obj == GeometryClass collect obj
	select myAr
	myProg = 0
	-- Assign proOptimizer modifier to all objects of selection
	for i = 1 to myAr.count do 
	(
		addModifier myAr[i] (ProOptimizer vertexPercent:35.0)
	)


	progressStart "Processing..." -- Start ProgressBar 
	-- Enable ProOptim calculation on all objects --
	for i = 1 to myAr.count do 
	(
		if (100*(i as float)/(myAr.count as float) > (myProg as float)) do  --then print "youpi" else print ((obj as float)/gem.count) as string
		(
			myProg = myProg+1
			progressUpdate myProg
		)
		myAr[i].modifiers[1].calculate = on
		convertToPoly myAr[i]
	)
	progressEnd()
)
