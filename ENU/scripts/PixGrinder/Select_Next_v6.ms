(
	clearListener()
	
	myStartCond = 1
	myCond = 1
	
	if selection.count == 0 do myStartCond = 2
	
	if objects.count == 0 do myStartCond = 3
	
	global pda_mySelector


	rollout pda_mySelector "Selector" 
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
	
	
	try (destroyDialog pda_mySelector) catch ()
	createDialog pda_mySelector
	


	if myStartCond == 1 do
	(
		print "myStartCond = 1"
		print "myCond = " + (myCond as string)
		SelNext pda_mySelector.myRad.state
	)
	
	if myStartCond == 2 do
	(
		print "myStartCond = 2"
		select objects[1]
		SelNext pda_mySelector.myRad.state
	)
	
	if myStartCond == 3 do
	(
		print "myStartCond = 3"
		messageBox ("No objects in the scene !!")
	)

	

	
		

)

-- Total reBuild --
---------------------------------------------------------------------------

x1 = finditem (objects as array) selection[1]
if x1 < objects.count then select objects[x1+1] else select objects[1]
max zoomext sel all

---------------------------------------------------------------------------