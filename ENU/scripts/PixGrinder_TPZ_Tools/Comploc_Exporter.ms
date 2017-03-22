
---------------------------------------------------------------------

-- PixGrinder TPZ Tools --
-- Comploc Exporter --
-- Comploc_Exporter.ms --
-- Exports One FBX File by Layer --
-- V 5.0 --

---------------------------------------------------------------------

(

	clearListener()
	defLayer = layermanager.getLayer 0
	for obj in objects do
	(
		if obj.layer == defLayer do
		(
			if QueryBox ("Warning : There are objects in the \"0(Default)\" layer \r Do you want to continue the export ?") == false do return (print "Canceled")
		)
	)
	
	--
	callbacks.removeScripts #filePreOpenProcess id:#UpdateFileOnOpenCb
	--


	currentScene = maxfilePath + maxFileName
	myStdPath = "D:\11_Comploc\Assets\Variants\AS365\Graphics"+"\\"
-- 	myStdPath = "D:\REVERT_COMPLOC\Assets\Variants\AS365\Graphics"+"\\"
-- 	global exp_path = getSavePath caption:"Export Files To : " initialDir:myStdPath
-- 	global exp_path = append exp_path "\\"
	exp_path = getSavePath caption:"Export Files To : " initialDir:myStdPath
	exp_path = append exp_path "\\"
	allLayers = #()
	animed = 0

	
	copyfile (maxfilepath+maxfilename) (maxfilepath+substituteString maxfilename ".max" ""+"_EXPORTBACKUP"+".max")
	saveMaxFile (maxfilepath+maxfilename) clearNeedSaveFlag:true  useNewFile:true quiet:true
	
		
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
	
	------------------------------
	

	
	
	-- A VIRER --
-- 	clearListener()
-- 	allLayers = #()
	
	--     Collecte du nom des layers à part hotspots et zz_      --
	
	for w = 1 to layermanager.count-1 do 
	(
		x1 = LayerManager.getLayer w
		if matchpattern x1.name pattern:"hotspot*" == false  and matchpattern x1.name pattern:"zz*" == false and x1.on == true do append allLayers x1.name
	)
	
-- 	for obj in allLayers do print obj
		
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
			myDum = dummy pox:[0,0,0] name:(x1.name + "_rootnode")
			for obj in objects where obj.parent == undefined and obj != myDum do obj.parent = myDum
		)
		myExp = exp_path + x1.name + ".fbx"
		exportFile  myExp #noPrompt using:FBXExp
		
		loadMaxFile currentScene useFileUnits:true quiet:true
		
	)

	enableSceneRedraw()
	messageBox ("Export Successful !\rIf you need, your Scene was backuped as "+ substituteString maxfilename ".max" ""+"_EXPORTBACKUP"+".max")

	--
	callbacks.addScript #filePreOpenProcess fileName:"$userScripts/PixGrinder/SVN_FileUpdate_Callback.ms" id:#UpdateFileOnOpenCb
	--

	
)




