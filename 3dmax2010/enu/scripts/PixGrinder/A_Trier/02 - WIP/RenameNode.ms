(
	for obj in geometry do 
	(
		if obj.parent != undefined do obj.name = obj.parent.name
	)
)


delete helpers
