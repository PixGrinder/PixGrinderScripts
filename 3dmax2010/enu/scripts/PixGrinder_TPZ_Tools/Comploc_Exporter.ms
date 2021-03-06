
---------------------------------------------------------------------

-- PixGrinder TPZ Tools --
-- Comploc Exporter --
-- Comploc_Exporter.ms --
-- Exports One FBX File by Layer --
-- V 5.0 --

---------------------------------------------------------------------

(

	clearListener()

	theLbl = substituteString maxfilename ".max" ""+"_EXPORTBACKUP"+".max"
	rollout myEnd "Complete"
	(
		hyperlink lbl "Export Successful !"  enabled:false align:#center --offset:[15,0]
		hyperlink lbl2 "If you need, your Scene was backuped as" offset:[15,0] enabled:false
		hyperlink lbl3 theLbl offset:[15,0] enabled:false
		button btnEnd "OK" offset:[0,10]

		on btnEnd pressed do 
		(
			destroyDialog myEnd
			callbacks.removeScripts id:#pdaDialog
		)
	)
	fn myDialog =
	(
		messageBox ("Export Successful !\rIf you need, your Scene was backuped as "+ substituteString maxfilename ".max" ""+"_EXPORTBACKUP"+".max")
		--createDialog myEnd 250 125 ((1920-250)/2) 400 modal:true bgcolor:(color 95 138 193)
	)

	defLayer = layermanager.getLayer 0
	for obj in objects do
	(
		if obj.layer == defLayer do
		(
			if QueryBox ("Warning : There are objects in the \"0(Default)\" layer \r Do you want to continue the export ?") == false do return (print "Canceled")
		)
	)
	
	--
	callbacks.removeScripts id:#myPdaSvnUpdate
	--
	currentScene = maxfilePath + maxFileName
	myStdPath = "$exports"
	exp_path = getSavePath caption:"Export Files To : " initialDir:myStdPath
	exp_path = append exp_path "\\"
	allLayers = #()
	animed = 0
	
	copyfile (maxfilepath+maxfilename) (maxfilepath+substituteString maxfilename ".max" ""+"_EXPORTBACKUP"+".max")
	
	disableSceneRedraw()
	
	-- supprimer les layers vides
	
	(
		l_ar = #()
		
		-- " (0 Default )" comme layer courant
		l0 = layermanager.getLayer 0
		l0.current = true
		
		-- collecte de tous les layers dans "l_ar"
		for i = 1 to (layermanager.count-1) do 
		(
			x = layermanager.getLayer i
			append l_ar x.name
		)
		
		for i = 1 to l_ar.count do
		(
			LayerManager.deleteLayerHierarchy l_ar[i] forceDelete:false
		)
	)
	
	
	--     Collecte du nom des layers à part hotspots et zz_      --
	
	for w = 1 to layermanager.count-1 do 
	(
		x1 = LayerManager.getLayer w
		if matchpattern x1.name pattern:"hotspot*" == false  and matchpattern x1.name pattern:"zz*" == false and x1.on == true do append allLayers x1.name
	)
	

	for i = 1 to allLayers.count do
	(
		x1 = layerManager.getLayerFromName allLayers[i]
		x1.current = true
			-- Display all layers --
		
		Avirer = for obj in objects where obj.layer != x1 collect obj
		delete Avirer
		for obj in objects do if obj.isAnimated == true do 
		(
			animed = 1
			exit
		)
		if animed == 1 do
		(
			myDum = dummy pos:[0,0,0] name:(x1.name + "_rootnode")
			for obj in objects where obj.parent == undefined and obj != myDum do obj.parent = myDum
		)
		myExp = exp_path + x1.name + ".fbx"
		exportFile  myExp #noPrompt using:FBXExp

		if i != allLayers.count then 
		(
			loadMaxFile currentScene useFileUnits:true quiet:true
		) else (
			callbacks.addScript #filePostOpen "myDialog()" id:#pdaDialog
			loadMaxFile currentScene useFileUnits:true quiet:true
		)
	)

	enableSceneRedraw()

	--
	callbacks.addScript #filePreOpenProcess "pdaSvnUpdate()" id:#myPdaSvnUpdate
	--

	--

)




