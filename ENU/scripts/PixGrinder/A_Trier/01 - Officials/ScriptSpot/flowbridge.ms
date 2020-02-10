(
-- Helper functions

--Point-Line Projection : find the point on the line AB which is the projection of the point C:
fn pointLineProj pA pB pC = (
	local vAB=pB-pA
	local vAC=pC-pA
	local d=dot (normalize vAB) (normalize vAC)
	(pA+(vAB*(d*(length vAC/length vAB))))
)

--Point-Line Distance : the distance between the line AB and the point C:
fn pointLineDist pA pB pC = (
	local vAB=pB-pA
	local vAC=pC-pA
	(length (cross vAB vAC))/(length vAB)
)

--Point-Segment Distance : similiar to point-line but will check for a segment rather than a line
fn pointSegmentDist pA pB pC = 
(
	local vAB=pB-pA
	local vAC=pC-pA
	local vBC=pC-PB
	
	local c1=dot vAB vAC
	local c2=dot vAB vAB
	
	if c1 < 0 do
		return length vAC
	
	if c2 < c1 do
		return length vBC
	
	(length (cross vAB vAC))/(length vAB)
)

--Point-Line Inclusion : is this point on the line ?
fn isPointLine pA pB pC tol = (
	local vAB=pB-pA
	local vAC=pC-pA
	local d=1.0-abs(dot (normalize vAB) (normalize vAC))
	if d<=tol then true else false
)

--Line-Line Intersection : intersection of two lines AB and CD:
fn lineLineIntersect pA pB pC pD = (
	local a=pB-pA
	local b=pD-pC
	local c=pC-pA
	local cross1 = cross a b
	local cross2 = cross c b
	pA + ( a*( (dot cross2 cross1)/((length cross1)^2) ) )
)

--xor function
fn xor b1 b2 = (not (b1 and b2)) and (b1 or b2)

--Point-Seg Project
fn pointSegmentProj pA pB pC = (
	local lineProj = pointLineProj pA pB pC 
	local XPoint = lineLineIntersect pA pB pC lineProj
	local segLen = distance pA pB
	if ((distance XPoint pA < segLen) and (distance XPoint pB < segLen)) then return XPoint
	/*
	if (xor (distance XPoint pA < segLen)  (distance XPoint pB < segLen)) then
	(
		if (distance XPoint pA < distance XPoint pB) then return pA else return pB
	)
	*/
	if (distance XPoint pA < distance XPoint pB) then return pA else return pB
)

--Get the Open edge verts from an epoly
fn OpenEdgeVerts epoly = (
	local oe = polyop.getOpenEdges epoly
	openVerts = #{}
	for edge in (oe as array )do
	(
		openverts = openverts + polyop.getVertsUsingEdge epoly edge
	)
	openverts
)

--Find the closest open edge from a epoly
fn ClosestOpenEdge epoly pnt = (
	local oe = polyop.getOpenEdges epoly as array
	local closestEdge = 0
	local closestEdgeDist = 10000.0
	for edge in oe do
	( 
		local edgeverts = polyop.getVertsUsingEdge epoly edge as array
		edgeDist = pointSegmentDist (polyop.getVert epoly edgeverts[1]) (polyop.getVert epoly edgeverts[2]) pnt 
		if edgeDist < closestEdgeDist then
		(
			closestEdgeDist = edgeDist
			closestEdge = edge
		)
	)
	return closestEdge
)



--Find the closest point to the closest open edge
fn ClosestPointOnOpenEdge epoly pnt = (
	local closestOE = ClosestOpenEdge epoly pnt
	local edgeverts = polyop.getVertsUsingEdge epoly closestOE as array
	return closestPoint = pointSegmentProj (polyop.getVert epoly edgeverts[1]) (polyop.getVert epoly edgeverts[2]) pnt 
)

-- Find Average Location from an Array of points
fn PointAverage Points = (
	sum = [0,0,0]
	for p in points do sum = sum + p
	sum / Points.count
)


--Relax points compared to eachother
fn PointRelax Points fixedPoints:#() tolerance:4 = (
	movedpoints = #()
	allpoints = join fixedPoints Points
	
	for pnt in Points do (
		neighbors = for p in allpoints where distance pnt p < tolerance collect p
		direction = [0,0,0]
		for n in neighbors do direction = direction + (pnt - n)
		newloc = (pnt + (direction / neighbors.count))
		append movedpoints newloc
	)
	
	return movedpoints
)

-- get the distnace from the bbox center of a point in the 
fn ratioFromCenter obj vertNum = (
	local center  = (obj.max + obj.min)/2
	local radius = (length (obj.max - obj.min)/2)
	ratio = (distance (polyop.getvert obj vertNum) center)/radius
)

)


macroscript FlowBridge category:"jpScripts" tooltip:"FlowBridge" 
(
undo on 

if flowBridgeSections == undefined then global flowBridgeSections = 12
if flowBridgeBezierStrength== undefined then global flowBridgeBezierStrength = 0.5
	
rollout fl_dialog "Flow Bridge Parameters" 
(
	--label lbl_speed "Flow Bridge Bezier Strength" offset:[0,10]
	spinner fbspinner_bez "Bezier:" range:[0.01,4.0,0.05] type:#float
	on fbspinner_bez changed val do flowBridgeBezierStrength = val
		
	spinner fbspinner "Segments:" range:[0,100,1] type:#integer
	on fbspinner changed val do flowBridgeSections = val
)


if keyboard.controlPressed == true then (
	createDialog fl_dialog pos:[100,100] style:#(#style_titlebar, #style_border, #style_sysmenu, #style_minimizebox)  modal:true
)

(
epoly = $
selectededges = epoly.getselection #edge
ss = SplineShape ()
addNewSpline ss
addNewSpline ss

faces = for edge in (selectededges as array) collect ((polyop.getfacesusingedge epoly edge) as array)[1]
facesNorm=  normalize (( (polyop.getfacenormal epoly faces[1]) + (polyop.getfacenormal epoly faces[2]) ) /2)

facecenters = for f in faces as array collect polyop.getfacecenter epoly f
facesdist = distance facecenters[1] facecenters[2]

edgecount = 1
edgedirs = for i in selectededges as array do
(
	face = ((polyop.getfacesusingedge epoly i) as array)[1]
	verts = (polyop.getEdgeVerts epoly i) as array
	facenorm = polyop.getfacenormal epoly face
	facecenter = polyop.getfacecenter epoly face
	pnt1 = polyop.getvert epoly verts[1]
	pnt2 = polyop.getvert epoly verts[2]
	pnt1vec = (pnt1 - facecenter)
	pnt2vec =  (pnt2 - facecenter)
	edgecenter = (pnt1 + pnt2)/2
	edgedir = (edgecenter - facecenter) 
	edgedir = (normalize edgedir) * (facesdist * flowBridgeBezierStrength) 
	crsCheck = ( length (facesNorm  - (normalize (cross pnt1vec edgedir))) )

	if edgecount == 2 then (
		if crsCheck < 1.414 then (
			temp = pnt1
			pnt1 = pnt2
			pnt2 = temp
		)
	)
	
	if edgecount == 1 then (
	addKnot ss 1 #bezier #curve pnt1 (pnt1 - edgedir) (pnt1 + edgedir)
	addKnot ss 2 #bezier #curve pnt2 (pnt2 - edgedir) (pnt2 + edgedir)
	) else (
	addKnot ss 1 #bezier #curve pnt1 (pnt1 + edgedir) (pnt1 - edgedir)
	addKnot ss 2 #bezier #curve pnt2 (pnt2 + edgedir) (pnt2 - edgedir)
	)
	edgecount = 2
)

updateshape ss 

ns = Normalize_Spline2 ()
ns.NormalizeType = 1
ns.UseStraightSegments = on
ns.numKnots = flowBridgeSections
cs = CrossSection ()
surf = surface ()
surf.steps = 0

addmodifier ss ns
addmodifier ss cs
addmodifier ss surf
converttopoly ss 

polyop.attach epoly ss
subobjectLevel = 2
)
)