(
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
)


-- Brouillon --


meditmaterials[1][1].diffusemap.name

allMult = getclassinstances multimaterial 
i = 1
j = 2
allMult[i][j].bitmap.filename

j = 3 
meditmaterials[1] = allMult[i][j]
myString = filenamefrompath meditmaterials[1].diffusemap.bitmap.filename
myString = replace myString (myString.count-3) 4 "" 
myString = myString + "_mat"