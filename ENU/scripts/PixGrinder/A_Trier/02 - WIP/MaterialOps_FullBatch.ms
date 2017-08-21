-- Material Ops - full Scene processing batch --



(
	theTest = true
	copyFile (maxFilePath+maxFileName) (maxFilePath+(substring maxfileName 1 (maxfileName.count-4))+"_BACKUP_MATERIALS.max") 

	clearListener()

	MyStart =  "Before :\r" + "Standard Materials : " + ((getClassInstances StandardMaterial).count as string )+  "\rMulti Materials : " + ((getClassInstances MultiMaterial).count as string) + "\r"
	

	while theTest == true do
	(
		if queryBox ("Please be sure materials bitmaps path are ok before running the following steps.\rContinue ?") == false then
		(
			theTest = false
			exit with(messagebox("Cancelled by User"))
		)

		holdMaxFile()
		
		theFile = "$userScripts/PixGrinder/Apply_CollapseMultiMaterial.ms"
		if doesFileExist theFile == true then fileIn theFile else exit with print ("error with file : "+ theFile)

		holdMaxFile()

		theFile = "$userScripts/PixGrinder/A_Trier/02 - WIP/Mat_Optimize_Colors_V2.ms"
		if doesFileExist theFile == true then fileIn theFile else exit with print ("error with file : "+ theFile)

		holdMaxFile()

		theFile = "$userScripts/PixGrinder/A_Trier/02 - WIP/Materials_AutoRename.ms"
		if doesFileExist theFile == true then fileIn theFile else exit with print ("error with file : "+ theFile)

		holdMaxFile()
		
		theFile = "$userScripts/PixGrinder/A_Trier/02 - WIP/Materials_MultiMat_Optimizer.ms"
		if doesFileExist theFile == true then fileIn theFile else exit with print ("error with file : "+ theFile)

		holdMaxFile()

		theTest = false
	)

	myEnd =  "AFTER :\r" + "Standard Materials : " + ((getClassInstances StandardMaterial).count as string )+  "\rMulti Materials : " + ((getClassInstances MultiMaterial).count as string) + "\r"
	format myStart
	format myEnd

)


-- holdMaxFile()
/*
(
	myTemp = #()
	saveNodes myTemp ((GetDir #scene)+"\\tempTemp.max") quiet:true
)
*/