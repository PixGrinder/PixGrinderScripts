
-- pda1 = pickObject() filter:geometry

(
	global mySet = "TEMP"
	global x=1
	global pda1 = #()
	global pda2 = #()
	if SelectionSets[mySet] == undefined then
	(
		SelectionSets[mySet] = #()
	) else
	(
		select SelectionSets[mySet]
		pda2 = getCurrentSelection()
		
	)
	
	max select none
	
	while x != 100 do 
	(
		pda1 =  pickObject()
		if pda1 == undefined then exit
		append pda2 pda1
		SelectionSets[mySet] = pda2
		hide pda1
		x = x+1
	) 
)


