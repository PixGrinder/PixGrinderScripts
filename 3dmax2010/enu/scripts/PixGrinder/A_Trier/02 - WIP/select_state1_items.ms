(
	pda_ar=#()
	
	for obj in objects do
	(
		if findstring obj.name "*1" != undefined do append pda_ar obj
	)

	select pda_ar
	
)
