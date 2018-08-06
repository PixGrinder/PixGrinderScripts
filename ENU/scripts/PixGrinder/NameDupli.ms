-- NameDupli --
(
	mySelec = #()

	for obj in selection do 
	(
		origName = obj.name
		myCopy = copy obj
		myCopy.name = origName
		append mySelec myCopy
	)

	select mySelec
)