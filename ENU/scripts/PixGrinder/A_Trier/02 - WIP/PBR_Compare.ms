-- PBR Compare -- 

-- macros.run "-- PixGrinder --" "PivotCenterPixGrinder"

maxFileMerge = maxfilepath + "H225_Comploc.max"

fn compareName v1 v2 =
(
	if v1.name > v2.name then 1 else -1
)

if selection.count > 0 then 
(
	firstCenter = selection.center
	if SelectionSets["___Verified___"] == undefined then 
	(
		SelectionSets["___Verified___"] = selection as array 
	) else (
		myVerifiedObj = for obj in SelectionSets["___Verified___"] collect obj
		appendifUnique myVerifiedObj selection
	)
	InitSel = selection as array
	qsort InitSel compareName
	myList = for obj in InitSel collect obj.name
	max hide inv
	clearSelection()
	mergeMAXFile maxFileMerge myList #select #mergeDups #useMergedMtlDups #neverReparent
	myMerged = selection as array
	qsort myMerged compareName
	for i = 1 to myMerged.count do
	(
		myMerged[i].transform = InitSel[i].transform
	)
	select myMerged
	myDum = macros.run "-- PixGrinder --" "BboxDummyMaker"
	myMerged.parent = myDum
	myDecal = (myDum.max.y - myDum.min.y) + 1.0
	myDum.pos = myDum.pos + [0.0, -myDecal, 0.0]
	-- delete myDum
	hide helpers
	myDum.isHidden = off
	-- 	macros.run "-- PixGrinder --" "Coord_World"
	-- move selection (firstCenter - mergedCenter)
	
)


