-- PBR Compare -- 

try (DestroyDialog CompareObjects) catch ()

maxFileMerge = maxfilepath + "H225_Comploc_Prepared.max"
myGeo = (for obj in geometry where (matchpattern obj.name pattern:"*_CollisionMesh*" == false) and (matchpattern obj.name pattern:"*_Volume*" == false) collect obj)
myCol = (for obj in geometry where (matchpattern obj.name pattern:"*_CollisionMesh*") or (matchpattern obj.name pattern:"*_Volume*") collect obj)


-- meshDatas = for obj in geometry collect #(getNumFaces obj.mesh, obj)

fn compareName v1 v2 =
(
	if v1.name > v2.name then 1 else -1
)

fn mySelNext = 
(
	myVisu = for obj in objects where obj.isHidden == false collect obj
	if objects.count == 0 then messageBox("No objects in scene !!") else
	(	
		-- Total reBuild --
		---------------------------------------------------------------------------
		if selection.count == 0 then (x1 = 0) else (x1 = finditem myVisu selection[1])
		if x1 < myVisu.count then select myVisu[x1+1] else select myVisu[1]
		---------------------------------------------------------------------------
	)
)


fn ComparePreparedScene = 
(
	if myMerged != undefined do 
	(
		delete myMerged
		free myMerged
	)
	if selection.count > 0 then 
	(
		firstCenter = selection.center
		if SelectionSets["___Verified___"] == undefined then 
		(
			SelectionSets["___Verified___"] = selection as array 
		) else (
			myVerifiedObj = for obj in SelectionSets["___Verified___"] collect obj
			SelectionSets["___Verified___"] = myVerifiedObj + (selection as array)
		)
		InitSel = selection as array
		SelectionSets["_myCurrentTarget_"] = InitSel
		--qsort InitSel compareName
		myList = for obj in InitSel collect obj.name
		max hide inv
		clearSelection()
		mergeMAXFile maxFileMerge myList #select #mergeDups #useMergedMtlDups #neverReparent
		myMerged = selection as array
		meditmaterials[2] = myMerged[1].material
		select myMerged
		myDum = macros.run "-- PixGrinder --" "BboxDummyMaker"
		myDum.name = ("A_VIRER - " +  myMerged[1].name)
		myMerged.parent = myDum
		myDecal = (myDum.max.y - myDum.min.y) + 1.0
		myDum.pos = myDum.pos + [0.0, -myDecal, 0.0]
		hide helpers
		myDum.isHidden = off
		if SelectionSets["__Imported_To_delete__"] == undefined then
		(
			SelectionSets["__Imported_To_delete__"] = myMerged + #(myDum)
		) else (
			myImp = for obj in SelectionSets["__Imported_To_delete__"] collect obj
			SelectionSets["__Imported_To_delete__"] = myImp + myMerged + #(myDum)
		)
	) else (messagebox("Please select objects to compare") )
)

fn distSort v1 v2 =
(
	if v1[1] > v2[1] then 1 else -1
)

fn nextItem = 
(
	myAr = #()
	visGeo = for obj in myGeo where (obj.isHidden == off) collect obj
	if selection.count <= 1 and visGeo.count >= 2 then 
	(
		mySelNext()
	) else (
		myCoord = selection.center
		max unhide all
		hide selection
		hide myCol
		visGeo = for obj in myGeo where (obj.isHidden == off) collect obj
		myDistCheck = for obj in visGeo collect #(distance obj.center myCoord, obj)
		qsort myDistCheck distSort
		select myDistCheck[2][2]
	)
)

rollout CompareObjects "Compare Objects"
(
	button btn_next "Next" offset:[0,10]
	spinner myDist "Radius Select" range:[0.01,100.0,0.1] type:#float scale:0.1 fieldWidth:40 offset:[-10,10]
	button btn_Compare "Compare" width:100 height:50 offset:[0,10]
	button btnFocusComp "Focus current objects" offset:[0,10]
	button btn_HideCompared "Hide Compared" offset:[0,10]
	button btn_DelImported "Delete Imported" offset:[0,10]
	button btn_ExludeVerified "Exclude from Verified" offset:[0,10]
	button btn_unHideRem "Show Remaining" offset:[0,10]
	

	on btn_HideCompared pressed do if SelectionSets["___Verified___"] != undefined then hide SelectionSets["___Verified___"]
	
	on btn_unHideRem pressed do 
	(
		clearSelection()
		max unhide all
		hide SelectionSets["___Verified___"]
		hide helpers
	)
	
	on btn_ExludeVerified pressed do 
	(
		if SelectionSets["___Verified___"] != undefined then
		( 
			myAr = #()
			myVerifiedStack = for obj in SelectionSets["___Verified___"] collect obj
			-----------------------------------------------
			blurf = selection as array
			for obj in blurf do append myAr (findItem myVerifiedStack obj)
			for rem in myAr do deleteItem myVerifiedStack rem
			SelectionSets["___Verified___"] = #()
			SelectionSets["___Verified___"] = myVerifiedStack

			free myVerifiedStack
			free myAr
			-----------------------------------------------
		)
	)

	on btn_DelImported pressed do delete SelectionSets["__Imported_To_delete__"]
	
	on btnFocusComp pressed do 
	(
		if SelectionSets["__Imported_To_delete__"] != undefined and unhide SelectionSets["_myCurrentTarget_"] != undefined then
		(
			clearSelection()
			max hide inv
			unhide SelectionSets["__Imported_To_delete__"]
			unhide SelectionSets["_myCurrentTarget_"]
			max select all
			max zoomext sel
		)
	)


	on btn_Compare pressed do
	(
		ComparePreparedScene()
	)


	on btn_next pressed do 
	(
		hide myCol
		nextItem()
		max zoomext sel
		--select x1
	)

	on myDist changed state do 
	(
		hide myCol
		if selection.count != 0 then 
		(
			for obj in myGeo do
			(
				if (distance $.center obj.center) < myDist.value then obj.isHidden = false else obj.isHidden = true
			)
		)
	)

	on myDist buttonup do if selection.count != 0 then 
	(
		CompareObjects.myDist.value = 0.1
		hide helpers
		max select all
		max zoomext sel
	)
	-- 	on myDist buttonup [<inCancel_arg>] do <expr> 
)


createDialog CompareObjects




