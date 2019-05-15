-- MeditSelected -- 
(
	theMats = #()
	for obj in selection where obj.material != undefined do appendifunique theMats obj.material

	if theMats.count < 24 then 
	(
		for i = 1 to theMats.count do meditMaterials[i] = theMats[i]
	) else (
		for i = 1 to 24 do meditMaterials[i] = theMats[i]
	)

)