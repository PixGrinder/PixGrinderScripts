(

	global pda = #()
	global pdaname = #()

	fn scenemat =
	(
		for obj in objects do
		(
			if obj.material != undefined do 
			(
				if classof obj.material == VRayMtl do appendifunique pda obj.material
				
				if classof obj.material == multimaterial do 
				(
					for i = 1 to obj.material.count do
					(
						if classof obj.material[i] == VRayMtl do appendifunique pda obj.material[i]
					)
				)
			)
		)
	)

	scenemat()
	
	for i = 1 to pda.count do
	(
		pda[i].option_traceReflection = on
		pda[i].option_traceRefraction = off
		pda[i].reflection_lockGlossiness = on
	)
	
)

	