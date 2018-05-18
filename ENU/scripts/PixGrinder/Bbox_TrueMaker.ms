
---------------------------------------------------------------------

-- PixGrinder Scripts --
-- Bbox true maker --
-- Bbox_TrueMaker.ms --
-- Creates a dummy with selection's dimensions (not scaled) --
-- V 1.0 --

---------------------------------------------------------------------

(
	if selection.count == 0 then messageBox("Select at least 1 object")
	else 
	(
		myMin = in coordsys local selection.min
		myMax = in coordsys local selection.max

		x1 = abs ( myMax.x-myMin.x )
		y1 = abs ( myMax.y-myMin.y )
		z1 = abs ( myMax.z-myMin.z )
		myDum = dummy pos:selection.center name:(selection[1].name+"_bbox") isselected:true boxsize:[x1,y1,z1]
	)
)

