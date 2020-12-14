
---------------------------------------------------------------------

-- PixGrinder Scripts --
-- AutoSaveStartup --
-- PixGrinderAutoSaveStartup.ms --
-- Tries to make 3dsmax Autosave to act like Maya AutoSave --
-- Removed Query on file open --
-- V 10.2 --

---------------------------------------------------------------------


-- Variables Definitions : 
--------------------------

	-- global files
	global pda_filesVault
	global myMinutes = 10
	global TimeInterval = myMinutes*1000*60
	global myMax = 50
	global myTotal = myMax - 1
	global myNumer = 1
	global myFormatNumer = formattedPrint myNumer format:"03d"
	global pda_temp = #()
	global pda_doCopy = false
	global pdaTimer = dotNetObject "System.Windows.Forms.Timer"
	global myFolder = ""
	global ASPrompt
	global ReallySavePrompt
	global pixScreenSize = getMAXWindowSize()


		



--------------------


--  Functions :
----------------


	fn pda_AutoSaveProcess =
	(
		
		
		try (destroyDialog ASPrompt) catch ()
		if maxfilename.count == 0 then 
		(
			pdaTimer.Stop()
			createDialog ASPrompt 300 100  ((pixScreenSize[1]*3/5) as integer) ((pixScreenSize[2]/10) as integer)
		) else (
			myFolder = maxfilepath + "_BACKUP_\\"+ substituteString maxfilename ".max" ""+"_autoback"
			if doesFileExist myFolder == false then makeDir myFolder
			pda_filesVault = getFiles (myFolder+"\\*.7z")
			if pda_filesVault.count == 0 then pda_doCopy = true else pda_doCopy = false
			if pda_doCopy == true then
			(
				myCommand = @"C:\Program Files\7-Zip\7z.exe"
				Hiddendoscommand ("\"" + myCommand + "\"" + " a "+ (myFolder+"\\"+substituteString maxfilename ".max" ""+"_autoback_"+"001"+".7z ") + (maxfilepath+maxfilename))
				--copyfile (maxfilepath+maxfilename) (myFolder+"\\"+substituteString maxfilename ".max" ""+"_autoback_"+"001"+".max")
				pda_doCopy = false
			) else (
				for i = 1 to pda_filesVault.count do
				(
					x1 = getFileModDate pda_filesVault[i]
					myArray = filterstring x1 "/ : "
					if myArray[myArray.count] == "PM" do 
					(
						if (myArray[4] as integer) != 12 do myArray[4] = (myArray[4] as integer + 12) as string
					)
					if myArray[1].count == 1 do  myArray[1] = "0" + myArray[1]
					if myArray[2].count == 1 do  myArray[2] = "0" + myArray[2]
					if myArray[4].count == 1 do  myArray[4] = "0" + myArray[4]
					x1 = myArray[3]+myArray[1]+myArray[2]+myArray[4]+myArray[5]+myArray[6]+myArray[7]+(filenamefrompath pda_filesVault[i])
					append pda_temp x1
				)
				sort pda_temp
				x2 = pda_temp[pda_temp.count]
-- 				tst = substring x2 (x2.count-6) 3
				tst = substring x2 (x2.count-5) 3
				myNumer =  tst as integer
				if myNumer <= myTotal then myNumer = myNumer +1 else myNumer = 1
				myFormatNumer = formattedPrint myNumer format:"03d"
				if pda_filesVault.count == 0 then
				(
					myNumer = 1
					myFormatNumer = "001"
				)

			)
		)
	

	)
	
	-- Save Action --
	fn pda_SaveAction = 
	(
		if (getFiles (myFolder+"\\"+substituteString maxfilename ".max" ""+"_autoback_"+myFormatNumer+".7z")).count == 1 do deleteFile (myFolder+"\\"+substituteString maxfilename ".max" ""+"_autoback_"+myFormatNumer+".7z")
		if getSaveRequired() == true then
		(
			if maxfilename.count != 0 then
			(
				saveMaxFile (maxfilepath+maxfilename) clearNeedSaveFlag:true  useNewFile:true quiet:true
				--copyfile (maxfilepath+maxfilename) (myFolder+"\\"+substituteString maxfilename ".max" ""+"_autoback_"+myFormatNumer+".max")
				myCommand = @"C:\Program Files\7-Zip\7z.exe"
				Hiddendoscommand ("\"" + myCommand + "\"" + " a "+ (myFolder+"\\"+substituteString maxfilename ".max" ""+"_autoback_"+myFormatNumer+".7z ") + (maxfilepath+maxfilename))
-- 				Hiddendoscommand ("\"" + myCommand + "\"" + " a "+ (myMaxPath + myFileName + ".7z ") + (myPathTemp + myFileName + ".max"))
			)
		)
	)

	fn pda_AutoSave = 
	(
		-- format "%%" localTime "\r"
		try (destroyDialog ReallySavePrompt) catch()
		if getSaveRequired() == true then
		(
				pdaTimer.Stop()
				createDialog ReallySavePrompt 300 100  ((pixScreenSize[1]*3/5) as integer) ((pixScreenSize[2]/10) as integer)
		)
	)

	fn pda_AutoSaveNoPrompt = 
	(
		if getSaveRequired() == true then
		(
			pda_AutoSaveProcess()
			pda_SaveAction()
		)
	)


	fn myAutoSaveOpenFile=
	(
		myNumer = 1
		myFormatNumer = "001"
		pda_AutoSaveProcess()
		--if QueryBox("Save current scene ? ") == true then pda_SaveAction()
	)


	-- Rollouts
	------------

	rollout ASPrompt "AutoSave Prompt"
	(
		label myQuestion "Save current NEW scene ?" offset:[0,10]
		button pixYes "Yes"  width:100 across:2 offset:[0,20]
		button pixNo "No"  width:100 across:2 offset:[0,20]

		on pixYes pressed do 
		(
			pda_theMaxSave = getSaveFileName()
			if pda_theMaxSave != undefined then saveMaxFile pda_theMaxSave clearNeedSaveFlag:true useNewFile:true
			pdaTimer.Start()
			destroyDialog ASPrompt
		)


		on pixNo pressed do
		(
			pdaTimer.Start()
			destroyDialog ASPrompt
		)
	)


	rollout ReallySavePrompt "AutoSave Prompt"
	(
		label myQuestionRS "Really Save ?" offset:[0,10]
		button pixRS_Yes "Yes"  width:100 across:2 offset:[0,20]
		button pixRS_No "No"  width:100 across:2 offset:[0,20]

		on pixRS_Yes pressed do 
		(
			pdaTimer.Start()
			pda_AutoSaveProcess()
			pda_SaveAction()
			destroyDialog ReallySavePrompt
		)


		on pixRS_No pressed do
		(
			--print "Autosave skipped !"
			pdaTimer.Start()
			destroyDialog ReallySavePrompt
		)
	)




	-- Deactivate 3dsmax autosave 
	------------------------------
	autoSave.Enable = False

	-- Callback :
	----------------
	callbacks.addScript #filePostOpen "myAutoSaveOpenFile()" id:#FelipeCallback persistent:false
	format ("PixGrinder Autosave Startup Done\r")

	
	-- Timer : 
	-----------
	dotnet.addEventHandler pdaTimer "tick" pda_AutoSave
	pdaTimer.interval = TimeInterval
	pdaTimer.Start()




