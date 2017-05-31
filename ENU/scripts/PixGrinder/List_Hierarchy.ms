

---------------------------------------------------------------------

-- PixGrinder Scripts --
-- List Hierarchy --
-- List_Hierarchy.ms --
-- Lists selected hierarchy in the Listener --
-- V 3.0 --
-- Mail : pixgrinder@gmail.com --

---------------------------------------------------------------------

(
	clearListener()
	theCondition = false


	fn sortByName v1 v2= 
	(
		if v1.name > v2.name then 1 else -1
	)

	fn testHier node level extFile =
	(
		x1=""
		for i = 1 to level do x1 = x1+"\t"
		format "%%%" x1 node.name "\r"
		format "%%%" (x1 as string) node.name "\r" to:extFile
		theLevel = level
		if node.children.count != 0 do 
		(
			theArray = for obj in node.children collect obj
			qsort theArray sortByName
			theLevel = theLevel+1
			for bla in theArray do testHier bla theLevel extFile
		)

	)

	if maxFileName.count == 0 then messageBox("Please Save MaxFile before using this script") else 
	( 
		myFile = (substituteString (maxFilePath+maxFileName) ".max" "_objectsList.txt")
		theCondition = true
	)

	if doesFileExist myFile == true or myFile == undefined then
	(
		messageBox("Text File already exists. Please back it up or rename it before re-using this script")
		Hiddendoscommand ("explorer.exe /select, "+ "\"" +myFile+"\"")
		theCondition = false
	)


	if theCondition == true then
	(

		try(close theFile) catch()
		theFile = createFile myFile
		theStart = for obj in selection where finditem (selection as array) obj.parent == 0 collect obj
		qsort theStart sortByName

		for obj in theStart do testHier obj 1 theFile
		close theFile
		Hiddendoscommand ("explorer.exe /select, "+ "\"" +myFile+"\"")
	)
)