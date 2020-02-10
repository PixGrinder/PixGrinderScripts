 (

try
(

	gb = undefined -- global base object
	tapeObject = undefined -- global tape object
	
try(destroyDialog SG)catch()
	rollout SG "Glue" width:160 height:170
	(
		pickbutton pickButton "> Pick Base Object <" pos:[2,3] width:113 height:24
		--groupBox grp1 "Projection Axis:" pos:[3,30] width:130 height:56
		radioButtons radioAxis "Projection Axis:" default:6 pos:[2,30] width:117 height:32 labels:#("+x",  "+y", "+z", "-x","-y", "-z", "eye", "ray") columns:3
		pickbutton pickTape "tape" pos:[77,78] width:38 height:15 enabled:false
		--label lbl1 "Ray:" pos:[25,78] 
		checkbox checkSurfaceNormal "Surf. normal align" pos:[2,95] width:144 height:16
		checkbox checkKnots "Glue spline knots" pos:[2,110] width:144 height:16
		checkbox checkVertices "Glue mesh vertices" pos:[2,125] width:144 height:16
		button buttonGlue "GLUE!" pos:[2,142] width:113 height:30
	
		on radioAxis changed a do
		(
			if a ==8 then pickTape.enabled = true else pickTape.enabled = false
		)
		on pickButton picked obj do
		(
			pickButton.caption = obj.name
			gb = obj
		)
		on pickTape picked obj do
		(
			if (classof obj) == Tape then
			(
				pickTape.caption = obj.name
				tapeObject = obj
			)
			else
			(
				messagebox "It must be a Tape object - it will be used as ray to define direction"
				
			)
		)
		
		on buttonGlue pressed  do
		(
			if gb == undefined then (messagebox "First select an object to glue on") else
			(
		
				GlueSplineKnots = checkKnots.state
				GlueVertices = checkVertices.state
				NormalAlign = checkSurfaceNormal.state
				
				if radioAxis.state == 1 then Axiz = [1,0,0]
				if radioAxis.state == 2 then Axiz = [0,1,0]
				if radioAxis.state == 3 then Axiz = [0,0,1]
				if radioAxis.state == 4 then Axiz = [-1,0,0]
				if radioAxis.state == 5 then Axiz = [0,-1,0]
				if radioAxis.state == 6 then Axiz = [0,0,-1]
				if radioAxis.state == 7 then Axiz = (-(Inverse(getViewTM())).row3)
				if radioAxis.state == 8 then 
				(
					if tapeObject != undefined then 
					(
						Axiz = (tapeObject as ray).dir
					)
					else 
					(
						messagebox "Some troubles with Ray. Pick a Tape object again"
						Axiz = [1,0,0]
					)
				)
				
				BaseObject = gb
				
				----------- converting base object to mesh
				addModifier BaseObject (edit_mesh())
				
				--fn CreateLine a b =
				--(
				--	y = SplineShape()
				--	addNewSpline y
				--	addKnot y 1 #corner #line a a a
				--	addKnot y 1 #corner #line b b b
				--)
		
				undo on
				(
					for GluedObject in selection do
					(
						
						-------------------- spline knots ------------------------
						if (classof GluedObject == SplineShape or classof GluedObject == Line) and GlueSplineKnots == true then  ----- processing splines
						(
							for s = 1 to numSplines GluedObject do
							(
								for v = 1 to numKnots GluedObject s do
								(
									setKnotType GluedObject s v #corner
									IntersectedRay = intersectRay BaseObject (ray (getKnotPoint GluedObject s v) Axiz)
									------------ processing perspective camera or view
									if radioAxis.state == 7  then	
									(
										
										vp = viewport.getType()
										if vp == #view_persp_user then
										(
											campos = (Inverse(getViewTM())).row4
											r = (getKnotPoint GluedObject s v) - campos
											IntersectedRay = intersectRay BaseObject (ray campos r)
										)
										if vp == #view_camera then
										(
											campos = (viewport.getCamera()).pos
											r = (getKnotPoint GluedObject s v) - campos
											IntersectedRay = intersectRay BaseObject (ray campos r)
										)
									)
									if IntersectedRay != undefined then setKnotPoint GluedObject s v IntersectedRay.pos
								)
							)
							updateShape(GluedObject)
						)
						
						
						else	
						(
							------------------------- mesh vertices ---------------------------------
							if  GlueVertices == true then----- processing vertices
							try
							(
								(
									convertTo GluedObject PolyMeshObject
									for v in GluedObject.verts do
									(
										IntersectedRay = intersectRay BaseObject (ray v.pos Axiz)
										if radioAxis.state == 7  then	---- processing perspective camera
										(
											
											vp = viewport.getType()
											if vp == #view_persp_user then
											(
												campos = (Inverse(getViewTM())).row4
												r = v.pos - campos
												IntersectedRay = intersectRay BaseObject (ray campos r)
											)
											if vp == #view_camera then
											(
												campos = (viewport.getCamera()).pos
												r = v.pos - campos
												IntersectedRay = intersectRay BaseObject (ray campos r)
											)
										)
										
										if IntersectedRay != undefined then v.pos = IntersectedRay.pos
									)
								)
							)
							catch(messagebox("error processing vertices!"))
							else 
							(
								
								----------------------------- objects ------------------------
								
								IntersectedRay = intersectRay BaseObject (ray GluedObject.pos Axiz)
								if radioAxis.state == 7  then	---- processing perspective camera
								(
									
									vp = viewport.getType()
									if vp == #view_persp_user then
									(
										campos = (Inverse(getViewTM())).row4
										r = GluedObject.pos - campos
										IntersectedRay = intersectRay BaseObject (ray campos r)
									)
									if vp == #view_camera then
									(
										campos = (viewport.getCamera()).pos
										r = GluedObject.pos - campos
										IntersectedRay = intersectRay BaseObject (ray campos r)
									)
								)
								if IntersectedRay != undefined then
								(
									GluedObject.pos = IntersectedRay.pos
									if NormalAlign == true then	GluedObject.dir = IntersectedRay.dir
								)
							)
						)
					)
				
				) -- end undo
				
				deleteModifier BaseObject 1
					
			) -- end object selected check
		) -- end button pressed
	) -- end rollout
	
	
createDialog SG 180 176 pos:[140,210] -- bgcolor:(color 84 101 120)  fgcolor:(color 248 113 45)
	
) -- end try
catch
(
)
)