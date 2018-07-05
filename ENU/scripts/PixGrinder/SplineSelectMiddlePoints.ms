
---------------------------------------------------------------------

-- PixGrinder Scripts --
-- Spline Tools --
-- Spline Select Middle Points --
-- V 1.1 --

---------------------------------------------------------------------




(
	if classof selection[1] == SplineShape or classof selection[1] == line do
	(
		max modify mode
		subobjectlevel = 1
		setKnotSelection $ 1 #(1,((numKnots $ 1) as integer))
		max select invert
	)
)
