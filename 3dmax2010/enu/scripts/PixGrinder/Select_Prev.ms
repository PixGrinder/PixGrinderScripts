---------------------------------------------------------------------

-- PixGrinder Scripts --
-- Select Prev --
-- Select_Prev.ms --
-- Selects previous object --
-- V 8.0  --



---------------------------------------------------------------------


(
	myVisu = for obj in objects where obj.isHidden == false collect obj
	if objects.count == 0 then messageBox("No objects in scene !!") else
	(	
		-- Total reBuild --
		---------------------------------------------------------------------------
		if selection.count == 0 then (x1 = 0) else (x1 = finditem myVisu selection[1])
		if x1 > 2 then select myVisu[x1-1] else select myVisu[myVisu.count]
		---------------------------------------------------------------------------
	)
)

