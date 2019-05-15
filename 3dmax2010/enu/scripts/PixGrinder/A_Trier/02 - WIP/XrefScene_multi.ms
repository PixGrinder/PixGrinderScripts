-- mass xref scene !!
(
	resetMaxFile() #noPrompt
	myPath = "D:\10 - Helicopters\AS365VMT\AH_AS365_3Dfiles\MAX\v3"+"\\"
	files = getfiles (myPath+"*.max")
	for obj in files do xrefs.addNewXRefFile obj
)