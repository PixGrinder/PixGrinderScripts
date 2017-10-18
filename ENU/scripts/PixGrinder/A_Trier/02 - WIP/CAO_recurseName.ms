(

	global theName = ""
	fn recurseName v1 v2=
	(
		-- theName = v1.name
		if v1.parent != undefined then 
		(
			theName = v1.parent.name + "++" + v1.name
			recurseName v1.parent v1
		) else v2.name = theName
	)


	undo off
	(
		
		DisableSceneRedraw()

		clearSelection()
		clearListener()


		for geo in geometry do recurseName geo geo

		EnableSceneRedraw ()
	)


)