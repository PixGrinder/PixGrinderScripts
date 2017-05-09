
---------------------------------------------------------------------

-- PixGrinder Scripts --
-- Attach100.ms --
-- Attach100 --
-- Attaches poly objects by 100--
-- V 0.6 --

---------------------------------------------------------------------

/*

(
	attachNb = 50
	a=1
	while a > 0 do
	(
		thePolys = for obj in geometry where classof obj == Editable_Poly collect obj
		a = thePolys.count
		while (polyop.getNumFaces thePolys[a] > 10000) do a = a-1
		print (a as string)
		if a < 1 then exit -- with messagebox ("Scene processed !")
		for i =1 to attachNb do
		(
			try (polyop.attach thePolys[a] thePolys[i]) catch ()
		)
	)

	messagebox ("Scene processed !")
)



(
	attachNb = 50
	theStep = 1
	thePolys = for obj in geometry where classof obj == Editable_Poly collect obj
	myTimes = thePolys.count / attachNb

	for i = 1 to (myTimes-1) do
	(
		for j = 1 to attachNb do
		(
			print theStep as string
			try (polyop.attach thePolys[theStep] thePolys[theStep+j]) catch ()
			theStep = theStep + attachNb
		)
	)
)
objects.count

*/


(
	thePolys = for obj in geometry where classof obj == Editable_Poly collect obj
	theStart = for i = 1 to 50 collect thePolys[i]


	for i = 1 to theStart.count do
	(
		thePolys = for obj in geometry where classof obj == Editable_Poly collect obj
		try (for j = 51 to 101 do polyop.attach theStart[i] thePolys[j]) catch ()
	)
	messageBox ("The End !")
)