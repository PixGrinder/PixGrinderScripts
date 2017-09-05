---------------------------------------------------------------------

-- PixGrinder Scripts --
-- List Selected --
-- ListSelected.ms --
-- Outputs selected objects names in MaxScript listener --
-- Improvement to come : Output in a text file ...   --
-- V 1.2 --

---------------------------------------------------------------------



(
	clearListener()
	for obj in selection do format "%\r" obj.name
)




