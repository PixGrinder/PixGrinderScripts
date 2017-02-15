-- VRML to Max 

(

	myInput = "D:\10 - Helicopters\AS365VMT\AH_AS365_3Dfiles\WRL\\"
	myOutput = "D:\10 - Helicopters\AS365VMT\AH_AS365_3Dfiles\MAX\\"


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
		saveMaxFile x1 useNewFile:true --quiet:<bool>
	)
)











