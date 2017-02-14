(	
	clearListener()
	global myCount = 0
	global pda = geometry as array
	global megArray = #()
	global indexArray = #()
	global myStatus = 1
	
	if maxFilePath.count == 0 do 
	(
		messagebox ("Please, save Max File before launching this script")
		myStatus = 0
	)
	
	
	if myStatus == 1 do
	(
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
		
		global val = 0
		global i = 1
		global tempAr = #()
		global mySets = #()
		for obj in indexArray do
		(
			if val < 1000.0 then
			(
				val = val + obj[1]
				append tempAr obj[2]
			) else (
				append mySets tempAr
				tempAr =#()
				val = 0
			)
		)

	)



--------------------------------------------------------


-- Brouillon
----------------------

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


global myTables = #()
obj1 = #(7346.74, $)
obj2 = #(1590.55, $)

append myTables obj1
append myTables obj2


indexArray = myTables

myTables[1][1] - myTables[2][1]

fn compareFN v1 v2 arr: =
(
	local d= v1[1] - v2[1]
	print d
	case of
	(
		(d < 0.): -1
		(d > 0.): 1
		default: 0
	)
)

qSort indexArray compareFN arr:myTables



