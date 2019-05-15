-- mass xref scene !!
-- v4
(
	clearListener()
	initPath = getDir #scene
	pda = #()
	
	if Maxfilepath.count != 0 do initPath = Maxfilepath

	fn sortBySize file1 file2=
	(
		if getFileSize file1 > getFileSize file2 then 1 else -1
	)
	
	
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
	
	
	pda = FileSelec initPath

	qsort pda sortBySize

	with quiet on 
	(
		for obj in pda do
		(
			loadMaxFile obj useFileUnits:on
			exportFile ((getFileNamePath obj) + (getFilenameFile obj) + ".fbx") #noPrompt using:FBXEXP
		)
	)
)


/*

exporterPlugin.classes
obj = maxfilepath + maxfilename
*/