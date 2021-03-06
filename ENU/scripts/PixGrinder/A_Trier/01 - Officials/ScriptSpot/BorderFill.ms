-- macroScript polyOp_BorderFill
-- 	buttonText:"Border Fill"
-- 	category:"PolyOp"
-- 	internalCategory:"PolyOp"
-- 	author:"Vojtech Cada"
(
	fn isValid =
		selection.count == 1 AND subObjectLevel == 1 AND Filters.Is_EditPoly()

	fn isEven nr = bit.and 1L nr == 0

	fn getNthVal n nMax valMin valMax mult:1d0 =
		(valMin * (nMax - n * mult) + valMax * n * mult) / nMax

	fn getFirstItem bitArr item:0 =
	(
		for i in bitArr while NOT item > 0 do item = i
		item
	)

	fn getRowCount verts vertSel =
		if vertSel.count == 1 then (verts.count / 2 + 1) / 2
		else if (local index = findItem verts vertSel[2]) == verts.count / 2 + 1 then index - 2
		else if index < verts.count / 2 then index - 1
		else index - verts.count / 2 - 1

	fn getSortedBorder obj vertSel edges edgePair =
	(
		local border = #()
		local prevVert = vertSel[1]
		local prevEdge = if (polyOp.getEdgeVerts obj edgePair[1])[1] == prevVert then edgePair[2] else edgePair[1]
		edges[prevEdge] = false

		while edges.numberSet > 0 do
		(
			append border prevVert
			prevVert = getFirstItem (polyOp.getVertsUsingEdge obj prevEdge - #{prevVert})
			prevEdge = getFirstItem (edges * polyOp.getEdgesUsingVert obj prevVert)
			edges[prevEdge] = false
		)

		append border prevVert
	)

	fn makeQuadStrip obj pts1 pts2 count closed:false =
	(
		if closed do count -= 1
		for offset = 1 to count do
			polyOp.createPolygon obj #(pts1[offset], pts1[offset + 1], pts2[offset + 1], pts2[offset])

		if closed do polyOp.createPolygon obj #(pts1[count + 1], pts1[1], pts2[1], pts2[count + 1])
	)

	fn makeQuadFill obj rowFirst columnFirst rowLast columnLast =
	(
		local corner1 = polyOp.getVert obj rowFirst[1]
		local corner2 = polyOp.getVert obj columnFirst[1]
		local corner3 = polyOp.getVert obj rowLast[1]
		local corner4 = polyOp.getVert obj columnLast[1]

		local columns = rowFirst.count
		local rows = columnFirst.count
		local startIndex = polyOp.getNumVerts obj
		local prevColumn = #(rowFirst[1]) + (for i = rows to 1 by -1 collect columnLast[i])

		for column = 2 to columns do
		(
			for row = 2 to rows do
			(
				local p1 = polyOp.getVert obj rowFirst[column]
				local p2 = polyOp.getVert obj columnFirst[row]
				local p3 = polyOp.getVert obj rowLast[columns + 2 - column]
				local p4 = polyOp.getVert obj columnLast[rows + 2 - row]

				polyOp.createVert obj (getNthVal (row - 1) rows p1 p3 + \
				                      getNthVal (column - 1) columns p4 p2 -
				                      getNthVal (row - 1) rows \
				                                (getNthVal (column - 1) columns corner1 corner2) \
				                                (getNthVal (column - 1) columns corner4 corner3))
			)

			local nextColumn = #(rowFirst[column]) + (for i = startIndex + 1 to startIndex + rows - 1 collect i) + #(rowLast[columns + 2 - column])

			makeQuadStrip obj prevColumn nextColumn rows
			prevColumn = nextColumn
			startIndex += rows - 1
		)

		makeQuadStrip obj prevColumn (columnFirst + #(rowLast[1])) rows
	)

	fn makeBorderFill obj pts rowCount columnCount =
	(
		local vertCount = polyOp.getNumVerts obj
		local count = pts.count

		local side1 = for i = 1 to rowCount collect pts[i]
		local side2 = for i = rowCount + 1 to rowCount + columnCount collect pts[i]
		local side3 = for i = rowCount + columnCount + 1 to 2 * rowCount + columnCount collect pts[i]
		local side4 = for i = 2 * rowCount + columnCount + 1 to count collect pts[i]

		makeQuadFill obj side1 side2 side3 side4
		polyOp.setVertSelection obj (for vert = vertCount + 1 to polyOp.getNumVerts obj collect vert)
	)

	on isEnabled return isValid()
	on isVisible return isValid()

	on execute do with undo "Border Fill" on
	(
		local obj = modPanel.getCurrentObject()
		local vertSel = polyOp.getVertSelection obj as array

		if vertSel.count < 1 do
			return messageBox "At least one vertex has to be selected."

		if vertSel.count > 2 do
			return messageBox "At most two vertices have to be selected."

		local vertEdges = (polyOp.getOpenEdges obj * polyOp.getEdgesUsingVert obj vertSel[1]) as array

		if vertEdges.count != 2 do
			return messageBox "Invalid vertex/edge combination."

		local edgeBorder = polyOp.getBorderFromEdge obj vertEdges[1]

		if edgeBorder.numberSet < 4 do
			return messageBox "At least two edges have to be selected."

		if NOT isEven edgeBorder.numberSet do
			return messageBox "The number of selected edges must be even."
		
		if vertSel.count == 2 AND NOT (polyOp.getVertsUsingEdge obj edgeBorder)[vertSel[2]] do
			return messageBox "Both vertices must share the same border."

		local borderLoop = getSortedBorder obj vertSel edgeBorder vertEdges
		local rowCount = getRowCount borderLoop vertSel 
		local columnCount = (borderLoop.count - 2 * rowCount) / 2

		makeBorderFill obj borderLoop rowCount columnCount
		notifyDependents obj partIDmsg:#obj 
	)
)