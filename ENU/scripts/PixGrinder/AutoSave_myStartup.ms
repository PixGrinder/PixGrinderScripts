
---------------------------------------------------------------------

-- PixGrinder Scripts --
-- Startup for Autosave --
-- Lauches Timers and everything needed for PixGrinder's autosave system --
-- V 0.1 --

---------------------------------------------------------------------



struct _pixLib
(
	myMinutes = 10.0
	TimeInterval = myMinutes*1000*60

	global pix_myNumer = 1
	myFormatNumer = "" -- Not Really usefull

	pix_MaximumAutoSaveFiles = 50

	fn  SaveIncrement = 
	(
		myFolder = maxfilepath+"_BACKUP_\\" + substituteString maxfilename ".max" ""+"_autoback" 	-- create Folder for Incremented files backup
		if myNumer <= myTotal then myNumer = myNumer + 1 else myNumer = 1 							-- Reset increment to 0 if max fileSaves is reached
		myFormatNumer = formattedPrint myNumer format:"03d" 										-- converts 1 digit increment to 3 digits ex : "1" -> "001"
		if (getFiles (myFolder+"\\"+substituteString maxfilename ".max" ""+"_autoback_"+myFormatNumer+".max")).count == 1 do deleteFile (myFolder+"\\"+substituteString maxfilename ".max" ""+"_autoback_"+myFormatNumer+".max")
		--  if current incremented file exists, delete it !
		saveMaxFile (maxfilepath+maxfilename) clearNeedSaveFlag:true  useNewFile:true quiet:true 	-- Save current max file, overwriting it 
		copyfile (maxfilepath+maxfilename) (myFolder+"\\"+substituteString maxfilename ".max" ""+"_autoback_"+myFormatNumer+".max") -- copy just saved file as increment in the Backup folder
		print ("Saved file : " + substituteString maxfilename ".max" ""+"_autoback_"+myFormatNumer+".max") -- Print confirmation of incremental save
	)


	fn createTimer theFunx theBool =
	(
		pixTimer = dotNetObject "System.Windows.Forms.Timer"
		dotnet.addEventHandler pixTimer "tick" theFunx
		pixTimer.interval = TimeInterval
		if theBool == true then pixTimer.start() else pixTimer.stop()
	)
)




