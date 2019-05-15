-- VRML to Max  - H145 Specific
-- V 5.0

(
	disableSceneRedraw()
	wantedPath = getDir #scene
	myStdPath = "c:"+"\\"
	if doesFileExist wantedPath == true then myStdPath = wantedPath
	
	exp_path = getSavePath caption:"Choose Input WRL Files : " initialDir:myStdPath

	myInput = exp_path + "\\"


	fn sortBySize file1 file2=
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


	fn ProcessCAO a b c d e f g =
	(
		ScaleRatio = g
		myOffset = [a,b,c]
		myRot = (eulerAngles d e f)
		myProg = 0
		
		
		myMod = Vertex_Weld()
		myMod.threshold = 0.0001
		mySmooth = Smooth()
		mySmooth.threshold = 20
		mySmooth.autosmooth = true
		
		delete helpers
		
		myDummy = dummy pos:[0,0,0]
		myDummy.name = "CAO_Positionner"
		
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



	files = getFiles (myInput+"*.wrl")
	qsort files sortBySize


	for i = 1 to files.count do
	(
		resetMaxFile #noPrompt
		--files[i]
		SysUnit()
		importFile files[i] #noPrompt  using:VrmlImp
		ProcessCAO 1.691 0.0 -3.09 0.0 -3.5 0.0 10.0 -- Original
-- 		ProcessCAO 1.883 0.0 -2.99 0.0 -3.5 0.0 10.0 -- Working or me
		viewport.setLayout #layout_4
		viewport.activeViewport = 4
		max tool maximize

		delete cameras
		select geometry
		max zoomext sel all
		y1 = "CAO_ATA_" + getFilenameFile files[i]
		myLayer = LayerManager.newLayerFromName y1
		for obj in objects do myLayer.addnode obj
		x1 = myInput+(getFilenameFile files[i])+".max"
-- 		max vpt persp user
		clearSelection()
		select geometry[1]
		max zoomext sel all
		select geometry
		max zoomext sel all
		enableSceneRedraw()
		sleep 1
		forceCompleteRedraw doDisabled:true
		saveMaxFile x1 useNewFile:true --quiet:<bool>
	)
)











