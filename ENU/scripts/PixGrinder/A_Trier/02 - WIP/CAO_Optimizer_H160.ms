-- CAO Optimizer -- 

clearListener()

	----------------------------------------------------------------------
	-- TPZ Specific
		try (callbacks.removeScripts #filePreOpenProcess id:#myPdaSvnUpdate) catch()
	-- TPZ Specific
	----------------------------------------------------------------------

myTresh = 0.4
mySmooth = Smooth threshold:20 autosmooth:true
myOpt = ProOptimizer MergePoints:on MergePointsThreshold:0.1 MergeFaces:on MergeFacesAngle:0.0872665 CompactFaces:off LockPoints:off VertexPercent:35


rollout pda_working "Working"
(
	label lbl1 "Processing files..."
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


	myInput = getSavePath caption:"Choose MAX Files to process : " initialDir:"$scenes" -- browser popoup
	myInput = myInput +"\\"
	files = getFiles (myInput+"*.max") -- prendre tous les max du dossier

	try (DestroyDialog pda_working) catch()
	CreateDialog pda_working

	myProcessDir = myInput + "Processed" + "\\" -- créer dossier Processed
	MakeDir myProcessDir-- créer dossier Processed
	-- obj = files[1]

	for obj in files do copyfile obj (myProcessDir+(filenamefrompath obj)) -- copier tous les fichiers dans dossier processed
	files = getFiles (myProcessDir +"*.max") -- files = tous les fichiers max à traiter




	-- fonction trier par taille de fichier 
	fn sortBySize file1 file2 =
	(
		if getFileSize file1 > getFileSize file2 then 1 else -1
	)

	qsort files sortBySize -- Trier les fichiers par ordre de taille


	max modify mode





for myFile in files do
(
		loadMaxFile myFile useFileUnits:false quiet:true
		-- SysUnit()
		with redraw off
		(
			max unhide all
			delete(for obj in geometry where (distance obj.min obj.max) <= myTresh collect obj)
			for obj in geometry do obj.parent = undefined
			delete helpers
			for obj in geometry do 
			(
				resetXForm obj
				convertToPoly obj
				addModifier obj myOpt
				obj.backfacecull = off
			)
		)



		for obj in geometry do 
		(
			obj.modifiers[1].Calculate = on
			--sleep 0.001
			convertToPoly obj
		)

		for obj in geometry do 
		(
			addModifier obj mySmooth
			convertToPoly obj
		)


		viewport.setLayout #layout_4
		viewport.activeViewport = 4
		viewport.setType #view_persp_user
		forceCompleteRedraw doDisabled:true
		select geometry
		max zoomext sel all
		viewport.setGridVisibility #all false
		disp = NitrousGraphicsManager.GetActiveViewportSetting()
		disp.VisualStyleMode = #Shaded
		clearSelection()
		sleep 1
		forceCompleteRedraw doDisabled:true
		sleep 1
		saveMaxFile myFile useNewFile:true quiet:true

) 


try (DestroyDialog pda_working) catch()




	----------------------------------------------------------------------
	-- TPZ Specific
		try (callbacks.addScript #filePreOpenProcess "pdaSvnUpdate()" id:#myPdaSvnUpdate) catch()
	-- TPZ Specific
	----------------------------------------------------------------------
