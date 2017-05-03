
---------------------------------------------------------------------

-- PixGrinder Scripts --
-- UV1_Detector.ms --
-- UV1_Detector --
-- Detects Objects with missing UV1 Map channel--
-- V 2.0 --

---------------------------------------------------------------------

(
	clearListener()
	for bla in geometry where superclassof bla == GeometryClass do convertToPoly bla
	x1 = for obj in geometry where classof obj == Editable_Poly collect obj
	x2 = for obj in x1 where (polyop.getMapSupport obj 1) == false collect obj
	clearSelection()
	select x2
	if x2.count == 0 then messageBox("No objects with missing UV1")
)

