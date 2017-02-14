(
	--toolMode.transformCenter()
	
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
	max file save
)
	