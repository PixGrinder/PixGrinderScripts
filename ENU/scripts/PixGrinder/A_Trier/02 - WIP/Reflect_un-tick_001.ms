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
	
	for i = 1 to pda.count do pda[i].reflectionMapEnable = off

