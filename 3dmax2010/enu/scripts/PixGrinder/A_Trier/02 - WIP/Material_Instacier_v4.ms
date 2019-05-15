-- Materials Instancier v1

(	
	clearListener()
	
	-- Convertir tous les objets en Polygon
	for obj in objects do try (convertToPoly obj) catch (print (obj.name + " " + (classof obj as string)))
	
	sceneMats = getClassInstances StandardMaterial -- collecter tous les materiaux standards dans la scene
	print ("Startup : sceneMats.count = "+sceneMats.count as string)
	scenematerials.count
	
	myGeo = for obj in objects where classof obj.material == StandardMaterial and classof obj.material.diffusemap == BitmapTexture collect obj -- Tous les objets ayant un materiau Standard
	print ("myGeo.count = "+myGeo.count as string)
	myMult = for obj in objects where classof obj.material == MultiMaterial collect obj -- Tous les objets ayant un materiau Multi/Sub
	print ("myMult.count = "+myMult.count as string)
	
	byMaps = for obj in sceneMats where classof obj.diffusemap == BitmapTexture collect obj
	print ("byMaps.count = "+byMaps.count as string)
	
	byColor = for obj in sceneMats where obj.diffusemap == undefined collect obj
	myGeoColor = for obj in objects where classof obj.material == StandardMaterial and obj.material.diffusemap == undefined collect obj 
	
	
	for i = 1 to myGeo.count do
	(
		myTemp = myGeo[i]
		for j = 1 to byMaps.count do
		(
			if  (filenamefrompath myTemp.material.diffusemap.filename) == (filenamefrompath byMaps[j].diffusemap.filename) do 
			(
				myTemp.material = byMaps[j]
			)
		)
	)
	
	for i = 1 to myGeoColor.count do
	(
		myTemp = myGeoColor[i]
		for j = 1 to byColor.count do
		(
			if  myTemp.material.diffuseColor == byColor[j].diffuseColor do 
			(
				myTemp.material = byColor[j]
			)
		)
	)

	sceneMats = getClassInstances StandardMaterial -- collecter tous les materiaux standards dans la scene
	print ("End : sceneMats.count = "+sceneMats.count as string)
	scenematerials.count
	
)
