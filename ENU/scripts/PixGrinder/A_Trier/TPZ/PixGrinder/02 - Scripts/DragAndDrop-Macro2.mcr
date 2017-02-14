macroScript Macro2
	category:"DragAndDrop"
	toolTip:""
(
	(
		global mySet = "lift_up"
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
		
		while x != 100 do 
		(
			pda1 =  pickObject()
			append pda2 pda1
			SelectionSets[mySet] = pda2
			hide pda1
			x = x+1
		) 
	)
)
