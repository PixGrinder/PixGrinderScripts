
---------------------------------------------------------

-- PixGrinder 1st Startup Script !!! --
-- V3 --
-- Now asks user wether to save at scene opening --

---------------------------------------------------------


	clearListener()

	
	-----------------------------------------------------

	-- Variables  :


	(

		--myPath = "$userScripts/PixGrinder/AutoSave_PDA_V7_1.ms"
		global myMinutes = 0.5
		global TimeInterval = myMinutes*1000*60
		myMax = 50
		myTotal = myMax - 1
		myNumer = 1
		myFormatNumer = ""
		myDates = #()
		my_temp = #()
		tempString = ""
		global pdaTimer = dotNetObject "System.Windows.Forms.Timer"
		global theSaveTest = false
		print theSaveTest
	)


	-----------------------------------------------------
	
	fn myTest = 
	(
		messageBox("SaveStartup - theSaveTest = " + (theSaveTest as string))
	)

	-- myTest()
	
	-----------------------------------------------------




	fn  SaveStartup = 
	(
		-- print ("SaveStartup - theSaveTest = " + (theSaveTest as string))
		if theSaveTest != false then
		(
			--myFolder = maxfilepath + substituteString maxfilename ".max" ""+"_autoback"
			myFolder = maxfilepath+"_BACKUP_\\" + substituteString maxfilename ".max" ""+"_autoback"
			if myNumer <= myTotal then myNumer = myNumer +1 else myNumer = 1
			myFormatNumer = formattedPrint myNumer format:"03d"
			if (getFiles (myFolder+"\\"+substituteString maxfilename ".max" ""+"_autoback_"+myFormatNumer+".max")).count == 1 do deleteFile (myFolder+"\\"+substituteString maxfilename ".max" ""+"_autoback_"+myFormatNumer+".max")
			saveMaxFile (maxfilepath+maxfilename) clearNeedSaveFlag:true  useNewFile:true quiet:true
			copyfile (maxfilepath+maxfilename) (myFolder+"\\"+substituteString maxfilename ".max" ""+"_autoback_"+myFormatNumer+".max")
		) else messagebox  ("theSaveTest is False !")
		theSaveTest = true
	)
	
	

		
	fn CtrlS =
	(
		if maxfilename.count == 0 then 
		(
			messageBox ("Please, save the current Scene before launching this script")
		) else (
			----------------------------------
			-- Disable 3dsmax Legacy Autosave

			autoSave.Enable = False 
			----------------------------------
			-- Create AUTOBACK subFolder --

			myFolder = maxfilepath + "_BACKUP_\\"+ substituteString maxfilename ".max" ""+"_autoback"
			makeDir myFolder
			----------------------------------
			-- Get Files in Autoback folder --

			files = getFiles (myFolder+"\\*.max")
			----------------------------------

			if theSaveTest == true then
			(
				if files.count == 0 then 
				(
					----------------------------------
					-- if no previous autoback, create it ! --
	
					copyfile (maxfilepath+maxfilename) (myFolder+"\\"+substituteString maxfilename ".max" ""+"_autoback_"+"001"+".max") 
					----------------------------------
				) else (
					----------------------------------
					-- if previous autoback exists, sort them ! --
					for i = 1 to files.count do
					(
						x1 = getFileModDate files[i]
						myArray = filterstring x1 "/ : "
						if myArray[1].count == 1 do  myArray[1] = "0" + myArray[1]
						if myArray[2].count == 1 do  myArray[2] = "0" + myArray[2]
						if myArray[4].count == 1 do  myArray[4] = "0" + myArray[4]
						x1 = myArray[3]+myArray[1]+myArray[2]+myArray[4]+myArray[5]+myArray[6]+myArray[7]+(filenamefrompath files[i])
						append pda_temp x1
					)
					sort pda_temp
					----------------------------------
					x2 = pda_temp[pda_temp.count]
					tst = substring x2 (x2.count-6) 3
					myNumer =  tst as integer -- finally defines Variable "myNumer"
				)
			) else messagebox("1st save")
		)
	)
		
		
	fn AS_Launcher myTimer =
	(
		if querybox ("Do you want to save current opened file ?") == true then theSaveTest = true else theSaveTest = false
		CtrlS()
		try (dotnet.removeEventHandler myTimer "tick" SaveStartup) catch (print "Timer not Removed") -- Stops timer if exists
		dotnet.addEventHandler myTimer "tick" myTest
		myTimer.interval = TimeInterval
		myTimer.start()
		theSaveTest = true
	)

	--callbacks.addScript #filePostOpen "AS_Launcher pdaTimer" id:#FelipeCallback persistent:false
	--print "PixGrinder Startup Done"

	-- AS_Launcher pdaTimer myTest

	AS_Launcher pdaTimer


	try (dotnet.removeEventHandler pdaTimer "tick" SaveStartup) catch (print "Timer not Removed") -- Stops timer if exists


-- dotnet.removeEventHandler pdaTimer "tick" myTest
-- callbacks.removeScripts id:#FelipeCallback