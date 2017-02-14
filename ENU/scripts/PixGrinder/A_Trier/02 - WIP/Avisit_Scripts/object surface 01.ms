


(
	global pda = #()
	global pdax = 0

	for obj in geometry do
	(
		if classof obj == PolyMeshObject do
		(
			pdax = 0
			for i = 1 to obj.numfaces do
			(
				pdax += polyop.getFaceArea obj i
			)
			print (obj.name+";"+(pdax) as string)
		)
	)
)


