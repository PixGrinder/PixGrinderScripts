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
	print ("Number of Multimaterials : " + allMulti.count as string)

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
-- 	for obj in pda do print (obj as string)

	-- Stockage des listes de bitmaps 
	-----------------------------------
	myLists = #()
	for obj in pda do appendIfUnique myLists obj[3]

	qsort myLists stringCompare

	for obj in myLists do print (obj.count as string +"     "+ obj)



	for w = 1 to myLists.count do
	(
		tempVar = for obj in allObj where (filenamefrompath obj.diffusemap.filename) == pda[k] collect obj -- myTemp = tous les matériaux qui ont la texture pda[k]
	)


)



pda[30][3]