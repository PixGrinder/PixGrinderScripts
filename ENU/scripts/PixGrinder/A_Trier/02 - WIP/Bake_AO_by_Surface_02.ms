-- Bake AO by Surface --

-- To do : --
-- Keep alpha blending in baked bitmaps --
-- Find a way to bake only AO, and assign it to UV channel 2 or 3, and make it work in Unity --




(	
	
	myCount = 0
	pda = for obj in geometry where classof obj != Targetobject and obj.numfaces >0 collect obj
	megArray = #()
	myStatus = 1
	myNames = #()
	myRes = 256
	myMod = Normalmodifier flip:on
	clearListener()

	-- set Mental Ray as renderer
	renderers.current = mental_ray_renderer()
	renderers.current.FinalGatherEnable2 = false

	
	-- Create default AO Shader --
	theAO = StandardMaterial name:"AO"
	theAO.diffuseMap = mix()
	theAO.diffuseMap.mixAmount = 0
	theAO.diffuseMap.map1 = Ambient_Reflective_Occlusion__3dsmax()
	theAO.diffuseMap.map1.samples = 128
	theAO.diffuseMap.map1.falloff = 1.0
	theAO.diffuseMap.map1.max_distance = 0.0
	theAO.diffuseMap.map1.dark = color 0 0 0 255
	theAO.selfIllumAmount = 100
	clearListener()

	fn bakeMat theObj =
	(
			-- meditMaterials[1] = theObj.material
			if classof theObj.material == StandardMaterial then
			(
				myMap = theObj.material.diffuseMap
				myColor = theObj.material.diffuse

				if theObj.material.diffuseMap == undefined then 
				(
					theObj.material = copy theAO
					theObj.material.diffuseMap.map1.bright = myColor
					--theObj.material.diffuseMap.map2 = undefined
					theObj.material.diffuseMap.color2 = myColor
				) else (
					theObj.material = copy theAO
					theObj.material.diffuseMap.map1.bright_shader = myMap
					theObj.material.diffuseMap.map2 = myMap
				)
			)

			------ A RETOUCHER !! ----
			------ A RETOUCHER !! ----
			------ A RETOUCHER !! ----
			------ A RETOUCHER !! ----

			if classof theObj.material == MultiMaterial then
			(

				for i = 1 to theObj.material.count where theObj.material[i] != undefined do
				(
					myMap = theObj.material[i].diffuseMap
					myColor = theObj.material[i].diffuse

					if theObj.material[i].diffuseMap == undefined then 
					(
						theObj.material[i] = copy theAO
						theObj.material[i].diffuseMap.map1.bright = myColor
						theObj.material[i].diffuseMap.color2 = myColor
					) else (
						theObj.material[i] = copy theAO
						theObj.material[i].diffuseMap.map1.bright_shader = myMap
						theObj.material[i].diffuseMap.map2 = myMap
					)
				)
			)

			-- meditMaterials[13] = theObj.material
	)


	----------------------------------
	
	if maxFilePath.count == 0 do 
	(
		messagebox ("Please, save Max File before launching this script")
		myStatus = 0
	)
	
	
	if myStatus == 1 do
	(
		fn compareFN v1 v2 =
		(
			if v1[1] < v2[1] then -1 else 1
		)
		
		for obj in pda do 
		(
			setFaceSelection obj #{1..obj.numfaces}
			myTempFaces = getFaceSelection obj
			x1Temp = (meshop.getFaceArea (snapshotAsMesh obj) myTempFaces)
			if x1Temp > 5.99 then 
			append megArray #(x1Temp, obj)
		)

	
		qSort megArray compareFN -- arr:megArray -- On obtient la liste des objets, trié par surface
		
		for i = 1 to megArray.count do print (megArray[i][1] as string + " : " + megArray[i][2] as string)
	)
	actionMan.executeAction 0 "40472"




	clearSelection()



	myMult = 1.5

	
	for obj in megArray do
	(
		-- Créer une boite autour de chaque objet --
		clearSelection()
		max hide inv
		obj[2].isHidden = false
		select obj[2]
		myBox = box length:(myMult*(abs(obj[2].max.y - obj[2].min.y))) transform:obj[2].transform width:(myMult*(abs (obj[2].max.x - obj[2].min.x))) height:(myMult*(abs (obj[2].max.z - obj[2].min.z)))
		myBox.center = obj[2].center
		addModifier myBox myMod
		collapseStack myBox
		convertToPoly myBox
		polyop.deleteFaces myBox #{2..6}
		myBox.material = StandardMaterial diffuse:(color 128 128 128)




		-- Auto UV Mapping --
		max modify mode
		mySpacing = 0.001
		MyWarp = unwrap_UVW()
		setFaceSelection obj[2] #{1..obj[2].numfaces}
		addModifier obj[2] MyWarp
		MyWarp.setMapChannel 3
		MyWarp.flattenMap 80.0 #() mySpacing true 0 true true
		collapseStack obj[2]


		-- Prepare materials for AO Baking-- 

		bakeMat obj[2]
		
		-- Automatic Bitmap Resolution --
		case of
		(
			(obj[1] < 10.0): myRes = 256
			(obj[1] > 10.0 and obj[1] < 20.0): myRes = 512
			(obj[1] > 20.0 and obj[1] < 100.0): myRes = 1024
			(obj[1] > 100.0 and obj[1] < 200.0): myRes = 2048
			(obj[1] > 200.0): myRes = 4096
		)
		



		-- Prepare Object for baking -- 
		obj[2].iNodeBakeProperties.removeAllBakeElements()
		be1 = completemap()
		be1.outputSzX = be1.outputSzY = myRes -- Ajouter "caseOf" avec resolution en fonction de la surface
		be1.fileType = maxFilePath + obj[2].name + "_baked.png"
		be1.fileName = fileNameFromPath be1.fileType
		be1.filterOn = true
		be1.enabled = true
		be1.backgroundColor = (color 128 128 128)
		obj[2].INodeBakeProperties.addBakeElement be1
		obj[2].INodeBakeProperties.bakeEnabled = true
		obj[2].INodeBakeProperties.bakeChannel = 3
		obj[2].INodeBakeProperties.nDilations = 16
		



		-- display baked mat in the Viewport -- 

		-- showTextureMap obj[2].material obj[2].material.diffuseMap true 

		
		-- Bake Complete Map based on uv 3--
		select obj[2]
		render rendertype:#bakeSelected vfb:off progressBar:true outputSize:[myRes,myRes]
		theMap1 = bitmaptexture filename:be1.fileType
		
		obj[2].material = StandardMaterial diffusemap:theMap1 specularLevel:50 glossiness:20
		showTextureMap obj[2].material on





		--  Copy UV3 to UV1
		ChannelInfo.CopyChannel obj[2] 3 3
		ChannelInfo.PasteChannel obj[2] 3 1
		collapseStack obj[2]




		-- delete the Bounding Box --
		delete myBox

	)

max unhide all

)

----------------------------




/*


obj = #("1",selection[1])




meditMAterials[1] = theAO
meditMAterials[2] = copy theAO

05 à 15 -> 256
15 à 60 -> 512
60 à 200 -> 1024
200 ++   -> 2048


obj = #("youpla")
append obj $


obj = selection[1]
setFaceSelection obj #{1..obj.numfaces}
myTempFaces = getFaceSelection obj
x1Temp = (meshop.getFaceArea (snapshotAsMesh obj) myTempFaces)




$.numfaces
x1 = getFaceSelection obj as array


(meshop.getFaceArea (snapshotAsMesh obj) #{1..(getNumFaces obj)})




*/



