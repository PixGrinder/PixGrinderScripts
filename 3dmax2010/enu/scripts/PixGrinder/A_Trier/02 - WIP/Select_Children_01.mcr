macroScript Macro60
	category:"DragAndDrop"
	toolTip:""
(
	pda_ar=#()
	for obj in selection do (
		appendifUnique pda_ar obj
		for i=1 to obj.children.count do (
			appendifUnique pda_ar obj.children[i]
		)
		
	)
	
	select pda_ar
)



