
-- Part 1
(
	clearListener()
	max select none
	myPattern = "ATA_??-??_*" -- Texte à rechercher !
	pda = #()
	pda_final = #()
	-- collection de tous les composants :
	
	for i = 1 to 10 do 
	(
		select helpers
		max group open
	)
	
	for obj in objects do 
	(
		if superclassof obj != camera and matchpattern obj.name pattern:myPattern == true do appendifunique pda obj
	)
	
	for obj in pda do
	(
		if obj.children.count > 2 do 
		(
			append pda_final obj
			for i = 1 to obj.children.count do if superclassof obj.children[i] != camera do append pda_final obj.children[i]
			select obj
			max group close
		)
		-- if classof obj == ObjectSet do append obj pda_final
	)
	
	max select none
	max hide inv

	for obj in pda_final do obj.ishidden = false
	
)

-- Part 2
(
	clearListener()
	hide cameras
	max select all
	mySelec = getcurrentselection()
	myParents = #()
	pda=#()
	myTemp=#()
	myList=#()
	
	
	for i = 1 to 10 do 
	( 
		select helpers
		max group open
	)
	
	-- select all parents
	for obj in mySelec do 
	(
		if obj.children.count > 0 do append myParents obj
	)
	
	for obj in myParents do
	(
		if superclassof obj == helper then
		(
			append myTemp obj
		)
	)
	
	for i = 1 to myTemp.count do
	(
		myName = myTemp[i].name
		select myTemp[i].children
		myX = getCurrentSelection()
		convertToPoly myX[1]
		for j = 2 to myX.count do polyop.attach myX[1] myX[j]
		myX[1].name = myName
		myX[1].parent = undefined
		delete myTemp[i]
	)
	
	
	
)


--------------------------------------------------

select $.children
x1 = getCurrentSelection()
convertToPoly x1[1]
for i = 2 to x1.count do
(
	polyop.attach x1[1] x1[i]
)