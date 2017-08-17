-- MaterialOps - MultiMaterials Instancier -- 
-- v 1.1 --



(
	fn sortMatList v1 v2 =
	(
		if v1[1] > v2[1] then 1 else -1
	)

	fn stringCompare v1 v2 =
	(
		if v1.count > v2.count then 1 else -1
	)


	-- lister tous les multimatériaux de la scene
	allMulti = getClassInstances MultiMaterial
	blublurf = ("Number of Multimaterials before script : " + allMulti.count as string)

	-- lister tous les objets avec multimatériaux
	allObj = for obj in objects where classof obj.material == MultiMaterial collect obj


	-- trier tous les MultiMateriaux par nombre de sous-matériaux
	pda = #()
	for obj in allMulti do 
	(
		myTempA = #()
		for i = 1 to obj.count do 
		(
			if classof obj[i].diffuseMap == BitmapTexture and filenamefrompath obj[i].diffuseMap.filename != "" then
			(
				append myTempA (filenamefrompath obj[i].diffuseMap.filename)
			) else append myTempA (obj[i].diffuse as string)
		)
		myTempA = myTempA as string
		append pda #(obj.count,obj,myTempA)
	)
	qsort pda sortMatList

	
	-- Stockage des listes de bitmaps      -- myLists = liste des listes de bitmaps uniques
	-----------------------------------
	myLists = #()
	for obj in pda do appendIfUnique myLists obj[3]
	qsort myLists stringCompare

	

	-- myTri = pour chaque liste unique de bitmaps associer le 1er matériau trouvé qui correspond
	myTri= #()
	for obj in myLists do
	(
		myTriTemp = #()
		for mat in pda do
		(
			if matchpattern obj pattern:mat[3] == true then append myTriTemp mat[2]
		)
		append myTri #(obj, myTriTemp[1])
	)

	
	-- Listes en cours : 

	 -- allMulti 		= tous les mutlimatériaux de la scene
	 -- allObj			= tous les objets possédant un multimatériaux
	 -- pda 			= ( NB_submats / MultiMateriau / liste des bitmaps )   -- Pour tous les multimatériaux de la scène 3D
	 -- myLists			= Listes de bitmaps uniques 
	 -- myTri 			= ( liste de bitmaps uniques / Multimatériau Unique )
	 -- allObjMultis 	= ( nombre de sousMateriaux / objet 3D / liste de bitmaps )




	allObjMultis = #()
	for obj in allObj do -- pour chaque objet qui a un multimaterial
	(
		myTempB = #()
		for i = 1 to obj.material.count do  -- pour chaque sous matériau
		(
			if classof obj.material[i].diffuseMap == BitmapTexture and filenamefrompath obj.material[i].diffuseMap.filename != "" then -- si le sous materiau a une bitmap en diffuse
			(
				append myTempB (filenamefrompath obj.material[i].diffuseMap.filename) -- ajouter les noms de bitmaps dans myTempB
			) else append myTempB (obj.material[i].diffuse as string) -- sinon ajouter "Color" dans myTempB
		)
		myTempB = myTempB as string -- Conversion de myTempB en "String"
		append allObjMultis #(obj.material.count, obj, myTempB)  -- allObjMultis = nombre de sousMateriaux / objet 3D / liste de bitmaps
	)


	-- OPERATION D'INSTANCIATION FINALE !! --

	for mat in allObjMultis do -- pour chaque tableau d'infos des objets 3D
	(
		for lst in myTri do -- pour chaque tableau d'infos des multimateriaux uniques
		(
			if mat[3] == lst[1] then mat[2].material = lst[2] 
		)
	)

	-------------------------------------------

	-- Force to update Scene Materials informations by saving an empty maxFile --

-- 	tempFile = maxFilePath + "_tempSceneMaterialsHack.max"
-- 	saveNodes #() tempFile
-- 	deleteFile tempFile

	-----------------------------------------------------------------------------

	clearListener()
	print ("myLists.count : "  + myLists.count as string)
	print (blublurf)
	blurf = getClassInstances MultiMaterial
	blurf = ("Number of Multimaterials AFTER script : " + (blurf.count as string))
)
