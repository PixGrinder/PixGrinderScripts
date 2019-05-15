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





-------------------------------
-------------------------------

x1 = for obj in geometry where classof obj.material != multimaterial collect obj
	
select x1


show meditmaterials[2]


classof meditmaterials[1].diffuseMap

meditmaterials[1] = pda[1]

for obj in geometry do if obj.material == meditmaterials[1] do print obj.name



	for obj in geometry do 
	(
		if classof obj.material == multimaterial do
		(
			for i = 1 to obj.material.count do 
			(
				if obj.material[i] == meditmaterials[1] do print obj.name
			)
		)
		
		if obj.material == meditmaterials[1] do print obj.name
		
	)

	
for obj in geometry do print (classof obj.material)
x1 = for obj in geometry where classof obj.material == multimaterial collect obj.material
	
for i = 1 to x1.count do
(
	for j = 1 to x1[i].count do print (classof x1[i][j])
)

	
