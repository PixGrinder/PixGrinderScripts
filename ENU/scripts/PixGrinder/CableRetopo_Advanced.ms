-- Cable Retopo - Advanced --

-- v1.0 --

-- Just select one cable with no branches, run the script... It's done ! --


--(

	clearListener()
	fn getSubObjCenter obj verts center:[0, 0, 0] =
	(
		for vert in verts do
			center += polyOp.getVert obj vert node:obj
		center / verts.numberSet
	)

	fn mySort v1 v2 = 
	(
		if v1[1] > v2[1] then 1 else -1
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

	myWeld = Vertex_Weld()
	myWeld.threshold = 0.01



	myObj = selection[1]
	convertToPoly myObj
	myCopy = copy myObj
	myBackup = copy myObj
	addModifier myCopy myWeld
	collapseStack myCopy
	thePos = polyop.getVert myCopy 1

	max modify mode
	resetXForm myCopy
	collapseStack myCopy
	select myCopy
	subObjectLevel = 1
	polyOp.deleteVerts myCopy #{1..10}
	polyOp.setVertSelection myCopy #{1}
	myCopy.EditablePoly.GrowSelection ()
	myCopy.EditablePoly.GrowSelection ()	max select invert
	polyOp.deleteVerts myCopy (polyop.getVertSelection myCopy )
	myradius = distance myCopy.min myCopy.max
	delete myCopy
	x1.radius = myradius * 0.5
-- 	x1.radius = 0.112*0.8

	myCopy2 = copy myObj
	thePos = polyop.getVert myCopy2 1
	x1.pos = thePos
	addModifier myCopy2 myMod
	myMod.node = x1
	collapseStack myCopy2
	max modify mode
	select myCopy2
	subObjectLevel = 1
	max select invert
	polyOp.deleteVerts myCopy2 (polyop.getVertSelection myCopy2 )
	myThick = distance myCopy2.min myCopy2.max
	delete myCopy2




	while polyop.getNumVerts myObj > 0 do	
	(
		thePos = polyop.getVert myObj 1
		x1.pos = thePos


		addModifier myObj myMod
		myMod.node = x1
		collapseStack myObj
		append myCoords (getSubObjCenter myObj (polyop.getVertSelection myObj ))
		polyOp.deleteVerts myObj (polyop.getVertSelection myObj )
	)


	delete x1

	qsort myCoords mySort

	sortedAr = #(myCoords[1])
	deleteItem myCoords 1

	for i = 1 to (myCoords.count-1) do
	(
		theDist = for val in myCoords collect #((distance sortedAr[i] val),val)
		qsort theDist mySort
		-- for txt in theDist do format "%\r" txt
		append sortedAr theDist[1][2]
		tempVal = findItem myCoords theDist[1][2]
		deleteItem myCoords tempVal
	)


	for obj in sortedAr do format "%\r" obj


	myShape = splineShape ()
	addNewSpline myShape
	for i = 1 to sortedAr.count do 
	(
		addKnot myShape 1 #corner #line sortedAr[i]
		if i > 1 do updateshape myShape
	)

	myShape.render_renderable = true
	myShape.render_mapcoords = true
	myShape.render_displayRenderMesh = true
	myShape.render_thickness = myThick*0.5
	myShape.render_sides = 3
	myShape.render_threshold = 120
	myShape.steps = 0

	delete myObj
	select myShape


	--updateshape myShape

	--for obj in myCoords do format "%\r" obj
	--actionMan.executeAction 0 "40472"  -- MAX Script: MAXScript Listener
--)


--polyop.getNumVerts myObj
-- select myObj

-- Sort my Coords -- 



