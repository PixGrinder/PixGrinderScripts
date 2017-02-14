-- CAO_Cleaner

(
	clearListener()
	units.DisplayType  = #Metric
	units.MetricType = #Millimeters
	units.SystemType = #Centimeters
	units.SystemScale = 10.0		
	myMod = Vertex_Weld()
	myMod.threshold = 0.0001
	mySmooth = Smooth()
	mySmooth.threshold = 20
	mySmooth.autosmooth = true
	myProg = 0
	
	
	progressStart "Processing..."
	
	for obj in geometry do 
	(
		if obj.parent != undefined do obj.name = obj.parent.name
	)
	
	progressUpdate 33
	
	for obj in objects do 
	(
		obj.parent = undefined
	)
	delete helpers
	
	progressUpdate 66
	
	for obj in geometry do
	(
		obj.pivot = obj.center -- center pivot
		resetXform obj
		convertToPoly obj
	)
	
	progressUpdate 100
	
	progressEnd()
	
	progressStart "Welding Vertices..."
	
	
	for i = 1 to geometry.count do
	(
			
		if (100*(i as float)/geometry.count > (myProg as float)) do  --then print "youpi" else print ((obj as float)/gem.count) as string
		(
			myProg = myProg+1
			progressUpdate myProg
		)
		obj = geometry[i]
		addmodifier obj myMod
		addmodifier obj (smooth())
		addmodifier obj mySmooth
		convertToPoly obj
	)
	
	progressEnd()
	
)