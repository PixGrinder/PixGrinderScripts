-- myCamList.ms
-- v 0.1

(
	myCond = true
	theFileName = "d:\\"+"Hotspots.csv"
	theCams = for cam in cameras where matchpattern cam.name pattern:"H*"==true collect cam
	if  deleteFile theFileName == true then
	(
		theCSV = createFile theFileName
		fn pde_sortCam stringA stringB= 
		(
			if stringA.name > stringB.name then 1 else -1
		)
		qsort theCams pde_sortCam
		format "H_test;0.0,0.0,0.0\r" to:theCSV
		for obj in theCams do format "%;%,%,%\r" obj.name (obj.position.X*-0.1) (obj.position.Z*0.1) (obj.position.Y*-0.1)  to:theCSV
		close theCSV
	) else messageBox ("FAIL :\r" + filenameFromPath theFileName + " is opened by another program")
)



-- for cam in cameras where matchpattern cam.name pattern:"H*"==true do cam.name = replace cam.name 1 1 "H_"