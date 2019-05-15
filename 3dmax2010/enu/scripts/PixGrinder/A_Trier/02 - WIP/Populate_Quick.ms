-- Populate Quick --
(
	if selection.count !=0 then 
	(
		myAr = #()

		for i = 1 to 24 do meditMaterials[i] = StandardMaterial()

		MatEditor.Open()

		for obj in selection do appendifunique myAr obj.material

		if myAr.count > 24 then 
		(
			for i = 1 to 24 do meditMaterials[i] = myAr[i]
		) else (
			for i = 1 to myAr.count do meditMaterials[i] = myAr[i]
		)

	) else (messageBox ("Please select objects before running this script"))

)