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
		myTemp = byMaps[i]
		for j = 1 to myGeo.count do
		(
				if filenamefrompath myGeo[j].material.diffusemap.filename == filenamefrompath myTemp.diffusemap.filename do myGeo[j].material = sceneMats[i]
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
	
	

	
	
	

-----------------------------------------------------------


(

	clearListener()
	myTemp = #()
	Std = getClassInstances StandardMaterial 
	StdGem = for obj in geometry where (classof obj.material == StandardMaterial) collect obj


	for i = 1 to Std.count do
	(
		for j = 1 to StdGem.count do
		(
			if StdGem[j].material.name == Std[i].name do appendifUnique myTemp StdGem[j]
		)
		for obj in myTemp do obj.material = Std[i]
	)

)


---



-- diffuse color to white
(
	clearListener()
	x1 = getClassInstances StandardMaterial
	x2 = for obj in x1 where obj.diffusemap != undefined collect obj
	for i = 1 to x2.count do 
	(
		if classof x2[i].diffusemap == Bitmaptexture do x2[i].diffuseColor = (color 255 255 255)
	)
	
)
