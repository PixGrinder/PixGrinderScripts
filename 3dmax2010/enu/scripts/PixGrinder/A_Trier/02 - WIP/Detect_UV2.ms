-- detect Geometry with UV2 map channel --

(
	x1 = for obj in geometry where polyop.getNumMaps obj != 2 collect obj    -- Channel 3 = UV2
	for bla in geometry do convertToPoly bla
	select x1
)


-- For command   "polyop.getNumMaps" :
-- Channel 1 = VertexColor
-- Channel 2 = UV1
-- Channel 3 = UV2
