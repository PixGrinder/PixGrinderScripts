
-- V3 --



-- Select objects which have keyframes after  -- 
/*

(
	clearSelection()
	myStartFrame = 10000
	x1 = geometry as array + helpers as array
	myPos = for obj in x1 where (numKeys obj.position.controller > 0) and (obj.pos.controller.keys[obj.position.controller.keys.count].time > myStartFrame ) collect obj
	myRot = for obj in x1 where (numKeys obj.rotation.controller > 0) and (obj.rotation.controller.keys[obj.rotation.controller.keys.count].time > myStartFrame ) collect obj
	mySca = for obj in x1 where (numKeys obj.scale.controller > 0) and (obj.scale.controller.keys[obj.scale.controller.keys.count].time > myStartFrame ) collect obj
	myAnimated = myPos+myRot+mySca
	myAnimated = makeUniqueArray myAnimated
	select myAnimated
)

*/



clearListener()
clearSelection()

rollout pdaMoveAnims "Move Anim Keys"
(
	label lblS "Start" cross:2
	label lblE "End"

	spinner sFrame "" range:[-50000,50000,0] type:#integer 
	spinner eFrame "" range:[-50000,50000,100] type:#integer
	spinner pdaOffset "Offset" range:[-50000,50000,10] type:#integer
	button myBtn "Move Keys" width:150

	on myBtn pressed do
	(
		mySelec = for obj in objects where obj.layer.on collect obj
		deselectkeys mySelec
		selectkeys mySelec sFrame.value eFrame.value
		moveKeys mySelec pdaOffSet.value #selection
	)

)

createDialog pdaMoveAnims




/*

mySelec = selection as array


theThreshold = 50


theThreshold = theThreshold - 1
myI = 1
myA = myI + theThreshold
myCond = on

while myCond == on do 
(	
	if myA < mySelec.count then
	(
		myArray = #()
		for i = myI to myA do append myArray mySelec[i]
		pdaMoveKeys 10000f 11000f -4000f myArray
		print myArray.count
		myI = myI + theThreshold
		myA = myA + theThreshold
	) else (
		myArray = #()
		for i = myI to mySelec.count do append myArray mySelec[i]
		pdaMoveKeys 10000f 11000f -4000f myArray
		print myArray.count
		--for obj in myArray do print "vla"
		myCond = off
	)
)
*/
