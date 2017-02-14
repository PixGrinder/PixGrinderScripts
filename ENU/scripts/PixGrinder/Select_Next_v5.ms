(
	clearListener()
	
	myStartCond = 1
	
	if selection.count == 0 do myStartCond = 2
	
	if objects.count == 0 do myStartCond = 3
	
	
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
		-- on myRad changed state do myCond = 2
	)
	
	-- fonctions :
	fn SelNext myVar = 
	(
		mySel = getCurrentSelection()
		max select all
		all = getCurrentSelection()
		v = findItem all mySel[1]
		nt = all.count
		
		if v+1 > nt then 
		(
			select all[1]
		)  else (
		v=v+1
		select all[v]
		)	
		
		if myVar == 1 then 
		(
			max zoomext sel all
		)
	)
	
	fn myDialogue = 
	(
		if Selector != undefined and Selector.isDisplayed == false do createDialog Selector
	)
	
		
	case of
	(
		(myStartCond == 1) :
		(
			print "myStartCond = 1"
			myDialogue()
			SelNext myCond
		)
		
		(myStartCond == 2) :
		(
			print "myStartCond = 2"
			select objects[1]
			myDialogue()
			SelNext myCond
		)
		
		(myStartCond == 3) :
		(
			print "myStartCond = 3"
			messageBox ("No objects in the scene !!")
		)
	
	)

)