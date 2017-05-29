---------------------------------------------------------------------

-- PixGrinder Scripts --
-- List Selected --
-- ListSelected.ms --
-- Outputs selected objects names in external text file --
-- V 2.0 --

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






