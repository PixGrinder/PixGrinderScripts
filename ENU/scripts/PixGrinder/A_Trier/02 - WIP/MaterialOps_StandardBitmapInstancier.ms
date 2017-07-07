-- MaterialOps - Standard Bitmap Materials Instancier -- 
-- v 1.0 --



(
	
	fn updateMatInfos =
	(
		-- Force to update Scene Materials informations by saving an empty maxFile --
		tempFile = maxFilePath + "_tempSceneMaterialsHack.max"
		saveNodes #() tempFile
		deleteFile tempFile
	)

	-- x1 = tous les matériaux standards de la scene
	x1 = getClassInstances standardMaterial
	myStart = x1.count as string


	-- x2 = tous les materiaux standards qui ont une image en diffuseMap -- et 100% opacité
	x2 = for obj in x1 where classof obj.diffusemap == BitmapTexture and obj.diffusemap.filename != undefined and obj.opacity == 100 collect obj    

	-- myObjStd = tous les objets de la scene qui ont un matériau standard avec texture en diffuse
	myObjStd = for obj in objects where classof obj.material == StandardMaterial and classof obj.material.diffusemap == BitmapTexture and obj.material.diffusemap.filename != undefined collect obj 

	-- myObjMult = tous les objets de la scene qui ont un multi matériaux
	myObjMult = for obj in objects where classof obj.material == Multimaterial collect obj 

	-- pda =  liste de tous les fichiers textures utilisés dans la scène
	pda = #()
	for obj in x2 do appendifunique pda (filenameFromPath obj.diffusemap.filename)


	-- Nettoyage des multimatériaux possédant 1 seul sous-matériau
	for obj in myObjMult where obj.material.count == 1 do 
	(
		matTemp = obj.material[1]
		obj.material = matTemp
	)

	updateMatInfos()
	-- RE myObjMult = tous les objets de la scene qui ont un multi matériaux
	myObjMult = for obj in objects where classof obj.material == Multimaterial collect obj 



	for k = 1 to pda.count do
	(
		myTemp = for obj in x2 where (filenamefrompath obj.diffusemap.filename) == pda[k] collect obj -- myTemp = tous les matériaux qui ont la texture pda[k]
		
		-- traitement des objets à matériau simple
		for obj in myObjStd where (filenamefrompath obj.material.diffuseMap.filename) == pda[k] do obj.material = myTemp[1]

		-- traitement des objets à matériau multiple
		for obj in myObjMult do 
		(
			for i = 1 to obj.material.count do
			(
				if classof obj.material[i].diffusemap == BitmapTexture and obj.material[i].diffusemap.filename != "" and (filenamefrompath obj.material[i].diffuseMap.filename) == pda[k] do obj.material[i] = myTemp[1]
			)
		)
	)

	updateMatInfos()
	x1 = getClassInstances standardMaterial
	print ("Nb matériaux Standards before batch : " + myStart)
	print ("Nb matériaux Standards AFTER batch : " + (x1.count as string) )

)