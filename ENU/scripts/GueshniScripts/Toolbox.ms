 (

-- bitmap the_bmp fileName:"ImageBG.jpg"

rollout imaj ""
(
bitmap the_bmp fileName:"ImageBG.jpg"
	
)								-- end rollout IMAGE


rollout systm "System"
(
button btn1 "" width:24 height:24 pos:[10,10] across:1  images:#("g9_SystemIcons.jpg", undefined, 20, 1, 21,1,1) tooltip:"Snap Windows"
button btn2 "" width:24 height:24 pos:[39,10] images:#("g9_SystemIcons.jpg", undefined, 20, 2, 21,1,1) tooltip:"Remove Missing Plugins"
button btn3 "" width:24 height:24 pos:[68,10] images:#("g9_SystemIcons.jpg", undefined, 20, 3, 21,1,1) tooltip:"Remove Empty Layers"
button btn4 "" width:24 height:24 pos:[97,10] images:#("g9_SystemIcons.jpg", undefined, 20, 4, 21,1,1) tooltip:"Lock Manager"
button btn5 "" width:24 height:24 pos:[126,10] images:#("g9_SystemIcons.jpg", undefined, 20, 5, 21,1,1) tooltip:"Copy Object"
button btn6 "" width:24 height:24 pos:[155,10] images:#("g9_SystemIcons.jpg", undefined, 20, 6, 21,1,1) tooltip:"Paste Object"
button btn7 "" width:24 height:24 pos:[184,10] images:#("g9_SystemIcons.jpg", undefined, 20, 7, 21,1,1) tooltip:"Reset Transform"
button btn8 "" width:24 height:24 pos:[213,10] images:#("g9_SystemIcons.jpg", undefined, 20, 8, 21,1,1) tooltip:"Directories"
button btn9 "" width:24 height:24 pos:[242,10] images:#("g9_SystemIcons.jpg", undefined, 20, 9, 21,1,1) tooltip:"Multi Xref Scenes"
button btn10 "" width:24 height:24 pos:[271,10] images:#("g9_SystemIcons.jpg", undefined, 20, 10, 21,1,1) tooltip:"Layer Manager"

button btn11 "" width:24 height:24 pos:[10,39] images:#("g9_SystemIcons.jpg", undefined, 20, 11, 21,1,1) tooltip:"Show Statistics"
button btn12 "" width:24 height:24 pos:[39,39] images:#("g9_SystemIcons.jpg", undefined, 20, 12, 21,1,1) tooltip:"Copy with Name"

	

on btn1 pressed do
	(
	macros.run "Gueshni" "SnapWindows"
	)	

on btn2 pressed do
	(
	macros.run "Gueshni" "RemoveMissingPlugins"
	)	

on btn3 pressed do
	(
	macros.run "Gueshni" "RemoveEmptyLayers"
	)	

on btn4 pressed do
	(
	macros.run "Gueshni" "LockManager"
	)	

on btn5 pressed do
	(
	macros.run "Gueshni" "CopyObject"
	)	

on btn6 pressed do
	(
	macros.run "Gueshni" "PasteObject"
	)	

on btn7 pressed do
	(
	macros.run "Gueshni" "ResetTransformMacro"
	)	

on btn8 pressed do
	(
	macros.run "Gueshni" "Directories"
	)	

on btn9 pressed do
	 (
	 macros.run "Gueshni" "MultiXrefScenes"
	 )	

on btn10 pressed do
	(
	macros.run "Gueshni" "LayerManager"
	)

on btn11 pressed do
	(
	macros.run "Gueshni" "ShowStatistics"
	) 

on btn12 pressed do
	(
	macros.run "Gueshni" "CopyWithName"
	) 


	
)								-- end rollout SYSTEM


rollout toolz "Tools"
(
button btn1 "" width:24 height:24 pos:[10,10] across:1  images:#("g9_ToolsIcons.jpg", undefined, 20, 1, 21,1,1) tooltip:"BBox Maker"
button btn2 "" width:24 height:24 pos:[39,10] images:#("g9_ToolsIcons.jpg", undefined, 20, 2, 21,1,1) tooltip:"Object Dimension"
button btn3 "" width:24 height:24 pos:[68,10] images:#("g9_ToolsIcons.jpg", undefined, 20, 3, 21,1,1) tooltip:"Calculator Launcher"
button btn4 "" width:24 height:24 pos:[97,10] images:#("g9_ToolsIcons.jpg", undefined, 20, 4, 21,1,1) tooltip:"Vertex Distance Tape"
button btn5 "" width:24 height:24 pos:[126,10] images:#("g9_ToolsIcons.jpg", undefined, 20, 5, 21,1,1) tooltip:"Multi Distance Meter"
button btn6 "" width:24 height:24 pos:[155,10] images:#("g9_ToolsIcons.jpg", undefined, 20, 6, 21,1,1) tooltip:"Collision Kreator"
button btn7 "" width:24 height:24 pos:[184,10] images:#("g9_ToolsIcons.jpg", undefined, 20, 7, 21,1,1) tooltip:"Ref Plane AutoRatio"
button btn8 "" width:24 height:24 pos:[213,10] images:#("g9_ToolsIcons.jpg", undefined, 20, 8, 21,1,1) tooltip:"Search by Name"
button btn9 "" width:24 height:24 pos:[242,10] images:#("g9_ToolsIcons.jpg", undefined, 20, 9, 21,1,1) tooltip:"Link Transfer"
button btn10 "" width:24 height:24 pos:[271,10] images:#("g9_ToolsIcons.jpg", undefined, 20, 10, 21,1,1) tooltip:"Hierarchy List"

button btn11 "" width:24 height:24 pos:[10,39] images:#("g9_ToolsIcons.jpg", undefined, 20, 11, 21,1,1) tooltip:"Animation List"
button btn12 "" width:24 height:24 pos:[39,39] images:#("g9_ToolsIcons.jpg", undefined, 20, 12, 21,1,1) tooltip:"List Selected Objects"
	

on btn1 pressed do
	(
	macros.run "Gueshni" "BBoxMaker"
	)	

on btn2 pressed do
	(
	macros.run "Gueshni" "ObjectDimension"
	)	

on btn3 pressed do
	(
	macros.run "Gueshni" "CalculatorLauncher"
	)	

on btn4 pressed do
	(
	macros.run "Gueshni" "VertexDistanceTape"
	)	

on btn5 pressed do
	(
	macros.run "Gueshni" "MultiDistanceMeter"
	)

on btn6 pressed do
	(
	macros.run "Gueshni" "CollisionKreator"
	)

on btn7 pressed do
	(
	macros.run "Gueshni" "RefPlane_AutoRatio"
	)

on btn8 pressed do
	(
	macros.run "Gueshni" "SearchByName"
	)

on btn9 pressed do
	(
	macros.run "Gueshni" "LinkTransfer"
	)

on btn10 pressed do
	(
	macros.run "Gueshni" "HierarchyList"
	)

on btn11 pressed do
	(
	macros.run "Gueshni" "AnimationList"
	)

on btn12 pressed do
	(
	macros.run "Gueshni" "ListSelected"
	)
	
)								-- end rollout TOOLS


rollout ui "UI"
(
button btn1 "" width:24 height:24 pos:[10,10] across:1  images:#("g9_UIIcons.jpg", undefined, 20, 1, 21,1,1) tooltip:"Align Viewport to Face"
button btn2 "" width:24 height:24 pos:[39,10] images:#("g9_UIIcons.jpg", undefined, 20, 2, 21,1,1) tooltip:"Align Viewport from 3 Points"
button btn3 "" width:24 height:24 pos:[68,10] images:#("g9_UIIcons.jpg", undefined, 20, 3, 21,1,1) tooltip:"Backface Cull"
button btn4 "" width:24 height:24 pos:[97,10] images:#("g9_UIIcons.jpg", undefined, 20, 4, 21,1,1) tooltip:"Vertex Ticks"
button btn5 "" width:24 height:24 pos:[126,10] images:#("g9_UIIcons.jpg", undefined, 20, 5, 21,1,1) tooltip:"Display Object Color"
button btn6 "" width:24 height:24 pos:[155,10] images:#("g9_UIIcons.jpg", undefined, 20, 6, 21,1,1) tooltip:"Random Wirecolor"
button btn7 "" width:24 height:24 pos:[184,10] images:#("g9_UIIcons.jpg", undefined, 20, 7, 21,1,1) tooltip:"Wirecolor by Layer"	
button btn8 "" width:24 height:24 pos:[213,10] images:#("g9_UIIcons.jpg", undefined, 20, 8, 21,1,1) tooltip:"Color Palette"
button btn9 "" width:24 height:24 pos:[242,10] images:#("g9_UIIcons.jpg", undefined, 20, 9, 21,1,1) tooltip:"Selection Highlight Outline Toggle"
button btn10 "" width:24 height:24 pos:[271,10] images:#("g9_UIIcons.jpg", undefined, 20, 10, 21,1,1) tooltip:"Viewport Shadow Toggle"




on btn1 pressed do
	(
	macros.run "Gueshni" "AlignViewport2Face"
	)	

on btn2 pressed do
	(
	macros.run "Gueshni" "AlignViewportFrom3points"
	)	

on btn3 pressed do
	(
	macros.run "Gueshni" "BackfaceCull"
	)	

on btn4 pressed do
	(
	macros.run "Gueshni" "VertexTicks"
	)	

on btn5 pressed do
	(
	macros.run "Gueshni" "DisplayObjectColor"
	)	

on btn6 pressed do
	(
	macros.run "Gueshni" "RandomWirecolor"
	)	

on btn7 pressed do
	(
	macros.run "Gueshni" "WirecolorByLayer"
	)	

on btn8 pressed do
	(
	macros.run "Gueshni" "ColorPalette"
	)	
	
on btn9 pressed do
	(
	actionMan.executeAction 0 "63565"	
	)	
	
on btn10 pressed do
	(
	actionMan.executeAction -844228238 "5"	
	)	

)								-- end rollout UI


rollout pivo "Pivot"
(
button btn1 "" width:24 height:24 pos:[10,10] across:1  images:#("g9_PivotIcons.jpg", undefined, 20, 1, 21,1,1) tooltip:"Center Pivot" 												
button btn2 "" width:24 height:24 pos:[39,10] images:#("g9_PivotIcons.jpg", undefined, 20, 2, 21,1,1) tooltip:"Align Pivot to Minimum"										
button btn3 "" width:24 height:24 pos:[68,10] images:#("g9_PivotIcons.jpg", undefined, 20, 3, 21,1,1) tooltip:"Easy Pivot"	
button btn4 "" width:24 height:24 pos:[97,10] images:#("g9_PivotIcons.jpg", undefined, 20, 4, 21,1,1) tooltip:"Align Pivot to Direction"	
button btn5 "" width:24 height:24 pos:[126,10] images:#("g9_PivotIcons.jpg", undefined, 20, 5, 21,1,1) tooltip:"Oriented Pivot Alignator"	
button btn6 "" width:24 height:24 pos:[155,10] images:#("g9_PivotIcons.jpg", undefined, 20, 6, 21,1,1) tooltip:"Fit Bounding Box"		
button btn7 "" width:24 height:24 pos:[184,10] images:#("g9_PivotIcons.jpg", undefined, 20, 7, 21,1,1) tooltip:"Pivot from SubObject"




on btn1 pressed do
	(
	macros.run "Gueshni" "CenterPivotMacro"
	)	

on btn2 pressed do
	(
	macros.run "Gueshni" "AlignPivot2Min"
	)	

on btn3 pressed do
	(
	macros.run "Gueshni" "EasyPivot"
	)	

on btn4 pressed do
	(
	macros.run "Gueshni" "AlignPivot2Direction"
	)	

on btn5 pressed do
	(
	macros.run "Gueshni" "OrientedPivotAlignator"
	)	

on btn6 pressed do
	(
	macros.run "Gueshni" "FitBoundingBox"
	)	

on btn7 pressed do
	(
	macros.run "Gueshni" "PivotFromSubObject"
	)	

)								-- end rollout PIVOT


rollout clection "Selection"
(
button btn1 "" width:24 height:24 pos:[10,10] across:1  images:#("g9_SelectionIcons.jpg", undefined, 20, 1, 21,1,1) tooltip:"Select by Pair" 															
button btn2 "" width:24 height:24 pos:[39,10] images:#("g9_SelectionIcons.jpg", undefined, 20, 2, 21,1,1) tooltip:"Random Select"																						
button btn3 "" width:24 height:24 pos:[68,10] images:#("g9_SelectionIcons.jpg", undefined, 20, 3, 21,1,1) tooltip:"Select Object with No Material"								
button btn4 "" width:24 height:24 pos:[97,10] images:#("g9_SelectionIcons.jpg", undefined, 20, 4, 21,1,1) tooltip:"Random Face Select"															
button btn5 "" width:24 height:24 pos:[126,10] images:#("g9_SelectionIcons.jpg", undefined, 20, 5, 21,1,1) tooltip:"Select Empty Objects"															
button btn6 "" width:24 height:24 pos:[155,10] images:#("g9_SelectionIcons.jpg", undefined, 20, 6, 21,1,1) tooltip:"Select Duplicated Surfaces"														
button btn7 "" width:24 height:24 pos:[184,10] images:#("g9_SelectionIcons.jpg", undefined, 20, 7, 21,1,1) tooltip:"Select Faces by Angle 5°"												




on btn1 pressed do
	(
	macros.run "Gueshni" "SelectByPair"
	)	

on btn2 pressed do
	(
	macros.run "Gueshni" "RandomSelect"
	)	

on btn3 pressed do
	(
	macros.run "Gueshni" "SelectNoMaterial"
	)	

on btn4 pressed do
	(
	macros.run "Gueshni" "RandomFaceSelect"
	)	

on btn5 pressed do
	(
	macros.run "Gueshni" "SelectEmptyObject"
	)	

on btn6 pressed do
	(
	macros.run "Gueshni" "SelectDuplicatedSurfaces"
	)		

on btn7 pressed do
	(
	macros.run "Gueshni" "SelectFacesByAngle5"
	)

)								-- end rollout SELECTION


rollout kreatobj "Create Object"
(
button btn1 "" width:24 height:24 pos:[10,10] across:1  images:#("g9_CreateObjectIcons.jpg", undefined, 20, 1, 21,1,1) tooltip:"Create Box"
button btn2 "" width:24 height:24 pos:[39,10] across:1  images:#("g9_CreateObjectIcons.jpg", undefined, 20, 2, 21,1,1) tooltip:"Create Sphere" 
button btn3 "" width:24 height:24 pos:[68,10] across:1  images:#("g9_CreateObjectIcons.jpg", undefined, 20, 3, 21,1,1) tooltip:"Create Cylinder" 
button btn4 "" width:24 height:24 pos:[97,10] across:1  images:#("g9_CreateObjectIcons.jpg", undefined, 20, 4, 21,1,1) tooltip:"Create Torus" 
button btn5 "" width:24 height:24 pos:[126,10] across:1  images:#("g9_CreateObjectIcons.jpg", undefined, 20, 5, 21,1,1) tooltip:"Create Cone" 
button btn6 "" width:24 height:24 pos:[155,10] across:1  images:#("g9_CreateObjectIcons.jpg", undefined, 20, 6, 21,1,1) tooltip:"Create GeoSphere" 
button btn7 "" width:24 height:24 pos:[184,10] across:1  images:#("g9_CreateObjectIcons.jpg", undefined, 20, 7, 21,1,1) tooltip:"Create Tube" 
button btn8 "" width:24 height:24 pos:[213,10] across:1  images:#("g9_CreateObjectIcons.jpg", undefined, 20, 8, 21,1,1) tooltip:"Create Pyramid" 
button btn9 "" width:24 height:24 pos:[242,10] across:1  images:#("g9_CreateObjectIcons.jpg", undefined, 20, 9, 21,1,1) tooltip:"Create Plane" 
button btn10 "" width:24 height:24 pos:[271,10] across:1  images:#("g9_CreateObjectIcons.jpg", undefined, 20, 10, 21,1,1) tooltip:"Create Hedra" 

button btn11 "" width:24 height:24 pos:[10,39] across:1  images:#("g9_CreateObjectIcons.jpg", undefined, 20, 11, 21,1,1) tooltip:"Create Chamfer Box"
button btn12 "" width:24 height:24 pos:[39,39] across:1  images:#("g9_CreateObjectIcons.jpg", undefined, 20, 12, 21,1,1) tooltip:"Create Oil Tank" 
button btn13 "" width:24 height:24 pos:[68,39] across:1  images:#("g9_CreateObjectIcons.jpg", undefined, 20, 17, 21,1,1) tooltip:"Create Chamfer Cylinder" 
button btn14 "" width:24 height:24 pos:[97,39] across:1  images:#("g9_CreateObjectIcons.jpg", undefined, 20, 13, 21,1,1) tooltip:"Create Spindle" 
button btn15 "" width:24 height:24 pos:[126,39] across:1  images:#("g9_CreateObjectIcons.jpg", undefined, 20, 14, 21,1,1) tooltip:"Create Gengon" 
button btn16 "" width:24 height:24 pos:[155,39] across:1  images:#("g9_CreateObjectIcons.jpg", undefined, 20, 15, 21,1,1) tooltip:"Create RingWave" 
button btn17 "" width:24 height:24 pos:[184,39] across:1  images:#("g9_CreateObjectIcons.jpg", undefined, 20, 16, 21,1,1) tooltip:"Create Torus Knot" 
button btn18 "" width:24 height:24 pos:[213,39] across:1  images:#("g9_CreateObjectIcons.jpg", undefined, 20, 18, 21,1,1) tooltip:"Create Capsule" 
button btn19 "" width:24 height:24 pos:[242,39] across:1  images:#("g9_CreateObjectIcons.jpg", undefined, 20, 19, 21,1,1) tooltip:"Create Dummy" 
button btn20 "" width:24 height:24 pos:[271,39] across:1  images:#("g9_CreateObjectIcons.jpg", undefined, 20, 20, 21,1,1) tooltip:"Create Point" 

button btn21 "" width:24 height:24 pos:[10,68] across:1  images:#("g9_CreateObject2Icons.jpg", undefined, 20, 1, 21,1,1) tooltip:"Rock Generator" 
button btn22 "" width:24 height:24 pos:[39,68] across:1  images:#("g9_CreateObject2Icons.jpg", undefined, 20, 2, 21,1,1) tooltip:"Quad Sphere" 
button btn23 "" width:24 height:24 pos:[68,68] across:1  images:#("g9_CreateObject2Icons.jpg", undefined, 20, 3, 21,1,1) tooltip:"Gear" 



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

on btn19 pressed do
	(
	StartObjectCreation Dummy
	)	

on btn20 pressed do
	(
	StartObjectCreation Point
	)	

on btn21 pressed do
	(
	macros.run "Gueshni" "RockGenerator"
	)	
on btn22 pressed do
	(
	macros.run "Gueshni" "QuadSphere"
	)		

on btn23 pressed do
	(
	macros.run "Gueshni" "GearCreator"
	)

)								-- end rollout CREATE OBJECT


rollout kreatspline "Create Spline"
(
button btn1 "" width:24 height:24 pos:[10,10] across:1  images:#("g9_CreateSplineIcons.jpg", undefined, 20, 1, 21,1,1) tooltip:"Create Line"
button btn2 "" width:24 height:24 pos:[39,10] across:1  images:#("g9_CreateSplineIcons.jpg", undefined, 20, 2, 21,1,1) tooltip:"Create Circle" 
button btn3 "" width:24 height:24 pos:[68,10] across:1  images:#("g9_CreateSplineIcons.jpg", undefined, 20, 3, 21,1,1) tooltip:"Create Arc" 
button btn4 "" width:24 height:24 pos:[97,10] across:1  images:#("g9_CreateSplineIcons.jpg", undefined, 20, 4, 21,1,1) tooltip:"Create Ngon" 
button btn5 "" width:24 height:24 pos:[126,10] across:1  images:#("g9_CreateSplineIcons.jpg", undefined, 20, 5, 21,1,1) tooltip:"Create Text" 
button btn6 "" width:24 height:24 pos:[155,10] across:1  images:#("g9_CreateSplineIcons.jpg", undefined, 20, 6, 21,1,1) tooltip:"Create Rectangle" 
button btn7 "" width:24 height:24 pos:[184,10] across:1  images:#("g9_CreateSplineIcons.jpg", undefined, 20, 7, 21,1,1) tooltip:"Create Ellipse" 
button btn8 "" width:24 height:24 pos:[213,10] across:1  images:#("g9_CreateSplineIcons.jpg", undefined, 20, 8, 21,1,1) tooltip:"Create Donut" 
button btn9 "" width:24 height:24 pos:[242,10] across:1  images:#("g9_CreateSplineIcons.jpg", undefined, 20, 9, 21,1,1) tooltip:"Create Star" 
button btn10 "" width:24 height:24 pos:[271,10] across:1  images:#("g9_CreateSplineIcons.jpg", undefined, 20, 10, 21,1,1) tooltip:"Create Helix"
	
button btn11 "" width:24 height:24 pos:[10,39] across:1  images:#("g9_CreateSplineIcons.jpg", undefined, 20, 12, 21,1,1) tooltip:"Spline Fiber"
button btn12 "" width:24 height:24 pos:[39,39] across:1  images:#("g9_CreateSplineIcons.jpg", undefined, 20, 13, 21,1,1) tooltip:"Vertex to Spline"


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
	macros.run "Gueshni" "SplineFiber"
	)		

on btn12 pressed do
	(
	macros.run "Gueshni" "VertexToSpline"
	)			

)								-- end rollout CREATE SPLINE


rollout cpdobject "Compound Object"
(
button btn1 "" width:24 height:24 pos:[10,10] across:1  images:#("g9_CompoundObjectIcons.jpg", undefined, 20, 1, 21,1,1) tooltip:"Morph"
button btn2 "" width:24 height:24 pos:[39,10] across:1  images:#("g9_CompoundObjectIcons.jpg", undefined, 20, 2, 21,1,1) tooltip:"Conform" 
button btn3 "" width:24 height:24 pos:[68,10] across:1  images:#("g9_CompoundObjectIcons.jpg", undefined, 20, 3, 21,1,1) tooltip:"ShapeMerge" 
button btn4 "" width:24 height:24 pos:[97,10] across:1  images:#("g9_CompoundObjectIcons.jpg", undefined, 20, 4, 21,1,1) tooltip:"Terrain"  
button btn5 "" width:24 height:24 pos:[126,10] across:1  images:#("g9_CompoundObjectIcons.jpg", undefined, 20, 6, 21,1,1) tooltip:"Connect" 
button btn6 "" width:24 height:24 pos:[155,10] across:1  images:#("g9_CompoundObjectIcons.jpg", undefined, 20, 7, 21,1,1) tooltip:"Boolean" 
button btn7 "" width:24 height:24 pos:[184,10] across:1  images:#("g9_CompoundObjectIcons.jpg", undefined, 20, 9, 21,1,1) tooltip:"ProBoolean" 
button btn8 "" width:24 height:24 pos:[213,10] across:1  images:#("g9_CompoundObjectIcons.jpg", undefined, 20, 8, 21,1,1) tooltip:"Loft" 
button btn9 "" width:24 height:24 pos:[242,10] across:1  images:#("g9_CompoundObjectIcons.jpg", undefined, 20, 5, 21,1,1) tooltip:"Scatter"
button btn10 "" width:24 height:24 pos:[271,10] across:1  images:#("g9_CompoundObjectIcons.jpg", undefined, 20, 10, 21,1,1) tooltip:"ProCutter" 
	
button btn11 "" width:24 height:24 pos:[10,39] across:1  images:#("g9_CompoundObjectIcons.jpg", undefined, 20, 11, 21,1,1) tooltip:"Geometry Projection" 
button btn12 "" width:24 height:24 pos:[39,39] across:1  images:#("g9_CompoundObjectIcons.jpg", undefined, 20, 12, 21,1,1) tooltip:"Terrain Conformer" 
button btn13 "" width:24 height:24 pos:[68,39] across:1  images:#("g9_CompoundObjectIcons.jpg", undefined, 20, 13, 21,1,1) tooltip:"Conform Vertice" 


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
	boolObj.createBooleanObject $
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
	macros.run "Gueshni" "GeometryProjection"
	)	

on btn12 pressed do
	(
	macros.run "Gueshni" "TerrainConformer"
	)	

on btn13 pressed do
	(
	macros.run "Gueshni" "ConformVertices"
	)	

)								-- end rollout COMPOUND OBJECT


rollout edspline "Edit Spline"
(
button btn1 "" width:24 height:24 pos:[10,10] across:1  images:#("g9_EditSplineIcons.jpg", undefined, 20, 1, 21,1,1) tooltip:"Align Spline to Minimum" 									
button btn2 "" width:24 height:24 pos:[39,10] images:#("g9_EditSplineIcons.jpg", undefined, 20, 2, 21,1,1) tooltip:"Simplify Line"																							
button btn3 "" width:24 height:24 pos:[68,10] images:#("g9_EditSplineIcons.jpg", undefined, 20, 3, 21,1,1) tooltip:"Spline Reducer"																				
button btn4 "" width:24 height:24 pos:[97,10] images:#("g9_EditSplineIcons.jpg", undefined, 20, 4, 21,1,1) tooltip:"Spline Painter"	
button btn5 "" width:24 height:24 pos:[126,10] images:#("g9_EditSplineIcons.jpg", undefined, 20, 5, 21,1,1) tooltip:"Spline Slicer"
button btn6 "" width:24 height:24 pos:[155,10] images:#("g9_EditSplineIcons.jpg", undefined, 20, 6, 21,1,1) tooltip:"Spline Optimize"
button btn7 "" width:24 height:24 pos:[184,10] images:#("g9_EditSplineIcons.jpg", undefined, 20, 7, 21,1,1) tooltip:"Spline Eclator"
button btn8 "" width:24 height:24 pos:[213,10] images:#("g9_EditSplineIcons.jpg", undefined, 20, 8, 21,1,1) tooltip:"Extrude" 
button btn9 "" width:24 height:24 pos:[242,10] images:#("g9_EditSplineIcons.jpg", undefined, 20, 9, 21,1,1) tooltip:"Lathe" 




on btn1 pressed do
	(
	macros.run "Gueshni" "Align2Min"
	)	

on btn2 pressed do
	(
	macros.run "Gueshni" "SimplifyLine"
	)	

on btn3 pressed do
	(
	macros.run "Gueshni" "SplineReducer"
	)	

on btn4 pressed do
	(
	macros.run "Gueshni" "SplinePainter"
	)	

on btn5 pressed do
	(
	macros.run "Gueshni" "SplineSlicer"
	)	

on btn6 pressed do
	(
	macros.run "Gueshni" "SplineOptimize"
	)	

on btn7 pressed do
	(
	macros.run "Gueshni" "SplineEclator"
	)	

on btn8 pressed do
	(
	modPanel.addModToSelection (Extrude ()) ui:on
	)	

on btn9 pressed do
	(
	modPanel.addModToSelection (Lathe ()) ui:on
	)

)								-- end rollout EDIT SPLINE



rollout edpoly "Edit Poly"
(
button btn1 "" width:24 height:24 pos:[10,10] across:1  images:#("g9_EditPolyIcons.jpg", undefined, 20, 1, 21,1,1) tooltip:"Auto Stitch" 
button btn2 "" width:24 height:24 pos:[39,10] images:#("g9_EditPolyIcons.jpg", undefined, 20, 2, 21,1,1) tooltip:"Border Fill"
button btn3 "" width:24 height:24 pos:[68,10] images:#("g9_EditPolyIcons.jpg", undefined, 20, 3, 21,1,1) tooltip:"Clean Vertex"
button btn4 "" width:24 height:24 pos:[97,10] images:#("g9_EditPolyIcons.jpg", undefined, 20, 4, 21,1,1) tooltip:"Bridge"
button btn5 "" width:24 height:24 pos:[126,10] images:#("g9_EditPolyIcons.jpg", undefined, 20, 5, 21,1,1) tooltip:"Flow Bridge"
button btn6 "" width:24 height:24 pos:[155,10] images:#("g9_EditPolyIcons.jpg", undefined, 20, 6, 21,1,1) tooltip:"Eclator"
button btn7 "" width:24 height:24 pos:[184,10] images:#("g9_EditPolyIcons.jpg", undefined, 20, 7, 21,1,1) tooltip:"Detach by ID"
button btn8 "" width:24 height:24 pos:[213,10] images:#("g9_EditPolyIcons.jpg", undefined, 20, 8, 21,1,1) tooltip:"PolyQuad"
button btn9 "" width:24 height:24 pos:[242,10] images:#("g9_EditPolyIcons.jpg", undefined, 20, 9, 21,1,1) tooltip:"Cable Retopology"
button btn10 "" width:24 height:24 pos:[271,10] images:#("g9_EditPolyIcons.jpg", undefined, 20, 10, 21,1,1) tooltip:"Edge Straighten"

button btn11 "" width:24 height:24 pos:[10,39] across:1  images:#("g9_EditPolyIcons.jpg", undefined, 20, 11, 21,1,1) tooltip:"Regularize Edge Loop" 
button btn12 "" width:24 height:24 pos:[39,39] images:#("g9_EditPolyIcons.jpg", undefined, 20, 12, 21,1,1) tooltip:"Shell" 
button btn13 "" width:24 height:24 pos:[68,39] images:#("g9_EditPolyIcons.jpg", undefined, 20, 13, 21,1,1) tooltip:"Surface" 
button btn14 "" width:24 height:24 pos:[97,39] images:#("g9_EditPolyIcons.jpg", undefined, 20, 14, 21,1,1) tooltip:"Optimize" 
button btn15 "" width:24 height:24 pos:[126,39] images:#("g9_EditPolyIcons.jpg", undefined, 20, 15, 21,1,1) tooltip:"Pro Optimizer" 
button btn16 "" width:24 height:24 pos:[155,39] images:#("g9_EditPolyIcons.jpg", undefined, 20, 16, 21,1,1) tooltip:"Mesh Smooth" 
button btn17 "" width:24 height:24 pos:[184,39] images:#("g9_EditPolyIcons.jpg", undefined, 20, 17, 21,1,1) tooltip:"Turbo Smooth" 
button btn18 "" width:24 height:24 pos:[213,39] images:#("g9_EditPolyIcons.jpg", undefined, 20, 18, 21,1,1) tooltip:"Chamfer" 
button btn19 "" width:24 height:24 pos:[242,39] images:#("g9_EditPolyIcons.jpg", undefined, 20, 19, 21,1,1) tooltip:"Slice Tool" 
button btn20 "" width:24 height:24 pos:[271,39] images:#("g9_EditPolyIcons.jpg", undefined, 20, 20, 21,1,1) tooltip:"Turbo Reverse"

button btn21 "" width:24 height:24 pos:[10,68] images:#("g9_EditPolyIcons2.jpg", undefined, 20, 1, 21,1,1) tooltip:"Slice"




on btn1 pressed do
	(
	macros.run "Gueshni" "AutoStitch"
	)	

on btn2 pressed do
	(
	macros.run "Gueshni" "BorderFill"
	)	

on btn3 pressed do
	(
	macros.run "Gueshni" "CleanVertex"
	)	

on btn4 pressed do
	(
	macros.run "Gueshni" "Bridge"
	)	

on btn5 pressed do
	(
	macros.run "Gueshni" "FlowBridge"
	)	

on btn6 pressed do
	(
	macros.run "Gueshni" "Eclator"
	)	

on btn7 pressed do
	(
	macros.run "Gueshni" "DetachByID"
	)	

on btn8 pressed do
	(
	macros.run "Gueshni" "PolyQuad"
	)	

on btn9 pressed do
	(
	macros.run "Gueshni" "CableRetopology"
	)	

on btn10 pressed do
	(
	macros.run "Gueshni" "EdgeStraighten"
	)	

on btn11 pressed do
	(
	macros.run "Gueshni" "RegularizeEdgeLoop"
	)		

on btn12 pressed do
	(
	modPanel.addModToSelection (Shell ()) ui:on
		(
		$.modifiers[#Shell].straightenCorners = on
		)
	)		

on btn13 pressed do
	(
-- 	subobjectLevel = 0
modPanel.addModToSelection (surface ()) ui:on
		(
		$.modifiers[#Surface].Threshold = 0
		$.modifiers[#Surface].steps = 0
		)
	)		

on btn14 pressed do
	(
	modPanel.addModToSelection (optimize ()) ui:on
	)		

on btn15 pressed do
	(
	modPanel.addModToSelection (ProOptimizer ()) ui:on
	)		

on btn16 pressed do
	(
	modPanel.addModToSelection (meshsmooth ()) ui:on
	)		

on btn17 pressed do
	(
	modPanel.addModToSelection (TurboSmooth ()) ui:on
	)	

on btn18 pressed do
	(
	modPanel.addModToSelection (Chamfer ()) ui:on
	)	

on btn19 pressed do
	(
	macros.run "Gueshni" "SliceTool"
	)

on btn20 pressed do
	(
	modPanel.addModToSelection (TurboReverse ()) ui:on
	)	

on btn21 pressed do
	(
	modPanel.addModToSelection (SliceModifier ()) ui:on
	)	

)								-- end rollout EDIT POLY



rollout transfrm "Transform"
(
button btn1 "" width:24 height:24 pos:[10,10] across:1  images:#("g9_TransformIcons.jpg", undefined, 20, 1, 21,1,1) tooltip:"Make Unique" 
button btn2 "" width:24 height:24 pos:[39,10] images:#("g9_TransformIcons.jpg", undefined, 20, 2, 21,1,1) tooltip:"Object Replacer"
button btn3 "" width:24 height:24 pos:[68,10] images:#("g9_TransformIcons.jpg", undefined, 20, 3, 21,1,1) tooltip:"Random Transform"
-- button btn4 "" width:24 height:24 pos:[97,10] images:#("g9_TransformIcons.jpg", undefined, 20, 4, 21,1,1) tooltip:"Renamer"
button btn4 "" width:24 height:24 pos:[97,10] images:#("g9_TransformIcons.jpg", undefined, 20, 4, 21,1,1) tooltip:"Object Renamer"
button btn5 "" width:24 height:24 pos:[126,10] images:#("g9_TransformIcons.jpg", undefined, 20, 5, 21,1,1) tooltip:"Clone Align Face"
button btn6 "" width:24 height:24 pos:[155,10] images:#("g9_TransformIcons.jpg", undefined, 20, 6, 21,1,1) tooltip:"Mesh Surface from Selection"
button btn7 "" width:24 height:24 pos:[184,10] images:#("g9_TransformIcons.jpg", undefined, 20, 7, 21,1,1) tooltip:"Position Zero"
button btn8 "" width:24 height:24 pos:[213,10] images:#("g9_TransformIcons.jpg", undefined, 20, 8, 21,1,1) tooltip:"Array"
button btn9 "" width:24 height:24 pos:[242,10] images:#("g9_TransformIcons.jpg", undefined, 20, 9, 21,1,1) tooltip:"Normal"
button btn10 "" width:24 height:24 pos:[271,10] images:#("g9_TransformIcons.jpg", undefined, 20, 10, 21,1,1) tooltip:"Symmetry"




on btn1 pressed do
	(
	macros.run "Gueshni" "MakeUnique"
	)	

on btn2 pressed do
	(
	macros.run "Gueshni" "ObjectReplacer"
	)	

on btn3 pressed do
	(
	macros.run "Gueshni" "RandomTransform"
	)	

on btn4 pressed do
	(
	macros.run "Gueshni" "ObjectRenamer"
	)		

on btn5 pressed do
	(
	macros.run "Gueshni" "CloneAlignFace"
	)		

on btn6 pressed do
	(
	macros.run "Gueshni" "MeshSurfaceFromSelection"
	)		

on btn7 pressed do
	(
	macros.run "Gueshni" "PositionZero"
	)		

on btn8 pressed do
	(
	macros.run "Gueshni" "ArrayMacro"
	)	
	
on btn9 pressed do
	(
	modPanel.addModToSelection (Normalmodifier ()) ui:on 
		(
			$.modifiers[#Normal].flip = on 
		)
	)	
	
on btn10 pressed do
	(
	modPanel.addModToSelection (symmetry ()) ui:on 
		(
			$.modifiers[#Symmetry].threshold = 0.001
		)
	)		

)								-- end rollout TRANSFORM


rollout Materiel "Material"
(
button btn1 "" width:24 height:24 pos:[10,10] across:1  images:#("g9_MaterialIcons.jpg", undefined, 20, 1, 21,1,1) tooltip:"Clear Material Editor" 
button btn2 "" width:24 height:24 pos:[39,10] images:#("g9_MaterialIcons.jpg", undefined, 20, 2, 21,1,1) tooltip:"Texture Search"
button btn3 "" width:24 height:24 pos:[68,10] images:#("g9_MaterialIcons.jpg", undefined, 20, 3, 21,1,1) tooltip:"Kill Material"
button btn4 "" width:24 height:24 pos:[97,10] images:#("g9_MaterialIcons.jpg", undefined, 20, 4, 21,1,1) tooltip:"Tile Mapper"
button btn5 "" width:24 height:24 pos:[126,10] images:#("g9_MaterialIcons.jpg", undefined, 20, 5, 21,1,1) tooltip:"Ortho Material Fix"
button btn6 "" width:24 height:24 pos:[155,10] images:#("g9_MaterialIcons.jpg", undefined, 20, 6, 21,1,1) tooltip:"Photoshop Bitmap Open"
button btn7 "" width:24 height:24 pos:[184,10] images:#("g9_MaterialIcons.jpg", undefined, 20, 7, 21,1,1) tooltip:"Map Collector"
button btn8 "" width:24 height:24 pos:[213,10] images:#("g9_MaterialIcons.jpg", undefined, 20, 8, 21,1,1) tooltip:"Collapse Sub Object Material"
button btn9 "" width:24 height:24 pos:[242,10] images:#("g9_MaterialIcons.jpg", undefined, 20, 9, 21,1,1) tooltip:"Material Control"
button btn10 "" width:24 height:24 pos:[271,10] images:#("g9_MaterialIcons.jpg", undefined, 20, 10, 21,1,1) tooltip:"Turn Viewport Maps On/Off"

button btn11 "" width:24 height:24 pos:[10,39] images:#("g9_MaterialIcons.jpg", undefined, 20, 11, 21,1,1) tooltip:"Remove Maps Channel"
button btn12 "" width:24 height:24 pos:[39,39] images:#("g9_MaterialIcons.jpg", undefined, 20, 12, 21,1,1) tooltip:"Get Material from Selection"
button btn13 "" width:24 height:24 pos:[68,39] images:#("g9_MaterialIcons.jpg", undefined, 20, 13, 21,1,1) tooltip:"ID Changer"
button btn14 "" width:24 height:24 pos:[97,39] images:#("g9_MaterialIcons.jpg", undefined, 20, 14, 21,1,1) tooltip:"Auto Flatten Mapping"
button btn15 "" width:24 height:24 pos:[126,39] images:#("g9_MaterialIcons.jpg", undefined, 20, 15, 21,1,1) tooltip:"Material"
button btn16 "" width:24 height:24 pos:[155,39] images:#("g9_MaterialIcons.jpg", undefined, 20, 16, 21,1,1) tooltip:"UVW Mapping"
button btn17 "" width:24 height:24 pos:[184,39] images:#("g9_MaterialIcons.jpg", undefined, 20, 17, 21,1,1) tooltip:"Unwrap UVW"
button btn18 "" width:24 height:24 pos:[213,39] images:#("g9_MaterialIcons.jpg", undefined, 20, 18, 21,1,1) tooltip:"UVW XForm"

	

on btn1 pressed do
	(
	macros.run "Gueshni" "ClearMaterialEditor"
	)	

on btn2 pressed do
	(
	macros.run "Gueshni" "TextureSearch"
	)	

on btn3 pressed do
	(
	macros.run "Gueshni" "KillMaterial"
	)	

on btn4 pressed do
	(
	macros.run "Gueshni" "TileMapper"
	)	

on btn5 pressed do
	(
	macros.run "Gueshni" "OrthoMaterialFix"
	)	

on btn6 pressed do
	(
	macros.run "Gueshni" "PhotoshopBitmapOpen"
	)	

on btn7 pressed do
	(
	macros.run "Gueshni" "MapCollector"
	)	

on btn8 pressed do
	(
	macros.run "Gueshni" "CollapseSubObjectMaterial"
	)	

on btn9 pressed do
	(
	macros.run "Gueshni" "MaterialControl"
	)	

on btn10 pressed do
	(
	macros.run "Gueshni" "TurnViewportMapsOnOff"
	)	

on btn11 pressed do
	(
	macros.run "Gueshni" "RemoveMapsChannel"
	)	

on btn12 pressed do
	(
	macros.run "Gueshni" "GetMaterialFromSelection"
	)	

on btn13 pressed do
	(
	macros.run "Gueshni" "IDChanger"
	)	

on btn14 pressed do
	(
	macros.run "Gueshni" "AutoFlattenMapping"
	)

on btn15 pressed do
	(
	modPanel.addModToSelection (Materialmodifier ()) ui:on
	)	

on btn16 pressed do
	(
	modPanel.addModToSelection (Uvwmap ()) ui:on
	)	

on btn17 pressed do
	(
-- 	.coords.U_Tiling = 10
-- 	.coords.V_Tiling = 10
	modPanel.addModToSelection (Unwrap_UVW ()) ui:on
	)	

on btn18 pressed do
	(
	modPanel.addModToSelection (UVW_Xform ()) ui:on
	)	

	
)								-- end rollout MATERIEL


rollout deformers "Deformers"
(
button btn1 "" width:24 height:24 pos:[10,10] across:1  images:#("g9_DeformerIcons.jpg", undefined, 20, 1, 21,1,1) tooltip:"Bend"
button btn2 "" width:24 height:24 pos:[39,10] images:#("g9_DeformerIcons.jpg", undefined, 20, 2, 21,1,1) tooltip:"Taper"	
button btn3 "" width:24 height:24 pos:[68,10] images:#("g9_DeformerIcons.jpg", undefined, 20, 3, 21,1,1) tooltip:"Skew"	
button btn4 "" width:24 height:24 pos:[97,10] images:#("g9_DeformerIcons.jpg", undefined, 20, 4, 21,1,1) tooltip:"Twist"		
button btn5 "" width:24 height:24 pos:[126,10] images:#("g9_DeformerIcons.jpg", undefined, 20, 5, 21,1,1) tooltip:"Stretch"		
button btn6 "" width:24 height:24 pos:[155,10] images:#("g9_DeformerIcons.jpg", undefined, 20, 6, 21,1,1) tooltip:"Squeeze"		
button btn7 "" width:24 height:24 pos:[184,10] images:#("g9_DeformerIcons.jpg", undefined, 20, 7, 21,1,1) tooltip:"Noise"		
button btn8 "" width:24 height:24 pos:[213,10] images:#("g9_DeformerIcons.jpg", undefined, 20, 8, 21,1,1) tooltip:"Wave"		
button btn9 "" width:24 height:24 pos:[242,10] images:#("g9_DeformerIcons.jpg", undefined, 20, 9, 21,1,1) tooltip:"Ripple"		
button btn10 "" width:24 height:24 pos:[271,10] images:#("g9_DeformerIcons.jpg", undefined, 20, 10, 21,1,1) tooltip:"Melt"
	
button btn11 "" width:24 height:24 pos:[10,39] images:#("g9_DeformerIcons.jpg", undefined, 20, 11, 21,1,1) tooltip:"Spherify"
button btn12 "" width:24 height:24 pos:[39,39] images:#("g9_DeformerIcons.jpg", undefined, 20, 12, 21,1,1) tooltip:"Push"	
button btn13 "" width:24 height:24 pos:[68,39] images:#("g9_DeformerIcons.jpg", undefined, 20, 13, 21,1,1) tooltip:"Relax"	
button btn14 "" width:24 height:24 pos:[97,39] images:#("g9_DeformerIcons.jpg", undefined, 20, 14, 21,1,1) tooltip:"Displace"		
button btn15 "" width:24 height:24 pos:[126,39] images:#("g9_DeformerIcons.jpg", undefined, 20, 15, 21,1,1) tooltip:"Lattice"
button btn16 "" width:24 height:24 pos:[155,39] images:#("g9_DeformerIcons.jpg", undefined, 20, 16, 21,1,1) tooltip:"FFD 2x2x2"
button btn17 "" width:24 height:24 pos:[184,39] images:#("g9_DeformerIcons.jpg", undefined, 20, 17, 21,1,1) tooltip:"FFD 3x3x3"
button btn18 "" width:24 height:24 pos:[213,39] images:#("g9_DeformerIcons.jpg", undefined, 20, 18, 21,1,1) tooltip:"FFD 4x4x4"

on btn1 pressed do
	(
	modPanel.addModToSelection (Bend ()) ui:on
	)
	
on btn2 pressed do
	(
	modPanel.addModToSelection (Taper ()) ui:on
	)
	
on btn3 pressed do
	(
	modPanel.addModToSelection (Skew ()) ui:on
	)
	
on btn4 pressed do
	(
	modPanel.addModToSelection (Twist ()) ui:on
	)
	
on btn5 pressed do
	(
	modPanel.addModToSelection (Stretch ()) ui:on
	)
	
on btn6 pressed do
	(
	modPanel.addModToSelection (Squeeze ()) ui:on
	)
	
on btn7 pressed do
	(
	modPanel.addModToSelection (Noisemodifier ()) ui:on
	)
	
on btn8 pressed do
	(
	modPanel.addModToSelection (Wave ()) ui:on
	)
	
on btn9 pressed do
	(
	modPanel.addModToSelection (Ripple ()) ui:on
	)
	
on btn10 pressed do
	(
	modPanel.addModToSelection (Melt ()) ui:on
	)
	
on btn11 pressed do
	(
	modPanel.addModToSelection (Spherify ()) ui:on
	)
	
on btn12 pressed do
	(
	modPanel.addModToSelection (Push ()) ui:on
	)
	
on btn13 pressed do
	(
	modPanel.addModToSelection (Relax ()) ui:on
	)
	
on btn14 pressed do
	(
	modPanel.addModToSelection (Displace ()) ui:on
	)
	
on btn15 pressed do
	(
	modPanel.addModToSelection (Lattice ()) ui:on
		(
		$.modifiers[#Lattice].Strut_Radius = 0.01
		$.modifiers[#Lattice].Joint_Radius = 0.01
		)
	)
	
on btn16 pressed do
	(
	modPanel.addModToSelection (FFD_2x2x2 ()) ui:on
	)
	
on btn17 pressed do
	(
	modPanel.addModToSelection (FFD_3x3x3 ()) ui:on
	)
	
on btn18 pressed do
	(
	modPanel.addModToSelection (FFD_4x4x4 ()) ui:on
	)	

)								-- end rollout DEFORMERS




rollout veget "Veget & Road"
(
button btn1 "" width:24 height:24 pos:[10,10] across:1  images:#("g9_VegetRoadIcons.jpg", undefined, 20, 1, 21,1,1) tooltip:"Veget Brush" 
button btn2 "" width:24 height:24 pos:[39,10] images:#("g9_VegetRoadIcons.jpg", undefined, 20, 2, 21,1,1) tooltip:"Planter"
button btn3 "" width:24 height:24 pos:[68,10] images:#("g9_VegetRoadIcons.jpg", undefined, 20, 3, 21,1,1) tooltip:"Veget"
button btn4 "" width:24 height:24 pos:[97,10] images:#("g9_VegetRoadIcons.jpg", undefined, 20, 4, 21,1,1) tooltip:"Altimetrizator"
button btn5 "" width:24 height:24 pos:[126,10] images:#("g9_VegetRoadIcons.jpg", undefined, 20, 5, 21,1,1) tooltip:"Glue"
button btn6 "" width:24 height:24 pos:[155,10] images:#("g9_VegetRoadIcons.jpg", undefined, 20, 6, 21,1,1) tooltip:"Mesh Sort"
button btn7 "" width:24 height:24 pos:[184,10] images:#("g9_VegetRoadIcons.jpg", undefined, 20, 7, 21,1,1) tooltip:"Decouper"
button btn8 "" width:24 height:24 pos:[213,10] images:#("g9_VegetRoadIcons.jpg", undefined, 20, 8, 21,1,1) tooltip:"Marquage"






on btn1 pressed do
	(
	macros.run "Gueshni" "VegetBrush"
	)	

on btn2 pressed do
	(
	macros.run "Gueshni" "Planter"
	)	

on btn3 pressed do
	(
	macros.run "Gueshni" "Veget"
	)	

on btn4 pressed do
	(
	macros.run "Gueshni" "Altimetrizator"
	)		

on btn5 pressed do
	(
	macros.run "Gueshni" "Glue"
	)		

on btn6 pressed do
	(
	macros.run "Gueshni" "MeshSort"
	)		

on btn7 pressed do
	(
	macros.run "Gueshni" "Decouper"
	)		

on btn8 pressed do
	(
	macros.run "Gueshni" "Marquage"
	)		

)								-- end rollout VEGET & ROAD



rollout zkelet "Skeleton"
(
button btn1 "" width:24 height:24 pos:[10,10] across:1  images:#("g9_SkeletonIcons.jpg", undefined, 20, 1, 21,1,1) tooltip:"Create Bones" 
button btn2 "" width:24 height:24 pos:[39,10] across:1  images:#("g9_SkeletonIcons.jpg", undefined, 20, 2, 21,1,1) tooltip:"IK Chain - type HI" 
button btn3 "" width:24 height:24 pos:[68,10] across:1  images:#("g9_SkeletonIcons.jpg", undefined, 20, 3, 21,1,1) tooltip:"IK Chain - type HD" 
button btn4 "" width:24 height:24 pos:[97,10] across:1  images:#("g9_SkeletonIcons.jpg", undefined, 20, 4, 21,1,1) tooltip:"Path Constraint" 
button btn5 "" width:24 height:24 pos:[126,10] across:1  images:#("g9_SkeletonIcons.jpg", undefined, 20, 5, 21,1,1) tooltip:"Position Constraint" 
button btn6 "" width:24 height:24 pos:[155,10] across:1  images:#("g9_SkeletonIcons.jpg", undefined, 20, 6, 21,1,1) tooltip:"Link Constraint" 
button btn7 "" width:24 height:24 pos:[184,10] across:1  images:#("g9_SkeletonIcons.jpg", undefined, 20, 7, 21,1,1) tooltip:"LookAt Constraint" 
button btn8 "" width:24 height:24 pos:[213,10] across:1  images:#("g9_SkeletonIcons.jpg", undefined, 20, 8, 21,1,1) tooltip:"Orientation Constraint" 
button btn9 "" width:24 height:24 pos:[242,10] across:1  images:#("g9_SkeletonIcons.jpg", undefined, 20, 9, 21,1,1) tooltip:"Reaction Manager" 





on btn1 pressed do
	(
	StartObjectCreation Bones
	)	

on btn2 pressed do
	(
	macros.run "Inverse Kinematics" "HI_IK"
	)	

on btn3 pressed do
	(
	macros.run "Inverse Kinematics" "HD_IK"
	)	

on btn4 pressed do
	(
	macros.run "Constraints" "Path"
	)	

on btn5 pressed do
	(
	macros.run "Constraints" "Position_Constraint"
	)	

on btn6 pressed do
	(
	macros.run "Constraints" "LinkConstraint"
	)	

on btn7 pressed do
	(
	macros.run "Constraints" "LookAt"
	)	

on btn8 pressed do
	(
	macros.run "Constraints" "Orientation_Constraint"
	)

on btn9 pressed do
	(
	macros.run "Animation Tools" "OpenReactionManager"
	)


)								-- end rollout SKELETON


rollout anym "Animation"
(
button btn1 "" width:24 height:24 pos:[10,10] across:1  images:#("g9_AnimationIcons.jpg", undefined, 20, 1, 21,1,1) tooltip:"Trafic" 
button btn2 "" width:24 height:24 pos:[39,10] across:1  images:#("g9_AnimationIcons.jpg", undefined, 20, 2, 21,1,1) tooltip:"ShiftKey" 
button btn3 "" width:24 height:24 pos:[68,10] across:1  images:#("g9_AnimationIcons.jpg", undefined, 20, 3, 21,1,1) tooltip:"SpeedoMeter" 
button btn4 "" width:24 height:24 pos:[97,10] across:1  images:#("g9_AnimationIcons.jpg", undefined, 20, 4, 21,1,1) tooltip:"Reverse Time" 
button btn5 "" width:24 height:24 pos:[126,10] across:1  images:#("g9_AnimationIcons.jpg", undefined, 20, 5, 21,1,1) tooltip:"Linear Controllers Assign" 
button btn6 "" width:24 height:24 pos:[155,10] across:1  images:#("g9_AnimationIcons.jpg", undefined, 20, 6, 21,1,1) tooltip:"XYZ Controllers Assign" 





on btn1 pressed do
	(
	macros.run "Gueshni" "Trafic"
	)	

on btn2 pressed do
	(
	macros.run "Gueshni" "ShiftKey"
	)	

on btn3 pressed do
	(
	macros.run "Gueshni" "SpeedoMeter"
	)	

on btn4 pressed do
	(
	macros.run "Gueshni" "ReverseTimeMacro"
	)	

on btn5 pressed do
	(
	macros.run "Gueshni" "LinearControllersAssign"
	)	

on btn6 pressed do
	(
	macros.run "Gueshni" "XYZControllersAssign"
	)


)								-- end rollout ANIMATION







if toolG9wind != undefined do 
            ( 
            closerolloutfloater toolG9wind
            )       

toolG9wind = newRolloutFloater "Gueshni Toolbox" 320 1025 3310 5
-- addRollout imaj toolG9wind 
addRollout systm toolG9wind
addRollout toolz toolG9wind rolledup: on
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
addRollout deformers toolG9wind rolledup: on
addRollout veget toolG9wind rolledup: on
addRollout zkelet toolG9wind rolledup: on
addRollout anym toolG9wind rolledup: on
			
)					--end macro