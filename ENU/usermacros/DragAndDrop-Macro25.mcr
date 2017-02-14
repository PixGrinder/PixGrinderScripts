macroScript Macro25
	category:"DragAndDrop"
	toolTip:""
(
	(
		clearListener()
		myMod = Vertex_Weld()
		myMod.threshold = 0.0001

		for obj in selection do
		(
			addmodifier obj myMod
			addmodifier obj (Smooth())
			maxOps.CollapseNodeTo obj 1 off
		)

		--for obj in selection do maxOps.CollapseNodeTo obj 1 off
		
	)
)
