-- Pivot from faces -- 

(

	polyop.detachFaces selection[1] (polyop.getFaceSelection selection[1]) delete:false asNode:true name:"TEMTEMP"

	selection[1].pivot = (getNodeByName "TEMTEMP").center

	delete (getNodeByName "TEMTEMP")

	subobjectlevel = 0
	
	max rotate
	toolMode.pivotCenter()
	max scale
	toolMode.pivotCenter()
	max move
	toolMode.pivotCenter()
	max rotate

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