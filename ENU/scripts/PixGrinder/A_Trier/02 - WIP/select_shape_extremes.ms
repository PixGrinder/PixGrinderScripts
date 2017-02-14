(
	if classof $ == SplineShape do
	(
		max modify mode
		subobjectlevel = 1
		setKnotSelection $ 1 #(1,((numKnots $ 1) as integer))
		max select invert
	)
)