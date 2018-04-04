-- Cable Retopo - Advanced --


(

	fn getSubObjCenter obj verts center:[0, 0, 0] =
	(
		for vert in verts do
			center += polyOp.getVert obj vert node:obj
		center / verts.numberSet
	)

	myCoords = #()
	-- polyOp.setVertSelection myObj #{1}
	-- thePos = polyop.getVert myObj 1
	x1 = sphere name:"tempSphere" 
	x1.radius = 0.07
	x1.segments = 8

	myMod = volumeselect()
	myMod.level = 1
	myMod.volume = 3



	myObj = selection[1]
	thePos = polyop.getVert myObj 1
	x1.pos = thePos


	addModifier myObj myMod
	myMod.node = x1
	convertToPoly myObj
	max modify mode
	select myObj
	subObjectLevel = 1
	append myCoords (getSubObjCenter myObj (polyop.getVertSelection myObj ))
	polyOp.deleteVerts myObj (polyop.getVertSelection myObj )


	delete x1


	--for obj in myCoords do format "%\r" obj
	--actionMan.executeAction 0 "40472"  -- MAX Script: MAXScript Listener
)


polyop.getNumVerts myObj