-- NameDupli --
(
	mySelec = #()

	for obj in selection do 
	(
		origName = obj.name
		origParent = obj.parent
		myCopy = copy obj
		myCopy.name = "CP_"+ origName
		append mySelec #(myCopy, origParent)
	)


	for obj in mySelec do
	(
		if obj[2] != undefined do 
		(
			obj[1].parent = (getNodeByName ("CP_"+ obj[2].name))
		)
	)
)
