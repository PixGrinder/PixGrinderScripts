
-- V2.1
-- name = _04A34542008_--A_DEF01_BLEED002



-- v5

(
	clearListener()
	clearSelection()
	mySeuil = 0.01
	myResult  =  #()
	fn myCompare x y =
	(
		if x[1] > y[1] then 1 else -1
	)
	theList = for obj in geometry collect #(obj.center.x,obj.center.y,obj.center.z,obj,obj.name, distance obj.min obj.max)
	qsort theList myCompare
	-- theList = theListRef


	-- for obj in theList do format "%\r" obj


	for obj in theList do
	(
		for bla in theList do
		(
			if (abs(obj[1]-bla[1]) <= mySeuil) and (abs(obj[2]-bla[2]) <= mySeuil) and (abs(obj[3]-bla[3]) <= mySeuil) and (abs(obj[6]-bla[6]) <= (mySeuil*5)) and obj[5] != bla[5] do append myResult obj[4]
		)
	)
	

	select myResult
)

-- select (getNodebyName "_04A34542008_--A_DEF01_BLEED002")


