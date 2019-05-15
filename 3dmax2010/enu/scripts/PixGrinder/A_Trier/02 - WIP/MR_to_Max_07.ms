(
	global pda = getclassInstances Arch___Design__mi

	--   i=1

	pda_backup = meditmaterials[1]

	-------------------------

	for i = 1 to pda.count do 
	(
		meditmaterials[1] = StandardMaterial()
		meditmaterials[1].name = pda[i].name
		if classof pda[i].diff_color_map == Ambient_Reflective_Occlusion__3dsmax then 
		(
			meditmaterials[1].diffuseMap = pda[i].diff_color_map.bright_shader
			meditmaterials[1].diffuse = pda[i].diff_color_map.bright
		) else (
			meditmaterials[1].diffuseMap = pda[i].diff_color_map
			meditmaterials[1].diffuse = pda[i].diff_color
		)
		meditmaterials[1].bumpMap = pda[i].bump_map
		meditMaterials[1].showInViewport=true
		for obj in geometry do if obj.material == pda[i] do obj.material = meditMaterials[1]
			
		for obj in geometry do 
		(
			if classof obj.material == Multimaterial do 
			(
				for j = 1 to obj.material.count do
				(
					if obj.material[j] == pda[i] do 
					(
						meditmaterials[1] = StandardMaterial()
						meditmaterials[1].name = pda[i].name
						if classof pda[i].diff_color_map == Ambient_Reflective_Occlusion__3dsmax then 
						(
							meditmaterials[1].diffuseMap = pda[i].diff_color_map.bright_shader
							meditmaterials[1].diffuse = pda[i].diff_color_map.bright
						) else (
							meditmaterials[1].diffuseMap = pda[i].diff_color_map
							meditmaterials[1].diffuse = pda[i].diff_color
						)
						meditmaterials[1].bumpMap = pda[i].bump_map
						obj.material[j] = meditmaterials[1]
						meditMaterials[1].showInViewport=true
					)
				)
			)
		)
	)
	
	meditmaterials[1] = pda_backup
	
)



