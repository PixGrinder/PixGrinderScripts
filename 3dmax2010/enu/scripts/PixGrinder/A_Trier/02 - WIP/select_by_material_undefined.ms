(
	pda = #()

	for obj in selection do
	(
		if obj.material != undefined do appendifunique pda obj
	)

	select pda
)