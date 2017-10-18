
-- Vincent Script --
-- To the Dolphin Rider -- 


-- Part  One --

(
	units.DisplayType  = #Metric
	units.MetricType = #Millimeters
	units.SystemType = #Centimeters
	units.SystemScale = 10.0


	myMod = Vertex_Weld()
	myMod.threshold = 0.0001
	mySmooth = Smooth()
	mySmooth.threshold = 20
	mySmooth.autosmooth = true


	for obj in geometry do 
	(
		resetXForm obj
		convertToPoly obj
	)
	
	
	
	for obj in geometry do
	(
		
		addmodifier obj myMod
		addmodifier obj (Smooth())
		--maxOps.CollapseNodeTo obj 1 off
		convertToPoly obj
		obj.backfacecull = off
	)
)

		

-- Part Two -- 

(
	-- DisableSceneRedraw()
	viewport.setLayout #layout_4
	viewport.activeViewport = 4
	max tool maximize

	myAr = #()
	myPath = maxfilepath + "Helionix_Parts"+"\\"
	makeDir myPath
	fn selectHier v1 =
	(
		append myAr v1
		if v1.children.count != 0 then for obj in v1.children do append myAr obj
		for obj in v1.children do selectHier obj
		select myAr
	)

	
	for obj in objects where obj.parent == undefined and obj.children.count != 0 do
	(
		myAr = #()
		clearSelection()
		selectHier obj
		myCond = false
		for bla in myAr do if superclassof bla == GeometryClass then myCond = true
		if myCond == true then 
		(
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
	)

	-- enableSceneRedraw()
)

