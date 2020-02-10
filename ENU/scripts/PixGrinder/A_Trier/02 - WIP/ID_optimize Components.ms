-- Transform ID Files --


theGoodTransform = (matrix3 [9.99657,0,-0.26177] [0,10,0] [0.26177,0,9.99657] [-0.109069,0,-1.59759])

-- init modifiers --
	theWeld = Vertex_Weld ()
	theWeld.threshold = 0.0001
	theSmooth = Smooth()
	theSmooth.autosmooth = on
	theSmooth.threshold = 45


fn sortBySize file1 file2 =
(
	if getFileSize file1 > getFileSize file2 then 1 else -1
)


-- 	initPath = getDir #scene
	initPath = @"D:\Travail\SVN3D_H160\H160_Comploc\MAX\CAO_BRUT\"
	theMaxFiles = #()
	
	if Maxfilepath.count != 0 do initPath = Maxfilepath
	
	
	fn FileSelec thePath = 
	(
		theDialog = dotNetObject "System.Windows.Forms.OpenFileDialog" --create a OpenFileDialog 
		theDialog.title = "PLEASE Select One Or More Files" --set the title
		theDialog.Multiselect = true --allow multiple files to be selected
		theDialog.Filter = "MaxFile(*.max)|" --specify the filter
		theDialog.FilterIndex = 1 --set the filter drop-down list to All Files
		theDialog.InitialDirectory = thePath
		theDialog.FileName="*.max"
		result = theDialog.showDialog() --display the dialog, get result into variable
		result.ToString() --when closed, convert the result to string
		result.Equals result.OK --returns TRUE if OK was pressed, FALSE otherwise
		result.Equals result.Cancel --returns TRUE if Cancel was pressed, FALSE otherwise
		theFilenames = theDialog.fileNames --the selected filenames will be returned as an array
		return theFilenames
	)
	
	
	theMaxFiles = FileSelec initPath

	qsort theMaxFiles sortBySize

callbacks.removeScripts id:#myPdaSvnUpdate


	for fil in theMaxFiles do
	(
		loadMaxFile fil useFileUnits:on quiet:on allowPrompts:off
		for geo in geometry do 
		(
			addModifier geo theWeld
			addModifier geo theSmooth
			convertToPoly geo
		)
		saveMaxFile (maxFilePath + maxFileName) quiet:on 
	)



	----------------------------------------------------------------------
	-- TPZ Specific
		callbacks.addScript #filePreOpenProcess fileName:"$userScripts/PixGrinder/SVN_FileUpdate_Callback.ms" id:#myPdaSvnUpdate
	-- TPZ Specific
	----------------------------------------------------------------------



