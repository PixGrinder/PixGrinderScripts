(
	--toolMode.transformCenter()
	
	
	myFold = "D:\10 - Helicopters\AS365VMT\AH_AS365_3Dfiles\MAX\Optimized\\"
	
	files = getFiles (myFold+"*.FBX")
	
	i=1
	for i = 1 to files.count do
	(		
		resetMaxFile #noPrompt
		importFile files[i] #noPrompt using:FBXIMP
		
		max select all
		pda = getCurrentSelection()
		myDum = dummy name:"AVirer"
		
		for obj in pda do obj.parent = myDum 
		
		myDum.rotation = (EulerAngles 90 0 0)
		myDum.scale = myDum.scale * 10
		
		for obj in pda do 
		(
			obj.parent = undefined
			resetXform obj
			ConvertToPoly obj
		)
		redrawViews()
		delete myDum
		x1 = substring files[i] 1 (files[i].count-4) + ".max"
		saveMaxFile x1 -- #noPrompt -- useNewFile:false quiet:true
	)
)
	