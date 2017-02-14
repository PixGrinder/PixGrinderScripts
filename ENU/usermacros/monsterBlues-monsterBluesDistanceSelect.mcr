macroScript monsterBluesDistanceSelect
 	category:"monsterBlues"
 	buttonText:"Distance Select"
 	toolTip:"Distance Select"
(
--	clearListener()

	--THIS FUNCTIONS RETURNS A CLOSER VERTEX BY DISTANCE
	--USE MESH OPERATIONS SO WE DON'T HAVE TO DEAL WITH EDIT POLY/MESH BULL
	fn getClosestAdjacentVertexToTarget obj vert targetVert =
	(
-- 		st = timestamp()
		
		VertsToCheck = (meshop.getVertsUsingEdge obj (meshop.getEdgesUsingVert obj #{vert})) as array

		vertDistance = distance (getVert obj targetVert) (getVert obj vert)
		closestVert = targetVert
		
		for v = 1 to VertsToCheck.count do
		(
			if VertsToCheck[v] != vert or VertsToCheck[v] != targetVert do
			(
				checkDistance = distance (getVert obj targetVert) (getVert obj VertsToCheck[v])
				if checkDistance < vertDistance do
				(
					vertDistance = checkDistance
					closestVert = VertsToCheck[v]
				)
			)
		)
		
-- 		et = timestamp()
-- 		format "getClosestAdjacentVertexToTarget took % seconds\n" ((et - st) / 1000.0)
		
		return closestVert
	)

	--GENERIC ERROR MESSAGE
	fn errorMsg =
	(
		messageBox "Select only one object and two verts." title:"Operation Failed."
	)

	if selection.count == 1 then
	(
		with redraw off
		(
			--GET THE ORIGINAL OBJECT
			originalObj = selection[1]
			
			--CREATE A TEMP MESH SO WE DON'T DEAL WITH THE EDIT POLY/MESH BULL
			undo off
			(
				obj = mesh mesh:originalObj.mesh
			)

			local VertPair = (getVertSelection obj) as array
			local VertLine = #()

			if VertPair.count == 2 then
			(
				escapeEnable = true
				
				undo off
				(
					--gc lite:true
					
-- 					st = timestamp()
					
					closestAdjacentVert = getClosestAdjacentVertexToTarget obj VertPair[1] VertPair[2]
					append VertLine closestAdjacentVert
					
					while VertPair[2] != closestAdjacentVert do
					(
						--print closestAdjacentVert
						nextClosestAdjacentVert = getClosestAdjacentVertexToTarget obj closestAdjacentVert VertPair[2]
						append VertLine nextClosestAdjacentVert
						closestAdjacentVert = nextClosestAdjacentVert
					)
					
-- 					et = timestamp()
-- 					format "Loop took % seconds\n" ((et - st) / 1000.0)
				)
				
				--print VertLine

				--SELECT VERTS ON THE ORIGINAL EDIT POLY OBJECT
				if classof originalObj == Editable_Poly do
				(
					undo "Distance Select" on
					(
						--JOIN THE VERT PAIR AND VERT LINE
						join VertLine VertPair
						polyop.setVertSelection originalObj VertLine
					)
				)

				--SELECT VERTS ON THE ORIGINAL EDIT MESH OBJECT
				if classof originalObj == Editable_Mesh do
				(
					undo "Distance Select" on
					(
						--USE KEEP SELECTION
						setVertSelection originalObj VertLine keep:true
					)
				)
				
				escapeEnable = false
			)
			else
			(
				errorMsg()
			)
			
			undo off
			(
				delete obj
			)
		)
		redrawViews()
	)
	else
	(
		errorMsg()
	)
)