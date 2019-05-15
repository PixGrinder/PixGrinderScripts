-- Attach Temp --
(
	myStart = timeStamp()
	clearListener()
	clearSelection()
	disableSceneRedraw()
	fn distSort v1 v2= 
	(
		if v1.center.x > v2.center.x then 1 else -1
	)
	progressStart "Processing..."
	undo off
	(
		myVis = for obj in objects where obj.isHidden == false collect obj
		while myVis.count  > 100 do
		(
			myVis = for obj in objects where obj.isHidden == false collect obj
			-- format "% %\r" myVis.count "visible objects"
			qsort myVis distSort
			myCompt = 2
			while polyop.getNumFaces myVis[1] + polyop.getNumFaces myVis[myCompt] < 65536 do
			(
				polyop.attach myVis[1] myVis[myCompt]
				myCompt = myCompt+1
			)
			myVis[1].isHidden = true
		)
	)
	-- format "% %\r" (polyop.getNumFaces myVis[1]) "Faces in current Attached Object"
	myEnd = timeStamp()
	progressEnd()
	enableSceneRedraw()
	print (((myEnd-myStart)/1000.0) as string +" sec")
)


