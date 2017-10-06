-- Comploc_CameraHotpot_Fixed --
-- Comploc_CameraHotpot_Fixed.ms --
-- Writes selected cameras coords for Comploc to a CSV File --
-- Sorts list alphabetically--
-- v3.1 --





(
	
	clearListener()
	ss = StringStream ""
	theCondition = false


	fn mySort v1 v2 = 
	(
		if v1.name > v2.name then 1 else -1
	)

	if maxFileName.count == 0 then messageBox("Please Save MaxFile before using this script") else 
	( 
		myFile = maxFilePath + "NewHotspots.csv"
		theCondition = true
	)



	if theCondition == true then 
	(
		gc()
		try(close theFile) catch()
		if doesFileExist myFile == true then deleteFile myFile
		theFile = createFile myFile
		myCams = for sel in selection collect sel
		qsort myCams mySort
		for obj in myCams do
		(	
			oldEuler = obj.transform.rotation as eulerAngles
			oldEuler.x = oldEuler.x + 90.0
			oldEuler.y = oldEuler.y
			oldEuler.z = oldEuler.z
			oldEuler
			quat = eulerToQuat oldEuler
			format "%;%,%,%;%, %, %, %\r" obj.name (-0.1*obj.pos.x) (0.1*obj.pos.z) (-0.1*obj.pos.y) (floor(100*quat.x)/100) (floor(-100*quat.y)/100) (floor(100*quat.z)/100) (floor(-100*quat.w)/100) to:theFile
		)
		sleep 1
		close theFile
		Hiddendoscommand ("explorer.exe /select, "+ "\"" +myFile+"\"")

	)
)


