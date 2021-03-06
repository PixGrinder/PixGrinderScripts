---------------------------------------------------------------------

-- PixGrinder Scripts --
-- List Selected To File --
-- ListSelectedToFile.ms --
-- Outputs selected objects names to external text file --
-- V 1.0 --

---------------------------------------------------------------------



(
	clearListener()
	myTempAr = #()
	myTempAr = for obj in selection collect obj.name
	sort myTempAr
	myFile = (substituteString (maxFilePath+maxFileName) ".max" "")+"_objectsList.txt"
	if doesFileExist myFile == true then
	(
		messageBox("Text File already exists. Please back it up or rename it before re-using this script")
		Hiddendoscommand ("explorer.exe /select, "+ "\"" +myFile+"\"")
	) else (
		theFile = createFile myFile
		for obj in myTempAr do format "%\r" obj to:theFile
		close theFile
		Hiddendoscommand ("explorer.exe /select, "+ "\"" +myFile+"\"")
	)
)






