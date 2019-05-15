
---------------------------------------------------------------------

-- PixGrinder Scripts --
-- List Hierarchy with Anim Ranges --
-- List_Hierarchy_withAnimRanges.ms --
-- Lists selected hierarchy in the Listener with anim ranges for animated objects --
-- V 1.0 --
-- Mail : pixgrinder@gmail.com --

---------------------------------------------------------------------

(
	clearListener()
	--theCondition = false


	fn sortByName v1 v2= 
	(
		if v1.name > v2.name then 1 else -1
	)

	fn testHier node level  =
	(
		x1=""
		for i = 1 to level do x1 = x1+"    "
		--format "%%%" x1 node.name "\r"

		myAnimList = #()
		theKeys = #()
		pda_animError = false
		if node.isAnimated then 
		(
			if numKeys node.position.controller > 0 do for p in node.position.controller.keys do append theKeys p.time
			if numKeys node.rotation.controller > 0 do for r in node.rotation.controller.keys do append theKeys r.time
			if numKeys node.scale.controller > 0 do for s in node.scale.controller.keys do append theKeys s.time
	
			if numKeys node.position.controller == -1 then pda_animError = true
			if numKeys node.rotation.controller == -1 then pda_animError = true
			if numKeys node.scale.controller == -1 then pda_animError = true
			
			if theKeys.count > 1 then 
			(
				sort theKeys
				myAnimList[1] = (node.name + ";" + ((theKeys[1] as integer / 160) as string) + ";" + ((theKeys[theKeys.count] as integer / 160) as string)) 
			)
	
			if pda_animError == true then myAnimList[1] = (node.name + ";0;0")
		) else (myAnimList[1] = node.name)

		format "%%\r" (x1 as string) myAnimList[1]
		theLevel = level
		if node.children.count != 0 do 
		(
			theArray = for obj in node.children collect obj
			qsort theArray sortByName
			theLevel = theLevel+1
			for bla in theArray do testHier bla theLevel
		)

	)

	theStart = for obj in selection where finditem (selection as array) obj.parent == 0 collect obj
	qsort theStart sortByName

	for obj in theStart do testHier obj 1 --theFile
	format "\r\r---- End of List ----\r\r"
	actionMan.executeAction 0 "40472"
)