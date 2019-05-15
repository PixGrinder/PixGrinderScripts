macroScript CableRetopology category:"- Gueshni -" Icon:#("g9_polyquad", 1) tooltip:"Cable Retopology"

(
	clearlistener()
	myCable = selection[1]
	maxOps.cloneNodes myCable cloneType:#copy newNodes:&nnl
	nnl = nnl[1]
	nnl.name = myCable.name+"_backup"
	nnl.isHidden = true
	myAr = #()
	myArTemp = #{}
	allFaces = #{}
	myVar = 1
	
	select myCable
	converttopoly myCable
	
-- 	myNum = 1

	fn getSubObjCenter obj verts center:[0, 0, 0] =
	(
		for vert in verts do
			center += polyOp.getVert obj vert node:obj
		center / verts.numberSet
	)
	
	subobjectlevel = 4
	global x1 = polyop.getFaceSelection myCable
	max select all
	allFaces = polyop.getFaceSelection myCable
	polyop.setFaceSelection myCable x1
	
	
	
	
	while myVar < 101 do
	(
		print myAr.count
		select myCable
		subobjectlevel = 4
		x1 = polyop.getFaceSelection myCable
		v1 = polyop.getVertsUsingFace myCable x1
		myArTemp = myArTemp + x1
		myDot = getSubObjCenter myCable v1
		appendifunique myAr myDot
		subobjectlevel = 4
		--for k = 1 to 3 do myCable.EditablePoly.GrowSelection ()
		myCable.EditablePoly.GrowSelection ()
		x2 = polyop.getFaceSelection myCable
		if (x2 as array).count == (x1 as array).count then myVar = 101 else
		(
		x2 = x2 - myArTemp
		polyop.setFaceSelection myCable x2
		x1 = polyop.getFaceSelection myCable
		myVar = myVar + 1 
		)
	)
	-- 	delete myCable
	myShape = splineShape ()
	addNewSpline myShape
	for i = 1 to myAr.count do 
	(
		addKnot myShape 1 #corner #line myAr[i]
		if i > 1 do updateshape myShape
	)
	myShape.render_renderable = true
	myShape.render_mapcoords = true
	myShape.render_displayRenderMesh = true
	myShape.render_thickness = 0.112
	myShape.render_sides = 6
	myShape.render_threshold = 89
	updateshape myShape
	select myShape
	
)