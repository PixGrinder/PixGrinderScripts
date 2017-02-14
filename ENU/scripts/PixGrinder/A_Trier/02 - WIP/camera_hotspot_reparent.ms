(
	clearListener()
	pda = #()
	pda = ( for obj in cameras where superClassOf obj == camera collect obj ) + ( for obj in cameras where classof obj == Targetobject collect obj )
	
		

	for obj in pda do
	(
		x1 = substring obj.name 1 (obj.name.count-8)
		for tmp in objects do
		(
			if matchpattern tmp.name pattern:x1 == true then obj.parent = tmp
		)
	)


)

