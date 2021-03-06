macroScript HideLongestEdges
	category:"Sergo Pogosyan"
	toolTip:"Selects and hide longest edges of the selected faces"
	buttonText:"Hide Longest Edges"
	Icon:#("sergoIcons",11)
(	
	on isEnabled return
	(
		if selection.count == 1 and classof selection[1] == Editable_mesh and selection[1].modifiers.count == 0 then true else false
	)
	
	on execute do
	(
		--try simply to select longest edge in face
		--pseudocode:
	/*
		get face selection			= getFaceSelection <node> [ <modifier_or_index> ] [ name:<name> ]
		for each face get edges		= meshop.getEdgesUsingFace <Mesh mesh> <facelist>
		and find longest of them
		add to selection array if longest is NOT open or already hidden = getEdgeVis, 
		select edges or hide them	= setEdgeVis, meshop.getOpenEdges <Mesh mesh>
	*/

	theObj = selection[1]
	faceSel = getFaceSelection theObj
	faceSel = faceSel as array
	edgesArr = #()
	for theFace in faceSel do
		(
		edgesFromFace = (meshop.getEdgesUsingFace theObj theFace) as array
		vertsFromEdges = (meshop.getVertsUsingEdge theObj edgesFromFace[1]) as array
		in coordsys world vert1 = meshOp.getVert theObj vertsFromEdges[1]
		in coordsys world vert2 = meshOp.getVert theObj vertsFromEdges[2]
		edge1 = length (vert2 - vert1)
		vertsFromEdges = (meshop.getVertsUsingEdge theObj edgesFromFace[2]) as array
		in coordsys world vert1 = meshOp.getVert theObj vertsFromEdges[1]
		in coordsys world vert2 = meshOp.getVert theObj vertsFromEdges[2]
		edge2 = length (vert2 - vert1)
		vertsFromEdges = (meshop.getVertsUsingEdge theObj edgesFromFace[3]) as array
		in coordsys world vert1 = meshOp.getVert theObj vertsFromEdges[1]
		in coordsys world vert2 = meshOp.getVert theObj vertsFromEdges[2]
		edge3 = length (vert2 - vert1)
		
		edge_length = if (temp = if edge1 > edge2 then edge1 else edge2) > edge3 then temp else edge3
		edge_number = if edge_length == edge1 then 1 else
				if edge_length == edge2 then 2 else
					if edge_length == edge3 do 3
				
		setEdgeVis theObj theFace edge_number false
	
		edge_number = (((theFace-1)*3)+edge_number)
		append edgesArr edge_number
		)
	setedgeselection theObj edgesArr
	)
) 