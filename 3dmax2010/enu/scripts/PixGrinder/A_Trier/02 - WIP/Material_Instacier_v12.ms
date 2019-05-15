-- Materials Instancier v10

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
	
	
	progressStart "Step 1/4 ..."
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
	
	progressStart "Step 2/4..."
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
		myMult = getClassInstances Multimaterial
		print ("myMult.count = "+myMult.count as string)
			
		myMultGeo = for obj in objects where classof obj.material == MultiMaterial collect obj -- Tous les objets ayant un materiau Multi/Sub
		print ("myMultGeo.count = "+myMultGeo.count as string)
		
		
		progressStart "Step 3/4 ..."
		myProg = 1
		for i = 1 to myMult.count do
		(
			for j = 1 to myMultGeo.count do
			(
				if myMult[i].count == myMultGeo[j].material.count do
				(
					myOK = 0
					myAr = #()
					for a = 1 to myMult[i].count do myAr[a] = 0
					for tst = 1 to myMult[i].count  do
					(
						if myMult[i][tst] != undefined and myMultGeo[j].material[tst] != undefined do
						(
							if myMult[i][tst].diffusemap !=  undefined and myMultGeo[j].material[tst].diffusemap != undefined then
							(
								if (filenamefrompath myMult[i][tst].diffusemap.filename) == (filenamefrompath myMultGeo[j].material[tst].diffusemap.filename) do myAr[tst] = 1
							) else (
								if myMult[i][tst].diffuseColor == myMultGeo[j].material[tst].diffuseColor do myAr[tst] = 1
							)
						)
					)
					print myAr
					if finditem myAr 0 != 0 then myOk = 0 else myOk = 1
					if myOk == 1 do myMultGeo[j].material = myMult[i]
					myOK = 0
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
	
	
	(
		myGeoColor = for obj in objects where classof obj.material == StandardMaterial and obj.material.diffusemap == undefined collect obj -- Tous les objets ayant un materiau Standard
		print ("myGeoColor.count = "+myGeoColor.count as string)
		
		myGeoMaps = for obj in objects where classof obj.material == StandardMaterial and classof obj.material.diffusemap == BitmapTexture collect obj -- Tous les objets ayant un materiau Standard
		print ("myGeoMaps.count = "+myGeoMaps.count as string)
		
		myMult = getClassInstances Multimaterial
		
		progressStart "Step 4/4 ..."
		myProg = 1
		
		for r = 1 to myMult.count do
		(
			
			-- Diffuse Color test pass for Multimaterials
			
			for i = 1 to myMult[r].count do
			(
				if myMult[r][i] != undefined do
				(
					if myMult[r][i].diffusemap == undefined do
					(
						for j = 1 to myGeoColor.count do
						(
							if myGeoColor[j].material.diffusecolor == myMult[r][i].diffusecolor do myMult[r][i] = myGeoColor[j].material
						)
					)
				)
				
			)
			
			-- Diffuse Map test pass for Multimaterials
			
			for i = 1 to myMult[r].count do
			(
				if myMult[r][i] != undefined do
				(
					if myMult[r][i].diffusemap == BitmapTexture do
					(
						for j = 1 to myGeoMaps.count do
						(
							if (filenamefrompath myGeoMaps[j].material.diffusemap.filename) == (filenamefrompath myMult[r][i].diffusemap.filename) do myMult[r][i] = myGeoMaps[j].material
						)
					)
				)
			)
			
			if (100*(r as float)/myMult.count> (myProg as float)) do
			(
				myProg = myProg+1
				progressUpdate myProg
			)
			
			
		)
		
		progressEnd()
		
		MessageBox ("Materials Optimization completed \r             ( Motherfucker !)")
	)
)
