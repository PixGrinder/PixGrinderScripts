	global pda = #()
	global pdaname = #()

	fn scenemat =
	(
		for obj in objects do
		(
			if obj.material != undefined do 
			(
				if classof obj.material == standardmaterial do appendifunique pda obj.material
				
				if classof obj.material == multimaterial do 
				(
					for i = 1 to obj.material.count do
					(
						if classof obj.material[i] == standardmaterial do appendifunique pda obj.material[i]
					)
				)
			)
		)
	)

	scenemat()


for i = 1 to pda.count do
(
	if pda[i].opacityMap != undefined do
	(
		pdax = pda[i].opacitymap.bitmap as string
		if findstring pdax ".jpg" != undefined do
		(
			pda[i].opacitymap.monoOutput = 0
		)
	)
)








-------------------------------------------------------


for i = 1 to scenematerials.count do 
(
	if classof scenematerials[i] == standardmaterial do 
	(
		if scenematerials[i].opacitymap != undefined and findstring scenematerials[i].opacitymap.bitmap as string "jpg" != undefined do
		(
			scenematerials[i].opacitymap.monoOutput = 0
		)
	)
	
	if classof scenematerials[i] == multimaterial do 
	(
		for j=1 to scenematerials[i].count do 
		(
			if classof scenematerials[i][j] == standardmaterial do 
			(
				if scenematerials[i][j].opacitymap != undefined and findstring scenematerials[i][j].opacitymap.bitmap "jpg" != undefined do
				(
					scenematerials[i][j].opacitymap.monoOutput = 0
				)
			)
		)
	)
)
