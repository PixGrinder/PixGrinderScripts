
---------------------------------------------------------------------

-- PixGrinder Scripts --
-- Attach100.ms --
-- Attach100 --
-- Attaches poly objects by 100--
-- V 0.4 --

---------------------------------------------------------------------



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

