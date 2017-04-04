-- CAO Post Import Processing -- 
-- v8.0 --



-----------------------------------------------------------------------------
--   !!!   CONFIGURE VALUES IN ProcessCAO FUNCTION TO PREVENT ERRORS   !!! --
-----------------------------------------------------------------------------


(

	clearListener()
	
-- 	myInput = "D:\10 - Helicopters\AS365VMT\AH_AS365_3Dfiles\WRL\v6\2016-10-05-3D"+"\\"
-- 	myStdPath = "D:\10 - Helicopters\H225VMT\MAX\CAO\Process"+"\\"
	myStdPath = "c:"+"\\"
	myInput = getSavePath caption:"Choose MAX Files to process : " initialDir:myStdPath
	myInput = myInput +"\\"
	files = getFiles (myInput+"*.max")
	global myParams


	fn sortByDate file1 file2=
	(
		if getFileSize file1 > getFileSize file2 then 1 else -1
	)
	

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
			
	
	)
	
	

	rollout myParams "CAO Offset parameters"
	(
		label txtPos "Position Offset :" offset:[0,15]
		edittext pX text:"0" fieldWidth:35 across:3 offset:[75,25]
		edittext pY text:"0" fieldWidth:35 across:3 offset:[45,25]
		edittext pZ text:"0" fieldWidth:35 across:3 offset:[10,25]


		label txtRot "Rotation Offset :" offset:[0,15]
		edittext rX text:"0" fieldWidth:35 across:3 offset:[75,25]
		edittext rY text:"0" fieldWidth:35 across:3 offset:[45,25]
		edittext rZ text:"0" fieldWidth:35 across:3 offset:[10,25]

		label txtScale "Scale Offset :" offset:[0,15]
		edittext sX text:"0" fieldWidth:35 align:#center

		button processButton "OK" width: 150

		on processButton pressed do
		(
			qsort files sortByDate
			a1 = (pX.text as float)
			a2 = (pY.text as float)
			a3 = (pZ.text as float)			
			a4 = (rX.text as float)
			a5 = (rY.text as float)
			a6 = (rZ.text as float)
			a7 = (sX.text as float)


			for i = 1 to files.count do
			(
				SysUnit()
				ProcessCAO files[i] a1 a2 a3 a4 a5 a6 a7
				max select none
				max zoomext sel all
				completeRedraw()
				saveMaxFile files[i] useNewFile:true quiet:true
			)
		)

	)

	try (destroyDialog myParams) catch ()
	createDialog myParams 450 450 512 256



)