(	
	clearListener()
	myCount = 0
 	pda = geometry as array
 	megArray = #()
	mySurfaceValue = 5000.0



	for i = 1 to pda.count do  							-- pour tous les objets
	(
		select pda[i] 									-- selectionner l'objet
		convertToPoly pda[i]							-- convertir l'objet en Poly
		myMax = polyop.getNumFaces pda[i]				-- myMax = nombre de faces de l'objet
		max modify mode
		myCount = 0
		for j = 1 to myMax do							-- Pour chaque face de l'objet :
		(
			myTemp = polyop.getFaceArea pda[i] j		-- myTemp = surface de la face actuelle
			myCount = myCount + myTemp					-- myCount = surface totale de l'objet
		)
		
		append megArray #(myCount, pda[i])				-- megArray = #(Surface, Objet)
		
	)
	
	max modify mode
	
	for obj in megArray where (obj[1] < mySurfaceValue) do 
	(
		select obj[2]
		convertToPoly selection[1]
		addModifier selection[1] (ProOptimizer())
		selection[1].modifiers[1].Calculate = true
		selection[1].modifiers[1].VertexPercent = 75.0
		convertToPoly selection[1]
	) 

	for obj in megArray where (obj[1] > mySurfaceValue) do 
	(
		select obj[2]
		convertToPoly selection[1]
		addModifier selection[1] (ProOptimizer())
		selection[1].modifiers[1].Calculate = true
		selection[1].modifiers[1].VertexPercent = 50.0
		convertToPoly selection[1]
	) 


	messageBox ("OptimizeBySurface process successful !")

)

-- for obj in megArray do print obj[1]