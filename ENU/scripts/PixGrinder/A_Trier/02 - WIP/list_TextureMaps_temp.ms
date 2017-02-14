(
	clearListener()
	x1 = getClassInstances StandardMaterial 
	pda = #()
	for obj in x1 do
	(
		try
		(
		if matchpattern obj.diffusemap.name pattern:"*#7" == true do appendifunique pda obj.diffusemap
		) catch ()
	)
	if pda.count < 24 do
	(
		for i = 1 to pda.count do meditmaterials[i] = pda[i]
		for obj in pda do print obj as string
	) 
)



(
	clearListener()
	x1 = getClassInstances StandardMaterial 
	pda = for obj in x1 where obj.bumpMap != undefined collect obj
	if pda.count < 24 do
	(
		for i = 1 to pda.count do meditmaterials[i] = pda[i]
		for obj in pda do print obj as string
	) 
)
