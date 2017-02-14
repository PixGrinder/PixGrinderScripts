-- Multi Materials Instancier v6

(	
	clearListener()
	
	-- Convertir tous les objets en Polygon
	for obj in objects do try (convertToPoly obj) catch (print (obj.name + " " + (classof obj as string)))
	
	myMult = getClassInstances Multimaterial
	print ("myMult.count = "+myMult.count as string)
		
	myMultGeo = for obj in objects where classof obj.material == MultiMaterial collect obj -- Tous les objets ayant un materiau Multi/Sub
	print ("myMultGeo.count = "+myMultGeo.count as string)
	
	
	progressStart "MultiMaterials Processing..."
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
