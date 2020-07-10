

-- Select objects which have keyframe after myStartFrame -- 
(
	clearSelection()
	myStartFrame = 11000
	x1 = geometry as array + helpers as array
	myPos = for obj in x1 where (numKeys obj.position.controller > 0) and (obj.pos.controller.keys[obj.position.controller.keys.count].time > myStartFrame ) collect obj
	myRot = for obj in x1 where (numKeys obj.rotation.controller > 0) and (obj.rotation.controller.keys[obj.rotation.controller.keys.count].time > myStartFrame ) collect obj
	mySca = for obj in x1 where (numKeys obj.scale.controller > 0) and (obj.scale.controller.keys[obj.scale.controller.keys.count].time > myStartFrame ) collect obj

	myAnimated = myPos+myRot+mySca
	myAnimated = makeUniqueArray myAnimated

	select myAnimated
)



----------------
-- Select objects with at least 1 keyframe
(
	clearSelection()
	--myStartFrame = 11000
	x1 = geometry as array + helpers as array
	myPos = for obj in x1 where (numKeys obj.position.controller > 0) collect obj
	myRot = for obj in x1 where (numKeys obj.rotation.controller > 0) collect obj
	mySca = for obj in x1 where (numKeys obj.scale.controller > 0) collect obj

	myAnimated = myPos+myRot+mySca
	myAnimated = makeUniqueArray myAnimated

	select myAnimated
)

-- select objects without XYZ controller
(
	x1 = geometry as array + helpers as array
	myPosCtrl =  for obj in x1 where classof obj.position.controller != Position_XYZ collect obj
	myRotCtrl =  for obj in x1 where classof obj.rotation.controller != Euler_XYZ and classof obj.rotation.controller != linear_rotation collect obj
	myScaCtrl =  for obj in x1 where classof obj.scale.controller != Bezier_Scale and classof obj.scale.controller != ScaleXYZ collect obj
	myAnimated = makeUniqueArray (myPosCtrl+myRotCtrl+myScaCtrl)
	select myAnimated
)



selectkeys selection 24f 100f
moveKeys selection -10f #selection


-------------------------------
reverseTime selection 14f 40f
/*
selectkeys selection 10000f 10600f
moveKeys selection -4000f
*/

-- deleteTime selection 27f 50f





/*




moveKeys <controller> <time> [#selection] Moves the specified keys by the time given. If #selection is specified, move the current selection otherwise move all keys. The moveKeys function only works on track properties: .controller and .track . It is not defined on the keys’ virtual array. 

EXAMPLES 
 
moveKeys $box01.pos.controller 5
moveKeys $box01.pos.track 5
 

moveKey <controller> <index_integer> <time> Move the indexed key by the specified time. 



*/







/*

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

*/


