(
	clearListener()
	--print exporterPlugin.classes
	myFold = "D:\10 - Helicopters\AS365VMT\AH_AS365_3Dfiles\MAX\Done\\"
	
	files = getFiles (myFold+"*.max")
	
	for i = 1 to files.count do
	(
		loadMaxFile files[i] useFileUnits:true quiet:true
		x1 = (substring files[i] 1 (files[i].count-4)) + ".FBX"
		exportFile x1 #noPrompt selectedOnly:false using:FBXEXP
		resetMaxFile #noPrompt
	)

)



