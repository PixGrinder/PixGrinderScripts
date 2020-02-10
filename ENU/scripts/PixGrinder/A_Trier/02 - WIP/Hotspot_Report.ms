-- Hotspot_Report --
-- V 1.0 --

clearListener()

myATA = for obj in objects where matchpattern obj.name pattern:"ATA_??-??_*" == true collect obj
if myATA.count > 0 then 
(
	myReport = undefined
	myFileName = MaxFilePath + MaxFileName + @"\Report_Nearest_Hotspots.txt"
	if doesFileExist myFileName == false then 
	(
		myReport = createFile myFileName
		close(myReport)
		myReport = openfile myFileName mode:"r+"
	) else (
		deleteFile myFileName
		myReport = createFile myFileName
		close(myReport)
		myReport = openfile myFileName mode:"r+"
	)

	-- filePos myReport

	for txt in myATA do
	(
		format "%\r" txt.name to:myReport
	)
	close(myReport)

	-- Hiddendoscommand ("explorer.exe /select, "+ "\"" +(maxfilepath+maxfileName)+"\"")
	Hiddendoscommand ("explorer.exe /select, " + MaxFilePath + MaxFileName + @"\Report_Nearest_Hotspots.txt")
)



