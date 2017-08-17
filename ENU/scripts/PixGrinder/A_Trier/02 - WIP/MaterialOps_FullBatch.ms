-- Material Ops - full Scene processing batch --



(
	clearListener()
	-- actionMan.executeAction 0 "40472" -- open Listener Window
	-- sleep 1
	theTest = 1
	theStandards 	= getClassInstances StandardMaterial
	theMultis 		= getClassInstances MultiMaterial
	Res1 = ("Nombre initial de Matériaux Standards : " + (theStandards.count as string))
	Res2 = ("Nombre initial de Matériaux Multiples : " + (theMultis.count as string))
	fn updateMatInfos =
	(
		-- Force to update Scene Materials informations by saving an empty maxFile --
-- 		tempFile = maxFilePath + "_tempSceneMaterialsHack.max"
-- 		saveNodes #() tempFile
-- 		deleteFile tempFile

		theStandards 	= getClassInstances StandardMaterial
		theMultis 		= getClassInstances MultiMaterial
		print ("Materiaux Standards : " + (theStandards.count as string))
		print ("Materiaux Multiples : " + (theMultis.count as string))


	)


	while theTest == 1 do
	(
		theFile = "$userScripts/PixGrinder/Apply_CollapseMultiMaterial.ms"
		if doesFileExist theFile == true then fileIn theFile else exit with print ("error with file : "+ theFile)
		updateMatInfos()

		theFile = "$userScripts/PixGrinder/A_Trier/02 - WIP/MaterialOps_StandardColorInstancier.ms"
		if doesFileExist theFile == true then fileIn theFile else exit with print ("error with file : "+ theFile)
		updateMatInfos()

		theFile = "$userScripts/PixGrinder/A_Trier/02 - WIP/MaterialOps_StandardBitmapInstancier.ms"
		if doesFileExist theFile == true then fileIn theFile else exit with print ("error with file : "+ theFile)
		updateMatInfos()

		theFile = "$userScripts/PixGrinder/A_Trier/02 - WIP/MaterialOps_MultiMaterialsInstancier.ms"
		if doesFileExist theFile == true then fileIn theFile else exit with print ("error with file : "+ theFile)
		updateMatInfos()

		theFile = "$userScripts/PixGrinder/A_Trier/02 - WIP/Materials_AutoRename.ms"
		if doesFileExist theFile == true then fileIn theFile else exit with print ("error with file : "+ theFile)
		updateMatInfos()


		-----------------------------------------------------------------------------

		theStandards 	= getClassInstances StandardMaterial
		theMultis 		= getClassInstances MultiMaterial
		ResEnd1 = ("Nombre FINAL de Matériaux Standards : " + (theStandards.count as string))
		ResEnd2 = ("Nombre FINAL de Matériaux Multiples : " + (theMultis.count as string))
		-- clearListener()
		print Res1
		print Res2
		print ResEnd1
		print ResEnd2
		theTest = 0
	)

)