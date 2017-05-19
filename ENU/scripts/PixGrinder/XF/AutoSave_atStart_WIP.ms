-- PixGrinder 1st Startup Script !!! --




-- Variables Definitions : 
--------------------------

	-- global files
	global pda_filesVault
	global myMinutes = 0.5
	global TimeInterval = myMinutes*1000*60
	global myMax = 50
	global myTotal = myMax - 1
	global myNumer = 1
	global myFormatNumer = ""
	global pda_temp = #()
	global pda_doCopy = false
	global pdaTimer = dotNetObject "System.Windows.Forms.Timer"
	global myFolder = ""
	-- global tempString = ""
	-- global myDates = #()

		



--------------------


--  Functions :
----------------

	fn myAutoSaveOpenFile=
	(
	-- 	sleep 5
		-- pda_TheStart = true
		--messagebox ("AutoSave is launched !")
		--fileIn "$userScripts/PixGrinder/XF/AutoSave_WIP.ms"
		pda_AutoSaveProcess()
		if QueryBox("Save current scene ? ") == true then pda_SaveAction()
		format "myAutoSaveOpenFile function executed\r"
	)


	fn pda_AutoSaveProcess =
	(
			if maxfilename.count == 0 then 
			(
				messageBox ("Please, save the current Scene before launching this script")
			) else (
				-- autoSave.Enable = False
				myFolder = maxfilepath + "_BACKUP_\\"+ substituteString maxfilename ".max" ""+"_autoback"
				if doesFileExist myFolder == false then makeDir myFolder
				pda_filesVault = getFiles (myFolder+"\\*.max")
				if pda_filesVault.count == 0 then pda_doCopy = true else pda_doCopy = false
				if pda_doCopy == true then
				(
					copyfile (maxfilepath+maxfilename) (myFolder+"\\"+substituteString maxfilename ".max" ""+"_autoback_"+"001"+".max")
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
					tst = substring x2 (x2.count-6) 3
					myNumer =  tst as integer
				)
			)
	
			if myNumer <= myTotal then myNumer = myNumer +1 else myNumer = 1
			myFormatNumer = formattedPrint myNumer format:"03d"
	)
	
	-- Save Action --
	fn pda_SaveAction = 
	(
		if (getFiles (myFolder+"\\"+substituteString maxfilename ".max" ""+"_autoback_"+myFormatNumer+".max")).count == 1 do deleteFile (myFolder+"\\"+substituteString maxfilename ".max" ""+"_autoback_"+myFormatNumer+".max")
		if getSaveRequired() == true then
		(
			saveMaxFile (maxfilepath+maxfilename) clearNeedSaveFlag:true  useNewFile:true quiet:true
			copyfile (maxfilepath+maxfilename) (myFolder+"\\"+substituteString maxfilename ".max" ""+"_autoback_"+myFormatNumer+".max")
		)
	)

	fn pda_AutoSave = 
	(
		pda_AutoSaveProcess()
		pda_SaveAction()
	)


	-- Deactivate 3dsmax autosave 
	------------------------------
	autoSave.Enable = False

	-- Callback :
	----------------
	callbacks.addScript #filePostOpen "myAutoSaveOpenFile()" id:#FelipeCallback persistent:false
	format ("PixGrinder Startup Done\r")

	
	-- Timer : 
	-----------
	dotnet.addEventHandler pdaTimer "tick" pda_AutoSave
	pdaTimer.interval = TimeInterval
	pdaTimer.start()






--------------------



/*
-- Original Script

	if maxfilename.count == 0 then 
	(
		messageBox ("Please, save the current Scene before launching this script")
	) else (
		--print "launch the script !!!"
		autoSave.Enable = False
		myFolder = maxfilepath + "_BACKUP_\\"+ substituteString maxfilename ".max" ""+"_autoback"
		if doesFileExist myFolder == false then makeDir myFolder
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
			tst = substring x2 (x2.count-6) 3
			myNumer =  tst as integer
		)
	)

*/


