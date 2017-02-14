
---MultiBake 

(
	clearListener()

	--------------------------------------------- Variables
	global mySel = getCurrentSelection()
	global myNames = #()
	global myFaces =  #()
	global myStatus = 1
	global myMin = 1
	global myMax = 2
	
	---------------------------------------------  / Variables
	--------------------------------------------- Function
	
	fn BakeDiffuse obj size = 
	(
	obj.iNodeBakeProperties.removeAllBakeElements()  
	be1 = diffusemap()
	be1.outputSzX = be1.outputSzY = size
	be1.fileType = (maxFilePath+"\\"+obj.name+"_diffuse.tga")
	be1.fileName = filenameFromPath be1.fileType 
	be1.filterOn = true
	be1.shadowsOn = false
	be1.lightingOn = false
	be1.enabled = true
	be2 = LightingMap()
	be2.outputSzX = be2.outputSzY = size

	obj.INodeBakeProperties.addBakeElement be1
	obj.INodeBakeProperties.bakeEnabled = true
	obj.INodeBakeProperties.bakeChannel = 3
	obj.INodeBakeProperties.nDilations =  20
	select obj

	render rendertype:#bakeSelected vfb:off progressBar:true outputSize:[size,size]
	 
	theMap1 = bitmaptexture filename:be1.fileType
	 
	bakedMat = standard diffusemap:theMap1 selfIllumAmount:0
	 
	obj.material = bakedMat
	 
	)

	
	--------------------------------------------- / Function
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
	
	if maxFilePath.count == 0 do 
	(
		messagebox ("Please, save Max File before launching this script")
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
	)
	
	for i = 2 to mySel.count do polyop.attach mySel[1] mySel[i]
	print (polyop.getNumFaces mySel[1]) as string
		
	
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
	--------------------------------------------- Bake Diffuse
	
	
	BakeDiffuse mySel[1] 2048
	
	ChannelInfo.CopyChannel mySel[1] 3 3
	ChannelInfo.PasteChannel mySel[1] 3 1
	collapseStack mySel[1]
	
	
	--------------------------------------------- / Bake Diffuse
	--------------------------------------------- Detach Script
	
	select mySel[1]
	mySel[1].name = mySel[1].name + "_OLD"
	max modify mode
	subobjectLevel = 4
	--myTemp = myNames.count-1
	for i = 1 to myNames.count do
	(
		polyop.detachFaces mySel[1] myFaces[i] delete:false asNode:true name:myNames[i]
	)
	print (myFaces[myNames.count]) as string
	subobjectLevel = 0
	
	-- delete mySel[1]
	
	
	--------------------------------------------- / Detach Script
	
)
	
	

--------------------------------------------------

polyop.setFaceSelection $ #{29725..29815}
polyop.getNumFaces $
#{29725..29817}


	
