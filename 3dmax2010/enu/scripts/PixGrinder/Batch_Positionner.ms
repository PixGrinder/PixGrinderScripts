-- Batch_Positionner
-- v1.2
(

	myStdPath = "c:"+"\\"
	myInput = getSavePath caption:"Choose MAX Files to process : " initialDir:myStdPath
	myInput = myInput +"\\"
	files = getFiles (myInput+"*.max")
	
	
	fn changePos myFile = 
	(
		loadMaxFile myFile useFileUnits:true quiet:true
		myOffset = [-18,0,-44]
		myDummy = dummy pos:[0,0,0]
		try myDummy.name = (substring maxFileName 1 4) catch ()
		
		for obj in geometry do obj.backfacecull = off
		for obj in objects where obj != myDummy do obj.parent = myDummy
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
		clearSelection()
		max zoomext sel all
		completeRedraw()
		saveMaxFile files[i] useNewFile:true quiet:true
	)

)

---------------------------------------------

fn ProcessCAO myFile a b c d e f g =
	(
		loadMaxFile myFile useFileUnits:false quiet:true
		ScaleRatio = g
		myOffset = [a,b,c]
		myRot = (eulerAngles d e f)
		myProg = 0
		
		
		myMod = Vertex_Weld()
		myMod.threshold = 0.0001
		mySmooth = Smooth()
		mySmooth.threshold = 20
		mySmooth.autosmooth = true
		
		
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
			obj.backfacecull = off
		)
		
		
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
		)
		
		progressEnd()



		