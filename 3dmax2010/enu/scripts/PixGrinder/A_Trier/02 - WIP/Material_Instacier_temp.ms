	(
-- 		clearListener()
		
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
	
	