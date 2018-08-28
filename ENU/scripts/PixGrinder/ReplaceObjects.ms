-- Replace Objects --
-- Replace Objects.ms -- 
-- 1 - Select object to duplicate  / 2 - Ctrl+Click to select objects to replace / 3 - Run This script --


(
	mySelec = selection as array
	--myCoords = for obj in selection collect obj.pos
	for i = 2 to mySelec.count do
	(
		x1 = copy mySelec[1]
		x1.pos = mySelec[i].pos
		delete mySelec[i]
	)

)