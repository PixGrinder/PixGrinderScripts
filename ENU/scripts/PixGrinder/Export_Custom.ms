-- Export Custom -- 
-- v 0.2 --


-- theClasses = exporterPlugin.classes

initPath = getDir #export


	fn FileSelec thePath = 
	(
		theDialog = dotNetObject "System.Windows.Forms.SaveFileDialog" --create a OpenFileDialog 
		theDialog.title = "Export Dialog" --set the title
-- 		theDialog.Multiselect = false --allow multiple files to be selected
		theDialog.Filter = "OpenSceneGraph(*.IVE)|*.IVE|FBX (*.FBX)|*.FBX|OBJ(*.OBJ)|*.OBJ" --specify the filter
		theDialog.FilterIndex = 3 --set the filter drop-down list to All Files
		theDialog.InitialDirectory = thePath
		theDialog.FileName="*.IVE"
		result = theDialog.showDialog() --display the dialog, get result into variable
		result.ToString() --when closed, convert the result to string
		result.Equals result.OK --returns TRUE if OK was pressed, FALSE otherwise
		result.Equals result.Cancel --returns TRUE if Cancel was pressed, FALSE otherwise
		theFilenames = theDialog.fileName --the selected filenames will be returned as an array
		return theFilenames
	)


	pda = FileSelec initPath
	myType = getFilenameType pda

-- 	print myType


	case myType of
	(
		".IVE": exportFile pda #noPrompt using:OSGExp
		".OBJ": exportFile pda #noPrompt using:ObjExp
		".FBX": exportFile pda #noPrompt using:FBXExp
	)



