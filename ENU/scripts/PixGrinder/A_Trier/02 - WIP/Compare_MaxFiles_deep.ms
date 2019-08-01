clearListener()

-- try (DestroyDialog myRol) catch()

	----------------------------------------------------------------------
	-- TPZ Specific
		callbacks.removeScripts #filePreOpenProcess id:#myPdaSvnUpdate
	-- TPZ Specific
	----------------------------------------------------------------------


fn mySort v1 v2 = 
(
	if v1[1] > v2[1] then 1 else -1
)


fn pda_selectList thePath = 
(
	theDialog = dotNetObject "System.Windows.Forms.OpenFileDialog" --create a OpenFileDialog 
	theDialog.title = "PLEASE Select One Or More Files" --set the title
	theDialog.Multiselect = false --allow multiple files to be selected
	theDialog.Filter = "MaxFile(*.MAX)|" --specify the filter
	theDialog.FilterIndex = 1 --set the filter drop-down list to All Files
	theDialog.InitialDirectory = thePath
	theDialog.FileName="*.max"
	result = theDialog.showDialog() --display the dialog, get result into variable
	result.ToString() --when closed, convert the result to string
	result.Equals result.OK --returns TRUE if OK was pressed, FALSE otherwise
	result.Equals result.Cancel --returns TRUE if Cancel was pressed, FALSE otherwise
	theFilenames = theDialog.fileNames --the selected filenames will be returned as an array
	if result.Equals result.OK then return theFilenames else return false
)


	

	pda_theFile_A = pda_selectList (getDir #scene)
	pda_theFile_A = pda_theFile_A[1]
	pda_theFile_B = pda_selectList (getDir #scene)
	pda_theFile_B = pda_theFile_B[1]
	
	if pda_theFile_A != false and pda_theFile_B != false then 
	(		
		loadMaxFile pda_theFile_A useFileUnits:on allowPrompts:off quiet:on
		pdaContentA = for obj in objects collect #(obj.name, getNumVerts obj, (distance obj.min obj.max))
		qsort pdaContentA mySort

		loadMaxFile pda_theFile_B useFileUnits:on allowPrompts:off quiet:on
		pdaContentB = for obj in objects collect #(obj.name, getNumVerts obj, (distance obj.min obj.max))
		qsort pdaContentB mySort

		myChanges = #()
		for i = 1 to pdaContentA.count do
		(
			if pdaContentA[i] != pdaContentB[i] then append myChanges pdaContentA[i][1]
		)

		clearListener ()
		actionMan.executeAction 0 "40472"  -- MAX Script: MAXScript Listener
		format "%\r\r" (filenameFromPath pda_theFile_A)
		format "Number of nodes : %\r" (pdaContentA.count as string)
		format "\r\r"
		format "%\r\r" (filenameFromPath pda_theFile_B)
		format "Number of nodes : %\r" (pdaContentB.count as string)
		format "\r\r"
		for obj in myChanges do format "%\r" obj

	)


	----------------------------------------------------------------------
	-- TPZ Specific
		callbacks.addScript #filePreOpenProcess fileName:"$userScripts/PixGrinder/SVN_FileUpdate_Callback.ms" id:#myPdaSvnUpdate
	-- TPZ Specific
	----------------------------------------------------------------------




/*

	clearListener()
	actionMan.executeAction 0 "40472"  -- MAX Script: MAXScript Listener
	myList = #()

	fn AlphaSort v1 v2 = 
	(
		if v1.name > v2.name then 1 else -1
	)

	myFile = (substituteString (maxFilePath+maxFileName) ".max" "")+"_Params.csv"
	if doesFileExist myFile == true then
	(
		messageBox("Text File already exists. Please back it up or rename it before re-using this script")
		Hiddendoscommand ("explorer.exe /select, "+ "\"" +myFile+"\"")
	) else (
		theFile = createFile myFile
		format "%;%;%\r" "Object Name" "Object Type" "Bbox Value" to:theFile
		myObjList = geometry as array
		qsort myObjList AlphaSort
		for obj in myObjList do format "%;%;%\r" obj.name (classof obj as string) ((distance obj.max obj.min) as string) to:theFile
		close theFile
		Hiddendoscommand ("explorer.exe /select, "+ "\"" +myFile+"\"")
	)


-- 	for obj in objects collect #(obj.name, classof obj as string, (distance obj.max obj.min) as string) 


*/



/*
gc()
(
	clearListener()
	myList = #()
	for obj in geometry do if classof obj != Editable_Poly do convertToPoly obj
	for obj in geometry do 
	(
		append myList #(obj.name, obj.position, (distance obj.max obj.min),NumVerts obj)
		
	)
	for bla in myList do print bla
)

*/