-- Replace Objects --
-- Replace Objects.ms -- 
-- 1 - Select objects to replace  / 2 - Alt+Click to select the replacer object / 3 - Run This script --


(
	mySelec = selection as array
	--myCoords = for obj in selection collect obj.pos
	theReplacer = mySelec[mySelec.count]
	for i = 1 to (mySelec.count-1) do
	(
		x1 = instance theReplacer
		x1.name = x1.name+"_0"+(i as string)

-- 		x1 = copy theReplacer
		x1.center = mySelec[i].center
		delete mySelec[i]
	)

)