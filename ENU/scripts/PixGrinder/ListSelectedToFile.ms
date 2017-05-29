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
	if doesFileExist ((maxFilePath)+"objectsList.txt") == true then
	(
		messageBox("Text File already exists. Please back it up or rename it before re-using this script")
		Hiddendoscommand ("explorer.exe /select, "+ "\"" +((maxFilePath)+"objectsList.txt")+"\"")
	) else (
		theFile = createFile ((maxFilePath)+"objectsList.txt")
		for obj in myTempAr do format "%\r" obj to:theFile
		close theFile
	)
)






