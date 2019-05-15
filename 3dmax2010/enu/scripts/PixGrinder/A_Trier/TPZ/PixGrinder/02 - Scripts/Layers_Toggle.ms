(
	myNb = layermanager.count
	myNb = myNb-1
	myStatus = layermanager.getLayer 1
	
	if myStatus.on == false then
	(
		for i = 1 to myNb do 
		(
			x = layermanager.getLayer i
			x.on = true
		)
	) else (
		for i = 1 to myNb do 
		(
			x = layermanager.getLayer i
			x.on = false
		)
	)
)