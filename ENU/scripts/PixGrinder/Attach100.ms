
---------------------------------------------------------------------

-- PixGrinder Scripts --
-- Attach100.ms --
-- Attach100 --
-- Attaches poly objects by 100--
-- V 0.1 --

---------------------------------------------------------------------



(
	thePolys = for obj in geometry where classof obj == Editable_Poly collect obj
	a = thePolys.count
	while polyop.getNumFaces thePolys[a] > 10000 do a = a-1
	for i =1 to 100 do
	(
		polyop.attach thePolys[a] thePolys[i]
	)

	messagebox ("Name : "+thePolys[a].name+"\rFaces : "+polyop.getNumFaces thePolys[a] as string)

)