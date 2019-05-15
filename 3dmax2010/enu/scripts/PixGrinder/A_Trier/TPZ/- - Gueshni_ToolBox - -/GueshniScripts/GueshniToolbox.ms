-- macroScript GueshniToolBox category:"- Gueshni -" Icon:#("g9_gueshnitoolbox", 1) tooltip:"Gueshni Toolbox"
 (

-- bitmap the_bmp fileName:"ImageBG.jpg"

rollout imaj ""
(
bitmap the_bmp fileName:"ImageBG.jpg"
	
)								-- end rollout IMAGE


rollout systm "System"
(
button btn1 "" width:24 height:24 pos:[10,10] across:1  images:#("g9_SystemIcons.jpg", undefined, 20, 1, 1,1,1) tooltip:"Snap Windows"
button btn2 "" width:24 height:24 pos:[39,10] images:#("g9_SystemIcons.jpg", undefined, 20, 2, 2,1,1) tooltip:"Remove Missing Plugins"
button btn3 "" width:24 height:24 pos:[68,10] images:#("g9_SystemIcons.jpg", undefined, 20, 3, 3,1,1) tooltip:"Remove Empty Layers"
button btn4 "" width:24 height:24 pos:[97,10] images:#("g9_SystemIcons.jpg", undefined, 20, 4, 4,1,1) tooltip:"BBox Maker"
button btn5 "" width:24 height:24 pos:[126,10] images:#("g9_SystemIcons.jpg", undefined, 20, 5, 5,1,1) tooltip:"Object Dimension"
button btn6 "" width:24 height:24 pos:[155,10] images:#("g9_SystemIcons.jpg", undefined, 20, 6, 6,1,1) tooltip:"Calculator Launcher"
button btn7 "" width:24 height:24 pos:[184,10] images:#("g9_SystemIcons.jpg", undefined, 20, 7, 7,1,1) tooltip:"Lock / Unlock"
button btn8 "" width:24 height:24 pos:[213,10] images:#("g9_SystemIcons.jpg", undefined, 20, 8, 8,1,1) tooltip:"Copy Object"
button btn9 "" width:24 height:24 pos:[242,10] images:#("g9_SystemIcons.jpg", undefined, 20, 9, 9,1,1) tooltip:"Paste Object"
button btn10 "" width:24 height:24 pos:[271,10] images:#("g9_SystemIcons.jpg", undefined, 20, 10, 10,1,1) tooltip:"Reset Spline/Mesh Transform"

	

on btn1 pressed do
	(
	macros.run "- Gueshni -" "SnapWindows"
	)	

on btn2 pressed do
	(
	macros.run "- Gueshni -" "RemoveMissingPlugins"
	)	

on btn3 pressed do
	(
	macros.run "- Gueshni -" "RemoveEmptyLayers"
	)	

on btn4 pressed do
	(
	macros.run "- Gueshni -" "BBoxMaker"
	)	

on btn5 pressed do
	(
	macros.run "- Gueshni -" "ObjectDimension"
	)	

on btn6 pressed do
	(
	macros.run "- Gueshni -" "CalculatorLauncher"
	)	

on btn7 pressed do
	(
	macros.run "- Gueshni -" "LockUnlock"
	)	

on btn8 pressed do
	(
	macros.run "- Gueshni -" "CopyObject"
	)	

 on btn9 pressed do
	 (
	 macros.run "- Gueshni -" "PasteObject"
	 )	

on btn10 pressed do
	(
	macros.run "- Gueshni -" "ResetTransform"
	)

	
)								-- end rollout SYSTEM


rollout ui "UI"
(
button btn1 "" width:24 height:24 pos:[10,10] across:1  images:#("g9_UIIcons.jpg", undefined, 20, 1, 1,1,1) tooltip:"Align Viewport to Face"
button btn2 "" width:24 height:24 pos:[39,10] images:#("g9_UIIcons.jpg", undefined, 20, 2, 2,1,1) tooltip:"Align Viewport from 3 Points"
button btn3 "" width:24 height:24 pos:[68,10] images:#("g9_UIIcons.jpg", undefined, 20, 3, 3,1,1) tooltip:"Backface Cull"
button btn4 "" width:24 height:24 pos:[97,10] images:#("g9_UIIcons.jpg", undefined, 20, 4, 4,1,1) tooltip:"Vertex Ticks"
button btn5 "" width:24 height:24 pos:[126,10] images:#("g9_UIIcons.jpg", undefined, 20, 5, 5,1,1) tooltip:"Display Object Color"
button btn6 "" width:24 height:24 pos:[155,10] images:#("g9_UIIcons.jpg", undefined, 20, 6, 6,1,1) tooltip:"Random Wirecolor"
button btn7 "" width:24 height:24 pos:[184,10] images:#("g9_UIIcons.jpg", undefined, 20, 7, 7,1,1) tooltip:"Wirecolor by Layer"	
button btn8 "" width:24 height:24 pos:[213,10] images:#("g9_UIIcons.jpg", undefined, 20, 8, 8,1,1) tooltip:"Palette Loader"




on btn1 pressed do
	(
	macros.run "- Gueshni -" "AlignViewportToFace"
	)	

on btn2 pressed do
	(
	macros.run "- Gueshni -" "AlignViewportFrom3points"
	)	

on btn3 pressed do
	(
	macros.run "- Gueshni -" "BackFaceCull"
	)	

on btn4 pressed do
	(
	macros.run "- Gueshni -" "VertexTicks"
	)	

on btn5 pressed do
	(
	macros.run "- Gueshni -" "DisplayObjectColor"
	)	

on btn6 pressed do
	(
	macros.run "- Gueshni -" "RandomWirecolor"
	)	

on btn7 pressed do
	(
	macros.run "- Gueshni -" "WirecolorByLayer"
	)	

on btn8 pressed do
	(
	macros.run "- Gueshni -" "PaletteLoader"
	)	

)								-- end rollout UI



rollout pivo "Pivot"
(
button btn1 "" width:24 height:24 pos:[10,10] across:1  images:#("g9_PivotIcons.jpg", undefined, 20, 1, 1,1,1) tooltip:"Center Pivot" 												
button btn2 "" width:24 height:24 pos:[39,10] images:#("g9_PivotIcons.jpg", undefined, 20, 2, 2,1,1) tooltip:"Align Pivot to Minimum"										
button btn3 "" width:24 height:24 pos:[68,10] images:#("g9_PivotIcons.jpg", undefined, 20, 3, 3,1,1) tooltip:"Easy Pivot"	
button btn4 "" width:24 height:24 pos:[97,10] images:#("g9_PivotIcons.jpg", undefined, 20, 4, 4,1,1) tooltip:"Align Pivot to Direction"	
button btn5 "" width:24 height:24 pos:[126,10] images:#("g9_PivotIcons.jpg", undefined, 20, 5, 5,1,1) tooltip:"Fit Bounding Box"	




on btn1 pressed do
	(
	macros.run "- Gueshni -" "CenterPivot"
	)	

on btn2 pressed do
	(
	macros.run "- Gueshni -" "AlignPivotToMin"
	)	

on btn3 pressed do
	(
	macros.run "- Gueshni -" "EasyPivot"
	)	

on btn4 pressed do
	(
	macros.run "- Gueshni -" "AlignPivot2Direction"
	)	

on btn5 pressed do
	(
	macros.run "- Gueshni -" "FitBoundingBox"
	)	

)								-- end rollout PIVOT



rollout clection "Selection"
(
button btn1 "" width:24 height:24 pos:[10,10] across:1  images:#("g9_SelectionIcons.jpg", undefined, 20, 1, 1,1,1) tooltip:"Select by Pair" 															
button btn2 "" width:24 height:24 pos:[39,10] images:#("g9_SelectionIcons.jpg", undefined, 20, 2, 2,1,1) tooltip:"Random Select"																						
button btn3 "" width:24 height:24 pos:[68,10] images:#("g9_SelectionIcons.jpg", undefined, 20, 3, 3,1,1) tooltip:"Select Object with No Material"								
button btn4 "" width:24 height:24 pos:[97,10] images:#("g9_SelectionIcons.jpg", undefined, 20, 4, 4,1,1) tooltip:"Random Face Select"															
button btn5 "" width:24 height:24 pos:[126,10] images:#("g9_SelectionIcons.jpg", undefined, 20, 5, 5,1,1) tooltip:"Select Empty Objects"												




on btn1 pressed do
	(
	macros.run "- Gueshni -" "SelectByPair"
	)	

on btn2 pressed do
	(
	macros.run "- Gueshni -" "RandomSelect"
	)	

on btn3 pressed do
	(
	macros.run "- Gueshni -" "SelectNoMaterial"
	)	

on btn4 pressed do
	(
	macros.run "- Gueshni -" "RandomFaceSelect"
	)	

on btn5 pressed do
	(
	macros.run "- Gueshni -" "SelectEmptyObject"
	)	

)								-- end rollout SELECTION



rollout kreatobj "Create Object"
(
button btn1 "" width:24 height:24 pos:[10,10] across:1  images:#("g9_CreateObjectIcons.jpg", undefined, 20, 1, 1,1,1) tooltip:"Create Box"
button btn2 "" width:24 height:24 pos:[39,10] across:1  images:#("g9_CreateObjectIcons.jpg", undefined, 20, 2, 2,1,1) tooltip:"Create Sphere" 
button btn3 "" width:24 height:24 pos:[68,10] across:1  images:#("g9_CreateObjectIcons.jpg", undefined, 20, 3, 3,1,1) tooltip:"Create Cylinder" 
button btn4 "" width:24 height:24 pos:[97,10] across:1  images:#("g9_CreateObjectIcons.jpg", undefined, 20, 4, 4,1,1) tooltip:"Create Torus" 
button btn5 "" width:24 height:24 pos:[126,10] across:1  images:#("g9_CreateObjectIcons.jpg", undefined, 20, 5, 5,1,1) tooltip:"Create Cone" 
button btn6 "" width:24 height:24 pos:[155,10] across:1  images:#("g9_CreateObjectIcons.jpg", undefined, 20, 6, 6,1,1) tooltip:"Create GeoSphere" 
button btn7 "" width:24 height:24 pos:[184,10] across:1  images:#("g9_CreateObjectIcons.jpg", undefined, 20, 7, 7,1,1) tooltip:"Create Tube" 
button btn8 "" width:24 height:24 pos:[213,10] across:1  images:#("g9_CreateObjectIcons.jpg", undefined, 20, 8, 8,1,1) tooltip:"Create Pyramid" 
button btn9 "" width:24 height:24 pos:[242,10] across:1  images:#("g9_CreateObjectIcons.jpg", undefined, 20, 9, 9,1,1) tooltip:"Create Plane" 
button btn10 "" width:24 height:24 pos:[271,10] across:1  images:#("g9_CreateObjectIcons.jpg", undefined, 20, 10, 10,1,1) tooltip:"Create Hedra" 

button btn11 "" width:24 height:24 pos:[10,39] across:1  images:#("g9_CreateObjectIcons.jpg", undefined, 20, 11, 11,1,1) tooltip:"Create Chamfer Box"
button btn12 "" width:24 height:24 pos:[39,39] across:1  images:#("g9_CreateObjectIcons.jpg", undefined, 20, 12, 12,1,1) tooltip:"Create Oil Tank" 
button btn13 "" width:24 height:24 pos:[68,39] across:1  images:#("g9_CreateObjectIcons.jpg", undefined, 20, 17, 17,1,1) tooltip:"Create Chamfer Cylinder" 
button btn14 "" width:24 height:24 pos:[97,39] across:1  images:#("g9_CreateObjectIcons.jpg", undefined, 20, 13, 13,1,1) tooltip:"Create Spindle" 
button btn15 "" width:24 height:24 pos:[126,39] across:1  images:#("g9_CreateObjectIcons.jpg", undefined, 20, 14, 14,1,1) tooltip:"Create Gengon" 
button btn16 "" width:24 height:24 pos:[155,39] across:1  images:#("g9_CreateObjectIcons.jpg", undefined, 20, 15, 15,1,1) tooltip:"Create RingWave" 
button btn17 "" width:24 height:24 pos:[184,39] across:1  images:#("g9_CreateObjectIcons.jpg", undefined, 20, 16, 16,1,1) tooltip:"Create Torus Knot" 
button btn18 "" width:24 height:24 pos:[213,39] across:1  images:#("g9_CreateObjectIcons.jpg", undefined, 20, 18, 18,1,1) tooltip:"Create Capsule" 


on btn1 pressed do
	(
	StartObjectCreation Box
	)	

on btn2 pressed do
	(
	StartObjectCreation Sphere
	)	

on btn3 pressed do
	(
	StartObjectCreation Cylinder
	)	

on btn4 pressed do
	(
	StartObjectCreation Torus
	)	

on btn5 pressed do
	(
	StartObjectCreation Cone
	)	

on btn6 pressed do
	(
	StartObjectCreation GeoSphere
	)	

on btn7 pressed do
	(
	StartObjectCreation Tube
	)	

on btn8 pressed do
	(
	StartObjectCreation Pyramid
	)	

on btn9 pressed do
	(
	StartObjectCreation Plane
	)	

on btn10 pressed do
	(
	StartObjectCreation Hedra
	)	

on btn11 pressed do
	(
	StartObjectCreation ChamferBox
	)	

on btn12 pressed do
	(
	StartObjectCreation Oiltank
	)	

on btn13 pressed do
	(
	StartObjectCreation ChamferCyl
	)	

on btn14 pressed do
	(
	StartObjectCreation Spindle
	)	

on btn15 pressed do
	(
	StartObjectCreation Gengon
	)	

on btn16 pressed do
	(
	StartObjectCreation RingWave
	)	

on btn17 pressed do
	(
	StartObjectCreation Torus_Knot
	)	

on btn18 pressed do
	(
	StartObjectCreation Capsule
	)	

)								-- end rollout CREATE OBJECT



rollout kreatspline "Create Spline"
(
button btn1 "" width:24 height:24 pos:[10,10] across:1  images:#("g9_CreateSplineIcons.jpg", undefined, 20, 1, 1,1,1) tooltip:"Create Line"
button btn2 "" width:24 height:24 pos:[39,10] across:1  images:#("g9_CreateSplineIcons.jpg", undefined, 20, 2, 2,1,1) tooltip:"Create Circle" 
button btn3 "" width:24 height:24 pos:[68,10] across:1  images:#("g9_CreateSplineIcons.jpg", undefined, 20, 3, 3,1,1) tooltip:"Create Arc" 
button btn4 "" width:24 height:24 pos:[97,10] across:1  images:#("g9_CreateSplineIcons.jpg", undefined, 20, 4, 4,1,1) tooltip:"Create Ngon" 
button btn5 "" width:24 height:24 pos:[126,10] across:1  images:#("g9_CreateSplineIcons.jpg", undefined, 20, 5, 5,1,1) tooltip:"Create Text" 
button btn6 "" width:24 height:24 pos:[155,10] across:1  images:#("g9_CreateSplineIcons.jpg", undefined, 20, 6, 6,1,1) tooltip:"Create Rectangle" 
button btn7 "" width:24 height:24 pos:[184,10] across:1  images:#("g9_CreateSplineIcons.jpg", undefined, 20, 7, 7,1,1) tooltip:"Create Ellipse" 
button btn8 "" width:24 height:24 pos:[213,10] across:1  images:#("g9_CreateSplineIcons.jpg", undefined, 20, 8, 8,1,1) tooltip:"Create Donut" 
button btn9 "" width:24 height:24 pos:[242,10] across:1  images:#("g9_CreateSplineIcons.jpg", undefined, 20, 9, 9,1,1) tooltip:"Create Star" 
button btn10 "" width:24 height:24 pos:[271,10] across:1  images:#("g9_CreateSplineIcons.jpg", undefined, 20, 10, 10,1,1) tooltip:"Create Helix"

-- button btn11 "" width:24 height:24 pos:[10,39] across:1  images:#("g9_CreateSplineIcons.jpg", undefined, 20, 11, 11,1,1) tooltip:"Create Oriented Rectangle"


on btn1 pressed do
	(
	StartObjectCreation Line
	)	

on btn2 pressed do
	(
	StartObjectCreation Circle
	)	

on btn3 pressed do
	(
	StartObjectCreation Arc
	)	

on btn4 pressed do
	(
	StartObjectCreation Ngon
	)	

on btn5 pressed do
	(
	StartObjectCreation Text
	)	

on btn6 pressed do
	(
	StartObjectCreation Rectangle
	)	

on btn7 pressed do
	(
	StartObjectCreation Ellipse
	)	

on btn8 pressed do
	(
	StartObjectCreation Donut
	)	

on btn9 pressed do
	(
	StartObjectCreation Star
	)	

on btn10 pressed do
	(
	StartObjectCreation Helix
	)	

on btn11 pressed do
	(
	macros.run "- Gueshni -" "OrientedRectangle"
	)	

)								-- end rollout CREATE SPLINE



rollout cpdobject "Compound Object"
(
button btn1 "" width:24 height:24 pos:[10,10] across:1  images:#("g9_CompoundObjectIcons.jpg", undefined, 20, 1, 1,1,1) tooltip:"Morph"
button btn2 "" width:24 height:24 pos:[39,10] across:1  images:#("g9_CompoundObjectIcons.jpg", undefined, 20, 2, 2,1,1) tooltip:"Conform" 
button btn3 "" width:24 height:24 pos:[68,10] across:1  images:#("g9_CompoundObjectIcons.jpg", undefined, 20, 3, 3,1,1) tooltip:"ShapeMerge" 
button btn4 "" width:24 height:24 pos:[97,10] across:1  images:#("g9_CompoundObjectIcons.jpg", undefined, 20, 4, 4,1,1) tooltip:"Terrain"  
button btn5 "" width:24 height:24 pos:[126,10] across:1  images:#("g9_CompoundObjectIcons.jpg", undefined, 20, 6, 6,1,1) tooltip:"Connect" 
button btn6 "" width:24 height:24 pos:[155,10] across:1  images:#("g9_CompoundObjectIcons.jpg", undefined, 20, 7, 7,1,1) tooltip:"Boolean" 
button btn7 "" width:24 height:24 pos:[184,10] across:1  images:#("g9_CompoundObjectIcons.jpg", undefined, 20, 9, 9,1,1) tooltip:"ProBoolean" 
button btn8 "" width:24 height:24 pos:[213,10] across:1  images:#("g9_CompoundObjectIcons.jpg", undefined, 20, 8, 8,1,1) tooltip:"Loft" 
button btn9 "" width:24 height:24 pos:[242,10] across:1  images:#("g9_CompoundObjectIcons.jpg", undefined, 20, 5, 5,1,1) tooltip:"Scatter"
button btn10 "" width:24 height:24 pos:[271,10] across:1  images:#("g9_CompoundObjectIcons.jpg", undefined, 20, 10, 10,1,1) tooltip:"ProCutter" 


on btn1 pressed do
	(
	StartObjectCreation Morph
	)	

on btn2 pressed do
	(
	StartObjectCreation Conform
	)	

on btn3 pressed do
	(
	StartObjectCreation ShapeMerge
	)	

on btn4 pressed do
	(
	StartObjectCreation Terrain
	)	

on btn5 pressed do
	(
	StartObjectCreation Connect
	)	

on btn6 pressed do
	(
	StartObjectCreation Boolean
	)	

on btn7 pressed do
	(
	StartObjectCreation ProBoolean
	)	

on btn8 pressed do
	(
	StartObjectCreation Loft
	)	

on btn9 pressed do
	(
	StartObjectCreation Scatter
	)	

on btn10 pressed do
	(
	StartObjectCreation Procutter
	)	

on btn11 pressed do
	(
	macros.run "- Gueshni -" "OrientedRectangle"
	)	

)								-- end rollout COMPOUND OBJECT



rollout edspline "Edit Spline"
(
button btn1 "" width:24 height:24 pos:[10,10] across:1  images:#("g9_EditSplineIcons.jpg", undefined, 20, 1, 1,1,1) tooltip:"Align Spline to Minimum" 									
button btn2 "" width:24 height:24 pos:[39,10] images:#("g9_EditSplineIcons.jpg", undefined, 20, 2, 2,1,1) tooltip:"Simplify Line"																							
button btn3 "" width:24 height:24 pos:[68,10] images:#("g9_EditSplineIcons.jpg", undefined, 20, 3, 3,1,1) tooltip:"Spline Reducer"																				
button btn4 "" width:24 height:24 pos:[97,10] images:#("g9_EditSplineIcons.jpg", undefined, 20, 4, 4,1,1) tooltip:"Spline Painter"	
button btn5 "" width:24 height:24 pos:[126,10] images:#("g9_EditSplineIcons.jpg", undefined, 20, 5, 5,1,1) tooltip:"Spline Slicer"
button btn6 "" width:24 height:24 pos:[155,10] images:#("g9_EditSplineIcons.jpg", undefined, 20, 6, 6,1,1) tooltip:"Spline Optimize"




on btn1 pressed do
	(
	macros.run "- Gueshni -" "Align2Min"
	)	

on btn2 pressed do
	(
	macros.run "- Gueshni -" "SimplifyLine"
	)	

on btn3 pressed do
	(
	macros.run "- Gueshni -" "SplineReducer"
	)	

on btn4 pressed do
	(
	macros.run "- Gueshni -" "SplinePainter"
	)	

on btn5 pressed do
	(
	macros.run "- Gueshni -" "SplineSlicer"
	)	

on btn6 pressed do
	(
	macros.run "- Gueshni -" "SplineOptimize"
	)	

)								-- end rollout EDIT SPLINE



rollout edpoly "Edit Poly"
(
button btn1 "" width:24 height:24 pos:[10,10] across:1  images:#("g9_EditPolyIcons.jpg", undefined, 20, 1, 1,1,1) tooltip:"Auto Stitch" 
button btn2 "" width:24 height:24 pos:[39,10] images:#("g9_EditPolyIcons.jpg", undefined, 20, 2, 2,1,1) tooltip:"Detriangulator"
button btn3 "" width:24 height:24 pos:[68,10] images:#("g9_EditPolyIcons.jpg", undefined, 20, 3, 3,1,1) tooltip:"Clean Vertex"
button btn4 "" width:24 height:24 pos:[97,10] images:#("g9_EditPolyIcons.jpg", undefined, 20, 4, 4,1,1) tooltip:"Bridge"
button btn5 "" width:24 height:24 pos:[126,10] images:#("g9_EditPolyIcons.jpg", undefined, 20, 5, 5,1,1) tooltip:"Conform Vertices"
button btn6 "" width:24 height:24 pos:[155,10] images:#("g9_EditPolyIcons.jpg", undefined, 20, 6, 6,1,1) tooltip:"Eclator"
button btn7 "" width:24 height:24 pos:[184,10] images:#("g9_EditPolyIcons.jpg", undefined, 20, 7, 7,1,1) tooltip:"Detach by ID"
button btn8 "" width:24 height:24 pos:[213,10] images:#("g9_EditPolyIcons.jpg", undefined, 20, 8, 8,1,1) tooltip:"PolyQuad"
button btn9 "" width:24 height:24 pos:[242,10] images:#("g9_EditPolyIcons.jpg", undefined, 20, 9, 9,1,1) tooltip:"Cable Retopology"
button btn10 "" width:24 height:24 pos:[271,10] images:#("g9_EditPolyIcons.jpg", undefined, 20, 10, 10,1,1) tooltip:"Edge Straighten"




on btn1 pressed do
	(
	macros.run "- Gueshni -" "Autostitch"
	)	

on btn2 pressed do
	(
	macros.run "- Gueshni -" "Detriangulator"
	)	

on btn3 pressed do
	(
	macros.run "- Gueshni -" "CleanVertex"
	)	

on btn4 pressed do
	(
	macros.run "- Gueshni -" "Bridge"
	)	

on btn5 pressed do
	(
	macros.run "- Gueshni -" "ConformVertices"
	)	

on btn6 pressed do
	(
	macros.run "- Gueshni -" "Eclator"
	)	

on btn7 pressed do
	(
	macros.run "- Gueshni -" "DetachByID"
	)	

on btn8 pressed do
	(
	macros.run "- Gueshni -" "PolyQuad"
	)	

on btn9 pressed do
	(
	macros.run "- Gueshni -" "CableRetopology"
	)	

on btn10 pressed do
	(
	macros.run "- Gueshni -" "EdgeStraighten"
	)	

)								-- end rollout EDIT POLY



rollout transfrm "Transform"
(
button btn1 "" width:24 height:24 pos:[10,10] across:1  images:#("g9_TransformIcons.jpg", undefined, 20, 1, 1,1,1) tooltip:"Make Unique" 
button btn2 "" width:24 height:24 pos:[39,10] images:#("g9_TransformIcons.jpg", undefined, 20, 2, 2,1,1) tooltip:"Object Replacer"
button btn3 "" width:24 height:24 pos:[68,10] images:#("g9_TransformIcons.jpg", undefined, 20, 3, 3,1,1) tooltip:"Random Transform"
button btn4 "" width:24 height:24 pos:[97,10] images:#("g9_TransformIcons.jpg", undefined, 20, 4, 4,1,1) tooltip:"Renamer"
button btn5 "" width:24 height:24 pos:[126,10] images:#("g9_TransformIcons.jpg", undefined, 20, 5, 5,1,1) tooltip:"Clone Align Face"




on btn1 pressed do
	(
	macros.run "- Gueshni -" "MakeUnique"
	)	

on btn2 pressed do
	(
	macros.run "- Gueshni -" "ObjectReplacer"
	)	

on btn3 pressed do
	(
	macros.run "- Gueshni -" "RandomTransform"
	)	

on btn4 pressed do
	(
	macros.run "- Gueshni -" "Renamer"
	)		

on btn5 pressed do
	(
	macros.run "- Gueshni -" "CloneAlignFace"
	)		

)								-- end rollout TRANSFORM


rollout Materiel "Material"
(
button btn1 "" width:24 height:24 pos:[10,10] across:1  images:#("g9_MaterialIcons.jpg", undefined, 20, 1, 1,1,1) tooltip:"Clear Material Editor" 
button btn2 "" width:24 height:24 pos:[39,10] images:#("g9_MaterialIcons.jpg", undefined, 20, 2, 2,1,1) tooltip:"Texture Search"
button btn3 "" width:24 height:24 pos:[68,10] images:#("g9_MaterialIcons.jpg", undefined, 20, 3, 3,1,1) tooltip:"Kill Material"
button btn4 "" width:24 height:24 pos:[97,10] images:#("g9_MaterialIcons.jpg", undefined, 20, 4, 4,1,1) tooltip:"Tile Mapper"
button btn5 "" width:24 height:24 pos:[126,10] images:#("g9_MaterialIcons.jpg", undefined, 20, 5, 5,1,1) tooltip:"Ortho Material Fix"
button btn6 "" width:24 height:24 pos:[155,10] images:#("g9_MaterialIcons.jpg", undefined, 20, 6, 6,1,1) tooltip:"Photoshop Bitmap Open"
button btn7 "" width:24 height:24 pos:[184,10] images:#("g9_MaterialIcons.jpg", undefined, 20, 7, 7,1,1) tooltip:"Map Collector"
button btn8 "" width:24 height:24 pos:[213,10] images:#("g9_MaterialIcons.jpg", undefined, 20, 8, 8,1,1) tooltip:"Collapse Sub Object Material"
button btn9 "" width:24 height:24 pos:[242,10] images:#("g9_MaterialIcons.jpg", undefined, 20, 9, 9,1,1) tooltip:"Material Control"
button btn10 "" width:24 height:24 pos:[271,10] images:#("g9_MaterialIcons.jpg", undefined, 20, 10, 10,1,1) tooltip:"Turn Viewport Maps On/Off"

button btn11 "" width:24 height:24 pos:[10,39] images:#("g9_MaterialIcons.jpg", undefined, 20, 11, 11,1,1) tooltip:"Remove Ambient"
button btn12 "" width:24 height:24 pos:[39,39] images:#("g9_MaterialIcons.jpg", undefined, 20, 12, 12,1,1) tooltip:"Get Material from Selection"

	

on btn1 pressed do
	(
	macros.run "- Gueshni -" "ClearMaterialEditor"
	)	

on btn2 pressed do
	(
	macros.run "- Gueshni -" "TextureSearch"
	)	

on btn3 pressed do
	(
	macros.run "- Gueshni -" "KillMaterial"
	)	

on btn4 pressed do
	(
	macros.run "- Gueshni -" "TileMapper"
	)	

on btn5 pressed do
	(
	macros.run "- Gueshni -" "OrthoMaterialFix"
	)	

on btn6 pressed do
	(
	macros.run "- Gueshni -" "PhotoshopBitmapOpen"
	)	

on btn7 pressed do
	(
	macros.run "- Gueshni -" "MapCollector"
	)	

on btn8 pressed do
	(
	macros.run "- Gueshni -" "CollapseSubObjectMaterial"
	)	

on btn9 pressed do
	(
	macros.run "- Gueshni -" "MaterialControl"
	)	

on btn10 pressed do
	(
	macros.run "- Gueshni -" "TurnViewportMapsOn"
	)	

on btn11 pressed do
	(
	macros.run "- Gueshni -" "RemoveAmbient"
	)	

on btn12 pressed do
	(
	macros.run "- Gueshni -" "GetSelMaterial"
	)	

	
)								-- end rollout MATERIEL


rollout veget "Veget & Road"
(
button btn1 "" width:24 height:24 pos:[10,10] across:1  images:#("g9_VegetRoadIcons.jpg", undefined, 20, 1, 1,1,1) tooltip:"Veget Brush" 
button btn2 "" width:24 height:24 pos:[39,10] images:#("g9_VegetRoadIcons.jpg", undefined, 20, 2, 2,1,1) tooltip:"Planter"
button btn3 "" width:24 height:24 pos:[68,10] images:#("g9_VegetRoadIcons.jpg", undefined, 20, 3, 3,1,1) tooltip:"Veget"
button btn4 "" width:24 height:24 pos:[97,10] images:#("g9_VegetRoadIcons.jpg", undefined, 20, 4, 4,1,1) tooltip:"Altimetrizator"
button btn5 "" width:24 height:24 pos:[126,10] images:#("g9_VegetRoadIcons.jpg", undefined, 20, 5, 5,1,1) tooltip:"Glue"
button btn6 "" width:24 height:24 pos:[155,10] images:#("g9_VegetRoadIcons.jpg", undefined, 20, 6, 6,1,1) tooltip:"Mesh Sort"
button btn7 "" width:24 height:24 pos:[184,10] images:#("g9_VegetRoadIcons.jpg", undefined, 20, 7, 7,1,1) tooltip:"Decouper"
button btn8 "" width:24 height:24 pos:[213,10] images:#("g9_VegetRoadIcons.jpg", undefined, 20, 8, 8,1,1) tooltip:"Marquage"






on btn1 pressed do
	(
	macros.run "- Gueshni -" "VegetBrush"
	)	

on btn2 pressed do
	(
	macros.run "- Gueshni -" "Planter"
	)	

on btn3 pressed do
	(
	macros.run "- Gueshni -" "Veget"
	)	

on btn4 pressed do
	(
	macros.run "- Gueshni -" "Altimetrizator"
	)		

on btn5 pressed do
	(
	macros.run "- Gueshni -" "Glue"
	)		

on btn6 pressed do
	(
	macros.run "- Gueshni -" "MeshSort"
	)		

on btn7 pressed do
	(
	macros.run "- Gueshni -" "Decouper"
	)		

on btn8 pressed do
	(
	macros.run "- Gueshni -" "Marquage"
	)		

)								-- end rollout VEGET & ROAD



rollout anym "Animation"
(
button btn1 "" width:24 height:24 pos:[10,10] across:1  images:#("g9_AnimationIcons.jpg", undefined, 20, 1, 1,1,1) tooltip:"Trafic" 





on btn1 pressed do
	(
	macros.run "- Gueshni -" "Trafic"
	)	


)								-- end rollout ANIMATION







if toolG9wind != undefined do 
            ( 
            closerolloutfloater toolG9wind
            )       

toolG9wind = newRolloutFloater "Gueshni Toolbox" 320 950 2500 5
-- addRollout imaj toolG9wind 
addRollout systm toolG9wind 
addRollout ui toolG9wind
addRollout pivo toolG9wind
addRollout clection toolG9wind rolledup: on
addRollout kreatobj toolG9wind
addRollout kreatspline toolG9wind
addRollout cpdobject toolG9wind rolledup: on
addRollout edspline toolG9wind
addRollout edpoly toolG9wind
addRollout transfrm toolG9wind
addRollout materiel toolG9wind
addRollout veget toolG9wind rolledup: on
addRollout anym toolG9wind rolledup: on
			
)					--end macro