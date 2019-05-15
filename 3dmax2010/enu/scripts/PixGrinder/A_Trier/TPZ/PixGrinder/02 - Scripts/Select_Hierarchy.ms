(

	if $ == undefined then messagebox("Please, select one object.") else
	(
	
		while $.parent != undefined do select $.parent

		for p in selection do
		(
			if p.children != undefined do
			(
				selectmore p.children
			)
		)
	)
)
