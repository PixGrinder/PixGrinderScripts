(



	rollout imaj ""
	(
	bitmap the_bmp fileName:"ImageBG.jpg"
		
	)								-- end rollout IMAGE


	rollout systm "System"
	(
		button btn1 "" width:24 height:24 pos:[10,10] across:1  images:#("g9_SystemIcons.jpg", undefined, 20, 1, 1,1,1) tooltip:"Snap Windows"
		on btn1 pressed do macros.run "- Gueshni -" "SnapWindows"
	)								-- end rollout SYSTEM


	rollout ui "UI"
	(
		button btn1 "" width:24 height:24 pos:[10,10] across:1  images:#("g9_UIIcons.jpg", undefined, 20, 1, 1,1,1) tooltip:"Align Viewport to Face"
		on btn1 pressed do macros.run "- Gueshni -" "AlignViewportToFace"
	)								-- end rollout UI



	rollout pivo "Pivot"
	(
		button btn1 "" width:24 height:24 pos:[10,10] across:1  images:#("g9_PivotIcons.jpg", undefined, 20, 1, 1,1,1) tooltip:"Center Pivot"
		button btn2 "" width:24 height:24 pos:[39,10] images:#("g9_PivotIcons.jpg", undefined, 20, 2, 2,1,1) tooltip:"Align Pivot to Minimum"
		button btn3 "" width:24 height:24 pos:[68,10] images:#("g9_PivotIcons.jpg", undefined, 20, 3, 3,1,1) tooltip:"Easy Pivot"
		button btn4 "" width:24 height:24 pos:[97,10] images:#("g9_PivotIcons.jpg", undefined, 20, 4, 4,1,1) tooltip:"Align Pivot to Direction"
		button btn5 "" width:24 height:24 pos:[126,10] images:#("g9_PivotIcons.jpg", undefined, 20, 5, 5,1,1) tooltip:"Fit Bounding Box"
		on btn1 pressed do macros.run "- Gueshni -" "CenterPivot"		
		on btn2 pressed do macros.run "- Gueshni -" "AlignPivotToMin"
		on btn3 pressed do macros.run "- Gueshni -" "EasyPivot"
		on btn4 pressed do macros.run "- Gueshni -" "AlignPivot2Direction"
		on btn5 pressed do macros.run "- Gueshni -" "FitBoundingBox"
	)								-- end rollout PIVOT



	rollout clection "Selection"
	(
		button btn1 "" width:24 height:24 pos:[10,10] across:1  images:#("g9_SelectionIcons.jpg", undefined, 20, 1, 1,1,1) tooltip:"Select by Pair" 															
		button btn2 "" width:24 height:24 pos:[39,10] images:#("g9_SelectionIcons.jpg", undefined, 20, 2, 2,1,1) tooltip:"Random Select"																						
		button btn3 "" width:24 height:24 pos:[68,10] images:#("g9_SelectionIcons.jpg", undefined, 20, 3, 3,1,1) tooltip:"Select Object with No Material"								
		button btn4 "" width:24 height:24 pos:[97,10] images:#("g9_SelectionIcons.jpg", undefined, 20, 4, 4,1,1) tooltip:"Random Face Select"															
		button btn5 "" width:24 height:24 pos:[126,10] images:#("g9_SelectionIcons.jpg", undefined, 20, 5, 5,1,1) tooltip:"Select Empty Objects" 
		on btn1 pressed do macros.run "- Gueshni -" "SelectByPair"
		on btn2 pressed do macros.run "- Gueshni -" "RandomSelect"
		on btn3 pressed do macros.run "- Gueshni -" "SelectNoMaterial"
		on btn4 pressed do macros.run "- Gueshni -" "RandomFaceSelect"
		on btn5 pressed do macros.run "- Gueshni -" "SelectEmptyObject"
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
		on btn1 pressed do StartObjectCreation Box
		on btn2 pressed do StartObjectCreation Sphere
		on btn3 pressed do StartObjectCreation Cylinder
		on btn4 pressed do StartObjectCreation Torus
		on btn5 pressed do StartObjectCreation Cone
		on btn6 pressed do StartObjectCreation GeoSphere
		on btn7 pressed do StartObjectCreation Tube
		on btn8 pressed do StartObjectCreation Pyramid
		on btn9 pressed do StartObjectCreation Plane
		on btn10 pressed do StartObjectCreation Hedra
		on btn11 pressed do StartObjectCreation ChamferBox
		on btn12 pressed do StartObjectCreation Oiltank
		on btn13 pressed do StartObjectCreation ChamferCyl
		on btn14 pressed do StartObjectCreation Spindle
		on btn15 pressed do StartObjectCreation Gengon
		on btn16 pressed do StartObjectCreation RingWave
		on btn17 pressed do StartObjectCreation Torus_Knot
		on btn18 pressed do StartObjectCreation Capsule
	)								-- end rollout CREATE OBJECT




	if toolG9wind != undefined do closerolloutfloater toolG9wind
  

	toolG9wind = newRolloutFloater "Gueshni Toolbox" 320 950 2500 5
	-- addRollout imaj toolG9wind 
	addRollout systm toolG9wind 
	addRollout ui toolG9wind
	addRollout pivo toolG9wind
	addRollout clection toolG9wind rolledup: on
			
)					--end macro