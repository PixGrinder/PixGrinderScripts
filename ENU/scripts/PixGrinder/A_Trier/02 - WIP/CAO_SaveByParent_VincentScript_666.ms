
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

