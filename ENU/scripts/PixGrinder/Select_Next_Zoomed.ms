---------------------------------------------------------------------

-- PixGrinder Scripts --
-- Select Next --
-- Select_Next.ms --
-- Selects next object --
-- V 8.0  --



---------------------------------------------------------------------


(
	myVisu = for obj in objects where obj.isHidden == false collect obj -- myVisu = tableau d'objets visibles
	if objects.count == 0 then messageBox("No objects in scene !!") else
	(	
		-- Total reBuild --
		---------------------------------------------------------------------------
		if selection.count == 0 then (x1 = 0) else (x1 = finditem myVisu selection[1])
		if x1 < myVisu.count then 
		(
			select myVisu[x1+1]
			if x1 != 0 then myVisu[x1].isHidden = true
		) else (select myVisu[1])
		max zoomext sel all
		---------------------------------------------------------------------------
	)
)
w
