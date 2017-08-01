-- name = _04A34542008_--A_DEF01_BLEED002

(

	clearListener()
	mySeuil = 0.1
	myCompName = "_04A34542008_--A_DEF01_BLEED002"

	myComp = getNodeByName myCompName

	myRef = #(myComp,myCompName,myComp.transform.position,(distance myComp.max myComp.min))

	myResult  =  #()

	for obj in geometry do
	(
		myCollect = true
		if not ((obj.center.x > myComp.center.x - mySeuil) and (obj.center.x < myComp.center.x + mySeuil)) then myCollect = False
		if not (obj.center.y > myComp.center.y - mySeuil and obj.center.y < myComp.center.y + mySeuil) then myCollect = False
		if not (obj.center.z > myComp.center.z - mySeuil and obj.center.z < myComp.center.z + mySeuil) then myCollect = False
		if myCollect == true then append myResult obj

	)

	select myResult

)

