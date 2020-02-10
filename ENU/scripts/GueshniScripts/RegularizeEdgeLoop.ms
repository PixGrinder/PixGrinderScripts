 (
	local theObject
	local theEdges
	local theLoops
		
	on IsEnabled return Filters.Is_EditPolySpecifyLevel #{3..5}
	on IsVisible return Filters.Is_EditPolySpecifyLevel #{3..5}
	on execute do
	(
		--check for validity / build one vertex array per loop
		function buildTheLoops =
		(
			--shorthands/optimization
			local v2e = polyOp.getEdgesUsingVert
			local e2v = polyOp.getVertsUsingEdge
			
			while not theEdges.isEmpty do
			(
				local theEdge = (theEdges as array)[1]
				local theVerts = polyOp.getEdgeVerts theObject theEdge
				theEdges -= #{theEdge}
				local vertA = theVerts[1]
				local vertB = theVerts[2]
				
				while true do
				(
					vertA = vertB
					local theConnected = (v2e theObject vertA) * theEdges
					local cnt = theConnected.numberSet
					if cnt > 1 do return 1  --branching edges
					if cnt == 0 then
					(
						if theVerts[1] != theVerts[theVerts.count] do return 2  --open loop
						deleteItem theVerts theVerts.count
						exit
					)
					else theEdge = (theConnected as array)[1]
					vertB = (((e2v theObject theEdge) - #{vertA}) as array)[1]
					append theVerts vertB
					theEdges -= #{theEdge}
					
				)--end while true
				
				append theLoops theVerts
				
			)--end while not theEdges.isEmpty
			
			return 0  --edge loops valid
			
		)-- end function buildTheVerts
		
		
		--make edge loops regular
		function makeRegular =
		(
			--shorthands/optimization
			local getPos = polyOp.getVert
			local setPos = polyOp.setVert
			
			for theLoop in theLoops do
			(
				local theCount = theLoop.count
				if theCount < 3 do return 1  --no need to rearrange 2 edges
				
				--average position of all vertices
				local theCenter = [0,0,0]
				for i = 1 to theCount do theCenter += getPos theObject theLoop[i]
				theCenter /= theCount
				
				--triangles formed by each edge in loop and theCenter
				--average of their normals, weighted by their surfaces
				local theDir = [0,0,0]
				for i = 1 to theCount do
					theDir += cross (getPos theObject theLoop[i] - theCenter) \
									(getPos theObject theLoop[mod i theCount + 1] - theCenter)
				
				--coordinate system local to the loop
				local theLocalTM = matrixFromNormal (normalize theDir)
				theLocalTM.translation = theCenter
				
				in coordSys theLocalTM
				(
					local theCoords = for i = 1 to theCount collect
						(getPos theObject theLoop[i]) * [1,1,0]  --make planar in theLocalTM (z = 0)
					local theRadius = 0  --average distance from theCenter
					local theDelta = 360.0 / theCount  --average angle variation
					local theOffset = 0  --average variations of ith vector from i * theDelta
					
					for i = 1 to theCount do
					(
						local p = theCoords[i]
						theRadius += length p
						local theAngle = atan2 p.y p.x
						theOffset += mod (720 + theAngle - theDelta * i) 360  --needs to be positive
					)
					
					theRadius /= theCount
					theOffset /= theCount
					
					for i = 1 to theCount do
					(
						local theAngle = theOffset + theDelta * i
						setPos theObject theLoop[i] ((theRadius * [cos theAngle, sin theAngle, 0]))
					)
					
				)--end in coordSys theLocalTM
				
			)--end for theLoop in theLoops
			
		)--end function makeRegular()
		
		
		-- macro body
		theLoops =#()
		theObject = selection[1]
		if subobjectLevel == 4 do theObject.editablePoly.convertSelectionToBorder #face #edge
		if (theEdges = polyOp.getEdgeSelection theObject).isEmpty then
			MessageBox "Selection is Empty" Title:"Poly Editing"
		else if (polyOp.getVertsUsingEdge theObject theEdges).numberSet != theEdges.numberSet then
			MessageBox "Invalid Edge Loop(s)" Title:"Poly Editing"
		else case buildTheLoops() of
			(
				1: MessageBox "Branching Edge Loop(s)" Title:"Poly Editing"
				2: MessageBox "Open Edge Loop(s)" Title:"Poly Editing"
				0: makeRegular()
			)
			
			
	)--end on execute
			
)--end script