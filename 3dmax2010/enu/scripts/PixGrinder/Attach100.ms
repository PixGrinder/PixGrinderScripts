
---------------------------------------------------------------------

-- PixGrinder Scripts --
-- Attach100.ms --
-- Attach100 --
-- Attaches poly objects by 50 --
-- V 1.3 --
--- Acts only on selected objects --

---------------------------------------------------------------------


-- selection.count


--

(
	clearListener()
	disableSceneRedraw()
	myProg = 0.0
	t1 = localTime
	ObjNb = 150
	thePolys = for obj in selection where superclassof obj == GeometryClass collect obj
	--for obj in thePolys do convertToPoly obj
	if ObjNb > thePolys.count then messageBox ("ObjNb value is too high !") else
	(
		progressStart "Processing..."
		theStep = thePolys.count / ObjNb
		theStart = for i = 1 to (theStep-1) collect thePolys[i]
		for i = 1 to theStart.count do
		(
			
			if (100*(i as float)/theStart.count > (myProg as float)) do
			(
				myProg = myProg+1.0
				progressUpdate myProg
			)
			convertToPoly theStart[i]
			for j = (theStep+1) to (theStep+ObjNb) do polyop.attach theStart[i] thePolys[j]
		)
		
		--for blurf = 2 to (selection.count) do try (polyop.attach selection[1] selection[blurf]) catch ()
		t2 = localTime
		format (t1+"\r"+t2+"\r"+"Objects count : "+(objects.count as string)+"\r")
		progressEnd()
		actionMan.executeAction 0 "40472"  -- MAX Script: MAXScript Listener
		messageBox ("The End !")
	)
	enableSceneRedraw()
)

