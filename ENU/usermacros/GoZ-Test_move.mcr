macroScript Test_move
category:"GoZ"
tooltip:"GoZ test3 (move)"
(
	max modify mode
	local node = $
	local modifier = modPanel.getCurrentObject()
	
	format " +++ test move : node = % (class = %)\n" node (classof node)
	if (modifier != undefined) then 
		format "    modifier = % (class = %)\n" modifier (classof modifier)
	else
		format "    modifier = undefined\n" 
	
	if (modifier != undefined) then (
/*
		--modifier.SetEPolySelLevel #Vertex
		subobjectLevel = 1
		modifier.SetOperation #Transform

	PrintCurrentTime "Before MoveSelection" ""
		--disableSceneRedraw()
		--with redraw off
		--undo off (
			local nv = modifier.GetNumVertices()
			local numMoved = 0
			local moveVec = [1, 1, 1]
			local moveVec2 = [2, 0, 0]
			for i = 1 to nv do	
			(
				if (i < 20) then (
					modifier.SetSelection #Vertex #{}
					modifier.Select #Vertex #{i}
					if (i < 10) then (
						modifier.MoveSelection moveVec
					) else (
						modifier.MoveSelection moveVec2
					)
					modifier.Commit ()
					
					numMoved = numMoved + 1
				)
			)
			--modifier.Commit ()
		--)
		--enableSceneRedraw()
format "% / % vertices moved ! \n" numMoved nv	
PrintCurrentTime "After MoveSelection" ""
*/
	)

	-- test move:
	/* polyop.setVert ne marche que sur un EditablePoly ou un baseMesh mais pas sur un EditPoly!!!!!
	subobjectLevel = 1
	local myVertexList = #{1, 2, 3, 4, 5, 6}
	local myPointArray = #()
	
	local point1 = [0, 0, 1]
	append myPointArray point1
	append myPointArray point1
	append myPointArray point1
print "coucou1"	
	--local point2 = polyop.getVert modifier 7
	local point2 = [1, 0, 1]
print "coucou2"	
	append myPointArray point2
	append myPointArray point2
	append myPointArray point2
	format "vtxList = %\n" myVertexList
print "coucou3"	
	polyop.setVert modifier myVertexList myPointArray node:$
print "coucou4"	
*/
)
