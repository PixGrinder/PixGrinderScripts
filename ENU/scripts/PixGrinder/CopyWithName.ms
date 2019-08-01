-- Copy with Name -- 
-- dassonphil@gmail.com --
-- v1.1 -- 



(
	mySelec = #()
	myPrefix=""
	selection[1].layer.current = true


	for obj in selection do 
	(
		origName = obj.name
		origParent = obj.parent
		myCopy = copy obj
		myCopy.name = myPrefix + origName
		append mySelec #(myCopy, origParent)
	)


	for obj in mySelec do
	(
		if obj[2] != undefined do 
		(
			obj[1].parent = (getNodeByName (myPrefix+ obj[2].name))
		)
	)
)


