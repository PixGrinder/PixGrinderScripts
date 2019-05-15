
(
	DisableSceneRedraw()

	-- remove hierarchies without geometry inside --

	x1 = for hlp in helpers where hlp.children.count == 0 collect hlp
	-- x1.count

	-- select x1

	myAr=#()

	fn selectUp v1 = 
	(
		if v1.parent != undefined do 
		(
			append myAr v1.parent
			selectUp v1.parent
		)
	)



	for obj in x1 do
	(
		myAr=#()
		append myAr obj
		selectUp obj
		delete myAr
	)

	EnableSceneRedraw()

)