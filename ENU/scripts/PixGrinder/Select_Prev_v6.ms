(
	clearListener()
	
	myStartCond = 1
	myCond = 1
	
	if selection.count == 0 do myStartCond = 2
	
	if objects.count == 0 do myStartCond = 3
	
	if Selector == undefined do
	(
	-- rollout : 
		rollout Selector "Selector" 
		(
			radiobuttons myRad labels:#("Zoom On", "Zoom Off") default:1
			
			on myRad changed state do 
			(
				if myRad.state == 2 then
				(
					myRad.state = 2 
					myCond = 2
				) else (
					myRad.state = 1
					myCond = 1
				)
				
			)
		)
	)
	
	
	fn SelNext myVar = 
	(
		mySel = getCurrentSelection()
		max select all
		all = getCurrentSelection()
		v = findItem all mySel[1]
		nt = all.count
		
		if v-1 < 1 then 
		(
			select all[nt]
		)  else (
		v=v-1
		select all[v]
		)	
		
		if myVar == 1 then 
		(
			max zoomext sel all
		)
	)
	
	fn myDg x1= 
	(
		print "myDg was used"
		--if Selector != undefined and Selector.isDisplayed == false do createDialog Selector
		if x1.isDisplayed == false do createDialog Selector
	)
	
	
	
	if myStartCond == 1 do
	(
		print "myStartCond = 1"
		print "myCond = " + (myCond as string)
		myDg Selector
		SelNext Selector.myRad.state
	)
	
	if myStartCond == 2 do
	(
		print "myStartCond = 2"
		select objects[1]
		myDg Selector
		--if Selector != undefined and Selector.isDisplayed == false do createDialog Selector
		SelNext Selector.myRad.state
	)
	
	if myStartCond == 3 do
	(
		print "myStartCond = 3"
		messageBox ("No objects in the scene !!")
	)

	

	
		

)