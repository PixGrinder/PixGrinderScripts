---------------------------------------------------------------------

-- PixGrinder Scripts --
-- List Selected --
-- ListSelected.ms --
-- Outputs selected objects names in MaxScript listener --
-- added alphabetical sorting --
-- Improvement to come : Output in a text file ...   --
-- V 3.0 --

---------------------------------------------------------------------



(
	ss = stringstream ""
	selNames = for obj in selection collect obj.name
	sort selNames
	actionMan.executeAction 0 "40472"
	clearListener()
	for i = 1 to selNames.count do
	(
		if i != selNames.count then (format "%, " selNames[i] to:ss) else (format "%" selNames[i] to:ss)
	)
	seek ss 0
	format "%\r" (readline ss)
)




