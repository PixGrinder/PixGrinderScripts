---------------------------------------------------------------------

-- PixGrinder Scripts --
-- Select Prev --
-- Select_Prev.ms --
-- Selects previous object --
-- V 7.1  --



---------------------------------------------------------------------


(
	if objects.count == 0 then messageBox("No objects in scene !!") else
	(
		-- Total reBuild --
		---------------------------------------------------------------------------
		if selection.count == 0 then (x1 = objects.count) else (x1 = finditem (objects as array) selection[1])
		if x1 > 2  then select objects[x1-1] else select objects[objects.count]
		max zoomext sel all
		---------------------------------------------------------------------------
	)
)


