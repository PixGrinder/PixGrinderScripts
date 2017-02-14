(
	clearListener()
	myConditions = 1
	myMinutes = 15
	TimeInterval = myMinutes*1000*60
	myMax = 30
	myTotal = myMax - 1
	myNumer = 1
	myFormatNumer = ""
	myDates = #()
	pda_temp = #()
	tempString = ""
	

	
	fn myAutoSave = 
	(
		--myFolder = maxfilepath + substituteString maxfilename ".max" ""+"_autoback"
		myFolder = maxfilepath + substituteString maxfilename ".max" ""+"_autoback"
		if myNumer <= myTotal then myNumer = myNumer +1 else myNumer = 1
		myFormatNumer = formattedPrint myNumer format:"03d"
		saveMaxFile (maxfilepath+maxfilename) clearNeedSaveFlag:true  useNewFile:true quiet:true
		copyfile (maxfilepath+maxfilename) (myFolder+"\\"+substituteString maxfilename ".max" ""+"_autoback_"+myFormatNumer+".max")
	)
	
		
	if maxfilename.count == 0 do 
	(
		myConditions = 0
		messageBox ("Please, save the current Scene before launching this script")
	)

	
	if myConditions == 1 do 
	(
		print "launch the script !!!"
		autoSave.Enable = False
		myFolder = maxfilepath + substituteString maxfilename ".max" ""+"_autoback"
		makeDir myFolder
		files = getFiles (myFolder+"\\*.max")
		if files.count == 0 then 
		(
			copyfile (maxfilepath+maxfilename) (myFolder+"\\"+substituteString maxfilename ".max" ""+"_autoback_"+"001"+".max") 
		) else (
			for i = 1 to files.count do
			(
				x1 = getFileModDate files[i]
				--append myDates (#((x1[5]+x1[6]+x1[7]+x1[8])as integer,x1[1] as integer,x1[3]as integer, x1[10] as integer,(x1[12]+x1[13]) as integer,(x1[15]+x1[16]) as integer, x1[18]+x1[19], filenamefrompath files[i]))
				tempString = ((x1[5]+x1[6]+x1[7]+x1[8]) + x1[1] + x1[3] + x1[10] + (x1[12]+x1[13]) + (x1[15]+x1[16]) +  (x1[18]+x1[19]) + (filenamefrompath files[i]))
				append pda_temp tempString
			)
			sort pda_temp
			x2 = pda_temp[pda_temp.count]
			tst = substring x2 (x2.count-6) 3
			myNumer =  tst as integer
		)
		
		
		global pdaTimer = dotNetObject "System.Windows.Forms.Timer"
		dotnet.addEventHandler pdaTimer "tick" myAutoSave
		pdaTimer.interval = TimeInterval
		pdaTimer.start()
		--pdaTimer.stop()
		
	) 

	

)


-----------------
pdaTimer.stop


