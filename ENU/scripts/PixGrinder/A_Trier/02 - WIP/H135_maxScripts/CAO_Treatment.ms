(
	clearListener()	
	
	ScaleRatio = 10
	myOffset = [10,10,10]
	myRot = (eulerAngles 10 10 10)
	
	$.rotation as EulerAngles
	
	myMod = Vertex_Weld()
	myMod.threshold = 0.0001
	
	fn ReNode =
	(
		for obj in geometry do 
		(
			if obj.parent != undefined do obj.name = obj.parent.name
		)
	)

	
	ReNode()
	delete helpers
	
	myDummy = dummy pos:[0,0,0]
	try myDummy.name = (substring maxFileName 1 4) catch ()
	
	for obj in objects where obj != myDummy do obj.parent = myDummy
		
	myDummy.pos = myOffset
	myDummy.scale *= ScaleRatio
	myDummy.rotation = myRot
	delete myDummy


	for obj in geometry do 
	(
		resetXForm obj
		convertToPoly obj
	)
	
	for obj in geometry do
	(
		addmodifier obj myMod
		addmodifier obj (Smooth())
		--maxOps.CollapseNodeTo obj 1 off
		convertToPoly obj
	)

		

)


