
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