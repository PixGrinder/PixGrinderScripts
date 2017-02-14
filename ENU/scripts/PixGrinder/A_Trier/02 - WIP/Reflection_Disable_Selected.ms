

for pda_obj in selection do (
	if (classOf pda_obj.material == standard ) then (
			pda_obj.material.reflectionMapEnable = off
	)
)

for pda_obj in selection do (
		if (classOf pda_obj.material== MultiMaterial ) do (
			for pda_j = 1 to pda_obj.material.numsubs do (
				pda_obj.material[pda_j].reflectionMapEnable = off
			)
		)
	)
)


