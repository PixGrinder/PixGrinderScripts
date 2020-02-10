global RL_VerticesToSplines

global sourceObj = undefined

fn mesh_filt obj = SuperClassOf obj == GeometryClass or (SuperClassOf obj == shape and obj.render_displayRenderMesh == true)

try (destroyDialog RL_VerticesToSplines) catch()

rollout RL_VerticesToSplines "Vertex to Spline"
(
	-- Rounds a value to n decimal places
	fn round_to val n =
	(
		local mult = 10.0 ^ n
		(floor ((val * mult) + 0.5)) / mult
	)
	
	-- Return a value with a percent of variation 	
	fn variation val varPercent outputInteger:false =
	(
		RndMultiplier = varPercent/100.0
		lowerMult = 1 - RndMultiplier
		upperMult = 1 + RndMultiplier
		RndVal = random (val*lowerMult) (val*upperMult)
		if outputInteger==true then RndVal = RndVal as integer
		RndVal
	)
	
	-- Returns a random radial point around the given point, taking a maximum radius
	fn radialPoint iniPos maxRadius =
	(
		mtx = matrix3 1
		angX = random 0 360
		angY = random 0 360
		mtx = (rotateXmatrix angX) * mtx
		mtx = (rotateYmatrix angY) * mtx
		newPointPos = (mtx.row3 * (random 0.0 maxRadius)) + iniPos
	)
	
	-- Subdivide each spline segment in nDivisions
	fn subDivideSplineSegs sp nDivisions =
	(
		nSegs = numSegments sp 1
		for seg=1 to (nSegs*(1+nDivisions))-nDivisions by (1+nDivisions) do (
			segType = getSegmentType sp 1 seg
			if segType==#line then knType=#corner else knType=#smooth
			subdivideSegment sp 1 seg nDivisions
			knIndexArr = (for k=(seg+1) to (seg+nDivisions) collect k) as array
			for idx in knIndexArr do (setKnotType sp 1 idx knType)
		)
	)
	
	-- Draw a spline using pointsArr, applying a random offset (knMaxOffset) to each vertex
	fn drawSpline pointsArr knMaxOffset =
	(
		knType=#smooth
		cvType=#curve		
		ss = SplineShape pos:pointsArr[1]
		addNewSpline ss
		for p=1 to pointsArr.count do (
			if p==1 then knOffset=0 else knOffset = (radialPoint 0.0 knMaxOffset)
			addKnot ss 1 knType cvType (pointsArr[p] + knOffset)
		)
		updateShape ss
		ss
	)
	
	-- Draw splines
	fn drawSplines nSplines nLength lengthVar nKnots knRelative nChaos =
	(		
		spArr = #()
		for b=1 to nSplines do (
			pointsArr = #()
			spLength = abs(variation nLength lengthVar)
			knMaxOffset = (nChaos*spLength/100)/5
			knAmount = nKnots
			if knRelative then (
				knAmount = int(round_to (spLength*nKnots/nLength) 0)
				if knAmount<2 then knAmount=2
			)
			for p=1 to knAmount do (
				knZ = (p-1)*spLength/(knAmount-1)
				append pointsArr [0,0,knZ]
			)
			ns = drawSpline pointsArr knMaxOffset
			appendIfUnique spArr ns
		)
		spArr
	)
	
	-- Place objects onto srcObj's vertices, aligned thier normals
	fn placeObjsOnVertices srcObj objsArr =
	(
		srcObj = convertToMesh (copy srcObj)
		numVerts = getNumVerts srcObj
		vertsArr = #()
		allVertsIdxArr = (for n=1 to numVerts collect n) as array
		for v=1 to objsArr.count do (
			idx = random 1 allVertsIdxArr.count
			append vertsArr allVertsIdxArr[idx]
			deleteItem allVertsIdxArr idx
		)	
		-- Iterate through object's vertices
		objCount = 1
		for ix in vertsArr do (
			pt = objsArr[objCount]
			vertpos = getVert srcObj ix
			pt.pos = vertpos
			vertnormal = normalize (getNormal srcObj ix)
			pt.transform = translate (matrixFromNormal vertnormal) vertpos
			objCount+=1
		)
		delete srcObj
	)
	
	-- Attach shapes in spArr
	fn attachShapes spArr =
	(
		toSpline = spArr[1]
		spArr2 = (for s=2 to spArr.count collect spArr[s]) as array
		for s in spArr2 do (addAndWeld toSpline s -1)
		updateShape toSpline
		toSpline
	)
	
	pickbutton btnPickSourceObj "Pick Source Object" filter:mesh_filt width:160 height:24 align:#center offset:[0,12]
	spinner spnNSplines "No.of splines..........." range:[1,1000,1] type:#integer fieldwidth:40 align:#left offset:[0,6]
	spinner spnSplineLength "Spline Length.......... " range:[0,10000.0,10.0] type:#worldunits fieldwidth:40 align:#left offset:[0,2]
	spinner spnLengthVar "Length Variation (%)  " range:[0,500.0,0] type:#float fieldwidth:40 align:#left offset:[0,2]
	spinner spnKnots "No. of Knots..........  " range:[2,10,2] type:#integer fieldwidth:40 align:#left offset:[0,2]
	checkbox chbKnotsRel "Relative to spline length" checked:true align:#left offset:[10,-2]
	spinner spnChaos "Chaos (%)............  " range:[0,100.0,0] type:#float fieldwidth:40 align:#left offset:[0,2]	
	checkbox chbAttachAll "Attach all splines" checked:true align:#left offset:[0,2]
	button btnCreateSplines "Create Splines" width:160 height:30 align:#center offset:[0,10]	
	
	on RL_VerticesToSplines open do sourceObj = undefined
		
	on btnPickSourceObj picked obj do (
		sourceObj = obj
		btnPickSourceObj.text = obj.name
		totalVerts = (getPolygonCount sourceObj)[2]
		spnNSplines.range.y = totalVerts
		spnNSplines.value = totalVerts
	)
	
	on btnCreateSplines pressed do (
		if (isValidNode sourceObj) then (
			undo "Create Splines" on (
				spArr = drawSplines spnNSplines.value spnSplineLength.value spnLengthVar.value spnKnots.value chbKnotsRel.state spnChaos.value
				placeObjsOnVertices sourceObj spArr
				if chbAttachAll.state==true then (
					theSplines = attachShapes spArr
				) else (
					theSplines = spArr
				)
				select theSplines
			)
		) else (
			sourceObj = undefined
			btnPickSourceObj.text = "Pick Source Object"
			messageBox "Please pick source object first."
		)
	)
)

createDialog RL_VerticesToSplines 180 256 style:#(#style_toolwindow, #style_sysmenu) pos:[140,210] bgcolor:(color 84 101 120) fgcolor:(color 248 113 45)