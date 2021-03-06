macroScript EdgeStraighten category:"- Gueshni -" Icon:#("g9_edgestraighten", 1) tooltip:"Edge Straighten"

(
	On IsEnabled Return Filters.Is_EditPoly()
	On IsVisible Return Filters.Is_EditPoly()
	
	global g_edgedist = 0
	sliderundo = true
	
	fn bitarray2array bitarray_ =
	(
		local outgoing = for BA in bitarray_ collect BA
	)
	
	-- Written by Laszlo Sebo (MeshTools 2.5)
	fn findnewedges_poly obj this_edge =		-- finds the edges that are going from this edge onto edgeloops
	(
			local nextedge = #()
			local exclude_edges = #()
			local localverts = polyop.getedgeverts obj this_edge

			local edge_faces = polyop.getedgefaces obj this_edge
			if (edge_faces.count != 1) do
			(
				for nf in edge_faces do join exclude_edges (polyop.getfaceedges obj nf)

				local nextedges = polyop.getedgesusingvert obj localverts[1]			--check one end of the edge
				if ((bitarray2array nextedges).count == 4) do
					nextedge = bitarray2array (nextedges - (exclude_edges as bitarray) * nextedges)

				local nextedges = polyop.getedgesusingvert obj localverts[2]			--check one other of the edge
				if ((bitarray2array nextedges).count == 4) do
					join nextedge (bitarray2array (nextedges - (exclude_edges as bitarray) * nextedges))
			)
			nextedge
	)
	
	fn f_straightenedge inedges obj dist =(
		
		local vertsall = polyOp.getVertsUsingEdge obj inedges
		local vertsab = #{}
		vertsab.count = vertsall.count
		
		if (vertsall.numberset == 2) then
		(
			-- add edges	
			join inedges (findnewedges_poly obj (inedges as array)[1])
			vertsall = polyOp.getVertsUsingEdge obj inedges
		)	
		local numverts = vertsall.numberset		

	
		-- when all edges are connect we first add vertices
		-- then remove them again, all inbetweens exist twice, hence
		-- are removed
		for e in inedges do
		(
			local edge = polyOp.getEdgeVerts obj e
			for i in edge do
			(
				if (not vertsab[i]) then (
					vertsab[i] = true
				)
				else(
					vertsab[i] = false
				)
			)
		)
		
		if (vertsab.numberset != 2) then(
			print "edge selection contains multiple branches"
		)
		else if (numverts  > 2) then(
			-- turn to integer array
			-- get inbetweens
			vertsall = vertsall - vertsab
			vertsab = vertsab as array
			-- get major direction
			local v3start = (polyop.getvert obj vertsab[1])
			local v3end = (polyop.getvert obj vertsab[2])
			local v3dir = normalize(v3end - v3start)
			-- run thru all vertices left and project them on the straight line
			-- TODO flip positions if order is wrong (untangle)
			-- TODO copy start/end if dotprod is greater AB length or < 0
			for v in vertsall do
			(
				local v3 = (polyop.getvert obj v)-v3start
				v3 = v3dir*(dot v3 v3dir) + v3start
				polyop.setvert obj v v3
			)
			
			if (dist > 0 and numverts > 3) then (
				for e in inedges do (
					local edge = polyOp.getEdgeVerts obj e
	
					if (edge[1] == vertsab[1])	then (
						polyop.setvert obj edge[2] (v3start + v3dir*dist)
					)
					else if (edge[2] == vertsab[1]) then (
						polyop.setvert obj edge[1] (v3start + v3dir*dist)
					)
					else if (edge[1] == vertsab[2]) then (
						polyop.setvert obj edge[2] (v3end - v3dir*dist)
					)
					else if (edge[2] == vertsab[2]) then (
						polyop.setvert obj edge[1] (v3end - v3dir*dist)
					)
				)
			)
		)
	)
	
	-- this function 
	-- taken from 3dsmax8 help
	fn getEPolyUnconnectedEdgesSelections thePoly =
	(
		--get the edge selection
		mainSelection = (polyOp.getEdgeSelection thePoly) as array
		--init. an array to collect sub-arrays with selections "elements"
		unconnectedSelections = #()
		--repeat until the main selection array is empty
		while mainSelection.count > 0 do
		(
			--append a new empty sub-array:
			append unconnectedSelections #() 
			--remember the current sub-array's index 
			currentSelCount = unconnectedSelections.count
			--append the first edge from the main selection array to the sub-array
			append unconnectedSelections[currentSelCount] mainSelection[1]
			--and remove the first edge from the main selection array
			deleteItem mainSelection 1
			--init. a counter 
			cnt = 0
			--while the counter is less than the edges in the sub-array
			while cnt < unconnectedSelections[currentSelCount].count do
			(
				cnt += 1 --increase the counter by 1
				--get the vertices of the current edge in the current sub-array
				currentEdgeVerts = (polyOp.GetVertsUsingEdge thePoly unconnectedSelections[currentSelCount][cnt]) as array
				neigborEdges = #() --init. an array to collect neighbor
				--gor every vertex in the current edge,
				for v in currentEdgeVerts do
				--add the edges used by the vertex to the neighbors array
				join neigborEdges ((polyOp.GetEdgesUsingVert thePoly v) as array)
				--for each neighbor edge, 
				for edge in neigborEdges do
				(
					--see if the edge is in the main selection array
					checkInSelection = findItem mainSelection edge 
					--if it is,
					if checkInSelection > 0 then
					(
					--delete the edge from the main array
					deleteItem mainSelection checkInSelection 
					--and add it to the current sub-array
					append unconnectedSelections[currentSelCount] edge 
					)--end if
				)--end for edge loop
			)--end while cnt
		)--end while mainSelection.count
		--finally, return the array containing the sub-arrays of connected edges:
		unconnectedSelections
	)--end fn
	
	function f_straightenall obj dist =(
		local collections = getEPolyUnconnectedEdgesSelections obj
		for sel in collections do
		(
			f_straightenedge  sel obj dist
		)
	)
	
	rollout rollOptions "Options" 
	(
		spinner spDistance "Distance from  :" range:[0,100,g_edgedist] pos:[2,2] scale:0.01
		label lblDescr0 "outer vertices" pos:[2,16]
		label lblDescr1 "0 means distance is projected" pos:[2,40]
		label lblDescr2 "which is default" pos:[2,56]

		
		on spDistance changed value do (
			
			g_edgedist = value
			undo "straigthen edge spinner" sliderundo
			(
				f_straightenall $ g_edgedist
			)
		)
		on spDistance buttonDown do (
			flagForeground $ true
			sliderundo = false
		)
		on spDistance buttonUp do (
			flagForeground $ false 
			sliderundo = true
		)

	)
	
	On Execute Do (
		if subobjectlevel == undefined then max modify mode
		if subobjectlevel != 2 then subobjectlevel = 2
		else (
			undo "straigthen edge" on
			(
				f_straightenall $ g_edgedist
			)
		)
	)
	
	On AltExecute type do (
		if subobjectlevel == undefined then max modify mode
		if subobjectlevel != 2 then subobjectlevel = 2
		else (
			createdialog rollOptions
			undo "straigthen edge init" on (
				f_straightenall $ g_edgedist
			)
		)
	)
)

macroScript EdgeStraightenDialog
category:"CrazyButcher" 
tooltip:"EdgeStraighten Dialog (Poly)" 
(
	On IsEnabled Return Filters.Is_EditPoly()
	On IsVisible Return Filters.Is_EditPoly()

	global g_edgedist = 0
	
	sliderundo = true
	
		fn bitarray2array bitarray_ =
	(
		local outgoing = for BA in bitarray_ collect BA
	)
	
	-- Written by Laszlo Sebo (MeshTools 2.5)
	fn findnewedges_poly obj this_edge =		-- finds the edges that are going from this edge onto edgeloops
	(
			local nextedge = #()
			local exclude_edges = #()
			local localverts = polyop.getedgeverts obj this_edge

			local edge_faces = polyop.getedgefaces obj this_edge
			if (edge_faces.count != 1) do
			(
				for nf in edge_faces do join exclude_edges (polyop.getfaceedges obj nf)

				local nextedges = polyop.getedgesusingvert obj localverts[1]			--check one end of the edge
				if ((bitarray2array nextedges).count == 4) do
					nextedge = bitarray2array (nextedges - (exclude_edges as bitarray) * nextedges)

				local nextedges = polyop.getedgesusingvert obj localverts[2]			--check one other of the edge
				if ((bitarray2array nextedges).count == 4) do
					join nextedge (bitarray2array (nextedges - (exclude_edges as bitarray) * nextedges))
			)
			nextedge
	)
	
	fn f_straightenedge inedges obj dist =(
		
		local vertsall = polyOp.getVertsUsingEdge obj inedges
		local vertsab = #{}
		vertsab.count = vertsall.count
		
		if (vertsall.numberset == 2) then
		(
			-- add edges	
			join inedges (findnewedges_poly obj (inedges as array)[1])
			vertsall = polyOp.getVertsUsingEdge obj inedges
		)	
		local numverts = vertsall.numberset		

	
		-- when all edges are connect we first add vertices
		-- then remove them again, all inbetweens exist twice, hence
		-- are removed
		for e in inedges do
		(
			local edge = polyOp.getEdgeVerts obj e
			for i in edge do
			(
				if (not vertsab[i]) then (
					vertsab[i] = true
				)
				else(
					vertsab[i] = false
				)
			)
		)
		
		if (vertsab.numberset != 2) then(
			print "edge selection contains multiple branches"
		)
		else if (numverts  > 2) then(
			-- turn to integer array
			-- get inbetweens
			vertsall = vertsall - vertsab
			vertsab = vertsab as array
			-- get major direction
			local v3start = (polyop.getvert obj vertsab[1])
			local v3end = (polyop.getvert obj vertsab[2])
			local v3dir = normalize(v3end - v3start)
			-- run thru all vertices left and project them on the straight line
			-- TODO flip positions if order is wrong (untangle)
			-- TODO copy start/end if dotprod is greater AB length or < 0
			for v in vertsall do
			(
				local v3 = (polyop.getvert obj v)-v3start
				v3 = v3dir*(dot v3 v3dir) + v3start
				polyop.setvert obj v v3
			)
			
			if (dist > 0 and numverts > 3) then (
				for e in inedges do (
					local edge = polyOp.getEdgeVerts obj e
	
					if (edge[1] == vertsab[1])	then (
						polyop.setvert obj edge[2] (v3start + v3dir*dist)
					)
					else if (edge[2] == vertsab[1]) then (
						polyop.setvert obj edge[1] (v3start + v3dir*dist)
					)
					else if (edge[1] == vertsab[2]) then (
						polyop.setvert obj edge[2] (v3end - v3dir*dist)
					)
					else if (edge[2] == vertsab[2]) then (
						polyop.setvert obj edge[1] (v3end - v3dir*dist)
					)
				)
			)
		)
	)
	
	-- this function 
	-- taken from 3dsmax8 help
	fn getEPolyUnconnectedEdgesSelections thePoly =
	(
		--get the edge selection
		mainSelection = (polyOp.getEdgeSelection thePoly) as array
		--init. an array to collect sub-arrays with selections "elements"
		unconnectedSelections = #()
		--repeat until the main selection array is empty
		while mainSelection.count > 0 do
		(
			--append a new empty sub-array:
			append unconnectedSelections #() 
			--remember the current sub-array's index 
			currentSelCount = unconnectedSelections.count
			--append the first edge from the main selection array to the sub-array
			append unconnectedSelections[currentSelCount] mainSelection[1]
			--and remove the first edge from the main selection array
			deleteItem mainSelection 1
			--init. a counter 
			cnt = 0
			--while the counter is less than the edges in the sub-array
			while cnt < unconnectedSelections[currentSelCount].count do
			(
				cnt += 1 --increase the counter by 1
				--get the vertices of the current edge in the current sub-array
				currentEdgeVerts = (polyOp.GetVertsUsingEdge thePoly unconnectedSelections[currentSelCount][cnt]) as array
				neigborEdges = #() --init. an array to collect neighbor
				--gor every vertex in the current edge,
				for v in currentEdgeVerts do
				--add the edges used by the vertex to the neighbors array
				join neigborEdges ((polyOp.GetEdgesUsingVert thePoly v) as array)
				--for each neighbor edge, 
				for edge in neigborEdges do
				(
					--see if the edge is in the main selection array
					checkInSelection = findItem mainSelection edge 
					--if it is,
					if checkInSelection > 0 then
					(
					--delete the edge from the main array
					deleteItem mainSelection checkInSelection 
					--and add it to the current sub-array
					append unconnectedSelections[currentSelCount] edge 
					)--end if
				)--end for edge loop
			)--end while cnt
		)--end while mainSelection.count
		--finally, return the array containing the sub-arrays of connected edges:
		unconnectedSelections
	)--end fn
	
	function f_straightenall obj dist =(
		local collections = getEPolyUnconnectedEdgesSelections obj
		for sel in collections do
		(
			f_straightenedge  sel obj dist
		)
	)
	
	rollout rollOptions "Options" 
	(
		spinner spDistance "Distance from  :" range:[0,100,g_edgedist] pos:[2,2] scale:0.01
		label lblDescr0 "outer vertices" pos:[2,16]
		label lblDescr1 "0 means distance is projected" pos:[2,40]
		label lblDescr2 "which is default" pos:[2,56]

		
		on spDistance changed value do (
			
			g_edgedist = value
			undo "straigthen edge spinner" sliderundo
			(
				f_straightenall $ g_edgedist
			)
		)
		on spDistance buttonDown do (
			flagForeground $ true
			sliderundo = false
		)
		on spDistance buttonUp do (
			flagForeground $ false 
			sliderundo = true
		)

	)
	On Execute do (
		if subobjectlevel == undefined then max modify mode
		if subobjectlevel != 2 then subobjectlevel = 2
		else (
			createdialog rollOptions
			undo "straigthen edge init" on (
				f_straightenall $ g_edgedist
			)
		)
	)
)