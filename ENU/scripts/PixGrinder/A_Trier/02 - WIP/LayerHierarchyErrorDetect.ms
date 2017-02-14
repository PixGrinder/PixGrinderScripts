-- Layer Hierarchy Error Detect --


(
	pda = #()
	for k = 1 to (layermanager.count-1) do
	(
		lx = layermanager.getLayer k
		max select none
		lx.select on
		for obj in selection do
		(
			if obj.parent != undefined do if obj.parent.layer != lx do append pda obj.parent
		)
	)

	select pda
	
)