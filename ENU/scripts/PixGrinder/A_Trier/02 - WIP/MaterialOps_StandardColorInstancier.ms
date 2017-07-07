-- MaterialOps - Standard Color Materials Instancier -- 
-- v 1.0 --



(
	-- x1 = tous les matériaux standards de la scene
	x1 = getClassInstances standardMaterial
	myStart = x1.count as string


	-- x2 = tous les materiaux standards sans diffuseMap
	x2 = for obj in x1 where obj.diffusemap == undefined and obj.opacity == 100 collect obj -- added material filter : only mats with opacity = 100

	-- myObjStd = tous les objets de la scene qui ont un matériau standard sans diffuseMap
	myObjStd = for obj in objects where classof obj.material == StandardMaterial and obj.material.diffusemap == undefined collect obj

	-- myObjMult = tous les objets de la scene qui ont un multi matériaux
	myObjMult = for obj in objects where classof obj.material == Multimaterial collect obj



	-- Nettoyage des multimatériaux possédant 1 seul sous-matériau
	for obj in myObjMult where obj.material.count == 1 do 
	(
		matTemp = obj.material[1]
		obj.material = matTemp
	)

	-- pda =  liste de toutes les couleurs diffuse utilisées dans la scène
	pda = #()
	for obj in x2 do appendifunique pda (obj.diffuse as string)

	-- RE myObjMult = tous les objets de la scene qui ont un multi matériaux
	myObjMult = for obj in objects where classof obj.material == Multimaterial collect obj


	for k = 1 to pda.count do
	(
		myTemp = for obj in x2 where (obj.diffuse as string) == pda[k] collect obj -- myTemp = tous les matériaux qui ont la couleur pda[k]
		
		-- traitement des objets à matériau simple
		for obj in myObjStd where (obj.material.diffuse as string) == pda[k] do obj.material = myTemp[1]

		-- traitement des objets à matériau multiple
		for mat in myObjMult do 
		(
			for i = 1 to mat.material.count do
			(
				if mat.material[i].diffuseMap == undefined and (mat.material[i].diffuse as string) == pda[k] do mat.material[i] = myTemp[1]
			)
		)
	)

	
	-- Force to update Scene Materials informations by saving an empty maxFile --

	tempFile = maxFilePath + "_tempSceneMaterialsHack.max"
	saveNodes #() tempFile
	deleteFile tempFile

	-----------------------------------------------------------------------------


	x1 = getClassInstances standardMaterial
	print ("Nb matériaux Standards before batch : " + myStart)
	print ("Nb matériaux Standards AFTER batch : " + (x1.count as string) )

)