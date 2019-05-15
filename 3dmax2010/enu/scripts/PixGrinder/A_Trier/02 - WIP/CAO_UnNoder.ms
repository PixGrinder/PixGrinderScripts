/*
(
	heapSize += 50000000
	undo off
	(
		
		DisableSceneRedraw()

		clearSelection()
		clearListener()


		for hlp in helpers where matchpattern hlp.name pattern:"object*" do
		(
			if hlp.children.count == 0 then (delete hlp) else
			(
				hlp.children[1].name = hlp.parent.name
				hlp.children[1].parent = hlp.parent
				delete hlp
			)
		)

		EnableSceneRedraw ()
	)

)
*/



/*
DisableSceneRedraw()
undo off

(
	clearListener()

	fn attachInHierarchy = 
	(
		for obj in geometry where obj.parent != undefined do
		(
			x1 = obj.parent
			convertToPoly x1.children[1]
			for i = 2 to x1.children.count do polyop.attach x1.children[1] x1.children[i]
		)
	)


	for hlp in helpers where matchpattern hlp.name pattern:"object*" and hlp.children.count == 0 do delete hlp
	
	attachInHierarchy()

	for obj in geometry where obj.parent != undefined and (obj.parent).parent != undefined do 
	(
		if matchpattern obj.parent.name pattern:"object*" then
		(
			p1 = obj.parent
			p2 = p1.parent
			obj.name = p2.name
			obj.parent = p2
			delete p1
		) 
	)

	attachInHierarchy()

	for obj in geometry where obj.parent != undefined do
	(
		if obj.name = obj.parent.name then 
		(
			x1 = obj.parent
			obj.parent = x1.parent
			delete x1
		)
	)

)
EnableSceneRedraw ()

*/
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

