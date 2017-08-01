
-- V2.1
-- name = _04A34542008_--A_DEF01_BLEED002


(
	clearListener()
	mySeuil = 0.1
	myResult  =  #()
	for bla in geometry do
	(
		myCompName = bla.name
		myComp = getNodeByName myCompName
		myRef = #(myComp,myCompName,myComp.center,(distance myComp.max myComp.min))
		for obj in geometry do
		(
			myCollect = true
			if not ((obj.center.x > myComp.center.x - mySeuil) and (obj.center.x < myComp.center.x + mySeuil)) then myCollect = False
			if not (obj.center.y > myComp.center.y - mySeuil and obj.center.y < myComp.center.y + mySeuil) then myCollect = False
			if not (obj.center.z > myComp.center.z - mySeuil and obj.center.z < myComp.center.z + mySeuil) then myCollect = False
			if myCollect == true then appendIfUnique myResult obj
		)
	)
	select myResult
)



-- v3

(
	clearListener()
	mySeuil = 0.1
	myResult  =  #()
	fn myCompare x y =
	(
		if x[1] > y[1] then 1 else -1
	)
	theList = for obj in geometry collect #(obj.center.x,obj.center.y,obj.center.z,obj)
	qsort theList myCompare
	-- theList = theListRef


	-- for obj in theList do format "%\r" obj

	for obj in theList do
	(
		for bla in theList do
		(
			myCollect = true
			if not ((bla[1] > obj[1] - mySeuil) and (bla[1] < obj[1] + mySeuil)) then myCollect = False
			if not ((bla[2] > obj[2] - mySeuil) and (bla[2] < obj[2] + mySeuil)) then myCollect = False
			if not ((bla[2] > obj[2] - mySeuil) and (bla[2] < obj[2] + mySeuil)) then myCollect = False
			if myCollect == true then append myResult obj[4]
		)
	)
	select myResult
)



-- v4

(
	clearListener()
	clearSelection()
	mySeuil = 0.1
	myResult  =  #()
	fn myCompare x y =
	(
		if x[1] > y[1] then 1 else -1
	)
	theList = for obj in geometry collect #(distance obj.max obj.min,obj,obj.center.x)
	qsort theList myCompare
	-- theList = theListRef


	-- for obj in theList do format "%\r" obj

	for obj in theList do
	(
		for bla in theList do
		(
			if obj[1] > bla[1]-mySeuil and obj[1] < bla[1]+mySeuil and obj[2].name != bla[2].name and obj[3] > bla[3] - mySeuil and obj[3] < bla[3] + mySeuil  then append myResult obj[2]
		)
	)
	select myResult
)




-- v5

(
	clearListener()
	clearSelection()
	mySeuil = 0.1
	myResult  =  #()
	fn myCompare x y =
	(
		if x[1] > y[1] then 1 else -1
	)
	theList = for obj in geometry collect #(obj.center.x,obj)
	qsort theList myCompare
	-- theList = theListRef


	-- for obj in theList do format "%\r" obj


	for obj in geometry do
	(
		for bla in theList do
		(
			if obj.center.x > bla[1] - mySeuil and obj.center.x < bla[1] + mySeuil and obj.name != bla[2].name do append myResult obj
		)
	)
	

	select myResult
)
