(
	clearListener()
	pda=#()

	for obj in selection do
	(
		if distance obj.min obj.max <= 0.4 do append pda obj
	)

	select pda
)


distance $.min $.max