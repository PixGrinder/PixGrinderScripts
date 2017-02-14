-- detect Geometry without UV --

(
	clearListener()
	for bla in geometry where classof bla != Editable_Poly do convertToPoly bla
	x1 = for obj in geometry where (polyop.getMapSupport obj 1) == false collect obj   
	max select none
	select x1
)

