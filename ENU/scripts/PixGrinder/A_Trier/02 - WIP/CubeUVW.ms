(
	clearListener()

	for obj in selection do
	(
		myMod = UVWmap()
		myMod.mapType = 4
		addModifier obj myMod
		objTM = obj.transform
		convertToPoly obj
	)
)





