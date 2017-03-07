(	
	clearListener()
	global myCount = 0
	global pda = geometry as array
	global megArray = #()
	global indexArray = #()

	fn compareFN v1 v2 arr: =
	(
		local d= v1[1] - v2[1]
		case of
		(
			(d < 0.): -1
			(d > 0.): 1
			default: 0
		)
	)
	

	for i = 1 to pda.count do
	(
		select pda[i]
		convertToPoly pda[i]
		myMax = polyop.getNumFaces pda[i]
		max modify mode
		myCount = 0
		for j = 1 to myMax do
		(
			myTemp = polyop.getFaceArea pda[i] j
			myCount = myCount + myTemp
		)
		
		append megArray #(myCount, pda[i])
		
	)
	
	indexArray = megArray
	
	qSort indexArray compareFN arr:megArray
	
	for i = 1 to indexArray.count do print (indexArray[i][1] as string + " : " + indexArray[i][2] as string)
	

)
