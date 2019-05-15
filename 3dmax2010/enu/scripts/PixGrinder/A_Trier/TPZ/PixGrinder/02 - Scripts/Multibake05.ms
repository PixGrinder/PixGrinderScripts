
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
	--Clear all render elements  
	obj.iNodeBakeProperties.removeAllBakeElements()  

	--Preparing the Bake Elements:
	be1 = diffusemap() --instance of the bake element class
	be1.outputSzX = be1.outputSzY = size --set the size of the baked map

	--specify the full file path, name and type:
	be1.fileType = (maxFilePath+"\\"+obj.name+"_diffuse.tga") --(getDir #image+"\\"+obj.name+"_diffuse.tga") 
	be1.fileName = filenameFromPath be1.fileType 
	be1.filterOn = true --enable filtering 
	be1.shadowsOn = false --disable shadows
	be1.lightingOn = false --disable lighting
	be1.enabled = true --enable baking
	be2 = LightingMap() -- instance of the bake element class
	be2.outputSzX = be2.outputSzY = size --set the size of the baked map

	--specify the full file path, name and type:
-- 	be2.fileType = (getDir #image+"\\"+obj.name+"_lighting.tga") 
-- 	be2.fileName = filenameFromPath be2.fileType 
-- 	be2.filterOn = true --enable filtering 
-- 	be2.shadowsOn =true --enable shadows
-- 	be2.enabled = true --enable baking
	 

	--Preparing the object for baking:
	obj.INodeBakeProperties.addBakeElement be1 --add first element
	-- obj.INodeBakeProperties.addBakeElement be2 --add second element
	obj.INodeBakeProperties.bakeEnabled = true --enabling baking
	obj.INodeBakeProperties.bakeChannel = 3 --channel to bake
	obj.INodeBakeProperties.nDilations =  20 --expand the texture a bit
	select obj --we are baking the selection, so we select the object

	--Call the renderer to bake both elements:   
	render rendertype:#bakeSelected vfb:off progressBar:true outputSize:[size,size]
-- 	theComp = CompositeTextureMap() --create a composite map
-- 	theComp.add() --add a second layer
-- 	theComp.blendMode = #(0,5) --set second layer to Multiply
	 
	--Create two maps, one with the diffuse, one with the lighting map
	theMap1 = bitmaptexture filename:be1.fileType
-- 	theMap2 = bitmaptexture filename:be2.fileType
-- 	theComp.mapList = #(theMap1, theMap2) --composite the two maps
-- 	theComp.opacity = #(100,70) --set the lighting map to 70% opacity
	 
	--Create a standard self-illum material using the Composite map 
	bakedMat = standard diffusemap:theMap1 selfIllumAmount:0
	 
	--Assign a Shell Material to the object, 

	--keep the old material as original material,

	--set the new bakedMat as the baked material:

-- 	obj.material = Shell_Material originalMaterial:obj.material \
-- 	bakedMaterial:bakedMat viewportMtlIndex:1 renderMtlIndex:1
	obj.material = bakedMat
	 
	--Show the textures of the baked material in the viewport
	--showTextureMap obj.material obj.material.bakedMaterial true 

	)--end fn

	
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
	--------------------------------------------- Bake Diffuse
	
	
	BakeDiffuse mySel[1] 2048
	
	ChannelInfo.CopyChannel mySel[1] 3 3
	ChannelInfo.PasteChannel mySel[1] 3 1
	collapseStack mySel[1]
	--(maxFilePath+"baked_maps")
	
	
	--------------------------------------------- / Bake Diffuse
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
	
	





	
