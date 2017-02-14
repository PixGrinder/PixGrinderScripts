
pda01 = selection as array

for i = 1 to pda01.count do (
	if classOf pda01[i].material == Standard do (
		for obj in geometry do (
			if classOf obj.material == standard and obj.material.diffuseColor == pda01[i].material.diffuseColor do (
				obj.material = pda01[i].material
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

