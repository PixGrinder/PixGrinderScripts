
---------------------------------------------------------------------

-- PixGrinder Scripts --
-- Spline Tools --
-- Spline Select Middle Points --
-- V 1.0 --

---------------------------------------------------------------------




(
	if classof $ == SplineShape do
	(
		max modify mode
		subobjectlevel = 1
		setKnotSelection $ 1 #(1,((numKnots $ 1) as integer))
		max select invert
	)
)
