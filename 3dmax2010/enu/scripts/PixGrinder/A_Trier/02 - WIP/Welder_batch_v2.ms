(
	clearListener()
	progressStart "Welding Vertex..."
	myProg = 0
	myMod = Vertex_Weld()
	myMod.threshold = 0.0001

	for i = 1 to selection.count do
	(
		obj = selection[i]
		addmodifier obj myMod
		addmodifier obj (Smooth())
		maxOps.CollapseNodeTo obj 1 off
	)

	--for obj in selection do maxOps.CollapseNodeTo obj 1 off
	
)




