---------------------------------------------------------------------

-- PixGrinder Scripts --
-- CAO Post Import Processing  --
-- Optimizes CAO Placement / hierarchy n Geometry after brut import --
-- V 8.3 --

---------------------------------------------------------------------


-- Default Values by AC --
-- H135   : Position = [0.0,-0.33,0.0] ; Rotation = [0.0,-30,0.0]; Scale=10
-- H145   : Position = [1.68,0,-3.1] ; Rotation = [0.0,-3.5,0.0]; Scale=10 
-- AS365  : Position = [7.13,0.0,39.0] ; Rotation = [0.0,0.0,0.0]; Scale=10 
-- H225   : Position = [0.0,0.0,12.05] ; Rotation = [0.0,0.0,0.0]; Scale=10 


(

	clearListener()
	 

	----------------------------------------------------------------------
	-- TPZ Specific
	--	callbacks.removeScripts #filePreOpenProcess id:#UpdateFileOnOpenCb
	-- TPZ Specific
	----------------------------------------------------------------------
	wantedPath  = maxfilepath -- default path 1 
	myStdPath = "$scenes" 											-- default path 2 if path 1 doesn't exist 
	if doesFileExist wantedPath == true then myStdPath = wantedPath
	myInput = getSavePath caption:"Choose MAX Files to process : " initialDir:myStdPath -- browser popoup
	myInput = myInput +"\\"
	files = getFiles (myInput+"*.max") -- prendre tous les max du dossier
	myProcessDir = myInput + "Processed" + "\\" -- créer dossier Processed
	MakeDir myProcessDir-- créer dossier Processed
	-- obj = files[1]
	for obj in files do copyfile obj (myProcessDir+(filenamefrompath obj)) -- copier tous les fichiers dans dossier processed
	files = getFiles (myProcessDir +"*.max") -- files = tous les fichiers max à traiter
	global myParams


	-- fonction trier par taille de fichier 
	fn sortBySize file1 file2 =
	(
		if getFileSize file1 > getFileSize file2 then 1 else -1
	)
	

	-- fonction pour mettre les bons parametres d'échelle
	fn SysUnit =
	(
		resetMaxFile #noPrompt
		units.DisplayType  = #Metric
		units.MetricType = #Millimeters
		units.SystemType = #Centimeters
		units.SystemScale = 10.0
		-- max file import
	)

	-- ReNode V1 - OBSOLETE: Pour chaque objet qui a un parent, lui donner le nom du parent --
	/*
	fn ReNode =
	(
		for obj in geometry do 
		(
			if obj.parent != undefined do obj.name = obj.parent.name
		)
	)
	*/




	
	fn ProcessCAO myFile a b c d e f g =
	(
		loadMaxFile myFile useFileUnits:false quiet:true
		max unhide all
		ScaleRatio = g
		myOffset = [a,b,c]
		myRot = (eulerAngles d e f)
		myProg = 0
		
		-- creation du modifier VertexWeld et Smooth avec parametres custom --
		myMod = Vertex_Weld()
		myMod.threshold = 0.0001
		mySmooth = Smooth()
		mySmooth.threshold = 20
		mySmooth.autosmooth = true
		
		fileIn ("C:/Users/guest1182/AppData/Local/Autodesk/3dsMax/2016 - 64bit/ENU/scripts/PixGrinder/A_Trier/02 - WIP/CAO_Dummy_Fix.ms")
		--ReNode() -- executer ReNode
		-- delete helpers -- supprimer les dummy


		myDummy = dummy pos:[0,0,0]
		try myDummy.name = (substring maxFileName 1 4) catch ()
		
		myTempAr = for obj in objects where obj.parent == undefined and obj != myDummy collect obj
		for obj in myTempAr do obj.parent = myDummy
			
		myDummy.pos = myOffset
		myDummy.scale *= ScaleRatio
		myDummy.rotation = myRot
		delete myDummy
		
		
		for obj in geometry do 
		(
			tempParent = obj.parent
			obj.parent = undefined
			resetXForm obj
			convertToPoly obj
			obj.parent = tempParent
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
		label theInfos1 "H135   : Position = [0.0,-0.33,0.0] ; Rotation = [0.0,-30,0.0]; Scale=10"
		label theInfos2 "H145   : Position = [1.68,0,-3.1] ; Rotation = [0.0,-3.5,0.0]; Scale=10"
		label theInfos3 "AS365  : Position = [7.13,0.0,39.0] ; Rotation = [0.0,0.0,0.0]; Scale=10"
		label theInfos4 "H225   : Position = [0.0,0.0,12.05] ; Rotation = [0.0,0.0,0.0]; Scale=10"
		label txtPos "Position Offset :" offset:[0,15]
		
		edittext pX text:"0" fieldWidth:35 across:3 offset:[75,25]
		edittext pY text:"0" fieldWidth:35 across:3 offset:[45,25]
		edittext pZ text:"0" fieldWidth:35 across:3 offset:[10,25]


		label txtRot "Rotation Offset :" offset:[0,15]
		edittext rX text:"0" fieldWidth:35 across:3 offset:[75,25]
		edittext rY text:"0" fieldWidth:35 across:3 offset:[45,25]
		edittext rZ text:"0" fieldWidth:35 across:3 offset:[10,25]

		label txtScale "Scale Offset :" offset:[0,15]
		edittext sX text:"100" fieldWidth:35 align:#center

		button processButton "OK" width: 150

		on processButton pressed do
		(
			qsort files sortBySize
			a1 = (pX.text as float)
			a2 = (pY.text as float)
			a3 = (pZ.text as float)			
			a4 = (rX.text as float)
			a5 = (rY.text as float)
			a6 = (rZ.text as float)
			a7 = (sX.text as float)


			for i = 1 to files.count do
			(
				disableSceneRedraw()
				SysUnit()
				ProcessCAO files[i] a1 a2 a3 a4 a5 a6 a7
				viewport.setLayout #layout_4
				viewport.activeViewport = 4
				viewport.setType #view_persp_user
				max tool maximize
				clearSelection()
				select geometry[1]
				max zoomext sel all
				select geometry
				enableSceneRedraw()
				forceCompleteRedraw doDisabled:true
				select geometry
				max zoomext sel all
				clearSelection()
				viewport.setGridVisibility #all false
				-- NitrousGraphicsManager.IsProgressiveRenderingFinished() -- TO CHECK --
				disp = NitrousGraphicsManager.GetActiveViewportSetting()
				disp.VisualStyleMode = #Shaded
				y1 = "zz_CAO_ATA_" + (getFilenameFile files[i]) + "_helpers"
				myLayer = LayerManager.newLayerFromName y1
				for hlp in helpers do myLayer.addnode hlp
				myLayer.on = false
				sleep 1
				forceCompleteRedraw doDisabled:true
				sleep 1
				saveMaxFile files[i] useNewFile:true quiet:true
			)
		)

	)

	try (destroyDialog myParams) catch ()
	createDialog myParams 450 450 512 256

	----------------------------------------------------------------------
	-- TPZ Specific
	--	callbacks.addScript #filePreOpenProcess fileName:"$userScripts/PixGrinder/SVN_FileUpdate_Callback.ms" id:#UpdateFileOnOpenCb
	-- TPZ Specific
	----------------------------------------------------------------------

)