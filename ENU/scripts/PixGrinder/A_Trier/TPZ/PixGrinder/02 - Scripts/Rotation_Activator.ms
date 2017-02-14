-- Rotation Activator

(

	pda = #()

	for obj in objects do
	(
		if findString obj.name "rotation" != undefined do append pda obj
	)

	for i = 1 to pda.count do
	(
		if pda[i].parent == undefined do
		(
			if classof pda[i].rotation.controller != Rotation_List do 
			(
				pda[i].rotation.controller = Rotation_List()
				pda[i].rotation.controller.available.controller = Linear_Rotation()
			)
			if pda[i].rotation.controller.weight[1] == 100 then pda[i].rotation.controller.weight[1] = 0 else pda[i].rotation.controller.weight[1] = 100
		)
	)
	
)


