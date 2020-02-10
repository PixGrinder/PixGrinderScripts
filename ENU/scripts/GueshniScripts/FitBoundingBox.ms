(
local obj
 
fn Jacobi  n &a &d &v  = 
( 
	local i, j, p, q, rot, sm, g, theta, t, tresh, c, s, tau, h
	local z=#()
	local b=#()
	for i =1 to n do
	(
		z[i] =0.0
		b[i] = a[i][i]
		d[i] = a[i][i]
		for j=1 to n do
		 if (i == j) then v[i][j] = 1.0
		 	       else v[i][j] = 0.0
	)

	rot =0
	for i =1 to 50 do
	(
		sm = 0.0
		for p = 1 to n-1 do
		 for q=p+1 to n do sm += abs( a[p][q] )
		 
		if ( sm == 0 ) then exit()
		tresh = case ( i<4 ) of
		(
			true: 0.2*sm/(n*n)
			false: 0.0
		)
		for p =1 to n-1 do
		(
			for q = p+1 to n do 
			(
				g = 1e12 * abs ( a[p][q] )
				if ((i>4) and ( abs(d[p])>g ) and ( abs(d[q])>g )) then (a[p][q] = 0.0)
				else 
				if ( abs( a[p][q] ) > tresh ) then
				(
					theta = 0.5 * ( d[q] - d[p] ) / a[p][q]
					t = 1.0 / ( abs(theta) + sqrt(1.0+theta*theta) )
					if ( theta < 0 ) then t = - t
					c = 1.0 / sqrt ( 1.0 + t*t )
                    			s = t * c
                    			tau = s / ( 1.0 + c )
                    			h = t * a[p][q]
					z[p] -= h
					z[q] += h
					d[p] -= h
                    			d[q] += h
                    			a[p][q] = 0.0
					for j=1 to p-1 do   
					(
						g = a[j][p]
						h = a[j][q]
						a[j][p] = g - s * ( h + g * tau )
						a[j][q] = h + s * ( g - h * tau )
					)
					for j=p+1 to q-1 do
					(
						g = a[p][j]
						h = a[j][q]
						a[p][j] = g - s * ( h + g * tau )
						a[j][q] = h + s * ( g - h * tau )
					)
					for j=q+1 to n do
					(
						g = a[p][j]
						h = a[q][j]
						a[p][j] = g - s * ( h + g * tau )
						a[q][j] = h + s * ( g - h * tau )
					)
					for j=1 to n do
					(
						g = v[j][p]
						h = v[j][q]
						v[j][p] = g - s * ( h + g * tau )
						v[j][q] = h + s * ( g - h * tau )
					)
					rot += 1
				)				
			)
		)
		for p =1 to n do
		(
			b[p] += z[p] 
			d[p] = b[p]			
			z[p] = 0.0
		)
	)--for i =1 to 50
	return rot
)--fn Jacobi


fn GetBestFitVectors &v &dir &norm  =
(
	local n = v.count
	if (n<2) then return false
	local point = v[1]
	for i = 2 to n do (point += v[i])
	point /= n
	local xx, xy, xz, yy, yz, zz
	xx = xy = xz = yy = yz = zz = 0.0
	for i = 1 to n do
	(
		local u = v[i] - point
		xx += u.x * u.x
		xy += u.x * u.y
		xz += u.x * u.z
		yy += u.y * u.y
		yz += u.y * u.z
		zz += u.z * u.z
	)
	
	--Symmetric Matrix
	local a = #([ xx, xy, xz ],
		 	 [ xy, yy, yz ],
		 	 [ xz, yz, zz ])
		 
	--Eigenvalue
	local d = #(0.0, 0.0, 0.0)
	
	--Eigenvectors	 
	local u = #([ 0, 0, 0 ],
		 	 [ 0, 0, 0 ],
		 	 [ 0, 0, 0 ])

	--finding the Eigenvalue and Eigenvectors
	jacobi  3 &a &d &u

	-- calc direction ray
	if ( d[1] >= d[2] ) then
	(
		if ( d[1] >= d[3] ) then (dir = [ u[1].x, u[2].x, u[3].x ])
        				 	else  (dir = [ u[1].z, u[2].z, u[3].z ])
	)
	else
	(
		if ( d[2] >= d[3] ) then (dir = [ u[1].y, u[2].y, u[3].y ])
					 else	 (dir = [ u[1].z, u[2].z, u[3].z ])
	)
	-- calc normal fit plane
	if ( d[1] <= d[2] ) then 
    	(
        		if ( d[1] <= d[3] ) then norm = [ u[1].x, u[2].x, u[3].x ]
        					else  norm = [ u[1].z, u[2].z, u[3].z ]
    	)
    	else
    	(
        		if ( d[2] <= d[3] ) then norm = [ u[1].y, u[2].y, u[3].y ]
        					else  norm = [ u[1].z, u[2].z, u[3].z ]
    	)
	return true
)--fn GetBestFitVectors

fn calcBox &arr  &dir &norm =
(
	local upVector = normalize ( cross dir norm )
	local T = matrix3 upVector norm dir [0,0,0]
	local iT = inverse T
	for i=1 to arr.count do arr[i] = arr[i] * iT

	local qmin = copy arr[1]
	local qmax = copy arr[1]
	
	for i in arr do (
		for j=1 to 3 do (
			if i[j] < qmin[j] do qmin[j]=i[j]
			if i[j] > qmax[j] do qmax[j]=i[j]
		)
	)
	
	local _diag = qmax-qmin
	local l = abs _diag.x
	local w = abs _diag.y
	local h = abs _diag.z
	local b = box length:w width:l height:h
	b.pivot = b.center
	b.transform = T
	b.pos = (qmax+qmin)/2.0 * T
	b.wirecolor = color 200 0 0 
	obj.parent = b
	tm_b = b.transform
	b.transform *= (inverse b.transform)
	resetxform obj
	collapsestack obj
	b.transform = tm_b
	delete b
)--fn calcBox

fn getVertsPosPoly node &arV &cloud_points =
(
	cloud_points = #()
	if (arV as array).count <=3 then
		for i=1 to node.NumVerts do append cloud_points (polyOp.getVert node i)
	else 
		for i in arV do append cloud_points (polyOp.getVert node i)	
)--	fn getVertsPosPoly

fn getVertsPosMesh node &arV &cloud_points = 
(
	cloud_points = #()
	if (arV as array).count <=3 then
		for i=1 to node.NumVerts do append cloud_points (getVert node i)
	else 
		for i in arV do append cloud_points (getVert node i)	
)--	fn getVertsPosMesh

undo off
(
	max modify mode
	obj = $
	-- get cloud points from object subselection
	case classOf(obj) of 
	(
		Editable_Poly:
		(
		   arrV = case subObjectLevel of
		  		 (
					1: getVertSelection obj
					2: polyOp.getVertsUsingEdge obj (getEdgeSelection obj)
					3: polyOp.getVertsUsingEdge obj (getEdgeSelection obj)
					4: polyOp.getVertsUsingFace obj (getFaceSelection obj)
					5: polyOp.getVertsUsingFace obj (getFaceSelection obj)
					default: #{}
				   )
		  getVertsPosPoly obj &arrV &cloud_points
		)
		Editable_mesh: 
		(
		   arrV = case subObjectLevel of
		  		 (
					1: getVertSelection obj
					2: meshOp.getVertsUsingEdge obj (getEdgeSelection obj)
					3: meshOp.getVertsUsingFace obj (getFaceSelection obj)
					4: meshOp.getVertsUsingFace obj (getFaceSelection obj)
					5: meshOp.getVertsUsingFace obj (getFaceSelection obj)
					default: #{}
				   )
		  getVertsPosMesh obj &arrV &cloud_points
		)
		
	)--case classObj
	
	-- calc fit dir and normal fit plane
	getBestFitVectors &cloud_points &dir &norm
)--undo off

	-- calc and draw box
	calcBox &cloud_points &dir &norm
)

-- macroScript FitBoundingBox Category:"Vitus Scripts" Tooltip:"Fit Bounding Box" icon: #("UVWUnwrapModes",5)
-- (
-- suspendediting()
-- for obj in selection as array do 
-- 	(
-- 	select obj
-- 	macros.run "metaMacroFn" "fitbb"
-- 	addmodifier $ (Normalmodifier flip: on); converttopoly $
-- 	)
-- resumeediting()
-- CompleteRedraw()
-- )