
---------------------------------------------------------------------

-- PixGrinder Scripts --
-- Attach100.ms --
-- Attach100 --
-- Attaches poly objects by 50 --
-- V 1.2 --

---------------------------------------------------------------------


-- geometry.count

(
	clearListener()
	t1 = localTime
	ObjNb = 50
	for obj in geometry do convertToPoly obj
	thePolys = for obj in geometry where classof obj == Editable_Poly collect obj
	if ObjNb > thePolys.count then messageBox ("ObjNb value is too high !") else
	(
		theStep = thePolys.count / ObjNb
		theStart = for i = 1 to (theStep-1) collect thePolys[i]
		for i = 1 to theStart.count do
		(
			thePolys = for obj in geometry where classof obj == Editable_Poly collect obj
			try (for j = (theStep+1) to (theStep+ObjNb) do polyop.attach theStart[i] thePolys[j]) catch ()
		)
		
		--for blurf = 2 to (geometry.count) do try (polyop.attach geometry[1] geometry[blurf]) catch ()
		t2 = localTime
		format (t1+"\r"+t2+"\r"+"Objects count : "+(objects.count as string)+"\r")
		messageBox ("The End !")
	)
)

