---------------------------------------------------------------------

-- PixGrinder Scripts --
-- CAO Post Import Processing  --
-- Optimizes CAO Placement / hierarchy n Geometry after brut import --
-- V 10.0 --

---------------------------------------------------------------------


-- Default Values by AC --
-- H135   : Position = [0.0,-0.33,0.0] ; Rotation = [0.0,-30,0.0]; Scale=10
-- H145   : Position = [1.68,0,-3.1] ; Rotation = [0.0,-3.5,0.0]; Scale=10 
-- AS365  : Position = [7.13,0.0,39.0] ; Rotation = [0.0,0.0,0.0]; Scale=10 
-- H225   : Position = [0.0,0.0,12.05] ; Rotation = [0.0,0.0,0.0]; Scale=10 


(

	clearListener()
	actionMan.executeAction 0 "40472"  -- MAX Script: MAXScript Listener
	
	 

	----------------------------------------------------------------------
	-- TPZ Specific
	--	callbacks.removeScripts #filePreOpenProcess id:#UpdateFileOnOpenCb
	-- TPZ Specific
	----------------------------------------------------------------------

	-- DotNet Open Folder dialog --

		initPath = getDir #scene

		fn FileSelec thePath = 
		(
			theDialog = dotNetObject "System.Windows.Forms.OpenFileDialog" --create a OpenFileDialog 
			theDialog.title = "Folder selection" --set the title
			theDialog.Multiselect = false --allow multiple files to be selected
			theDialog.Filter = "MaxFile(*.max)|" --specify the filter
			theDialog.FilterIndex = 1 --set the filter drop-down list to All Files
			theDialog.InitialDirectory = thePath
			theDialog.FileName="*.max"
			result = theDialog.showDialog() --display the dialog, get result into variable
			result.ToString() --when closed, convert the result to string
			result.Equals result.OK --returns TRUE if OK was pressed, FALSE otherwise
			result.Equals result.Cancel --returns TRUE if Cancel was pressed, FALSE otherwise
			theFilenames = theDialog.fileNames --the selected filenames will be returned as an array
			myPath = getFilenamePath theFilenames[1]
			return myPath
		)

		myInput = FileSelec initPath
		files = getFiles (myInput +"*.max")
	--


	myProcessDir = myInput + "Processed" + "\\" -- créer dossier Processed
	MakeDir myProcessDir-- créer dossier Processed
	-- obj = files[1]
	for obj in files do copyfile obj (myProcessDir+(filenamefrompath obj)) -- copier tous les fichiers dans dossier processed
	files = getFiles (myProcessDir +"*.max") -- files = tous les fichiers max à traiter
	global myParams


	-- Fonction trier par taille de fichier --
		fn sortBySize file1 file2 =
		(
			if getFileSize file1 > getFileSize file2 then 1 else -1
		)
	--
	

	-- Fonction pour mettre les bons parametres d'échelle --
		fn SysUnit =
		(
			resetMaxFile #noPrompt
			units.DisplayType  = #Metric
			units.MetricType = #Millimeters
			units.SystemType = #Centimeters
			units.SystemScale = 10.0
		)
	--

	
	-- Fonction pour trier les objets par nombre de faces -- 
		fn SortFaceCount v1 v2= 
		(
			if v1.numfaces > v2.numfaces then 1 else -1
		)
	--


	-- createDialog curObject 750 75 1200 1100  -- old dialog for showing current processed object
	
	fn ProcessCAO myFile a b c d e f g =
	(
		loadMaxFile myFile useFileUnits:false quiet:true
		max unhide all
		ScaleRatio = g
		myOffset = [a,b,c]
		myRot = (eulerAngles d e f)
		
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
		
		myGeos = geometry as array
		qsort myGeos SortFaceCount
		myProg = 0 -- reset progression status
		
		progressStart "Welding Vertices..."

		for i = 1 to myGeos.count do
		(
			if (100*(i as float)/myGeos.count > (myProg as float)) do
			(
				myProg = myProg+1
				progressUpdate myProg
			)
			addmodifier myGeos[i] myMod
			addmodifier myGeos[i] (Smooth())
			--maxOps.CollapseNodeTo obj 1 off
			convertToPoly myGeos[i]
			myGeos[i].backfacecull = off
		)
		
		

		myProg = 0 -- reset progression status

		progressStart "Smoothin faces..."
		for i = 1 to myGeos.count do
		(
			if (100*(i as float)/myGeos.count > (myProg as float)) do
			(
				myProg = myProg+1
				progressUpdate myProg
			)
			addmodifier myGeos[i] mySmooth
			convertToPoly myGeos[i]
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
		edittext pZ text:"12.05" fieldWidth:35 across:3 offset:[10,25]


		label txtRot "Rotation Offset :" offset:[0,15]
		edittext rX text:"0" fieldWidth:35 across:3 offset:[75,25]
		edittext rY text:"0" fieldWidth:35 across:3 offset:[45,25]
		edittext rZ text:"0" fieldWidth:35 across:3 offset:[10,25]

		label txtScale "Scale Offset :" offset:[0,15]
		edittext sX text:"10" fieldWidth:35 align:#center

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
				--disableSceneRedraw()
				with redraw off 
				(
					SysUnit()
					ProcessCAO files[i] a1 a2 a3 a4 a5 a6 a7

					-- Put helpers in hidden layer -- 
						y1 = "zz_CAO_ATA_" + (getFilenameFile files[i]) + "_helpers"
						myLayer = LayerManager.newLayerFromName y1
						for hlp in helpers do myLayer.addnode hlp
						myLayer.on = false
					--D:\H160VMT\6-Delivered & received\Input\H160\2018-07-09-Datapack\Datapack_livraison TPZ_20180709\MAX\Conversion
					
					--enableSceneRedraw()

					-- Maximize viewport on perspective view -- 
						viewport.setGridVisibility #all false
						viewport.setLayout #layout_4
						viewport.activeViewport = 4
						viewport.setType #view_persp_user
						disp = NitrousGraphicsManager.GetActiveViewportSetting()
						disp.VisualStyleMode = #Shaded
						disp.ShowSelectionBracketsEnabled = false
						max tool maximize
					--
				)

				clearSelection()
				sleep 1
				select geometry[1]
				max zoomext sel all
				select geometry
				max zoomext sel all
				clearSelection()
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

