(
	clearListener()
	progressStart "Welding Vertex..."
	myProg = 0
	myMod = Vertex_Weld()
	myMod.threshold = 0.0001
	mySelect = getcurrentselection()

	for i = 1 to mySelect.count do
	(
		
		if (100*(i as float)/mySelect.count > (myProg as float)) do  --then print "youpi" else print ((obj as float)/gem.count) as string
		(
			myProg = myProg+1
			progressUpdate myProg
		)
		
		obj = mySelect[i]
		-- print obj.name
		addmodifier obj myMod
		addmodifier obj (Smooth())
		maxOps.CollapseNodeTo obj 1 off
	)

	--for obj in selection do maxOps.CollapseNodeTo obj 1 off
	progressEnd()
)




