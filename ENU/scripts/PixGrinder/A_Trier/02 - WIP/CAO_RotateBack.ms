-- reRotator
(
	clearListener()
	myPath = "D:\10 - Helicopters\AS365VMT\AH_AS365_3Dfiles\MAX\\"
	files = getFiles (myPath+"*.max")
	
	fn reRotate =
	(
		myRot = (eulerAngles 0 -3 0)
		select objects
		max rotate
		toolMode.transformCenter()
		rotate objects myRot
		for obj in objects do resetXform obj
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