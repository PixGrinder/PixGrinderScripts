
---------------------------------------------------------------------

-- PixGrinder TPZ Tools --
-- Comploc Exporter --
-- Comploc_Exporter.ms --
-- Exports One FBX File by Layer --
-- V 5.2 --
-- For later : Add sorting by numFaces : $.numfaces

---------------------------------------------------------------------

-- FBX Export Setup --


	FbxExporterSetParam "Animation" on
	FbxExporterSetParam "ASCII" off
	FbxExporterSetParam "AxisConversionMethod" #Animation
	FbxExporterSetParam "BakeAnimation" on
	FbxExporterSetParam "Cameras" off
	FbxExporterSetParam "EmbedTextures" off
	FbxExporterSetParam "FileVersion" #FBX201900
	FbxExporterSetParam "GenerateLog" off
	FbxExporterSetParam "UseSceneName" off
	FbxExporterSetParam "UpAxis" #y
	FbxExporterSetParam "TangentSpaceExport" off
	FbxExporterSetParam "Triangulate" off
-- 	FbxExporterSetParam "SplitAnimationIntoTakes" off
	FbxExporterSetParam "SmoothMeshExport" off
	FbxExporterSetParam "SmoothingGroups" on
	FbxExporterSetParam "ShowWarnings" off
	FbxExporterSetParam "Skin" on
	FbxExporterSetParam "Shape" on
	FbxExporterSetParam "SelectionSetExport" off
	FbxExporterSetParam "ScaleFactor" 1.0
	FbxExporterSetParam "Resampling" 30.0
	FbxExporterSetParam "Removesinglekeys" off
	FbxExporterSetParam "Preserveinstances" off
	FbxExporterSetParam "PointCache" off
	FbxExporterSetParam "NormalsPerPoly" off
	FbxExporterSetParam "Lights" off
	FbxExporterSetParam "GeomAsBone" off
	FbxExporterSetParam "FilterKeyReducer" off
	FbxExporterSetParam "ConvertUnit" #dm
	FbxExporterSetParam "Convert2Tiff" off
	FbxExporterSetParam "ColladaFrameRate" 30.0
	FbxExporterSetParam "ColladaSingleMatrix" on
	FbxExporterSetParam "ColladaTriangulate" on
	FbxExporterSetParam "CAT2HIK" off
	FbxExporterSetParam "BakeResampleAnimation" on


---------------------------

if QueryBox("Did you configure UNITY Importer ?") then
(

	clearListener()

	--theLbl = substituteString maxfilename ".max" ""+"_EXPORTBACKUP"+".max"
	rollout myEnd "Complete"
	(
		hyperlink lbl "Export Successful !"  enabled:false align:#center --offset:[15,0]
		on btnEnd pressed do 
		(
			destroyDialog myEnd
			callbacks.removeScripts id:#pdaDialog
		)
	)

	rollout myWorking "Working"
	(
		label lbl28 "Exporting..."
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
	
	--copyfile (maxfilepath+maxfilename) (maxfilepath+substituteString maxfilename ".max" ""+"_EXPORTBACKUP"+".max")
	
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
	

createDialog myWorking

	for i = 1 to allLayers.count do
	(
		x1 = layerManager.getLayerFromName allLayers[i]
		x1.current = true
			-- Display all layers --
		
-- 		Avirer = for obj in objects where obj.layer != x1 collect obj
-- 		delete Avirer
		select (for obj in objects where obj.layer == x1 collect obj)
		myExp = exp_path + x1.name + ".fbx"
		exportFile  myExp #noPrompt selectedOnly:on using:FBXExp

	)
	clearSelection()
	enableSceneRedraw()


	--
	callbacks.addScript #filePreOpenProcess "pdaSvnUpdate()" id:#myPdaSvnUpdate
	--


destroyDialog myWorking


	--

) else (messageBox("Export Aborted") )






