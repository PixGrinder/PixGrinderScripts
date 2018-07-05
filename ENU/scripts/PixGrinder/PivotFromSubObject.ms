-- Pivot from faces -- 

(


	myCond = true


	if myCond == true then 

	(
		max modify mode

		myTempMesh = snapshotAsMesh selection[1]

		fn averageSelVertPosition obj =
		(
		    verts = obj.selectedVerts
		    --verts = meshop.getVertSelection obj
		    p = Point3 0 0 0
		    for v in verts do
		    (
		        p += v.pos
		    )
		    p = p/verts.count
		    return p
		)


		if subObjectLevel == 4 or subObjectLevel == 5 then 
		(
			
			setVertSelection myTempMesh (meshop.getVertsUsingFace myTempMesh (getFaceSelection myTempMesh))
			selection[1].pivot = averageSelVertPosition myTempMesh
		) 


		if subObjectLevel == 1 then selection[1].pivot = averageSelVertPosition myTempMesh

		if subObjectLevel == 2 or subObjectLevel == 3 then 
		(
			setVertSelection myTempMesh (meshop.getVertsUsingEdge myTempMesh (getEdgeSelection myTempMesh))
			selection[1].pivot = averageSelVertPosition myTempMesh
		)

		delete myTempMesh

		subobjectlevel = 0
		
		max rotate
		toolMode.pivotCenter()
		max scale
		toolMode.pivotCenter()
		max move
		toolMode.pivotCenter()
		max rotate

		x1 = getRefCoordSys()

		getCoordCenter()

		toolMode.coordsys #local
	)


)

	/*
	
		
		polyop.setVertSelection selection[1] (polyop.getVertsUsingEdge selection[1] (polyop.getEdgeSelection selection[1]))
		subObjectLevel = 1

meshop.getFaceSelection myTempMesh

	*/




	/*
	
	Uniform Scale or Non-Uniform Scale !!
	---------------------------------------

	toolmode.commandmode -- get active command mode ( move, rotate, etc )
	toolMode.nonUniformScale()
	toolMode.UniformScale()



	*/

	-- updateToolbarButtons()
	-- actionMan.executeAction 0 "40472"  -- MAX Script: MAXScript Listener









------- HELP -------------

-- polyop.getFaceSelection $


/*
polyop.detachFaces <Poly poly> <facelist> delete:<boolean=true> asNode:<boolean=false> name:<string="Object01"> node:<node=unsupplied>


Detaches the specified faces. 
If <delete> is true, the faces are deleted after being detached. 
If <delete> is false, the faces are not deleted. 
If <asNode> is true, the faces are detached as a separate node. 
If <asNode> is false, the faces are detached as an element in the poly. 
If <asNode> is true, <name> specifies the name of the new node. 
If <asNode> is true and <poly> is an Editable Poly (not a node), <node> must be specified. 
Returns true if the operation was successful.


*/


-------------------------------