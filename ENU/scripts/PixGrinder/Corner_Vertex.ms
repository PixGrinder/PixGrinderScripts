
---------------------------------------------------------------------

-- PixGrinder Script --
-- Corner_Vertex --
-- Corner_Vertex.ms --
-- Converts selected spline vertices to Corner --
-- Allows to assign Shortcut to this basic function --
-- MaxScript adapted from SwordSlayer's code --
-- V 1.1 --

---------------------------------------------------------------------





(
	-- mapped fn setKnotTypes obj spline index type:#corner = setKnotType obj spline index type

	if Filters.Is_EditSplineSpecifyLevel #{2} do
	(
		local obj = selection[1]
		local splineCount = numSplines obj

		for spline = 1 to splineCount
			where (local selectedKnots = getKnotSelection obj spline) != #() do
				(
					for kaka in selectedKnots do setKnotType obj spline kaka #corner
				)

		updateShape obj
	)
)
