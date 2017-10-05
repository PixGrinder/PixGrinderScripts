---------------------------------------------------------------------

-- PixGrinder Scripts --
-- List Selected --
-- ListSelected.ms --
-- Outputs selected objects names in MaxScript listener --
-- added alphabetical sorting --
-- Improvement to come : Output in a text file ...   --
-- V 2.0 --

---------------------------------------------------------------------



(
	selNames = for obj in selection collect obj.name
	sort selNames
	actionMan.executeAction 0 "40472"
	clearListener()
	for obj in selNames do format "%\r" obj
)




