
---------------------------------------------------------------------

-- PixGrinder Scripts --
-- AutoSave --
-- Tries to make 3dsmax Autosave to act like Maya AutoSave --
-- V 7.0 --

---------------------------------------------------------------------




(
	clearListener()
	global myMinutes = 10
	print (myMinutes as string)
	global TimeInterval = myMinutes*1000*60
	print (TimeInterval as string)
	myMax = 50
	myTotal = myMax - 1
	myNumer = 1
	myFormatNumer = ""
	myDates = #()
	pda_temp = #()
	tempString = ""
	global pdaTimer = dotNetObject "System.Windows.Forms.Timer"
	

	fn  SaveStartup = 
	(
		--myFolder = maxfilepath + substituteString maxfilename ".max" ""+"_autoback"
		myFolder = maxfilepath+"_BACKUP_\\" + substituteString maxfilename ".max" ""+"_autoback"
		if myNumer <= myTotal then myNumer = myNumer +1 else myNumer = 1
		myFormatNumer = formattedPrint myNumer format:"03d"
		if (getFiles (myFolder+"\\"+substituteString maxfilename ".max" ""+"_autoback_"+myFormatNumer+".max")).count == 1 do deleteFile (myFolder+"\\"+substituteString maxfilename ".max" ""+"_autoback_"+myFormatNumer+".max")
		
		saveMaxFile (maxfilepath+maxfilename) clearNeedSaveFlag:true  useNewFile:true quiet:true
		copyfile (maxfilepath+maxfilename) (myFolder+"\\"+substituteString maxfilename ".max" ""+"_autoback_"+myFormatNumer+".max")
	)
	
	
	fn myAutoSave = 
	(
		if getSaveRequired() == true do 
		(
			if (queryBox "Auto-save current scene ?" title:"AutoSave Dialog" beep:true) == true then SaveStartup() else print "Autosave skipped !"
		)
	)
	
		
	if maxfilename.count == 0 then 
	(
		messageBox ("Please, save the current Scene before launching this script")
	) else (
		--print "launch the script !!!"
		autoSave.Enable = False
		myFolder = maxfilepath + "_BACKUP_\\"+ substituteString maxfilename ".max" ""+"_autoback"
		makeDir myFolder
		files = getFiles (myFolder+"\\*.max")
		if files.count == 0 then 
		(
			copyfile (maxfilepath+maxfilename) (myFolder+"\\"+substituteString maxfilename ".max" ""+"_autoback_"+"001"+".max") 
		) else (
			for i = 1 to files.count do
			(
				x1 = getFileModDate files[i]
				myArray = filterstring x1 "/ : "
				if myArray[1].count == 1 do  myArray[1] = "0" + myArray[1]
				if myArray[2].count == 1 do  myArray[2] = "0" + myArray[2]
				if myArray[4].count == 1 do  myArray[4] = "0" + myArray[4]
				-- myArray
				x1 = myArray[3]+myArray[1]+myArray[2]+myArray[4]+myArray[5]+myArray[6]+myArray[7]+(filenamefrompath files[i])
				-- print x1
				append pda_temp x1
			)
			sort pda_temp
			x2 = pda_temp[pda_temp.count]
			tst = substring x2 (x2.count-6) 3
			myNumer =  tst as integer
		)
		
		
		try (pdaTimer.stop()) catch (print "pdaTimer undefined !")
		dotnet.addEventHandler pdaTimer "tick" myAutoSave
		pdaTimer.interval = TimeInterval
		pdaTimer.start()
		SaveStartup()
		--pdaTimer.stop()
	) 
)



