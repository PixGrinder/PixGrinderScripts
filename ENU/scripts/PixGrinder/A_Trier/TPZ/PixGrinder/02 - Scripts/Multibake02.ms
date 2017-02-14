
---MultiBake 

(

	clearListener()
	global mySel = getCurrentSelection()
	global myNames = #()
	global myFaces =  #()
	global myStatus = 1
	global myMin = 1
	global myMax = 2
	
	--------------------------------------------- Startup conditions

	for i = 1 to mySel.count do
	(
		if superclassof mySel[i] != GeometryClass do 
		(
			messagebox ("Please select only Geometry objects")
			myStatus = 0
		)
			
	)

	if mySel.count < 2 do 
	(
		messagebox ("Please, select multiple objects")
		myStatus = 0
	)
		
	--------------------------------------------- / Startup conditions
	
	
	--------------------------------------------- Attachment Script
	
	if myStatus == 1 do
	(
		for i = 1 to mySel.count do
		(
			convertToPoly(mySel[i])
			append myNames mySel[i].name
			if i == 1 then
			(
				-- myMin = 1
				myMax = polyop.getNumFaces mySel[1]
				-- myBit = #{1..myMax}
				append myFaces #{1..myMax}
			) else (
				for j = 2 to i do myMin = myMax + 1
				myMax = myMin + polyop.getNumFaces mySel[i] 
				myMax = myMax - 1
				append myFaces #{myMin..myMax}
			)
		)
	)
	
	for i = 2 to mySel.count do polyop.attach mySel[1] mySel[i]
		
	
	---------------------------------------------  / Attachment Script

	
	--------------------------------------------- UV3 Flatten
	
	select mySel[1]
	max modify mode
	x1 = unwrap_UVW()
	modPanel.addModToSelection x1
	subobjectLevel = 3
	max select all
	myMod = mySel[1].modifiers["Unwrap UVW"]
	myMod.setMapChannel 3
	myMod.flattenMap 66.0 #() 0.01 true 0 true true
	collapseStack mySel[1]
	

	--------------------------------------------- / UV3 Flatten


	--------------------------------------------- Detach Script
	
	select mySel[1]
	mySel[1].name = mySel[1].name + "_OLD"
	max modify mode
	subobjectLevel = 4
	for i = 1 to myNames.count do
	(
		-- polyop.setFaceSelection mySel[1] myFaces[i]
		polyop.detachFaces mySel[1] myFaces[i] delete:false asNode:true name:myNames[i]
	)
	subobjectLevel = 0
	delete mySel[1]
	
	
	--------------------------------------------- / Detach Script
	
)
	
	





	


	

--------------------------------
-- Brouillon


polyop.detachFaces <Poly poly> <facelist> \

delete:<boolean=true> asNode:<boolean=false> \

name:<string="Object01"> node:<node=unsupplied>











for i = 1 to mySel.count do print ( myNames[i] + " : " + (myFaces[i] as string))


max modify mode
subobjectLevel = 4
i = 4
polyop.setFaceSelection $ myFaces[i]
redrawViews()


--------------------------------
