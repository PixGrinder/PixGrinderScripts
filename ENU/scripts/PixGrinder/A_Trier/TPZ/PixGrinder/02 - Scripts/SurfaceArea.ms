(
	clearListener()
	global pda = $
	global myCount = 0

	select pda
	convertToPoly pda
	myMax = polyop.getNumFaces pda
	max modify mode
	-- subobjectlevel = 4

	for i = 1 to myMax do
	(
		myTemp = polyop.getFaceArea pda i
		myCount = myCount + myTemp
	)

	print (pda.name+" surface : "+ myCount as string)
)


