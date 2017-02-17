-- MaterialOps - MultiMaterials Instancier -- 




(

	clearListener()

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
	print ("Number of objects with Multimaterials : " + allObj.count as string)
	clearSelection()
	select allObj


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
			) else append myTempA "Color"
		)
		myTempA = myTempA as string
		append pda #(obj.count,obj,myTempA)
		-- myTempA = #()
	)


	clearListener()

	qsort pda sortMatList


	-- pda = stockage de tous les MultiMateriaux : (nb submats - MultiMateriau - liste des bitmaps)



	-- Stockage des listes de bitmaps      -- myLists = liste des listes de bitmaps uniques
	-----------------------------------
	myLists = #()
	for obj in pda do appendIfUnique myLists obj[3]

	qsort myLists stringCompare

	-- 	for obj in myLists do print (obj.count as string +"     "+ obj)
	-- 	for obj in myLists do print ((obj as string).count as string + " : "+obj)

	-- classof myLists[3]




	
	-- faire des listes de bitmaps pour chaque objet de la scene qui a un multimateriaux  -- myObjBmList = (nb submateriaux / objet / liste des bitmaps)
	-------------------------------------------------------------------------------------
	myObjBmList = #()
	for obj in allObj do
	(
		objTemp = #()
		for i = 1 to obj.material.count do
		(
				if classof obj.material[i].diffuseMap == BitmapTexture and filenamefrompath obj.material[i].diffuseMap.filename != "" then
				(
					append objTemp (filenamefrompath obj.material[i].diffuseMap.filename)
				) else append objTemp "Color"
		)

		objTemp = objTemp as string
		append myObjBmList #(obj.material.count,obj,objTemp)
	)



	clearListener()

	qsort myObjBmList sortMatList



	-- 	for obj in myObjBmList do print obj




	for w = 1 to myLists.count do
	(
		tempVar = for obj in pda where obj[3] == myLists[w] collect obj[2] -- myTemp = tous les matériaux qui ont la texture pda[k]

		print (tempVar[1] as string)
		-- youpla = tempVar[1]

		for obj in myObjBmList where obj[3] == myLists[w] do obj[2].material = tempVar[1]

	)

	
	allMulti = getClassInstances MultiMaterial
	print blublurf
	Print ("Number of Multimaterials AFTER script : " + allMulti.count as string)
)



-- myLists = liste des listes de bitmaps uniques

-- pda = stockage de tous les MultiMateriaux : (nb submats - MultiMateriau - liste des bitmaps)

-- myObjBmList = (nb submateriaux / objet / liste des bitmaps) 


-- myTemp = tous les matériaux qui ont la texture pda[k]



classof myObjBmList[10][3]


classof myLists[10]