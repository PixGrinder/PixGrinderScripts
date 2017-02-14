-- reRotator v2
(
	clearListener()
	myPath = "D:\10 - Helicopters\AS365VMT\AH_AS365_3Dfiles\MAX\BadRotate\Good"
	files = getFiles (myPath+"\*.max")
	
	fn reRotate =
	(
		myRot = (eulerAngles 0 -3 0)
		myDum = Dummy name:"temp" position:[0,0,0]
		for obj in objects where obj != myDum do obj.parent = myDum
		select myDum
		max rotate
		toolMode.selectionCenter()
		rotate myDum myRot
		delete myDum
		for obj in objects do 
		(
			resetXform obj
			convertToPoly obj
		)
		max select none
	)
	
	
	
-- 	for obj in files do print obj
		
	for obj in files do
	(
		loadMaxFile obj useFileUnits:true quiet:true
		reRotate()
		saveMaxFile obj useNewFile:true quiet:true
	)
	
	
)