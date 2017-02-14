(	
	clearListener()
	global myCount = 0
	global pda = geometry as array
	global megArray = #()
	global indexArray = #()
	global myStatus = 1
	global myNames = #()
	global myRes = 2048
	
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
		
		
		for mySel in mySets do
		(
			for i = 1 to mySel.count do
			(
				append myNames mySel[i].name
				if i == 1 then
				(
					myMax = polyop.getNumFaces mySel[1]
					append myFaces #{1..myMax}
					print (" i = " + (i as String) + " , max Faces = " + (myMax as string) + " " + mySel[i].name)
				) else (
					for j = 2 to i do myMin = myMax + 1
					myMax = myMin + polyop.getNumFaces mySel[i] 
					myMax = myMax - 1
					print (" i = " + (i as String) + " , max Faces = " + (myMax as string) + " " + mySel[i].name)
					append myFaces #{myMin..myMax}
				)
			)
			
			for i = 2 to mySel.count do mySel[1].EditablePoly.attach mySel[i] mySel[1]
				
			select mySel[1]
			max modify mode
			x1 = unwrap_UVW()
			modPanel.addModToSelection x1
			subobjectLevel = 3
			max select all
			myMod = mySel[1].modifiers["Unwrap UVW"]
			myMod.setMapChannel 3
			myMod.flattenMap 66.0 #() 0.005 true 0 true true
			collapseStack mySel[1]
			
			
			
			
			BakeDiffuse mySel[1] myRes
			ChannelInfo.CopyChannel mySel[1] 3 3
			ChannelInfo.PasteChannel mySel[1] 3 1
			collapseStack mySel[1]
			
			
			
			
			
			
			select mySel[1]
			mySel[1].name = mySel[1].name + "_OLD"
			max modify mode
			subobjectLevel = 4
			for i = 1 to myNames.count do
			(
				if  i == myNames.count then
				(
					myMax = polyop.getNumFaces mySel[1]
					myLast = #{myMin..myMax}
					polyop.detachFaces mySel[1] myLast delete:false asNode:true name:myNames[i]
				) else (	
					polyop.detachFaces mySel[1] myFaces[i] delete:false asNode:true name:myNames[i]
				)
			)
			print (myFaces[myNames.count]) as string
			subobjectLevel = 0
			
			delete mySel[1]
			
			
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



