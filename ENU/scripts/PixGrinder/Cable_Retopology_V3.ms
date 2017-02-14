
--------------------------------------------------
-- Cable Retopology --
-- V3
-- by Philippe DASSONVILLE
-- dassonphil@gmail.com
--------------------------------------------------

(
	clearlistener()
	myCable = selection[1]
-- 	maxOps.cloneNodes myCable cloneType:#copy newNodes:&nnl
-- 	nnl = nnl[1]
-- 	nnl.name = myCable.name+"_backup"
-- 	nnl.isHidden = true
	myAr = #()
	myArTemp = #{}
	allFaces = #{}
	myVar = 1
	VertexLimit = 501
	
	select myCable
	converttopoly myCable
	
-- 	myNum = 1

	fn getSubObjCenter obj verts center:[0, 0, 0] =
	(
		for vert in verts do
			center += polyOp.getVert obj vert node:obj
		center / verts.numberSet
	)
	
	subobjectlevel = 1
	global x1 = polyop.getVertSelection myCable
	max select all
	allFaces = polyop.getVertSelection myCable
	polyop.setVertSelection myCable x1
	
	
	
	
	while myVar != VertexLimit do
	(
		--print myAr.count
		select myCable
		subobjectlevel = 1
		x1 = polyop.getVertSelection myCable
		v1 = polyop.getVertSelection myCable
		myArTemp = myArTemp + x1
		myDot = getSubObjCenter myCable v1
		appendifunique myAr myDot
		subobjectlevel = 1
		--for k = 1 to 3 do myCable.EditablePoly.GrowSelection ()
		myCable.EditablePoly.GrowSelection ()
		x2 = polyop.getVertSelection myCable
		if (x2 as array).count == (x1 as array).count then myVar = VertexLimit else
		(
		x2 = x2 - myArTemp
		polyop.setVertSelection myCable x2
		x1 = polyop.getVertSelection myCable
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
	myShape.render_sides = 5
	myShape.render_threshold = 89
	myShape.steps = 0
	updateshape myShape
	select myCable
	subobjectlevel = 0
	myShape.pivot = myShape.center
	select myShape	
)




