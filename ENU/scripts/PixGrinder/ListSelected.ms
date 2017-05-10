---------------------------------------------------------------------

-- PixGrinder Scripts --
-- List Selected --
-- ListSelected.ms --
-- Outputs selected objects names in MaxScript listener --
-- Improvement to come : Output in a text file ...   --
-- V 1.1 --

---------------------------------------------------------------------



(
	clearListener()
	myTempAr = #()
	myTempAr = for obj in selection collect obj.name
	sort myTempAr
	for obj in myTempAr do format "%\r" obj
	-- format "% - % - %\r" obj.name obj.position obj.rotation
)
