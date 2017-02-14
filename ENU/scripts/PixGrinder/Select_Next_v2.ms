(
	clearListener()
	-- myCond = 1 
-- 	mySel = #()
-- 	all = #()
-- 	myVar = 1
	-- try destroyDialog Selector catch ()
	
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
	
-- 	fn myTest = 
-- 	(
-- 		x1 = getCurrentSelection()
-- 		max select all
-- 		for i = 1 to x1.count do print x1[i].name
-- 	)
	
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
	
	try
	( if Selector.isDisplayed == false then createDialog Selector
	) catch ()
	
	SelNext myCond

	
)