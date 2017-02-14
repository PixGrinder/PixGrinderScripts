-- Script : "rename_multimat_to_bitmap.ms"
-- From : Philippe DASSONVILLE
-- contact : dassonphil@gmail.com



(
	clearListener()
	allMult = #()
	myString = ""

	allMult = getclassinstances multimaterial 
	for i = 1 to allMult.count do
	(
		for j = 1 to allMult[i].count do
		(
			try 
			(
				myString = filenamefrompath allMult[i][j].diffusemap.bitmap.filename
				myString = replace myString (myString.count-3) 4 "" 
				myString = substring myString 1 9
				allMult[i][j].name = myString
				allMult[i][j].diffusemap.name = myString + "_map"
				myString = ""
			) catch ( print myString)
		)
	)
	clearListener()
)

