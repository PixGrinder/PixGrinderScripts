-- Export Custom -- 
-- v 0.1 --



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
		".IVE": format "%   -   %\r" "IVE Extension" pda
		".OBJ": format "%   -   %\r" "OBJ Extension" pda
		".FBX": format "%   -   %\r" "FBX Extension" pda
	)


	