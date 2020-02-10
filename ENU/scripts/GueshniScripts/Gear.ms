plugin simpleObject spurGear
	name:"Gear"
	category:"Gueshni"
	classID:#(0x16852d2a, 0x7bd01ff0)

(
	local involutePoints = #()
	local trochoidPoints = #()
	local toothAngle = 18d0
	local halfN = 10d0

	fn getMmPerUnit = case units.systemType of
	(
		#inches: 25.4
		#feet: 304.8
		#miles: 1609344.
		#centimeters: 10.
		#meters: 1e3
		#kilometers: 1e6
		default: 1.
	)

	parameters main rollout:params
	(
		toothCount default:20 type:#integer ui:spnToothCount
		pitchRadius default:20 type:#worldUnits ui:spnPitchRadius
		holeRadius default:4 type:#worldUnits ui:spnHoleRadius
		faceWidth default:5 type:#worldUnits ui:spnFaceWidth
		toothSegs default:3 type:#integer ui:spnSegs
		innerSegs default:2 type:#integer ui:spnInnerSegs
		heightSegs default:1 type:#integer ui:spnHeightSegs
		smooth default:true type:#boolean ui:chxSmooth

		pressureAngle default:20 type:#angle ui:spnPressureAngle
		profileShift default:0 type:#float ui:spnProfileShift
		clearance default:0.25 type:#float ui:spnclearance
		precision default:0.01 type:#float animatable:false ui:spnPrecision
		mmPerUnit default:0 type:#float animatable:false ui:spnMmPerUnit

		on toothCount set count do (toothAngle = 180 / (halfN = count / 2d0); this.params.spnModule.value = this.params.getModule (mmPerUnit != 0))
		on pitchRadius set val do this.params.spnModule.value = this.params.getModule (mmPerUnit != 0)
	)

	rollout params "Parameters"
	(
		group "Basic"
		(
			spinner spnToothCount "Tooth Count: " type:#integer fieldWidth:50 range:[3, 1e6, 20]
			spinner spnModule "Module [mm]: " type:#float fieldWidth:50 range:[0.1, 1e6, 2] tooltip:"The length of the pitch circle diameter per tooth.\nIf the units are generic units, they are treated as millimeters."
			spinner spnPitchRadius "Pitch Radius: " type:#worldUnits fieldWidth:50 range:[1e-6, 1e9, 20] tooltip:"The diameter of a circle which by pure rolling action would produce the same motion as toothed gear."
			spinner spnHoleRadius "Hole Radius: " type:#worldUnits fieldWidth:50 range:[1e-9, 1e9, 4]
			spinner spnFaceWidth "Face Width: " type:#worldUnits fieldWidth:50 range:[-1e9, 1e9, 4]
			spinner spnSegs "Tooth Segs: " type:#integer fieldWidth:50 offset:[0,10] range:[3, 1e6, 5]
			spinner spnInnerSegs "Inner Segs: " type:#integer fieldWidth:50 range:[2, 1e6, 1]
			spinner spnHeightSegs "Height Segs: " type:#integer fieldWidth:50 range:[1, 1e6, 1]
			checkBox chxSmooth "Smooth" align:#right
		)

		group "Advanced"
		(
			spinner spnPressureAngle "Pressure Angle: " fieldWidth:50 range:[1, 90, 20] tooltip:"Common values are 14.5, 20 and 25 degrees.\nFor 14.51° pressure angle the usual clearance is equal to pi / 20.\nFor 20° pressure angle it is to 0.225 - 0.25"
			spinner spnProfileShift "Profile Shift: " fieldWidth:50 range:[-0.5, 0.6, 0] tooltip:"Used most often to prevent undercut.\nIndicates what portion of gear one's addendum height should be shifted to gear two."
			spinner spnclearance "Clearance Coeff. " fieldWidth:50 range:[0.1, 0.3, pi/20d0]
			spinner spnPrecision "Precision: " fieldWidth:50 scale:1e-3 range:[1e-3, 0.1, 0.01]
			spinner spnMmPerUnit "mm per Unit: " fieldWidth:50 indeterminate:true range:[0, 1e9, 0]
		)

		fn getModule conversionSet =
			2 * pitchRadius / toothCount * (if conversionSet then mmPerUnit else getMmPerUnit())

		on params open do
		(
			local conversionSet = mmPerUnit != 0
			spnMmPerUnit.indeterminate = NOT conversionSet
			spnModule.value = getModule conversionSet
		)

		on spnModule changed val do
		(
			pitchRadius = toothCount / 2d0 * val / (if mmPerUnit != 0 then mmPerUnit else getMmPerUnit())
			redrawViews()
		)
	)

	local flipMeshNormals = meshOp.flipNormals

	struct segment (index = 0, box, elements)

	struct rect
	(
		p1, p2,
		x = amin p1.x p2.x,
		y = amin p1.y p2.y,
		w = abs (p1.x - p2.x),
		h = abs (p1.y - p2.y),
		left = x,
		right = x + w,
		bottom = y,
		top = y + h
	)

	fn isOdd nr =
		bit.and 1L nr != 0

	fn getUnitRoot rad =
		(rad^2 + 1)^.5

	fn getTangent outer inner =
		(((outer / inner)^2 - 1)^.5)

	fn getUnwindAngle ang =
		radToDeg ang - atan ang

	fn getNthVal n nMax valMin valMax mult:1d0 =
		(valMin * (nMax - n * mult) + valMax * n * mult) / nMax

	fn wrapIndex nr lower upper =
		int(mod (nr - lower) (upper - lower + 1)) + lower

	fn doBoxesIntersect b1 b2 =
		abs(b1.x - b2.x) < (b1.w + b2.w) AND abs(b1.y - b2.y) < (b1.h + b2.h)

	fn isPointInSegment p1 p2 pos =
	(
		local proj = (dot (normalize (p2 - p1)) (pos - p1))
		proj >= 0 AND proj <= length (p2 - p1) AND close_enough ((dot (normalize (p2 - p1)) (normalize (pos - p1)))) 1 10
	)

	fn doSegmentsContainPt s1 s2 pt =
		isPointInSegment s1.p1 s1.p2 pt AND isPointInSegment s2.p1 s2.p2 pt

	fn getLineIntersection p1 p2 p3 p4 =
	(
		local cross1 = cross (normalize (p2 - p1)) (normalize (p4 - p3))
		local cross2 = cross (p3 - p1) (normalize (p4 - p3))
		p1 + normalize (p2 - p1) * dot cross2 cross1 / dot cross1 cross1
	)

	fn getBoxForBoxes b1 b2 =
		rect p1:[amin b1.left b2.left, amax b1.top b2.top] \
		     p2:[amax b1.right b2.right, amin b1.bottom b2.bottom]

	fn getSegments points =
		for i = 2 to points.count collect
			segment index:i box:(rect p1:points[i-1] p2:points[i]) elements:#(points[i-1], points[i])

	fn getSegmentTree segments =
		if segments.count > 2 then
		(
			local newSegments = for i = 2 to segments.count by 2 collect
				segment box:(getBoxForBoxes segments[i-1].box segments[i].box) elements:#(segments[i-1], segments[i])
			if isOdd segments.count do append newSegments segments[segments.count]
			getSegmentTree newSegments
		)
		else if segments.count == 2 then
			segment box:(getBoxForBoxes segments[1].box segments[2].box) elements:#(segments[1], segments[2])
		else segments[1]

	fn findIntersections seg1 seg2 intersections:#() =
	(
		if doBoxesIntersect seg1.box seg2.box then
		(
			if seg1.index > 0 AND seg2.index > 0 then
			(
				local intersection = getLineIntersection seg1.box.p1 seg1.box.p2 seg2.box.p1 seg2.box.p2
				if doSegmentsContainPt seg1.box seg2.box intersection do
				(
					append intersections intersection
					append intersections seg1.index
					append intersections seg2.index
				)
			)
			else if seg1.index > 0 then
			(
				findIntersections seg1 seg2.elements[1] intersections:intersections
				findIntersections seg1 seg2.elements[2] intersections:intersections
			)
			else if seg2.index > 0 then
			(
				findIntersections seg1.elements[1] seg2 intersections:intersections
				findIntersections seg1.elements[2] seg2 intersections:intersections
			)
			else
			(
				findIntersections seg1.elements[1] seg2.elements[1] intersections:intersections
				findIntersections seg1.elements[1] seg2.elements[2] intersections:intersections
				findIntersections seg1.elements[2] seg2.elements[1] intersections:intersections
				findIntersections seg1.elements[2] seg2.elements[2] intersections:intersections
			)
		)
		intersections
	)

	fn intersectToothCurves involutePoints trochoidPoints =
	(
		local involuteCurve = getSegmentTree (getSegments involutePoints)
		local trochoidCurve = getSegmentTree (getSegments trochoidPoints)

		local intersections = findIntersections involuteCurve trochoidCurve

		if intersections.count < 1 then
		(
			local intersection = trochoidPoints[1]
			this.involutePoints = for p in involutePoints where p.y > intersection.y collect p
		)
		else
		(
			this.involutePoints = for i = 1 to intersections[2] - 1 collect involutePoints[i]
			this.trochoidPoints = for i = intersections[3] to trochoidPoints.count collect trochoidPoints[i]
			append involutePoints intersections[1]
			insertItem intersections[1] this.trochoidPoints 1
		)
	)

	fn getInterpolatedPts points count =
	(
		local total = 0d0
		local lengths = for i = 2 to points.count collect (d = distance points[i-1] points[i]; total += d; d)
		local step = total / count * (1 - precision / 100)

		local pts = #()
		local accum = 0d0
		for i = 2 to points.count do
		(
			accum += lengths[i-1]
			while accum >= step do
				append pts (points[i] + (accum -= step) * normalize (points[i-1] - points[i]))
		)
		pts
	)

	fn getUnitToothPoints segIters =
	(
		free involutePoints
		free trochoidPoints

		local addendum = 1 + profileShift
		local dedendum = (1 - profileShift) + clearance

		local V = (profileShift - 1) / tan pressureAngle
		local U = V * (tan pressureAngle)^2 - clearance * (getUnitRoot (tan pressureAngle)) - pi / 4

		local offsetAngle = toothAngle / 4 + getUnwindAngle (tan pressureAngle)
		local involuteMax = getTangent (1 + addendum / halfN) (cos pressureAngle)

		local angleMin = radToDeg ((U + V) / halfN)
		local angleMax = radToDeg (U / halfN)

		for seg = 0 to segIters do
		(
			local trochoidAngle = getNthVal seg segIters angleMin angleMax mult:0.99d0
			local involuteAngle = getUnwindAngle (getNthVal seg segIters involuteMax 0) - offsetAngle

			if involuteAngle < 0 do append involutePoints \
				(cos pressureAngle * getUnitRoot (getNthVal seg segIters involuteMax 0) * [sin involuteAngle, cos involuteAngle, 0])

			local stepV = getNthVal seg segIters -V 0 mult:0.99d0

			local M = V * tan pressureAngle / stepV
			local N = clearance / getUnitRoot M
			local P = N * M + V * tan pressureAngle + halfN

			local x = P * sin trochoidAngle + (N + stepV) * cos trochoidAngle
			local y = P * cos trochoidAngle - (N + stepV) * sin trochoidAngle

			append trochoidPoints ([x, y, 0] / halfN)
		)
		append trochoidPoints ((1 - dedendum / halfN) * [-sin (toothAngle / 2), cos (toothAngle / 2), 0])

		intersectToothCurves involutePoints trochoidPoints

		local toothPoints = #(involutePoints[1])
		for p in (getInterpolatedPts involutePoints toothSegs) do append toothPoints p
		for p in (getInterpolatedPts trochoidPoints toothSegs) do append toothPoints p
		toothPoints
	)

	fn getReversedFace face =
		[face.z, face.y, face.x]

	fn addQuad pt1 pt2 pt3 pt4 &faces =
	(
		append faces [pt1, pt4, pt3]
		append faces [pt3, pt2, pt1]
	)

	fn addRow pts1 pts2 row rows count &vertList new:true =
		if row == 0 then pts1 else if row == rows then pts2
		else if NOT new then for i = vertList.count - count + 1 to vertList.count collect i
		else
		(
			local lastVert = vertList.count
			join vertList (for i = 1 to count collect getNthVal row rows vertList[pts1[i]] vertList[pts2[i]])
			for i = lastVert + 1 to lastVert + count collect i
		)

	fn makeQuadStrip pts1 pts2 count &faceList closed:false =
	(
		if closed do count -= 1
		for offset = 1 to count do
			addQuad pts1[offset] pts1[offset + 1] pts2[offset + 1] pts2[offset] &faceList

		if closed do addQuad pts1[count + 1] pts1[1] pts2[1] pts2[count + 1] &faceList
	)

	fn makeMultiStrip pts1 pts2 count loops &faceList &vertList closed:false =
		for row = 1 to loops do
			makeQuadStrip (addRow pts1 pts2 (row - 1) loops pts1.count &vertList new:false) \
			              (addRow pts1 pts2 row loops pts1.count &vertList) \
			              count &faceList closed:closed

	fn getOuterPoints toothCount toothPtCount midCount offset:1 pts:#{} =
	(
		for i = 0 to toothCount-1 do
			pts += #{offset + i * toothPtCount .. offset + 2 * toothSegs + i * toothPtCount, \
			         offset + 2 * toothSegs + midCount + i * toothPtCount .. offset + (i + 1) * toothPtCount - 1}

		pts = pts as array
		for i = pts.count to 1 by -1 collect pts[i]
	)

	fn addSingleNGonPoints n radius &vertList segments:1 clockwise:false =
	(
		local angle = 360d0/n * (if clockwise then 1 else -1)
		local prevPos = [0, radius, 0]
		local dist = 2 * radius * sin angle / segments

		for i = 1 to n do
		(
			local pos = radius * [sin (i*angle), cos (i*angle), 0]
			local step = (pos - prevPos) / segments

			for i = 0 to segments-1 do append vertList (prevPos + i * step)
			prevPos = pos
		)
	)

	fn addNGonsPoints holeRadius rootRadius loops innerDiv &vertList =
		for i = 1 to loops do
		(
			local mult = getNthVal i innerSegs 1d0 0d0
			addSingleNGonPoints toothCount (((1 - mult) * holeRadius + mult * rootRadius) / cos (toothAngle/2)) &vertList segments:innerDiv
		)

	fn addTeethPoints pitchRadius toothCount toothPoints innerCount &vertList =
		for tooth = 0 to toothCount-1 do
		(
			local angle = tooth * toothAngle

			for i = toothPoints.count-1 to 1 by - 1 do
				append vertList (pitchRadius * toothPoints[i] * [-1,1,0] * rotateZMatrix angle)

			for i = 1 to toothPoints.count-innerCount do
				append vertList (pitchRadius * toothPoints[i] * [0,1,0] * rotateZMatrix angle)

			for p in toothPoints do
				append vertList (pitchRadius * p * rotateZMatrix angle)
		)

	fn getCurvedLoop offset baseCount midCount =
		for i = offset + midCount to (offset + midCount + 4 * toothSegs) collect wrapIndex i 1 baseCount

	fn getStraightLoop offset baseCount loopCount midCount toothPtCount innerDiv =
		join (for i = offset to offset + midCount - 1 collect wrapIndex i 1 baseCount) \
		     (for i = baseCount + innerDiv * (offset / toothPtCount) + 1 to baseCount + innerDiv * (1 + offset / toothPtCount) + 1 collect wrapIndex i (baseCount + 1) (baseCount + loopCount)) + \
		     (for i = offset + toothPtCount + midCount - 1 to offset + toothPtCount by - 1 collect wrapIndex i 1 baseCount)

	fn makeOuterFlatFaces baseCount loopCount midCount toothPtCount innerDiv &faceList =
		for offset = 2 * toothSegs + 1 to baseCount by toothPtCount do
			makeQuadStrip (getCurvedLoop offset baseCount midCount) \
			              (getStraightLoop offset baseCount loopCount midCount toothPtCount innerDiv) \
			              (4 * toothSegs) &faceList

	fn makeInnerFlatFaces loops baseCount loopCount stripCount &faceList =
		for i = 0 to loops do
			makeQuadStrip (#{baseCount + i * loopCount + 1 .. baseCount + (i+1) * loopCount} as array) \
			              (#{baseCount + (i+1) * loopCount + 1 .. baseCount + (i+2) * loopCount} as array) \
			              stripCount &faceList closed:true

	fn makeOuterLoopFaces toothCount toothPtCount midCount basePointCount &faceList &vertList =
		makeMultiStrip (getOuterPoints toothCount toothPtCount midCount) \
		               (getOuterPoints toothCount toothPtCount midCount offset:(basePointCount + 1)) \
		               (toothCount * (toothPtCount - midCount + 1)) heightSegs &faceList &vertList closed:true

	fn makeInnerLoopFaces basePointCount loopCount &faceList &vertList =
		makeMultiStrip (#{basePointCount - loopCount + 1 .. basePointCount} as array) \
		               (#{2 * basePointCount - loopCount + 1 .. 2 * basePointCount} as array) \
		               loopCount heightSegs &faceList &vertList closed:true

	fn smoothFaces obj flatFaceCount faceCount facetCount =
	(
		for face = 1 to flatFaceCount do setFaceSmoothGroup obj face 1
		for face = flatFaceCount + 1 to faceCount do setFaceSmoothGroup obj face 2
		for i = 0 to facetCount do
		(
			local f = flatFaceCount + 1 + (2 * i + 1) * toothSegs * 4 + i * 4
			for face = f to f+3 do setFaceSmoothGroup obj face 4
		)
	)

	fn clampHoleRadius rootRadius =
	(
		disableRefMsgs()
		holeRadius = amin holeRadius (0.9 * rootRadius)
		enableRefMsgs()
	)

	on clone original do
	(
		toothAngle = original.toothAngle
		halfN = original.halfN
	)

	on buildMesh do
	(
		local vertList = #()
		local faceList = #()

		local innerCount = int((toothSegs + 1) / 2)
		local innerDiv = 2 * (innerCount-1)
		local midCount = 2 * toothSegs - (innerCount - 1)
		local toothPtCount = 1 + 4 * toothSegs + midCount
		local baseCount = toothCount * toothPtCount
		local loopCount = toothCount * innerDiv

		local toothPoints = this.getUnitToothPoints (int(1 / precision))
		local rootRadius = pitchRadius * length toothPoints[toothPoints.count]

		clampHoleRadius rootRadius

		addTeethPoints pitchRadius toothCount toothPoints innerCount &vertList
		addNGonsPoints holeRadius rootRadius (innerSegs-1) innerDiv &vertList
		addSingleNGonPoints loopCount holeRadius &vertList

		makeOuterFlatFaces baseCount loopCount midCount toothPtCount innerDiv &faceList
		makeInnerFlatFaces (innerSegs - 2) baseCount loopCount (toothCount * innerDiv) &faceList

		local basePointCount = vertList.count
		join vertList (for vert in vertList collect Point3 vert.x vert.y faceWidth)
		join faceList (for face in faceList collect basePointCount + getReversedFace face)
		local flatFaceCount = faceList.count

		makeOuterLoopFaces toothCount toothPtCount midCount basePointCount &faceList &vertList
		makeInnerLoopFaces basePointCount loopCount &faceList &vertList

		setMesh mesh vertices:vertList faces:faceList

		for face in mesh.faces do setEdgeVis mesh face.index 3 false
		if faceWidth < 0 do flipMeshNormals mesh #all

		if NOT smooth then for face = 1 to faceList.count do setFaceSmoothGroup mesh face 0
		else smoothFaces mesh flatFaceCount faceList.count (heightSegs * toothCount - 1)
	)

	tool create numPoints:3
	(
		on mousePoint click do if click == 1 do
		(
			faceWidth = 0
			nodeTM.translation = gridPoint
		)

		on mouseMove click do case click of
		(
			2: holeRadius = (pitchRadius = (gridDist.x^2 + gridDist.y^2)^.5) / 5
			3: faceWidth = gridDist.z
		)
	)
)