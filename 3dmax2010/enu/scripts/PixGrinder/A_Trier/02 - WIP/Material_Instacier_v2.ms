-- Materials Instancier v1

(	
	clearListener()
	
	-- Convertir tous les objets en Polygon
	for obj in objects do try (convertToPoly obj) catch (print (obj.name + " " + (classof obj as string)))
	
	sceneMats = getClassInstances StandardMaterial -- collecter tous les materiaux standards dans la scene
	print ("Startup : sceneMats.count = "+sceneMats.count as string)
	
	myGeo = for obj in objects where classof obj.material == StandardMaterial and classof obj.material.diffusemap == BitmapTexture collect obj -- Tous les objets ayant un materiau Standard
	print ("myGeo.count = "+myGeo.count as string)
	myMult = for obj in objects where classof obj.material == MultiMaterial collect obj -- Tous les objets ayant un materiau Multi/Sub
	print ("myMult.count = "+myMult.count as string)
	
	byMaps = for obj in sceneMats where classof obj.diffusemap == BitmapTexture collect obj
	print ("byMaps.count = "+byMaps.count as string)
	
	
	for i = 1 to byMaps.count do
	(
		--myTemp = byMaps[i]
-- 		for j = 1 to myGeo.count do
-- 		(
-- 				if (filenamefrompath myGeo[j].material.diffusemap.filename) == (filenamefrompath byMaps[i].diffusemap.filename) do myGeo[j].material = sceneMats[i]
-- 		)
		
		for obj in myGeo do 
		(
			try
			(
				if (filenamefrompath obj.material.diffusemap.filename) == (filenamefrompath byMaps[i].diffusemap.filename) do obj.material = sceneMats[i]
			) catch(print ((i as string) + " " + obj.name))
		)
		
-- 		for k = 1 to myMult.count do
-- 		(
-- 			for l = 1 to myMult[k].material.count do
-- 			(
-- 				if filenamefrompath myMult[k].material[l].diffusemap.filename == filenamefrompath sceneMats[i].diffusemap.filename do myMult[k].material[l] = sceneMats[i]
-- 			)
-- 		)
		
	)
	
	sceneMats = getClassInstances StandardMaterial -- collecter tous les materiaux standards dans la scene
	
	print ("End : sceneMats.count = "+sceneMats.count as string)
	
)
