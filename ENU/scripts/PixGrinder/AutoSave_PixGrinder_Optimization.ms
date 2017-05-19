
---------------------------------------------------------------------

-- PixGrinder Scripts --
-- AutoSave --
-- Tries to make 3dsmax Autosave to act like Maya AutoSave --
-- Total Remake --
-- V 9.0 --

---------------------------------------------------------------------




(
	clearListener()
	myTotal = pixLib_MaximumAutoSaveFiles - 1

	myDates = #()
	pda_temp = #()
	myTest = true
	



	
	while myTest == true do	
	(
		if maxfilename.count == 0 then exit with messageBox ("Please, save the current Scene before launching this script")


	(
		autoSave.Enable = False;
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

		pixTimer.stop()
		pixTimer.start()
		
		SaveStartup()
		--pdaTimer.stop()
	) 
)
------------------------------------------------------------------

-- try (destroyDialog ASPrompt) catch ()
-- rollout ASPrompt "AutoSave Prompt"
-- (
-- 	label myQuestion "Auto-save current scene ?" offset:[0,10]
-- 	button pixYes "Yes"  width:100 across:2 offset:[0,20]
-- 	button pixNo "No"  width:100 across:2 offset:[0,20]

-- 	on pixYes pressed do SaveStartup()

-- 	on pixNo pressed do
-- 	(
-- 		print "Autosave skipped !"
-- 		dotnet.removeEventHandler pdaTimer "tick" myAutoSave
-- 		dotnet.addEventHandler pdaTimer "tick" myAutoSave
-- 	)
-- )
-- createDialog ASPrompt 300 100

-- try (closeRolloutFloater ASQuery) catch ()
-- ASQuery = newRolloutFloater "TEST" 300 120 dialogBar:true
-- addRollout ASPrompt ASQuery







	global ASPrompt
	pixScreenSize = getMAXWindowSize()


	fn myAutoSave = 
	(
		if getSaveRequired() == true do 
		(
			try (destroyDialog ASPrompt) catch ()
			createDialog ASPrompt 300 100  ((pixScreenSize[1]*3/5) as integer) ((pixScreenSize[2]/10) as integer)
		)
	)
	

	rollout ASPrompt "AutoSave Prompt"
	(
		label myQuestion "Auto-save current scene ?" offset:[0,10]
		button pixYes "Yes"  width:100 across:2 offset:[0,20]
		button pixNo "No"  width:100 across:2 offset:[0,20]

		on pixYes pressed do 
		(
			SaveIncrement()
			destroyDialog ASPrompt
		)


		on pixNo pressed do
		(
			print "Autosave skipped !"
			dotnet.removeEventHandler pdaTimer "tick" myAutoSave
			dotnet.addEventHandler pdaTimer "tick" myAutoSave
			destroyDialog ASPrompt
		)
	)
