
-- Vincent Script --
-- To the Dolphin Rider -- 
	

-- Part Two -- 


	-- DisableSceneRedraw()
	viewport.setLayout #layout_4
	viewport.activeViewport = 4
	max tool maximize

	myAr = #()
	myPath = maxfilepath + "Helionix_Parts"+"\\"
	makeDir myPath
	
	-- fonction select hierarchy à partir du plus haut parent --
	fn selectHier v1 =
	(
		append myAr v1
		if v1.children.count != 0 then for obj in v1.children do append myAr obj
		for obj in v1.children do selectHier obj
		select myAr
	)

	fn mySort v1 v2 = 
	(
		if v1.name < v2.name then -1 else 1
	)

	-- supression des helpers sans parents ni enfants --
	for hlp in helpers where hlp.parent == undefined and hlp.children.count == 0 do delete hlp

	-- myRoots = tous les helpers à la racine de la scene
	myRoots = for hlp in helpers where hlp.parent == undefined collect hlp

	

	-- supression des hierarchies ne contenant QUE des helpers; sans geometry --
	for obj in myRoots do 
	(
		myAr = #()
		clearSelection()
		myState = false
		selectHier obj
		for bla in selection do if superclassof bla == GeometryClass then myState = true
		if myState == false then delete myAr
	)

--  Update de myRoots - myRoots = tous les helpers à la racine de la scene
	myRoots = for hlp in helpers where hlp.parent == undefined collect hlp

	qsort myRoots mySort
	
	for obj in myRoots do
	(
		myAr = #()
		clearSelection()
		selectHier obj
		hide objects
		for pde in myAr do pde.isHidden = false
		select myAr
		max zoomext sel all
		clearSelection()
		-- enableSceneRedraw()
		forceCompleteRedraw doDisabled:true
		--sleep 1
		savenodes myAr (myPath + myAr[1].name +".max")
		-- DisableSceneRedraw()
	
	)

	-- enableSceneRedraw()

