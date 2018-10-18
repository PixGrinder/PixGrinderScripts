-- PBR_LoadMaps --


(
	clearListener()
	initPath = getDir #scene
	pda = #()
	
	--if Maxfilepath.count != 0 do initPath = Maxfilepath
	
	
	fn FileSelec thePath = 
	(
		theDialog = dotNetObject "System.Windows.Forms.OpenFileDialog" -- create a OpenFileDialog 
		theDialog.title = "PLEASE Select One Or More Files" --set the title
		theDialog.Multiselect = false --allow multiple files to be selected
		theDialog.Filter = "Files(*.*)|" --specify the filter
		theDialog.FilterIndex = 1 --set the filter drop-down list to All Files
		theDialog.InitialDirectory = thePath
		theDialog.FileName="*.*"
		result = theDialog.showDialog() --display the dialog, get result into variable
		result.ToString() --when closed, convert the result to string
		result.Equals result.OK --returns TRUE if OK was pressed, FALSE otherwise
		result.Equals result.Cancel --returns TRUE if Cancel was pressed, FALSE otherwise
		theFilenames = theDialog.fileNames --the selected filenames will be returned as an array
		return theFilenames
	)
	
	myMap = (FileSelec initPath)[1]
	
	pda_name =  filenamefrompath myMap
	rpStart = findString pda_name "_"






	
	TheBitMap = bitmaptexture filename:myMap

	meditMaterials[1].TEX_color_map = TheBitMap.bitmap
)


/*
	meditMaterials[1].TEX_color_map = undefined
	show meditmaterials[1]
	classof meditmaterials[1].TEX_color_map
	getFilenamePath myMap

*/
