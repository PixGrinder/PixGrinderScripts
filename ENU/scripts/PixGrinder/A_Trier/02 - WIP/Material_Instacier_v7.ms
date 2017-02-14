-- Materials Instancier v1

(	
	clearListener()
	
	-- Convertir tous les objets en Polygon
	for obj in objects do try (convertToPoly obj) catch (print (obj.name + " " + (classof obj as string)))
	
	sceneMats = getClassInstances StandardMaterial -- collecter tous les materiaux standards dans la scene
	print ("Startup : sceneMats.count = "+sceneMats.count as string)
	print scenematerials.count
	
	myGeo = for obj in objects where classof obj.material == StandardMaterial and classof obj.material.diffusemap == BitmapTexture collect obj -- Tous les objets ayant un materiau Standard
	print ("myGeo.count = "+myGeo.count as string)
	myMult = for obj in objects where classof obj.material == MultiMaterial collect obj -- Tous les objets ayant un materiau Multi/Sub
	print ("myMult.count = "+myMult.count as string)
	
	byMaps = for obj in sceneMats where classof obj.diffusemap == BitmapTexture collect obj
	print ("byMaps.count = "+byMaps.count as string)
	
	byColor = for obj in sceneMats where obj.diffusemap == undefined collect obj
	myGeoColor = for obj in objects where classof obj.material == StandardMaterial and obj.material.diffusemap == undefined collect obj 
	
	
	progressStart "Step 1/3 ..."
	myProg = 1
	for i = 1 to myGeo.count do
	(
		if (100*(i as float)/myGeo.count > (myProg as float)) do  --then print "youpi" else print ((obj as float)/gem.count) as string
		(
			myProg = myProg+1
			progressUpdate myProg
		)
		myTemp = myGeo[i]
		for j = 1 to byMaps.count do
		(
			if  (filenamefrompath myTemp.material.diffusemap.filename) == (filenamefrompath byMaps[j].diffusemap.filename) do 
			(
				myTemp.material = byMaps[j]
			)
		)
	)
	progressEnd()
	
	progressStart "Step 2/3..."
	myProg = 1
	for i = 1 to myGeoColor.count do
	(
		if (100*(i as float)/myGeoColor.count > (myProg as float)) do  --then print "youpi" else print ((obj as float)/gem.count) as string
		(
			myProg = myProg+1
			progressUpdate myProg
		)
		myTemp = myGeoColor[i]
		for j = 1 to byColor.count do
		(
			if  myTemp.material.diffuseColor == byColor[j].diffuseColor do 
			(
				myTemp.material = byColor[j]
			)
		)
	)
	
	progressEnd()

	(	
		clearListener()
		
		-- Convertir tous les objets en Polygon
		for obj in objects do try (convertToPoly obj) catch (print (obj.name + " " + (classof obj as string)))
		
		myMult = getClassInstances Multimaterial
		print ("myMult.count = "+myMult.count as string)
			
		myMultGeo = for obj in objects where classof obj.material == MultiMaterial collect obj -- Tous les objets ayant un materiau Multi/Sub
		print ("myMultGeo.count = "+myMultGeo.count as string)
		
		
		progressStart "Step 3/3 ..."
		myProg = 1
		for i = 1 to myMult.count do
		(

	-- 		myMulTemp = myMult[i]
			for j = 1 to myMultGeo.count do
			(
				if myMult[i].count == myMultGeo[j].material.count do
				(
					myOK = 1
					for tst = 1 to myMult[i].count  do
					(
						try
						(
							if myMult[i][tst].diffuseColor != myMultGeo[j].material[tst].diffuseColor do myOK = 0
							if (filenamefrompath myMult[i][tst].diffusemap.filename) != (filenamefrompath myMultGeo[j].material[tst].diffusemap.filename) do myOK = 0
						) catch ()
					)
					if myOk == 1 do myMultGeo[j].material = myMult[i]
					print (myMultGeo[j].material.name+" optimized")
					myOK = 1
				)
			)
			
			if (100*(i as float)/myMult.count > (myProg as float)) do
			(
				myProg = myProg+1
				progressUpdate myProg
			)
			
		)
		
		
		progressEnd()
		
	)
	
)
