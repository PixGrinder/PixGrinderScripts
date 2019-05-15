
---------------------------------------------------------------------

-- PixGrinder Scripts --
-- UV1_Detector.ms --
-- UV1_Detector --
-- Detects Objects with missing UV1 Map channel--
-- V 3.0 --

---------------------------------------------------------------------

(
	clearListener()
	x2 = for obj in geometry where (meshop.getMapSupport (snapshotAsMesh obj) 1) == false collect obj
	clearSelection()
	select x2
	if x2.count == 0 then messageBox("No objects with missing UV1")
)

