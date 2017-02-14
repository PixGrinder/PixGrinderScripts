(
	pda = getCurrentSelection()



	for i = 1 to pda.count do
	(
		cam = pda[i]
		if superclassof cam == camera do
		(
			myName = cam.name
			myParent = cam.parent
			cam.parent = undefined
			myPos = cam.pos
			delete cam
			x1 = Physical targeted:off iso:300.00 name:myName pos:myPos isSelected:off
			x1.parent = myParent
			select x1
		)
		i=i+1
	)
)