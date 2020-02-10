 (
	 on execute do
	(
		macros.run "Medit Tools" "clear_medit_slots"
		if selection.count == 0 then mySelection = geometry else mySelection = selection
		cnt = 1
		for i in mySelection do
		(
			if i.material != undefined then
			(
				alreadyExist = false
				for j=1 to 24 do
				(
					if meditMaterials[j] == i.material then
						alreadyExist = true
				)
				
				if not alreadyExist then
				(
					meditMaterials[cnt] = i.material
					cnt = cnt + 1
				)
				
				if cnt > 24 then
					exit
			)
		)
	)
)