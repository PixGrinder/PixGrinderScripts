---------------------------------------------------------------------

-- PixGrinder Scripts --
-- Select Next --
-- Select_Next.ms --
-- Selects next object --
-- V 7.1  --



---------------------------------------------------------------------


(
	if objects.count == 0 then messageBox("No objects in scene !!") else
	(	
		-- Total reBuild --
		---------------------------------------------------------------------------
		if selection.count == 0 then (x1 = 1) else (x1 = finditem (objects as array) selection[1])
		if x1 < objects.count then select objects[x1+1] else select objects[1]
		---------------------------------------------------------------------------
	)
)


