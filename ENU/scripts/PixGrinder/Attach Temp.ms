-- Attach Temp --
(
	myStart = timeStamp()
	clearListener()
	clearSelection()
	fn distSort v1 v2= 
	(
		if v1.center.x > v2.center.x then 1 else -1
	)
	progressStart "Processing..."
	undo off
	(
		myVis = for obj in objects where obj.isHidden == false collect obj
		format "% %\r" myVis.count "visible objects"
		qsort myVis distSort

		if myVis.count < 101 then messagebox("Not enouth visible objects !") else 
		(

			myCompt = 2

			while myCompt < 100 do 
			(
				if polyop.getNumFaces myVis[1] + polyop.getNumFaces myVis[myCompt] < 65536 then	
				(
					polyop.attach myVis[1] myVis[myCompt]
					myCompt = myCompt+1
				) else (
					myCompt = 30000
					myVis[1].isHidden = true
				)

			)
			--select myVis[1]
			format "% %\r" (polyop.getNumFaces myVis[1]) "Faces in current Attached Object"
			if polyop.getNumFaces myVis[1] > 64000 do myVis[1].isHidden = true
		)
	)
	myEnd = timeStamp()
	print (((myEnd-myStart)/1000.0) as string +" sec")
	progressEnd()
)


