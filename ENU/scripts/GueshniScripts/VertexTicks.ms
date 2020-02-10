(
	fn filt obj = isKindOf obj GeometryClass or isKindOf obj shape
	if selection.count != 0 do
	(
		for o in selection where filt o do o.vertexticks = not o.vertexticks
	)
)