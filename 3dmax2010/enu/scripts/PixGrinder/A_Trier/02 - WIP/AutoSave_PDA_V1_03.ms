(
	clearListener()
	myConditions = 1
	myMinutes = 10
	TimeInterval = myMinutes*1000*60
	myMax = 50
	myTotal = myMax - 1
	myNumer = 1
	myFormatNumer = ""
	myDates = #()
	pda_temp = #()
	tempString = ""
	

	fn  SaveStartup = 
	(
		--myFolder = maxfilepath + substituteString maxfilename ".max" ""+"_autoback"
		myFolder = maxfilepath + substituteString maxfilename ".max" ""+"_autoback"
		if myNumer <= myTotal then myNumer = myNumer +1 else myNumer = 1
		myFormatNumer = formattedPrint myNumer format:"03d"
		if (getFiles (myFolder+"\\"+substituteString maxfilename ".max" ""+"_autoback_"+myFormatNumer+".max")).count == 1 do deleteFile (myFolder+"\\"+substituteString maxfilename ".max" ""+"_autoback_"+myFormatNumer+".max")
		
		saveMaxFile (maxfilepath+maxfilename) clearNeedSaveFlag:true  useNewFile:true quiet:true
		copyfile (maxfilepath+maxfilename) (myFolder+"\\"+substituteString maxfilename ".max" ""+"_autoback_"+myFormatNumer+".max")
	)
	
	
	fn myAutoSave = 
	(
		if getSaveRequired() == true do SaveStartup()
	)
	
		
	if maxfilename.count == 0 do 
	(
		myConditions = 0
		messageBox ("Please, save the current Scene before launching this script")
	)

	
	if myConditions == 1 do 
	(
		--print "launch the script !!!"
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
				myArray = filterstring x1 "/ : "
				if myArray[1].count == 1 do  myArray[1] = "0" + myArray[1]
				if myArray[2].count == 1 do  myArray[2] = "0" + myArray[2]
				if myArray[4].count == 1 do  myArray[4] = "0" + myArray[4]
				myArray
				x1 = myArray[3]+myArray[2]+myArray[1]+myArray[4]+myArray[5]+myArray[6]+myArray[7]+(filenamefrompath files[i])
				print x1
				append pda_temp x1
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
		SaveStartup()
		--pdaTimer.stop()
		
	) 


)





----------------------------------------
clearlistener()
for i = 1 to files.count do 
(
	print ((filenamefrompath files[i]) + "   " + getFileModDate files[i])
)


for i = 1 to 8 do print pda_temp[i]

(
	clearlistener()
	i=8
	y1 = getFileModDate files[i]
	print y1.count
	if y1.count != 22 do print y1
)

----------------------------------------
(
	clearlistener()
	x1 = "15/11/2016 12:04:20 AM"
	print x1
	myArray = filterstring x1 "/ : "
	if myArray[1].count == 1 do  myArray[1] = "0" + myArray[1]
	if myArray[2].count == 1 do  myArray[2] = "0" + myArray[2]
	if myArray[4].count == 1 do  myArray[4] = "0" + myArray[4]
	myArray
	x1 = myArray[3]+myArray[2]+myArray[1]+myArray[4]+myArray[5]+myArray[6]+myArray[7]
)

-- 05/23/2016 11:04:20 AM
-- 5/3/2016 9:04:20 AM
-- 15/3/2016 9:04:20 AM
-- 15/3/2016 19:04:20 AM

-- x1.count must = 22
