(

	clearListener()
	
	myInput = "D:\10 - Helicopters\AS365VMT\AH_AS365_3Dfiles\MAX\\"
	files = getFiles (myInput+"*.max")
	
	

	fn SysUnit =
	(
		resetMaxFile #noPrompt
		units.DisplayType  = #Metric
		units.MetricType = #Millimeters
		units.SystemType = #Centimeters
		units.SystemScale = 10.0
		-- max file import
	)

	fn ReNode =
	(
		for obj in geometry do 
		(
			if obj.parent != undefined do obj.name = obj.parent.name
		)
	)
	
	
	fn ProcessCAO myFile =
	(
		loadMaxFile myFile useFileUnits:false quiet:true
		ScaleRatio = 10
		myOffset = [20,0,39]
		myRot = (eulerAngles 0 -3 0)
		
		
		myMod = Vertex_Weld()
		myMod.threshold = 0.0001
		
		ReNode()
		delete helpers
		
		myDummy = dummy pos:[0,0,0]
		try myDummy.name = (substring maxFileName 1 4) catch ()
		
		for obj in objects where obj != myDummy do obj.parent = myDummy
			
		myDummy.pos = myOffset
		myDummy.scale *= ScaleRatio
		myDummy.rotation = myRot
		delete myDummy
		
		
		for obj in geometry do 
		(
			resetXForm obj
			convertToPoly obj
		)
		
		for obj in geometry do
		(
			addmodifier obj myMod
			addmodifier obj (Smooth())
			--maxOps.CollapseNodeTo obj 1 off
			convertToPoly obj
		)

			

	)

	for i = 1 to files.count do
	(
		SysUnit()
		ProcessCAO files[i]
		saveMaxFile files[i] useNewFile:true quiet:true
	)
	

)