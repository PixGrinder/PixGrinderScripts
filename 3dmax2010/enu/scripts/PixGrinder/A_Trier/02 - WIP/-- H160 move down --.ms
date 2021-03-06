-- H160 move down -- 
(
	clearListener()

	initPath = getDir #scene


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


	pdaFiles = FileSelec initPath



	callbacks.removeScripts id:#myPdaSvnUpdate
	with redraw off 
	(
		for fl in pdaFiles do
		(
			loadMaxFile fl useFileUnits:false quiet:true
			move (for obj in objects where obj.parent == undefined collect obj) [0,0,-4]
			--move selection [0,0,-4]
			saveMaxFile fl useNewFile:false quiet:true
		)	
		callbacks.addScript #filePreOpenProcess "pdaSvnUpdate()" id:#myPdaSvnUpdate
	)

)


-- Teapot pos:[-0.711446,4.15638,0] isSelected:on radius:7.0502

-- select (for obj in objects where obj.isHidden = false and obj.parent == undefined collect obj)

