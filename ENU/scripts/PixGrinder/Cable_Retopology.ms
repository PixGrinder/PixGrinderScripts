
---------------------------------------------------------------------

-- PixGrinder Scripts --
-- Cable Retopology --
-- Creates a spline from a bad cable model automatically --
-- V 4.2 --
-- by Philippe DASSONVILLE
-- dassonphil@gmail.com

---------------------------------------------------------------------



(
	clearlistener()
	myCable = selection[1]
	selection[1].layer.current = true
	myCond = true
	myAr = #()
	myArTemp = #{}
	allFaces = #{}
	myVar = 1
	VertexLimit = 501
	

	while myCond == true do
	(
		if classof myCable != Editable_Poly and classof myCable != Editable_mesh do 
		(
			exit with (MessageBox("Need to select only 1 Poly or Mesh object !"))
			myCond = false
		)

		if subobjectlevel != 1 or ((getVertSelection myCable)as array).count < 3 do
		(
			exit with (MessageBox("Need to select cable end vertices"))
			myCond = false
		)

		-- Get Shape Radius --
		mySnap = snapshot myCable
		allVerts = (for i = 1 to (getNumVerts mySnap) collect i) as bitArray
		ToRemoveNow = allVerts - getVertSelection mySnap
		meshop.deleteVerts mySnap ToRemoveNow
		global myThick = (distance mySnap.min mySnap.max)*0.9
		print myThick
		delete mySnap

		
		select myCable
		temp1 = getVertSelection myCable
		converttopoly myCable
		
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
			select myCable
			subobjectlevel = 1
			x1 = polyop.getVertSelection myCable
			v1 = polyop.getVertSelection myCable
			myArTemp = myArTemp + x1
			myDot = getSubObjCenter myCable v1
			appendifunique myAr myDot
			subobjectlevel = 1
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
		-- myShape.render_thickness = 0.112
		myShape.render_thickness = myThick
		myShape.render_sides = 5
		myShape.render_threshold = 89
		myShape.steps = 0
		updateshape myShape
		select myCable
		subobjectlevel = 0
		myShape.pivot = myShape.center
		select myShape

		myCond = false
	)
)




