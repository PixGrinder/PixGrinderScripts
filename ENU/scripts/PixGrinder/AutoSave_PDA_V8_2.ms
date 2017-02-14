
---------------------------------------------------------------------

-- PixGrinder Scripts --
-- AutoSave --
-- Tries to make 3dsmax Autosave to act like Maya AutoSave --
-- V 8.2 --

---------------------------------------------------------------------




(
	clearListener()
	global myMinutes = 10.0
	global TimeInterval = myMinutes*1000*60
	global myMax = 50
	global myTotal = myMax - 1
	global myNumer = 1
	global myFormatNumer = ""
	global myDates = #()
	global pda_temp = #()
	global tempString = ""
	global pdaTimer = dotNetObject "System.Windows.Forms.Timer"
	

	fn  SaveStartup = 
	(
		--myFolder = maxfilepath + substituteString maxfilename ".max" ""+"_autoback"
		myFolder = maxfilepath+"_BACKUP_\\" + substituteString maxfilename ".max" ""+"_autoback"
		if myNumer <= myTotal then myNumer = myNumer +1 else myNumer = 1
		myFormatNumer = formattedPrint myNumer format:"03d"
		if (getFiles (myFolder+"\\"+substituteString maxfilename ".max" ""+"_autoback_"+myFormatNumer+".max")).count == 1 do deleteFile (myFolder+"\\"+substituteString maxfilename ".max" ""+"_autoback_"+myFormatNumer+".max")
		MyPrintTime = localTime
		print MyPrintTime
		saveMaxFile (maxfilepath+maxfilename) clearNeedSaveFlag:true  useNewFile:true quiet:true
		copyfile (maxfilepath+maxfilename) (myFolder+"\\"+substituteString maxfilename ".max" ""+"_autoback_"+myFormatNumer+".max")
		print ("Saved file : " + substituteString maxfilename ".max" ""+"_autoback_"+myFormatNumer+".max")
	)
	
	
	fn myAutoSave = 
	(
		if getSaveRequired() == true do 
		(
			if (queryBox "Auto-save current scene ?" title:"AutoSave Dialog" beep:true) == true then SaveStartup() else 
			(
				print "Autosave skipped !"
				dotnet.removeEventHandler pdaTimer "tick" myAutoSave
				dotnet.addEventHandler pdaTimer "tick" myAutoSave
			)
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
				if myArray[myArray.count] == "PM" do 
				(
					if (myArray[4] as integer) != 12 do myArray[4] = (myArray[4] as integer + 12) as string
				)
				if myArray[1].count == 1 do  myArray[1] = "0" + myArray[1]
				if myArray[2].count == 1 do  myArray[2] = "0" + myArray[2]
				if myArray[4].count == 1 do  myArray[4] = "0" + myArray[4]
				x1 = myArray[3]+myArray[1]+myArray[2]+myArray[4]+myArray[5]+myArray[6]+myArray[7]+(filenamefrompath files[i])
				append pda_temp x1
			)
			sort pda_temp
			x2 = pda_temp[pda_temp.count]
			pda_temp[1]
			tst = substring x2 (x2.count-6) 3
			myNumer =  tst as integer
		)
		
		
		dotnet.removeEventHandler pdaTimer "tick" myAutoSave
		dotnet.addEventHandler pdaTimer "tick" myAutoSave
		pdaTimer.interval = TimeInterval
		pdaTimer.start()
		
		SaveStartup()
		--pdaTimer.stop()
	) 
)



