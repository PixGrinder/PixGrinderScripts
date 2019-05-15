-- H225_Re-Positionner.ms --
-- v 0.1 --

(

	myStdPath = "c:"+"\\"
	myInput = getSavePath caption:"Choose MAX Files to process : " initialDir:myStdPath
	myInput = myInput +"\\"
	files = getFiles (myInput+"*.max")
	
	
	fn changePos myFile = 
	(
		loadMaxFile myFile useFileUnits:true quiet:true
		myOffset = [0,0,2.3]
		myDummy = dummy pos:[0,0,0]
		try myDummy.name = (substring maxFileName 1 4) catch ()
		
		-- for obj in geometry do obj.backfacecull = off
		for obj in objects where obj != myDummy and obj.parent == undefined do obj.parent = myDummy
		myDummy.pos = myOffset
		
		delete myDummy
		
		for obj in geometry do 
		(
			resetXForm obj
			convertToPoly obj
		)
	)
	
	
	
	for i = 1 to files.count do
	(
		changePos files[i]
		max select none
		max zoomext sel all
		completeRedraw()
		saveMaxFile files[i] useNewFile:true quiet:true
	)

)