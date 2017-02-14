(
	clearListener()
	
	myStartCond = 1
	
	if objects.count == 0 then myStartCond = 2
	
	if selection.count == 0 then myStartCond = 3
		
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
	
	if Selector == undefined then
	(
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
		createDialog Selector
	) else if Selector.isDisplayed == false then createDialog Selector
	
		
	case of
	(
		myStartCond == 1 :
		(

			
			SelNext myCond
		)
		
		myStartCond == 2 :
		(
			select objects[1]
			
		)
	
	)
		
	
	


	
)