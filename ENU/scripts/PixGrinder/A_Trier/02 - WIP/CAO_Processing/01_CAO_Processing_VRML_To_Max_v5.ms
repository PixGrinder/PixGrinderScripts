-- VRML to Max 
-- v5.0

(
	clearListener()
	myStdPath = "c:"+"\\"
	exp_path = getSavePath caption:"Choose Input WRL Files : " initialDir:myStdPath
	myInput = exp_path + "\\"
	exp_path = getSavePath caption:"Choose Max Files Output : " initialDir:myInput
	myOutput = exp_path + "\\"



-----------------------------------------------------------------------
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


	files = getFiles (myInput+"*.wrl")
	qsort files sortByDate


	for i = 1 to files.count do
	(
		resetMaxFile #noPrompt
		files[i]
		SysUnit()
		importFile files[i] #noPrompt  using:VrmlImp
		delete cameras
		select geometry
		max zoomext sel all
		y1 = "CAO_ATA_" + getFilenameFile files[i]
		myLayer = LayerManager.newLayerFromName y1
		for obj in objects do myLayer.addnode obj
		x1 = myOutput+(getFilenameFile files[i])+".max"
		max select none
		max zoomext sel all
		saveMaxFile x1 useNewFile:true --quiet:<bool>
	)
)











