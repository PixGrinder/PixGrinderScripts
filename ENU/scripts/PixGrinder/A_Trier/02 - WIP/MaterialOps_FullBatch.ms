-- Material Ops - full Scene processing batch --



(
	theTest = true
	copyFile (maxFilePath+maxFileName) (maxFilePath+(substring maxfileName 1 (maxfileName.count-4))+"_BACKUP_MATERIALS.max") 

	clearListener()

	MyStart =  "Before :\r" + "Standard Materials : " + ((getClassInstances StandardMaterial).count as string )+  "\rMulti Materials : " + ((getClassInstances MultiMaterial).count as string) + "\r"

	----------------------------
	-- Materials Renamer code -- 
	----------------------------
	StdMaterials = getClassInstances StandardMaterial
	StdBitmap = for obj in StdMaterials where classof obj.diffuseMap == BitmapTexture and obj.diffuseMap.filename != undefined collect obj
	StdColor = for obj in StdMaterials where obj.diffuseMap == undefined collect obj
	transpCol = for obj in StdColor where obj.opacity < 100.0 collect obj
	BmTex = getClassInstances BitmapTexture
	global pda_thePrefix = ""

	fn renameMats myPrefix = 
	(
		for obj in StdBitmap do 
		(
			pda_y = getFilenameFile obj.diffuseMap.filename
			obj.name = (myPrefix+"BitMapMat_"+pda_y)
		)

		for obj in BmTex where obj.filename != undefined do obj.name = (getFilenameFile obj.filename +"_BitMap")


		for obj in objects where classof obj.material == MultiMaterial do obj.material.name = (myPrefix + "MultiMat_" + obj.name )


		--- Transparency feature ---

		for i = 1 to transpCol.count do
		(
			transpCol[i].name = (myPrefix + "TranspColor_" + (i as string))
		)

		for obj in StdBitmap where obj.opacityMap != undefined do 
		(
			pda_y = getFilenameFile obj.diffuseMap.filename
			--pda_z = replace pda_y (pda_y.count-3) 4 ""
			obj.name = (myPrefix+"TranspBitmap_"+pda_y)
		)

	)


	rollout myPrefixer "PrefixChoose" 
	(
		label lbl "Choose Materials Prefix : "
		edittext myField "myCaption" text:"H160_" fieldWidth:150
		button myPrefixBtn "OK"

		on myPrefixBtn pressed do 
		(
			pda_thePrefix = myField.text
			destroyDialog myPrefixer
		)
	)


	createDialog myPrefixer 250 100 150 150 modal:true




	

	while theTest == true do
	(
		if queryBox ("Please be sure materials bitmaps path are ok before running the following steps.\rContinue ?") == false then
		(
			theTest = false
			exit with(messagebox("Cancelled by User"))
		)

		theFile = "$userScripts/PixGrinder/Apply_CollapseMultiMaterial.ms"
		if doesFileExist theFile == true then fileIn theFile else exit with print ("error with file : "+ theFile)


		theFile = "$userScripts/PixGrinder/A_Trier/02 - WIP/Mat_Optimize_Colors_V2.ms"
		if doesFileExist theFile == true then fileIn theFile else exit with print ("error with file : "+ theFile)

		
		renameMats pda_thePrefix
		
		/*
		theFile = "$userScripts/PixGrinder/A_Trier/02 - WIP/Materials_AutoRename.ms"
		if doesFileExist theFile == true then fileIn theFile else exit with print ("error with file : "+ theFile)
		*/
		
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