-- Nearest_Cam -- 
-- V1.0 --
--------------------
clearListener()
myReport = undefined
myArray = #()
fn mySortCam v1 v2= 
(
	if v1[1] > v2[1] then 1 else -1
)


myATA = for obj in objects where matchpattern obj.name pattern:"ATA_??-??_*" == true collect obj

for obj in myATA do
(
	theCams = for cam in cameras collect #((distance cam.center obj.center), cam)
	qsort theCams mySortCam
	append myArray #(obj.name, theCams[1][2].name)
)

clearListener()
actionMan.executeAction 0 "40472"  -- MAX Script: MAXScript Listener

clearListener()

if myArray.count > 0 then 
(
	myFileName = MaxFilePath + (getFilenameFile MaxFileName) + "_Report_Nearest_Hotspots.txt"
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
	for ar in myArray do format "%;%\r" ar[1] ar[2] to:myReport

	close(myReport)

	-- Hiddendoscommand ("explorer.exe /select, "+ "\"" +(maxfilepath+maxfileName)+"\"")
	Hiddendoscommand ("explorer.exe /select, " + MaxFilePath + (getFilenameFile MaxFileName) + "_Report_Nearest_Hotspots.txt")
)




-- for ar in myArray do format "%;%\r" ar[1] ar[2]

