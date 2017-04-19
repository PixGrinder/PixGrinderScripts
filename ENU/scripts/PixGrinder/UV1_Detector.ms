
---------------------------------------------------------------------

-- PixGrinder Scripts --
-- UV1_Detector.ms --
-- UV1_Detector --
-- Detects Objects with missing UV1 Map channel--
-- V 1.0 --

---------------------------------------------------------------------

(
	clearListener()
	for bla in geometry where classof bla != Editable_Poly do convertToPoly bla
	x1 = for obj in geometry where (polyop.getMapSupport obj 1) == false collect obj   
	clearSelection()
	select x1
	if x1.count == 0 then messageBox("No objects with missing UV1")
)

