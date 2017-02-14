-- MaterialRemove
(
	(
		for obj in selection do obj.material = undefined
		redrawViews()
	)
)
