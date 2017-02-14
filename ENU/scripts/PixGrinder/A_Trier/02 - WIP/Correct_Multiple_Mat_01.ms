

for obj in selection do (
	if classOf obj.material == multimaterial do (
		for i = 1 to obj.material.numsubs do (
			if obj.material[i].diffusecolor == (color 150 150 150) do obj.material[i]=meditmaterials[1]
		)
	)
	if classOf obj.material == Standard and obj.material.diffusecolor == (color 150 150 150) do obj.material=meditmaterials[1]

)

max select none

