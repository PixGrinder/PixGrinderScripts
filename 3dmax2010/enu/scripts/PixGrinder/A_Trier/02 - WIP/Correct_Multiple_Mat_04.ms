
pda01 = selection as array
pda02 = pda01

for i = 1 to pda01.count do (
	if classOf pda01[i].material == Standard do (
		for j = 1 to pda02.count do (
			if classOf pda02[j].material == Multimaterial do (
				for k = 1 to pda02[j].material.count do (
					if pda01[i].material.diffusecolor == pda02[j].material[k].diffusecolor do (
						pda02[j].material[k] = pda01[i].material
					)
				)
			)
		)
				for j = 1 to pda02.count do (
					if classOf pda02[j].material == Standard do (
						if pda01[i].material.diffusecolor == pda02[j].material.diffusecolor do (
							pda02[j].material = pda01[i].material
						)
					)
				)
	)
)




for obj in selection do (
	if classOf obj.material == multimaterial do (
		for i = 1 to obj.material.numsubs do (
			if obj.material[i].diffusecolor == (color 150 150 150) do obj.material[i]=meditmaterials[1]
		)
	)
	if classOf obj.material == Standard and obj.material.diffusecolor == (color 150 150 150) do obj.material=meditmaterials[1]

)

max select none

$.material.diffusecolor = ($.material.diffusecolor - 20)