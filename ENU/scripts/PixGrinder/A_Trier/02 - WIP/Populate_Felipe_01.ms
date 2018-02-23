(
	pda = #()
	
	for i = 1 to 24 do meditmaterials[i] = StandardMaterial()

	for obj in selection do
	(
		if superclassof obj == GeometryClass and obj.material != undefined do appendifunique pda obj.material
	)

	if pda.count > 24 then
	(
		for i = 1 to 24 do
		(
			meditmaterials[i] = pda[i]
		)
	) else (
		for i = 1 to pda.count do
		(
			meditmaterials[i] = pda[i]
		)
	)

)


rollout myNextMats ""
(

	

)