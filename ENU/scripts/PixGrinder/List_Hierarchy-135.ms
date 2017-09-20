

---------------------------------------------------------------------

-- PixGrinder Scripts --
-- List Hierarchy --
-- List_Hierarchy.ms --
-- Lists selected hierarchy in the Listener --
-- V 2.1 --
-- Mail : pixgrinder@gmail.com --

---------------------------------------------------------------------


(
clearListener()

fn sortByName v1 v2= 
(
	if v1.name > v2.name then 1 else -1
)

fn testHier node level=
(
	x1=""
	for i = 1 to level do x1 = x1+"\t"
	format "%%%" x1 node.name "\r"
	theLevel = level
	if node.children.count != 0 do 
	(
		theArray = for obj in node.children collect obj
		qsort theArray sortByName
		theLevel = theLevel+1
		for bla in theArray do testHier bla theLevel
	)

)

theStart = for obj in selection where finditem (selection as array) obj.parent == 0 collect obj
qsort theStart sortByName

for obj in theStart do testHier obj 1
)





-- 	myFile = (substituteString (maxFilePath+maxFileName) ".max" "")+"_objectsList.txt"
-- 	if doesFileExist myFile == true then
-- 	(
-- 		messageBox("Text File already exists. Please back it up or rename it before re-using this script")
-- 		Hiddendoscommand ("explorer.exe /select, "+ "\"" +myFile+"\"")
-- 	) else (
-- 		theFile = createFile myFile
-- 		for obj in myTempAr do format "%\r" obj to:theFile
-- 		close theFile
-- 		Hiddendoscommand ("explorer.exe /select, "+ "\"" +myFile+"\"")
-- 	)