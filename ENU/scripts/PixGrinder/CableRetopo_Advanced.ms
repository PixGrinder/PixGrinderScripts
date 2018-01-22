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
	x1 = sphere name:"tempSphere" 
	x1.radius = 0.07
	x1.segments = 8

	myMod = volumeselect()
	myMod.level = 1
	myMod.volume = 3

	myWeld = Vertex_Weld()
	myWeld.threshold = 0.001


	myObj = selection[1]
	myBak = copy myObj
	convertToPoly myObj
	addModifier myObj myWeld
	resetXForm myObj
	collapseStack myObj
	thePos = polyop.getVert myObj 1

	-- define the sphere radius using shape section --
	select myObj
	max hide inv
	theSection = section length:10.0 width:10.0 pos:myObj.center isSelected:on
	max views redraw
	theSpline = convertToSplineShape theSection
	select theSpline
	theSpline.render_renderable = false
	theSpline.render_displayRenderMesh = false
	theSpline.render_mapcoords = false
	x1.isHidden = false
	theSpline.isHidden = false
	select theSpline
	max zoomext sel 
	max modify mode
	for i = 1 to (numSplines theSpline) do 
	(
		tempAr = for j = 1 to numKnots theSpline i collect j
		setKnotSelection theSpline i tempAr keep:true 
	)
	--subObjectLevel = 1
	weldSpline theSpline 0.001
	updateshape theSpline
	max views redraw
	-- subObjectLevel = 3

	knotCo = #()
	for i = 1 to numKnots theSpline 1 do append knotCo (getKnotPoint theSpline 1 i)

	refShape = splineShape ()
	addNewSpline refShape
	for i = 1 to knotCo.count do 
	(
		addKnot refShape 1 #corner #line knotCo[i]
		if i > 1 do updateshape refShape
	)
	max views redraw
	delete theSpline
	select refShape
	refShape.pivot = refShape.center
	max zoomext sel


--


	--myRadius = (distance theSpline.min theSpline.max)*1.5
	x1.radius = (distance refShape.min refShape.max)*1.2
	-- forceCompleteRedraw()
	myThick = (distance refShape.min refShape.max)

	delete refShape
	
	-- /define the sphere radius using shape section --

	thePos = polyop.getVert myObj 1
	x1.pos = thePos
	-- x1.radius = myRadius
	x1.isHidden = false
	select x1
	max zoomext sel

	while polyop.getNumVerts myObj > 0 do	
	(
		thePos = polyop.getVert myObj 1
		x1.pos = thePos
		addModifier myObj myMod
		myMod.node = x1
		collapseStack myObj
		append myCoords (getSubObjCenter myObj (polyop.getVertSelection myObj ))
		polyOp.deleteVerts myObj (polyop.getVertSelection myObj)
		polyop.deleteIsoVerts myObj
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
	myShape.render_thickness = myThick
	myShape.render_sides = 3
	myShape.render_threshold = 120
	myShape.steps = 0

	delete myObj
	myBak.isHidden = false
	select myBak
	-- select myShape


	--updateshape myShape

	--for obj in myCoords do format "%\r" obj
	--actionMan.executeAction 0 "40472"  -- MAX Script: MAXScript Listener
--)


--polyop.getNumVerts myObj
-- select myObj

-- Sort my Coords -- 



