-- Pivot from faces -- 

(

	max modify mode

	fn averageSelVertPosition obj =
	(
	    verts = obj.selectedVerts
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

		polyop.detachFaces selection[1] (polyop.getFaceSelection selection[1]) delete:false asNode:true name:"TEMTEMP"

		selection[1].pivot = (getNodeByName "TEMTEMP").center

		delete (getNodeByName "TEMTEMP")

	) 


	if subObjectLevel == 1 then selection[1].pivot = averageSelVertPosition selection[1]

	if subObjectLevel == 2 or subObjectLevel == 3 then 
	(
		polyop.setVertSelection selection[1] (polyop.getVertsUsingEdge selection[1] (polyop.getEdgeSelection selection[1]))
		selection[1].pivot = averageSelVertPosition selection[1]
	)

	

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


	/*
	
		
		polyop.setVertSelection selection[1] (polyop.getVertsUsingEdge selection[1] (polyop.getEdgeSelection selection[1]))
		subObjectLevel = 1



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

)







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