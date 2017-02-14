(
	clearListener()
	myConditions = 1
	TimeInterval = 0.1*1000*60
	myMax = 10
	myTotal = myMax - 1
	myNumer = 1
	myFormatNumer = ""
	myDates = #()
	pda_temp = #()

	
	fn myAutoSave = 
	(
		
		--myFolder = maxfilepath + substituteString maxfilename ".max" ""+"_autoback"
		
		files = getFiles (myFolder+"\\*.max")
		if myNumer <= myTotal then myNumer = myNumer +1 else myNumer = 1
		myFormatNumer = formattedPrint myNumer format:"03d"
		if files.count == 1 do
		(
			saveMaxFile(maxfilepath+maxfilename)
			copyfile (maxfilepath+maxfilename) (myFolder+"\\"+substituteString maxfilename ".max" ""+"_autoback_"+myFormatNumer+".max")
		)
		
		if files.count > 1 do
		(

		)
		
		
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
			x2 = pda_temp[pdatemp.count]
		)
		
		
		pdaTimer = dotNetObject "System.Windows.Forms.Timer"
		dotnet.addEventHandler pdaTimer "tick" myAutoSave
		pdaTimer.interval = TimeInterval
		pdaTimer.start()
		
	) 
)