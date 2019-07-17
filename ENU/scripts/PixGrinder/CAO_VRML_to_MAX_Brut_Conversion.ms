-- VRML to Max 
-- V 4.2

(
	disableSceneRedraw()
	wantedPath = "D:\\10 - Helicopters\\H225VMT\\CAO\\2017-05-22-3D\\H225-22_05_2017"
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


	files = getFiles (myInput+"*.wrl")
	qsort files sortBySize


	for i = 1 to files.count do
	(
		resetMaxFile #noPrompt
		files[i]
		SysUnit()
		importFile files[i] #noPrompt  using:VrmlImp
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
		forceCompleteRedraw doDisabled:true
		sleep 1
		saveMaxFile x1 useNewFile:true --quiet:<bool>
	)

	messageBox("MAx conversion complete !")

)











